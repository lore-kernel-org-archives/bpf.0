Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7962290DBB
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775250521; cv=none; b=rRn900JFw84BhJ5B1fsz1WORGmx468ACGsQh6LKozLCxVqrIPf2DzinDwm6uW6Hnbceofu8z+2rLaxwJZuJsRTm6XM93jK/9xi7ZQDtClT4KXPq5zOfkMvfRQeX5+9HG6PEGoAX8T8iaiHR4NV7lSoXr9V/RdPFZS4dDqPVBl1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775250521; c=relaxed/simple;
	bh=sjrOcmBeonQeUKhF+7FaAXLL1ZCqKwAzenU3FPeT9aQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RftGctkO7bUDtgnzyfiwV28pcPhgYQeu7E2pG6zAoXEfNh/6fA5EhuoS/depCxTs1gVqs7XoRnfjxWKOs5gTfButTDEL9rpQvJAy+B2xyb3+nVhzF44Amr6sbJKZLf6KX0d7XVfXLEQDs5Bhsrfxx2ZsKJDdvkqGp0dFlcNo8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWAKprnX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWAKprnX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso19703725e9.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775250519; x=1775855319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rtz6zW8ohpnkRnnbqIqGqsqLu4coVv09fBIfiINDmEw=;
        b=NWAKprnXpeCbjmSke3StP87/3Jhk7PmdeZDTtAYiCRUddM0yZd3Y9Z+YMiADweIgPC
         dkmsg3csqg4mXabTpzqWt/aDpV6A7vQRnaNeSx5uLOOW3rSwgG5cmIYhcsj2wP9t0For
         yPwu/sOFjHze7VWqsNg7l+C596kBM/ZlHdQ8R7eqwVw21fkzjdy2kSRI8PkiUrxiDvDs
         /37dor3A+yH733mgx/vbXqQMJCr9lijNABaSb07HQ17hZpZ+UwsRL45js7I8rdA6RIWv
         G673ewd3ugMI4UvWJPvW5LkhsUVJLXgdeZNG2U9vRDlo8PEapIuJsTHLFSGrVB757OFu
         Ej4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775250519; x=1775855319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtz6zW8ohpnkRnnbqIqGqsqLu4coVv09fBIfiINDmEw=;
        b=FPBT+5Vm1aE5+AYa4M1sYP7juz2qpLnK6l83hIM2qMmqV2pdedN6uuC5csJvwLSKnH
         QlGV4H1IBMb94UEdc9T9hcCDFj5u4byvvKoSGpduHrXlinUskXUmaiR63qvkaXBDFNsn
         vVPQgpeg1ubrDAdDaYGEEXfX9gnFCe96TI4+P+CuKSiFyF43hG+AA9iSFOJCbbHftsx+
         n63MGeoCpNdE36RSRnLL/1+aKrpvK5yl4mcL5PB2o9xOh5ug2K2E62FVHVRJOdL5p/GO
         papCUAfTzNUnajhKbNyNyGkEwpwoljz5oDko9y8+N/5Z4blTIGo8NNp6aayFc2FjAh/Z
         eoWg==
X-Forwarded-Encrypted: i=1; AJvYcCWpMIFyhOZc1aHLau+riCHNFJNhaepN7+kssoI3znixxzonV5FZeQHHNYAIbQy46XZ4RDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycsnnk9eiGMoYDkq2ZN3KhljLbtzob6UNCVE/6YCcSZmnSh4UR
	s7gcHEjdWCNYIXBBKT9G0UhU0VtuW11G1NScNkIlkesnvR1A1UxgEuJZ
X-Gm-Gg: ATEYQzy3edf23L62wGrrHp7b1fn5OLRelHAevZ1JBnuT5dN141oea41so1ClrHImx6g
	A5YCTxe5hxHdhk3jIyDUYb1uLjf+G1s4xrTnmoTxQvdlfkaKpgEv4jFIitTdlxjj+aDsxN/zcuz
	2nrfFjcXKFoYY+C0hco3PJlG9bg3E3O8/XtqD/uQT+r4jhNIDNpFtmKwKcs663rCWtJKRRqzRV9
	9cinlLAOOez3PJACsnnc5gQnsXpJI73bYwcw5im34XE0bFmD0TOkAnwfmgf2DAEyISeGpF1izbe
	cSGXcJunIfZShPfpjMmf28JDTHHZpOcPE71dJ7uGrxyd/K8olKSB00LTjwgRdVYQhrDMSMX3sSz
	7iO5671vuWdxvmDIq2CkaSUlZEMLBPeeI3xwRuO4RV/HUwSFJ7sesJL2apJzM4sjqqzEpYvn/7B
	uuKC6WseXTc3rOYuqgPcqlJEhVPW1q7aBxH+GgfkapFT0qaOSWZLnFh0A=
X-Received: by 2002:a05:600c:5292:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-488997a51b2mr71073585e9.22.1775250518655;
        Fri, 03 Apr 2026 14:08:38 -0700 (PDT)
Received: from krava (ip-94-113-247-31.net.vodafone.cz. [94.113.247.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm18895321f8f.4.2026.04.03.14.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 14:08:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 3 Apr 2026 23:08:35 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
	dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 dwarves 0/2] pahole: add BTF layout encoding feature
Message-ID: <adAsUx82TbLx4PfS@krava>
References: <20260226085240.1908874-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226085240.1908874-1-alan.maguire@oracle.com>

On Thu, Feb 26, 2026 at 08:52:38AM +0000, Alan Maguire wrote:
> A soon-to-arrive v9 series will add support to add BTF layout
> information to BTF; this describes the BTF kinds known about at
> time of encoding in order to support parsing even in cases where
> the kinds are not known to the parser; the layout relates a
> BTF kind to the amount of space it consumes via an optional single
> element following the BTF type or a set of vlen-specified objects.
> 
> This series implements the support for the BTF "layout" feature
> but does not require the libbpf changes to support it; the feature
> test uses a weak declaration of btf__new_empty_opts() to handle the
> unsupported case.
> 
> To test pahole with this feature, the following approach can be used;
> 
> 1. Specify -DLIBBPF_EMBEDDED=OFF option to cmake
> 2. Install latest libbpf with associated patch series with layout support
> 
> Alternatively with embedded libbpf the changes can be applied to
> the embedded libbpf in lib/bpf/src.
> 
> Changes since v2 [1]:
> 
> - Resynced, renamed kind_layout -> layout
> - Avoid encoding layout info in split BTF since it is a waste of space
> 
> Changes since v1 [2]:
> 
>  - Resynced with latest pahole
> 
> [1] https://lore.kernel.org/dwarves/20251210202752.813919-1-alan.maguire@oracle.com/
> [2] https://lore.kernel.org/dwarves/20250528095349.788793-1-alan.maguire@oracle.com/
> 
> Alan Maguire (2):
>   pahole: Add "layout" BTF encoding feature
>   man-pages: describe layout BTF feature

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  btf_encoder.c      | 21 ++++++++++++++++++++-
>  dwarves.h          |  4 ++++
>  man-pages/pahole.1 |  2 ++
>  pahole.c           |  6 ++++++
>  4 files changed, 32 insertions(+), 1 deletion(-)
> 
> -- 
> 2.39.3
> 
