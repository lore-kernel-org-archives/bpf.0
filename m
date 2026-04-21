Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033F35C193
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770005; cv=none; b=G0Pd3SEX3UWCxZIoJArJFCFdQEQr51bOukeDUzGWKi4hO3gH9+z/Cl4dgQjuXctDjN0ERrVxK2UKdYpulyD/S02Jmujd7pNuajUyfjLSeNGqx8dIPPVLNgkQqJar+sPO5QK0gA5OSlqKhzEFsEkRAS7/mvqt3MWOopQhymeY6s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770005; c=relaxed/simple;
	bh=lH+61DXYdj5W8uY9OQCRRyzuoPGchFxI/oD15zsqu90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YeI1tolqRXskafl3YajvCVhff8tmAmap5ejgvnkrTXz5AM0C3xWP7IvZKbBFveIdC461dQ2/0hxh71BOCRy+y1sjQWA8CS+f1bmitYBxvESkj25pmMBUFvKfnNdmEcVRKQBVrkkVO/At46GLzSdgvHJo/lJFJnicCarzuGJyBLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiSGH/o7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiSGH/o7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4A7C2BCB0;
	Tue, 21 Apr 2026 11:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776770004;
	bh=lH+61DXYdj5W8uY9OQCRRyzuoPGchFxI/oD15zsqu90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PiSGH/o73gTtpzEG4dH4/E6N/FfwSn+FaU0KvdmnWedvh/caEbCFay3+8/CWAeCjc
	 /qntrOpFraPfUzcimQcYtxN0Bs0mX/ZU2Cr4bt/L+szCgmArRRaxP06XzFFTO6ocMe
	 Wjhp6IGhvvzeYK/tIm6aLrAhW+sbyIpzEoFtyNOo4qsthTOVuuVmY7nAnsselt9DCy
	 FrMLmAXqKbPu/xe0Fg+oQtkOQ+GAOWGsV9idMLotXBvE/GImEq0KbMDvNruggkTOUU
	 dXQ3pPFsszCzKIX2TJgiu3rzqfgjWkddg2swDxJGfL6Fh7OvhvEkBmTBq8MlpGTYl9
	 dT3WW2bSg1q0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 5/6] selftests/bpf: add icmp_send_unreach
 kfunc IPv6 tests
Reply-To: sashiko@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420105816.72168-6-mahe.tardy@gmail.com>
References: <20260420105816.72168-6-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 11:13:23 +0000
Message-Id: <20260421111324.6B4A7C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Hardcoded little-endian value for IPv6 address comparison causes=
 test failure on big-endian architectures.
--

commit 27121b4497956027b4ace73b50126b8070a214c3
Author: Mahe Tardy <mahe.tardy@gmail.com>

selftests/bpf: add icmp_send_unreach kfunc IPv6 tests

This commit extends the existing IPv4 icmp_send_unreach kfunc tests to
support IPv6.

> diff --git a/tools/testing/selftests/bpf/progs/icmp_send_unreach.c b/tool=
s/testing/selftests/bpf/progs/icmp_send_unreach.c
> index 6fc5595f08aa9..112b9cbfab6fe 100644
> --- a/tools/testing/selftests/bpf/progs/icmp_send_unreach.c
> +++ b/tools/testing/selftests/bpf/progs/icmp_send_unreach.c
> @@ -6,6 +6,11 @@
>  #define SERVER_PORT 54321
>  /* 127.0.0.1 in network byte order */
>  #define SERVER_IP 0x7F000001
> +/* ::1 in network byte order */
> +#define SERVER_IP6_0 0x00000000
> +#define SERVER_IP6_1 0x00000000
> +#define SERVER_IP6_2 0x00000000
> +#define SERVER_IP6_3 0x01000000

Does this hardcoded value assume a little-endian architecture?

Since the IPv6 loopback address ::1 in network byte order ends with 0x01,
reading the last 4 bytes as a 32-bit integer yields 0x01000000 on
little-endian systems, but 0x00000001 on big-endian systems like s390x.

> @@ -16,17 +21,46 @@ int egress(struct __sk_buff *skb)
[ ... ]
> +		if (ip6h->daddr.in6_u.u6_addr32[0] !=3D SERVER_IP6_0 ||
> +		    ip6h->daddr.in6_u.u6_addr32[1] !=3D SERVER_IP6_1 ||
> +		    ip6h->daddr.in6_u.u6_addr32[2] !=3D SERVER_IP6_2 ||
> +		    ip6h->daddr.in6_u.u6_addr32[3] !=3D SERVER_IP6_3)
> +			return SK_PASS;

Will this comparison fail on big-endian systems, causing the BPF program to
erroneously ignore the loopback packets?

Could we use bpf_htonl(1) or similar here instead, so the test passes
regardless of the host's endianness?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420105816.7216=
8-1-mahe.tardy@gmail.com?part=3D5
