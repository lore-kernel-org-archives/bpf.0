Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A423AE6F5
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299103; cv=none; b=Y8vUlrikvE3/VPk45FzIAZMFGmf8O+ot0KpIBK7xmLGtRZuTfMzbiUg+yIa0HWfNGojiN/nSOhGs+ef+qJgx+CZR+vBIsin3lmIMHAIqVdJCBtNockNyJPIGHQgrOoy4JSvX8hitO5rl1b46JPEPONMvETXWNjiyNsY4l3WnQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299103; c=relaxed/simple;
	bh=+zIe5NVPDKz8/Ej7QeLs9cHzLQjVNcAlMk5IFomQP7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAD36pq7ZBIWmjAVb8jPl0tyk6N7TwaRRlHmHsfJW/PLLHcu39ipJ5amA42S8vZJTMHaXwbtQySmwmXtFWkMLkCeTK/4R7o/diaPlMuvS5RIelEUOZxeORQWEJsPLftPLdRI/gOMel4QBqMR5D7qmyZbdUE1cBrVx6JOGAzL3uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KC/lqPVN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC/lqPVN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d049069377so6974265ad.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787299101; x=1787903901; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tGqZc2QCVfVmshUDzN/Ox9VPqNMMVTOEB7NVHdB7+5E=;
        b=KC/lqPVNo6ZzavEezjtZCjh/F53fKv7I2WSjrIZgBelEXaHCL8CQda/ioaAG9BOiSZ
         5zA61YnQOgIPeCJQeNt5wmn6rXP9M/vvu/snes10iZMFOzR5l47rSfBaccdVTEnnMJxf
         FHbdg5h09+5THtTMSNaNgE1n49j7bEpEHSptxVivLzsaCjyvO8AQGGFy4wdL3FLUW9cW
         P6MYqdiIV00/St+Fq1+gS4HC5EszpL2iOUfkX7oqe1K55LwkvYIYz16ddW09GpIcWCOs
         BGiqkA5pvnshjdH11Zf9SDKYNaZyMjOf89qtUkJjxablsk+k+0XCfvv32lZB1eiTHv5m
         2xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787299101; x=1787903901;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tGqZc2QCVfVmshUDzN/Ox9VPqNMMVTOEB7NVHdB7+5E=;
        b=Z/8iPX2BfugzVlZYy9OBTHjQ3wh8XgRBIckvzzSaFq46Vi+bmF5wiVfYMYPUiywSCz
         L6xl6wko/vmbORf1vcjnwD2S6e7tiGp6+08gDGXwKQW+TXguBmSw4pf64H3oQn/jxC2y
         /flQYavlrAebKsAuyeQQISFj89Aio87Tv5D/YkZgQdBkifpk2vlH3VPQ4uphPK/R/2pn
         ik3wG0IN+hK5Kuuy2VGE6UUzzEHl/uevia6dYKbuoeodQybYzng0+7eEUkLltJ4lCZ+3
         ioLns0eTejcop0JbRfXwHw+d47cIJRQmtn7jBvOGK++DGG0xbvSpmt07FgdME3Fe9O9T
         ADQw==
X-Gm-Message-State: AFuF++nc7H0u/rWum5mkEdmPlspWEiRIif4YP5oLjLb+lIN1BDKkea+0
	75u83dU1Whxbv+Ge/iHdRdx4owAWdOSEO+AE5ARKjmCuVbRsXCPQNtOn
X-Gm-Gg: AR+sD11YtM7QZwHFWFiEg/R/5zArMsS+nOg2Q58zW0S9/4uxL11joM2DBtCmt17OPVs
	7/TIalHSriyLAoJsOXjB1g3BYuYmZSivfiUuLxLaPBWoK5sg19EYVtSk/G7m3NzwEZ0SgDtDAjA
	j87mkHXgpea+xiXpoGdbZ9k2yhv2FX7EhSGvK9OHueBbL2+/d3TZjimnNJ+biGyqfQRH5Ged3bl
	dsjo8RNqfKLiOaQAi8fwdNLOylRBkt+p6G53X/BWC2gkocAQXMuQcLoXSElobqv1Nz1FzrYl385
	hQO1EjPENx0/4XO3CzxxxbU0DGafJL2JLlVXhJAxwMD0mUaOqPDez3hLHORsfz1F/KxdlHdzsYv
	C8/s4TpkCgMMz6e/zTDHFHMMNs+jPUISV0XyE65QRb1L1SE0pkbVq+9a6qj7NGvKGq4HzcWfgE2
	G1Hfp4Ngk4xOnvSjXhal2/+fUO49y9SkFa2m3uG6wr/Qh24+/3rbvvzwolNkVqZDHZ3w==
