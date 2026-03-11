Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677273CFF61
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225534; cv=none; b=D8MfjWSFvceGwOuE/W3x+0MYh8nMgoHG5TAHwwBLdNFdJWHoUADLgKRbHYjQwMQg3uvrRfb/GYzyW8yvGj9cebtduBwGIHYCzfpSA59HVGIl5KBHRW1gmdtsL/1HHaiUuMpHk8oq/JBXVJNIXv1BQsSPk9CENw5ptOfyREJcO10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225534; c=relaxed/simple;
	bh=185y0PaB2qoq/kw/dk0yYXDMqRtCAUSs/ki1l8VSMrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIku/LPgbvrlelwnilWvdRNJtQtAfptgzheUzxSL2HemeIFXfeltVHPL3HjWv7mnDzlAarp+V71d6UuEMuMET05nEnO2hQavrzKjT0bh0IsAOe+M014VWKVGK7ZMxOcv6z2do3tWt/PWfbEUSmpS7wWtvUcOF7Di2SfNZdyf24I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EC1PaC7M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbNOr/pk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EC1PaC7M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbNOr/pk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773225532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neo6yRSSLrmWFQaEvseu7oNpogbBakeVD6DPSMC4PEE=;
	b=EC1PaC7MmvAidbaCL4r5cKCODX5WLIObZwuGq3AMEUJl8h3Q+ljswwdSLXX9qe2gwbfKNz
	FG9OOEjd3SBjSZpT7KT9kiuXsOXKXw6Cx0t6bkM/iYP0lE3rnI731/6752Q2S5CJRzGfzS
	m/4krs69+t5cSZSLjMeKlcEZBLKihbI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-5vbWF5xGN_-7uDUzKALCPA-1; Wed, 11 Mar 2026 06:38:51 -0400
X-MC-Unique: 5vbWF5xGN_-7uDUzKALCPA-1
X-Mimecast-MFC-AGG-ID: 5vbWF5xGN_-7uDUzKALCPA_1773225530
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439ab866bc1so12734228f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 03:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773225530; x=1773830330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=neo6yRSSLrmWFQaEvseu7oNpogbBakeVD6DPSMC4PEE=;
        b=TbNOr/pkTH5NrZ7ojW04Lz0C4b5XRDEKVyyoqtqS7M8Nu1CGEjUGmMkWZTvR/Tt6zn
         Ksegl6h3+AQFgv+2G44PSJiV4bSBHzCuKMiayd/QBnebwq5wh3r9BTSPZsknluGZ/g0H
         wEckIx0AXr89MNEz+7NMVpNTG+OJCM96UiAUdtGV3y05u2KOxKYkkXHeyVxiBgxhtBji
         ST0gC5FoXDAzAqDl+JgmyiOkDL4Xbuxe3YUc1fkiD1BVG9UxJSPWez54yXnhCEY3wpX1
         tjKLqYIr181tg0Ad2MA2CMiPjdQlQYWaVJPrMkcclazzCyVMP9y5XJy4EnHfomvwkuOZ
         Pg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225530; x=1773830330;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neo6yRSSLrmWFQaEvseu7oNpogbBakeVD6DPSMC4PEE=;
        b=KzHDH4uGm2387A8tLepj98HaxNz8vVNp1qDzEQ7JLjQPyZEMrsFyob+QHKIkH96OuA
         ijM2Dv91CwY5CpUlF6ynnj7VMn/XbsZmu5A6ZKjttXL+jwA2yLQRcQgRQKdHbdAAGa9Z
         9XsLn2+/16aqs7HDCHPMM1f5uEKCgafuR/r9QXHLoSiLhQnrpmp8V8HpMOAdIX9pWezS
         JKAplYkGrmuzVcM/Zq7lAAwwUp0MvFhO+e3aJ8rnl3qjkCGWuRXqXo/OMgqWVuSzlr+z
         nK2cWpMQX6teKKI9qdULFZDl64xUU0aiXenoctVjCjpWdaYHjY45CXD5oPXruTb8DGsj
         7Wkg==
