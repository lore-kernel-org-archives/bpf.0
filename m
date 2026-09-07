Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA682367295
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810286; cv=none; b=elYHhjtiSrEV0e7XTEvRdoA2be/An+dADjGJyTBGf43eYdW1bEQpX+uJt2ezJbKB+e65EqY6QxrRmZ6GTTzL8ee8OIVlql691jLFSktnzoHQWELMtAl6mhacPaGs0UyY5doPeim7VaN3ojYw/UHaSviRHro9Q0BNeAj9jq5nfI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810286; c=relaxed/simple;
	bh=heVSWZ6ofcmkguErxTUn5xFI+sn3FWQ6oAgyxDPFOIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XlGBVf2CqmMFCiVP0MC7SRporrdLKY9BiIoEkyAUHUm+nbK/OG2p+BGVZm1zcF8/DhfN2PsYnwmQ5zFAppNoRg9Wu/mOfw8r4zs3ocSzaNFukyD8f1DNfMYUOnqY4OSYoA9nl1TvixmHe/H1Y6dhvQNVfQLZ7RrL2U8dYgwUkls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS1YHE/W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS1YHE/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BBA1F00A3A;
	Mon,  7 Sep 2026 19:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788810284;
	bh=mCmR72e2nOVpqrAnxqoWJB/dmw9MTO20IiKdwmYu4LY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AS1YHE/Wx3j0mPNoZj9QToAE4SHxjEChfcR0SjTfXl2qgvGcVn5pqZZzjmyy2zEUC
	 KTCQ2jIFTNubPJkbYz+B6apKrAa7UqEZFDTDeefNLEKZ6pSD9jqXpl93DPsWNVmJBa
	 uvjPGey9ZWCkHTFdN/awChdv19Pc5xmCQFzE8NIfb8yaSV708U8zjbIvpBVCcJSi6K
	 2OvLIjONS+1EeBxMGtmmAEglAMrYf7960kt8Tx4uP5Mo+ECrLueDeCB/nxj1UHGTfU
	 flb/nFpqOAFU3Y748o86PPsNQy2Tvlm4ndpYAX221/eGlS/AvzTDt1VZhFaS97ub8u
	 hdi7dWtu70XGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: refresh seg6local SRH pointer after skb pull
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260907192129.557377-2-bestswngs@gmail.com>
References: <20260907192129.557377-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 19:44:43 +0000
Message-Id: <20260907194444.37BBA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The fix for the dangling SRH pointer is conditionally compiled=
 under `CONFIG_IPV6_SEG6_BPF`, leaving the use-after-free vulnerability unp=
atched when IPv6 is compiled as a module (`CONFIG_IPV6=3Dm`).
- [Critical] Early error returns in `bpf_lwt_seg6_store_bytes`, `bpf_lwt_se=
g6_adjust_srh`, and `bpf_lwt_seg6_action` leave `srh_state->srh` dangling i=
f the SKB head was reallocated before the failure, causing the exact same u=
se-after-free that the patch attempts to fix for `bpf_skb_pull_data`.
- [High] `bpf_lwt_seg6_store_bytes`, `bpf_lwt_seg6_adjust_srh`, and `bpf_up=
date_srh_state` use `ipv6_find_hdr` without `IP6_FH_F_SKIP_RH`, correctly i=
dentifying the wrong routing header if multiple are present.
--

commit 681db76be957fb9fd9b5dfbb7a3c0b06da4f90b7
Author: Weiming Shi <bestswngs@gmail.com>

bpf: refresh seg6local SRH pointer after skb pull

An LWT_SEG6LOCAL program can invalidate its cached SRH with
bpf_lwt_seg6_adjust_srh() and then call bpf_skb_pull_data(). The latter
may reallocate skb->head, leaving the per-CPU SRH pointer dangling.
Post-program SRH validation then writes through that pointer.

Closes: https://lore.kernel.org/all/GCy0KRM2IcQGoJQTjJEU9D0maBxXzEDHuQpq@bu=
gs.sh/

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e7535523..e61f9e9226b10 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7162,6 +7162,32 @@ static const struct bpf_func_proto bpf_lwt_seg6_ad=
just_srh_proto =3D {
>  	.arg2_type	=3D ARG_ANYTHING,
>  	.arg3_type	=3D ARG_ANYTHING,
>  };

[Severity: High]
This isn't a bug introduced by this patch, but bpf_lwt_seg6_store_bytes(),
bpf_lwt_seg6_adjust_srh(), and bpf_update_srh_state() use ipv6_find_hdr()
without IP6_FH_F_SKIP_RH, which can correctly identify the wrong routing
header if multiple are present.

If a remote packet arrives with an exhausted Routing Header (e.g., Type 0)
followed by an active SRH, seg6_get_srh() initially correctly skips the
exhausted header using IP6_FH_F_SKIP_RH.

However, when the BPF program calls bpf_lwt_seg6_store_bytes() or
bpf_lwt_seg6_adjust_srh(), they recalculate the pointer using
ipv6_find_hdr() without IP6_FH_F_SKIP_RH, which stops at the exhausted
first header:

net/core/filter.c:bpf_lwt_seg6_store_bytes() {
    ...
    if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
        return -EINVAL;
    ...
}

This reassigns srh_state->srh to the wrong header. Later,
seg6_bpf_has_valid_srh() overwrites the hdrlen of the exhausted header and
validates against it, which can cause packet corruption and SRH validation
bypass.

