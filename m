Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEF6363C45
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 03:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740698; cv=none; b=CyKTa5KfSMRN7Wy3LCK00DkpfNXIlE5gTviLhSiuu6EA6dxgAe4jqTpW0R3yWbD2h6RAk2cUg4jO7rX3sMXrm6wuUV5U+FLhbIwQlb1hY7D2sHcjLoheXy+M9fVWGi6ahCKZkexk8W/HT+gX+4FQS/BDIVReA9O0QG+HXYnO/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740698; c=relaxed/simple;
	bh=AfFUUR3UpSbNCjRjoXy1WRjALk61jW8gfIBkSQ9vcNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iI8bssGhHRycUc6Ldq+YKsP1TeZ8tEn2BiJ1G+rqmo2sF+usj5tPjMw5Lv2yEHBmg77IYyvls2en/pDOEqCPfWtsec5Y1oOaDzMZLoXvBErxOUzXdy8nZFXlS7aRhdEadRQTl5+PZfqqXyVj3at7S/fGNq/870cgRIKkOHwzgcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEVMol0H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEVMol0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C77C19425;
	Tue, 21 Apr 2026 03:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776740697;
	bh=AfFUUR3UpSbNCjRjoXy1WRjALk61jW8gfIBkSQ9vcNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gEVMol0HpD+RO8QZcQlRVNOqrtvH2/+PIOhy14EI2cHX/DEgX7WIC00IWJmQspq87
	 VjX8hbpKav8KbWKuixHmVUIMYFXPAY11EGgUsBkdWWmAjLtLfJKUuyvBT1cf6xslEP
	 L2A9q+W11lmdIVb+M9lnNFql4ClSIpCXqq3Xw7udFgq3o4aS+R6J+en2vXWM2jdn/Y
	 0dSgqnzl6upPfL+6wAdwIc6ycucvV7oWNkYay6FCNb/GWEc0wItkljVT4MtL1Lr+Vh
	 nSNrlme/ew1IwZVbflN947pxwjnyukJ0sXt0Ur93mXs6sSNjP1mmNuvj6s5dNZDZjU
	 iQwu3j7B1XSPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/10] selftests/hornet: Add a selftest for the
 Hornet LSM
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420212653.438685-10-bboscaccy@linux.microsoft.com>
References: <20260420212653.438685-10-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 03:04:56 +0000
Message-Id: <20260421030457.74C77C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 7 potential issue(s):
- [High] Use of deprecated `bpf_probe_read_str` to read a user-space pointe=
r.
- [High] Hardcoded dependency on the host's `/sys/kernel/btf/vmlinux`.
- [High] Custom Makefile rules are bypassed due to `$(OUTPUT)/` prefix mism=
atch.
- [High] Linking against the host system's `libbpf` instead of the in-tree =
library.
- [High] Unconditional hardcoded dependency on kernel signing keys.
- [Medium] The selftest fails to verify Hornet's negative enforcement capab=
ilities.
- [Medium] BPF selftest `loader.c` uses raw conditionals instead of `ASSERT=
_*()` macros.
--

commit 162ecc15ea5091af09f42092fc7aa704f31709fa
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

selftests/hornet: Add a selftest for the Hornet LSM
   =20
This selftest contains a testcase that utilizes light skeleton eBPF
loaders and exercises hornet's map validation.

> diff --git a/tools/testing/selftests/hornet/Makefile b/tools/testing/self=
tests/hornet/Makefile
> new file mode 100644
> index 0000000000000..432bce59f54e7
> --- /dev/null
> +++ b/tools/testing/selftests/hornet/Makefile

[ ... ]

> +TEST_GEN_PROGS :=3D loader
> +TEST_GEN_FILES :=3D vmlinux.h loader.h trivial.bpf.o map.bin sig.bin ins=
n.bin signed_loader.h
> +$(TEST_GEN_PROGS): LDLIBS +=3D -lbpf

Could this link against the host operating system's libbpf.so instead of the
locally built in-tree library?

It looks like it lacks the -L$(BPFDIR) library search path. If the host
machine doesn't have libbpf-dev installed, the build might fail, or it could
link against an outdated version.

[ ... ]

