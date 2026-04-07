Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DA23B635F
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566773; cv=none; b=mVmNQDV5na5r7HXQTsJXv3mzLjDj9ZT4X1/C0LPZRBlTjf8JdM2aQ8gzCenGUPT7Ixt/wns2OBVTwBu4hzbx/VBW3Um1II2S1DapLBhZcnjGqmZSMcAADulmDZxIqvRJEMeUpmEs/3P4VN3HUw4DmEaVzXpLL22mGUDwMmH5U90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566773; c=relaxed/simple;
	bh=Xgt0yKnI3R51jfRlpHewLRsZbOBbN1ll4V1KpUJWSZI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHjvqpSG4KwnU5CTtrmB6xCnoTK9FZO452WZartHH1Cb9XBjKHM2lWzkvpblzkCabWqQigFIgBnOQ4uAFQyj1UOarene+YkySz74PHqJJRSIRtcS/BXko/WnwUn8xLZUmJs7KX+QryiR/GOhTzoY2Z9hy7JGHyZcxY7ECeGl9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSmTs+G3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSmTs+G3"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfb723698so4408418f8f.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775566770; x=1776171570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RF2eQ/e3Z+XWoNNXFRS5Nhax4dGCTs+V8hdOEp9z2VY=;
        b=FSmTs+G39Er3O63YqgSNXUAQ6zOrrylO0kBEbasKqcQFjI3KWxqeiEHVAfLawUanL2
         bQVTgu6xVDqlB21+m4oVtqS7T/hpXtu/gjna4yhjYMJGHGxXyBn5Y+RDj+QZRr+vsPFB
         aWhizCjRC7LEyFXl94ZKyJMHj8yFUL2UeOzW6fCX5pHRT3i8xyISYmDh+6kuEGsf/XVA
         NIegkCxBlzhfppERcR1dWt0xoe50qvrMB70pQKf65aKBz2F7xzY0xSKpPRYAZlDtEmic
         eKK/HzPQLDm5AErB+FSBuPxKN1frJAfcijYmG0KKeqrpw5mb3DmUimfbPiNNXTOEoP21
         19yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775566770; x=1776171570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RF2eQ/e3Z+XWoNNXFRS5Nhax4dGCTs+V8hdOEp9z2VY=;
        b=aBzidINhmOXgHmpHXVEFF+qqpCT3BWAteGYrPGE1jYeLJSPfBidIur4EOaiEkyLj2v
         WmaoPGpMSYmIX8xctISk7ThIP7h+Mu0r60QZeDPWjUR0dTGJwxss8mPoAwaVYo2jfC5c
         p78te4l5Utut9KU5blqDAku1Do3QqF30tRUbf+GiIGMgfV8kh2UMjHiVQf2EnjfIYURb
         zfAUtss5bxr8+B1qjC/IyLSSSs6fHljHr3Lxt7yKhaReDLxqGIeiHMqRhCMcsb9gUz9l
         XRQWuVGRyzbKrQ48QG/iJWarUVnFDEGY0jJE3CJ9JeHLCPxALZTbTjL04Gl0U9pCg8Xz
         Q+jA==
X-Gm-Message-State: AOJu0YzgNT2FUn0aMKUorW5jmnM8t0nbVWIbCGDprlXIRVyHejR75Vdw
	DRfVSO50jqMKv2zGBzSx6Ys/MEBzwbOqoggzEu0/u1XGkiYtPLXFXdr/
X-Gm-Gg: AeBDievFr6b82ePR/RujYpEbfkPTX4G6lrDQrSGPxXQ8yMqWKZm3V5vME/QQAco0UUP
	mktnqS7kuVJV0Y3rPzn9j0SpA4Gy17l2aE6dYH7hqrME7Gk7m5mIAFY3QONTB8kteZm5uetiXyu
	zLIxEhn1hZwkWoLN7m4rQjsPnOaFAHkVwJbuLyJKF0lcKm/HpZBAVb7HOiGPHbRaYavwZJyNmLV
	2+1vi+8owrV8rKtcZBI2JeK0h3qk9F3zw9SxC3pcw4ePIJ9cmsutvFN27gthsGWrbInNV4fsdgy
	WG/VB5WjwOR7gD1JFrqMgm3i3rfK4Cl7XpF2jmzrGZ9HEOQJA++bHNTDft4+31a0Llx8VgBewlR
	Qw/WR01tjbPC2W3upO/i/O4O3V/5FRbtY1ddPQ0R/UO24bqmCUNoMMX4dTDyPyoFULej/PEGHsA
	3BT6btmgFY34SeMNEmK+L4TQ==
X-Received: by 2002:a05:6000:1a8d:b0:43d:3ce:ecc1 with SMTP id ffacd0b85a97d-43d292e2501mr22709595f8f.43.1775566770076;
        Tue, 07 Apr 2026 05:59:30 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f52easm51273781f8f.36.2026.04.07.05.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:59:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 7 Apr 2026 14:59:28 +0200
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, ihor.solodrai@linux.dev, emil@etsalapatis.com,
	linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next v5 1/2] tracing: Prefer vmlinux symbols over
 module symbols for unqualified kprobes
Message-ID: <adT_sBF_i_6oedFe@krava>
References: <20260406193158.754498-1-andrey.grodzovsky@crowdstrike.com>
 <20260406193158.754498-2-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406193158.754498-2-andrey.grodzovsky@crowdstrike.com>

On Mon, Apr 06, 2026 at 03:31:57PM -0400, Andrey Grodzovsky wrote:
> When an unqualified kprobe target exists in both vmlinux and a loaded
> module, number_of_same_symbols() returns a count greater than 1,
> causing kprobe attachment to fail with -EADDRNOTAVAIL even though the
> vmlinux symbol is unambiguous.
> 
> When no module qualifier is given and the symbol is found in vmlinux,
> return the vmlinux-only count without scanning loaded modules. This
> preserves the existing behavior for all other cases:
> - Symbol only in a module: vmlinux count is 0, falls through to module
>   scan as before.
> - Symbol qualified with MOD:SYM: mod != NULL, unchanged path.
> - Symbol ambiguous within vmlinux itself: count > 1 is returned as-is.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> Suggested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

lgtm, kprobe_multi seems to behave like that already, maybe you could add test for that as well

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> ---
>  kernel/trace/trace_kprobe.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index a5dbb72528e0..99c41ea8b6d7 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -765,6 +765,13 @@ static unsigned int number_of_same_symbols(const char *mod, const char *func_nam
>  	if (!mod)
>  		kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
>  
> +	/* If the symbol is found in vmlinux, use vmlinux resolution only.
> +	 * This prevents module symbols from shadowing vmlinux symbols
> +	 * and causing -EADDRNOTAVAIL for unqualified kprobe targets.
> +	 */
> +	if (!mod && ctx.count > 0)
> +		return ctx.count;
> +
>  	module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);
>  
>  	return ctx.count;
> -- 
> 2.34.1
> 
