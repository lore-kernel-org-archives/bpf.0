Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572D3ED12E
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940432; cv=none; b=HP4YQ7B6+2QFtkRf2O4SG3GivvpgfhOi/AHw2u7jy/uxlCLJAHKdNSf41gRQgNrLptZAIBXMpHzxC36HH2f+Ku1DNuZSQ47yA7L0q0CaiS4l0OgRO9YYwPWccS+LlwW8MKV4GNqjs1WSLsB86pXu0he1zQQwoKaL0H6Emov6AWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940432; c=relaxed/simple;
	bh=ZbnkxqB0UOthMkwN5CIHuyXph+1mt4NEkIP3fBPhVwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAsM1lEWkXjqSSCFqIZO1ulSNktiZpspcbyn0Xcaatq/LHNQtgzyKScTZ4PExj2MayPQVrj9naovchFEZmuR5tSntbW+1uNjEof0m5fj/whM6cOfGktM837hfNCpLAbr+VDHlcgchD+nF1qy9TzbwsMTMzTIsRVfkVqPSqV3aa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALt5qJQv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALt5qJQv"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so12306785e9.0
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773940428; x=1774545228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vSj41vwzyfPnBWdUsO74iCkcogfZIb63jeX8VX6ch4U=;
        b=ALt5qJQv1TRGGls3kV5x9OmGvQvK3nOGp8NDtQF4g8ysneWyf35HIITosrxWD2TS5K
         UyW4aFktaR9222tqfeISFfcza6aVUkrWoGcmacfzBtV4SrpTmlQuK/14xaGXZrPXslgs
         BbLmoJb2O84lMom60qPFJvarBLOpZg9AYlEgqySBfacpzcGAc174st1fG/xqYWt5xtMq
         i8KRBP6jy+jacWqgHi4A9C9WWlH+4w3a4K4yG+Sj7b4DDYXz0cQJ1wgZhoIfXbkkw4yv
         7u4l6LTScLVgiIt7AVpbZ755tTVpUsIfBoHxEnWjlaLM6tmhHGlVwtDKxrg7x3aDJiN8
         Pa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773940428; x=1774545228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSj41vwzyfPnBWdUsO74iCkcogfZIb63jeX8VX6ch4U=;
        b=mtuaQu6+U0BqNvPtyb25lrZcd/MiSb82f4PYeR1yuAou8zUnWhijePYe184gmXrztz
         pJMwaMvhhlB0/7kP9i9liZT7Sf0ZrkiN7XITehsHfgqTFVeety+HT97/I3ikeHbNvHKB
         lEGcFICW8B1sRP4htER3lNUUlND+vCCzC4KLWNTn9Gag7Exh4LKzTgN62NgfZl7++iGx
         B6v5HZ5MMHxeOa0d2Y7hbSfItKVev6oA3PjufZtBp92ydS/ThJDp0Bm1C8ZJH3EpFDKw
         V8RvoSttfralPVEGyAIBPFSW3dyura8trt3xpqz/qkbFc2rbf2On0yuY2a8LYIboYYOB
         L5dQ==
X-Gm-Message-State: AOJu0YzAUP7YvJiD8QDWuKt2ESxnhWJLErklylRVqm4Q3im80SbPFyqE
	9VoK3zVqEdttc6ilkHx1nBpAt6RqBja2B83wXJvNEtNiY5ds9lL0oP2p
X-Gm-Gg: ATEYQzySXlRERnIbkDWuRevsy0UVMvn7MvT54IOSQ+usZLueWTtqDn9T7bsM965Efv+
	0UEFxcLKXscWODPMDRD2+U8lzirPOzHvFk257oa0UddVQxBSCdN2nkqNJUa08TxIob6IXzTufUO
	z6AhPodpdUs6OLeLxIeyfQSRSNC7qasNke8GbMwC8U4yuvhdQBjBvBz8OAbSVMMGbyNRuZGD0dJ
	6nuVmtx0bNQAWT7L3J1YyBlxKHiI0esF3uqbd15jsfq3XdbfqA9A0x/LS9hBL5H2oRsku3k+lU2
	4XI+KHMC4EEK95uLo4pK5+B+Z5suO3IReRQ/MQ95fy1oKaopJdz9DpbH/qcLnWrBV8xjgrC5UCu
	BuPPMfPLTPMhJ661IKAQqMycu/Pu8ibcsoeuL4svaG4utAax7uXVj+IB5hNkzFMVCTdB+v3RIEP
	6v/miGoNG9Ju0lnCNWDomHnzP2AAQPhjcX9cgD1jYsPXBdpC9qBPV96td5bvqafuDNZACsploqu
	x2EGA0l7wVhwl4mNnMO2GsgsOUwkVsKBJsm7cvoHmoTakd7MFsWGCPzq4/kAMA=
X-Received: by 2002:a05:600c:3f0a:b0:486:fbc8:8dfd with SMTP id 5b1f17b1804b1-486fbc8919emr41818945e9.23.1773940428183;
        Thu, 19 Mar 2026 10:13:48 -0700 (PDT)
Received: from mail.gmail.com (lfbn-ren-1-685-61.w81-53.abo.wanadoo.fr. [81.53.253.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f5e1ab83sm43491165e9.36.2026.03.19.10.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 10:13:47 -0700 (PDT)
Date: Thu, 19 Mar 2026 18:13:44 +0100
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
Message-ID: <abwuyFR6wh7xQfpO@mail.gmail.com>
References: <cover.1773441432.git.paul.chaignon@gmail.com>
 <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
 <swmeukekw55emiwcduoq4jpjk6hwqk7nzxbcs4xgw4mir5ldd7@mqyinrubwmlo>
 <abs6SmlOId9IVidk@mail.gmail.com>
 <rqymt2p6ypkk7wv3jzhm4zkbyfg2b5fyvia6bdfp6mdbzzqcmz@qvt2rb4ul2p5>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rqymt2p6ypkk7wv3jzhm4zkbyfg2b5fyvia6bdfp6mdbzzqcmz@qvt2rb4ul2p5>

On Thu, Mar 19, 2026 at 03:09:10PM +0800, Shung-Hsi Yu wrote:
> On Thu, Mar 19, 2026 at 12:50:34AM +0100, Paul Chaignon wrote:
> > On Tue, Mar 17, 2026 at 02:14:48PM +0800, Shung-Hsi Yu wrote:
> > > On Fri, Mar 13, 2026 at 11:54:43PM +0100, Paul Chaignon wrote:

[...]

> > Yes, that's definitely a good point. We probably don't even want to
> > backport this to stable kernels (at least not until we've built more
> > confidence via syzbot). We'll drop the tag.
> 
> I was actually hoping to get it into stable as soon as it merged, heh,
> but make sense.
> 
> You would have to actively reply the AUTOSEL selection email sent to you
> once this merged though, even without the fixes tag it would still
> likely bit picked up; I'm not sure the exact AUTOSEL criteria and it
> seem LLM-based right now, but given this says "fix" and "syzbot" I doubt
> it will overlook this.

That makes me think Checkpatch will likely complain about the missing
tag as soon as I repost without it, right? Given I'll need to answer to
the AUTOSEL email anyway, maybe it makes sense to keep a Fixes tag.
Would a Fixes: 5f99f312bd3b ("bpf: add register bounds sanity checks
and sanitization") make more sense here?

> 
> > > > Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
> > > > Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > > Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> > > ...
