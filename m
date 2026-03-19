Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242BF271443
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940648; cv=none; b=TdLwH2OONbdEoFtWSuN0YbUMUxLsky16VCFrjnNYRTTq0VL2sLfdF8YIgEDPAnqICAbNQutMSsDQ/lzjmcoUU3G5ntanS5sYE/tos/N/Js6GxmQ3s2FcoSJHLnYb7+X2T78Z9q0lgS0eqM/GnCi308KJ0FQWDwdVUbyt1nU52s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940648; c=relaxed/simple;
	bh=2xeFmYdYDNQWuWONqYWVn0UNh8i1OYs1x+kaqJ8XxVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rE1BSqUYFmJgIoNCop18Z46kVsj3JAjdIfMVfvn7I4pWDDQLyt26bm9FwZ6WT8MXlU2Na6lRN8aTKrRly+HelyPmACeNKCJUX43grXRg3qNbbo4xUmz5Pt8AI+CitDrJuFN9NngOWo5ekekbMC1bzmbCIQtYl3irpwvgqSq8lfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuGCCG7K; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuGCCG7K"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so15655865e9.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 10:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773940645; x=1774545445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VbhBAMSwBIe/ULuaudcr2IqT2Nm+ULrsxmqcW7Kgg+Q=;
        b=fuGCCG7KxvcSYjPrGcRpk9INQLx69ZECEMn0482CWK+Gnwtlo6C3TUlJGHSbD6dGl5
         UQGwC0ati6V/gytTIqat7l6vElhKj0wIuPoXc6pfKUU14W4L6RPt3b1wXr3GsEynisTy
         nRkdtCabpuZ3iYD6UTIpTbAtub5DvfBT7Bunb3TLk16YJokxj0RxMA8CTrusghBtwamg
         q0Gvwo9o8zkuymsei+AtJibOBFqlhx1on8OwCmhQNQlnCmud8ixkSwPjryzJwY5aXf4O
         APe3uKCp9sa2yDuIltg0p9Vux93HqdJ5oimBKdvp0R8gl7Nf2yo+IU6v81eKPX25FHbU
         v0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773940645; x=1774545445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbhBAMSwBIe/ULuaudcr2IqT2Nm+ULrsxmqcW7Kgg+Q=;
        b=C1uLyBZL2qoZ0MQkQUbAtn1xVaoxcu+xh43/t2gqHQyK7N0f41F0Gud22BuWQr8cqx
         yXzXSpCpdGStLJl7+Vt0v/eyE7IFZc3e/7Oboqk/NVTRu7yxt+7YDjrzzi42/+pybzQi
         L/CinYFpa80YDL/7yz4KzEWizP5t6nYdOd2qHta9w8kmsXL8rekcC1R7DHmWI8m5Sr35
         DEQnIVnYOIitcsR1BA/qCrtbmtPfPErjXJwoRY1+C0KBagzvIEI9r4ZerfNuEKAflG+4
         mQsbe2wzwm8SgDLHQ3haYKdSzHurKA0+Yexjfe5GHXpvSjYlsFFe3j4MT60Xjbi+ue+g
         9ybw==
X-Gm-Message-State: AOJu0Yz8QONmHT8ZuPohL+OLPPx/wfhshir92xJXXyZ6uv/nRklmWwAU
	xUz+wiCrEA3CjQ4gzgfgQ+eQDmS5y9/6KbIoeAgUtuckNyqAfmHa/WGM
