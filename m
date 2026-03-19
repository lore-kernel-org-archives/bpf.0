Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CECF39C003
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773904161; cv=none; b=go6YbUWG3cxwbTsRC8ZTN7A4QgJ5cHwIP0bIFwcEOR+xkC+4XlipQvmca03qD6DQFmyfwRMs6x/jbuX7p1ZOHaN935A4+gNG4Q1eXIsIEU7g/3/UumzWeuhnqn6Zo1iAzTIwqngjSmW9c7ph4+t5pf9fHnGWGomzCrU38BDeJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773904161; c=relaxed/simple;
	bh=zxQQre6DhyOyD2TwfBFUNdRrcbCFjDRv0wewoObm8WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2cWupuKXAlHmWWIt+2pljhq8p9m/E/1rn+raAIbgGzrAAuNGnWX8oYPu7NK20clIZnn7qjP4jiPrWDB5Q1orop2hG0drO5DI2hDHi1do5vKod/AcpK3GmdaUcoLWr1yE8YniFneLk0Zw8Ro6vv/P7wt3Ar4MzGt8c6xBdj53aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RLdLxl7e; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RLdLxl7e"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-485345e1013so12407575e9.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 00:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773904158; x=1774508958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p0ZseOfw6JRowQR2hVprKt8+YKHSsyyodPX65S19uw4=;
        b=RLdLxl7erhPTWxH+CxWwwrbl0aSaXJXlACEiCQJp/VQjlMYAG/8k41okdVQfhc9qqG
         5zSYRIJNBaWlgpZCymHqriAqFQ6IA7XGGcCs+UJmFIwc9Xgxtw5cCk+Bpj57+bgg2eMS
         Cde9/sXpg5bdMekPb8f7wZiXC8QNGD0Rv+7Bzk5yLwPBuJ1QW8gNNCwILbiwSEuNAlId
         AI6D5OqU8QrjqtDKEQS2V3hRs0kUVJs2/PsRNyYipF3+QIPYl6srZirGG84Qq9i2h5QI
         sXvS6FrX8drl7eAnz4Prv6oegqaU4gLMo8ehmoC+CIGNxk/LlrIMnfuEPiqyiqSryAiV
         HCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773904158; x=1774508958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0ZseOfw6JRowQR2hVprKt8+YKHSsyyodPX65S19uw4=;
        b=fxQAJCy6OY/aOKBs+gklOEHms7+pOme8cCKSDtMgeNp0yAwrUL8lNNJsQGba20efuv
         8W2dg19K8sn8s6Gb2sTA2TN9jcmdJdNprJsLq/Bd9D/Uort2ys2xp8D9+BlzHLt5k1rl
         d4mc1Nb/vCdfcSpRwqtLazbZE4c9Zndcv6xq2cr1r6nWwS9xw2hD7xO3ooFPZSAEsTtP
         5Jbm2mpfW9RRloE2Y4d+bTMRpo4NxeVdaHt0bwEFPdEzjeqXiyrHzKqE607XaPt3GAOh
         YDUg5AfjzIJ3pPO0ybNPZD9maU0psujn+P19Nyy4bPs9xrytFArgKUEWFVM0Bu1ws4+f
         zNBg==
X-Gm-Message-State: AOJu0YwDPP/fiEfndUdzG8eSWCuxYJ0cHR/n0U/j7asnOAzq6Oaf8ZKv
	MsMYp5s6fHnLwjqsr1pLB8j5Ffm5BLKQ/+2ZWVYTvBlw9jzD2MAiqvxHcbFW1VkGv4Q=
X-Gm-Gg: ATEYQzydxY4XXP2r577jq7GWsPhSKaWZdJD632VvRuYhFnK7yyybhCIZ59wNY0KPYVt
	VaoziZ3MQVwhQP6mUngSwA8kdtAsWq22+Rg2A42d7iv25EghzsQv1qAil18ggIbdtxcuZuIbbpj
	iWNxfikIIRcQEPz+pR41b72ikpt6AnrKQtrI8fL9x7+cQ5AfCSObqgSTR6QH2REnifuzkRitGi2
	5b518+uLjPcW20qyaa1oHvio4wEl+u29GAHH5hR+BM1WUaqkKW5I0VePa19vOzrfQBl3aKdIqXW
	+GBrK6P314kOg9PFqUTuwuo0cHTEae06BWPDZRoWgh2nK+i2GxWLDlLqmR1h+qDPdNArRZMg6IN
	wEb1ruEnK5y7RLl3Di3JFIa2humLRlyOW/ECuKx95u4/F8ULx1OhkelqgzGRU5l7m7vlWrgnAeC
	RgI2VMrPIQkoBcsq18ew==
