Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C12931F7
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788567839; cv=none; b=JcWePRy9sNjw/GvVxe9YCJirN20XHLIbW0PWviO7h8TUqjojH+nGTdAMwee+vly+lTuo0uPVIXdneU+vZ4WjGkFQG8meMUyxwooML8XbcZ6m3JpDOJOVALgeRdPwQdqu4MGSvQoS3/Yf7AotCQciY6ygKdiyeUq0vsK9cHeVfqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788567839; c=relaxed/simple;
	bh=FuwxworsnmRpdS2wyxTknCYmINOeNTTGJ/Jpaj8FTQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZBig4k+0JKsD/FwN5Dg41wumBi5VSny0Ic+GRMHEB9q95MMULoeJl24hq8OW4tMrPEKvBKMd6D2xfE68r1Gue7gwfQ0LQTQtVsMJsoTTSmNJKju4LpcW9m09sIGb1KtI/Dw78l75fqfklk3UHR9/XOGc3M9Qwk3N04NWX6oYddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ6iY3pT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ6iY3pT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E2E1F00A3D;
	Sat,  5 Sep 2026 00:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788567838;
	bh=dyGq+DXVrcV2qIKytHJaHQjyP389fgDPP+pU0G4Hb30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fQ6iY3pT7nTLQcHGKQtcQC4PwDAK+emiG95wo8GklXWBkMR0EzQkk5WW6j6kkNfl1
	 cpOHV7x276TyzzU/VBlTkiC/pDVQrJK4gcU51QZOXsaNIDlBBS2j0eLMvwuk9sPi0f
	 Xg/JtWdRgBl8TjjHi83+Ps2xTinAXzZ1CXzZTKRmyRSj59CvxL9HkWUTwAzV68wTuO
	 IdQ/ODoBQ5Qb6P2bG5HSVpXyQ+PBH1+UHsbEZ1o3X6MVhPa3yHt6cXIP5FVUv1injQ
	 WLfOl2Q8nrhwuSfqNixjkg+qoNNpgzMqY1q46PclX2sjsxVfylpCDjHgJ08xXWs89Q
	 qB8nM0+sgcWng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 03/10] bpf: mark a NULL memory argument of a call
 precise
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-3-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
 <20260904-register-is-null-precise-fixes-v1-3-0f5a360ff15d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:23:57 +0000
Message-Id: <20260905002358.04E2E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Uninitialized variable `known_memory` is read on the error path =
in `check_kfunc_args` when handling NULL memory arguments.
--

commit 00db4f1dea6ce217e9633f69c742a410441956c2
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: mark a NULL memory argument of a call precise

This commit ensures that a NULL memory argument is correctly marked precise=
=20
to prevent pruning against arbitrary scalar values. It also introduces a new
mark_arg_precision() helper to handle arguments that reside on the stack.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ca362a7ea58c3..b758f28227540 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -7168,7 +7177,7 @@ static int check_mem_reg(struct bpf_verifier_env *e=
nv, struct bpf_reg_state *reg
>  	int size, err =3D 0;
> =20
>  	if (bpf_register_is_null(reg))
> -		return 0;
> +		return mark_arg_precision(env, argno);

[Severity: Medium]
Does this early return path leave the `known_memory` pointer uninitialized=
=20
if `mark_arg_precision()` fails?

Looking at its caller in `check_kfunc_args()`, `known_memory` is declared
without initialization:

kernel/bpf/verifier.c:check_kfunc_args() {
	...
	bool known_memory;
	...
	ret =3D check_mem_reg(env, reg, argno, type_size, BPF_READ | BPF_WRITE,
			    meta, &known_memory);
	if (ret < 0) {
		...
		if (known_memory)
			verbose(env, "...");
		else
			verbose(env, "...");
		return ret;
	}
	...
}

If `mark_arg_precision()` returns a negative error code (like `-EFAULT` fro=
m=20
backtracking depth limits), `check_mem_reg()` will propagate it immediately=
=20
before reaching the `if (known_memory) *known_memory =3D true;` block.=20

Could this cause `check_kfunc_args()` to evaluate an uninitialized boolean=
=20
variable when deciding which diagnostic message to print on the error path?

>  	if (known_memory)
>  		*known_memory =3D true;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-register-i=
s-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com?part=3D3
