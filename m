Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566AB35A3AE
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777954472; cv=none; b=mT6EhodSqziEFZC4fYJAymnVpQMa/QoJZT56JQV2df/ujVoxjCgbIbsuBV5+UKBfRCH8L5wr7OiKjIbeV0bK8C3i/+e7d8aFx16vvod8YDS+vQrnfC4qI0NwlBvqrruDUqBIrICUf0Z0XMmIBPRfdaQBzrpi5vgVbATAW1tihiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777954472; c=relaxed/simple;
	bh=J8ZHnWTVGSMJKFXv1kPKiRu7wzbnnopVtNqtbZV9bFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dKc9DDd1+nAvjva6yfIS0q9+Hvi36AWsWaIF42KQ8HWytJMxuko+iiBAwtkiuMR6ZJOGG8WZr3tsa4NS2enO1UiymRyxIZlWPwxldQfeSHfHmQeTfeSQD+/Iq6Yfdf2xQ2gXntpewn3PrQjQ7SvUJdtHRzENy9nFXnKBDwiJWbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpX9183K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpX9183K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD280C2BCB4;
	Tue,  5 May 2026 04:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777954472;
	bh=J8ZHnWTVGSMJKFXv1kPKiRu7wzbnnopVtNqtbZV9bFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lpX9183KFew3B+3WpDdCuOrUDfCtFjsiXiKlxRhNn0uJGIq8WrlrlRcWLPhCGK6Qo
	 KQxlovtNApubvEWEEZWU7+0abPfCbFepeXYfJgUO/FaN3onskeFdH+9Mwff/bKBPqX
	 KmqNN8UPOi+M7f7ASA8HPk4cYnPKptUmUXum3DbgFiIEMGTWj5Oe+GTvB3kWNZSQje
	 SMNsQiAvfAs8mCbN3eDaQ10szxGCkFCyEG62c7OwUcfaQehEWAaPkww/TAHyEO9RmE
	 r/AdL2oavJSP6Cdsg6jwiUh26xvMuxlCoQTUgo3DflEh6s3tYRdR7cRVjk5TbBwAM3
	 WdDJhfcbcIbVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] selftests/bpf: tc_tunnel - validate decap GSO
 and encapsulation state
Reply-To: sashiko@lists.linux.dev
To: "Nick Hudson" <nhudson@akamai.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504101759.3319427-7-nhudson@akamai.com>
References: <20260504101759.3319427-7-nhudson@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 04:14:31 +0000
Message-Id: <20260505041431.CD280C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Pointer arithmetic `kskb->head + kskb->end` causes build failures =
and runtime logic errors on 32-bit kernels.
- [Medium] Missing kernel feature causes test to fail instead of skip, brea=
king CI on older kernels.
--

commit f73fb4725baa7b601a1b82c32e5095c6b4294f5c
Author: Nick Hudson <nhudson@akamai.com>

selftests/bpf: tc_tunnel - validate decap GSO and encapsulation state

This commit enhances the tc_tunnel selftest to validate post-decap tunnel
state for both GSO and non-GSO packets, and checks IPXIP decap for IPIP/SIT
paths.

> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/t=
esting/selftests/bpf/progs/test_tc_tunnel.c
> index 7376df405a6b..853bca962910 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
[ ... ]
> @@ -621,6 +645,11 @@ static int decap_internal(struct __sk_buff *skb, int=
 off, int len, char proto)
>  		break;
>  	case IPPROTO_GRE:
>  		olen +=3D sizeof(struct gre_hdr);
> +		if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
> +						BPF_F_ADJ_ROOM_DECAP_L4_GRE))
> +			return TC_ACT_SHOT;

If the kernel is missing support for these new decapsulation flags, will
returning TC_ACT_SHOT cause the test harness to time out and fail the test?

Since selftests often run on older kernels, should missing features gracefu=
lly
skip the test instead of failing it to prevent false positives and CI
breakages on stable or LTS branches?

[ ... ]
> @@ -655,6 +688,40 @@ static int decap_internal(struct __sk_buff *skb, int=
 off, int len, char proto)
>  	if (bpf_skb_adjust_room(skb, -olen, BPF_ADJ_ROOM_MAC, flags))
>  		return TC_ACT_SHOT;
> =20
> +	kskb =3D bpf_cast_to_kern_ctx(skb);
> +	shinfo =3D bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info=
);

Will this arithmetic work correctly on 32-bit kernels?

On 64-bit architectures, sk_buff_data_t is an integer offset, so
kskb->head + kskb->end works. However, on 32-bit platforms, sk_buff_data_t =
is
a pointer (unsigned char *), making the addition of two pointers invalid C =
and
causing build failures.

Furthermore, even if cross-compiled with a 64-bit vmlinux.h, adding
kskb->head to an absolute kskb->end pointer would yield an invalid address =
at
runtime.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504101759.3319=
427-1-nhudson@akamai.com?part=3D6
