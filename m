Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D67D081
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630278; cv=none; b=hNeZKw1hpi3luNDcX1i16jTTGhB3py1bMofJ2pV0TU5ve0dNg6aKQW5IY8Hy9TZF4sUT0Lr1p1Nw/nvRMocMi5qWRWHmeg3bMX1GbqGAg+/FaykByORorxTiz+F29sefe3heE+JshaqR+6jktAgzGW42gXrKbvLYPYAP3gy7wn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630278; c=relaxed/simple;
	bh=izYN5Fka+442b0SI0O1anwz7wF5N3skaqgGrc9Y3kiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXmtXLck4fRuJe8wdncV+sq4AJe1GZK4RzwLrcsmbX99AYhaavG7WsqXTUN0kvKGY2trZv3gpWkU+HmIhGDaB0HuDNcq51OgQydNtWMdVzxeiUVZ2DlhWTTTu70Bkwcy20cxlCBi2V24Hwipk/Cqike04i+dpsKyWGy2OJ4qZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V53Lc385kz4f3mHZ
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 20:51:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 99B3F1A0172
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 20:51:12 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgDnOm29ZwVmwX7vIQ--.18322S2;
	Thu, 28 Mar 2024 20:51:10 +0800 (CST)
Message-ID: <3236d084-fbc3-4e25-a2e8-ccc6cffe1437@huaweicloud.com>
Date: Thu, 28 Mar 2024 20:51:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Enable cross platform testing
 for local vmtest
Content-Language: en-US
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Pu Lehui <pulehui@huawei.com>
References: <20240326155736.3480081-1-pulehui@huaweicloud.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20240326155736.3480081-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDnOm29ZwVmwX7vIQ--.18322S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyrXF17Xr4xtrW5Xr4xJFb_yoWrKw48pw
	48Zr4aka4rWF1Sgrn7Za109FWfJr4vvrW7CryUX345Zw17tr97Ar92yFWjqrnxW3s5ur43
	ZasagF90kw18Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIccxYrVCFb41lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUgCztUU
	UUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

Gather this to riscv64 patchset [0] for better regression:

Link: 
https://lore.kernel.org/bpf/20240328124916.293173-1-pulehui@huaweicloud.com/ 
[0]

