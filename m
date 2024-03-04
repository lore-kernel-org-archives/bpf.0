Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E043D963
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559999; cv=none; b=LgvGdvJMCAWEirex6ezO11h3KmDIHQvs7Z4y6pAPqcXQETDY4YAP0+qK+h6BSJ8ExKuHUrDpbUhqWSHJY/9W7/p4C7xp4P9F6uPeFlPMXfPcllQZIPtQCxOFeXpA6ttj8Qju4bVFjHTaTFX/mk6p9nF2IVtsbbnZDqOsJxgUI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559999; c=relaxed/simple;
	bh=sjOe5GqdTDnHiqB4dCidAPYiPJgKF6XMbv4MT4RJ+n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTdsGB1Xqv8vU9OmUuLtq/1mdLDhmyH0VbgLoB7cv/KwWw/7A8K3w3CcPm4MM3y80pdUYTj7gKQVFLptsg9AuJUCFhuBY4keEU+loSiLh539hv5ysZ1g2cm3UeRGDIvHXZbKDacaS20ix8gxifMAX+bb3irU+5E3dUSZ4oEL5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ai8xwVhN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ai8xwVhN"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e151a1434so1331808f8f.2
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 05:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709559996; x=1710164796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mF2A/erodOEAvFD+DVCRwC+YTSsM3QNROncHsz37sWE=;
        b=Ai8xwVhNjmeOcThkR9lf1IpXTtryyc091BJOqBwmKbK3QhDZiJQl2slopDjuRk3ghj
         /YLxQo7bqMYzDxlpxgT90fJDsZokQ3Us5oX4zy93NY7sEF5Kmcf24DBYxnQdQ1Hp7P6i
         3wsDOurYKEjJ/PsIBYA75ZmeJut204cXl/HzqGs5EhkblH47GAWqRy+o0UStW8f/hxHi
         QRjxnIcqc/5RVb/HijA4UD+2BINKTrhLCuHNTUzeiClj0eG8oFHqi+k579Wf1waWDcM+
         27yEskBVDKF2oSGlHLc3H+D38CmEusAVBIFyxEAX+Ua68/Ee2qLm1VhkrNkYo9oPp669
         i8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709559996; x=1710164796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF2A/erodOEAvFD+DVCRwC+YTSsM3QNROncHsz37sWE=;
        b=P2iL45ig9PqpXY5Fg2xwoytn8yhjH21aC6whSb6W/s+ql5PwBOOngjcPzkY3briwH1
         TqecLyLdn0OkdCkmvgwYeD5Aq0DYHA7lO7+RnHps+yihkRb+IHfTlhyRzefjiD7lWeRi
         dgnwt47CZzkyOmT6Ev251x98XnbSI909s4vbGg/tmbudzYeGZByhuzk0T3DBwGQHTZ0k
         MHKymm8u6OFqUuHTU6D/wXhz1+hWFDqJTTOTK9/2XnGePeMeBh3yuT18n7ullAtnIAFg
         QejsBX7cEkoIrKr2mtrmbjU6WSRzyGQJLKQV5h9JhcQZXY0bYYGzpsTS/ZSwJXwmzaCe
         374Q==
X-Gm-Message-State: AOJu0Yw9g05ICkHbRmYQCo8wWhWbza91ZjVTX7bc21S1C06nc4ZZEzGu
	ihpVs07jLRPcROUsV+FgUsfeTpgANQRptcUAOgTCJuEjBBeCaF8D0hP7qTUeRyE=
X-Google-Smtp-Source: AGHT+IF7EoUCCRF8NKiY+ZJGE0dJqDLXEstIuFfLMqvSrgX/VKHuk/UTvrWlf1slNgMAg8iIdilt8A==
X-Received: by 2002:adf:eb11:0:b0:33b:5f1d:5ef4 with SMTP id s17-20020adfeb11000000b0033b5f1d5ef4mr6498196wrn.1.1709559996527;
        Mon, 04 Mar 2024 05:46:36 -0800 (PST)
Received: from hackbox2.linaro.org ([2a00:2381:fd67:101:f4c1:e8ff:fe8f:2fb2])
        by smtp.gmail.com with ESMTPSA id h3-20020adfa4c3000000b0033dd2a7167fsm12391780wrb.29.2024.03.04.05.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 05:46:36 -0800 (PST)
Date: Mon, 4 Mar 2024 13:46:34 +0000
From: Haojian Zhuang <haojian.zhuang@linaro.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH] bpf: check mem for dynptr type
Message-ID: <ZeXQuv2jCsKnYZnr@hackbox2.linaro.org>
References: <20240303023732.1390919-1-haojian.zhuang@linaro.org>
 <07f7315efef78b7a19dec16b59b74b15f7b97dd6.camel@gmail.com>
 <ZeXGTP3ZIFRPGFCG@hackbox2.linaro.org>
 <564df7e8c14864641c2f57a5283de53c746ea047.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564df7e8c14864641c2f57a5283de53c746ea047.camel@gmail.com>

On Mon, Mar 04, 2024 at 03:13:29PM +0200, Eduard Zingerman wrote:
> On Mon, 2024-03-04 at 13:02 +0000, Haojian Zhuang wrote:
> [...]
> 
> > Yes, I'm referring to bpf_user_ringbuf_drain() helper function.
> > 
> > Yes, I should extend bpf/progs/user_ringbuf_success.c. And it could be
> > loaded by bpf/prog_tests/user_ringbuf.c.
> 
> Before doing so, could you please share example you have in mind?
> 

Sure. My test case is in the link (https://github.com/hzhuang1/linux/blob/bpf02/tools/testing/selftests/bpf/progs/test_crypto_kern.c).

> > But I failed to find the binary of user_ringbuf.c after bpf test cases
> > built. And there're no binaries for the test cases in bpf/prog_tests
> > directory. How to make use of these test cases? I failed to find
> > documents on it. Could you help to share any tips to me? Thanks
> 
> The binary that runs tests is called "test_progs" and is compiled
> using target "test_progs" under "tools/testing/selftests/bpf" directory.
> Specific tests could be run using commands like:
> - "./test_progs -a user_ringbuf" (to run all subtests in the group);
> - "./test_progs -a user_ringbuf/test_user_ringbuf_loop"
>   (to run one subtest from the group).
> 

Thanks. I'll follow this instruction.

> I have an old writeup on setting up local testing environment,
> if you need it I can update and share it.

It's better if you can share it.

Best Regards
Haojian
