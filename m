Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443BB234973
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758615; cv=none; b=gfRXT0DS8ciyS0teY6B3I0lTWMgH/POsPf3UP/GHMDIIesZ0ADOLqJlTaBBOB28QU8Z63WTdDWQAlKN9+07hxsKiAQfcdkl8Sy957W9bG+H7xt29n+mKuCYK/ruXOydOGw6RzZsr/i+2ND/wMCYvPtSS24Aqm5ffOy9jK4MeJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758615; c=relaxed/simple;
	bh=w0z/NDoxIlaoOdZZdORv4xGwVgdTVe7SQGfoqffz2Mo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OKaCyvi8/zvJabFYEj8xU4vjnjJvgO9oHLyyNPqdXn/ugZmuWGYEIYMjS4fTVj2tz2nCj5Qqhyfc9bBSDg4MKOsXld2HIUnfCfsIuPRUgSLa5u0dMwyaPj9Q3jhRUQcQ/NpUv/mMwEu/Slg1pg0qyyk1+wQpwBlgphZd2Trao+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhOf7Pkk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhOf7Pkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC5F1F0089B;
	Sun, 11 Oct 2026 22:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791758614;
	bh=TQlzcIAfz5DCgzqvsgvtjKsYU5bWLPIzsRB/cfSohe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MhOf7PkkIAmSrWC6IyzUoutpl1PO1cRBCEehXy+Qf3tNJJSEWr9n62wzUmOCicyq2
	 Z/5+G0fF1TaFOmd2Y4RQpGxqI1I0DNuzRnRnPbgSlxZ7KsPJZI/I0eBqhL3P6MEQY2
	 8y+TB/joeTg3+cy2ZSB5L9sMNR8OD98hzKMX2QMilvBuSvVJTUOsNp5KeHuablSsIN
	 mCziZ8KPF5bSt9ZvvfMJmGSuJAC/RT3yhAlEPoE4xDaBUJTB+WYZdmyjMni/zvYGjG
	 Pp1WQnEp5GtlIGlAuSW2ww74n5UAuBfAnsjO5RXhixKzciRX7v6cf/yJgjszHzNBlK
	 H/qxeV1LNIy4Q==
Message-ID: <sashiko-outbox-167498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools/dma: fix building from the top level with O=
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261011223358.2327625-4-sashal@kernel.org>
References: <20261011223358.2327625-4-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 22:43:33 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] tools/dma: incomplete fix for out-of-tree (O=3D) builds
--

commit f9ebfb989b6d469df7135b7ea719817656f0b606
Author: Sasha Levin <sashal@kernel.org>

tools/dma: fix building from the top level with O=3D

This commit attempts to fix the out-of-tree build for tools/dma when using
O=3D<dir> by correctly setting the srctree variable. It ensures that srctree
is worked out even when it is empty or when building_out_of_srctree is set.

> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
> index e4abf37bf020c..b5fe6e2625eef 100644
> --- a/tools/dma/Makefile
> +++ b/tools/dma/Makefile
> @@ -7,7 +7,13 @@ bindir ?=3D /usr/bin
>  # isn't set and when invoked from selftests build, where srctree
>  # is set to ".". building_out_of_srctree is undefined for in srctree
>  # builds
> +ifeq ($(srctree),)
> +update_srctree :=3D 1
> +endif
>  ifndef building_out_of_srctree
> +update_srctree :=3D 1
> +endif
> +ifeq ($(update_srctree),1)
>  srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
>  srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
>  endif

[Severity: Low]
Does this commit completely fix the out-of-tree (O=3D) builds?

While this resolves the srctree issue to successfully locate Makefile.inclu=
de,
an out-of-tree build via O=3D<dir> will still fail immediately afterwards.

The default all target depends on $(ALL_PROGRAMS), which correctly expands =
to
include $(OUTPUT) (e.g., out/.../dma_map_benchmark). However, the explicit
build rule for $(DMA_MAP_BENCHMARK) lacks the $(OUTPUT) prefix:

tools/dma/Makefile:
    DMA_MAP_BENCHMARK =3D dma_map_benchmark
    $(DMA_MAP_BENCHMARK): prepare FORCE
        $(CC) $(CFLAGS) $(DMA_MAP_BENCHMARK).c -o $(DMA_MAP_BENCHMARK)

As a result, Make will abort with a 'No rule to make target' error.

Furthermore, the compilation command places the resulting binary back in the
source tree instead of the requested output directory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011223358.2327=
625-4-sashal@kernel.org?part=3D1
