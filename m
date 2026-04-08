Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8D137D138
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646659; cv=none; b=f1sKFmpWYnbnXOw4QHFjJiJyYAHs24RKSKxjNvbpHXOJ6moDRJhdcztRZHBuUmaajzXashbDjhbu7nOVsqxnL5sgrMNONtIvLbKirpRTf2+imVSFgj5sBxFvWW1mPKxp1CFDtumRiu5F0cijY3awIKQGcWg2iBXQfrHs+1BrU6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646659; c=relaxed/simple;
	bh=jFZjtktr1182f8BWsVbMJEHb9H4MNzz+xm/vLv4K1D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkmVUilLTU6kbJoeuT8rtyqacqCYPQEFjJL61eiYXjr645dHB5ajNwR96xMzlmtMkyO96mj+bWJ+qsiuxi6VPxVhAdw1gxvXS3+SF86XBI+hEnA2ZAcBqhZe7KIZAHU/WSjsJcs8VU7B4gEUhOtYhVmcp6/jTQZkded0hv3vnoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Scmo/EJ+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Scmo/EJ+"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so5356896f8f.2
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775646656; x=1776251456; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vfllRBgwiwa3h1YU32+J/3Xslzo7VJyKCR+sEXLOPdc=;
        b=Scmo/EJ+ekij29gx2CQSx27ITvBa/vg71uKIqGTyxtvEoc4ODr3I/8+pVOEglOpK5I
         SdoOTFP/ha9+eVfICmbo0AzaEr19G0QV/cuuk1hpEbANdcMkGMfbx+aWtl8hzDIW4BYr
         jh3bse40AqusVWoyFJ6OXswjb3tJ+cistJiPXnDN4VH/eeSTUcUjDVAs0thGX3gj84nM
         120ormNdhG6+CXwLNBhFFxSBrOPv6HEKau4TWb+kov0R4vstoPeApF6eKOom2WziCJXg
         hIpV6UhWkn1RNLiIwElYZdwXLNDEqIapPndFCkO97e6UYivlHNWsGpcc6NfE1DxXokHM
         bd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775646656; x=1776251456;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfllRBgwiwa3h1YU32+J/3Xslzo7VJyKCR+sEXLOPdc=;
        b=GpF2ZQOid1AVQwyTYI6+iE6LIw6q9VWlkeHmwXFvF1N/SPxLwI5Q/qRZcNRg3lhXUY
         3Xf9rEFeHLjN2eRHtwtaBEWy9Sbgq4Iv138boQnxN0Q8GE1WWjUwpKvu2K93bVaVY5b2
         Ky3scQW/c596sEjm67xLxfkEAXQJAp3fn6Ke4LEaTUbdn1CEa5gJZndd1yEIkt+jemP6
         oh03glHptgtkYg+shYhW4Y1XQdtt4sj74LVkk6UuC6r/6UWyRAfETo38O49SVKJY/+Yk
         H4GojcHHMcUNr5vBivC+eiWLOylnnYJpr3REiYp/Ee0eCV1pHuitSMNQz3F+5xITSq9l
         K2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU1tI268eBV7k2MzkryqKK2JaITxjbPamsS9k2/kmVEoMCPpoViK1pZ0Fd04bnzVvHlt18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb24rJpMMbhKWua2+Of1oJaGMnLamAPeLL42FqNOulQ/AC3Mva
	8bee0IFc6OXokelD67i3n6fkFoXPug3vtpV1gv/b61ma7VfTov2cYJpopxiWWVqg8Rk=
