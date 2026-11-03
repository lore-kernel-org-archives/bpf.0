Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699809;
	b=y2qtyvEHRM9GLIw5Hxj2HOXpMQdopmJwh7isFIxESDvxqucQ5FUNyVKa0Ya7J7ThuQjb
	 dB25U3imvccVj3LduHQznPplyyWRtFcgllqJAwDBuGpKQy1g5FkLXbOwZIO94HaK7sb5S
	 2TPcVMID/ufk6VmkP0xrdmUUcIIebPpl+KeiNcjurv46hBl75SA0h1+9QbKIQEUKxcJem
	 RxOHACE5ZubvF/Xlb+B9uXBNRV078a9G5r4HT4culnb3SsR4MCgCY4pUKW1Hxw+xU4KGk
	 nX8dPLKPIHD0YdRzcr0PfILYiHZZ7mQUcPWL23d9ARw1xo0GL+hxs1SeuL5U2W1B6bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699809;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Zr1gXMsOmSpFG5+TOTKNZZ3xnB6NeOoUG48hE3Nt3/U=;
	b=zwRhb09d+96+yVCUj1Ao8oEAFRRgtBzPeepUrPklz3R1016eC9ZeRdAa9HqTYmginYXT
	 qHF40BQQ6pTarTlXzqWFTlshtT16ET9vlpjypDsHlB9+vBPqWE0zqC4iyZxX6Ra/Pk6B8
	 /V5cVbkgVFpV0peTnLb8uhJzhBIPCEp9swg+1qlJ3OJVh086BVck3ad3YszdlCqKnOex1
	 z0ez/kdLpVoQO7b93e8gCcpUS725wESWOumtNeueYFk737zEUIIv5wphIy92Ev3AP4KHJ
	 6AXGUVZdwjyGiWLSy+odMzia2GLkBJd5xrxpTClVFqlIBtuaOLZvFtL9ViH+9j8gkiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PYBo7Y/p";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315A5606A32D
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYBo7Y/p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B961F000C1;
	Tue,  3 Nov 2026 09:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699808;
	bh=Zr1gXMsOmSpFG5+TOTKNZZ3xnB6NeOoUG48hE3Nt3/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYBo7Y/pfcpORs7MSjcGptyzvdHfUaDciWgQV+4hmr6P8kzAKtHAeds7rkxQKMRu1
	 C5obkhWTy1z1692ecp22KnMh6R4V4KHMY4dHqKl131+ayknWWZOr6FYS7BnfZl0ZJs
	 EjlESuPWcOt/N9rnoIluCiJEewBVhD10uc6xz+oztZyd2SfLGftBVHp0tI+mZYweRf
	 Wgjo0USJvDqRQikKebwjpDLFUXp9IYXHVpN60JC0Dt86AMyOILdr1Rg5/kIcJh0fMu
	 wkxLA3t7RLZW2PyDVmTCUV+6dNplAJTrKhHH9racGLE/lGO0/aFGVwWKw/gsuoDsSB
	 viHdG6G7SlA7w==
Message-ID: <sashiko-outbox-194987@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Verify classic uprobe
 attach types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261103093400.112178-5-jolsa@kernel.org>
References: <20261103093400.112178-1-jolsa@kernel.org>
 <20261103093400.112178-5-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:56:48 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: classic uprobes with expected_attach_type 0 still use pri=
vate stack
- [High] bpf: unchecked kprobe expected_attach_type breaks uprobe feature p=
robe
--

commit 9ee5232694f8a364dae370cb864edf0a6d7ff502
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Verify classic uprobe attach types

