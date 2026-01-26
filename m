Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A213126AD
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421759; cv=none; b=jL03aSlEywUSp5nDDIuJvHKTIs4/2i4N7g9wHabJtQdgygD0kUwszklyD+kcaQe1UB+H653/XwsNrqyIEDso81KBMY27fQwJ9CPFjFey4JQezJQCpwQCo9yvEFUqrW/wWdOADn9va0MiRPw3b7cB+eiNsl+4IS3xkasvcaEDthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421759; c=relaxed/simple;
	bh=heD1/zxbWRIQM9lkgarT0VzF5h/BHiXrLX0s8WFS5PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EboyMOFYl2XiLMlNWi/3J1Hh9E/4hYdEP8pqPhHi6CJFeZ8C0HYjlUWlEELwctGSLqoF9WWddKyNVcf+8s1K/5KEZFuHfXCYcuHaHmf+IEPEVm11FP1SogmWx3uUIrGpKH10KSe8L/gptxhrFS121AZsSpUZjJUEPtgz7GiWwH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F8EbefgK; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8EbefgK"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b8863db032dso454096166b.0
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 02:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769421756; x=1770026556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hT60tmihYcKbv1/AvWYSJ5d72JRvZQpyi5UDbrwfXQ=;
        b=F8EbefgKOoVr8jcTTSa5ANHdchKn4LFJzle/laLCnJNWBgE8J9PQ5HW/6Zw3+0/4gd
         V6LB0BFy2fDUCFWsQkPftqlUWmktnrnWyJOzqOhzOp0ekxGuMy6zpv3/rBtPgkDXKZ+P
         NufrKKHX4ujc0PvKans/dIxJuzw75hWQ1ONYsv6G6TGdu0JrghAkVq1BfZGI0o9KpK0S
         mpEotkn6vSzZY33aXuWUOylw8/H7MGUtAntc5g/gDlCzi4U1+0MxNksp/uxFANUzc+2U
         0L8/jBiuoifu5qRCj4wjf07wEaEAbW5M2Eun+3lOEk5CVsVxafDo4DdJJdtDev17SuBV
         OUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769421756; x=1770026556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hT60tmihYcKbv1/AvWYSJ5d72JRvZQpyi5UDbrwfXQ=;
        b=TC+QL1VA3tX94TxYiLv3lr43CrKxCciDfnFneMETRCVmL7sGryjfQrPptF/sBfYv9c
         Udzm7Gw3ejfsedO1G+Tj26VJzAZXeFDL9/vL3Vv9zUASWMwG1qSueM31Tv/GVff//WVF
         vHfOk2ES2DzuTVL3EHFBNg2PZTcNjpAS84YWbxHJrLKhoOAgKpANgV8zfrIGEHg6PNij
         1SB1dcV9YEAyuzPIaSElbATP2RLZiRCNdJ91tFGBHIsXE1yPdg5ossz6S8wBWqhSuk/g
         7X9y3w200x/XEPOpFjmBPuJJA85iMDg19h3KNhB77uX4kGXPdek36wlnFjgnREnGpRzX
         4FuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiIq/aoEptaj/yPcPk+DKJgSqSz9zM9l+UAwQquSupTci3h9iC8aCjfeT0qqlvEroRZBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIvM8ZrR2/h/paRgwNgQk0RqHeee8Zo1YApd7BG0XxDXVPDprp
	YQUXVufeM/uhlMV7mEy308UYiTQJqGt9fFUpXjpSZEgBgd9Ys0SHSnjNAV6f8ECqBg==
X-Gm-Gg: AZuq6aL3U+vMmISefBT/zfmGS6tdH3K3FfaP0ButXV6RHonDxSDeQZO0lnjmae+pFML
	LcueevaETJEzuB3DV/F+RQ8FnM83pJZEekm8pO05s1xak5565mw2xfFUD6ODbK0hXvQ61nkV9gr
	GaxMD302R8CDdIlu/nYpnnaqFJie5XNaSSi8jTtLTQO5Kg0bQWUdIwEGDGfOHcPOTVPX37oArU+
	QFb1A5kHn1DO0qME0ModxbYaJ/2xx/Q+61h2MU94e8X7hrjLmWe1EdWRYUMSrg1FnWt8xLYgUv6
	uVx8ykHFgt1MYj/NttI8znw/w2Colbu6enFS9uAWLangjMKTDFB++BOXNdDqo2+qjcHeD1TlTah
	zmZx4Zo6gB3OeiiJbgLUwq5sSCo8sA1CcamrOsMCCzCUlAEWs57QIXK+SXW7euUvIEHhf9Kt87T
	nQXDJgP9INPaGFjE+lLG2to5ouOwX/Dv3waayWnxrDnxStpFIQWIw=
X-Received: by 2002:a17:907:c10:b0:b88:4ddf:d6f0 with SMTP id a640c23a62f3a-b8d4f723bf6mr282103166b.61.1769421755871;
        Mon, 26 Jan 2026 02:02:35 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b7d7ceasm632281966b.65.2026.01.26.02.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:02:35 -0800 (PST)
Date: Mon, 26 Jan 2026 10:02:32 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: yonghong.song@linux.dev, ihor.solodrai@linux.dev, eddyz87@gmail.com,
	jolsa@kernel.org, andrii@kernel.org, ast@kernel.org,
	david.faust@oracle.com, dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 4/5] man-pages: document true_signature
 btf_feature
Message-ID: <aXc7uFtOhE7bSZnw@google.com>
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-5-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123172650.4062362-5-alan.maguire@oracle.com>

On Fri, Jan 23, 2026 at 05:26:49PM +0000, Alan Maguire wrote:
> Ensure non-default "true_signature" feature is documented in
> the manual page.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Matt Bobrowski <mattbobrowski@google.com>

> ---
>  man-pages/pahole.1 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 3125de3..90a8f45 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -337,6 +337,11 @@ Supported non-standard features (not enabled for 'default')
>  	                   of split BTF with a possibly changed base, storing
>  	                   it in a .BTF.base ELF section.
>  	global_var         Encode all global variables using BTF_KIND_VAR in BTF.
> +	true_signature     Encode functions ensuring that binary-level
> +	                   (rather than source-level) signatures are used;
									 ^
									 within the generated BTF.
									 
> +                           for gcc these are ".isra.0" and ".costprop.0"
> +                           optimized functions

For BTF generation, would there ever be a situation whereby we
wouldn't want true signature support? I'm just trying to understand
why this isn't defaulted to true.
