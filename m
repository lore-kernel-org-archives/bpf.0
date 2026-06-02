Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C93243964
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391898; cv=none; b=itxP/wqb5/GjWkkQQ1kNB+P67mHIDXKD8u9vxONNHz1XKXn3HouGzoFfeZOK6yfBkDrEv1ERH/l+LGqsicH7hlKXr/Ecm/CTKL2pwZ7zOuMUf7S1wCcoxR4ZTXiqbem8v2lO8jwzbYmxNHHJDuCDi713ZjDNFEV7CBY1XjaDBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391898; c=relaxed/simple;
	bh=FYGX+z1NHS6G0DY02oZQ6hTTBFd4DJcBw8FAvVlqv/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj1d0shyJXvghQ3eBbVEhV0INJ3Bh8yl3+ffikYmQ96uOJcKJtIaX8BSe2x3U3coMl8Qkwv1Mq5jQrEz/wtDXf1g/Xl7o+oScmYviNRgyJC6bPHJSefd/7eL9r/tXe75CZ2xu/oKJW8xr+S76lXtT7F/15GeRtGFEeMxJLLfK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LWb2KaeB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LWb2KaeB"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so248740266b.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780391895; x=1780996695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8weWZwvlicUS0dvAxblKD1HBMYQh1u5mQ2U5bxBouSc=;
        b=LWb2KaeBuGlQuxF2ygVImG8z4k6CWEfaz8CIF20uqpcIp1Z/93bnC+RGYjgbcyS3DT
         Bpzm6hJMKdWRjIsE50U5MFlQBwL+kknijzd2EJC0arOwnoenhvloVr3CD/Dsa4VcYEBu
         GY4VF1Bl1OppX4jipLsrAg4r1QppX6Ry0lBgZRF9dOA2/gbepWfZgfURLWNmuXVwUoYs
         YaxlUZ+Zfgii3NCsewGG4TRrGe4euGOzb60mmQxXKpVtMk1Wd1CI9dvIna+pKHYCXuUa
         ijTY/DAk5DAWuF+1uq4KEPQdf3TqZfaUWGocJWqxyi24zbd/ufyOHgYbm2r5OBJkOpYu
         /vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780391895; x=1780996695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8weWZwvlicUS0dvAxblKD1HBMYQh1u5mQ2U5bxBouSc=;
        b=FrTC4B5p6hQRjfOUtHdKi83nW8frKUd2brygJAXEcWEQVMy6lwf/mgN7CK3c11+wrG
         R+CK6lrmUlfV1kIchshvLcW2EyDt16lkIxq+UOX8d1HToTNAs2GdguBp+HgDd8xOFEqe
         QmJ2NSBY7qzPMD8Kgwm7flpciqAfix/JlHQAOQEq5ALUZT81moDEEJ2+k4Qj8GtK6btZ
         l8Hk4Z7Q5kCMx9PxWwColMMLWD6kEYP5LVWtz8EAIElY/tHJbqBxKb7/l2OzNd4knE+v
         yk+e53YDPZvSxBkYztHXV7m9iAvxpMnmD7p+jMca/ZejJ2SKRbRNbzt/Lfza3mCP3/iM
         onVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QWSr5tP13HbBkwysPN5wTNVYmZx2XodK7WyAU09zpDVJeWwe5RdK/yz6vYXetJq2LUm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztFug7ylJWgXKmeOT8xXIwn9BF0u0smRQq0Ss6edRjoh/7cI0O
	wHyPL+2oHtBkMMM8TvkMnvc3poInfxECP0Ruxz1FkrQP6hiPk0zuLZou9H0kdMMMlkCgYazufX1
	p5R9Zn1Ym5w==
