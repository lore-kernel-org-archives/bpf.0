Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71133F8C4
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915675; cv=none; b=GuhgRdPBOu0N77LeFV9oMXGfA3e5bPByTvF2cr4x0+7MtkayePJUwiPywI+bTa09cmFbz2lUFNmVnBmqPY+nitanBYzA+U+bEo7TkNDpkWn4YzxwsDwrpIzvKDkhE9luNkiiQoRxGwoirsbcW8MeAdPEXxg6Z8tT96L0lq4A+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915675; c=relaxed/simple;
	bh=o2PYO+2b60S/GjJl+yXYHFr03aIZxeFIp6+uBk3T+Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFZn69kDrvrO+kSBUyEgRht5pQFzTyHaQIga9A7sYXRX//f9iIDuqLdqEfwsGQENwU8BkCHZQxkECSsQgUaQg9fA9BOkHIJcV41/aT8ICbp+uVvlkIMcWr8GNFCIT/FFhMCMUSgeSHu9KDirJfIePG+rkttrcet1SKkFPRYJNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kN9glXIu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN9glXIu"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so6065135e9.0
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 03:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773915669; x=1774520469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg22zT0Bx/qgk/yPL7dpvN4/kLV2NojO5WEGyzmt93E=;
        b=kN9glXIuhnH9RlVtxodAu4iCBZembYmbr3/bDI/oWFvA3uUYODE7s/mjg25iLu/rcE
         KRJWAR8VyZ1eXq4rpCPEy/mSof8GRlaV09uwOBJYIwE7NpG0ripK+MwynM5Wq2AQqpZK
         0ukBqZBmG3RrfuCJ2l2um1i81tyioUjWRv2fscAOAPQd2CO3jS2fnHmta2dOXIwdz/yF
         u+Ha+PCL9A+QgVepya49l06j5CDPEej3vGkZHZSGBlgHKFGNUc/H2W5MX5htzyQTogKF
         Mw0iJpvdQRQGj1Ijzp2dqkz38EgIYfDBn139DLBHouSJGuukV/5WmB+rhgxfqipIpb9G
         Mosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773915669; x=1774520469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg22zT0Bx/qgk/yPL7dpvN4/kLV2NojO5WEGyzmt93E=;
        b=LyIN4SOXYOnPB+FWcY+gf3ddNaoBnQNybN9Cltr+zFHINkRQmMBrV4ZfLPtAL6LTPs
         oOT7fZfdHYw3mhYilKvbK7abzFNxbjJ4D6cMj7psGowlFvrYtcAxGIxZCZkphGipAcqM
         qIY5UpskxPCyR1PX3TcbMEj+5Zzjg/ZiSGTB7ODzotquoNx4pWhcOJM/UnCU/yWFpVhe
         EFvbxHie5ZXa0FTCRWIck/Oxji4xkvTfNI9WXZwJOrosGUs0xfOFEKLbwc0Nc6dxv8vr
         USRVqwkAFVdCsC9L+2ASk5cCLs3lMKzT4ELN4EXZWwUkSt0lHHRQMYEAhV5z7lU4220J
         hj8A==
X-Forwarded-Encrypted: i=1; AJvYcCU/f+bVCJRV/ddQ4mCX8180OsCsLaIP3PkLT8UtLHFFXdvmOryDAt4Z4lp9fuhqlF67ZhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6ujfmjRYE/JR3S5q4pV8n6jJwJ7xeVACgWDfvW4jm87A0c5T
	SbbVUY9BIm09n6K7yOdqj/okfhDtPlq/WCFjM8J2Xphkckc8KamGcZlP
X-Gm-Gg: ATEYQzyMv8nDfS/JIw+WFnB1tNd5CYmNqe0Cd5Qb2KAeM78PNWIHdnHsMjbYBsHci2R
	DF2J7Yx0Fk2yVpT9Kyvr5CE9znitGm1YWdiLmaP/HOSFBYPjOdSjnZJrRpKCkwfOtUib75muez8
	1ukKyN7In3GE6lzfWmEWv/VjcnHXNb4g/01VQs4ntowvlPHbuF90Kjmr6WHBLAX8flpNPAaP7Bw
	TZrfmO+ibxl0d0+d9nsL8v39DvpAS3jnHziYPqH8NcCJgj1aSonQmuUl6i5irikQzAXAHnJTA3V
	kTvKRtGmDZO+bi9waTN7dtOdPy+IC7QcDuRBm+FKt42ndmh46wDYICXMzy4xdwwTSDd98QrwGD2
	1dt+mbUU4DjdqKmemWeTu4hP2tCHb/oKwVGofK5osOisTkLRt/EAWdS17lPTbcDFn8cJfDIUg1o
	tTM/k86TYExqY6ZdPdMFuRIL7oi5OrqiR36upJKfSTDyqFx/hQitaig6jGj9iw0bhL2kExuMl79
	FNY7Xt7IM6v8i+zF4l4894Amn0f4ail+DmwRgakHliedUljJ860DDt6qc4cK/A=
