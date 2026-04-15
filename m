Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9831324B2C
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250161; cv=none; b=RyJsmkksbIGE68+HfK/yg4veqUCmNOCRE3YpjM5JZzOHVQtEmvm4P5SO2S7MFawRertSWLu5tQCVz+C1qNg/+TQlFV6OdoASPmthGNPKVXPykcxqEWC4E9iv1zPua9R83Qt7oIX7w6acJJ6o5M8GFlZh7JxVRSxIZndgp8PPepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250161; c=relaxed/simple;
	bh=I14BmVJXxDlFKWq3Os4T8qNRubEmA8Q6L1/fdrYthtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ool0vT2ekqoOZ5AKoLfvhSt5AQFGMa4w7AChfv3hph1UpcwSq/0GRb7sADsRzUukNDGVrFLM9o6BFyu4ty9cK/CatSIPwxebm4uL34FMhzlhvVUiY5XVK11zOgirn2sfltEtNjNJT8Iem+w7oRQb6GCgI/BG3XL2KB4BZXYVX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh8JYbuO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh8JYbuO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso36783435e9.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 03:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776250158; x=1776854958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZ9DolBx7oWdXo3o6819JtHACfT0Arv3+O2nQR4ONHw=;
        b=fh8JYbuOCDpbruvidBGWBQuBZYEKgfABTnvMaU9xKt2U368d/RKO85iGcStVv/vCXR
         JAKpRSyA+fS+WxHGoDEgx4+CkB97KIqj85t2XT6Yh6HsAaBI9ZPvfohH+C+6grrvDsOb
         ATke8z6NNQyfIndN8tDitiO1gVAiBoj4aQSNPKxyuuumZ9rQHqFfM6YALdR5AYI78TrA
         Gf+g4WXAQwrGfkrXtP+fzfVC5e0V1UdKPwh6mgZYtF0nvAiaV4c+fRGQ84c3QY4uaapN
         WgbDpwrNNdEko6p21Ojk6zo74pAzvcfxjR9SKe57hsGGinjF2izXnQN6SjuIm4ZXH1lg
         3UiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776250158; x=1776854958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZ9DolBx7oWdXo3o6819JtHACfT0Arv3+O2nQR4ONHw=;
        b=WHbtXHOJA0mVR0CiZ14DHDOiJa9gZSMEubHPIWFV56TcsTveEG6GJRPsH/E+NBKT4z
         Uo147/+l7VvPNbYlDVUOUMmAVDJIiF0r2TasBCGmOBgx0YquWg0GItWrOnOkcFI06rbo
         8x9dmX2JwmnT/CjbqBPFRC+pMUi/wYH3F1e5RWNhuYBXibDe2+DbVkQj9HE6oyT3hHIz
         vyRKjnQdQOTMBLrOz+WibKwbwoofTC6QAAyPnBi5OTjdlH/Q0cEDSE+6xg8QNRuHhJpC
         gpr03oye9BGYCoq6Rsmu2a+cz1tCzVaZ9o84Blv73FW2ETPAMfFK1orG3nkRuXduQ5z7
         aqlg==
X-Gm-Message-State: AOJu0YyF5HB//+mJDb76uFTzXDcZV2Z+Fe1bmoJHxtAgDE2Ec9BA3AkU
	2S540GXfz7LPQnn1QjJFlXfAAAS8s6u7nF91yoSo/+fe6rX1wSUSQOAY