X-Gm-Gg: Acq92OE8PjsmbwGZALCBb8c2pQ7KvOFHEoVG7gbDOCYkaVYoabHGkA1YRLpVBH/lNi1
	81O5t7UXXWFaSJ9KY8n4BOBbQE+ZboXN4YHNu/3/3mjQoLXwVeX6nQODnOEbYPe4E9272X/pYxj
	AOWpkot/Y8qFofeEDemYJWLNpp4XVlY+/ZTiOug0OOPfMLXIcpf5WY28eRiLtcYH6AVhiejWXHW
	gzbOV/v5GThMkfw8ridO4iG1VXHETyio8Fy+FSQR91mtDwkd5otHVjcDRuEwpMikIFmQX1lQFRD
	+AgDKgektUGd2LDfAs65ekU77MTxERNiusLCSXz1XjYx/2R/rXQBoCiZ/03oEvc7Vs2C74z9lZ+
	HNfmFxQRE+PTeUJoEaqNsncUYgkamJQUUb+JkmFjXdkcMTXCJnntplDZkLhxDkV7M/JR91fHwyH
	opnyM3z1QmXnSzYR6CKwDBSdo8r0aO8yxYYEi4BXZulOI/ffzcDM3LVg==
X-Received: by 2002:a17:907:9453:b0:bea:5cc7:95a4 with SMTP id a640c23a62f3a-beab03de8a1mr933593866b.0.1780391895233;
        Tue, 02 Jun 2026 02:18:15 -0700 (PDT)
Received: from u94a (27-240-75-84.adsl.fetnet.net. [27.240.75.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd91846f8sm2382956a91.4.2026.06.02.02.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:18:14 -0700 (PDT)
Date: Tue, 2 Jun 2026 17:17:59 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: stable@vger.kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	tamird@kernel.org, eddyz87@gmail.com
Subject: Re: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking
 fixes
Message-ID: <ah6dLESn8tHAtxS9@u94a>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
 <ah5pf25fhVH9WuU-@u94a>
 <ah56iBM2P_9hF3_L@u94a>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah56iBM2P_9hF3_L@u94a>

On Tue, Jun 02, 2026 at 02:42:35PM +0800, Shung-Hsi Yu wrote:
> On Tue, Jun 02, 2026 at 01:47:01PM +0800, Shung-Hsi Yu wrote:
> ...
> > On Tue, Jun 02, 2026 at 02:03:58AM +0800, Zhenzhong Wu wrote:
> > > Hi BPF maintainers,
> > > 
> > > This RFC backports two BPF verifier scalar range-tracking fixes to 6.1.y.
> > > The series is intended to fix a verifier state-pruning issue where an
> > > impossible scalar path can be kept while the real success path is pruned.
> > > 
> > > This is a verifier scalar range-tracking issue, not a helper-specific
> > > issue.
> > > The visible failure is that the verifier can prune the real success
> > > continuation, which should not be skipped, and keep only an impossible one.
> > ...
> > 
> > This sounds somewhat similar to the issue fixed in "backport of iterator
> > and callback handling fixes" for stable 6.6[1] by @Eduard. Could you try
> > to test on the latest stable 6.6.y as well at see if you can reproduce
> > the issue there?
> ...
> 
> My mistake, the reproducer you had doesn't use iterator or callback, so
> probably not fixed in stable 6.6. I'll take a better look at this later
> this week.

Two more ideas beside testing on latest stable 6.6. 

1. Can you try testing on bpf-next, but with commit d028f87517d6 'bpf:
   make the verifier tracks the "not equal" for regs' reverted? My
   concern is that it is possible that commit d028f87517d6 does not
   address the root cause of incorrect state pruning here.

   If the reproducer _fails_ to reproduce the issue even with commit
   d028f87517d6 reverted, then it is possible that the root cause was
   fixed by another commit further down the line.

2. Have you consider adding your reproducer into BPF selftests? Would be
   very useful to have in stable (though it needs to first land in
   bpf-next first).

> > 1: https://lore.kernel.org/stable/20240125001554.25287-1-eddyz87@gmail.com/
> > 2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
