Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FFF3D093F
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392725; cv=none; b=NTF906g/3K39kxwFHN32nWzZsVLFg5GqafRdmR+Re9B5tyzfSL9olHVvjpkRnZ8lx3nnRmOExtvc44TfmwjNT+Yp0Y1Pzi1M1fUvKsB1P9Prh0u/4IyOrP9wdBQ5NiA0BlN7bUeFL7fAHtNbdSGcH6aTDxL65rg0zBTqxpz9Da8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392725; c=relaxed/simple;
	bh=4+/5yEFn9JFSxH6c5p5oPPracueX7dIOLIPHQldOR7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nRIeWPPiMf+AJf13Ee3A+6UIiCU4Vr5rhPYrBPffCDY6BL4xN1uSYJUStpeFFnPXWYo3uJk0L061z2XKdHWTUBg0+S08LDeej2dBFL/V1lTowHIx47JpQM90WF+4h88U25m3OY+VvreuKsp8IB5rL+ycK0lkcUYZJoDFtOb0u1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxAml9tb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxAml9tb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ED41F00893;
	Tue,  2 Jun 2026 09:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780392719;
	bh=wJ5qHrMSlM7Squ5pAM0LZbkBZoA9q0ejRF0V8bdek2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AxAml9tbQt1hiL/vrDzVMyNXDxLRnszkEceQjNqab4dD6KW+PVShQ/X9C7hPs1N3X
	 ej2IOrjaWIUUWff/DAa5NCBoA2XwLrs4lPSJxCMn2owyJltebMN38I+jwL6WIhzQp9
	 /kgv9PMwtKBm2+gpY1gS3C79zB9bymEIoqV7QlPu+jE+yBgqafzE6QFvSbTw8n8vGu
	 7ZO5FxSNU4a3b/TtzJnWfD5nf7uVAg/yNDruLw34RlVGlPik0ogrPbKQ8aYWA6rKY+
	 IyxsuIV+UPEDAIRXZbA7eKo20WiffVL8otHrQmSjRJZ+O8LMscsheAMUsBo1+L6l0F
	 Hswdzv3Qdx/mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add regression test for kfunc
 implicit arg injection
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602085827.2562222-3-chenyuan_fl@163.com>
References: <20260602085827.2562222-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 09:31:58 +0000
Message-Id: <20260602093158.E4ED41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Multi-line comment does not follow the BPF subsystem comment style.
- [Low] Build failure in selftests due to accessing a non-existent BSS fiel=
d in the reused struct_ops skeleton.
--

commit 70edd2df92a9670c07a307bbdf1081733e04e3dd
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: Add regression test for kfunc implicit arg injection

This commit adds a regression test to verify that the BPF verifier correctly
injects the bpf_prog_aux pointer for KF_IMPLICIT_ARGS kfuncs. It uses inline
assembly to contaminate R2 before calling a kfunc to ensure the kernel prop=
erly
overwrites it with the valid pointer.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc=
.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
> index 461ded7223515..fb4d06dd6c4dc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c

[ ... ]

> @@ -97,6 +103,7 @@ static void test_st_ops_assoc_reuse(void)
> =20
>  	ASSERT_EQ(skel->bss->test_err_a, 0, "skel->bss->test_err_a");
>  	ASSERT_EQ(skel->bss->test_err_b, 0, "skel->bss->test_err_b");
> +	ASSERT_EQ(skel->bss->test_err_inject, 0, "skel->bss->test_err_inject");

[Severity: Low]
Will this cause a build failure? It looks like test_err_inject is defined
in struct_ops_assoc.c, but this function is testing the skeleton for
struct_ops_assoc_reuse.c.

Since the variable isn't defined in the reused program's source, the
generated struct_ops_assoc_reuse skeleton won't contain the test_err_inject
BSS field, which would cause a compiler error when accessing
skel->bss->test_err_inject here.

> =20
>  out:
>  	struct_ops_assoc_reuse__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c b/tools=
/testing/selftests/bpf/progs/struct_ops_assoc.c
> index 68842e3f936b9..ed0084453d560 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> @@ -103,3 +103,43 @@ SEC(".struct_ops.link")
>  struct bpf_testmod_multi_st_ops st_ops_map_b =3D {
>  	.test_1 =3D (void *)test_1_b,
>  };
> +
> +/* Test for aux injection with stale register contamination.
> + *

[Severity: Low]
This isn't a bug, but does this violate the BPF subsystem multi-line
comment style? The guidelines require the opening /* to be on its own
line, rather than starting the text on the same line.

> + * This test verifies that the kernel correctly injects the implicit
> + * bpf_prog_aux pointer for kfuncs with KF_IMPLICIT_ARGS.  The program
> + * uses inline assembly to contaminate R2 with a known magic value
> + * before calling the kfunc:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602085827.2562=
222-1-chenyuan_fl@163.com?part=3D2
