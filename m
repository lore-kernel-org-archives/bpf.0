Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435DA3B2FFE
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973835; cv=none; b=VtBQj6efLluQ8cmhSEmdrtGNLDP2mnIr1L56Rv0iXjL+UTuFNL6HEPol/PW9+Rqna9ncWDbIy64DQbMhbP8AE1luLUuAUT54HZomqBB2ax8yx5Di6yrvONIsL1+Ktzl1eTa4Eun6dXUsw2U8mhQI+1W5DC2zbIj9DUxnh1hIOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973835; c=relaxed/simple;
	bh=PLzpJztQbgjm/R5Va8radS8LD2yn/Mx0BQLHJBtdPD8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoiKj+1JK5v5VAqeHNd0iEYzAu1bfx9x8/g3ujE+kSMRFJkBr0F0v1nBxnnlzyHZptydyfNl5o9CB/+IDSYaxkX8KWTs7WS1xEnekIWK8ftVKtYkYtf0FpHqD8z1k3xtEWvf0qm6qJmp7xxYJX+urT8PFG0hq6RdrWUK1KnPcqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVn506V3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVn506V3"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44e5624c053so7668487f8f.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 06:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779973833; x=1780578633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHBVfnpng1nZot2BKG6R34xKna8XhFOYG+DQ3zgnWPQ=;
        b=iVn506V3r32t/H6eQg2OfKIzby8YBUwmtLwMTUYuvgs7Qmeth4X2vFarJNZ8ELBWaC
         eTZuAlZeXyotCNsIv5b8qrqdFhExkUmdZr2HwBdG7Qtz0sd31ii5j92GlD4pXjDZ3zaU
         YQWkLnk94wW7QzAgKMlNCieNwquMlf7KvoNSwlXsiDJXPmUQW7tWOchhe1U1IdQYxDWp
         U8u0AmYheWYTOwtTtHLnuFstqBqQ9R8sGFWhy/269Tib8K4C0ecla76ufZwhPQ5y5l9S
         yhb737UXrcInBK3uF/EHwVLKVXa7EYVEvQMFlgu+5hN17p/JKpElL8iRp9cX/8PoPMcc
         ixMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973833; x=1780578633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHBVfnpng1nZot2BKG6R34xKna8XhFOYG+DQ3zgnWPQ=;
        b=OF7ErRFVCoYPnbPZ/OI9xy0DV75mebY8VX70z8SMVbKL/QW6FqllEU4DfYKRXGLTKF
         nU3zV4PPdiVNpCdsZbqFb1KeCMY51iU/hCipYSPpsYkc2k+IKqbYfZct3YO0Rcq3jmaG
         3qnPaFcaKUvmZlygB3g6AugsidBgMJVq0+rfHs3DNBWxZ954iDm1I6UcGl/nJYAGbmfO
         xsajXF/CkLWu6+5FL1Bpd1AEk2mBFxWisN2DrD7BgMghpiwIX+N+O9JejvPau6mFTpoI
         5Rkv5JCwV/VmenvipViCtr5nPiaaNZh3OfXztf6fvXtzt8+e6fVlsFY1cyNCPHq4d1QT
         LL2Q==
X-Gm-Message-State: AOJu0YwGH9Ct7tHCFUyved807lh7TI+6EZb7IFx2a8kDjI6k4pchSmjS
	4HNz4VlEHqCwDEMi9BZTIe8edbl/Tue1eZq8mWhvBagEM2cGoBGTnAberMKMvQ==
X-Gm-Gg: Acq92OEAS0Sdh2HGsMbNFvvBLJq2lslnXTCtWKxe95+26syXCeq0uwayWhl2D8ZD3zC
	7SIix/W+CEp24n/1S9W0DS7Ec/mqGyzpDQnDwyGmdr5VubJbJOkoWAQkzSmg2m4BI/hodgLMDla
	ISIYKgYcjKN8Jjz5XHRF/VHWCWAxCvH9sjGDPBe8yk30TkPw6Lm5vYyD8RKqfpcVcU4hbaiR/rh
	wKT0TYgYtvYCUY1+hJX9NTaAG+Wa3dDEDZj9R3dLtUP6JhjBFQC8cJwrg3GiU/JyLNsLlGGxVPp
	ILa9xwRgST7p+GEc6LV1yCC7H0lp+Dz1buV70ElITxAK2IaZmdkhQ2adWKMy5X2DJJhlsKeB21+
	rz9KT/oC/UinokQPXBuaIlQ5j9FyE3FEUjL8QTC3uTzADbtnej7kf7RjbymPL6zfzgZcmRNNwn1
	frQTvD1t0qMq4Du7ea1/hGSyNy4w==
X-Received: by 2002:a05:600c:5488:b0:490:47e0:e13f with SMTP id 5b1f17b1804b1-49047e0e21bmr455250105e9.3.1779973832567;
        Thu, 28 May 2026 06:10:32 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49091d57c0dsm64407835e9.0.2026.05.28.06.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:10:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 28 May 2026 15:10:30 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv6 bpf-next 01/29] ftrace: Add ftrace_hash_count function
Message-ID: <ahg-xtJiSHckH1LP@krava>
References: <20260527113951.46265-2-jolsa@kernel.org>
 <20260527115758.24F361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527115758.24F361F000E9@smtp.kernel.org>

On Wed, May 27, 2026 at 11:57:57AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing a fallback stub for `ftrace_hash_count` when `CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS` is disabled.
> --
> 
> commit 78dc69c9f694d0e9d50e5ac39e06f35ffd293fdf
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> ftrace: Add ftrace_hash_count function
> 
> This commit adds an external ftrace_hash_count() function to allow retrieving
> the hash count outside of the ftrace object.
> 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 28b30c6f10314..282da661f1313 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -551,6 +551,8 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
> >  
> >  void ftrace_stub_direct_tramp(void);
> >  
> > +unsigned long ftrace_hash_count(struct ftrace_hash *hash);
> > +
> >  #else
> 
> [Severity: Low]
> Is a fallback stub for ftrace_hash_count() needed here when
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS is disabled?
> 
> Other direct call functions in this header provide static inline fallbacks
> in the #else block. Since struct ftrace_hash is gated by the broader
> CONFIG_DYNAMIC_FTRACE config, if an external built-in caller uses this
> function on a kernel configured without direct calls, could this cause a
> build failure due to an implicit declaration?

yep, will add the stub

jirka
