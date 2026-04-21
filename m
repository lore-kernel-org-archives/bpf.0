Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB57331203
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761743; cv=none; b=Bp7Y58khUuifjJlJLT4TK9vL1K6xi6tFXqlhMZJiZQy93Hgd173b9pm428DmJ4mUvmr2Op9NTDqLMlcsTpQErsbEp+Yqb3and/yhtqgm4lE/WKdUucF03QSlmQ+GvCvLLk3Kq5ZY709l2pIKdQu0RwWk5YIRtdqbPK/fx+dcezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761743; c=relaxed/simple;
	bh=6McYy461bijCUAFHC5l3ji/PR6N+L3vcGNyzVKEBb+o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCwXUocyVUAcA7R/WCHhVH8awwR14vU38kJ7605VcBBRD82Qx6NM+cjI+auFMOIGbUXDWIXmh7njWA8B20pKPzl6neqxtke2LjjOVvOjIaja9ughRHPEIkgg6voQK1diTsMZz8jhc0IWIJmArWnOsUbk3R7z4+m0Bup0V9zPADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGDvJAIW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGDvJAIW"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d734223e4so2697423f8f.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761741; x=1777366541; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ddKnE6lkkUQV3xtljOGxMa6CIyS9sv5i2KFEzVc9Jc=;
        b=JGDvJAIWIdPYzqzJmd1YwP0R1gZuyMV54TMHkMm93Y0VGilCumHeZJnA0IRDasTYxE
         KqvuvBBh0WiRwt7RLeRESMTkjVN1LkfMIZWEIb1aXxyJx0URqpo4YfBDaLz+aR1Lsajz
         Y4I+pHJ0HmhnaNN1vJA2Tn2tCKF8qD22mcxbUHzZJdM6xhMokPSfxiXFiYtIZPm/KDYy
         +wrqFMSkKTNsDAUAMdmuhqxw/4r6Wzh/qrHCI9zLfOYzHZe6JFTkWEPWq1yr1RzHs48f
         OQ20Byx7/gre5XD5sxPj+3rF6mqz8yO61ZB8fo3qVIhoabwkOXxEm0yG8X7kMfuWAxsm
         6LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761741; x=1777366541;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ddKnE6lkkUQV3xtljOGxMa6CIyS9sv5i2KFEzVc9Jc=;
        b=Bpnsri00S2VPiPuAT1+JQOyVGL53uDKUWw8n8yHtjCDgyUqDN/A5bvbMH6wXF1zVd2
         ars0X6XXkOM6hF2yF2D78ALjFjmwKw4igbakX3fcLpl4sYjTuUnzzLGpQmz3JMB00Ob0
         UOz1SenJvGPBQEw18yu62glg4+KAgWtgoMIyucTV3DKdBJX5/vOJJW0BevFXOD+Ob/nP
         O7jhFmMXMg88PBbWOphV36JqIpo6AOh0t4oLQc2RNGQ2I9Pe3YoBgB27/qhzC0PBppDN
         fdf6z+5Ti1z4ou8SSstlET4DH5fvbSyv4aUEfettgmjQi5uY3ObmKB8DURvyfz6D/0e3
         NsoA==
X-Gm-Message-State: AOJu0YxNpPcDjMZ6zVqnFNrF9hykWjGB8OvlOwq2lLggfy3Gk8VlzdBM
	3joxuQSIUa8CaDweU3Ce5oL6D9NrW18CLT5jMI1rui+JhKJWjBSrLOL0
