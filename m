Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843933B1EF1
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780389; cv=none; b=IVNrSz6+1OYywrQ6Ti5OwJWUsOJimSLo4NItkOjUI6blzpIS1tqh+CnV8VQidXxvxklwceiNgTqjnvCyGIn5NxFgkcxMw2ylVv4a+ZPw+0M+BNc4io7mWVkHMQskycrBGtjND0jp5oTgc9oea9wcoJPXl0rBButqSRA3R6JubCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780389; c=relaxed/simple;
	bh=C7k9xSHg46NGX1vEILqdEKet9tm0ADDmR62ltR61OhU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iQ5y1n5TSo4IoN/MY8IRXSPE222VNnKPS8g9piLICymn1jQ7msBMYJwNoZLTKl8gOOVhVb+yMgDcLQDeIgJK6/nSmElzR2uiE9nte2lcnXuBDCIS8Ux/bJhEzNgr0JRHhqaWOmboit8d5PHflxujCH2Xz1NWtINIPmfa4RsTILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5X392YO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5X392YO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36C91F000E9;
	Thu, 18 Jun 2026 10:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781780388;
	bh=NJDcK1UVFzhkqlmncruhaF4wynZTf1/vY1Wse7raHUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X5X392YOiKVUkyE2XNvBvxhNTY9vRL6G9IRVQHGVeDjcslGmgbq24VMdAjlKbOJBO
	 fq5DPpfF1H9mu18UAX9HilNl4Q4zjNr+XF/dt0bnrEqRYQli8T364N/nqYVG7M/tF/
	 vebCThztMHIyqDmpuWIjc5GCtXV9cG9Hm1ikjnQZQ7IKZaTymjzdSOSGDlfccb7FNr
	 7AdTPBeKMyGPyT3ZK5FEf1vLVGVJSRdYLi8iPgUBe037Al5bC/CL0Qe5+p6QA68hAR
	 04j2QuJ5KgPmh0GHQnKUWCHVgGcRksNT6ZnIWA69QLsQbJGXYCf7RHQacZi2R+eHcu
	 IZV2B82ro7FzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf, sockmap: fix use-after-free when the
 stream parser resizes the skb
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260618102718.2331468-2-rhkrqnwk98@gmail.com>
References: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
 <20260618102718.2331468-2-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 10:59:47 +0000
Message-Id: <20260618105947.F36C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch attempts to fix a slab-use-after-free by rejecting s=
tream parser programs that modify the SKB, relying on `prog->aux->changes_p=
kt_data`. However, this flag does not account for `bpf_dynptr_write`, which=
 also modifies the SKB and triggers the exact same use-after-free vulnerabi=
lity.
--

commit aeac0d3c109078049124a26f6151db8a79f11ac5
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: fix use-after-free when the stream parser resizes the skb

This patch rejects stream parser programs that modify packet data to
prevent a use-after-free. The issue occurs when skb_ensure_writable() frees
the frag_list that the stream parser continues to track.

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 99e3789492a09..c60ba6d292f9a 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c

[ ... ]

> @@ -1515,6 +1515,17 @@ static int sock_map_prog_link_lookup(struct bpf_ma=
p *map, struct bpf_prog ***ppr
>  	return 0;
>  }
> =20
> +static int sock_map_prog_attach_check(enum bpf_attach_type attach_type,
> +				      struct bpf_prog *prog)
> +{
> +	/* A stream parser must not modify the skb, only measure it. */
> +	if (prog && attach_type =3D=3D BPF_SK_SKB_STREAM_PARSER &&
> +	    prog->aux->changes_pkt_data)

[Severity: Critical]
This isn't a bug introduced by this patch, but does this check completely
prevent the vulnerability?

It appears that prog->aux->changes_pkt_data might be bypassed if a program
uses bpf_dynptr_write(). Looking at bpf_helper_changes_pkt_data() in
net/core/filter.c, BPF_FUNC_dynptr_write is missing from the switch
statement.

Consequently, the verifier does not set prog->aux->changes_pkt_data during
CFG construction for programs that write via dynptrs. While the verifier
sets a local changes_data flag in check_helper_call() to clear packet
pointers:

kernel/bpf/verifier.c:check_helper_call() {
    ...
        /* this will trigger clear_all_pkt_pointers(), which will
         * invalidate all dynptr slices associated with the skb
         */
        changes_data =3D true;
    ...
}

It never sets the permanent env->subprog_info[...].changes_pkt_data flag
for this helper.

Could a malicious BPF_PROG_TYPE_SK_SKB program use bpf_dynptr_from_skb() to
get a writable dynptr, and then call bpf_dynptr_write() to invoke
skb_ensure_writable() and free the frag_list? If so, would this trigger the
exact same use-after-free, completely bypassing this attach-time check?

> +		return -EINVAL;
> +
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618102718.2331=
468-1-rhkrqnwk98@gmail.com?part=3D1