Should we update these functions to use IP6_FH_F_SKIP_RH when finding the
routing header to ensure we match the correct active SRH?

> +
> +BPF_CALL_2(bpf_lwt_seg6_pull_data, struct sk_buff *, skb, u32, len)
> +{
> +	struct seg6_bpf_srh_state *srh_state =3D
> +		this_cpu_ptr(&seg6_bpf_srh_states);
> +	unsigned int srhoff;
> +	int ret;
> +
> +	lockdep_assert_held(&srh_state->bh_lock);
> +	if (!srh_state->srh)
> +		return ____bpf_skb_pull_data(skb, len);
> +
> +	srhoff =3D (unsigned char *)srh_state->srh - skb->data;
> +	ret =3D ____bpf_skb_pull_data(skb, len);
> +	srh_state->srh =3D (struct ipv6_sr_hdr *)(skb->data + srhoff);
> +
> +	return ret;
> +}

[Severity: Critical]
This is a pre-existing issue, but I noticed early error returns in
bpf_lwt_seg6_store_bytes(), bpf_lwt_seg6_adjust_srh(), and
bpf_lwt_seg6_action() leave srh_state->srh dangling if the SKB head was
reallocated before the failure, causing the exact same use-after-free
regression that this patch attempts to fix for bpf_skb_pull_data().

For example, in bpf_lwt_seg6_store_bytes():

net/core/filter.c:bpf_lwt_seg6_store_bytes() {
    ...
    if (unlikely(bpf_try_make_writable(skb, offset + len)))
        return -EFAULT;
    ...
}

If bpf_try_make_writable() successfully reallocates skb->head and frees the
old head, but then fails in a subsequent step such as an skb_clone()
fragment failure, it returns an error code immediately.

Because the early error paths do not update srh_state->srh, it remains
pointing to the freed old head. When the BPF program finishes,
seg6_bpf_has_valid_srh() accesses this freed memory.

A similar situation occurs in bpf_lwt_seg6_adjust_srh():

net/core/filter.c:bpf_lwt_seg6_adjust_srh() {
    ...
    if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
        return -EINVAL;
    ...
}

If the earlier skb_cow_head() successfully freed the old head, and then this
IPv6 header search fails, it returns early and leaves the SRH pointer dangl=
ing.

Also in bpf_lwt_seg6_action():

net/core/filter.c:bpf_lwt_seg6_action() {
    ...
    if (!pskb_pull(skb, hdroff))
        return -EBADMSG;
    ...
}

If pskb_pull() reallocates the head and fails, bpf_update_srh_state(skb) is
never called, leaving the SRH pointer dangling.

Should we also ensure the SRH pointer is updated on early error returns in
these functions, similarly to how it is handled for bpf_skb_pull_data() her=
e?

> +
> +static const struct bpf_func_proto bpf_lwt_seg6_pull_data_proto =3D {
> +	.func		=3D bpf_lwt_seg6_pull_data,
> +	.gpl_only	=3D false,
> +	.ret_type	=3D RET_INTEGER,
> +	.arg1_type	=3D ARG_PTR_TO_CTX,
> +	.arg2_type	=3D ARG_ANYTHING,
> +};
>  #endif /* CONFIG_IPV6_SEG6_BPF */

[ ... ]

> @@ -9052,6 +9078,8 @@ lwt_seg6local_func_proto(enum bpf_func_id func_id, =
const struct bpf_prog *prog)
>  		return &bpf_lwt_seg6_action_proto;
>  	case BPF_FUNC_lwt_seg6_adjust_srh:
>  		return &bpf_lwt_seg6_adjust_srh_proto;
> +	case BPF_FUNC_skb_pull_data:
> +		return &bpf_lwt_seg6_pull_data_proto;
>  #endif
>  	default:
>  		return lwt_out_func_proto(func_id, prog);

[Severity: Critical]
This is a pre-existing issue, but I noticed the fix for the dangling SRH
pointer is conditionally compiled under CONFIG_IPV6_SEG6_BPF, leaving the
use-after-free regression unpatched when IPv6 is compiled as a module
(CONFIG_IPV6=3Dm).

When IPv6 is built as a module, CONFIG_IPV6_SEG6_BPF evaluates to 'n'.
BPF programs can still be attached via parse_nla_bpf() which unconditionally
supports BPF_PROG_TYPE_LWT_SEG6LOCAL. The verifier defaults
BPF_FUNC_skb_pull_data to the standard bpf_skb_pull_data_proto wrapper
instead of this newly introduced safe wrapper because of this fallback:

net/core/filter.c:lwt_seg6local_func_proto() {
    ...
#if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
    ...
#endif
    default:
        return lwt_out_func_proto(func_id, prog);
}

This standard wrapper can reallocate the SKB head without updating the
per-CPU srh_state->srh pointer. When the BPF program finishes,
input_action_end_bpf() in net/ipv6/seg6_local.c reads the dangling
pointer regardless of CONFIG_IPV6_SEG6_BPF:

net/ipv6/seg6_local.c:input_action_end_bpf() {
    ...
    if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
        goto drop;
    ...
}

Can we make sure the safe wrapper is also used when IPv6 is compiled as a
module to avoid this regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907192129.5573=
77-2-bestswngs@gmail.com?part=3D1
