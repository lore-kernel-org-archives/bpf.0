Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC1331619B
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 05:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773985794; cv=none; b=gC4UarA3mtaXa2XwkuS9Rv5Fh3NJ2FE/At9sKc2P8SEBv2n1pdc3zWUaxVHqK51sJ0vkmZyhe0JKfqF17fuz497KJ4sRVri/5JmU7IZuegdHmQ8GIh9HnVE8nUReIJUBw5TDShlyeUnDXs8O2725TikLX6HXp+fMQSzt7/cAJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773985794; c=relaxed/simple;
	bh=j841ON1V4ssRQqbrEc+wICqvo9SoGjW+2ze4r2T3WpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ttqf3pETZ6bNTb//vWv+7gWKgU4yEaRywF6wT9zjpHb/L9ksKpagUjw0ozfzUGcCvb+N381dLuf4wOOGc0Y0qFFG2WTJWNg3zfP3jhETjJrqON0XivancJ2Dnc/RUpsWfv7WFzQsEaRCYO8sz3cKB842d64hd/JHjDpf9Zvv28A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a0JlP3+V; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a0JlP3+V"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so10643375e9.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 22:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773985791; x=1774590591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0CCII3mWQme0aER5LS05slFBXGYSmM8F2zraKp/oeU=;
        b=a0JlP3+V78Vm7J3f5GSPjTzEux80CsKV1zCWdKE6pTtCERyYfUNdOdrbndVaUTXZ2X
         sWavYtosgksvO8VV8Tm3uSjMOdymKhwQBaNwViaeF6YJb8JcIFMAPVjdZ9plF870e1rE
         jUJEphxGccSrcMcnXNGkJLnntxXe5+30xkB8l/9jXitElcW8sisyr36e3IcZyqnr1ig0
         u2FiJSX33cvsYx6Xr3ntZl4veCyk82eVIu1Tj11ZLfPcn7C3FqHnHfaVtEaM7dEdVOGK
         qvSRCBts1RYqI8L/XI/KPgmn3nXHyU3VSP5/M/vIYIRZt0ajGpSMYgpqvK4VOSvzOyqS
         I3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773985791; x=1774590591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0CCII3mWQme0aER5LS05slFBXGYSmM8F2zraKp/oeU=;
        b=NludFJ1AM+d+Pd+KG6y/REpykPVoNwa2GDB+qnJZtXVCaaISX4lqjDxMFjct36n3wm
         vWFOrG3fu2SJdOW6XGGKZd2glxv6vhwSemCptBdArFCGJ4Zcd+EAKpxArSybI/FPt45b
         Nm9jFTdIHu0WJXHe6dqxewl+olmUhy4z6IukeDR3FUuVnDKvOah8WohaNVF90/uiQ7I8
         jmvJs37Uv2Nmk9yJqwgp144F+/t2lJmmwPQx/az08mr/KCl1mLR0FXse+k+JQrwSWCPG
         rcXKHX6vMVAZvFsSU3JKxbbNcPwK9A38oKnV0qIA9WOj68PBjCtqPX6ZvYBoGhMdznWb
         d9XQ==
X-Gm-Message-State: AOJu0Yy6fRnOshtwxU+ME4e8WXlaXf9fpDEWtqGIEsji1JeJaoLfB7SI
	/2SxVuhPRTJ/PvCj/WV/LSHJvYRyTTuYYMdPU39zGDlwVuUTkf2yZl2WyY6lh2N0Ltc=
X-Gm-Gg: ATEYQzyB1DRz2slsM1LKgnwrBvq/FlSoAQS3/0LCW39AUbgmoOVKvOI2cge8s/rXQk7
	pQYNmko9U3xPaE83NJRFdf9O18FG61vzhX2/Uzzm7lZaneI7NHbm9aotQlKZSHIx9p7atTDfl52
	xDgz9ueG9cCVABCw1DEQZkKTrw+X/BpRElg3pMtHMzp8Q5tKYe4R+FrKNXfur9tHvvP4nxbiydO
	+GPPuxhwlO+KdgfK5/X9iRnP3LHD1rWSEWz4q1CxXgtiHrmyqUgFXl4uUeZ3lZxy2EpYxe7fdlp
	ADM64E7utOz+s8M3SZ2plltSDxeGMTfS5fmi1aUwaz+L7YmTm/cCr2FKcpEQZ9HYvfuEF8N/LyL
	euAM+Ac053L+jcTwmS6a+PFosjMVWvvFAsMo0OImC4XDv5CWR9m1pbKlUJac+/9ne8/Qk3zQjIu
	ULTKmWZ/HCdX47mdFQeA==
