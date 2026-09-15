Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A82430CE3
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492758; cv=none; b=CC/L4z4OD1w3aDIp1xkkkXOnyQXcZPNQz/Vn0HOtD5rUsgunICXGIcbmjmcDOoJqquYBiw7PBGHJ4TdLqkIEVeZNNQvQCp5s3iPDfU9201Tic/IgEu/wwDn8910xoZIhLY0Ud7Wd77FvKPlolTjJ6f4gKTE26oIRDpTiPmxx9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492758; c=relaxed/simple;
	bh=qfvSp4m9II/+j9uuZPxAlVZkkqj5lLQn4/iWmZBrtnI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=liNT4wRmh41lOtOwxcX080WzCpdGmCBM5PNKitPZqCIc+7OvWtKDxb/j8cNIUD1bAVE+mwEJ6kFy/WUwVae2RU2DqF3omVqkkyP9c1TueWikrWmFfqS4bmy7Dt8cJ0XKogQAqK46/Se/u6vcGYt4XQfIq+OMGKh1PkauKX1D51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9AJ581z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9AJ581z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBB11F000FF;
	Tue, 15 Sep 2026 17:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789492756;
	bh=WYiHqNxDHD1q0zJIhg0QW3yTfYOO17Aoiukh5TjTOAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9AJ581zFzetxPRTI7kBT5omFnJkdAKRw49hS5zyTt+3tUUPDk0EXa+epcISVPpKA
	 ajprWgSVPt8FF6VtamwsCRCzGCCroxJ9GadW+ybwM2AydJIVMb2pZwqiBLW4OaEsz5
	 BBpIMSXy72b8Dx6aZC4W8OUctaU+G+Lr2eT3SnP24ViL1kFC9zOl0qDW43AnUgqOX3
	 pGsii0hynrFjWr7HfXJPqRY9Hm1uayMO3fw62fjRFHSwmAsQmoaF1t9r7RCFjB13Sh
	 HPKDMx5s1ifWnuxCHFCEyINGAmm8raeRT+qx7cAqkhRfMqEs29lP+i7fsidyr2UEgC
	 NULHQK5Wj5IQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: clear stale IPv4 options after LWT encapsulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260915170147.3943392-2-bestswngs@gmail.com>
References: <20260915170147.3943392-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 17:19:15 +0000
Message-Id: <20260915171916.5BBB11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: incorrect SKB CB state when cb_access is false
--

commit 81b40ecbc1d9468e9497a57756458b9bd7e91f03
Author: Xiang Mei <xmei5@asu.edu>

bpf: clear stale IPv4 options after LWT encapsulation

This commit addresses an out-of-bounds stack write caused by a stale IPv4
header length being interpreted as an option length. It tracks active LWT
runs and resets the control block state to preserve consistency across
nested runs and protocol family changes.

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -80,6 +80,31 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf=
_lwt_prog *lwt,
[ ... ]
>  	bpf_compute_data_pointers(skb);
>  	ret =3D bpf_prog_run_save_cb(lwt->prog, skb);
> +	lwt_ip_encap =3D ri->kern_flags & BPF_RI_F_LWT_IP_ENCAP;
> +	ri->kern_flags &=3D ~BPF_RI_F_LWT_IP_ENCAP;
> +
> +	if (lwt_ip_encap && ri->lwt_ip_encap.cb_access)
> +		bpf_lwt_reset_ip_cb(skb, ri->lwt_ip_encap.cb_proto,
> +				    ri->lwt_ip_encap.iif,
> +				    ri->lwt_ip_encap.l3slave,
> +				    (ret =3D=3D BPF_LWT_REROUTE &&
> +				     lwt->prog->type !=3D BPF_PROG_TYPE_LWT_OUT) ||
> +				    (ret =3D=3D BPF_REDIRECT && can_redirect));

[Severity: High]
Does skipping the control block reset when cb_access is false cause issues =
if
the packet is returned to the old protocol handler?

If a BPF program with cb_access set to false changes the IP encapsulation
family via bpf_lwt_push_ip_encap() and then returns BPF_OK, it seems the
original protocol stack could end up reading a control block formatted for =
the
wrong protocol family. Could this result in corrupted packet delivery state,
such as lost routing flags like IPSKB_L3SLAVE or reading a zeroed nhoff in
IPv6?

[ ... ]
> @@ -669,6 +740,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
[ ... ]
>  		skb->protocol =3D htons(ETH_P_IPV6);
>  	}
> =20
> +	if (ri->kern_flags & BPF_RI_F_LWT_RUN) {
> +		ri->kern_flags |=3D BPF_RI_F_LWT_IP_ENCAP;
> +		if (!ri->lwt_ip_encap.cb_access) {
> +			bpf_lwt_reset_ip_cb(skb, ri->lwt_ip_encap.cb_proto,
> +					    ri->lwt_ip_encap.iif,
> +					    ri->lwt_ip_encap.l3slave, true);
> +			ri->lwt_ip_encap.cb_proto =3D skb->protocol;
> +		}
> +	}

[Severity: High]
Is it safe to eagerly convert the control block to the new protocol here wh=
en
cb_access is false?

This appears to assume the packet will always be subsequently processed as =
the
new protocol. Since the restoration logic in run_lwt_bpf() is completely
bypassed when cb_access is false, this might leave the control block in an
inconsistent layout when the packet is handled by the original protocol han=
dler.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915170147.3943=
392-2-bestswngs@gmail.com?part=3D1
