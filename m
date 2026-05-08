Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7B25A357
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209119; cv=none; b=fx4+0ILLrM/ro++wbsTSASjFxMjpEd0ofxd3TYpzTtcqkAvMsb0dCLgfM4kabaPZcvQpHU/bUgubDBV53Ef3aICCBrTADY62aGCsO8MVbGqkfhYIejk3WuOChxC0hoywwhvt7f4KJGUIr9+cg/ohlGuz6Y0HKdHhyu8NfnrnNjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209119; c=relaxed/simple;
	bh=xrPMuU9pY6iGmlXwlLZyuR0uERw7lJPL4QUoje/puDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qT1VvLZtVjxeD0AYn7VLZ9x/Hgctmc4LvRM0s9NfwRKJO62LOsc5YqQPWNRWpmeJKXbLuPGvaU5BnJy69ZvLvBJQC2LbE9aJQ+KnWjE+tDnZ4nS6Bc/rMevchDzLQ2ALHCA8WxgXuc5R62jiYFyW7NDGwEU4N2TNfdC6Jlmsvdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPcgN5Iq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPcgN5Iq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFF3C2BCB2;
	Fri,  8 May 2026 02:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778209118;
	bh=xrPMuU9pY6iGmlXwlLZyuR0uERw7lJPL4QUoje/puDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IPcgN5Iqe0nfmLPtMFFWeYy8wniRpzIVZ/o+JA6XKtkfsx7B0IQfaKP6a1i6H8FqI
	 4HeliqbUQ/HvqKQJiYgx16A36ZN/tA9DqESlBrxOll8iZxTU33+r4X4NuUcFsHWBmB
	 Tvct1IISIvD7ZcvI+UTmcV+9+R9DOxHt+NeV3ohayJ1kTaMr2ljIBbGsDVaSuNcpy8
	 J3MeVh8/SYYnZ/aEAYTd8uYHlN+rSCI+LTlb96NhwAs6bYNhGdGtAHmn/lHpzCWIoY
	 WQOc5PC5oOr0SAh4a7i3cvQo07eXiDnnk0N0uKl29fotCy4CsfBypFF1TkxL25WXuw
	 gvvKFnuyJvWaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/10] selftests/hornet: Add a selftest for the
 Hornet LSM
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507191416.2984054-10-bboscaccy@linux.microsoft.com>
References: <20260507191416.2984054-10-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 02:58:35 +0000
Message-Id: <20260508025838.7EFF3C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Cross-compilation breakage due to `gen_sig` built with target comp=
iler but executed on the host.
- [High] Cross-compilation breakage due to hardcoded host paths for `vmlinu=
x.h` and includes.
- [High] Incorrect helper used to read user-space memory in the BPF program.
- [High] Makefile custom targets lack `$(OUTPUT)/` prefix, breaking out-of-=
tree builds.
- [High] Unconditional dependency on kernel signing keys breaks the global =
selftests build.
- [Medium] Selftest links against the system's `libbpf` instead of the loca=
lly built in-tree version.
- [Medium] Violation of the BPF selftest macro guidelines.
--

commit 7071c10449f31b01df208a3d3f4cf023f39c5b06
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

selftests/hornet: Add a selftest for the Hornet LSM

This selftest contains a testcase that utilizes light skeleton eBPF
loaders and exercises hornet's map validation.

> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index 450f13ba4cca9..4e2d1cd88c825 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
[ ... ]
> @@ -44,6 +44,7 @@ TARGETS +=3D ftrace
>  TARGETS +=3D futex
>  TARGETS +=3D gpio
>  TARGETS +=3D hid
> +TARGETS +=3D hornet

Will this break the global selftests build if module signing keys haven't
been generated? The hornet Makefile seems to unconditionally depend on
$(CERTDIR)/signing_key.pem, which might not exist in all build environments.

>  TARGETS +=3D intel_pstate
>  TARGETS +=3D iommu
>  TARGETS +=3D ipc

