Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95430DD00
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029885; cv=none; b=kW8If1N5Kc0knq09DweVh5qMBD499OxIfqWdbJc10FH88QuPrl4fWBh70s1z0q299O1HHEkUeokfkAAT0RjACO2Mfx1ck96lZQsKFOMb/EjIwHkW5l6N7OPI3zMEVO2vrrxHd9SnOr6eBAUEE5qtcNO42zS+8jPFelDaYlxCqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029885; c=relaxed/simple;
	bh=MPVqFn8B9p4RrwT5jsaR0Lw7tNeeJ1n1bdyEL325lLk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUL1AJ76w4HTsQ90Xyandt1FVVkZuysPsCZyVTyRTrISmv0j6lLjrz8unNlTWQn+YZVQilbQ2VdG6/71h4dVKC1hxrC2BTZCxff1ma095YVYVLSUuLwX5HMo3zZ/SmJTkdDMrk9nbrtNAaqVB+taDgS8NXLUeb0Z4cuOOqz7/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z76WoY3W; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z76WoY3W"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfbd17589so6170571f8f.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777029883; x=1777634683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hw7+DtCe4V1xDBwAGJTClYpq+4ukLefYtebXjXI5aJw=;
        b=Z76WoY3WW/WpV7ACGMA6mEvqg2U9yw63jhPOYpgoOyRjj3Xvf4dJtVka0CqhFMVFho
         75pyz9SCAqyoKHfkZvAv22ltPogbdl8QnwDVKoMuJ2QA0ZizDtPoICfgGY8rh6hZlgN1
         A520bNO394tZamAoPilUuerfoWNE1zU6+GYfGxUkE/TKXDq0q7Bfe8M5e3bCPHVduNg/
         fqPwuvNn5Y8l+0id6X29dSGViDSgJ7uyXa+38WS+HRmy8eMRO872n7FKX+ZB6i/XRGl9
         +6nMdHH4kG2BB9Zmf5Uv3qWB14YInLpfglLynDnzU/yKQOh5H9x6IRfEGD1n1O0KGrqa
         ADYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777029883; x=1777634683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hw7+DtCe4V1xDBwAGJTClYpq+4ukLefYtebXjXI5aJw=;
        b=mHhggdAWj7OVe/Yl3l5gk+aZAdYXLuBxxbpm8lLWFdclawlFmnOG3C0iisYDWjvwkW
         +MGpWRniaJdSPuetXchIFGmHqJiAPHSO/UH9kzlk5KZAbXSb0gTUljpOhJdftU6rBkR0
         1rb0AHjVqnl4uf5HEehwisVlLEEgGafRGFNnHduhNMnHqKvjIu+7XWT6bXHIoePPiak6
         IDurRymHzwRtIwVqz9sPhzLe8mrTDV6MyCjkEJDwBYwVwqRHAM2QNZgWKdJ5vZCRsDKp
         RwD47C9uOtQ8FTnRjLwAYT8Fq5gUDL+gUspNBb0RQ/WS4+MEKjX1AzxtdTb8Xwn3bjYG
         01Kw==
X-Forwarded-Encrypted: i=1; AFNElJ8PfRFNVJl3secFANZkeULPiwhOL7mwLYL+9pnIp6CpyZg+Dag11Q+9HZ5fcS3En2wLO34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDbOD08wTYy1We1ozQTBg3p6ttDhLgP3yHBQfEK7F32Dth+b9L
	Vi4nSPNdxB1iMO8i1P277WPo0YYEyITiNyR6Snyj3q2L7WaRwMc/4Mwn
X-Gm-Gg: AeBDieunp/r9as0eCXxDzmMX0fd+PdwaQ2x5KYg+EqlJih6W8UQkwp1pX6D3QjkvmAl
	r2UgC583WA4hgWsbczRnjqflxuULMEvAwtZesTJCnaNsbWH8eQ5czHSMN+0fKhOMF2hNQTDYoKS
	ziKfK3pi8eQktniSzzTkGkcRs/27nYFIYVgt1YcdGv7jgS5449Zar4ar+mo+x3e0MoyAqGTjmvu
	oyahBNoyzQpk+BtGg2nbu2+kDNtx5q1hIOleebSZArcZe1RbCb+ACV9t2Wa8gaY1bwhQQYZQotS
	+nEhWFHwi3seEK15CiXx22LZooLGuukNg/4+B47MaU60Tzrc+aSRYlSm0F09nJd31eMUyXOriEv
	NEVm0BvzxYo1QaweYnJycS16uPbJrXZ8zUrYLcv8wExuXliRTfDSIGyJyK6b867/QgalZ2Ze9Y7
	sCLEydglH8aYk1FUbrJw==
X-Received: by 2002:a05:6000:2f81:b0:43e:a638:2507 with SMTP id ffacd0b85a97d-43fe3da64a6mr47793437f8f.8.1777029882819;
        Fri, 24 Apr 2026 04:24:42 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc09b1sm60212276f8f.9.2026.04.24.04.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 04:24:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 24 Apr 2026 13:24:40 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 04/28] bpf: Use mutex lock pool for bpf
 trampolines
Message-ID: <aetS-OVaIz9XbZBP@krava>
References: <20260417192502.194548-5-jolsa@kernel.org>
 <20260418035227.168AEC19424@smtp.kernel.org>
 <aec7bAbGlnEo3R1g@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7bAbGlnEo3R1g@krava>

On Tue, Apr 21, 2026 at 10:55:08AM +0200, Jiri Olsa wrote:

SNIP

> > 
> > Regarding the pool initialization, the new trampoline_locks array is
> > initialized in init_trampolines(), which runs as a late_initcall.
> > 
> > Since the static array resides in the bss section and is only zero-initialized
> > before this phase, what happens if early boot BPF components (like early BPF
> > LSM policies) try to attach or modify a trampoline before late_initcall?

hum, I don't see how this could happen.. anyway we init other trampoline
tables in here, so if it's wrong, it's already broken

jirka
