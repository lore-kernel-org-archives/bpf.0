Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47387374E6F
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216923; cv=none; b=Sq9Z+e57sfKN4IOUjecnyzDd6lyLKWCxg2hpVMFM0n2ErVIAfdqaApdoReZuB3FA2Ihou1HXi/lEEMui091pmHv0zGLkJY9AaOBLR1PMB2HVXdzBQOMxO4hlxy7oBOCjOg6FfowJa1BQoeIPjZeWU3LtPo84h7g/a6vQIq8P5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216923; c=relaxed/simple;
	bh=N79XjQJoOuQt9ZkaNiqaXvHrn0UqlVJjCB0UiQJmyEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mwj1etsG2gFb1PD4VGQiP6WQCHBCR9gBCYe9xaMrpkGKZCmadpXy9/4Lum79YUrGzbk38Jo+ZZd9hefc6NUU5E7BykUBpcvTH64bZ16NJoNIpPRR4Pg7iujIKe3ONFM0+2rbqbfmeUoHWUC5b9Nkz/H8ziBqad6P38cUK7qaf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tyt2D4Zg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tyt2D4Zg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A746A1F000E9;
	Tue, 19 May 2026 18:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779216919;
	bh=DLwFSR+DyRFav3S6g8jXJGEJYQ4iFWeTwWziA8iKh2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tyt2D4ZgiP6Y1JFlrDsn70o1x8JAjajZ6wMWsedZuTqnBVOLvrAoGSU8ol1+vQBsp
	 +ZioOirVxPF3nMSHppi9vXZHKEPlwtepEarETq+MGPfNsDlVmgNDIv3phnwAapeCiS
	 Pk9UIPUedS8x5ZudmhKfMguBJmOPCk/haf13FXevTHJylrvNLe0vUcy/kOxJm/0aOK
	 xOx+DkNz61U/fG8/xfeBbP+zSaJjnu5lMim+1IqGxs8PZNyjKh4bRz0oyi7UlEVxaK
	 ylZTEO74ms37S/TPD6mS86acdvv8hGlXyaFOyHeZfSzFWQTwZQRLYAzNV++DcPpUpv
	 1MD7B036b31tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 07/14] bpf: Unify referenced object tracking
 in verifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519181314.2731658-8-ameryhung@gmail.com>
References: <20260519181314.2731658-8-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 18:55:19 +0000
Message-Id: <20260519185519.A746A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused legacy fields `ref_obj_id` and `id` remain in `struct bpf_ca=
ll_arg_meta`.
--

commit ff3476feb916076d44d843f726cd0727a0a067bc
Author: Amery Hung <ameryhung@gmail.com>

bpf: Unify referenced object tracking in verifier

This commit unifies referenced object tracking in the verifier by introduci=
ng
struct ref_obj_desc to consolidate the id and ref_obj_id fields. It updates
kfuncs and helpers to use this shared structure, replacing open-coded updat=
es
with shared helper functions.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edebeb3ad3635..bc7f8725cc698 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -231,9 +231,28 @@ static void bpf_map_key_store(struct bpf_insn_aux_da=
ta *aux, u64 state)
>  			     (poisoned ? BPF_MAP_KEY_POISON : 0ULL);
>  }
> =20
> +static void update_ref_obj(struct ref_obj_desc *ref_obj, struct bpf_reg_=
state *reg)
> +{

[ ... ]

>  struct bpf_call_arg_meta {
>  	struct bpf_map_desc map;
>  	struct bpf_dynptr_desc dynptr;
> +	struct ref_obj_desc ref_obj;
>  	bool raw_mode;
>  	bool pkt_access;
>  	u8 release_regno;

[Severity: Low]
Since this patch consolidates id and ref_obj_id into the new ref_obj field,
should the legacy ref_obj_id and id fields be removed from struct
bpf_call_arg_meta as well?

Looking at the rest of struct bpf_call_arg_meta, it appears these old field=
s=20
were successfully removed from struct bpf_kfunc_call_arg_meta but were left
behind here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519181314.2731=
658-1-ameryhung@gmail.com?part=3D7
