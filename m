Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6943EBF39
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596148; cv=none; b=VAv25hpLsRoIFsfP5EaFlgAAIgRv7YdHAv7cAuWHkgezsOPzyCKCLV/qSJZVcClq6WRAN/1xlCNiih9bHuC98D5YqGiADdSWOatmR9VmlTjUwCPXrgzccWG4sqabPI6W/VAdS9/exzyeP+bLeZWFwyJqsvXMGmqU38GZ5AGs7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596148; c=relaxed/simple;
	bh=5pnm51SSmefadHjuQ6GqaWmk6s9rdsyTyQAbSYWv1xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+5gkj6VzOmK1Cqjn4KUah8WkXqV1N3ONywhRODWvvY3wvP+xV84sDAek+rVEHL0sQjucrRJbup8BOS95Q2542fBMS0EuVO7t4N3k50N5DHt+KZUnc9YqRFMY7aDlkvEEB7LK9LzJeCJM2i3YpTdQu59LKq57r2I/2IY0KpP144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtNiW5bm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtNiW5bm"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso18171095e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771596145; x=1772200945; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=micEVXezFuZ5V8pAvMdzgq/Q1xm4QZUZIHUHlGXwD5I=;
        b=JtNiW5bmWFn+qsla4+dchjV0vbbu6WbKA4BvotIWPsAH2FuztDT7GMTeDBuTkMrPxk
         hb7IaKnEAFzAoWiNDe+pbzWlpRRYwNk3I7NSRRg3i/s/JMW+DLcwsIW4PaSmtXgmOBva
         ZSgM1ztyQgSFUZvl7Pmu7KSOY7X+miqKlIhdM/3id1XIc14OBViatg3xwKZ7loxxIYe5
         i5iW74vGq3jkOCPtNBmm5ZBYfjyOUIH98wGV4ye3HReLezb8/Wk13VOccErIpLS73AkK
         HlAvWzTm8luJOuydEkdCcafwYGVnHrrEBT4bWgz1/7+6+1++lioP6FTQoV9hJMt05a7N
         gSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771596145; x=1772200945;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=micEVXezFuZ5V8pAvMdzgq/Q1xm4QZUZIHUHlGXwD5I=;
        b=dfiZE6d1jq/zgOu4anQINAqXLaPL5nAaDllX3yay9y8oYGtMf0oaDONayS6B0RP1nw
         TtIjyEN3P3fOWfTAfTzmftsRgKM+ylsAosrKCUG/lnTZwm5kkZIdHhVtSk13FxnYviem
         XNuUvNYWlfg75T5MtiEfZG/fE/M3rN4LrvRFu8T/3Uagk+lvlJLbwoftrt3RtfLfjtL6
         91m30OAcH+zqdksregB4MFZHZexX/991MQniPXBruYw4cSkJnAxLHXmVxhzl8LLnPhj4
         rYieS8dQGsdeRGBrk2n1f4W6d+PFk5o/tDwFRR+SSBmQlmK26NkyjGz5vq8S1hm1wKxg
         p/dw==
X-Forwarded-Encrypted: i=1; AJvYcCXPznoOQ5LZ/2I72Md1FNO+alPsJb6BbJBSjxoOvPK6yanK0z1GKk2WCtwiRFFBcK+ePfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCcBLZRIzBY43pg5ZSvwGEBaAS7je0zMBKngjKvep2gXPUIFFS
	u1fU1lVk/et1WFuSLl5Z6M8tg/3787sJm5XC1lnT701le7l61UdZpWb9
X-Gm-Gg: AZuq6aLhJ2CEu6L9+47cubyE6ySaFwZoM7r5KaEGbZUmkN+YRfo+PxrstHZnlLYmAGz
	R3lSUfwdxYRk4l0sWoF5IFqACrKrKJsjxHwAX2midbLXTGGdeAgZu1weRV0xWzuzrGooUdgF6yT
	cJPpHTe2QH9JS9E8kqP6PeCDEgVRePH9/xPLOQFS2sysUHP6YKusgPvnHe63gdkuLaZyrAehxiz
	7C/QI+ffEHD0b75+qONchQg+Gjqa+gJkKDTd6Vc0AkLzDa9RKPyGxsfxDW8m8R3MkTR13YjVwPT
	IlSayUXsFMhZjzmaXWjeXY1tmsuNPW7xoU28BOrYLA75DaXiOI3OGofnFI877asDbiY7HkbQ/kB
	gBP/HlQueCwtrQyIZE5tfxDvAQsip6qQ2of+mzmk1moNTY5ckElbAjXi0iVLNw3R8+Jxn19x5pf
	jtE6KxmXdjYjzcJEx3v7crZ+ZUxVqA5sQULk/5X0dleDWShtzXByKchggRK9GU4Hzwxz88nqy8H
	iAvZX6lfam25S0xj+n94Khz/PBtLJL9XMUd0fl1r4MIO6WfHIBNyUV4Q8NywmE0DtAguO2bl9I=