X-Received: by 2002:a05:600c:3556:b0:485:3038:72c2 with SMTP id 5b1f17b1804b1-486f8b91f3fmr41235265e9.17.1773904157715;
        Thu, 19 Mar 2026 00:09:17 -0700 (PDT)
Received: from u94a ([2401:e180:8dfc:66a:a219:10d5:f609:370a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b58377dsm4692649b3a.22.2026.03.19.00.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 00:09:16 -0700 (PDT)
Date: Thu, 19 Mar 2026 15:09:10 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Simulate branches to prune based on
 range violations
Message-ID: <rqymt2p6ypkk7wv3jzhm4zkbyfg2b5fyvia6bdfp6mdbzzqcmz@qvt2rb4ul2p5>
References: <cover.1773441432.git.paul.chaignon@gmail.com>
 <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
 <swmeukekw55emiwcduoq4jpjk6hwqk7nzxbcs4xgw4mir5ldd7@mqyinrubwmlo>
 <abs6SmlOId9IVidk@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abs6SmlOId9IVidk@mail.gmail.com>

On Thu, Mar 19, 2026 at 12:50:34AM +0100, Paul Chaignon wrote:
> On Tue, Mar 17, 2026 at 02:14:48PM +0800, Shung-Hsi Yu wrote:
> > On Fri, Mar 13, 2026 at 11:54:43PM +0100, Paul Chaignon wrote:
> > > From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> > > 
> > > This patch fixes the invariant violation warnings. These warnings
> > 
> > Nit: I would say this patch fix the invariant violation (minus the
> > warning part), warning are gone after this, but that because we have
> > fixed the caused of the warning.
> 
> I wondered about the same when writing this :) I thought it best to not
> claim too much and be specific to the invariant violation we currently
> warn about as technically there could be others.

That is true. Then maybe just "this patch fixes the invariant violation that
happens after we refine ranges & tnum based on an incorrectly-detected"?

> > > happen after we refine ranges & tnum based on an incorrectly-detected
> > > branch condition. For example, the branch is always true, but we miss
> > > it in is_branch_taken; we then refine based on the branch being false
> > > and end up with incoherent ranges (e.g. umax < umin).
> > ...
> > > Fixes: 5f99f312bd3b ("bpf: add register bounds sanity checks and sanitization")
> > 
> > Following the thought above, I am uncertain about the fixes tag here.
> > Commit 5f99f312bd3b surface the invariant violation as warning, but
> > invariant violation still happens before that, we just don't catch it.
> > That actual root cause would probably go even further back, but probably
> > would be too much of a hassle to figure out. Maybe drop the tag?
> 
> Yep, that has been a question even for the previous invariant violation
> fixes I've sent. On one hand, what is usually being reported as the bug
> is the unecessary warning. But on the other hand, as you say, the
> warning just surfaces an existing bug which we are fixing.
> 
> > Put it in another way. If a tool uses this fixes tag to determine where
> > this fix needs to be applied in stable, it would determine it is only
> > needed for anything v6.8+, when 5f99f312bd3b is merged. But this patch
> > probably should was be applied to stable kernel before v6.8, because
> > IIUC invariant violation likely also happens there.
> 
> Yes, that's definitely a good point. We probably don't even want to
> backport this to stable kernels (at least not until we've built more
> confidence via syzbot). We'll drop the tag.

I was actually hoping to get it into stable as soon as it merged, heh,
but make sense.

You would have to actively reply the AUTOSEL selection email sent to you
once this merged though, even without the fixes tag it would still
likely bit picked up; I'm not sure the exact AUTOSEL criteria and it
seem LLM-based right now, but given this says "fix" and "syzbot" I doubt
it will overlook this.

> > > Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
> > > Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> > ...
