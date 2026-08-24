Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCE15A85A
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576489; cv=none; b=fJwkoIvo4r0v/idyl8CvEPfPlK9/2TxayvpHp0RgE156+vdIOFpL76yRBvT4/3LpoDo547VXehv925e89blMDsTuWYcxNTb/Ufierpo+Lqud6SdwK5EMCK1rWPyKalLsO944w/zdkfxbfejVKBunxdIy3BXcvrJN/NCI7GlUeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576489; c=relaxed/simple;
	bh=ehxKGCl2X5B/1IOEDTS8ANSWyiXGlGGYkVM+GEl+HLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Axwd3bmhxTh6y4G47itTmQlZ3KvrnNlLN44pAM5wD0gx/AxtdB4iawwi37deTS98txdv6+YPVhHI1Wpfb2IE5INV1h6K0byIOAOUlfdUTXaoaWwoe9yc6HcOszUvNYy6y+lGAKkg7a2/pGOaKM81LGibnJJZw/943+XQV+F4024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PPdsAzEP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PPdsAzEP"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso484422566b.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787576486; x=1788181286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pt4qchYiVKMNGY6XXirkSLkRJOx81JgmCbFLO8XAS28=;
        b=PPdsAzEP3WR9fvnlFoRlYtxYSiDozQMMHC4ZXgewlGOcwDFeQ645JfMX7C42tRY/49
         6gIN4/uDQmWmZIbslqJEpVZarkog0pIMOSSPoXTaJuSSIAk4AWikZFmrYQ++1xoptHy3
         sZN55sbNhSpwRjTWxv6oFT9KRHNX8xE1SON7ZHr4rxpG9cJNMY/z65a20aLOgd6vWJIk
         rloEXodPJDiav2FDGESPTM7wsewJ02nqq8PnbqhyRjv2gg6ylI1hiOGie3a1siFsCIDk
         cGtfDbUX/v2rjd/DmXcIcYy7/9vfbOqsu7Yvb35OD0bCR5HK7YgdvnpYJS4Yq+NSgiwa
         sGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576486; x=1788181286;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pt4qchYiVKMNGY6XXirkSLkRJOx81JgmCbFLO8XAS28=;
        b=Kyh3hWI7F0aaZ/spCDCM++YE9S9TalOW88L5fojFAlpwtBwPw4RQBnLhDcNIne4iPp
         Ydz5jRwV42Zfq8JC2XojG9pRThwf8b5uyJtkGsQ+nkg2Im1uMVbqjHDmpsrGgVEe1WC/
         3n5VedCAcFRBFs/RgDsbNy0wm+4mDU3EL42DdnbcaNXzPSvA3ellZ/xzgVJ7fmdat60x
         DUqY2dV4oA1VYnfVdNFRZ3rdIuPqVXcJD2iVWf2IEtbEjXtfN6G9qM76gTbFhRx2vWLE
         qi6bggzdiMix0ZC5KRREDHh3XHYxbNp9y1niNIC7El0mRdDwXr7q9lZF2TLe6l5rZEa7
         uu6Q==
X-Gm-Message-State: AFuF++nWfS4gyvWSCeIFV8hoplxReOMsbaFY3z0SilQ6zh4kFkvj1kUa
	lh0SwSawyk+yDAcxFTvsvi9F+JRzy3Wnp9fSHsqWzx7h7TZoObgHol+e+jlZpYoLpm8=
X-Gm-Gg: AR+sD12bo4KlWxxfD1MHy/GtgBx6pw5JCpMFGHIvyHWIYDGtTrX1UUrFHhbm06NWSht
	hxi+Scj+1WNTl21n+bdRzjb4LL1AidDO2JSI1sxTvwHBZe9t17bFRxyxpMsoJ8/0IJ2CFczz1st
	x6iuhX9BXzXWr+Ny3qHYIFQVT+ZKW4Nw4Or2q8v+KbWab/NHLObDXX8jCpib4Nb3/6EDl5d8rP/
	NOeM4+o8gG3PF+pvfv2FwtiHwBnv0oYX/Te69UHUwcFHRzD+Lp7pIswLf7tBFUEpLhoYunQgyaz
	VuMrjw2I7sv3IDVzaxRm6oICofAO9IZCQwNYqP0/VIQLxxb2ePR7GyIq7Q8IBj/7TeD5PaBxUlU
	F4yyvwrn2ZzhsEEJvHeDG01ySuUTqF8XQwDS8Uekx7QaBlGLG0bHhWNzbIIbJIl8hxYyRNwEm4k
	sDpS54v8wI3Ht5MsKdS1pbFqF83k7cWDcrURFvnlYk7UmWrr6/pjno+qV5d0qWyChDB0eWg8j2+
	g==
X-Received: by 2002:a17:907:930a:b0:c1c:6f0d:5b22 with SMTP id a640c23a62f3a-c246a654342mr3127903466b.11.1787576485993;
        Mon, 24 Aug 2026 06:01:25 -0700 (PDT)
Received: from localhost (109-81-81-112.rct.o2.cz. [109.81.81.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249672becesm1294715466b.42.2026.08.24.06.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:01:25 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:01:23 +0200
From: Michal Hocko <mhocko@suse.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add a sleepable page allocator for
 map memory
Message-ID: <aoxAo6gDK00PeCzG@tiehlicka>
References: <20260821050250.35112-1-jiayuan.chen@linux.dev>
 <20260821050631.39784-1-jiayuan.chen@linux.dev>
 <aow4YNCDa0gDwbfj@tiehlicka>
 <de12ff1b-2f7c-4efe-ba1f-95e0b8d259f2@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de12ff1b-2f7c-4efe-ba1f-95e0b8d259f2@linux.dev>

On Mon 24-08-26 20:44:18, Jiayuan Chen wrote:
> 
> On 8/24/26 8:26 PM, Michal Hocko wrote:
> > On Fri 21-08-26 13:06:12, Jiayuan Chen wrote:
> > > bpf_map_alloc_pages() picks the allocator via can_alloc_pages(), a
> > > conservative guess for BPF program context that is always false under
> > > PREEMPT_RT. So even a caller that really is sleepable gets the
> > > non-blocking allocator, which never reclaims and never engages the OOM
> > > machinery.
> > I thought one of the main motivations was reentrancy. As you cannot
> > really assume the context bpf_map_alloc_pages is called from there is an
> > extra care needed so that this doesn't re-enter the allocator from bpf
> > program called from allocator path and deadlock.
> 
> 
> Agreed, bpf_map_alloc_pages() is designed to be safe to run in any context.
> 
> The commit message should be precise.

How do you achive any level of safety for the _sleepable version? Vast
majority of the kernel is sleepable but that doesn't mean this is safe
from the mm reentrancy POV.

-- 
Michal Hocko
SUSE Labs
