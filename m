Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC163B1014
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908774; cv=none; b=giVilmZePSgZwPNspx436GRM2DVBLrVrK0PXZb8Iv1XUYaAFtFZb/ni3rC2im5bB7Yhsuojj6jK13SObrv/iUzulliQQi5RpqEzMcNCiQ9a8oRSAcIhW68+it3dWdB0e6V4zjPUtUq3Zz5rZcEAb8hbdwg6n/M9fOaf0ktyVOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908774; c=relaxed/simple;
	bh=71kngNLglTQFWzZYkjVAWT0fHT+5MJVHKiuaOh/1EgQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpXBqGra/YPitRJsM442VemQBTYFZG6Guea/NhecxeRmUT9MPWsUZlcqhuMTKTJoaUmS9vH3JkWQI6G5xifdDoN/RF0q7gFNPZIUwnauo/W1UpAHptJVJQUfVjaq9CgbyFqG98YraZA4FnTl+iY5dxfWgASXj1O7EHZJPszuuRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOFTK4Ag; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOFTK4Ag"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490af320e2aso44718395e9.2
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780908771; x=1781513571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RAmzFalsZ1626ri7eqynS376s1QmdxkNtdz+K5A5+m4=;
        b=IOFTK4Ag/Fh423MXLErk25yqTc/H6GVAub/458cV/r+cGCGj/fTnQdeEqQyJvwkA7S
         qRshw+rSQOex2QIdvzssxJ90ysoVDk9cefNRdZenzfK2/5sLUen7O4nfwScdtz81DmOA
         DqMhOHQfju0U4/4y5Ct/FDrffrqw69KGj+kQNpU/GhgcKTLi7/B/ZPqUrXZbG2Iz/C7X
         nQnLHM7xIsc5MdXMzmYkdSJpMxbHR3t8bGt0AksjW7aH2HeXSyadL2ZcE5MGrL0oS0Ma
         3U2ug8NRcoJMgO3RdrMwVPpzzIrUFgXo/vwqTS1xDZx/1Ulfy1WZtLoSemz84aLsictQ
         aWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908771; x=1781513571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAmzFalsZ1626ri7eqynS376s1QmdxkNtdz+K5A5+m4=;
        b=SjaIR9SZiZi+SuaQdmYEWb54IAJhvpEJemCcD4ZSAlPos+rBmIa3IsD1TGOLgbFHzy
         29eoq8+Bo1w81b7govYmq3iGSA6PbJnYERduLhh0SKR74U2s9nNl2tOWUllxi5o/bfO/
         oW3c0DTQiIFM+D89JkVNqR4SF8EU8qmKdyh9UqH5hEm3k6WiB77Yf/lJipeMwShgWMFz
         l33n8z1XYIUhNYbIkp3NDSRENWcSF9aJWqF3KqW7Xx7ByXc7INDyzaRX15dJzSxSz3li
         BjgV4rwnJv3V1gQojhQl8n063V69HVkfBWKQUAEpzj2CEW6BXBb8qoB3PfOdFlpfgeqC
         bSAA==
X-Forwarded-Encrypted: i=1; AFNElJ+g3wOzj5wip4PRm7UNNtWaMioihuX7L5cCVZdCzsaG5ZA5D1N5Vwlwdln7f93S5yu6mQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBvleYV8qpWpPAHL7rn2e9ZocARbFPfp01j2Bn7gCcFRPjjDuY
	hh+GjWUlA1+S+wkA589NOBDleSUsI7o9JDlnUNQ1++EvLke1WqsjQhXh
X-Gm-Gg: Acq92OF6/eIoMXdUdAYGWzt8N5JPD6eKpyG6zh9e7o69muliVzv4RUxWb0AWYOGKWb9
	L1T6XODlHtzHDoSfzl8RqAkjcnhSKdJohXg/K4Gb0rSln+Srrx5uh4nnJT/1hGjjGasvVVG6Dz5
	cPQ6y7JWwKherGogjLPyl1aDys40DNSKJJp0TJ2nZCRmInnDOv+pxf+BI02NMbpNEimWA1IqrgR
	AvZvh8DgcGT4Bcf/N2mb/LuCpSQ4pA6pZFl7HGImQ8Fh36eC3gwslV8gNUogWZD9VAzjtT1NH2w
	+wxoaX6Q8BOoaV4dMOhMD6vPW3CLG2Zg6r2P3wpzGZVgAalYzyVrdVfYTWeQobVPh8EoacAyOWT
	HwmlX6rTjhcm97Wh8P1Yh19XTeqwH1WrQavZMHhEk8x+Vjk1Cs0j30HJbzGtPynZAD5RrLCxEMR
	MoBraKJ4wd+LSj23vE6/l47g==
X-Received: by 2002:a05:600c:83c3:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-490c25a21a9mr267462155e9.9.1780908771176;
        Mon, 08 Jun 2026 01:52:51 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413adbsm378495555e9.15.2026.06.08.01.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:52:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 8 Jun 2026 10:52:47 +0200
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Ihor Solodrai <isolodrai@meta.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf v2 0/2] Keep dynamic inner array lookups nullable
Message-ID: <aiaC37sAQD5kOfQZ@krava>
References: <20260607-f01-v2-v2-0-da48453146e8@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607-f01-v2-v2-0-da48453146e8@mails.tsinghua.edu.cn>

On Sun, Jun 07, 2026 at 09:24:12PM +0800, Nuoqi Gui wrote:
> An ARRAY_OF_MAPS can use an array created with BPF_F_INNER_MAP as its
> inner map template. The flag allows a concrete inner array with a
> different max_entries value to replace the template.
> 
> The verifier currently uses the template's max_entries to elide
> nullness for a constant-key lookup through the inner map pointer. At
> runtime, the lookup uses the concrete inner array's max_entries instead.
> The verifier can therefore accept an unchecked dereference even though
> the runtime helper returns NULL.
> 
> Patch 1 keeps lookups through BPF_F_INNER_MAP array templates nullable.
> Patch 2 adds a verifier regression test for the unchecked dereference.
> 
> Before the fix, the regression program is accepted and the runtime
> reproducer triggers a NULL dereference. With the fix, both programs are
> rejected with an invalid map_value_or_null access.
> 
> Tested by compiling kernel/bpf/verifier.o and
> verifier_map_in_map.bpf.o, and by running the regression program and
> runtime reproducer in QEMU before and after the fix.
> 
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
> v1->v2:
> - Update the can_elide_value_nullness() comment to match the changed
>   parameter (const struct bpf_map *map).

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> v1: https://patch.msgid.link/20260604151153.2488051-1-gnq25@mails.tsinghua.edu.cn
> 
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: Andrii Nakryiko <andrii@kernel.org>
> Cc: Daniel Xu <dxu@dxuuu.xyz>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Ihor Solodrai <isolodrai@meta.com>
> Cc: bpf@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> 
> ---
> Nuoqi Gui (2):
>       bpf: Keep dynamic inner array lookups nullable
>       selftests/bpf: Cover dynamic inner array lookup nullability
> 
>  kernel/bpf/verifier.c                              | 15 ++++----
>  .../selftests/bpf/progs/verifier_map_in_map.c      | 40 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 6 deletions(-)
> ---
> base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> change-id: 20260606-f01-v2-324fb92185a2
> 
> Best regards,
> --  
> Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> 