X-Received: by 2002:a05:600c:3551:b0:485:9a50:3369 with SMTP id 5b1f17b1804b1-486f456fe98mr114147895e9.29.1773915669043;
        Thu, 19 Mar 2026 03:21:09 -0700 (PDT)
Received: from mail.gmail.com (lfbn-ren-1-685-61.w81-53.abo.wanadoo.fr. [81.53.253.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4b74abdsm65073905e9.5.2026.03.19.03.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 03:21:08 -0700 (PDT)
Date: Thu, 19 Mar 2026 11:21:06 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, kernel-team@fb.com, yonghong.song@linux.dev,
	emil@etsalapatis.com, arighi@nvidia.com
Subject: Re: [PATCH bpf v2 1/2] bpf: refine u32/s32 bounds when ranges cross
 min/max boundary
Message-ID: <abvOEmcYyEcxl4O-@mail.gmail.com>
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
 <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>
 <aaocJ3gJr7019urU@Tunnel>
 <fd6a7d7fc0eee70b0b3053b1db34e9e986b2a067.camel@gmail.com>
 <aaoevIcblUpMyN3U@Tunnel>
 <bnw5mn5vwgezvhvzotrqcxfq5xixczjgzc2gj42565vnod5aai@rbwkdbuz5t3d>
 <abl1V9B56HSCKh3H@mail.gmail.com>
 <vnpbticzhrf4ke7xo6dklqipfstg5p62ccouurkxb66maotip2@3aexbucdvrr7>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vnpbticzhrf4ke7xo6dklqipfstg5p62ccouurkxb66maotip2@3aexbucdvrr7>

On Thu, Mar 19, 2026 at 03:03:07PM +0800, Shung-Hsi Yu wrote:
> On Tue, Mar 17, 2026 at 04:37:59PM +0100, Paul Chaignon wrote:
> > On Thu, Mar 12, 2026 at 02:45:47PM +0800, Shung-Hsi Yu wrote:
> > > On Fri, Mar 06, 2026 at 01:24:28AM +0100, Paul Chaignon wrote:
> > > > On Thu, Mar 05, 2026 at 04:18:42PM -0800, Eduard Zingerman wrote:
> > > > > On Fri, 2026-03-06 at 01:13 +0100, Paul Chaignon wrote:
> > > > > > On Thu, Mar 05, 2026 at 11:48:22AM -0800, Eduard Zingerman wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > > > > > index 0322f817d07be5d003c17dd7cedfa3aa4197678e..04938d0d431b38e086b50fe28b99e4ad2682742e 100644
> > > > > > > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > > > > > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > > > > > @@ -422,15 +422,69 @@ static bool is_valid_range(enum num_t t, struct range x)
> > > > 
> > > > [...]
> > > > 
> > > > > > Don't we usually put changes to this file in a separate commit, as for
> > > > > > test changes in general?
> > > > > 
> > > > > W/o this change the reg_bounds.c tests would fail.
> > > > > So far we tried to keep selftests passing for every commit,
> > > > > to help with any potential bisecting.
> > > 
> > > Similarly we have stable AUTOSEL tends to just pick up kernel/bpf/
> > > changes and not the selftests ones. e.g. both 76e954155b45 ("bpf:
> > > Introduce tnum_step to step through tnum's members") and efc11a667878
> > > ("bpf: Improve bounds when tnum has a single possible value") got picked
> > > for 6.18.17-rc1, but not 024cea2d647e "selftests/bpf: Avoid
> > > simplification of crafted bounds test".
> > 
> > I can send the selftest backports to the stable ml (unless you already
> > are on it?)
> 
> Requested in https://lore.kernel.org/all/xbjybmha7fdnnm5gn6p6jyppf4ud2r72rfabvej6egg545ozsu@a4qj43d3iu36/
> 
> We should be good now.

Thanks!

> 
> > Do you know if there's anything I could have done differently to have
> > the selftests picked up? ...
> 
> In this specific case above it would to be have the selftest change
> along with the kernel/bpf/verifier.c changes, all in one commit, like
> Eduard has reasoned.

I realized after sending that I was probably unclear. I meant anything I
could have done to have the *new* selftests picked up. From your answer
below, it sounds like no.

> 
> > Or maybe something we could change in AUTOSEL?
> 
> We can argue that the selftest was dependency that should go together,
> and that AUTOSEL should pick it up, but IIRC it is design to only pick
> up dependencies that comes before a commit. OTOH it would be nice to
> have it try picking up selftests in the same series whenever it picks a
> commit from there, but that sounds like a bigger ask.

Agree it would be nice but probably too much load for stable, even
assuming we have a fully-working stable BPF CI :(

> 
> ...