X-Gm-Gg: ATEYQzyY8Lot6OASU13J3ZgYM9P2JCkin9N1WtA5Bm7AUJERx/8pqxFRokJIldrCft1
	Z0qUsOzB/IL85dmGJCOANe0EIvyQhY+qTpERUYERQ0LP507af+BjGJ72VJVJed72Kv3bIc2Nzh0
	MA/XArs/DHeUY6sJPGQpGlwy73Pe9+nSP1HyIi/TquXIH4vgY1aiInxsi5K0RaEqTZRRvDTcjtd
	hkeGDdb7b53Mzxt+YZrrRG+CfEZl+uiW9mACHkt5Nv17RMnYOuCNkqlaqvshVA2OzLFB7aJqSIw
	a3J19bdueHieXrLjNePfuXJ2Q4Y0BXYNcYV+KL+som4u5fv7+ash5a+Dg7aEuWgerW83qGRl1mt
	ymSuK5QVYQpyNnzkQp8QUmreF8foyfktDL9fwLLlJuVrUwDv4E8DlANRlwxwdBiH19qp95bg/Ee
	cZAvXa9uWSbzTNCpjL/Xlt1dI4zrWMbFYiH5OYp4qyZtXtXdtD2ojsQMqDNF7iJwAdhI9I8uLVH
	K+O8p0ioaHK+RbXs2JOc8xTrxBLqWj099xiSNUJVw9c3zZ29Pzaug1PVr2976E=
X-Received: by 2002:a05:600c:5742:b0:483:703e:4ad9 with SMTP id 5b1f17b1804b1-486f446d066mr100346695e9.19.1773940645202;
        Thu, 19 Mar 2026 10:17:25 -0700 (PDT)
Received: from mail.gmail.com (lfbn-ren-1-685-61.w81-53.abo.wanadoo.fr. [81.53.253.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe8c2ce3sm632675e9.8.2026.03.19.10.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 10:17:24 -0700 (PDT)
Date: Thu, 19 Mar 2026 18:17:22 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Simulate branches to prune based on
 range violations
Message-ID: <abwvosbAmLJM7PiB@mail.gmail.com>
References: <cover.1773441432.git.paul.chaignon@gmail.com>
 <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
 <swmeukekw55emiwcduoq4jpjk6hwqk7nzxbcs4xgw4mir5ldd7@mqyinrubwmlo>
 <abs6SmlOId9IVidk@mail.gmail.com>
 <rqymt2p6ypkk7wv3jzhm4zkbyfg2b5fyvia6bdfp6mdbzzqcmz@qvt2rb4ul2p5>
 <abwuyFR6wh7xQfpO@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abwuyFR6wh7xQfpO@mail.gmail.com>

On Thu, Mar 19, 2026 at 06:13:48PM +0100, Paul Chaignon wrote:
> On Thu, Mar 19, 2026 at 03:09:10PM +0800, Shung-Hsi Yu wrote:
> > On Thu, Mar 19, 2026 at 12:50:34AM +0100, Paul Chaignon wrote:
> > > On Tue, Mar 17, 2026 at 02:14:48PM +0800, Shung-Hsi Yu wrote:
> > > > On Fri, Mar 13, 2026 at 11:54:43PM +0100, Paul Chaignon wrote:
> 
> [...]
> 
> > > Yes, that's definitely a good point. We probably don't even want to
> > > backport this to stable kernels (at least not until we've built more
> > > confidence via syzbot). We'll drop the tag.
> > 
> > I was actually hoping to get it into stable as soon as it merged, heh,
> > but make sense.
> > 
> > You would have to actively reply the AUTOSEL selection email sent to you
> > once this merged though, even without the fixes tag it would still
> > likely bit picked up; I'm not sure the exact AUTOSEL criteria and it
> > seem LLM-based right now, but given this says "fix" and "syzbot" I doubt
> > it will overlook this.
> 
> That makes me think Checkpatch will likely complain about the missing
> tag as soon as I repost without it, right? Given I'll need to answer to
> the AUTOSEL email anyway, maybe it makes sense to keep a Fixes tag.
> Would a Fixes: 5f99f312bd3b ("bpf: add register bounds sanity checks
> and sanitization") make more sense here?

Uh, that's already what I added :facepalm: Thankfully, vacation is only
hours away... :)

> 
> > 
> > > > > Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
> > > > > Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > > > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > > > Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> > > > ...
