Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907C359A6C
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777507054; cv=none; b=MOxr54+6OfA7hssbohHknzqAbjbZqJluJ/WGB0ODRYELiR4Rm/LcOU/reXwlmhGyoYJl3AsEQbkmx+FDfm40xsSJ7ePW6DzhzVAnesaxnPifzlJccUa69+WZdOES1L+7LWdUhqcq3/gDUIX0Y3a0d/+baBsMoMLLZLjWydXDbO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777507054; c=relaxed/simple;
	bh=3DOPIjlDEPHs1RvXSpOfs7tN35qpUrezxPdh+YGQysE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V3gBCPgA9vC+IGDCcdd0bnmxcUYMrzHOE3oGL5XQ9yCPFyVbEuTx3g7dAigQ1VeAYz8ODXOpHVSoHtGezwZzKdk9VUZC71Bb/+bIRW0X3bUD2leDLfFEjXa2IytK4WhTI/Zld/aa8xm0nn2J3tPDiwHklKq35kluphh2GAu91VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDHI9yt9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDHI9yt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65395C19425;
	Wed, 29 Apr 2026 23:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777507054;
	bh=3DOPIjlDEPHs1RvXSpOfs7tN35qpUrezxPdh+YGQysE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CDHI9yt9iybBv8XvKio9Wn9irm2hW+Sr3ZAE94wcPgFTD/ZEP5LG19UYJLIaSoPcD
	 y3sauOG7zK3bTBV/ifjqrq3hLxtfEgciCB5wisft9k0yFsX0BXwSHw4LANIubMkcz2
	 /o1KOaq5VdGvaTw9tD2FOZzcub671BmB+xA6jNMl4X0wveyrHNZ1c264VaoXQlmXev
	 zWRtANfVgRHvHOIXHOU5A/rlH1K7VTEvz4BzvaOoabgL3xwNfZc5kfYrD4DHF7ZYnd
	 97zN2Qeru48OJsZtWLnPD8NZRn24lv7t5Nj0XOd5qqxviLGUqIgb0c32uIvXowYy+x
	 QOutuJsV28nWw==
From: sashiko-bot@kernel.org
Subject: Re: [v6 09/10] selftests/hornet: Add a selftest for the Hornet LSM
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429191431.2345448-10-bboscaccy@linux.microsoft.com>
References: <20260429191431.2345448-10-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 23:57:33 +0000
Message-Id: <20260429235734.65395C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] Makefile targets lack `$(OUTPUT)/` prefix, breaking out-of-tree =
builds.
- [Medium] Makefile hardcodes host architecture and kernel paths, breaking =
cross-compilation.
- [Medium] Makefile has an unconditional build dependency on kernel cryptog=
raphic signing keys.
- [Medium] BPF program uses `bpf_probe_read_str()` for a user-space pointer.
- [Medium] BPF program uses `BPF_CORE_READ()` to access tracepoint context =
fields.
--

commit 1e13c1e9492cd70a4a039a9763aae8236928bf0c
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
selftests/hornet: Add a selftest for the Hornet LSM

This selftest contains a testcase that utilizes light skeleton eBPF
loaders and exercises hornet's map validation.

> diff --git a/tools/testing/selftests/hornet/Makefile b/tools/testing/self=
tests/hornet/Makefile
> new file mode 100644
> index 000000000000..432bce59f54e
> --- /dev/null
> +++ b/tools/testing/selftests/hornet/Makefile
[ ... ]
> +BPF_CFLAGS :=3D -target bpf \
> +	-D__TARGET_ARCH_$(ARCH) \
> +	-I/usr/include/$(shell uname -m)-linux-gnu \

Does this hardcoded include path break cross-compilation? If building for
arm64 on an x86 host, it looks like this will pull in x86 headers instead
of the target architecture headers.

> +	$(KHDR_INCLUDES)
> +
> +vmlinux.h:
> +	$(BPFTOOL) btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h

Does this hardcode the host kernel's BTF? This will fail in build
environments where the host kernel lacks BTF, or when cross-compiling
where the target kernel's built BTF ($(objtree)/vmlinux) should be used.

Also, shouldn't custom build rules like this use the $(OUTPUT)/ prefix?
Since this Makefile includes ../lib.mk, items in TEST_GEN_PROGS and
TEST_GEN_FILES are prefixed with $(OUTPUT)/. When building out-of-tree
(make O=3Ddir), make might fail to match the expected $(OUTPUT)/ targets
for vmlinux.h, trivial.bpf.o, loader.h, and the other explicit rules.

> +
> +trivial.bpf.o: trivial.bpf.c vmlinux.h
> +	$(CLANG) $(CFLAGS) $(BPF_CFLAGS) -c $< -o $@
> +
> +loader.h: trivial.bpf.o
> +	$(BPFTOOL) gen skeleton -S -k $(CERTDIR)/signing_key.pem -i $(CERTDIR)/=
signing_key.x509 \

Does this create an unconditional dependency on kernel cryptographic signing
keys? If the target kernel configuration disables module signing or other
features that generate these specific keys, the files won't exist and the
build might fail unconditionally instead of gracefully skipping.

> +		-L $< name trivial > $@
[ ... ]
> diff --git a/tools/testing/selftests/hornet/trivial.bpf.c b/tools/testing=
/selftests/hornet/trivial.bpf.c
> new file mode 100644
> index 000000000000..d38c5b53ff93
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

Should tracepoint arguments be accessed directly (e.g., ctx->args[1])
instead of using BPF_CORE_READ()?=20

Passing the verifier-translated tracepoint context pointer (PTR_TO_CTX)
to memory-reading helpers (which BPF_CORE_READ expands to) is an
anti-pattern that defeats direct memory access optimizations and can
lead to verifier rejection.

> +
> +	bpf_probe_read_str(filename, sizeof(filename), pathname_ptr);

Will this fail to read the user-space pointer? On architectures with strict
user/kernel memory separation (like x86 with SMAP), bpf_probe_read_str()
cannot read user memory. Would bpf_probe_read_user_str() be more
appropriate here?

> +	task =3D (struct task_struct *)bpf_get_current_task();
> +	start_time =3D BPF_CORE_READ(task, start_time);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429191431.2345=
448-1-bboscaccy@linux.microsoft.com?part=3D9
