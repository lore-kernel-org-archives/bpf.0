Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEDE3C3443
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847641; cv=none; b=BwtvXfC/HWLUl2IwiBMfCHsXUWyW1RQSL9RaYejSsf8WC8vMIhHIdFTgspD1fLNuSMzZXCxCFVUj7mBQ6TroftzbOeW9ViiJ9sKkBlLf6TU4k2umf8pcEfxeNNcbILuilMSCWGkKZyc3dZIV3VMYmHIqk7B7sAoL/ONMtJwk0dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847641; c=relaxed/simple;
	bh=B6nAcbzf7qcwbZ275fkjBhRhWbFtTJdRl2zx6Y7ueR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uTCahwN2pks+cvDrrCseOSu2RtWB/AuHDaQQUTzNKY3zmucxLw9Elqk9B8Kb+y/iHZKqjkc52893cHpTA1vjq7fuGeMB1GiD2bBP6Y0jIEoIFHlVhF5Lnmiw8WyrNfEBUsjvH05nFe+SL8/HlCyY82ErFixAubm76nxYqEar58c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSAXut2x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSAXut2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832DB1F00A3A;
	Tue, 30 Jun 2026 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782847640;
	bh=1Sv6JTvV+Qnq51faPVwH8GZDpljXVRSjMX9cWXFiZRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DSAXut2x/z8RK+477ryUIOqT9YI2T5kf+utq/Eow6JbPFpILGdhPxYo+2kWIY/h9N
	 08ZW1+lIaOnzp1J2P4WCTNLS1lHjdDDMzyIf+t4ucmhVXxUt2d/gZBeEfC0ueUHRTE
	 /zCSM28cWG7hXZwhqF1xkESrRciGzoDNeLutyhOu17nfp9sPLNJl3IHOcBpfvAQCSz
	 q4GAhFYORgHYK/ce2yIjpM8XzActGwmnXCBf4ToumoZVkf2tsEKE8r/YDnxHvv8Vle
	 RaYn4wBY0PomDQ7J1SB/f6xaeUETvkiLDoy49l8CC0l1qKys3Q3veaDjOifCw3VB8j
	 Dfp9pvYOcpvlA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 7/7] selftests/bpf: cover
 bpf_xdp_metadata_rx_csum in xdp_metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Vdovin" <deliran@verdict.gg>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630191510.81402-8-deliran@verdict.gg>
References: <20260630191510.81402-1-deliran@verdict.gg>
 <20260630191510.81402-8-deliran@verdict.gg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 19:27:19 +0000
Message-Id: <20260630192719.832DB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added multi-line comment in `verify_xsk_metadata` violate=
s the BPF subsystem comment style guidelines.
--

commit f8507da4f2875a0c3ae86814a72a21202665e4a5
Author: Vladimir Vdovin <deliran@verdict.gg>

selftests/bpf: cover bpf_xdp_metadata_rx_csum in xdp_metadata

This commit updates the xdp_metadata test to call bpf_xdp_metadata_rx_csum()
and export its status to userspace. It then asserts the expected checksum
status depending on whether the frame was injected via AF_XDP or sent
through the stack.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tool=
s/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 5c31054ad4a4c..77f55696eb786 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -310,6 +310,16 @@ static int verify_xsk_metadata(struct xsk *xsk, bool=
 sent_from_af_xdp)
>  	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
>  		return -1;
> =20
> +	/* veth surfaces the checksum verdict from skb->ip_summed.  A packet
> +	 * injected via AF_XDP carries no checksum context and is CHECKSUM_NONE,
> +	 * while one sent through the stack is CHECKSUM_PARTIAL and reads back =
as
> +	 * verified.
> +	 */

[Severity: Low]
This isn't a bug, but does this comment format match the BPF subsystem
multi-line comment style guidelines?=20

The BPF subsystem typically requires the opening /* to be on its own line,
rather than sharing a line with the first row of text.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630191510.8140=
2-1-deliran@verdict.gg?part=3D7
