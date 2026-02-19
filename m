Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284B2C1589
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527336; cv=none; b=dpT1gDvrLSks02t9jZ6QeAb8TPW0DoEzfZb4EURuD6BgrerGLVQl6tHTox2kh1p6xSenGemP4WlMTIBo63W6DkHcX5MOu5Rfy9ocmnmWTr5HjZFrtbbQc3JUMtSp/VgvPIzWTEio/pukd0OMnS3Wm65V4PbziNaMIYItRddygCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527336; c=relaxed/simple;
	bh=2Cb5zh20bmwGGQBLSAfaO5bmgC947DHW4t2/0HnJdjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qpz20w62uJOyL9n/r8nEbDrbCv7HAZvHGguINDfzW9RU69VwZzshDTrlwti0E/fgvIIVYa0YrHQzVkIXXqV+RwndpiLWL7v3vHyCy1NMMvjmowOM4/i/L0+OMGNdFulP8bKgrnz7G9qR0tJrRT3c6/EfYpzrpS6NTlXUzyPLHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRWg3b8e; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRWg3b8e"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so8321325e9.0
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 10:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771527333; x=1772132133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dIKrq95o5SOyigqVdpPCfaICoavwfRBP5sPiRtItYU0=;
        b=fRWg3b8eDCzvxvuUha1lj3H4hqNbJojhTuPS+hK+Akp540AeRz4MOzurKMTEI+DTJe
         UqRN8o8OCBBMmgzDaxZpNA+6nzjOWsSexq0lmVW91HbXOX7XnROE6F5PIyIbbMt/g2E7
         wzoAEWt0fXQXuhJdNXwKcp7dJ8UaIKpmEl+lIDxQjYD+e6Hpzmh+dUhhIzPpbeDe1TQ4
         mfvtmM2eTyQYspGxf9X85+A2hoOsbXBJCOysW316k/P2qjQxiNWGCsjEXHKe1414PFMU
         ACIh/h9ufuLVPjEptG+SzSAUp5iCV+TE03/XkNTEMBlq/ijlVOustAcS3nb8jC3XtHbE
         /MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771527333; x=1772132133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIKrq95o5SOyigqVdpPCfaICoavwfRBP5sPiRtItYU0=;
        b=dsQOPSi1WgzvuGvDTH+cDtRwQwsgBLnTasUw86A3ghMjRUzPds9a4APfkHdm9lVnpn
         AYKqpkQ1uOsLsOepKoi0EM/3861C4hO1g4rxW+gex83Np+Ukh6EP+j6osF9iLOWEA+aL
         1cqmvGRkY+nxGVGitY/xc4GDoI4csoY/tKDEqFlUP2NlqALZ2HI8vSpTaZO4Lfz/9Up6
         bOdgbFBDwh0FmG0cGecZQUQ4lT6KqRhIAmUTDYCNDliQHeVS3U+YxYs8IpyDE9ZbYOTs
         LJry7m3SmTJE9DcJNxXKf89k0p7Z/WfI+j4W/6eVm3sqvGIy7Ms+zaXBQvInxB5ELupf
         ghlg==
X-Forwarded-Encrypted: i=1; AJvYcCUZDSw9NJSE+lcQ/ib+sSSmIcz72OpGFbE2Uwl50r3wMlC0jiqboRtzDbOvs1nRE+0StwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6sxYLm31smZLPFni6DJEB9bBylGYNvI71TBVTLrHp5bxXEl//
	bhShQlAh35IltKDNykNC8ncczsyYcjjn2ssh8D77UcoRnZ5WJCsnLfqi
X-Gm-Gg: AZuq6aKkb2rdUBbnyOsja6Jn6Kc8brOxVkDHioijX5xSoWRUoCbQbF2enmutOnV8bd9
	4rIgvEyXAPqj7BliSnn6giVhc1YHfAVdgNvfo6ThnRqXXBKdJMCyKpAWFifgf1vSkpjuelmjF7A
	6xEjcB6aRTH20ZLSoZ8+m0ulgX+oBJsELss6P4riTun8+hbWxkaDxDivhUqEsfZd/LtdE9R8LmS
	KRxI6rJhMt3dTtutKkAsjhCEh3iHSX97JeP/0BqoCdTljqI6c3Qg+pxixI+lbo9PppzSYlEtyLa
	doZgbQ2+DOBtKavuv1rwsPMUlAHOy9Zstaw9d/tipesw62ZojrXPz31ROP0ixdLmMGAI0zmH5re
	584t3y4enC1D9Ht7+gZ+3xQrxHrY8BVIFLF/ibUYEjkXgFYf9y8Tacpqa2zJ6hwrkjOirryJ02v
	JwzXetB32X/qVhCAIC8cJLyW/rlZdH/bbaRNsZx/H+vIWWAynCsDcZU0ZQwLqEg395bBn35ID7N
	raKzPzizQxAn7mgDoK9kWXMIjzg9ZjCxDU2cjC535S/fTSYvuApyu0A46raVQlISygRgtSVasBW
	TIySISqONPO+C6ZFtklIkw==