X-Received: by 2002:a05:600c:8883:b0:486:feb7:f2a with SMTP id 5b1f17b1804b1-486feb70f41mr20242685e9.13.1773985791074;
        Thu, 19 Mar 2026 22:49:51 -0700 (PDT)
Received: from u94a ([2401:e180:8dfc:66a:a219:10d5:f609:370a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a938743sm817306a12.19.2026.03.19.22.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:49:50 -0700 (PDT)
Date: Fri, 20 Mar 2026 13:49:44 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Simulate branches to prune based on
 range violations
Message-ID: <eeg4rhy4om2sx7w7wvtujn7hddp7wq5c2rwylr5azdt5yur7md@mhj5zl2j372p>
References: <cover.1773441432.git.paul.chaignon@gmail.com>
 <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
 <swmeukekw55emiwcduoq4jpjk6hwqk7nzxbcs4xgw4mir5ldd7@mqyinrubwmlo>
 <abs6SmlOId9IVidk@mail.gmail.com>
 <rqymt2p6ypkk7wv3jzhm4zkbyfg2b5fyvia6bdfp6mdbzzqcmz@qvt2rb4ul2p5>
 <abwuyFR6wh7xQfpO@mail.gmail.com>
 <abwvosbAmLJM7PiB@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abwvosbAmLJM7PiB@mail.gmail.com>

On Thu, Mar 19, 2026 at 06:17:22PM +0100, Paul Chaignon wrote:
> On Thu, Mar 19, 2026 at 06:13:48PM +0100, Paul Chaignon wrote:
> > On Thu, Mar 19, 2026 at 03:09:10PM +0800, Shung-Hsi Yu wrote:
> > > On Thu, Mar 19, 2026 at 12:50:34AM +0100, Paul Chaignon wrote:
> > > > On Tue, Mar 17, 2026 at 02:14:48PM +0800, Shung-Hsi Yu wrote:
> > > > > On Fri, Mar 13, 2026 at 11:54:43PM +0100, Paul Chaignon wrote:
> > 
> > [...]
> > 
> > > > Yes, that's definitely a good point. We probably don't even want to
> > > > backport this to stable kernels (at least not until we've built more
> > > > confidence via syzbot). We'll drop the tag.
> > > 
> > > I was actually hoping to get it into stable as soon as it merged, heh,
> > > but make sense.
> > > 
> > > You would have to actively reply the AUTOSEL selection email sent to you
> > > once this merged though, even without the fixes tag it would still
> > > likely bit picked up; I'm not sure the exact AUTOSEL criteria and it
> > > seem LLM-based right now, but given this says "fix" and "syzbot" I doubt
> > > it will overlook this.
> > 
> > That makes me think Checkpatch will likely complain about the missing
> > tag as soon as I repost without it, right?

Perhaps.

> > Given I'll need to answer to
> > the AUTOSEL email anyway, maybe it makes sense to keep a Fixes tag.
> > Would a Fixes: 5f99f312bd3b ("bpf: add register bounds sanity checks
> > and sanitization") make more sense here?

I would just drop the fixes tag, and if AUTOSEL picks it up (which it
should, based on what I have seen) and land in stable, that fine. If
there is something wrong with the patchset, we'll have follow up in
bpf-next, that should also be picked up be AUTOSEL (given it should have
a fixes tag that points to this commit).

Basically, just let AUTOSEL do its thing. Should make life easier for
you.

Rejecting AUTOSEL is more work because you have to then:
1. Answer the AUTOSEL email and provide a reason
2. Manually ask it to be backported / send it yourself to stable

Certainly not wrong to be careful with stable by withholding, just that
I find the back and forth might not be the best use of your time.

> Uh, that's already what I added :facepalm: Thankfully, vacation is only
> hours away... :)

:D

> > > > > > Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> > > > > > Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
> > > > > > Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > > > > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > > > > Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> > > > > ...
