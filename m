Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47E35B125
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761753; cv=none; b=rAH3bPiOEGCFaVTk3eauuNtGv95CXBINRVrPpoi6LLxPdd1Mhl4DbtH/hmITdN2ELaFWxWSEknfjOazGhMsx0W95m9OS+1br/Zrp97bIn2irdIwjJmmYaF6hcUvS4TLV9O5AHhFO/gJFOKq1kKZnOhAMTVJkcU6lO2fnXR1vFLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761753; c=relaxed/simple;
	bh=AZDR1isMFQyNKFuybLOvsuw5gIrf9qlXU0JZx0dpqaE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VT30IP95sfdGNamIkeWVnOhkWYfyAHAkikh0ZJUalvhw9nxrF2hZOYg+UaVgj3o7OHqj7I40LfVrZ/AM5BjdzcYjwpnoV/gJpmW6D7FG4/v3BLEbrao9fakFDj8f+p57+QiFzlh2nadFbPDUPFevX/zw1Rmd0ckQ+i0/b+zRXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4WNNxyU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4WNNxyU"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43fe62837baso2393604f8f.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761750; x=1777366550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tvcz5hSAoObfzS42pi+saOECAJRoncopu43VJxoiKms=;
        b=A4WNNxyUNATfj3IlyyqtWNY2UoeU0VO/XYM8NuelQzPdt06Ylaz1sWGzoem88z2gQ7
         D+yDCvV+HI5srFMWyONvfL+XmUl/Wdvj74OnVeICk+xfO1NEZd1k9Kx/QNmvEFWzbc/L
         MD1/PF+Nc7QUshOYMbxu40TuUs01J8oq4jix173yUptxxnQK3kejFDk9/5UKDRvRnYCT
         dNzieTwjehFMyzeE597AqK98dcQbcFNE/2yGBSH7aY9tal+WdLl4+1Pxa6d3ibqJQlQ7
         c313/weIHtMpGaeXlm7oL2pPqTipZk+JG3DLkkNobgBLyRsSalr3iYq8B4YseOx9IL8f
         /C6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761750; x=1777366550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tvcz5hSAoObfzS42pi+saOECAJRoncopu43VJxoiKms=;
        b=BBaNd7lgJuzEfrG0Wc4dWpkkgNLBREMxJZ1zPF3PQM5Qkp5Xh6YPcYelLqdit+O8DU
         5ukYgn8uQqIcBf4fHbIId+XPFVD7A+G6PwnDV0h48rvtRpyjRYmCRCFCgErX/u1aVdfI
         W10uvQu3LY+DETwTTlOCc2fn3f4DPCm2xAs9mgivdcN4W7BWSS6n8Q2qdV/Gubr3BLJA
         yPHrIisdFJ4660BIwP3jPovvki7cG4HBt7TTwi0SypXoOIRP8Zp/uP1URmR0ra1KBGnT
         VMSVk0l+TwJ2eLOPvQaZ4XCB+Ffpafp//Zz35KVw4MnigY1l+Fvn00kW7Mj8GP4zrv1z
         +u4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/v+Uxf+0EpW32Me3aUj93RRk8bBRByLdJ5Y1cLsUt9+9N5fQeWTNivS4poLjsr1TuMw20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj6qpC1Pmuh8iFhz/PpUPfzLZR0LaaeLUbmKzuCrfRPZRLnIZ4
	oTRCr4AQ+4zKAj8CMAnthgIZtEvailMDUZvFWKkTIL3+BFMRvpbyXaik
X-Gm-Gg: AeBDieuU3yW1vxVotr9/7DXIN8iDfpHNnjvNFCR9J/YFM8u24cU3SntPnC4imrRmFYr
	fCAdd/ne9y9ovyXfbjdnAZySd9u5+ia0NGGTsp1vsmMJJYlLALPeKqZBrJEa2GEOvjGOyx3L1M1
	UnE5ShxDEFrA326nKqD9wKuGAf+qMXsv6q040lW+UfsQtvgZNl/8hmQ1cVCf+Ew6cX4ts2rb10D
	FCmnANkU171GceYBeudHXLMhyarG/wFSknps7R9h3zRaf1fL/rlE4zKV1cXzIPEDuj+n4BBTGHL
	fygE5Wev/2lpBw0M//d01MuS0Ho9Zq3/m8qg2q5GFyLvZfwL/H/QWlB3KJG2mxGVb6qnt23QB8Q
	tO2rInsuZvaIXn2BAk6cOg/nR6wEox0YOcmlUwGLTa4sHqppGFAi6FRfyy6Oj8hdHeWggK1RCSI
	96snJbqynMYU7cph5l8w==
X-Received: by 2002:a05:6000:4287:b0:43f:e7c9:2402 with SMTP id ffacd0b85a97d-43fe7c9254bmr25968265f8f.3.1776761749886;
        Tue, 21 Apr 2026 01:55:49 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm39816338f8f.29.2026.04.21.01.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:55:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:55:47 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 10/28] bpf: Add multi tracing attach types
Message-ID: <aec7k-8w7jx9MN03@krava>
References: <20260417192502.194548-11-jolsa@kernel.org>
 <1ef3a598cb11de0fac8dfe1ac94287d3588ca36257f27b0a2407e85f5037667a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef3a598cb11de0fac8dfe1ac94287d3588ca36257f27b0a2407e85f5037667a@mail.kernel.org>

On Fri, Apr 17, 2026 at 08:22:39PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 552bc5d9afbd..5f814e7101cf 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1154,6 +1154,8 @@ enum bpf_attach_type {
> >  	BPF_TRACE_KPROBE_SESSION,
> >  	BPF_TRACE_UPROBE_SESSION,
> >  	BPF_TRACE_FSESSION,
> > +	BPF_TRACE_FENTRY_MULTI,
> > +	BPF_TRACE_FEXIT_MULTI,
> >  	__MAX_BPF_ATTACH_TYPE
> >  };
> 
> In the RFC version posted on February 4, 2026, Leon Hwang asked whether
> BPF_TRACE_FSESSION_MULTI should be added alongside BPF_TRACE_FENTRY_MULTI
> and BPF_TRACE_FEXIT_MULTI for consistency, since BPF_TRACE_FSESSION exists
> and is handled similarly to FENTRY/FEXIT.
> 
> Reference:
> https://lore.kernel.org/bpf/3015991d-2e9b-4bf4-9c17-26e00b5d5926@linux.dev/
> 
> You acknowledged this with "good catch, will add it" in the same thread:
> https://lore.kernel.org/bpf/aYM-jeV50WaVik1b@krava/
> 
> However, BPF_TRACE_FSESSION_MULTI was not added in any subsequent version
> through v5. Should BPF_TRACE_FSESSION_MULTI be included here for API
> consistency?
>

I think the comment was to introduce the support for fsession,
not to add it to this specific patch

and BPF_TRACE_FSESSION_MULTI is introduced in:
  bpf: Add support for tracing_multi link session

jirka

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24583317711

