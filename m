Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45001DE4FB
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297179; cv=none; b=L7SEXrNRD97Abl7Unsz0PnBJAs3ygkRfAM8+0eEqx5NZEC+ULmQddu1x1H1avs+3bqt/HIbUAe5jskpRq5dSN3IJJkr2GNZZem6vqqw/BxzdvM/5vwRXp/Jeb2H35bmYvVGG6jTULFL9L5gT0Z1/UojAMj38RCK+ffp5eEhfk0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297179; c=relaxed/simple;
	bh=cWBzPNGvmLPsCF7Xu+ou5pZaT22rZHNLy7WFMxIooS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JZhhRc5NN1OxjVcuFcEDEHFZtwSOzzullH7DF46eknlDcZ1M/t3Lt9vEyeXNjAjUFRcooR3T406Dh3M6csADzJ9US1wplzc/7ZLbkOGLEMP2aZQNUthQACf5TixxQHZUIDefCuFpOv9/Pi+y61u0h3+ofxd6BTx115JMDwle/uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwNvvc/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwNvvc/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7287E1F000E9;
	Wed, 24 Jun 2026 10:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782297178;
	bh=RKB03lm9q30rIVvOvnvRCMnQ7P9DT0qVm7fdecB6zsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IwNvvc/8in+iLsV+Ddi67WAXCOYGt8lHHteW+5GGqjIiX1//HtxL3frMoFWP+f+vj
	 HS3kBuqGNW36gQovNpTztOtNDyuqub6/mLtUnRhPRyF4LemxaMCs5x2/bDvtl34/8g
	 lnc4tJQFM88r+CBYuvO20bdf/lTHEb9DgFt8Lhw5TLVlFxX8O2AjqArx6kqVBeYwsJ
	 hIeC9GWr40ImXxVm1xhK0pME0OcnPtFI9Fhe/ckwgbE5GDm7rB/QF5zID93op8WQju
	 TxoWZ21gvp+B++lvyc057abQaQNt7KNoLWla4w4TlDj6NsqwLH2VwuGhwO+g4ZycXv
	 poy01goe7tRMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] seg6: validate SRH length before reading fixed
 fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623-f01-17-seg6-srh-len-v2-1-2edc40e9e3e1@mails.tsinghua.edu.cn>
References: <20260623-f01-17-seg6-srh-len-v2-1-2edc40e9e3e1@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 10:32:58 +0000
Message-Id: <20260624103258.7287E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A Time-of-Check to Time-of-Use (TOCTOU) vulnerability exists when =
BPF helpers pass user-modifiable BPF memory directly to SEG6 encapsulation =
functions, leading to out-of-bounds reads and kernel information leaks over=
 the network.
--

commit 05b380962874b4a6f9423731237517670aee7b1f
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

seg6: validate SRH length before reading fixed fields

This commit adds a minimum size check to seg6_validate_srh() before reading
fixed SRH fields. It prevents an out-of-bounds read when a BPF program
supplies a length shorter than the fixed ipv6_sr_hdr structure.

> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index 1c3ad25700c4c..62a7eb7792026 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -29,6 +29,9 @@ bool seg6_validate_srh(struct ipv6_sr_hdr *srh, int len=
, bool reduced)
>  	int max_last_entry;
>  	int trailing;
> =20
> +	if (len < sizeof(*srh))
> +		return false;
> +

[Severity: High]
This is a pre-existing issue, but is there a Time-of-Check to Time-of-Use
(TOCTOU) vulnerability when BPF helpers pass user-modifiable BPF memory
directly to SEG6 encapsulation functions?

If a BPF program uses bpf_lwt_push_encap() with a buffer originating from a
BPF map, can a concurrent thread update the BPF map value between the
validation here and the later execution in __seg6_do_srh_inline() or
__seg6_do_srh_encap()?

net/core/filter.c:bpf_push_seg6_encap() {
    ...
	struct ipv6_sr_hdr *srh =3D (struct ipv6_sr_hdr *)hdr;

	if (!seg6_validate_srh(srh, len, false))
		return -EINVAL;
    ...
}

If osrh->hdrlen or osrh->first_segment is maliciously modified after
validation, could this lead to an out-of-bounds read and kernel information
leak over the network during memcpy?

net/ipv6/seg6_iptunnel.c:__seg6_do_srh_inline() {
    ...
	hdrlen =3D (osrh->hdrlen + 1) << 3;
    ...
	memcpy(isrh, osrh, hdrlen);
    ...
}

>  	if (srh->type !=3D IPV6_SRCRT_TYPE_4)
>  		return false;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623-f01-17-seg=
6-srh-len-v2-1-2edc40e9e3e1@mails.tsinghua.edu.cn?part=3D1
