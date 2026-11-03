Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741776;
	b=GJYTfCESFjMhlPcDUIM9aYVWxNbKUOl0qpMhR2B9EdZth8IFMbRqVtkulgQkxZVZ1N/X
	 18bGpEdg6PstDY98fp6OyLg8RVBXLV6iGsZdsr+q8jgcDOYM7MIcmgHIj+K9fsyFGb4aQ
	 D9EX0iolgBRajuQ0atqLASoxVDeDipK/qk0cNt73y7fQ0WzDz2tpcz6DS9VXMuJFRtq2H
	 p/dmH7vMMLM0mlkIQX6FOKwJmNhkenfwlQq78rH57LLD0dR59OGjyedqetVhaevBer7ax
	 H7Tuek5XdE5W2NvnC/sP9sFt5gw7BG2uLSpdcgj77pXd5ezPkFJWR8t6huHzDg9j37g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0Zhw2wy6QkBybAwKKqO3MK9GDD5LduUNu9qTjP9oonY=;
	b=UdPllinF+FVuLOcpndJMmhgaYnBmf+eqG7jiBJTuWWXkk3o3qicenY7Y/dnIMHZSB24b
	 /s3zalIr459tTRIfCHEZYkn3De3fUksubDYyoDthiEiRUlFOqbJGhtJLMH8omQNdS+c+s
	 wNpJz75l6WEDGiQY1WqTMBOil58IJXNOTwNSy5ar99M/UB2xnlRO417QA6fGE9eLCvKo+
	 JgJdudlb9FUPZiCFwfMQYOZR27PSdzrxqlu4XJIZpX2DKsxH8ZeXWIs9l4dpCRdhf1rkJ
	 TTB4Es6KW7O4AsgmbgaLwGi8aHwORlxW8+KdPl5SEakc556OXD8lGBXSmbJ8cB66vAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qS2zh+q+;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A8606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 21:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 749A8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qS2zh+q+
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so170115e9.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 13:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793741775; x=1794346575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Zhw2wy6QkBybAwKKqO3MK9GDD5LduUNu9qTjP9oonY=;
        b=qS2zh+q+u2w5dsEdTvnP8sHYQYip4DwlmT3KmeAFk6te3T3eHcRUOg9T68KFVlOReC
         fr8PxdNsqn3o2q3xHimsG1d7LcnSQ7S0hSbBQ6VdmgJAW/mTm0G/67Ofs6F4XPm0vnGO
         2pyORWS72QMljoeAlgREzzJ7+7b5ZjJ3/S4cv8dymJRMNMMRVc7mH5hTw6Oi8X/QvFFy
         RwMLhEvNRaWpULxIk1iRLnlcOh1Z6pwBprloiyKcOg0gh0vOQjF6aL2q8bSTM8/nIIX3
         kmSiY+yzSv5cHxd2GFv9uLV7BYV0Wiqz+XY30ww+pTNh1njFTxfKcukrDKyV/S1RlZw6
         /Gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793741775; x=1794346575;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Zhw2wy6QkBybAwKKqO3MK9GDD5LduUNu9qTjP9oonY=;
        b=MxHfU4qPtts/7tavg3Nop8WH1CWpgaqQAlB1I82PXXfCDkINPRsfWaZ2Sy1e+4bfa2
         TU13lVw07dlY22izbBWsSCeQduq/92N4t0l44fYuX3jcx53oRUui/qOhbDGIz8reOK4y
         9uSl26G2JHTFOluFEUkAwTOr2FUBwxhrBwKJUucrjQ9sjYvGeKr/wgoXIZKzXQG3AOUb
         AaOjx3gph+JWK20c8QD4KzgXcikio99WOkQ7nihMzR75Tb+Czs4RbDfJU5FZN76qKrDw
         rQarG3HJwalusuJm7VCj+kbtqytfq1zJgC2LlZ63gbP7AakUSqA/nd8lreI9widWBIzm
         UBlw==