X-Forwarded-Encrypted: i=1; AJvYcCW5QJf0SsOB+SLsGeQxFBf0XJLiWhf4vweH8qIrWA3IChDn42tR7Y+ndeR8mr+CsKg2Kd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKYMyxFUMxsWwCudzNVBVhhWRm3S/SmAbM/jdLSPHe1nZZKHau
	KqJrR/FmNG/b0trjPuswxSSelxzdsWCzaJLw9hf5x/AxWccp4lJiDKFhpfD7lVn9RtKepc3ylG8
	6gJRgT99HSmRD172qwIWV9H5l7uor5GweX+8PQQsvQQaNctxoOPH8
X-Gm-Gg: ATEYQzxDNdZ61vlwW7kF7bAGAypMmv1DrcPPtFo+IEHiLjPzpeKtdO2A09IUxS4l4pc
	/yMSsvhAOLUlLpy/5vPPXOzZiflIA0i/5BgWBAZtgJ0glMviUhyLm1GC2oaY32ycsgmoshjncJj
	g2Omntdutq/L+aNDM2IdDgaeO9LJYeYaSj3a7548G76Bvb1N+aoRh3u/8nf7EzOy/IZ3LwJfK0q
	KnP4LR/WfC/CbFUSWqNBpnV3Rgh2KGcNRDVP4bTyTk9EbwewacswQrYLYgs1Sf79FO2OqMfQGDi
	GiYYMwjBNN4oe6/voslYAQ94L0tx0tNFHuylpTJNmsQdazibgN4J8EBlMHz5Weguk7ZDSbAo9to
	vsRWbyVDh13B8IkYOeJla+WXKMPCMdHShjuReBxvm8TvihpscMW7u0Hea
X-Received: by 2002:a05:6000:2486:b0:439:d752:8bf9 with SMTP id ffacd0b85a97d-439f8227e7emr4056580f8f.58.1773225529953;
        Wed, 11 Mar 2026 03:38:49 -0700 (PDT)
X-Received: by 2002:a05:6000:2486:b0:439:d752:8bf9 with SMTP id ffacd0b85a97d-439f8227e7emr4056538f8f.58.1773225529493;
        Wed, 11 Mar 2026 03:38:49 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f818d209sm5419754f8f.5.2026.03.11.03.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 03:38:48 -0700 (PDT)
Message-ID: <8194d1b7-9279-4290-a15a-df57ea991066@redhat.com>
Date: Wed, 11 Mar 2026 11:38:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/bpf: Fix read_iter buffer termination in
 test_bpffs
To: sun jian <sun.jian.kdev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
References: <20260310102145.857810-1-sun.jian.kdev@gmail.com>
 <6a914824-178a-47c3-98f7-f3c3086ab831@redhat.com>
 <CABFUUZG+fDw2eETsmEs1RZ-vSZ07uuxLuZDYp0KJqTX_6via0w@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CABFUUZG+fDw2eETsmEs1RZ-vSZ07uuxLuZDYp0KJqTX_6via0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/11/26 07:47, sun jian wrote:
> On Tue, Mar 10, 2026 at 8:28 PM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> Does this fix any real issue with the test? I can see one very
>> hypothetical false negative when the uninitialized memory would contain
>> "iter" but that seems very unlikely to happen.
>>
> 
> Hi Viktor,
> 
> Thanks for the feedback.
> 
> Even if the probability of a false positive is low, the current code
> is still incorrect:

It's actually a false negative, i.e. test reporting as passing because
it finds "iter" in the random bytes while it's actually missing. In an
absolute majority of cases, the random bytes wouldn't matter because
"iter" would be found early in the initialized part of the buffer.

So, since this fix only makes difference for cases when the test is
failing, I don't think it's worth patching it.

But I'll let maintainers decide, I'm not sure what the common practice
is for these cases.

Viktor

> on short reads it NUL-terminates only at the end of the buffer, so strstr() can
> scan uninitialized stack bytes. That makes the helper potentially
> non-deterministic.
> 
> Terminating at len makes it deterministic and ensures we only inspect
> data actually
> returned by read().
> 
> Regards,
> Sun Jian
> 

