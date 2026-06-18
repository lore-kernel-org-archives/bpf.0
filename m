Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF13033DE
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773795; cv=none; b=lYHjAtuShwO8R1z7mX3SRuePnvSFKj7SJR7CmBWB18NooWE21uB+OTkt2YxZbtdMVJL+20xk8UtzSnamUP5E1gTDG02wbJ90qTA5fMIW0rBhrhTZ7ENlXKc2VKNCVjdw6vF4vj8yxMSwx9Ld3ZJ6bpLB6AfYIPGdtns6V1QiyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773795; c=relaxed/simple;
	bh=zv7dnoIiEIsog103TukZRXg57EQskPkFPXs+MseL5NA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oKDwQfJh8nGRHdxScSgxwUZ21rFuImiExoBlHFonbXWR5xtFB7P6XUjEYF/+BPoHVc5XjFcE0IBoU6V9ATPnC0/AO6o3yB808dX/oBdEbvNKbousNzzgabnGh8DVhS9EOZxr1XTNA3ZV7JWmQ5efJSiMrNCC/Y0hB+cnpmxAY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pzr6ulfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pzr6ulfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E281F000E9;
	Thu, 18 Jun 2026 09:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781773794;
	bh=VeFcHbnImlRTB65SVDBoI7yPUyIn+F1z/NeuwxUmlbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pzr6ulfb2x9OGaWPqBrupYyIJb/wxZxup0zrFvaXyq2mnpfvnN4am16L4hK5uM8zy
	 AOM+zJpev83RNjx4Zo0rJ1vuXaBWfA1K6THG4AG1mBQOl9CZLE/UkFO25osIhkGsCL
	 2Bf9AtyZEhJ3/jbu16zPS+AofsNwOR6x4e2vv1gPLMD4tX2WkXnwcEUpZkyzqmBano
	 6u8oPuToI0GD8eyVpnz3B97XsTkvFmY8MaUUZnbNtEUu3R9TacO5eYQmfwkHOteAUL
	 MvYEzu+QxI2wR0/S8UP8CyZFbGpS7Gya/52Gc4NA0zEwCV13yrk4PasKu3QgK3kpUL
	 Y1HeB30K90rQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: libarena: Fix can-loop zero
 variable definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260618085626.19633-3-emil@etsalapatis.com>
References: <20260618085626.19633-1-emil@etsalapatis.com>
 <20260618085626.19633-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 09:09:53 +0000
Message-Id: <20260618090954.12E281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing `barrier_var()` clobber in open-coded loops allows compi=
ler Loop Strength Reduction, leading to verifier failures.
--

commit 3447132bcf1b724653f0483db116e1292c49b493
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Fix can-loop zero variable definition

This patch modifies the zero variable to be a regular volatile instead of
a const volatile, ensuring it remains imprecise in BPF can_loop constructs.
Because this change can cause the compiler to optimize array accesses into
pointer increments (which breaks verification), barrier_var() is added to
several loops.

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bp=
f.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
> index b45a306816c0e..5628f09870121 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
[ ... ]
> @@ -171,7 +171,8 @@ __weak int test_buddy_alignment(void)
>  SEC("syscall")
>  __weak int test_buddy_alignment(void)
>  {
> -	int ret, i;
> +	int ret;
> +	u32 i;
> =20
>  	ret =3D buddy_init(&buddy);
>  	if (ret)
> @@ -179,6 +180,7 @@ __weak int test_buddy_alignment(void)
> =20
>  	/* Allocate various sizes and check alignment */
>  	for (i =3D zero; i < 17 && can_loop; i++) {
> +		barrier_var(i);
>  		ptrs[i] =3D buddy_alloc(&buddy, alignment_sizes[i]);

[Severity: Medium]
The commit message notes that modifying the zero variable definition requir=
es
using barrier_var() to prevent the compiler from optimizing array dereferen=
ces
into pointer increments, which causes verification failures.

Since zero is now globally volatile, do we need to add barrier_var() to oth=
er
loops that use zero for array dereferences to prevent loop strength reducti=
on?

For instance, in test_buddy.bpf.c:test_buddy_alloc_multiple():

    for (j =3D zero; j < sz && can_loop; j++) {
        mem[j] =3D poison;
    }

And the outer loop in the same function:

    for (i =3D zero; i < SEGARRLEN && can_loop; i++) {
        sz =3D alloc_multiple_sizes[i % 9];
        ...
        segarr[i].block =3D mem;
    }

Similar tight loops exist in other files, such as spmc_common_init()
in test_parallel_spmc.bpf.c:

    for (i =3D zero; i < TEST_SPMC_MAX_VALUES && can_loop; i++)
        seen[i] =3D 0;

And asan_test_buddy_oob_single() in test_asan_buddy.bpf.c:

    for (i =3D zero; i < alloc_size && can_loop; i++) {
        mem[i] =3D 0xba;
    }

Will these un-barriered loops also suffer from the same verification failur=
es?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618085626.1963=
3-1-emil@etsalapatis.com?part=3D2