X-Received: by 2002:a17:903:b4e:b0:2d0:8b28:51ab with SMTP id d9443c01a7336-2d64af3a1e9mr91546415ad.7.1787299100851;
        Fri, 21 Aug 2026 00:58:20 -0700 (PDT)
Received: from omen-arch ([147.46.124.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3cf99csm15290755ad.74.2026.08.21.00.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 00:58:20 -0700 (PDT)
Date: Fri, 21 Aug 2026 16:58:11 +0900
From: Junseo Lim <zirajs7@gmail.com>
To: florent.revest@linux.dev
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Jose Fernandez <jose.fernandez@linux.dev>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
Message-ID: <aogAKH0PEmuOa--X@omen-arch>
References: <20260819122252.1782790-1-florent.revest@linux.dev>
 <aocadTp5OaOybxzT@omen-arch>
 <bc0edb11e07e0f6147e9c552805d0029c7aec7fc@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc0edb11e07e0f6147e9c552805d0029c7aec7fc@linux.dev>

On Thu, Aug 20, 2026 at 04:06:30PM +0000, florent.revest@linux.dev wrote:
> 20 août 2026 à 17:26 "Junseo Lim" <zirajs7@gmail.com mailto:zirajs7@gmail.com?to=%22Junseo%20Lim%22%20%3Czirajs7%40gmail.com%3E > a écrit:
> 
> > 
> > On Wed, Aug 19, 2026 at 12:22:50PM +0000, Florent Revest (Anthropic) wrote:
> > 
> > > 
> > > bpf_tramp_image_put() makes sure a trampoline image is not freed while
> > >  a task may still be running in it (call_rcu_tasks() + im->pcref), but
> > >  nothing similar is done for the progs called by that image. Since
> > >  commit e21aa341785c ("bpf: Fix fexit trampoline."), detach patches the
> > >  return path so that a task still in the original function skips the
> > >  fexit progs when it comes back, and counts on the prog's own RCU flavor
> > >  to cover a task that is inside a prog. On that basis the last prog
> > >  reference is dropped right away and the prog is freed after a single
> > >  RCU / RCU tasks trace grace period.
> > > 
> > >  [...] 
> > >  
> > >  Fix it by having the image take a reference on every prog it calls, in
> > >  bpf_tramp_image_alloc(), and drop them in bpf_tramp_image_free(). A
> > >  detached prog now stays loaded until the old image is gone, which
> > >  reverts a deliberate choice of commit e21aa341785c ("bpf: Fix fexit
> > >  trampoline."). Detached fexit progs still stop being called right away
> > >  since the return path is patched.
> > > 
> > This appears to be the same issue addressed by my earlier patch [1].
> > 
> > I think the flexible-array approach here is cleaner, so I'm fine with this
> > version going forward. Could you please carry the original Reported-by tag?
> > 
> > Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
> > 
> > [1] https://lore.kernel.org/bpf/20260815071927.147049-1-zirajs7@gmail.com/T/
> > 
> Oh wow, sorry, I had no idea we raced on this!
> 
> I also like the idea of guarding this with CONFIG_PREEMPTION and of
> course I don't mind adding your Reported-by tag in a v2. I'll give a bit
> of time for others to chime in first.

Just in case it helps with the CONFIG_PREEMPTION angle: Sashiko pointed out
on my patch that a CONFIG_PREEMPTION guard would leave the unlink/update
failure path uncovered on CONFIG_PREEMPTION=n.

So your unconditional version looks right to me.

Cheers,
Junseo