> +vmlinux.h:
> +	$(BPFTOOL) btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h

Does this hardcode a dependency on the host's running kernel instead of the
target kernel being compiled?

This would break cross-compilation and fail the build entirely on host
machines without CONFIG_DEBUG_INFO_BTF enabled in their running kernel.
Should it use the in-tree $(VMLINUX_BTF) provided by the build infrastructu=
re?

[ ... ]

> +sig.bin: insn.bin map.bin $(OUTPUT)/gen_sig
> +	$(OUTPUT)/gen_sig --key $(CERTDIR)/signing_key.pem --cert $(CERTDIR)/si=
gning_key.x509 \
> +		--data insn.bin --add map.bin:0 --out sig.bin

Will this unconditionally fail if the kernel configuration lacks
CONFIG_MODULE_SIG?

The Makefile hardcodes the use of signing_key.pem and signing_key.x509, whi=
ch
might not exist. Should the test gracefully detect the absence of the requi=
red
keys and skip the build or execution instead of failing the entire pipeline?

> +
> +signed_loader.h: sig.bin
> +	$(SCRIPTSDIR)/write-sig.sh loader.h sig.bin > $@
> +
> +loader: loader.c signed_loader.h
> +	$(CC) $(CFLAGS) -I$(LIBDIR) -I$(APIDIR) $< -o $@ -lbpf

Could this custom rule be bypassed because it lacks the $(OUTPUT)/ prefix?

The include ../lib.mk transforms TEST_GEN_PROGS by prefixing it with
$(OUTPUT)/. When make attempts to build $(OUTPUT)/loader, it might fall back
to its default pattern rule.

This would omit the -I include paths, the -lbpf linker flag, and the
dependency on signed_loader.h, leading to compilation failures.

Also, similar to the LDLIBS addition above, this uses -lbpf without specify=
ing
the in-tree path.

> diff --git a/tools/testing/selftests/hornet/loader.c b/tools/testing/self=
tests/hornet/loader.c
> new file mode 100644
> index 0000000000000..f27580c7262b3
> --- /dev/null
> +++ b/tools/testing/selftests/hornet/loader.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stddef.h>
> +#include <sys/resource.h>
> +#include <bpf/libbpf.h>
> +#include <errno.h>
> +#include  "signed_loader.h"
> +
> +int main(int argc, char **argv)
> +{
> +	struct trivial *skel;
> +
> +	skel =3D trivial__open_and_load();

The commit message states this "exercises hornet's map validation", but this
solely loads a valid, signed skeleton.

Are there any negative tests to verify that the LSM actually blocks invalid
loads? If the Hornet LSM fails open or is disabled, this test might falsely
pass.

> +	if (!skel)
> +		return -1;

Should this use the modern ASSERT_*() macros like ASSERT_OK_PTR() instead of
raw conditionals?

Using raw conditionals silently bypasses the standard testing reporting
infrastructure.

> +
> +	trivial__destroy(skel);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/hornet/trivial.bpf.c b/tools/testing=
/selftests/hornet/trivial.bpf.c
> new file mode 100644
> index 0000000000000..d38c5b53ff932
> --- /dev/null
> +++ b/tools/testing/selftests/hornet/trivial.bpf.c

[ ... ]

> +SEC("tracepoint/syscalls/sys_enter_unlinkat")
> +int handle_enter_unlink(struct trace_event_raw_sys_enter *ctx)
> +{
> +	char filename[128] =3D { 0 };
> +	struct task_struct *task;
> +	unsigned long start_time =3D 0;
> +	int pid =3D bpf_get_current_pid_tgid() >> 32;
> +	char *pathname_ptr =3D (char *) BPF_CORE_READ(ctx, args[1]);
> +
> +	bpf_probe_read_str(filename, sizeof(filename), pathname_ptr);

Can this silently fail on architectures with strict user/kernel address spa=
ce
separation (like x86 with SMAP enabled)?

The sys_enter_unlinkat tracepoint receives pathname from user space in
args[1], but bpf_probe_read_str() is deprecated and meant for kernel-space
pointers. Should this use bpf_probe_read_user_str() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420212653.4386=
85-1-bboscaccy@linux.microsoft.com?part=3D9
