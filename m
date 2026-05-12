Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B9E383304
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551632; cv=none; b=cfFfDLthIVo6eDdA3vbm9W6HII0gql7uWRp8M6SyS3IyuGFZnB5c0JsCf8nZIjWgRCNBb54fkeC7NmX7goeTlFymb4sBI1kTe7wPhVxecyU71+zLQjN6KT9Xqm9wYkcN23n/V9Zbmeqb3oEcukGhQKnWIqPl+fyefw6MRog+wag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551632; c=relaxed/simple;
	bh=uCnPTczXRGCjJkasxe+ExAASvngVWa567A59zopNH78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrTYYC68mekSgQ8o5USHH5WgFsnBIiMyt8s3O/pykdHmDtRMygNQ5ngRne+8oBl8GAq+1JJkLC/+q+8htzom8Xdd/DEC9n/94jXojrhQ1px3ZESG2zM0K6xzmB1ZOVPn50NHY9w+9NKHRd0M0Z6ndTJwd6/oSyzNCMMZOqKWqQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qEX44jXZ; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEX44jXZ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65c364b893aso4823289d50.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 19:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778551630; x=1779156430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMuUQCVEJE6aMa+W2DJMi+Yspl9yx7h60YzqRdzSdYs=;
        b=qEX44jXZoqKunEwLInD4vegNkHUxXDMpLjzhapkeKedn0NWiljYo6bSn86utQGiYoO
         4gEDC694xsrmFZ8tAjwJSai0mhMoRVufGfdeRusiB9nXlWh6w+o0IblRrljigm7b4jsp
         svoGYUJIAfJ3z5gtf1m5rPXBw0ONg62/Fc016aQOuRDwDzJuO4yKSix6HGB8wb97Yb65
         k6+6nwiDO7KbFKazEcFPr1VVqnn8gZXMOKmvB4rL7Ce++ScCceLQCKq/oHeaTF/ZEQNl
         i3KJbLJcNNJQQK9x8aWlVQ1GAPJMoogfZtPzvDkh8M2JRCtIki6OVG2XPYfbRwlyMIbP
         jWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551630; x=1779156430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMuUQCVEJE6aMa+W2DJMi+Yspl9yx7h60YzqRdzSdYs=;
        b=dGqHrAdzgn/r9dF4fZ2kmOVOwuGANgJnUS/5RTXgAWlwkHjO9akjLekLHlyXC7sP6m
         pdQzUvlO9lRUUo/qzShlKIupTHAvHR4MkWNe9AehgXml1Hxut3g51UR8Hogq2dor12Cr
         KNHtzUUydi9GqnINI4KUS9DIgwdWuVTybwj49xTTy1r2RZAHJ496A5eR9k3wcNwLAGEh
         2aDofOnmeKm5HufpVcRr/owj7EksIb8ULgUymVZol6GFOvLZ0hDVTyYCyJPWRHDlwjZQ
         sSChitbr3AXFVeRxwjbJ0t6HDPe3I4rXqlwq9bAnhs53uJ0NTDVbrDb3qlDAU7qs9ozT
         oGog==
X-Forwarded-Encrypted: i=1; AFNElJ9yDlkzArSrNmL2e/ynf8kONCqzIna+03fpzMqoJfIOfLR7LFLHHwQmmFIqzitW6aJTjUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDCBTlJyaBO56FJPZedHn4Yk5oaz7NInQ2DdDtaVheIOZGOxW
	BMNTOAGlPXQg5rcsUa8ejdwMhA41Ed7cOXboYiVH91Fkq/skLh6oJrIf
X-Gm-Gg: Acq92OF/K1zMKOGdlVJK1IS+xvjZFgX/4ZLazjBbZ1l5rCcgqleI2cON+tKTKdMeLZv
	kdrdYVJTxwwK+EtG6CSGy/zK5ceNtlj89B7aDPUytPT+dB/oNkB9ebKFzhaYrxcxB7ByjEUKU53
	JTkhu2YabI+wzBfmQdcwD10I2hVX6D9C7gzjr+8FW39NvbE+1Qbe5R1yxtl/8zBezharXc0ck4i
	d6H8E2V7CLuE0MXTl4wHQ2fDiXl+8lVCUhx1cCLDtUANBFZJWw9P9U5sH9/mPBG57fHVeMc4rKN
	wzyRZLRahRZvHTmeLm4FYjRTwLuRbXA7M+4BwXVrwuYzdh93/mduCAJ3nlT2pFLJRTq17psBYn2
	PZ9cKuMtu0ECJHJYiHCeJCbiK59tbcLTn6R0ndphlMDMmkkom+64XRNc9etIbfISnTO50GkYeyd
	q0LTAGSDGfa+cdsmYQuQvORD2OcV6c3mrEDbhu4+BJpbEn8GY3Fow8Ew28jA==
X-Received: by 2002:a05:690e:1282:b0:65c:ed33:bda5 with SMTP id 956f58d0204a3-65d94901e32mr16907981d50.0.1778551630402;
        Mon, 11 May 2026 19:07:10 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6d1b:2c6f:d117:7f3e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66019105sm159044777b3.0.2026.05.11.19.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:07:09 -0700 (PDT)
Date: Mon, 11 May 2026 22:07:09 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, sashiko@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
Message-ID: <agKJzaG6U9-XppgE@zenbox>
References: <agCXEJKJh-JGMhjG@zenbox>
 <CAADnVQJdFCFJcg0Pqdnx=D2h5vHj_q4mrwSJYxRC5RW0NTFNvQ@mail.gmail.com>
 <agEnc0aYMhuIeDlq@zenbox>
 <DIFYUK5DKGAT.189D9YYSQFCUZ@gmail.com>
 <agH_0MEw4b0pB11-@suesslenovo>
 <DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com>
 <CAP01T75942V+wKJD0yhs8yb7U5vj+y9s6efJ+UdpTMfzP31CWg@mail.gmail.com>
 <agKBE4Ci4_LmJ1Dc@zenbox>
 <CAP01T76i3S93kvXnQvK+NU1ee82s+ka2jQfmf-yL86r9AS2tuQ@mail.gmail.com>
 <DIGBOYWXZ95S.3GAGVQGUJNQD4@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIGBOYWXZ95S.3GAGVQGUJNQD4@gmail.com>

On Mon, May 11, 2026 at 06:55:50PM -0700, Alexei Starovoitov wrote:
> On Mon May 11, 2026 at 6:46 PM PDT, Kumar Kartikeya Dwivedi wrote:
> > On Tue, 12 May 2026 at 03:43, Justin Suess <utilityemal77@gmail.com> wrote:
> >>
> >> On Mon, May 11, 2026 at 10:10:07PM +0200, Kumar Kartikeya Dwivedi wrote:
> >> > On Mon, 11 May 2026 at 19:29, Alexei Starovoitov
> >> > <alexei.starovoitov@gmail.com> wrote:
> > There is no deferral here. I'm saying that we just cancel for timer,
> > wq, task work, and leave other fields as is. So we don't have active
> > work pending for async items.
> >
> > So as long as the item keeps getting recycled in the allocator, we
> > don't free these fields. Once the memalloc is destroyed, the dtor runs
> > in a known safe context where we can assume bpf_obj_free_fields won't
> > deadlock or run into any problems.
> 
> So the plan is to do
> if (in_nmi()) && case BPF_KPTR* | BPF_LIST_HEAD | BPF_RB_ROOT
> just ignore it?
> And no other changes anywhere at all?
> 
> That would be too good to be true :)
I guess the last question I have is what would prevent an xchg() out of
a map on a recycled kptr from causing a UAF?