X-Gm-Gg: AeBDieu/74MEgTYcprFUPFLVx1a57DJ2rmjM53kOOj0OnE+evwoMICAZpkfWyMRkcUw
	74tE6x2saTqTaILpLxQ3pJ3oJ8aef6E5Pz02cF0KSaPb3NzvC6tARHt2m3bd9dC5nRi4HGy63Vg
	4ABzdhaeT2KiIk6+H+9BIk4DYSwQysZ7KfqdZrjqztkVYgtHdshoQdhEqX2uNslAIjGuJ9OTtGc
	UhYpGPfRmtVArnMnGQJgmQ5mY63o5Wijd3NZY53N1WaBv2VBis2UYBEAF12g8AdrRSpbNLigsQe
	lJOKj6CVxNPRnVmq3N+vEeuQYpMRI0PYCgXa6Bo1M+TAyl48voLGDZ9BDBS71pUb7BzRZrIgqe5
	iuMmAeosQV1hMbXMZnbddy234usV7nKWZZB8PTTNahu5tEV7TKo78P00GIyxrVEvQKohvTalN7C
	Uy3jQlrAg8bevQZq8rt29FixMdKg==
X-Received: by 2002:a05:6000:2282:b0:43b:54c9:85f4 with SMTP id ffacd0b85a97d-43d292df407mr31359155f8f.39.1775646656473;
        Wed, 08 Apr 2026 04:10:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f73sm61649889f8f.8.2026.04.08.04.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 04:10:55 -0700 (PDT)
Date: Wed, 8 Apr 2026 13:10:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Song Liu <song@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	kpsingh@kernel.org, mattbobrowski@google.com, jolsa@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	yonghong.song@linux.dev, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to
 klp_patch
Message-ID: <adY3vej2kt5joAg4@pathway.suse.cz>
References: <CADBMgpy3e25EH5xbKMN5GeOK47jE6uzviknbt35V49_Y7zFj8A@mail.gmail.com>
 <CAPhsuW6p3YOv3_M_c0ThMcrNqNjT=7i46ekJBrWO_oGzQkxrxA@mail.gmail.com>
 <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
 <CAPhsuW4B00-grg9XJa+AO3xgGwM_u8FC+GH3JrkYZOJx4PuV8Q@mail.gmail.com>
 <adQhpBC2W9I6QW-g@redhat.com>
 <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
 <CALOAHbDN_t-ZRO0g9_sQFCv0J6SPDFfwJCcwSzd4ww5XRkU0QA@mail.gmail.com>
 <CALOAHbCxPA0dtsx7L2kYn8wwBdM=krZyOpfRTBiDW9qfA_zmzQ@mail.gmail.com>
 <adUd0Mojbtrwmeod@pathway.suse.cz>
 <CAPhsuW7JhtbniZHFWGMrzeqdS=-EjCySFPgiOBv0zKJNRwzONA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7JhtbniZHFWGMrzeqdS=-EjCySFPgiOBv0zKJNRwzONA@mail.gmail.com>

On Tue 2026-04-07 16:09:39, Song Liu wrote:
> On Tue, Apr 7, 2026 at 8:08 AM Petr Mladek <pmladek@suse.com> wrote:
> [...]
> > > + * @replace:   replace tag:
> > > + *             = 0: Atomic replace is disabled; however, this patch remains
> > > + *                  eligible to be superseded by others.
> >
> > This is weird semantic. Which livepatch tag would be allowed to
> > supersede it, please?
> >
> > Do we still need this category?
> >
> > > + *             > 0: Atomic replace is enabled. Only existing patches with a
> > > + *                  matching replace tag will be superseded.
> > >   * @list:      list node for global list of actively used patches
> > >   * @kobj:      kobject for sysfs resources
> > >   * @obj_list:  dynamic list of the object entries
> > > @@ -137,7 +141,7 @@ struct klp_patch {
> > >         struct module *mod;
> > >         struct klp_object *objs;
> > >         struct klp_state *states;
> > > -       bool replace;
> > > +       unsigned int replace;
> >
> > This already breaks the backward compatibility by changing the type
> > and semantic of this field.
> 
> I was thinking if replace=0 means no replace, it is still backward
> compatible. Did I miss something?

IMHO, the semantic of the no-replace mode would be strange if
we introduce the hybrid mode. Especially, it would be strange when
it can be replaced by any livepatch with random replace tag/set.
Also it would just complicate the definition and detection of conflicts.

I am going to provide more details in the reply to Yafang.

Best Regards,
Petr
