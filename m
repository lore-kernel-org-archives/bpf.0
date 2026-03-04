Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1083914E9
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645016; cv=none; b=ku/NvBOtc449LBp2ZbY/cCOr+rWeszmBZqNDfPBVlchexUVvEVUu6eUB5iWy/HUHBBiEj75wLdHSOfvHlZhQnO2aL5Ma69WLJNjpUpi8PThWrrUpYeKdM1qq28n2tyBGbiGCtA6+iAoBQpgZ1WmOMytWI14QHifpEzrpQSA0Ovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645016; c=relaxed/simple;
	bh=JkbNzU+BC5mBDwM7Qlval4j4vLyLERVSyUQctGylHzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbIg6Ay31yxGIMvhYxh3HAUu/nrN2/0EviTkCkmD8iKxRlAIK0o69eL4D1aC+/STCC4t4sCUHMzXLOmqtswXtthRaAsNkOvwx1Z4L8h2YXVFTccLWotuJlBVwJVbz/avAmYflv/29MEhRqtkFi/5vTyeM1i1jEMtl5hw8/7h+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQYoUW1V; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQYoUW1V"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b9b190easo2348709f8f.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 09:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772645009; x=1773249809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/95HNY6KDLzXlUBiGuKlerjfWpKOKTeKORSHgp3u1Uc=;
        b=YQYoUW1VBvAnVLYSLizzhSBr80QtbIaRXDS51kDzlvNZ3fjq1NWMBKvGRxtMIN6/wX
         uSZz0KapBUWz1540FeT+UpDJ4StgtQpP7eSkg7PBBzwsgEhxaLeT2onfhvG44Y2ahf8m
         pDxxikF3L3n3W2AIRX8UrMI3HJeV8oByeaB2ld8OVheJBqOnnWfRLtmBbOX3IX3peK1H
         IjpbcMfa7bnxXli3sjWHi6Y3eKz2ZDy1Sx+0/6bDJ0tIJZVJSvwevEKoCNQO/hBtvNJm
         1YpcT1ocxyu4Css8soaPt9L32BtJv9VGOIdK80FnBBQbE0ylSSK+Fg2iGueb2h4eNKt+
         r8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772645009; x=1773249809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/95HNY6KDLzXlUBiGuKlerjfWpKOKTeKORSHgp3u1Uc=;
        b=mcZZA/17w4NDtTq1av+I7pQaZj22esl7FSq2DVckNpKgML4/tbFR27kqLdPj8yoXdT
         Gw+0ssBYtyoq6zpMnEyJaSjF1X856zNXzrw58/g5IkL06qyGEqRViHo1FWZiTNrjpSiC
         HWiYB6Q47TqdiV08C5VFuSTtNy6k5CfPxnipXM7x+Cc2aePE/sgTmGUBZTIJ6m5wTjLK
         mG4iXn+ojfpLGvW/2B1fAb8f+nVd119S8ZiMbuEiahAo8L/6t5OdJNeaJfYQ+yj500r8
         0MPP9BknuKaeZ3/YAdAtnGkgE/9PMTX+gvJWrCXhBu1uHDYrolHQ+q16xSTdOjUMjMY6
         6xBA==
X-Forwarded-Encrypted: i=1; AJvYcCWh5/y8xAN72dK/kCFUpX6vZaFxLUWyOeFgnk7i54xZGVU21P+9hzKxt8bqQdoy2qbMGgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3GMmsyH1cut6idKAgamQ15Qua6vas8CYLLpVyY+UMfkdJEaW
	5Dr91sFmYY3E2Qq4ReI3EisXXVC/pyMpNtoDHtjDGhhwmJ/+Rl4+bw3M
