Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4742A796
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557140; cv=none; b=HozYEb/Nf3hSXXzGXSylEyfPy8FQ9jGSs8U+C67qQunseXFkLk58rN/0zKoay9z8/LHXapNAleiAFdn3ExTgnU56eitcsSI9dR4oT+46RFMpmpy3rHBFBz4gwpSUs+PlA0YoJn1PIwglM0I5s+VfqLpel9YoSypei3YZ1PZrWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557140; c=relaxed/simple;
	bh=8e5VApyeGKMZII4tP8/p08nbLyY/Kfg1+46m5Y8IWuU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iHkrflXIussXXxVaK4RAz0/Z/8bBslYq7NUl04TSZejkCPpVIltksoAY6i+Jap0Dh21g1Bh2kQHiSLWPXp6xJ8TKFo1L+QMeWbmQ1e9AWm+O0Dzvex+YW9evRgDYleOBBvYuCq78jCltT9ZD5BtGnYBocAnWmm1K7Elzv9XM/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlkkeL71; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlkkeL71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FF41F000E9;
	Mon, 20 Jul 2026 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784557139;
	bh=+ssVCpKzMzJVU3L2gDlak7tN4lZKZd6CZSi02/ktGjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DlkkeL71f1Z7zPo71b8fFuh2EbaLvpUAmkQI5ZjWcR4DTji3dL5hyGLDENvwCCSzz
	 evc/5EFbPBFN6zlWxTKGQJnGrJiC8paz9euPinpVzjXl6unj43E/ehG1JTlBk8s27q
	 HKm8Q5s3Q30cO2PVZH3yH2kahUHNMs/w2xkg8p8CPwBXmDjgr5rKNlLt275HGHa51B
	 jXgJ3MksQZ16u4b0rzlZq5kJyuJTkRvl6ZAgtSfOZckGyLUA2PoTTRjvOHy76ZKVLf
	 380EIVg+Lr4Z7uxOV0sCApe/DGikcJKzoYujluRnWG2F1Ol3WIforaeNZPDFGLyN6p
	 4Z7n7+4qAz4xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] veth: convert frag_list skbs before running XDP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Fleming" <matt@readmodwrite.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720140545.461747-1-matt@readmodwrite.com>
References: <20260720140545.461747-1-matt@readmodwrite.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:18:58 +0000
Message-Id: <20260720141859.19FF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] veth_xdp_rcv_skb() fails to adjust skb->len when an XDP progra=
m modifies fragment lengths, causing state desynchronization.
--

--- Patch [1]: [PATCH bpf v2] veth: convert frag_list skbs before running X=
DP ---
commit c3ece024a1663f1b10d53a17f59581af7993ec1f
Author: Matt Fleming <mfleming@cloudflare.com>

veth: convert frag_list skbs before running XDP
   =20
A frag_list skb can reach veth with data_len set but nr_frags zero.
This patch routes non-linear skbs through skb_pp_cow_data() before exposing
them to XDP, preventing a crash in AF_XDP copy mode.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 1c51421491753..00e34afd858e7 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

> @@ -771,7 +771,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_r=
q *rq,
>  	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
>  			 skb_headlen(skb), true);
> =20
> -	if (skb_is_nonlinear(skb)) {
> +	if (skb_shinfo(skb)->nr_frags) {
>  		skb_shinfo(skb)->xdp_frags_size =3D skb->data_len;
>  		xdp_buff_set_frags_flag(xdp);
>  	} else {

[Severity: Critical]
This is a pre-existing issue, but while reviewing the XDP fragment changes,=
 I
noticed a potential state desynchronization in veth_xdp_rcv_skb() when hand=
ling
XDP tail adjustments.

When a fragmented packet is received and an attached XDP program calls
bpf_xdp_adjust_tail() to shrink or grow the packet, veth_xdp_rcv_skb() upda=
tes
skb->data_len:

drivers/net/veth.c:veth_xdp_rcv_skb() {
    ...
	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
	 */
	if (xdp_buff_has_frags(xdp))
		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
	else
		skb->data_len =3D 0;
    ...
}

Does skb->len also need to be updated with the corresponding delta when
skb->data_len is modified?

If skb->len isn't updated alongside skb->data_len, could skb_headlen()
evaluate to a size larger than the actual linear buffer? If the tail is
shrunk, this desynchronization might lead to out-of-bounds reads or writes
past the allocated linear memory during subsequent network stack processing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720140545.4617=
47-1-matt@readmodwrite.com?part=3D1
