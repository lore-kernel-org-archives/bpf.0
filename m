Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51987371D1D
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010516; cv=none; b=NqZNMRjcntq+9sq1tX+nsK4gz7/FyoeXiyhy0+xQ++C+V4W4sX1LTmy2uU+N53AZeOd0ch8QAY2F7NT58A0+2cIuETSj2HjYQTT/eNCuHozGMylW7VhDRO71bxuQsTQQuV7T9sHOBeGBtIII9WYl5bzipa30SvRa4wbM+zUgesw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010516; c=relaxed/simple;
	bh=+bMqPCuDHgXcG7lBBSBlbgsYr3H771IbWSOBsLqIjh4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fehhoad+J8EFYiaTPpr3CE0QD0mc5AoeZSMdhOZj0SZQADDpUuco2MHPjDPnohfbgjJjWBiv9BYizaU8O10mkEaQZr0evqP0rUE6+QChAfPWJi2fp+sMEk0LZFOimS0PfsPjPQ0EvPz2YYm7kK/J7BKymbc8hc3rCKVlY5VNX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0+fzNBV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0+fzNBV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFA21F0089E;
	Tue,  9 Jun 2026 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781010515;
	bh=KKKuN1TO9iRZqzBi/TtUciNwn/hqQd3cZSYdsMAZBMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L0+fzNBVAt0putqyxTiB5kHlpbnKNfmprdkt2GtTeSNJViA7AFqxH2RjrAyK/PlGk
	 OyX7eH37iZsYzd1m6yvbEVOVF+e5aYj5tUtvrRemqd8FNAI3gWWbcHayMWHwW3LdIb
	 Be0WnaSZxOEzQWtBDzTInk6yxutwj9qsO2sOWdl/JW9SwxzUhbFWu2t4nUAIR9bhkp
	 3tz7CDyq2PXnIsG4/R6EqiGr+izMjUk2iRMOFODKHKLAVZwD1Wi86/6KrIjMKYw8R5
	 xHqp0JJNIYjAOZle2ZZihdp2mU/BxGM4FQFSF0QZNGfE9neDJWOlK6wOk2x/1eWQb1
	 WlmMVaqiHluhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v6 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609125214.3096351-2-chenyuan_fl@163.com>
References: <20260609125214.3096351-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 13:08:33 +0000
Message-Id: <20260609130834.CAFA21F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a hard compilation error by referencing an und=
eclared variable `argno` and an undefined function `reg_arg_name()`.
--

commit 73eb7a1ebaf3a1d6b87a679580f3e6dc96801fe5
Author: Yuan Chen <chenyuan@kylinos.cn>
bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointe=
r deref

This commit fixes a vulnerability where an implicit bpf_prog_aux argument
could be bypassed due to BTF dedup failures, leading to arbitrary kernel
memory dereference. It ensures the verifier strictly validates and either
injects the correct pointer or explicitly rejects the program.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12082,9 +12082,28 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
[ ... ]
> +		if (is_kfunc_arg_implicit(meta, i)) {
> +			/*
> +			 * This is an exhaustive list of the non-bpf_prog_aux
> +			 * implicit args kfuncs, which are handled
> +			 * post-verification by bpf_fixup_kfunc_call().
> +			 */
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
Does this code compile? It looks like it introduces a build error by
referencing argno, which is not defined in this scope.

Also, is reg_arg_name() defined anywhere? It doesn't appear to be declared
or defined in the kernel tree.

> +			return -EFAULT;
> +		}
> +
>  		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609125214.3096=
351-1-chenyuan_fl@163.com?part=3D1