X-Received: by 2002:a05:600c:35c3:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-483a55343c9mr35737045e9.21.1771596144696;
        Fri, 20 Feb 2026 06:02:24 -0800 (PST)
Received: from Tunnel (2a01cb09b01c9b546fd5ffb86f392ee0.ipv6.abo.wanadoo.fr. [2a01:cb09:b01c:9b54:6fd5:ffb8:6f39:2ee0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a316c2aasm71581625e9.0.2026.02.20.06.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 06:02:23 -0800 (PST)
Date: Fri, 20 Feb 2026 15:02:20 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH bpf 2/4] bpf: Improve bounds when tnum has a single
 possible value
Message-ID: <aZhpbEF7h1kDLb-N@Tunnel>
References: <cover.1771316309.git.paul.chaignon@gmail.com>
 <5299e75f8807c7c49ec048e821f25a6dfef2c6cc.1771316309.git.paul.chaignon@gmail.com>
 <12705b3d58569685048804c33e90755c17667cbf.camel@gmail.com>
 <CAM=Ch06Vg-faG9ukU4DAsF9FRG2PeUtYHh3BkG0dOzYi=WDCyg@mail.gmail.com>
 <5044b1d83c3c916c0754eb5556008316c36c15ae.camel@gmail.com>
 <aZdcoaH9ERUNpln1@mail.gmail.com>
 <aZenQb3H5g73Bhz9@mail.gmail.com>
 <7b696c92e56dc560154818484cb35def2639cbf2.camel@gmail.com>
 <CAM=Ch04aEBi0eCtemGRBO0xFcPs5Av5T=AqQwQxGcNSJ2nAQ9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM=Ch04aEBi0eCtemGRBO0xFcPs5Av5T=AqQwQxGcNSJ2nAQ9Q@mail.gmail.com>

On Fri, Feb 20, 2026 at 01:34:26AM -0500, Harishankar Vishwanathan wrote:
> On Thu, Feb 19, 2026 at 8:29 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> [...]
> > >     tnum_next = tnum_step(reg->var_off, reg->umin_value);
> > >     umin_in_tnum = (reg->umin_value & ~reg->var_off.mask) == reg->var_off.value;
> > >     tmax = reg->var_off.value | reg->var_off.mask;
> > >     if (tnum_next > reg->umax_value) {
> > >         /* The u64 range and the tnum only overlap in umin.
> > >          * u64:  ---[xxxxxx]-----
> > >          * tnum: --xx----------x-
> > >          */        ^
> > >         ___mark_reg_known(reg, reg->umin_value);
> > >     } else if (!umin_in_tnum && tnum_next == tmax) {
> > >         /* The u64 range and the tnum only overlap in the maximum value
> > >          * represented by the tnum, called tmax.
> > >          * u64:  ---[xxxxxx]-----
> > >          * tnum: xx-----x--------
> > >          */
> > >         ___mark_reg_known(reg, tmax);
> > >     } else if (!umin_in_tnum && tnum_next <= reg->umax_value &&
> > >        tnum_step(reg->var_off, tnum_next) > reg->umax_value) {
> > >         /* The u64 range and the tnum only overlap once in between umin
> > >          * (excluded) and umax.
> > >          * u64:  ---[xxxxxx]-----
> > >          * tnum: xx----x-------x-
> > >          */
> > >         ___mark_reg_known(reg, tnum_next);
> > >     }
> > >
> > > Wdyt?
> >
> > This makes sense, I missed this nuance in the original patch.
> > Maybe keep the first check as 'umin_in_tnum && tnum_next > reg->umax_value',
> > then?
> 
> I too think Eduard's suggestion makes sense. We will be explicit in
> the code that
> we want umin to be part of the tnum.

Agree, it helps readability. I've sent the v2 with that change.

Thanks everyone!
