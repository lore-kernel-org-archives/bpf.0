Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCBF3CF665
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368494; cv=none; b=dMVtxv+wBrMGIH3Ld01T+UDYu+jPWpjGiVakIRHyivvAtHcQ0zvFAS2BGwXywqL/ljMums7Ro/uBYzsmowiM126ZO7gBDuGJAYqGGijZky+tqXheai6CO2E3iR3ScDTnYOy6Xx4Gt+TcKiZ57s704sMJ2QX+T8ZVsb6wKDbr1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368494; c=relaxed/simple;
	bh=koy6cT9xKynLcGN+SJtmmJh6g08wiZF2foTNsZgBhOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hUF1Nnr/ZuKm1vpZeK06rHqh9VqEl1E5vwtIXZqIxmd6+JMxcjLfeYe5Mhohhu0WYaTBHcFEom8a9ju77eu9X/SwBWuZ6J1DC9/tKGT+Jix/puq2rIcxI/1K7Xjd0w3H9ZH2UyPGpS7JjIdr0nFMyGsqixv66h+SbvBNsYPJ/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFn2amG5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFn2amG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2FC1F00A3B;
	Thu, 21 May 2026 13:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368493;
	bh=GtflNjxmO6DiCle6ClS9hXcjBlW2g9jUzko8KIj3gIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TFn2amG52V6sP8DCFD3H6kb4hJcYYrUY7YT3MjGAJEzElf/1H3w3fTz+x8h5oL5ig
	 g/9FrPKTYLWisLsM+jPFg11PoSZpfGPCFI/Ds/xbuj4KC5c0HtJ4YsuT3+9YqIRgqJ
	 rjy/d+NcKCjPTjk11A4mmDTQkeYnwdVUcxnlY1AXdwMKkQ9oGqNs4UqLipU/YJidl1
	 5Ts2nk+e69eCkCQTTT/0GUePzORcX0K1cEJUpZwP081VFr/M3eQSOHoXR2fwFTh5UJ
	 7aib6Y7CDvnpsHMAj9un13QChyStnkzLPm489pAQvw9FkVzGYqBNEsSYgNDNun3Opu
	 bViF8kOK1iHhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 05/12] libbpf: Change has_nop_combo to work on top of
 nop10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521124411.31133-6-jolsa@kernel.org>
References: <20260521124411.31133-6-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 13:01:32 +0000
Message-Id: <20260521130133.1A2FC1F00A3B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Replacing the 5-byte nop check entirely with a 10-byte nop check=
 silently degrades tracing performance for existing compiled binaries and c=
auses BPF selftest failures.
--

commit 9ee5f26b2092c13d658ca6962b0ca9bbe4cfe44a
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Change has_nop_combo to work on top of nop10

This commit modifies the has_nop_combo() function to detect an 11-byte nop
sequence rather than a 6-byte nop sequence to optimize uprobe handling.

> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index e3710933fd52a..484a4354e82ba 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
[ ... ]
> @@ -596,14 +596,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, =
const struct usdt_note *note,
>  #if defined(__x86_64__)
>  static bool has_nop_combo(int fd, long off)
>  {
> -	unsigned char nop_combo[6] =3D {
> -		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> +	unsigned char nop_combo[11] =3D {
> +		0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
>  	};

[Severity: Medium]
Will this drop support for older compiled binaries and cause BPF selftests
to fail?

By completely replacing the 5-byte nop check rather than supporting both, it
looks like legacy binaries will silently fall back to unoptimized uprobes on
the first byte, which could degrade tracing performance.

Additionally, tools/testing/selftests/bpf/usdt.h still seems to define
USDT_NOP using the 6-byte sequence (0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00).
Could this cause subtest_optimized_attach() in prog_tests/usdt.c to fail its
assertions, since the +1 offset for the nop5 instruction will no longer be
applied during testing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521124411.3113=
3-6-jolsa@kernel.org?part=3D1