X-Gm-Gg: AeBDievwbPsu65mf7230uWEnBIXbRfTpW+nXaq9zAsTDpwCtF02TFiS6YXEfL/eJhDl
	WE8yBZrrSSS9r7JVS/6Q7X2SiA0CLCPUyBGpq4Z8nSWGeCFy196+CauwRKnJMXbfmWurEGnSibh
	n7xxqUR3DtnwtY+3+gW32/j4vs3l6cYUQXWTfSKNuJ5i7kW7nBZ+u01lLamxdR+Lp4b12bUUc2Q
	PsLHgT3V6eL+0BuP7qPIKc44fky9cK4tfkWG9lMe5hpZ52mw6zoSNNHuFol4HYwTXJePWpVLUsI
	/oLE2HtoTDJu4Xs5vnC3g1BdGX3rlfBAeiaRLOZ9l7aXsWRTGfgPm1zuX2JqMWc+T3drjklcUnj
	BcpafgJbyixN1NrmLzlmOFdnp/ypuUcEY2NBRGzS+HdY5gK7eHSmix/leDBFmwYIJlwyZe3oGLv
	TFW2xmT7Q=
X-Received: by 2002:a5d:6f14:0:b0:43d:7086:b03 with SMTP id ffacd0b85a97d-43fe4032b76mr22123952f8f.1.1776761740677;
        Tue, 21 Apr 2026 01:55:40 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm35812714f8f.0.2026.04.21.01.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:55:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:55:38 +0200
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 10/28] bpf: Add multi tracing attach types
Message-ID: <aec7isklARy8JbqP@krava>
References: <20260417192502.194548-11-jolsa@kernel.org>
 <20260418040909.5F3B7C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260418040909.5F3B7C19424@smtp.kernel.org>

On Sat, Apr 18, 2026 at 04:09:08AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [High] FENTRY_MULTI and FEXIT_MULTI programs can bypass verifier bounds checks and read out-of-bounds kernel stack memory by directly accessing the `ctx` array.
> - [High] bpf_multi_func lacks the __used attribute, causing it to be optimized out by Clang LTO, which completely breaks the feature at runtime.
> --
> 
> Note: The format of this review has been altered due to system recitation
> restrictions. Direct quoting of the patch diff has been omitted, and the
> findings are provided as a free-form summary.
> 
> commit ca84efa8f86b1acb8cf0bd98e80446dbd7c92e12
> Author: Jiri Olsa <jolsa@kernel.org>
> Subject: bpf: Add multi tracing attach types
> 
> This commit introduces new multi-tracing attach types BPF_TRACE_FENTRY_MULTI
> and BPF_TRACE_FEXIT_MULTI, along with base verifier support. It uses a dummy
> function bpf_multi_func for initial verification before the specific link
> attachment happens.
> 
> Can this approach lead to out-of-bounds kernel stack memory reads? 
> 
> Since the initial verification is done against bpf_multi_func, which is 
> defined with 6 arguments, the verifier will statically permit direct context 
> accesses up to ctx[5] (and ctx[6] for the return value in FEXIT_MULTI). 
> However, when the program is attached to a real function at runtime, the 
> trampoline allocates the context array on the kernel stack based on the 
> target function's actual argument count. 
> 
> If the target function has fewer than 6 arguments, would reading ctx[5] read 
> past the allocated context array and leak memory from the caller's stack 
> frame? Additionally, would reading ctx[6] for the return value return 
> unrelated stack memory instead of the actual return value, since the 
> trampoline places the return value dynamically? Does the verifier need to 
> explicitly reject direct memory accesses to the context array for these 
> program types and enforce the use of bounds-checked helpers like 
> bpf_get_func_arg()?

ok, seems like we need to disable the direct access

> 
> Is it possible for Clang LTO to optimize out the bpf_multi_func function 
> entirely? 
> 
> The dummy function is defined without a __used or __attribute__((retain)) 
> attribute, and the BTF_ID_LIST_GLOBAL_SINGLE macro only embeds the function 
> name in an inline assembly section without generating a C-level reference. 
> In kernel builds with Link Time Optimization enabled, could the compiler 
> eliminate this function as dead code?
> 
> If this occurs, pahole would not generate BTF data for it, leaving the BTF 
> ID as 0. Would this result in the verifier's bpf_check_attach_target() 
> unconditionally rejecting multi-tracing program loads by throwing a missing 
> btf_id error? Should a __used attribute be added to the function definition 
> to prevent this?

I did not check with LTO, will check and probably add that attribute

jirka

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260417192502.194548-11-jolsa@kernel.org?part=1