X-Gm-Gg: AeBDievWriGwfQNBuuWXVFKpPtdDlSVp2IGygpslgYdq7VBc2JzvD6aXhABZJpsz1FX
	gSEDz+CwqBovPXcrjc90UXRGdx7q9/mSLWR7lOggohoXTnk1AFNcqnFR2kSXs8+wJF10HM9Iqcd
	D1NLKTh8WCmmQPlCRobCx3CKB5IVaCNmaD2ojRfFOvw0O8fQptlaGtMuZCZjB2KFt/CYjnhnHfE
	aCb/eVkvEoxM1pf9lwece5YktXU4wBRgoEQCAF/q71GYYQbmhaninA61KFMt+ajoibwBzmVPuZN
	zvzouCNCaaKVprXmRl1ecBq4/0tUtD9n/0MYHhSowHyrgqw2d8qTq/hHoQKpdY0rH9xWTNZ2gNw
	YrnopTI6ftY+29AKI3AV856FsNTU66nN3UJFdvatilt1vGw85xjTo8H8AwG/ytLiCxBvW0JxOTW
	QnXihCjoBHy9jCSFJfSkJDkwXpO/ww+AdqdLnEJkejEBsgnkrCbTELSbTT6nVxCLQEecQIKFpzl
	z/ELpcBFCENqTx1s/P2LKKPbowvqPZl2GLTKKP8IEpdPpPy9Z+kISHuWi+LVL/r+iMT4N4MZB5L
	T7lz/fyIXPHcuavc7ay3G+PEEfblPPJeSvyZkQIC/hyBmRfytkhOFA==
X-Received: by 2002:a05:600c:a109:b0:488:a977:8de with SMTP id 5b1f17b1804b1-488d6839866mr202485885e9.16.1776250158106;
        Wed, 15 Apr 2026 03:49:18 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e002eae79bbf3d352f3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:2eae:79bb:f3d3:52f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f095ceeesm22206885e9.8.2026.04.15.03.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:49:17 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:49:15 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
	alan.maguire@oracle.com, kernel@uniontech.com
Subject: Re: [PATCH bpf v2 1/2] bpf: allow UTF-8 literals in
 bpf_bprintf_prepare()
Message-ID: <ad9tK74n_7J4FGtq@mail.gmail.com>
References: <20260415032126.1096299-1-dingyihan@uniontech.com>
 <20260415032126.1096299-2-dingyihan@uniontech.com>
 <ad9sKyzvsYqgu_yY@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad9sKyzvsYqgu_yY@mail.gmail.com>

On Wed, Apr 15, 2026 at 12:45:02PM +0200, Paul Chaignon wrote:
> On Wed, Apr 15, 2026 at 11:21:25AM +0800, Yihan Ding wrote:
> > bpf_bprintf_prepare() only needs ASCII parsing for conversion
> > specifiers. Plain text can safely carry bytes >= 0x80, so allow
> > UTF-8 literals outside '%' sequences while keeping ASCII control
> > bytes rejected and format specifiers ASCII-only.
> > 
> > This keeps existing parsing rules for format directives unchanged,
> > while allowing helpers such as bpf_trace_printk() to emit UTF-8
> > literal text.
> > 
> > Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
> > Suggested-by: Paul Chaignon <paul.chaignon@gmail.com>
> 
> I don't think this tag is appropriate here. If you want to give credit
> for changes made after reviews, you can do so in the Changelogs of the
> cover letter :)
> 
> > Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> > ---
> >  kernel/bpf/helpers.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 6eb6c82ed2ee..6319b39c92f9 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -845,7 +845,13 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
> >  		data->buf = buffers->buf;
> >  
> >  	for (i = 0; i < fmt_size; i++) {
> > -		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
> > +		unsigned char c = fmt[i];
> > +
> > +		/*
> > +		 * Permit bytes >= 0x80 in plain text so UTF-8 literals can pass
> > +		 * through unchanged, while still rejecting ASCII control bytes.
> > +		 */
> > +		if (isascii(c) && !isprint(c) && !isspace(c)) {
> >  			err = -EINVAL;
> >  			goto out;
> >  		}
> > @@ -867,6 +873,14 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
> >  		 * always access fmt[i + 1], in the worst case it will be a 0
> >  		 */
> >  		i++;
> > +		/*
> > +		 * The format parser below only understands ASCII conversion
> > +		 * specifiers and modifiers, so reject non-ASCII after '%'.
> > +		 */
> > +		if (!isascii((unsigned char)fmt[i])) {
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> 
> Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

Actually, this patch will require changes to fixup the existing
test_snprintf_negative() selftest that is currently failing. That fixup
needs to be in this commit to not break selftests during bisections.

> 
> >  
> >  		/* skip optional "[0 +-][num]" width formatting field */
> >  		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
> > -- 
> > 2.20.1
