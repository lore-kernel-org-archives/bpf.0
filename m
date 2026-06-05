Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223C3BBFD0
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639270; cv=none; b=G0C1V8uendVecDJO26XReM+lCV+y2Qp5A0OBEdRTn13E+47fCsvlX1CUXuLsrCsXsySzNt398XVzd2QrgEKWe7khZ889ya0XdkD18+T72ze4RpYCJ8YRJSVIJvImG7FBrgYKUzXmMuvxNKeJu2MiySSCwn61tZU9duog2QjZ0G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639270; c=relaxed/simple;
	bh=4UPF+yynoFAX0CC69nDOBHvbvcJ3N3raIQWxwYxlSoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SuZi9x96AWsU2BzkWpA9I21G15plE/k3Av1tY/4RLi431wzEnTjouGz4GY2FfEY+QDNHfrTakr70KtgBCREXx8XhkpelGIiGvKIREXhOIBSzSEvGCyEkHrbSWua4a49zzMfVM+ui4TiOGl1DcPeCaGHwmKkyNFADIw8Tc4Az644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFAtoCBQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFAtoCBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8741F00893;
	Fri,  5 Jun 2026 06:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780639269;
	bh=gjVslxgtRhD4//xChXg5cSRPWOnohDqfCkn+xx4JwZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XFAtoCBQt3xm6iYdk+l4E4ReaRX6U1BvRv4ti7dAYsKBtXtkvWyys/lqw0bAMM2Z0
	 d/P01g5Ayfy+98+4w7g8LzpZo2F4fs0dQqHlELF82FBF8mxTq4FwUTCEIoYrj37Ag2
	 BU9akkkyDFcUprieZKI71WHfsSyTcAXMKgA+LE7ymz/Pjv7goSsN4gz7JltZCZwWza
	 zRPjMeGbR5jhY3Qb93eHGO+Aw8B/oqGAkPwDVMY74ZDVikZkmxg8QJ5GDLz/e9luBH
	 wTjYtZsSaDjcgSj8R2kWtpRzROsjY79wcyEJLTet2YQco+Fz/1Nd1PflB9hrRev1jv
	 SjAnxsxKxJMyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/13] preempt: Introduce HARDIRQ_DISABLE_BITS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Boqun Feng" <boqun@kernel.org>
Cc: ojeda@kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260605054128.5925-3-boqun@kernel.org>
References: <20260605054128.5925-3-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:01:08 +0000
Message-Id: <20260605060109.3B8741F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NMI nesting inside a hardirq causes `HARDIRQ` count to overflow in=
to `NMI` bits, leading to permanent `preempt_count` corruption and a kernel=
 panic.
--

commit 81acab4bc4267e8b9061bcb43c1763c01ce614f2
Author: Boqun Feng <boqun@kernel.org>

preempt: Introduce HARDIRQ_DISABLE_BITS

This commit changes the preempt_count() layout to contain an 8-bit
HARDIRQ_DISABLE count to track interrupt disabling nested levels. This
supports preempt_disable()-like interrupt disabling.

Link: https://patch.msgid.link/20260121223933.1568682-2-lyude@redhat.com

> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 586f966883255..e2d3079d3f5f1 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h

[ ... ]

> @@ -31,29 +32,34 @@
>   *
>   *         PREEMPT_MASK:	0x000000ff
>   *         SOFTIRQ_MASK:	0x0000ff00
> - *         HARDIRQ_MASK:	0x000f0000
> - *             NMI_MASK:	0x00100000
> + * HARDIRQ_DISABLE_MASK:	0x00ff0000
> + *         HARDIRQ_MASK:	0x0f000000
> + *             NMI_MASK:	0x10000000
>   * PREEMPT_NEED_RESCHED:	0x80000000
>   */
>  #define PREEMPT_BITS	8
>  #define SOFTIRQ_BITS	8
> +#define HARDIRQ_DISABLE_BITS	8
>  #define HARDIRQ_BITS	4

[Severity: High]
This is a pre-existing issue, but does keeping HARDIRQ_BITS at 4 risk a
structural overflow into the NMI bits during deep NMI nesting?

Looking at __preempt_count_nmi_enter() in include/linux/hardirq.h, it adds
HARDIRQ_OFFSET to preempt_count on every NMI, and explicitly permits up to
15 nested NMIs:

include/linux/hardirq.h:__preempt_count_nmi_enter() {
	__preempt_count_add(HARDIRQ_OFFSET);
	/* Maximum NMI nesting is 15. */
	BUG_ON(__this_cpu_read(nmi_nesting) >=3D 15);
	...
}

If 15 NMIs nest while the CPU is already inside a hardirq (where the HARDIRQ
count is 1), the total count reaches 16.

Since HARDIRQ_BITS is 4, would a value of 16 overflow the 4-bit field into =
the
adjacent NMI field? It appears this could corrupt preempt_count and eventua=
lly
clear the NMI flags prematurely during exit, leading to a kernel panic.

>  #define NMI_BITS	1
> =20
>  #define PREEMPT_SHIFT	0
>  #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
> -#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
> +#define HARDIRQ_DISABLE_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
> +#define HARDIRQ_SHIFT	(HARDIRQ_DISABLE_SHIFT + HARDIRQ_DISABLE_BITS)
>  #define NMI_SHIFT	(HARDIRQ_SHIFT + HARDIRQ_BITS)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605054128.5925=
-1-boqun@kernel.org?part=3D2
