Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5E30ACF2
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720200; cv=none; b=NZQksqaolAMaPOgoAy4Aa3hD/oOG05HXGjGFMxsytIqEpJuRRz7ygilvQXn7PoGpLnpM8pQH3GUrOUP8wEoQDVy0+HHjH1POmWvgFVvCmcg3MexaNYK9toUknTMVErJ570u+LLOrW9Qz8pdetvFlUt48QI3E45a2ZpsnE9fi+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720200; c=relaxed/simple;
	bh=bWM+n0PuIclSzxSg8yrCMqDB9BwasgmhRhRSh6nIcUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX75LLDvtex4ZBoN2CWtqgjj87nZIyzc83cmuyOL/FXetN6yu/zAmMqIBF1fZNFptir31bIxRvYxaHVx0yDMqNCi+sQ7YwJ7AXAD+gD4C2FFXfqivbjMLSfWJUqJM4SZlORh53q2Y9WYCxMlfzjK1gEQp84wYrnTLYRIYGYXhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cBCYfFvr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cBCYfFvr"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso8138845e9.3
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 00:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775720195; x=1776324995; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SFIAOrBx/Kk6hQbOqlmoeLP19Ql72j2A2UxB1/jbKYA=;
        b=cBCYfFvrs1geXGepneF48LzQAgmUYgVNSWs7NXsWvzAB3JeKpKS0eBD5D5iChjgId+
         XNhLodDX3OaRT+lCWCtHl9GTXt/zd38gGDyImjK8v9vMtNhrHkXOOMzmj6Fdg2Furs96
         CXJTnqHnFDvRGXQxeCu2v0MTKtkmYolX5VYeXL2UMLxG1wGALEF8xs4oouz47G6tMxnT
         bPdop31V4ZUG1STY5xZiVloB76UIThDBi4FQmNNDVxG/14vJ5zFWqYi6lZgzj2+Q9Oyl
         e5fFK3GsAcb7JbJ94z0YXEon477481XH7PfwuKCFveYFAPEEucllZwaOSVVhuP7X7a4J
         betQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775720195; x=1776324995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFIAOrBx/Kk6hQbOqlmoeLP19Ql72j2A2UxB1/jbKYA=;
        b=Qhom+tee78PR2tWZaPeS5Cz+o13J0QO+dAFZXA90BVCTY5BMEG+Mso+8UhY7WVly0h
         Fig+LjoYPi2qK67NDG1tIA4N3MLyzFYIEmaruCbTrlA+7jMqz37+caPtzkiflKcvHd8O
         /ueuzWbnX1TLwNzRiGOMl30+ysmcMKZNv4jKHK+fuHxp7EOtjypMPXCMnLFFUPvtSZDY
         n9/v1qUX8n29HlgUCm+9WdkV001scXAN45UA28gR/O9fjeKzFDL4p8p2kGBjfOdcQI44
         AMw41ejevBnKujtBoau7EBBy+azsNsFYHQou0t913kDG0+dAVAx+aIOeMZ95/9jDsj8r
         ZMHw==
X-Forwarded-Encrypted: i=1; AJvYcCUeFUaTNZxk9Y4wx1MmtfSHrLSltYVzF/xd53tanz+6Pq8MBMWO5Es1UUS+fiatPc+Ouho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnAp9uciYHiOZkDMTxkha9/I2hskk35orHZCZKVecgLtsvYqZQ
	SwnjUlB7t2Ta8xXPgDsu8zB1KbUJEhZu5T/rv768beWZzj7UFsA4fIZe/gFsNc0NVww=
X-Gm-Gg: AeBDiessW+vyljFQC7hw4xqVBw5r9TaOMHtV1ngSnL2Y20n7XYchYF2AWfCfP8FNsVu
	gblmdYIMlq38Xwsp7Srg9/a8P7o9+AQdDvfIzJnr9CTeyzzxsMNAIKlF4eV9d45XtWLveqrcQVg
	ssE5cxeIzwwffLrOLp/gg/Oh+oxlBRFg8kFyOr/KTBZjjzGXa3/scXmXLAvkNLKBVQtgllHq7UX
	h7qSPJKUTW1TrTXQ/TToaS55v3FXsVNT/NBVxEDFKR3OgP0TF3d+S+WH/uaVsaVqmsgmEdDspia
	uSQ0w6ueuAd1P1V6dlcmY6X73WAr/YoIsdb6kwL69tzOQky235RkEVphUolAv2zkB05DZ/MAjj2
	nTHpkKAAiBvpnd0KUDv9ccl4lKeBm0uXm+/yNslYeUKe/33e1Y7TLwaBt8ZVZoXXh/o2HaVxPJs
	YsSRzrisKFgpA22pFpllfjBcyh/A==
