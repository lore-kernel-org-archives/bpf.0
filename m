Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039F4B8DEE
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018053; cv=none; b=oiyEyif5bG6W+WNhpA6aMqy8jsGh3fDlCuN9GmzMNzA/o/Ov38uVPOkR7bUpKkW1jY+XvhC9V3Y50PaPTgvopJilaOFXIATzXBtWDsverdP2eCOzFuH4W1Y7G5GLEtv5vHpd3r+jDDQ57GEHEdl0t+vx0gVrDsylNyHwBvhj9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018053; c=relaxed/simple;
	bh=3ziFoZoKKIktYhgFpVpe64MMhwrkJm8iB79zc3+t2xY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GOi6FrlfCQ10buyXuOHIWFNWaOARm3OTC8r3xnSIxQEIEUGG5NHU4HQIMSrw0AK/Gpx/EEPry2jmjmIO75C3ZemiJB1IBSbnCLg0qxAwXwQMrVlLkn6AJexa8pH0/ze+xZbCDBoaXwneh0g1TiGQL7Uzp3J0Xf22upsgdUP1AJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMhjIJwV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMhjIJwV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6F51F00893;
	Tue,  9 Jun 2026 15:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781018039;
	bh=gI7XjOemkCpWkMJy3ocBz54hsr35IBC1eUp8QVS4b6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hMhjIJwV6LMnZqqOx3TKkJtCJu/cwods0Ers5qUU7osF3tlsz+BXwujc4W34rMjlh
	 eTbZq491lLDt05Yl6GgXgGCsOLE3mhj7cpzYXki/T1fF/6B842BF5mAK46ip/3XIPx
	 ky15JvwrPlTfZF11tjnt8aGUK1Ac4FPS6QEfAqtEi2v2fAdPuYNPfbiYbVQ9+cAMhp
	 KdkF4R4izXVwWkCzFc4+7LrIy89JIkgN9qHOZGPwLR/tcI0b2qL2H8QdbuoqADGoq/
	 3j3QGMCD5L0wGUJfQifpaLEHuhFBQYHxjKIflNi8OffhBMSwtkHRDkwitcwfMTu4HV
	 ckm79PqSLqOqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix gotox target validation against
 CFG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609-f01-02-gotox-bpf-next-v1-1-b441d63a1559@mails.tsinghua.edu.cn>
References: <20260609-f01-02-gotox-bpf-next-v1-1-b441d63a1559@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 15:13:58 +0000
Message-Id: <20260609151359.3C6F51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly introduced jump target validation check in `check_indire=
ct_jump` introduces an O(N * M) algorithmic complexity that bypasses verifi=
er complexity limits, allowing a CPU soft lockup or Denial of Service (DoS).
--

commit 618413c7b9b3d9e098467c3629ea05da9fcb47af
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

bpf: Fix gotox target validation against CFG

This commit adds validation to ensure that jump targets copied from the
INSN_ARRAY map are present in the CFG jump table built for the gotox
instruction. It rejects programs before pushing verifier states for unmodel=
ed
targets to prevent entering another subprog without a matching call frame.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ed7ba0e6a9ce0..25fa90e731e30 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17124,6 +17124,23 @@ static int indirect_jump_min_max_index(struct bp=
f_verifier_env *env,
>  	return 0;
>  }
> =20
> +static bool is_cfg_indirect_jump_target(struct bpf_verifier_env *env,
> +					u32 target)
> +{
> +	struct bpf_iarray *jt =3D env->insn_aux_data[env->insn_idx].jt;
> +	int i;
> +
> +	if (!jt)
> +		return false;
> +
> +	for (i =3D 0; i < jt->cnt; i++) {
> +		if (jt->items[i] =3D=3D target)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* gotox *dst_reg */
>  static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_=
insn *insn)
>  {
> @@ -17171,6 +17188,15 @@ static int check_indirect_jump(struct bpf_verifi=
er_env *env, struct bpf_insn *in
>  		return -EINVAL;
>  	}
> =20
> +	for (i =3D 0; i < n; i++) {
> +		if (!is_cfg_indirect_jump_target(env, env->gotox_tmp_buf->items[i])) {

[Severity: High]
Could this nested iteration result in a CPU soft lockup?

This loop inside check_indirect_jump() iterates n times, and
is_cfg_indirect_jump_target() performs a linear scan over jt->cnt. Both n
and jt->cnt are bounded by the map's max_entries, which can be very large.

Since there is no cond_resched() here, this creates an O(N * M) synchronous
iteration sequence that bypasses the verifier's global instruction limits
and could trigger the kernel watchdog panic.

Given that both gotox_tmp_buf->items and jt->items are strictly sorted
arrays, could this be optimized to O(N + M) using a two-pointer merge
approach or O(N log M) using binary search?

> +			verbose(env,
> +				"gotox target %u from map id=3D%d is not in the CFG jump table\n",
> +				env->gotox_tmp_buf->items[i], map->id);
> +			return -EINVAL;
> +		}
> +	}
> +
>  	for (i =3D 0; i < n - 1; i++) {
>  		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
>  		other_branch =3D push_stack(env, env->gotox_tmp_buf->items[i],

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-f01-02-got=
ox-bpf-next-v1-0-b441d63a1559@mails.tsinghua.edu.cn?part=3D1