X-Forwarded-Encrypted: i=1; AKwUvBwRTtZJwZyRPm1750KCjZU+6H2VNJabzkbCFDwU24iNi0Q2Gw1cLAP5E/MM4DATNYOSKbU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/L6LKyVC5mKMTGuXxKNDzCUoVWFE3yj82TZ1mLEQ1nplBosAtC
	2Px3fI0hInXEBcTFILbOWhidkAuh2HNF8WYZDwSHqDVLgO6AR8C8zbAk
X-Gm-Gg: AYBFou2uy7K+WOBMc/k4qOpdwitFXCP5c3T3xtWsdiVOuyduBpXdOXWD5FQ8Z6XeF5m
	/NUejHDEmfihFsf1dvJqccr4gN+d22bG1/K5zYH2ozKIH1NvI0vJx2ZJXwZ3XdB2StMZmtWVxs9
	JYS5+LPNKOYIHX3sS+rQV0sWhTtbSfJRNmSWyaYElBUimjyQG7+r35xGnixaNQeP9fQEdzoqZvb
	sZZSpBNLf7AY01TL36GFDycpSgrAcZAq4G37imtdbzWxEFh//2bI2Zqpr7n6WeQVhA50OCUMRAb
	7jmqgRRUNzahx6GdPdxJat7yL9rd6RkyA5mJzT1Pjct7wFrosymXt3ptCe3ayo+2ZR56RBBi/bX
	4ceOD+To8+LVDvVl+FkCDFDVEBHeI1PXfcJ+eT5CXWgU4f6YbgmzEJ3HLxctm0EdaFGQMVH5kS3
	SFP7zAnyNLauc4Nn/5zGi54M63Dmvx3QT27XsN8oh4RQjZ0gt8iHbqOOmadsfHdc/m8A4z64Rpo
	noFynGzqFXZpDAA2zCaqF0yt6FHW772O6JY8KUFbWFXOEPvCy5+smD3yzU73M9QqzdP1hKgbQ/U
	5xm3cud7Na27cDm3FWoiqIpHwOM1imZBWaa5
X-Received: by 2002:a05:600c:c16d:b0:4a1:e00b:a0ea with SMTP id 5b1f17b1804b1-4ac150b204fmr317995765e9.1.1793741774609;
        Tue, 03 Nov 2026 13:36:14 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec9cd43bsm184291f8f.14.2026.11.03.13.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:36:14 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Nov 2026 22:36:12 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: Re: [PATCHv2 bpf-next 2/8] bpf: Add user memory kfuncs
Message-ID: <aupTzCetiTqmbOab@krava>
References: <20261103075916.100050-1-jolsa@kernel.org>
 <20261103075916.100050-3-jolsa@kernel.org>
 <DMLRWY2OAGS9.3KD9RKTC5MYPX@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMLRWY2OAGS9.3KD9RKTC5MYPX@gmail.com>

On Tue, Nov 03, 2026 at 06:05:46PM +0000, Alexei Starovoitov wrote:
> On Mon, Nov 02, 2026 at 11:59 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > +#ifdef CONFIG_IA32_EMULATION
> > +static unsigned long bpf_user_vm_mmap(unsigned long len, unsigned long prot)
> > +{
> > +	struct thread_info *ti = current_thread_info();
> > +	bool compat = test_thread_flag(TIF_ADDR32);
> > +	unsigned long addr;
> > +
> > +	/*
> > +	 * We are not in a syscall, but x86 get_unmapped_area() paths
> > +	 * ignore TIF_ADDR32 and rely on in_32bit_syscall().
> > +	 */
> > +	if (compat)
> > +		ti->status |= TS_COMPAT;
> > +	addr = vm_mmap(NULL, 0, len, prot, MAP_PRIVATE | MAP_ANONYMOUS, 0);
> > +	if (compat)
> > +		ti->status &= ~TS_COMPAT;
> 
> Do you have users with ia32 tasks ?

nope

> Without this code bpf_user_anon_mmap() returns -ENOMEM in an ia32 task.
> Nothing breaks.
> 
> arch_uprobe_get_xol_area() calls it a HACK, and that one is in arch/x86.
> kernel/bpf/helpers.c has no arch #ifdef today. Let's keep it this way.
> 
> Drop it and say in the comment that ia32 tasks are not supported.
> Pls don't add code just because a bot said so.

ok, will drop it

jirka
