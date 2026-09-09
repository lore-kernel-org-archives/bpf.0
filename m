Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192B657267E
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963261; cv=none; b=UxTIxXdRVVeYo7NjVmiSmj+JFBmHfXJhJ+iESxvP74t+V6zXdfKBbnwv4YR9wVcp90upbaFp7vNj4BfoaJKJh9bIkTiT/mRJJEyvbmrJP3oyXuJoV4tgc0fsbjyfLcMnRNkPCcz/exy+/KqTdpv+2v5kmtXbiuQ52LPMf/PP26c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963261; c=relaxed/simple;
	bh=PtRrn2chiNume5GGEaw2CimUgwtkpASY7awBr0YqhSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fXlbkiaDVVBw8Sv+FnDkSZjTPXLzeIl8jkp1eJejrklT5XUFylQyQaG2z2k1bNBSH/UwCzQ541N+IwcuyK0F8GOD3rEmFlZ0hQ8ZsLMhazvO/FBuAYwTPMDSjX5Oz/yoeDPMiP8FiqNRi3DBbEKSsbvvF739xf7Ez4q17N5Mc2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDafvnJ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDafvnJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3721F00A3D;
	Wed,  9 Sep 2026 14:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963259;
	bh=PhI+WpoHYyL/CMNNfS2GSigoLUYI99YUj4kAJbAqmZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SDafvnJ1Dc2S0M127Ihnks+yZ2a4HsDoX2eaSs9PBlfs2fV5svgoGQKnbJGG/dOC5
	 6HEQ5wVr4qPKCr24U2ZRI6qB28DC+QJTINZRqJ0TShDaDNYsyp9ju4IRKLWiUtQHY3
	 NnrtngY6JkeCms5S5i9PLu0v6OvgSqy8B7d9ruynKa58AI2Jj0QEvcvSyYCVFDOJSc
	 TyS5kEat7w18vQAfkBGmupNHoJA2LV5bV6Q4hNpWLpYQQHkWkGIC/29K96uLXgnCtO
	 XfWorTS+JHIoPV4WHx8hiqd4n4d22YHG58vK8cPiBok4hrAiXkQzhJnGX50j65ybgo
	 QKJVyHuzuDscA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: Fix non-linear SRH access in
 bpf_update_srh_state()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQgU2VjdXJpdHkgRk9SR0UgTGFicyk=?= <cenzhang@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909135324.60165-1-cenzhang@linux.microsoft.com>
References: <20260909135324.60165-1-cenzhang@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:14:19 +0000
Message-Id: <20260909141419.BD3721F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free and OOB access in bpf_lwt_seg6_store_bytes and bpf_=
lwt_seg6_adjust_srh
--

commit f61c52a826d2d54d2acaba3787ebc0a69bbfc5af
Author: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft=
.com>

bpf: Fix non-linear SRH access in bpf_update_srh_state()

This commit fixes an out-of-bounds access in bpf_update_srh_state() by
replacing ipv6_find_hdr() with seg6_get_srh() to ensure the SRH is pulled
into linear memory. It also updates bpf_lwt_seg6_action() to correctly
handle skb->head reallocations.

Link: https://lore.kernel.org/bpf/20260901183151.16648-1-cenzhang@linux.mic=
rosoft.com/
Link: https://lore.kernel.org/bpf/CABFh=3Da5iLOEJdPhoaWUhLc0eEqAuhnd83_jJr9=
MVZZG6gSJAEw@mail.gmail.com/

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8513167a858a8..b037d70e5fe65 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[Severity: High]
This is a pre-existing issue, but does bpf_lwt_seg6_store_bytes() have a
use-after-free and out-of-bounds access risk similar to the one fixed here?

In bpf_lwt_seg6_store_bytes():

	if (unlikely(bpf_try_make_writable(skb, offset + len)))
		return -EFAULT;
	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
		return -EINVAL;
	srh_state->srh =3D (struct ipv6_sr_hdr *)(skb->data + srhoff);

The call to bpf_try_make_writable() can reallocate skb->head. If the
subsequent call to ipv6_find_hdr() fails, the function returns without
updating srh_state->srh, leaving a dangling pointer to the freed skb->head.

Additionally, if ipv6_find_hdr() succeeds but locates the SRH in non-linear
data, the cache update uses skb->data + srhoff.

Could this result in an out-of-bounds pointer being cached, just like the
bug this patch fixes in bpf_update_srh_state()?

[Severity: High]
This is a pre-existing issue, but bpf_lwt_seg6_adjust_srh() appears to
suffer from similar memory safety issues.

In bpf_lwt_seg6_adjust_srh():

	if (len > 0) {
		ret =3D skb_cow_head(skb, len);
		if (unlikely(ret < 0))
			return ret;
		...
	} else {
		ret =3D bpf_skb_net_hdr_pop(skb, offset, -1 * len);
	}

	bpf_compute_data_pointers(skb);
	if (unlikely(ret < 0))
		return ret;
	...
	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
		return -EINVAL;
	srh_state->srh =3D (struct ipv6_sr_hdr *)(skb->data + srhoff);

Operations like skb_cow_head() or bpf_skb_net_hdr_pop() can reallocate
skb->head. If they fail, returning early leaves srh_state->srh pointing to
freed memory. Similarly, if ipv6_find_hdr() fails, it returns early leaving
a dangling pointer.

If ipv6_find_hdr() succeeds, it also caches a potentially out-of-bounds
pointer from non-linear data.

Would it make sense to update both of these functions to safely handle
skb->head reallocations and use seg6_get_srh() instead of ipv6_find_hdr()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135324.6016=
5-1-cenzhang@linux.microsoft.com?part=3D1