X-Gm-Gg: ATEYQzwoidNQA3Qo3JdNtChBHKLTos7DeLBsCeYEziTpWQwTJVxS/6FCiKXkvaFr683
	PzHPT6PHY/onoqexcHqGOHxjUSSjcNiBgn6AlQC+aoiuKU5KLmXW57IkV+xdp46V/4UsfTZShN2
	OOPnQDqyGCekN7J0tmzINbmKJU0tckHyMHshPu3WCT5kyS8lTrE0n6flnSpPcz+W8sBk+jhjXEn
	ugmKjyY3BpxrPmIm4ni0aiYxp632QMndtG56edD+MiYWLEndkI0kpEHSz4wy+fhfOWw35tLt01v
	xESTyZ/pXsl76QmpzkH2ZaDX1j9yZ7DIFQxNcW8srXidVf3Jq/bIdhBEDyx7XKfKThkDRE0cS35
	NpLamTWGssxVhMstu+fYyj9vM4jq6IiHgWdK5bmZkHmZfCZrjOVer9H15kpZq7e8ePixY/Zi9Zu
	RYSqk2r4RfpnsF8MopBJwiX4e+HAvbh+EEOtyVI7d8IzgGaraAKsL21kpPU/WbLSJLKs4C9tS4c
	eNipmJ08wZlc7uWWZWGMjqgCojS5MjoVtkwBXMydOSJnV2zvXyHRuoOT/7qpvb3nh/ZrqpF3b7l
	u0od3bOrEA==
X-Received: by 2002:a05:6000:1862:b0:439:c1e2:921f with SMTP id ffacd0b85a97d-439c800d2a1mr5668603f8f.59.1772645009089;
        Wed, 04 Mar 2026 09:23:29 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e00a157f2ce043226e6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:a157:f2ce:432:26e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b1116698sm31716855f8f.16.2026.03.04.09.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:23:28 -0800 (PST)
Date: Wed, 4 Mar 2026 18:23:26 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Vitaly Chikunov <vt@altlinux.org>, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf v1] resolve_btfids: Drop -lzstd fallback if libzstd
 not found
Message-ID: <aahqjs9v3PRmR6rV@mail.gmail.com>
References: <20260302231058.916946-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302231058.916946-1-ihor.solodrai@linux.dev>

On Mon, Mar 02, 2026 at 03:10:58PM -0800, Ihor Solodrai wrote:
> The "|| echo -lzstd" default makes zstd an unconditional link
> dependency of resolve_btfids. On systems where libzstd-dev is not
> installed and pkg-config fails, the linker fails:
> 
>   ld: cannot find -lzstd: No such file or directory
> 
> libzstd is a transitive dependency of libelf, so the -lzstd flag is
> strictly necessary only for static builds [1].
> 
> Drop the -lzstd fallback to enable builds on systems without
> libzstd-dev installed.
> 
> Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
> Reported-by: Vitaly Chikunov <vt@altlinux.org>
> Closes: https://lore.kernel.org/bpf/aaWqMcK-2AQw5dx8@altlinux.org/
> Fixes: 4021848a903e ("selftests/bpf: Pass through build flags to bpftool and resolve_btfids")
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/resolve_btfids/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index ef083602b73a..5df897c881d3 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -66,7 +66,7 @@ LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>  
>  ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
> -ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
> +ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null)

This change is currently failing in CI with "undefined reference to
`ZSTD_xxx'" when trying to build resolve_btfids. I think this is
happening because the selftests use static linking with
PKG_CONFIG='pkg-config --static' but then the same isn't done for
resolve_btfids, so "pkg-config libelf --libs" doesn't return -lzstd.

So maybe the solution is to define HOSTPKG_CONFIG when building
resolve_btfids, as in the following diff:

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 72a9ba41f95e..d5acbeba0383 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -409,6 +409,7 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids        \
                CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
                LIBBPF_INCLUDE=$(HOST_INCLUDE_DIR) \
                EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' \
+               HOSTPKG_CONFIG=$(PKG_CONFIG) \
                OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)

 # Get Clang's default includes on this system, as opposed to those seen by

>  
>  HOSTCFLAGS_resolve_btfids += -g \
>            -I$(srctree)/tools/include \
> -- 
> 2.53.0
> 
> 
