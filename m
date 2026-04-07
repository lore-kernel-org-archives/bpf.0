Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4B3B2FE1
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566760; cv=none; b=evq4xlUSASP08urhAH6ve8eU7JbuDh1UQgg66b0wsYLtuUQ/2szsvGcLx0RWwYTXsoVJhFTVePaJqpxzfc9+JQ2cvd7g1Te7ZLWChg35M7dbE78tP9K5brjomMMdnlcFj5+RErx3Ms4DJGZO23Nh6z96Fi+1jBWLsvn0KYYRuCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566760; c=relaxed/simple;
	bh=MRMavbZxCmCqu97ErQH2KvVIS98vfvYbGQ+qfUPr1Ko=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrQxFJLJFjo3KxO6/SUi/PRUjg5lkTCaHxMVFVY8Pv66D3W3sGl0tRmHJ2VV1n817RCXUuWMDiszbsPGa0mVgZK1Fe6NnBWOZXnwxczhvtvRYgeX9v85dS1Q697plJo+EG3jXiqAOjP4mkMdZhz5hupkq+MgqPL+94MuRsjVHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBcv96/r; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBcv96/r"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cf7683a28so2988532f8f.2
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775566757; x=1776171557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGNXMEdomMQOlLGOIDoXABUDmvC0Bd8MldldSKwLSgU=;
        b=kBcv96/rrTo2xLduUbuybkQiPVfjyBN1g6CAF2tlfNk1anGH2d21Dw/yD/DEjeAxHh
         +wS0kyy9FDvzHFJKr1HXGSC7S/kM5/F/1yYRY753AAV3ZweVTuyo7cg5FG3PJRe0QrvY
         gWRvMJLTYhyp8lf11I6yvnbflQaawNdU138a31O+R61hgQa1ya/qSkVwt/NLSmcKEZfd
         ZGBV/Ix84czcD+4NUsTd+Pb82TbyZf2DI+OK83tUIsts00hwN8LzHUzY0WAzEPuQvUM7
         LYla06e55ACBK7sbFY6x7/87KnUaiCnx3QkimIiZV3LrRMMaelcPpVwTCQadbfWLoYM0
         3A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775566757; x=1776171557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGNXMEdomMQOlLGOIDoXABUDmvC0Bd8MldldSKwLSgU=;
        b=X2xDBSdwjHz4lKVrhOK/hlAjbS55K2s6vWZbTXs2wDR8gJgRWMDP+6uYEJfXxg+noN
         MG7+2N25KPiIRUbdPSmAF1dhSjIjqzNdmhmchYj3xezLMtF6LM94DNa+LFo3T4R3iE0a
         gYD08vfDUx2aKeti3QwSNuUTjj3Jei/xIa2ACgb4vZ09xceHWNA/PTG555ywQLTsjzi1
         2wk/rNyi7RIJohK1Afe1iqJzHNU4e15acy5XdxarW8MYpV6A/Bbs3m8YegkMVj1VvbnD
         3iRk/rWI7zvfcpM4M8QSTcqC34Is73uFXntEBV5+ox84NDRHA6zg7wzZddQJqf1CEIa0
         PbuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUko5YcEPoNrQolcCnPLyWCTaeHW7ifh3z0SdT2iDQY5WoH4qWIkunTt11CWwjuMHn2Iso=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSx7cdLqx8My4JTB+HCxgh5+thT7l9g79FTbIPDrDXZPZ0ML7
	kuMKgxdM8RJfBq5BGZFbXAdF9v0Rg88oab1w1NLcm3BWqrE4jxWIuLGD
X-Gm-Gg: AeBDieutObdW8YRtZggfEuKqBFBjQtDkgrsOwc2L44DTrItxc0DzrSbTuySUcDPm28J
	2gFUJq8dSJckrazSnXg2WLub65WwHGfSVeIC01KUlAx6ITq9bOCKdyDa5p9XE+bLcFtw8lRauJU
	ZE66ztR7ALLemBITbv6jOdvGkH9IqK4vrY5tBLMT4PC8IFTipZKf2JN7Uj1xHZB8DfkdVqjH4LB
	a4lkQ/kzXSXeD0xoIqoUbm7NIgIQnf1g+Lx4ZkvTqgYuM35UbTKdnnZSTqdsZcSeXMC0ISHyIKF
	Ku+IvLlHwVHvrC3vxFi+hmjlKuzEmxMpm3cK5aK1LeamEHRJZqwSOigzOpwoWA5SMI/zvhjR2kH
	qkOUgaq1R8jiJILMuW8AQOifN8CTVF/fXzwqlpCcLTXbdEg4kkCEHe3H5I3D3huRFDDscnkB8QM
	NAjCzzo708kok=
X-Received: by 2002:a05:6000:2903:b0:43b:3d4f:e18d with SMTP id ffacd0b85a97d-43d292e8001mr24841203f8f.39.1775566756876;
        Tue, 07 Apr 2026 05:59:16 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f73sm53750505f8f.8.2026.04.07.05.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:59:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 7 Apr 2026 14:59:14 +0200
To: bot+bpf-ci@kernel.org
Cc: andrey.grodzovsky@crowdstrike.com, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, ihor.solodrai@linux.dev, emil@etsalapatis.com,
	linux-open-source@crowdstrike.com, martin.lau@kernel.org,
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com
Subject: Re: [RFC PATCH bpf-next v5 1/2] tracing: Prefer vmlinux symbols over
 module symbols for unqualified kprobes
Message-ID: <adT_omtCk7ZGz1xS@krava>
References: <20260406193158.754498-2-andrey.grodzovsky@crowdstrike.com>
 <669779524c357c9790196e8e9ce8da8b21a71756c96e828252fead311fdc44c3@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <669779524c357c9790196e8e9ce8da8b21a71756c96e828252fead311fdc44c3@mail.kernel.org>

On Mon, Apr 06, 2026 at 08:15:10PM +0000, bot+bpf-ci@kernel.org wrote:
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > Suggested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> This commit fixes a bug introduced when module symbol counting was
> added to number_of_same_symbols(). Would it be worth adding a
> Fixes: tag?
> 
> Suggested:
> Fixes: 926fe783c8a6 ("tracing/kprobes: Fix symbol counting logic by looking at modules as well")

there's also:
  9d8616034f16 tracing/kprobes: Add symbol counting check when module loads

jirka

> 
> That commit added module_kallsyms_on_each_symbol() to
> number_of_same_symbols(), which caused unqualified kprobe targets
> matching both vmlinux and a module to return count > 1 and fail
> with -EADDRNOTAVAIL.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24047967861

