Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60545393DC7;
	Thu,  1 Oct 2026 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869757; cv=none; b=bRa0ldwGK0n7oXvFCQYDaUYWXhHblBYVvbi4e9KMNxAQmkJri46zNwxMeB1p6KEUWcgmHiBFs7NY+CQmHGpKkS1CCwPu4QSOWDpQWC7wWZWU7TtDcvszGi4Kk6BW/peCRs3M2KaIaCGvnlQZLNplM4LxJgYbzk/kv8DAJUmZbHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869757; c=relaxed/simple;
	bh=UOGEoGKjLLoCN6nnoamLYdxFkHEXI4z9zIB/nIHcIoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CsaTx9gfzkttYHVOL1x8okvq0Tm+H9TwqcPPv//whNokjuX1ONuEdVhr0wgCWlWC2c6Eyv7MkCbpHnZokAisr6Nob9n84gLzeQdhj+rZxzFW7pi8nWjtYPukoz8rfXAnzJ8syge1YbIFMS/t+inVi5Qeca0mP8fc+RNWKy6sFAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omRHk8Oe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omRHk8Oe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D291F000FF;
	Thu,  1 Oct 2026 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869755;
	bh=5pJ+Sk87/n/chH0hTVnTbn2E6uyDaO1sZjjaUdGA3bA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=omRHk8OeaZppyORocRW7PA2igG/7cJd9aDkY0Z36/LUjvlhrA98m56pro6DdDHHtd
	 FEsS99hmdC3/3oizK6uYgpsqdRt526326Imsk2saTvYi8AKDlmkNSHS2dP4szkC2p4
	 DNAI1oyrYsvtR5eO4RZ8fpSooi615Xn5dAeWAugy6/iCwOHwJXvk+pAYPqzzemsGLz
	 GVDIzkhn/l42Satv/SxusPZw1O7VbZrtoTUZa1029shV0qR0diEDwGZ50oyYwNRQ3Y
	 cE+L5X22MdVjYZFJWZ1+L53gOBPUnLid1CKXxEaKvOnL+xfRfKpXqxEJ/X85KurRmd
	 KTlfa5S3xNrOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/15] tools/rv: Define CONFIG_X86_64 statically for
 BPF monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261001152042.124445-12-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-12-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:49:14 +0000
Message-Id: <20261001154915.07D291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rv: build failure from #ifdef inside LIBBPF_OPTS macro
--

commit a53c9f566aefb8c15a1d5a3745ce6829be8b1a7a
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Define CONFIG_X86_64 statically for BPF monitors

This commit statically defines the CONFIG_X86_64 value via libbpf open
options to bypass system Kconfig dependencies. This ensures reliable
loading for the rv tool by defining the architecture at compile time.

> diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification=
/rv/src/bpf_monitor.c
> index 9a3f00febfeb2..d43ee75d3904f 100644
> --- a/tools/verification/rv/src/bpf_monitor.c
> +++ b/tools/verification/rv/src/bpf_monitor.c
> @@ -719,7 +719,16 @@ static struct bpf_object *open_bpf_monitor(const cha=
r *path, struct bpf_monitor_
>  	struct bpf_object *obj =3D NULL;
>  	int res;
> =20
> -	obj =3D bpf_object__open_file(path, NULL);
> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
> +		/* Define statically as arch is known, Kconfig may not be available */
> +#ifdef __x86_64__
> +		.kconfig =3D "CONFIG_X86_64=3Dy\n",
> +#else
> +		.kconfig =3D "CONFIG_X86_64=3Dn\n",
> +#endif
> +	);

[Severity: Low]
Does this #ifdef block inside the LIBBPF_OPTS macro invocation cause a
build failure?

Embedding preprocessor directives inside macro arguments invokes undefined
behavior according to the C99 standard. Clang explicitly rejects this
pattern (-Wembedded-directive), which leads to a build failure when
compiling tools/rv with Clang.

> +
> +	obj =3D bpf_object__open_file(path, &opts);
>  	if (!obj) {
>  		err_msg("bpf: error opening object: %s\n", strerror(errno));
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001152042.1244=
45-1-gmonaco@redhat.com?part=3D11