This commit adds assertions to the uprobe selftest to check that loaded
classic uprobe and uretprobe programs keep BPF_TRACE_UPROBE as their
expected attach type.

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe.c b/tools/test=
ing/selftests/bpf/prog_tests/uprobe.c
> index 86404476c1daf..7d372552f5eab 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe.c
> @@ -44,6 +44,10 @@ static void test_uprobe_attach(void)
>  	skel =3D test_uprobe__open_and_load();
>  	if (!ASSERT_OK_PTR(skel, "skel_open"))
>  		return;
> +	ASSERT_EQ(bpf_program__expected_attach_type(skel->progs.test1),
> +		  BPF_TRACE_UPROBE, "uprobe_attach_type");
> +	ASSERT_EQ(bpf_program__expected_attach_type(skel->progs.test3),
> +		  BPF_TRACE_UPROBE, "uretprobe_attach_type");

[Severity: High]
Does the feature probe behind this expected_attach_type assignment actually
detect kernel support for BPF_TRACE_UPROBE?

In tools/lib/bpf/libbpf.c, libbpf_prepare_prog_load() sets
expected_attach_type when FEAT_UPROBE_ATTACH_TYPE is supported:

	/* set uprobe attach_type if supported */
	if ((def & SEC_UPROBE) && kernel_supports(prog->obj, FEAT_UPROBE_ATTACH_TY=
PE)) {
		prog->expected_attach_type =3D BPF_TRACE_UPROBE;
		opts->expected_attach_type =3D BPF_TRACE_UPROBE;
	}

In tools/lib/bpf/features.c, probe_kern_uprobe_attach_type() probes this by
calling bpf_prog_load() with BPF_PROG_TYPE_KPROBE and
opts.expected_attach_type =3D BPF_TRACE_UPROBE:

	fd =3D bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL", insns,
			   ARRAY_SIZE(insns), &opts);
	return probe_fd(fd);

However, in kernel/bpf/syscall.c, bpf_prog_load_check_attach() does not have
a case for BPF_PROG_TYPE_KPROBE and falls into the default case:

	case BPF_PROG_TYPE_SYSCALL:
	case BPF_PROG_TYPE_EXT:
		if (expected_attach_type)
			return -EINVAL;
		fallthrough;
	default:
		return 0;

Because BPF_PROG_LOAD does not validate expected_attach_type for
BPF_PROG_TYPE_KPROBE, wouldn't probe_kern_uprobe_attach_type() always
succeed on older kernels too, causing libbpf to unconditionally set
BPF_TRACE_UPROBE while current kernels accept arbitrary invalid
expected_attach_type values for kprobe programs? Also, since
test_uprobe_attach() only checks the userspace getter
bpf_program__expected_attach_type(), should the test also verify that the
kernel rejects attaching a BPF_TRACE_UPROBE program to a non-uprobe perf
event?

[Severity: Critical]
In addition, can a classic uprobe program loaded with expected_attach_type
set to 0 still be assigned a per-CPU private stack and corrupt stack memory?

In kernel/bpf/verifier.c, bpf_enable_priv_stack() only disables the private
stack when expected_attach_type is explicitly set to one of the uprobe
attach types:

	case BPF_PROG_TYPE_KPROBE:
		/* Disable private stack for uprobe programs. */
		if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE ||
		    prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_MULTI ||
		    prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_SESSION)
			return NO_PRIV_STACK;
		fallthrough;

And in kernel/events/core.c, __perf_event_set_bpf_prog() still allows
attaching a BPF_PROG_TYPE_KPROBE program with expected_attach_type =3D=3D 0=
 (and
jits_use_priv_stack =3D=3D true) to a uprobe perf event:

	if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE && !is_uprobe)
		return -EINVAL;

	if (prog->type =3D=3D BPF_PROG_TYPE_KPROBE && prog->sleepable && !is_uprob=
e)
		/* only uprobe programs are allowed to be sleepable */
		return -EINVAL;

If an existing userspace loader (or a sleepable BPF_PROG_TYPE_KPROBE program
loaded with expected_attach_type =3D=3D 0) loads a program with stack depth=
 >=3D
BPF_PRIV_STACK_MIN_SIZE and attaches it to a uprobe event, won't it still
receive PRIV_STACK_ADAPTIVE and overwrite the per-CPU private stack if
preempted on the same CPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103093400.1121=
78-1-jolsa@kernel.org?part=3D4
