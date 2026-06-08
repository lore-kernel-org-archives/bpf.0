Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA6F3D171B
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930025; cv=none; b=QPZpQeQgiZx8BrRsPxGLTCIFp0fQ2vRSxDbfvzUUZArJEyOVlQdRs44sxSei5lEK/TEnZpXfvnfD9WiYkj74RV6K+fCVrf2qGXQeyAo+ISaYQ5Ah0WFbiFaNuNEVw7w73b0KTo5EbpruY6y07V98TBo73zRrhY6Cjmk4Q20E/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930025; c=relaxed/simple;
	bh=VybfMSP0+rSkL+edavTk5MnuCm5YcWgaRrhNKc5UoSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rFQCPX2rCPTt/AWQDziFLTWO8p2YsQVDn5wBoq5/doWbT2kPAEMMWtrYUGsHcBxHBilx6tcrX7BetV13U6G5Z/i6HhpL0v1QoL6qCt1qgl5WPHngMyqCpRqmTi6km/fdqKVqXjNX349R+1kHlElfc617Bxj4PaRkomjH8o6db6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUcNu2wb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUcNu2wb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299861F00893;
	Mon,  8 Jun 2026 14:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780930024;
	bh=5vfQU9n7L5DAnvCDDrBQqcsgii3SgoQnechN0NvHljQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GUcNu2wbTJnAAa3g/sSuQ1l7NlyY9QGqxNdtDwG2RNxR5PtSmskU99p9Tq2W/KmNW
	 /bvguEChf82tlmRciGekVYoz6OWy7AaJiin0ilj+PxG19LcPjHR0wKB2L57U00bj8v
	 F065UzaiRuYTtcGUFAeL5hrow9dLKDIPZgzncKYaMvm/nWqE4zzKze+s5bZAZAQfC2
	 H7zX3v8jLkSsLXmzxSDbt3JWbN7EqrkLeeBWoo5X5yRuO+B0PVlpf0UVYU2X+OPpg2
	 cRIFzz42h2P4H+8Zyxant5RURrq2XmAEGZIZ7I2O9kcUAN3awRvF7Nsa+Z64KMf+0z
	 SUYLwy8Xs5XTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608142618.3064380-2-chenyuan_fl@163.com>
References: <20260608142618.3064380-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 14:47:02 +0000
Message-Id: <20260608144704.299861F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces references to an undeclared variable `argno` a=
nd an undefined function `reg_arg_name`, causing an unconditional build fai=
lure.
--

commit 07d82a6816de40e50bec7a27a6fdfd4ab3af2c6d
Author: Yuan Chen <chenyuan@kylinos.cn>
bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointe=
r deref

This patch modifies the verifier's check_kfunc_args() to explicitly reject
unrecognized implicit kfunc arguments with -EFAULT instead of silently skip=
ping
them. It ensures that BTF mismatches result in a clean rejection rather than
leading to a kernel crash or information disclosure.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4d..7e5b68c31c349 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12082,9 +12082,27 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_

[ ... ]

> +		if (is_kfunc_arg_implicit(meta, i)) {
> +			/* kfuncs with implicit args (e.g. 'off' parameter)
> +			 * handled during verification in bpf_fixup_kfunc_call():
> +			 * obj_new, percpu_obj_new, obj_drop, percpu_obj_drop,
> +			 * refcount_acquire, list_push, rbtree_add. Don't flag them. */
> +			if (is_bpf_obj_new_kfunc(meta->func_id) ||
> +			    is_bpf_percpu_obj_new_kfunc(meta->func_id) ||
> +			    is_bpf_obj_drop_kfunc(meta->func_id) ||
> +			    is_bpf_percpu_obj_drop_kfunc(meta->func_id) ||
> +			    is_bpf_refcount_acquire_kfunc(meta->func_id) ||
> +			    is_bpf_list_push_kfunc(meta->func_id) ||
> +			    is_bpf_rbtree_add_kfunc(meta->func_id))
> +				continue;
> +			verbose(env, "%s unrecognized implicit argument, possible BTF mismatc=
h\n",
> +				reg_arg_name(env, argno));

[Severity: Low]
Will this compile successfully? It looks like argno is not declared in this
scope (perhaps the intended variable was i or regno?), and the function
reg_arg_name() does not appear to be defined in the kernel tree. Could this
cause an unconditional build failure?

> +			return -EFAULT;
> +		}
> +
>  		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> =20
>  		if (btf_type_is_scalar(t)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608142618.3064=
380-1-chenyuan_fl@163.com?part=3D1
