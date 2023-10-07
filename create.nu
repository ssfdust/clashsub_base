def createpod [] {
    if (podman pod exists clashsub | complete).exit_code == 1 {
        echo "Create clashsub pod"
        # podman pod create -p 18080:80 -p 25500:25500 clashsub
        podman pod create -p 25500:25500 clashsub
    } else {
        echo "clashsub pod exists."
    }
}

def pullimage [image: string] {
    let image_row = (podman images | detect columns | find $image)
    if ($image_row | length) > 0 {
        echo "Image $image exists."
    } else {
        echo $"Pull ($image) from remote."
        podman pull $image
    }
}


def customconv [orig: string, new: string, tag: string] {
    let image_row = (podman images | detect columns | find $new | find $tag)
    if ($image_row | length) > 0 {
        echo "Image is ready."
    } else {
        let subconverter = (buildah from $orig)
        buildah copy $subconverter all_base.tpl /base/base/all_base.tpl
        buildah commit $subconverter $"($new):($tag)"
        buildah rm $subconverter
    }
}

pullimage docker.io/tindy2013/subconverter
createpod
customconv docker.io/tindy2013/subconverter docker.io/ssfdust/subconverter ssfdust
podman run --name subconverter --pod clashsub -d docker.io/ssfdust/subconverter:ssfdust