X-Received: by 2002:a05:600d:6409:20b0:483:96d8:9f75 with SMTP id 5b1f17b1804b1-48396d89fafmr92254285e9.28.1771527333072;
        Thu, 19 Feb 2026 10:55:33 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e007aa252361bd08e0a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7aa2:5236:1bd0:8e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b3e0dsm33500985e9.1.2026.02.19.10.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 10:55:32 -0800 (PST)
Date: Thu, 19 Feb 2026 19:55:29 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH bpf 2/4] bpf: Improve bounds when tnum has a single
 possible value
Message-ID: <aZdcoaH9ERUNpln1@mail.gmail.com>
References: <cover.1771316309.git.paul.chaignon@gmail.com>
 <5299e75f8807c7c49ec048e821f25a6dfef2c6cc.1771316309.git.paul.chaignon@gmail.com>
 <12705b3d58569685048804c33e90755c17667cbf.camel@gmail.com>
 <CAM=Ch06Vg-faG9ukU4DAsF9FRG2PeUtYHh3BkG0dOzYi=WDCyg@mail.gmail.com>
 <5044b1d83c3c916c0754eb5556008316c36c15ae.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5044b1d83c3c916c0754eb5556008316c36c15ae.camel@gmail.com>

On Thu, Feb 19, 2026 at 10:32:19AM -0800, Eduard Zingerman wrote:
> On Wed, 2026-02-18 at 01:06 -0500, Harishankar Vishwanathan wrote:
> > On Tue, Feb 17, 2026 at 5:58 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > [...]
> > > > 1. The u64 range and the tnum only overlap in umin.
> > > >    u64:  ---[xxxxxx]-----
> > > >    tnum: --xx----------x-
> > > I think this hunk should be rewritten as follows:
> > > 
> > >         tnum_next = tnum_step(reg->var_off, reg->umin_value);
> > >         tnum_max = reg->var_off.value | reg->var_off.mask;
> > >         tnum_min = reg->var_off.value;
> > >         if (tnum_next > reg->umax_value) {
> > >                 /* The only overlap is umin */
> > >                 ___mark_reg_known(reg, tnum_min);
> > >         } else if (tnum_min < reg->umin_value && tnum_next == tnum_max) {
> > >                 /* The only overlap is tmax */
> > >                 ___mark_reg_known(reg, tnum_next);
> > >         } else if (tnum_next <= reg->umax_value &&
> > >                    tnum_step(reg->var_off, tnum_next) > reg->umax_value) {
> > >                 ___mark_reg_known(reg, tnum_next);
> > >         }
> > > 
> > > - At-least to me, it easier to understand this way.

Agree. That looks easier to parse to me too. Thanks!

> > 
> > We can also use tmin and tmax, like tnum_step from the previous commit does,
> > to keep things consistent.
> > 
> > > - There is no need to gate the condition `tnum_next > reg->umax_value`,
> > >   if next tnum overshoots the reg->umax_value then only tnum_min is left.
> > 
> 
> Hi Harishankar,
> 
> Sorry for delayed response.
> 
> > The guard helps avoid the case where u64 and tnum have no intersection:
> > u64:  ---[xxxxxx]-----
> > tnum: x------------x-
> > 
> > The entire condition for "only overlap of tnum is with umin" needs to check both
> > (1) if umin is a member of var_off
> > (2) if the next member of var_off after umin > umax.
> 
> Right before the hunk there is:
> 
>   reg->umin_value = max(reg->umin_value, reg->var_off.value);
> 
> Which implies that:
> 
>   tnum_min <= reg->umin_value
> 
> My mental model for register sync functions is that all ranges are
> considered valid, hence I suggested dropping the check.

I think I agree with that, especially considering the reg->umin_value
computation above. If we think we need extra checks to be on the safe
side, they should probably live in reg_bounds_sanity_check.

> If you think the check should be preserved, maybe still rewrite it like:
> 
>   tnum_min == reg->umin_value && tnum_next > reg->umax_value
> 
> That's a bit easier to parse compared to
> '(reg->umin_value & ~reg->var_off.mask) == reg->var_off.value'.
> Wdyt?
> 
> > 
> > > - Accidentally, it fixes the scx_cosmos regression
> > >   (probably, because first condition is relaxed).
> 
> I double-checked scx_cosmos with current master, patch as posted and
> patch with my changes, in all three cases I see:
> 
> File              Program             Verdict  Insns
> ----------------  ------------------  -------  -----
> scx_cosmos.bpf.o  cosmos_select_cpu   success    475
> 
> So, I'm not sure why CI flagged this as +500%.

Ok, that's reassuring. I was going crazy trying to understand how your
changes could have fixed this given the semantics should be unchanged.

I'm re-testing the patchset on Cilium just to be sure, and I'll send a
v2 afterward. Thanks for the review!
