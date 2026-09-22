Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D7036E466
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040433; cv=none; b=HwrQLWu7/nZ3+L8lLh+fLGK18sK/WjWIySgUcuJArYJl/FUd+w4Rbmgg1ql61e0ceTVc2yuEsCuk/je9z+niG7gx7VAx1yr/3n16l5RT3B1kmtt91X/ramFVzkd2nms3H6b4p20yYrcfhNusJtrYiBpY7n/8N4W4Cugsb8ZCrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040433; c=relaxed/simple;
	bh=66b2ZbWDRaq41HTNP74WrKIar06WfewjBOrn1FtIAbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b/GwJ9BAFLmdVeN7ls5AIwqaf++w8wIctDRh8gZnM7LFa0UJvl69LKT22S2ldIz2jO4zOI2Dw3mtTPN6eWnvJMyOKlwFBgZ39oih2f7rWXQxpj26Hbxfd0WAZqZOY0x+xS9NFVIHX1Y/r4U62mq++Y0xGmGuWv8caaxX4R6LTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC5iWjLL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC5iWjLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F581F000FF;
	Tue, 22 Sep 2026 01:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040432;
	bh=iLFbW76NPh0D0AyCBV1iKchST/weQWwUjbi1XnMCwjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SC5iWjLLU0J5cPn55MVU9votdBx3f/uaDyw5DYnhpWhglyCca7IQ5eH7Dcbedn4pK
	 eBTE/TBzHgAcLy/14BolQSK+82mPYMb3nXpnP1m9sQBnotdqdWLzWnxnhxk4htxqXc
	 OT3ALykL8vkC3pCiJDSjfg7f8ncv7e5InM6VZ5TGYyQEyqkGK656UaszlrrG6AEi+u
	 SrAQKuopdwtuv00ylD6YZQFAGFOGv6fpG0bMN3H9sj3y37mwJgl0df+Dg27Wwx22hW
	 +eSjY6GFx6NDtOAe+n6ObwTMBqhd1mOI3eo2hoCESxwpktDRmfAvlmHCh21dULJ++7
	 2R8iNLhxbCWXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 06/17] bpf: Add callx calls to the call graph
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922011323.1298619-7-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
 <20260922011323.1298619-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:27:11 +0000
Message-Id: <20260922012711.C2F581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: quadratic path explosion in check_max_stack_depth_subprog for=
 callx
--

commit 17c2586ab967c2795c90663c91164f6b6733f760
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add callx calls to the call graph

This commit introduces call graph tracking for indirect callx calls.
It records caller-to-callee edges in a bitmap during the main verification
pass, which is then used by the recursion check and maximum stack depth che=
cks.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0d32d3921210a..12898d31e244d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -5486,23 +5539,40 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>  			return -EINVAL;
>  		}
> =20
> -		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
> -			continue;
> -		/* remember insn and function to return to */
> -
> -		/* find the callee */
> -		next_insn =3D i + insn[i].imm + 1;
> -		sidx =3D bpf_find_subprog(env, next_insn);
> -		if (verifier_bug_if(sidx < 0, env, "callee not found at insn %d", next=
_insn))
> -			return -EFAULT;
> -		if (subprog[sidx].is_async_cb) {
> -			/* async callbacks don't increase bpf prog stack size unless called d=
irectly */
> -			if (!bpf_pseudo_call(insn + i))
> +		if (bpf_is_callx(insn + i)) {
> +			/*
> +			 * Walk the callees recorded by the main verification
> +			 * pass one by one, returning to this insn after each.
> +			 */
> +			if (dinfo[idx].callx_insn !=3D i) {
> +				dinfo[idx].callx_insn =3D i;
> +				dinfo[idx].callx_next =3D 0;
> +			}
> +			sidx =3D next_callx_callee(env, idx, dinfo[idx].callx_next);

[Severity: High]
Could this lead to a quadratic path explosion and unbounded CPU time in the
verifier?

The callx_edges bitmap appears to aggregate all distinct callees for an
entire caller subprogram. If I am reading this correctly,
check_max_stack_depth_subprog iterates over this entire aggregate bitmap
for every single callx instruction in that subprogram.

If a subprogram has K callx instructions and M distinct callees, would the
verifier evaluate K * M edges here instead of just K edges? Across nested
subprogram calls, it seems like this combinatorial amplification could
evaluate paths exponentially. Since this pass lacks state pruning or
complexity bounds, could this bypass the verifier complexity limits and hang
the kernel thread?

> +			if (sidx < 0)
>  				continue;
> -			if (subprog[sidx].is_exception_cb) {
> -				verbose(env, "insn %d cannot call exception cb directly", i);
> -				return -EINVAL;
> +			dinfo[idx].callx_next =3D sidx + 1;
> +			dinfo[idx].ret_insn =3D i;
> +			next_insn =3D subprog[sidx].start;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922011323.1298=
619-1-alexei.starovoitov@gmail.com?part=3D6