> diff --git a/tools/testing/selftests/hornet/Makefile b/tools/testing/self=
tests/hornet/Makefile
> new file mode 100644
> index 0000000000000..432bce59f54e7
> --- /dev/null
> +++ b/tools/testing/selftests/hornet/Makefile
[ ... ]
> +BPF_CFLAGS :=3D -target bpf \
> +	-D__TARGET_ARCH_$(ARCH) \
> +	-I/usr/include/$(shell uname -m)-linux-gnu \
> +	$(KHDR_INCLUDES)

Is it intentional to use $(shell uname -m) here?

When cross-compiling, this will yield the host architecture instead of the
target architecture, which might include the wrong host structures.

> +
> +vmlinux.h:
> +	$(BPFTOOL) btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h

Does this read the host kernel's BTF instead of the target kernel's BTF?
If cross-compiling, /sys/kernel/btf/vmlinux is the host machine's BTF.

Also, are these targets missing the $(OUTPUT)/ prefix? The Makefile includes
../lib.mk which automatically prepends $(OUTPUT)/ to TEST_GEN_FILES and
TEST_GEN_PROGS.

When building out-of-tree with O=3D..., make might fail to find the rules f=
or
these targets without the $(OUTPUT)/ prefix.

> +
> +trivial.bpf.o: trivial.bpf.c vmlinux.h
> +	$(CLANG) $(CFLAGS) $(BPF_CFLAGS) -c $< -o $@
> +
> +loader.h: trivial.bpf.o
> +	$(BPFTOOL) gen skeleton -S -k $(CERTDIR)/signing_key.pem -i $(CERTDIR)/=
signing_key.x509 \
> +		-L $< name trivial > $@
[ ... ]
> +$(OUTPUT)/gen_sig: ../../../../scripts/hornet/gen_sig.c
> +	$(call msg,GEN_SIG,,$@)
> +	$(Q)$(CC) $(shell $(PKG_CONFIG) --cflags libcrypto 2> /dev/null) \
> +		  $< -o $@ \
> +		  $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
> +
> +sig.bin: insn.bin map.bin $(OUTPUT)/gen_sig
> +	$(OUTPUT)/gen_sig --key $(CERTDIR)/signing_key.pem --cert $(CERTDIR)/si=
gning_key.x509 \
> +		--data insn.bin --add map.bin:0 --out sig.bin

Since $(OUTPUT)/gen_sig is executed during the build process to generate
sig.bin, shouldn't it be built with $(HOSTCC) instead of the target $(CC)?

During cross-compilation, building it with the target compiler and running
it on the host could result in an 'Exec format error'.

> +
> +signed_loader.h: sig.bin
> +	$(SCRIPTSDIR)/write-sig.sh loader.h sig.bin > $@
> +
> +loader: loader.c signed_loader.h
> +	$(CC) $(CFLAGS) -I$(LIBDIR) -I$(APIDIR) $< -o $@ -lbpf

Does this link against the system's dynamic libbpf.so instead of the locally
built in-tree version?

Typically, kernel selftests statically link against the in-tree libbpf.a to
test the current kernel's library and avoid build failures on systems missi=
ng
the package.

> +
> +
> +EXTRA_CLEAN =3D $(OUTPUT)/gen_sig
> diff --git a/tools/testing/selftests/hornet/loader.c b/tools/testing/self=
tests/hornet/loader.c
> new file mode 100644
> index 0000000000000..f27580c7262b3
> --- /dev/null
> +++ b/tools/testing/selftests/hornet/loader.c
[ ... ]
> +int main(int argc, char **argv)
> +{
> +	struct trivial *skel;
> +
> +	skel =3D trivial__open_and_load();
> +	if (!skel)
> +		return -1;

Should this use the BPF testing framework and modern ASSERT_*() macros like
ASSERT_OK_PTR() to provide structured TAP output?

New BPF tests are expected to follow this standard.

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

Because args[1] of sys_enter_unlinkat is a user-space pointer to the pathna=
me,
does this need to use bpf_probe_read_user_str() instead of
bpf_probe_read_str()?

On architectures with strict boundary protections or split address spaces,
reading user-space memory with bpf_probe_read_str() could fail or read
garbage.

> +	task =3D (struct task_struct *)bpf_get_current_task();
> +	start_time =3D BPF_CORE_READ(task, start_time);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507191416.2984=
054-1-bboscaccy@linux.microsoft.com?part=3D9
