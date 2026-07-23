Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA303C5DD4
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787068; cv=none; b=uWdFphF7QeAD40gnuV010xN15nFiQ8NXWnHQ3p/B0l/CGykgrdgaQsnPzwYhZHZuX9yKw6MMuIiIw6h5HK6xrXXrZKXEBe2ijHxJHtphgpm0MXCjJbbvhdNpYH8v9kfgZLIIJrGhJlJx8noLIxneefgQA5OvoMsHd2SmMdw0h30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787068; c=relaxed/simple;
	bh=U6kpdJaGL5VwDrJJbwyhOIlnERU4ndv+RRpNSuviHPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tBH7OE+/UdUitOZyvPTuxEqeD1XCte5ealSRDAw9N9HGtbp9lzqUInMPZvaHpZr8vXdwXhMPn0ARHq5IrEnPlfvyS8bgIeopFJfGya2P6xVuQ9EPp3+zxHHkke80oC76PvOvlnuDjzVvdx82IEgzkAcE3HBpBTatpJYXS3ciAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxeTiT20; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxeTiT20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DB31F000E9;
	Thu, 23 Jul 2026 06:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784787065;
	bh=uKJ6GrFOpNoGspG5Qr9Hm4tA5CgsJqNw3Mt6Teo7Wts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WxeTiT20R5F3GIWD6FeTPVrVV8wB7dZqQsbsBfWDPWmUxwQdLXd5Rs+wmAnC0mc2l
	 Q13eBnz2/wzl34xhjhOwKJJlS6yJP4UoJ32m/IfSeI0siqbg8tiKtzyxrwiYiZ/f2l
	 NumqA1vUw8XvmQ9bT963sBaZxH6mEkR1jEW6wboLEJYvmito05T+NPxGuw6zyWUxGJ
	 L2SUvAsCexL/mBJnf2DkV3pHUKN0C7wk2U/D81Iv7o254jCyAjoxvSAStGeid0/BHa
	 b7sgSqrZcFsSsMhU/e+H2HnUKqQ23FmeOq86Kk6VgrGtud6IGvsb6gw3cazFoSp4Xm
	 r57/NiQ+NYxzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: normalize arg_track state construction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Yu" <tao1.yu@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723055508.1403247-1-tao1.yu@intel.com>
References: <20260723055508.1403247-1-tao1.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 06:11:05 +0000
Message-Id: <20260723061105.B4DB31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The helper `arg_track_imprecise()` leaves union bytes uninitiali=
zed, failing to fully resolve the KMSAN uninit-value bug.
--

--- Patch [1]: [PATCH] bpf: normalize arg_track state construction ---
commit 66a3cf2cd9455714944be22e6ff4f7ab5a037e76
Author: Tao Yu <tao1.yu@intel.com>

bpf: normalize arg_track state construction

This commit introduces explicit helper functions to normalize arg_track
state construction and address a KMSAN uninitialized-value bug during
liveness analysis.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 0aadfbae0acc5..58b979c17c3e4 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> +static struct arg_track arg_track_imprecise(u16 mask)
> +{
> +	return (struct arg_track){ .mask =3D mask, .frame =3D ARG_IMPRECISE };
> +}

[Severity: Medium]
Does this compound literal leave the remaining 6 bytes of the anonymous uni=
on
uninitialized?

Since the union contains both an 8-byte offset array and a 2-byte mask,
explicitly initializing only the mask member leaves the remaining bytes of
the union unspecified.=20

When this state is returned, such as from fill_from_stack(), and propagated
via arg_track_join() during liveness analysis, won't KMSAN continue to
trigger warnings when the structure is copied by value?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723055508.1403=
247-1-tao1.yu@intel.com?part=3D1
