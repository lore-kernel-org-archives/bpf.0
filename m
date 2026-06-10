Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADBA2ECE91
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101165; cv=none; b=f1p4Z+iNdkKpn0W/7eJyfXHOMgmN7WLH6w2WNKbYon/XR8RBnJIMu1DsxF2NRbcCqRLC3ki5oWr2pAI3y7Gkpo874tJuvIRce8GKTkXKQIZw9e6hYB1iN8CGl+y9Ftmty3SbHjDUbLb2f1pwEhl3tcntoOOLJ4gX+AeEcqrukDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101165; c=relaxed/simple;
	bh=2UcMG7eW22Wp21oBmTORpvrhcvCH0AeREMlcUTx0O70=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJb4sGsNe2d6++FbNrqPZlTTBEUqq6LlJT9eJI3oT1eDDYLZHL87NneEwQzjOZm/WOn+2ZuXQK5RSAE92PPezZgd0wRqvbfRYs8AzhzgOJEJDLdzRkHgJ8oL8TLoBQyyyCh1zM3Ia8fztv+XUNkC6W0t13DmRFPHB9sNWFGKqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGcwJcie; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGcwJcie"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b3637b90so59104435e9.3
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781101163; x=1781705963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IJe4hCM5mV7sAi0olWI2yw4JfnaywTegRaUXICsgLbw=;
        b=XGcwJcieY3bPCyK+MFuRgrdUVSjKG7/GKLp06jWQRYl48ddxYm8U53HkWa/oykPCVd
         3t93wE6+E0/2xVFV5Ck+lNaKYDVQTGeefR97a90sojk5j06rLNi6hvzwt7ZQ6WCNrveQ
         3ymv2i7ZHPqbJIDG5Y3To84o5s+IveRegGEb8F2Gk1S2VskAtf56EHaVUK5Kn/+nQP3O
         CXrPDJMkDWleB7OEriLt0G5VmRjFVo4kftuTd0nAwaR1akYf7ra9HPJK6HEmX55btaM7
         w1Sn27hiEgq3Ail1IVNFcdjeyKs8dL3YZpEyvPj7Im7rBCzKy6iRNBRjMSTSNeI90fym
         MJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781101163; x=1781705963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJe4hCM5mV7sAi0olWI2yw4JfnaywTegRaUXICsgLbw=;
        b=YHATYdgqcu00636HedbEorfj+rLyZW9znbnQYkK6FLMQMu8oJZd9m3nuxAK1dZPogO
         78onR/kU73BevfEIoMkk2CEFvemJ5NpWZckn0rGmywVjp/hLbuNfEtEPvosQZvjGZB4m
         aNnf7LvuqVZnK8PUsEyyMMHpD5LmZbmu29ZoOU9g9R6YH2wqoNjMvVPpPHEReL9q+Yxl
         tLZOsdnuzSPXgrRqLjjtZ0B2E+x4CR4wFT474fojH3YFV2wKuU1J3ARhW6IrNbXXszFV
         KFqd0ZVNies4mZURh/vlaFajxFI6tIJjqdpxsKKIfCnR/4AApjC7WY0y+9sAc2TXFWKY
         WEkA==
X-Forwarded-Encrypted: i=1; AFNElJ9SiwPTUtrL3kGhepSSkMt6LImtx5Di4OjHQRu6soaXgFXVAtgjDK9LJW4314FbpFy4L+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQC+iuQGyK31q21c98XWx5AId+5u1P19hTKdcUX6wdWOeWJIFN
	47RwMWGMBxgkrGs3JXajumJVVjTUUaV0oUVcMotdEMHixnh6bj5a+r2f
X-Gm-Gg: Acq92OHrnkAOpVdW8iMNYNF2IXs993IUg3uqedYPT1uZBsDtx/jSwmik08UzagYISXw
	4ofml2jYUKFBv50iPLiF0Ntfz6DE1QIJDG+mQEHrMurtaplY8lnofMiI2n+pf11g77gz0yFxPEA
	+5X4iP2XjziFFIej4DtEgszbJLZKNmXWTjkieqLi2bhThvOGuz7mHVVc2Dcy78X1nMcqU4oRZjE
	lEBmA+dPnlfbPtaQUHCKCOLHzVGe730p9Y9XjnwuZLdmxEFgovzNsOm4JWnekgpb5MdDp9bADiR
	GbvWiyI40+pxk4JDWQyKFs6YTxgyuOvgeuDu3XG9oQAzADAuKVK5SZ03eg5tl8SQCz+kLOm9me9
	olPQsDMUWy2+FNZ2JvXwvk1vA0xDrea481twWWVLZUTP9UIhsIrLadUbUsU4Bcye0I/q/2/L/B1
	R1DBNxRfFr6vKItZkoemSqMw==
X-Received: by 2002:a05:600c:198d:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-490c25baa0bmr431549485e9.14.1781101162066;
        Wed, 10 Jun 2026 07:19:22 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e4b5asm565611265e9.13.2026.06.10.07.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 07:19:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 Jun 2026 16:19:18 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add support to specify uprobe_multi
 target via file descriptor
Message-ID: <ailyZhiVzMU-qW-q@krava>
References: <20260609104244.588321-1-jolsa@kernel.org>
 <20260609104244.588321-3-jolsa@kernel.org>
 <DJ4Q7RSSY0IT.1IDOSQBEWUQ6I@gmail.com>
 <aikg0kljumneVrkC@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aikg0kljumneVrkC@krava>

On Wed, Jun 10, 2026 at 10:31:14AM +0200, Jiri Olsa wrote:
> On Tue, Jun 09, 2026 at 11:22:38AM -0700, Alexei Starovoitov wrote:
> > On Tue Jun 9, 2026 at 3:42 AM PDT, Jiri Olsa wrote:
> > >  	flags = attr->link_create.uprobe_multi.flags;
> > > -	if (flags & ~BPF_F_UPROBE_MULTI_RETURN)
> > > +	if (flags & ~(BPF_F_UPROBE_MULTI_RETURN|BPF_F_UPROBE_MULTI_PATH_FD))
> > 
> > In addition to what bots said, pls run checkpatch on above.
> > It should complain of lack of ' '.
> 
> it complains only about a typo..

ah the --strict option that triggers that.. will fix

jirka
