Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E298D3BE164
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933361; cv=none; b=la1S8DupSprqhSJ/DaA3dddB/J85LWkSZwLEGTuEnSDrwIzYITBHdrwwgJcwqmrmG9NXK0ms90mkbQUzHw9JfZLgUEWOL0btMn9XIaExSEzwJDCRloTxCMPG/JPiz21H+9HUAxWYFb3tvbfeH68vT3+2cZcVF238fZjiYZ1CrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933361; c=relaxed/simple;
	bh=cGAg77A9vGAqO01N9puooMvj1PtUM0QhbRn4oKLxUtA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYylZTWoh2gQIU+XOEtqA/99syFvwq3R++dva4VmKxkIvp259YdRv5rgL7wJ2UL09RkCwrAiEWM5nSjRSBvRMRlTJ8xrgxU43ad0LcnIh1vFrQwqvW+6nEco0z9v+SkUadgydZzZmR9nMLYw3XHLVTsEbvJwS94ZWUgrBW0+xFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsZmm+UN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsZmm+UN"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b0046078so57430665e9.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 01:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933358; x=1777538158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pX8X61NK9tT2Owfg7advdmy2f2BYjZERfDDXJtbjaAw=;
        b=DsZmm+UN6pd3bQ+4HicCbv9Gz0rZ7v2vHQUh/mc8Jf0r21+aL7sSHSSnCOmWiibIEk
         0ynTYj3svKjGpwud4trt8JGWvt5NIMG3+n+aT9nFiYX1nb9k5tv21YYbQe6+9zAMVdqH
         RldjEO66z+Ay17AR1XbbF/fKE9fK1KsJrVdA6c2AxxuouU7qy6q7ZIxxHYrF2t20u6WV
         cEo5/8cpXEP3LoBlyS3+9PoSme1R2AiNCCRpp03jU2uLISpx1QgdadIvr23qeSXGFx8Z
         K7xnYf0iqkqLfGiCA+dxaqyPihy6mEnPpJ6bulTC6RTZ7xAWMD9aLQal+8tFEGfix/jb
         74uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933358; x=1777538158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pX8X61NK9tT2Owfg7advdmy2f2BYjZERfDDXJtbjaAw=;
        b=qDach1ZzZ9LLrOceIx1BDOa5gCkq3W6cUMQZmHexP7l7iVJLan7gZQWRGVmcpmpBbh
         Q3JR7EIU5r83BVaJTNlt8z/dnVSFQQK5sNGHkezhQQqIkn984GBoGH8Y/C/9ib3Fj8g+
         QlpR4F6PBY4rLKmC/TbXV7VcMaDiyn+Wp+G9ajGwkvpNkorIZA71mnUusVncoAvCbMkb
         DJ838jrc3pA79w7gRUhHECusmZj1Vni9JpZ2BWhd0fIV+WNP+pxRLQSflUrzw+JKKRA2
         z3W1ECURmKCE9wZCaeqRugaUlLCBGp0XyDmFHXRJd8nQn0TIfnY6mgfN9IA9/5OZAklk
         Ld0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/CcVIv3WgqPxQ85dPlTC1jIdgv2Vxtq9gVKNfWIg+V5ZZOHUJVe33jpyYw3DRyxWt6fqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZXYHcLKl41R399f+vu/PXHLr4ZG6EI84mVB+57f8jFniT60U9
	DyhymzN8YRFL5H5uTNG5jAx+mhJZamujLr6h238rGjpCm2QKMT9OiLTy
X-Gm-Gg: AeBDies4R2visKqeY1tgdOUyhdB3UAEeC+7YW8hKYLLflmAZyv+ciH7FNtxgnPMAd+d
	eI2Q7ZTQqjTK+5M3WFFfTIbdTCvCxvHM29V8SPZcQ7Ud6AD51D1hYdjsFavjlsJ/AqYQvs59XdM
	cGyfX1gbADaHTnTMzNlVYOdmnezr0ND6HUDiypNOOmIN797yrY5gJqCucaIjA8r4Hl/oy59eymm
	LNz0+OYSAdlM72E+J0cvwTB8lA891RKOWmRrT6ZaPLpxsO83j01jlIUdcOEF7yAkjRAL+PNoFBa
	GlqYqcMsvK4QNpRuJPVFN9788GibKgIYs6PVb5kiIuYey23RgHqAIDyFpBVhSAdMzYLZp5sKmPb
	ZQ4UbeCaqYSgE4JYUjdMTMg4xXcEjxFcHcF9CvoP6xLcYr+cv7Qwm7T66g2tTYTDGkDTJEH+05n
	67z8RSxnSMRebBbcc3IQ==
X-Received: by 2002:a05:600c:888b:b0:485:4bd1:4c64 with SMTP id 5b1f17b1804b1-488fb796f95mr301870745e9.31.1776933357937;
        Thu, 23 Apr 2026 01:35:57 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm518612495e9.5.2026.04.23.01.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:35:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 23 Apr 2026 10:35:55 +0200
To: XIAO WU <shawdoxwu@gmail.com>
Cc: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, clm@meta.com, daniel@iogearbox.net,
	eddyz87@gmail.com, ihor.solodrai@linux.dev, kafai@fb.com,
	linux-trace-kernel@vger.kernel.org, martin.lau@kernel.org,
	menglong8.dong@gmail.com, rostedt@kernel.org, songliubraving@fb.com,
	yhs@fb.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 10/17] bpf: Add support for tracing_multi link
 session
Message-ID: <aenZ68-4ZeNhlXr1@krava>
References: <0520af2c467a82b82aa3014b7e721f95bfde9e91324bb2e183b099e5a37bbc3e@mail.kernel.org>
 <20260423160724.00004f6d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423160724.00004f6d@gmail.com>

On Thu, Apr 23, 2026 at 04:07:24PM +0800, XIAO WU wrote:

SNIP

> I agree the patch should be made bisect-safe. I will post a follow-up
> that ensures BPF_TRACE_FSESSION_MULTI cannot enter this uninitialized
> fexit path (either by initializing it consistently where needed, or
> rejecting this attach route and keeping it exclusive to
> bpf_tracing_multi_attach()).
> 
> Signed-off-by: XIAO WU <shawdoxwu@gmail.com>
> 
> Thanks

fyi there's v5 already https://lore.kernel.org/bpf/20260417192502.194548-1-jolsa@kernel.org/

jirka
