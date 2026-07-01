Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED048032F
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905485; cv=none; b=p3lCOZ6NDJNe96NoX5qqECdX2xSbTFIbLreItKyLZn1LkwjMRxl/ynnmvZRi4AokyqlgFyXFMCLF+JJjh/HacQN7R9MOB9MaKccnsHQzpTV4jIURHXlxaltoz7Qt9ICpM2EySiRsH0Jr1SlX1lFdU3HxSoIPcPkhTGzE6fyETqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905485; c=relaxed/simple;
	bh=Dve0VmCjU9mPpD1Ya9SMCVr9374pIBOKQAR5OsMMYds=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr29n+5HC1O51ps0Hl6ucncyvjq89HffyYYl3UJvBt9YVcQzRF9gwnt4KnJkFZqGYzvrDCWwkb6LBEsVC1BKtP1yD70mwdS4LB7FFrSN6EgwhISg/b0LEaYlE3QZQjlGVP6KbxCIXcX86ijGaC1vsRyzh+3O/P1/xRbMuEFYWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHZ/VeEJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHZ/VeEJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so3537905e9.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782905483; x=1783510283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fj8eAuKcVgK2A4fvhFbSFS2GpOpIsHgk7CadgUGfyUI=;
        b=FHZ/VeEJZg26HcWMicdHKh2m0oH6a3YI1dguXjeVUeR0iFZIP9P/ATLXIQbT3jXh+4
         ncoKOMdYmJ4BBbyrwvVQbEuJ7PlfHLdm8BDzcSQyCk03QU6RKTPIvDqDwEQoFPOjFkjx
         6p4kPbZ87P71AHWYt3m56temE8IoRh08wNEsBxTyYzudGh57qRkArwzIhic2wdNjZk0v
         6m6OmSwhFBFYP+IfCWWCXb+awr1DRkXTbfwXSRfkZvsY1P7/Y3gZn6h6qyawUBbdgEfv
         HfI9mwfA9wzQgLN8fNPH0YFUGwfxG4B5SiZdh7OcpCJ7ZOWWvyzlrMz3wBJSTnqb9lv+
         n7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782905483; x=1783510283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fj8eAuKcVgK2A4fvhFbSFS2GpOpIsHgk7CadgUGfyUI=;
        b=dTovRC2Ep7H6g2iuD3R/rnGOsgE/rkxu/+PZHJveV8AF/kXfQHhSMZsBA1h9HK2zCl
         09BYgzdlNcHWm1cZV2ogLYG/R2qt2iJhhDD3Y7ekR2sQNo6gd+JTwKU0bMWUYgnw1V6F
         VjYnXWvPxw/X6nn0kvUbvF9VK4OHuROJwdpPbPdg2e5m3y8fpPl/DgAPU0EeW6MrMyjw
         aBc4dNwhvTYbXTnr00n/DINW7JjTaeLQv5ED2zGw+29EHQuGgkemy+UgX3NtnuAAqWIE
         Y0yqLwesJiOZL/ZNxMH7qfIkWrAfw6WTojQae+VsPqMQj3ut9UCpIqakpgwyloPLNtxu
         +FRA==
X-Gm-Message-State: AOJu0YyjDR+ZBC2lTocGgfQ2KNrXuE6jpQ3C6hIWnRVg0IUa4LzaVpBp
	Yxz+Rvz6cVUGvR7xKqQ0WYx7kB5stF1v1ChcMy66X8IpgqfaGyS+li+O
X-Gm-Gg: AfdE7clTF30SKUvu4zfRpphJySm5WRJRPy4DVMuUGZgX9pLtwGmrzfgTWZYBC4SUuES
	B3zk7ENAzMu3rJWzuIPTEC5XnqBI7cTKwadKDwYyf8kdafyO/tOC4RahrSrmwp7nBoBDwIXlnLz
	XG62N5hJdReWQ4W4R5MC954bOvL47wUv7GYgQsNEwCYLA4A3GORCNoNM4pcKjCVAIzdv7K0lgbZ
	jkv2eTzVFOAVpQuWdY68VAD/0mvV8T69Rv9UT/JaXMKk44LySoqCEcIdeXqOwgZcP4wX+p2d8CR
	MzNUDReCcxPpX9VDQCT1zR89yn/KpEoIg/JB9vvce/ZK6dTwOL6ENRnvzr5igxszhKZ4xKu0zgQ
	IevRtIxAH2bWJUwWKTGE7DclS98fKYvdMpEMh46tKmgQXBwX6Wp3mHkQba1G8isR6mZhPGxoHe9
	5OXbYucEshwOsCwisGAiTAQNsq
X-Received: by 2002:a05:600d:6447:20b0:493:c194:4e7a with SMTP id 5b1f17b1804b1-493c2b382e8mr16151225e9.3.1782905482666;
        Wed, 01 Jul 2026 04:31:22 -0700 (PDT)
Received: from krava (37-188-177-177.red.o2.cz. [37.188.177.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475671d0403sm17059649f8f.29.2026.07.01.04.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 04:31:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Jul 2026 13:31:18 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv4 bpf-next 2/3] selftests/bpf: Add tracing_multi link
 info tests
Message-ID: <akT6hnLyJpFd-QLV@krava>
References: <20260629212208.895962-1-jolsa@kernel.org>
 <20260629212208.895962-3-jolsa@kernel.org>
 <20260629213407.11FB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629213407.11FB61F000E9@smtp.kernel.org>

On Mon, Jun 29, 2026 at 09:34:06PM +0000, sashiko-bot@kernel.org wrote:

SNIP

> > +static void verify_tracing_multi_invalid_user_buffer(int fd, const struct tmulti_target *targets)
> > +{
> > +	__u32 ids[TRACING_MULTI_CNT] = {};
> > +	struct bpf_link_info info;
> > +	__u32 len = sizeof(info);
> > +	int err, i;
> [ ... ]
> > +	/* Invalid addrs pointer -> EFAULT */
> > +	memset(&info, 0, sizeof(info));
> > +	info.tracing_multi.addrs = 0x1;
> > +	info.tracing_multi.count = TRACING_MULTI_CNT;
> > +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> > +	ASSERT_EQ(err, -EFAULT, "tracing_multi.bad_addrs");
> 
> [Severity: Medium]
> Will this test actually return -EFAULT?
> 
> By zeroing out the info struct before these checks, the mandatory ids
> pointer is left as NULL while count is non-zero. If the kernel validation
> logic eagerly rejects the missing ids array with -EINVAL before reaching
> the -EFAULT paths, won't this assertion fail?

there's no such eager reject in bpf_tracing_multi_link_fill_link_info,
the test passes

jirka
