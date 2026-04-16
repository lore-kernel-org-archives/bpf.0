Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61124A044
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776376554; cv=none; b=Z3VG1RgnDLFl4emOrFr30tOBSczdTZxkf4lDQoXrQGCP0zYLRZWoq4Ihi/1uEZosuWMdeQxEAPRnPZVZknzDdqM7b+z2nIT8mfDiUdJC+xTQ0QSZshRIptkWeQ0/wA68CF2aWsVfDT/r7w+hlRAQlo6Tcgk+6qEqm2/kT9mK9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776376554; c=relaxed/simple;
	bh=vy65xpd69qZg5lRrLPr1sFVtigh4kw6gpNB98qUYPpQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RxcPJGG1Bv/+WEtamSQy9uan0PmpTEtI6FmMAuOekqcKnUE3ugw32rWqY/vc+9kG/jJf88pNYpqG+oS3jDv5GDW1D0ufQOBvu0YlViYBW1TyYZwmCPf3NKXp3FDcTagvRVXBoKm2lmWR7fJAM1IrMKAl0Yu7a54IuN9IEZaxYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1MhFiAo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1MhFiAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D28C2BCAF;
	Thu, 16 Apr 2026 21:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776376554;
	bh=vy65xpd69qZg5lRrLPr1sFVtigh4kw6gpNB98qUYPpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=O1MhFiAo9KTivzYJBf/UuMttqZWqCPbthIGXC91Z7tlwQedCzmKKdX6VX+C9FuYOX
	 t7CGRx7+mIpyLHgK59M3gueY/gYHQKaEQnp6REQ15HibPqANlmEUGK+GdCteK7mja5
	 0SeULbuMu5YuY8+/9Fo75k34U0TmoyJvA6XyoXia4E2g5lrEqXnvxu2c65nOD/SPdb
	 oGyJFlHgYR+zbeJkpR9FMaeJq3eYFH90/H4ps1YxEFW5DX0T9lP5BnPtFPjM4SluKH
	 7FCPPmbwL7V3E9At5jxT12RQpL+5ndTsXgGS8cdD5Yx+rpaGMr4s5c4GU+yx4nau37
	 5EbwOoFVbdRwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] selftests/hornet: Add a selftest for the
 Hornet LSM
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416173500.176716-10-bboscaccy@linux.microsoft.com>
References: <20260416173500.176716-10-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 21:55:53 +0000
Message-Id: <20260416215554.65D28C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Medium] Makefile targets lack the `$(OUTPUT)/` prefix, breaking out-of-t=
ree and standard selftest builds.
- [Medium] Hardcoded use of the host's `/sys/kernel/btf/vmlinux` breaks cro=
ss-compilation.
- [Medium] The host tool `gen_sig` is compiled using the target compiler, b=
reaking cross-compilation.
- [Medium] Unconditional build dependency on kernel module signing keys.
- [Medium] Incorrect use of `bpf_probe_read_str()` to read user-space memor=
y.
--

commit d3ed81de44873be8726bc1bb9c61643050622647
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

selftests/hornet: Add a selftest for the Hornet LSM

This commit adds a new selftest for the Hornet LSM. It contains a testcase
that utilizes light skeleton eBPF loaders and exercises hornet's map
validation.

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
> +$(TEST_GEN_PROGS): $(TEST_GEN_FILES)
> +
> +include ../lib.mk
> +
> +BPF_CFLAGS :=3D -target bpf \
> +	-D__TARGET_ARCH_$(ARCH) \
> +	-I/usr/include/$(shell uname -m)-linux-gnu \
> +	$(KHDR_INCLUDES)
> +
> +vmlinux.h:

Since ../lib.mk prepends $(OUTPUT)/ to all entries in TEST_GEN_FILES and
TEST_GEN_PROGS, will the generic build infrastructure look for targets like
$(OUTPUT)/vmlinux.h and fall back to default implicit rules because the
custom targets lack the $(OUTPUT)/ prefix?

> +	$(BPFTOOL) btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h

Does this extract the BTF from the host machine's running kernel instead
of the target kernel? On cross-compiled builds, could this generate
mismatched architecture types?

> +
> +trivial.bpf.o: trivial.bpf.c vmlinux.h
> +	$(CLANG) $(CFLAGS) $(BPF_CFLAGS) -c $< -o $@
> +
> +loader.h: trivial.bpf.o
> +	$(BPFTOOL) gen skeleton -S -k $(CERTDIR)/signing_key.pem -i $(CERTDIR)/=
signing_key.x509 \

Does this create an unconditional build dependency on the kernel module
signing keys?

If the target kernel is configured without module signing, or the selftests
are built on a clean source tree before the keys are generated, will this
cause the build to fail?

> +		-L $< name trivial > $@
> +
> +insn.bin: loader.h
> +	$(SCRIPTSDIR)/extract-insn.sh $< > $@
> +
> +map.bin: loader.h
> +	$(SCRIPTSDIR)/extract-map.sh $< > $@
> +
> +$(OUTPUT)/gen_sig: ../../../../scripts/hornet/gen_sig.c
> +	$(call msg,GEN_SIG,,$@)
> +	$(Q)$(CC) $(shell $(PKG_CONFIG) --cflags libcrypto 2> /dev/null) \
> +		  $< -o $@ \
> +		  $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
> +
> +sig.bin: insn.bin map.bin $(OUTPUT)/gen_sig
> +	$(OUTPUT)/gen_sig --key $(CERTDIR)/signing_key.pem --cert $(CERTDIR)/si=
gning_key.x509 \

Since gen_sig is executed locally on the host to generate sig.bin, will
compiling it with $(CC) and $(PKG_CONFIG) (which point to the target
toolchain) cause an Exec format error during cross-compilation?

Should it be compiled using $(HOSTCC) and host pkg-config instead?

[ ... ]

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

Since pathname_ptr is extracted from args[1] of the sys_enter_unlinkat
tracepoint, isn't it a user-space pointer?

On architectures with strict user and kernel address space separation, does
bpf_probe_read_str() fail to read this memory?

Should this use bpf_probe_read_user_str() instead?

> +	task =3D (struct task_struct *)bpf_get_current_task();
> +	start_time =3D BPF_CORE_READ(task, start_time);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416173500.1767=
16-1-bboscaccy@linux.microsoft.com?part=3D9