On 2024/3/26 23:57, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> The variable $ARCH in the current script is platform semantics, not
> kernel semantics. Rename it to $PLATFORM so that we can easily use $ARCH
> in cross-compilation. For now, Using PLATFORM= and CROSS_COMPILE=
> options will enable cross platform testing:
> 
>    PLATFORM=<platform> CROSS_COMPILE=<toolchain> vmtest.sh -- ./test_progs
> 
> Meanwhile, some descriptions have been corrected.
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
> v2:
> - Specifies the -cpu for the ARM64.
> - Completely renamed ARCH to PLATFORM.
> 
>   tools/testing/selftests/bpf/vmtest.sh | 40 +++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> index 65d14f3bbe30..825149a905e5 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -4,28 +4,34 @@
>   set -u
>   set -e
>   
> -# This script currently only works for x86_64 and s390x, as
> -# it is based on the VM image used by the BPF CI, which is
> +# This script currently only works for the following platforms,
> +# as it is based on the VM image used by the BPF CI, which is
>   # available only for these architectures.
> -ARCH="$(uname -m)"
> -case "${ARCH}" in
> +PLATFORM="${PLATFORM:-$(uname -m)}"
> +case "${PLATFORM}" in
>   s390x)
>   	QEMU_BINARY=qemu-system-s390x
>   	QEMU_CONSOLE="ttyS1"
> -	QEMU_FLAGS=(-smp 2)
> +	HOST_FLAGS=(-smp 2 -enable-kvm)
> +	CROSS_FLAGS=(-smp 2)
>   	BZIMAGE="arch/s390/boot/vmlinux"
> +	ARCH="s390"
>   	;;
>   x86_64)
>   	QEMU_BINARY=qemu-system-x86_64
>   	QEMU_CONSOLE="ttyS0,115200"
> -	QEMU_FLAGS=(-cpu host -smp 8)
> +	HOST_FLAGS=(-cpu host -enable-kvm -smp 8)
> +	CROSS_FLAGS=(-smp 8)
>   	BZIMAGE="arch/x86/boot/bzImage"
> +	ARCH="x86"
>   	;;
>   aarch64)
>   	QEMU_BINARY=qemu-system-aarch64
>   	QEMU_CONSOLE="ttyAMA0,115200"
> -	QEMU_FLAGS=(-M virt,gic-version=3 -cpu host -smp 8)
> +	HOST_FLAGS=(-M virt,gic-version=3 -cpu host -enable-kvm -smp 8)
> +	CROSS_FLAGS=(-M virt,gic-version=3 -cpu cortex-a76 -smp 8)
>   	BZIMAGE="arch/arm64/boot/Image"
> +	ARCH="arm64"
>   	;;
>   *)
>   	echo "Unsupported architecture"
> @@ -38,7 +44,7 @@ ROOTFS_IMAGE="root.img"
>   OUTPUT_DIR="$HOME/.bpf_selftests"
>   KCONFIG_REL_PATHS=("tools/testing/selftests/bpf/config"
>   	"tools/testing/selftests/bpf/config.vm"
> -	"tools/testing/selftests/bpf/config.${ARCH}")
> +	"tools/testing/selftests/bpf/config.${PLATFORM}")
>   INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/master/INDEX"
>   NUM_COMPILE_JOBS="$(nproc)"
>   LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
> @@ -58,6 +64,10 @@ tools/testing/selftests/bpf. e.g:
>   If no command is specified and a debug shell (-s) is not requested,
>   "${DEFAULT_COMMAND}" will be run by default.
>   
> +Using PLATFORM= and CROSS_COMPILE= options will enable cross platform testing:
> +
> +  PLATFORM=<platform> CROSS_COMPILE=<toolchain> $0 -- ./test_progs -t test_lsm
> +
>   If you build your kernel using KBUILD_OUTPUT= or O= options, these
>   can be passed as environment variables to the script:
>   
> @@ -109,7 +119,7 @@ newest_rootfs_version()
>   {
>   	{
>   	for file in "${!URLS[@]}"; do
> -		if [[ $file =~ ^"${ARCH}"/libbpf-vmtest-rootfs-(.*)\.tar\.zst$ ]]; then
> +		if [[ $file =~ ^"${PLATFORM}"/libbpf-vmtest-rootfs-(.*)\.tar\.zst$ ]]; then
>   			echo "${BASH_REMATCH[1]}"
>   		fi
>   	done
> @@ -126,7 +136,7 @@ download_rootfs()
>   		exit 1
>   	fi
>   
> -	download "${ARCH}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst" |
> +	download "${PLATFORM}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst" |
>   		zstd -d | sudo tar -C "$dir" -x
>   }
>   
> @@ -244,12 +254,17 @@ EOF
>   		exit 1
>   	fi
>   
> +	if [[ "${CROSS_COMPILE}" != "" ]]; then
> +		QEMU_FLAGS=("${CROSS_FLAGS[@]}")
> +	else
> +		QEMU_FLAGS=("${HOST_FLAGS[@]}")
> +	fi
> +
>   	${QEMU_BINARY} \
>   		-nodefaults \
>   		-display none \
>   		-serial mon:stdio \
>   		"${QEMU_FLAGS[@]}" \
> -		-enable-kvm \
>   		-m 4G \
>   		-drive file="${rootfs_img}",format=raw,index=1,media=disk,if=virtio,cache=none \
>   		-kernel "${kernel_bzimage}" \
> @@ -384,7 +399,8 @@ main()
>   	fi
>   
>   	local kconfig_file="${OUTPUT_DIR}/latest.config"
> -	local make_command="make -j ${NUM_COMPILE_JOBS} KCONFIG_CONFIG=${kconfig_file}"
> +	local make_command="make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} \
> +			    -j ${NUM_COMPILE_JOBS} KCONFIG_CONFIG=${kconfig_file}"
>   
>   	# Figure out where the kernel is being built.
>   	# O takes precedence over KBUILD_OUTPUT.