X-Received: by 2002:a05:600c:4753:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-4889976eb60mr333821525e9.13.1775720194684;
        Thu, 09 Apr 2026 00:36:34 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd19ea83sm81192215e9.1.2026.04.09.00.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 00:36:34 -0700 (PDT)
Date: Thu, 9 Apr 2026 09:36:31 +0200
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
Message-ID: <addW_-whBavyHY-Z@pathway.suse.cz>
References: <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
 <CAPhsuW4B00-grg9XJa+AO3xgGwM_u8FC+GH3JrkYZOJx4PuV8Q@mail.gmail.com>
 <adQhpBC2W9I6QW-g@redhat.com>
 <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
 <CALOAHbDN_t-ZRO0g9_sQFCv0J6SPDFfwJCcwSzd4ww5XRkU0QA@mail.gmail.com>
 <CALOAHbCxPA0dtsx7L2kYn8wwBdM=krZyOpfRTBiDW9qfA_zmzQ@mail.gmail.com>
 <adUd0Mojbtrwmeod@pathway.suse.cz>
 <CALOAHbDG9mq1iJv5suct=cqJ+2r8VvJ-dXN=nuvMw0XYqnUjxA@mail.gmail.com>
 <adY_WgA54CDtWBq6@pathway.suse.cz>
 <CAPhsuW42WqGuZ1Z-RG0yzifZ7rh=XKUa5hKb6JxLeTWdc4s4-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW42WqGuZ1Z-RG0yzifZ7rh=XKUa5hKb6JxLeTWdc4s4-A@mail.gmail.com>

On Wed 2026-04-08 11:19:50, Song Liu wrote:
> On Wed, Apr 8, 2026 at 4:43 AM Petr Mladek <pmladek@suse.com> wrote:
> [...]
> > > >
> > > > This is weird semantic. Which livepatch tag would be allowed to
> > > > supersede it, please?
> > > >
> > > > Do we still need this category?
> > >
> > > It can be superseded by any livepatch that has a non-zero tag set.
> >
> > And this exactly the weird thing.
> >
> > A patch with the .replace flag set is supposed to obsolete all already
> > installed livepatches. It means that it should provide all existing
> > fixes and features.
> >
> > Now, we want to introduce a replace flag/set which would allow to
> > replace/obsolete only the livepatch with the same tag/set number.
> > And we want to prevent conflicts by making sure that livepatches with
> > different tag/set number will never livepatch the same function.
> >
> > Obviously, livepatches with different tag/set number could not
> > obsolete the same no-replace livepatch. They would need to livepatch
> > the same functions touched by the no-replace livepatch and would
> > conflict.
> >
> > So, I suggest to remove the no-replace mode completely. It should
> > not be needed. A livepatch which should be installed in parallel
> > will simply use another unique tag/set number.
> 
> I think I see your point now. Existing code works as:
> - replace=false doesn't replace anything
> - replace=true replaces everything
> 
> If we assume false=0 and true=1, it is technically possible to define:
> - replace_set=0 doesn't replace anything
> - replace_set=1 replaces everything
> - replace_set=2+ only replace the same replace_set

Yes. This well describes my point.

> This is probably a little too complicated.
> 
> > > This ensures backward compatibility: while a non-atomic-replace
> > > livepatch can be superseded by an atomic-replace one, the reverse is
> > > not permitted—an atomic-replace livepatch cannot be superseded by a
> > > non-atomic one.
> >
> > IMHO, the backward compatibility would just create complexity and mess
> > in this case.
> 
> Given that livepatch is for expert users, I think we can make this work
> without backward compatibility. But breaking compatibility is always not
> preferred.

I believe that it is acceptable because:

  1. It was always hard to combine no-replace and replace livepatches.
     I wonder if anyone combines them at all.

  2. I believe that nobody tries to load the same livepatch module on
     different kernel versions. Instead, everyone prepares a custom
     livepatch module for each livepatched kernel version/release.

     And the tooling for creating livepatches will need to be updated
     to use "number" instead of "true/false" anyway.

That said, it is easier to always use "0" for non-replace patches
instead of assigning an unique "number" to avoid replacing. But
I do not think that this would justify the complexity of having
different semantic for 0, 1, and 2+ replace_set numbers.

Best Regards,
Petr
