Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67043793BF
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778749516; cv=none; b=umYyt5CswM1xaKJaNkfrvLvv0sBRB849kptE5JSxZ8adwaRE0dmaGOhhc/KSoTtx1wU5z/QrDDxnIabX7LGne+NKYufCYD8R6DYl/KGNcef9RbEJPO/DnbcgX9ialpO124Yr8XgmsVXInA3JTZP9iFCYNaLzJJJD2VWvi986wb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778749516; c=relaxed/simple;
	bh=qVyr4qt77zsuqXZ9w/JXIjpv6jtxz9aHDD5YCfrstEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5+Rz0kaCpnWSzDOncYYAUEUagqz4GmYgWP38i6fFdzilUdCgxP1HmbMahvEYUOFkDKw9eOcH5xqK2SnxgwSgVsaWrUuh+TffprSuM/WvLpl0/+LaDNPOvPqKStXQIsnA0Vfj59uA9C7VyuuZXdTlT3h4K/YN4eek+TBFyGqXkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMWJYI48; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/NqDm40; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMWJYI48";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/NqDm40"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778749514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CemDzzrwR3SGpVnjXIQxXW5PCfyUzVu1NubMUDPJPt4=;
	b=FMWJYI48rO7n2IzNDxPMolQ/X3A41mKiQbnNgQtMdoVGVhTv0LFo/24yJd15ZVTLgulMSk
	XSd37E8nHzUqNGCiCJtTjOpRNtcKQ2vY2gkiv/pKIqs5w3SYf2K8mrktYSSKL2eBsCBWJH
	5Ge7g5sDEdu3kaLZA05haBZbXUMGLqE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-CeGkIho-OcerbGq5PouJtQ-1; Thu, 14 May 2026 05:05:11 -0400
X-MC-Unique: CeGkIho-OcerbGq5PouJtQ-1
X-Mimecast-MFC-AGG-ID: CeGkIho-OcerbGq5PouJtQ_1778749511
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4411a69f565so6923989f8f.2
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 02:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778749511; x=1779354311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CemDzzrwR3SGpVnjXIQxXW5PCfyUzVu1NubMUDPJPt4=;
        b=L/NqDm40huVJIkyMYPhQGXGaiYeOGKFfOYjIp5Npl4cBd3+AS5gmyLActFJW+rTlfM
         B9iUefybEexeGeROiRSC10nR5eJIwZZDtH3zLPuhZ5D6fwpf1S1fXXHM/vl5fEyJROwX
         4NU1L9+jjdSlN6gLqI2TQ4PebR7WXGQ+WXbjzQ+fralcvmxb7N2Wnk9JR/MSYXEnpdLJ
         frd7y1sDK0fLRcm6/nZmd+NI+Jm6mY4vNoo/LG35Ts7Z0eJz7rzKnKLS2MUd1ZyKPrzj
         bpSojOxs8JMZ7+Ctqxi5Q+aB8IHVhzfM5D36sPswEGVO+CU2epwqHxPr60uhSBr39JwP
         Qpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778749511; x=1779354311;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CemDzzrwR3SGpVnjXIQxXW5PCfyUzVu1NubMUDPJPt4=;
        b=q7MgVOK4v7wSt2EzfIh3tIZsaUq5ZaICxpu2La/dI53VMjT1pOsQRcrPUiDIXw3uNl
         uGqUTCJHFUwBrgGg2yQb3J1zd/UUb9F/LdOJgyN0g3n4OFiK+UHZhqVxM76UaF1tR42d
         VBt/J+LYs8K8wCsPrWNyXbIFZTeEYaeua/4JfH6ADpykgNrBPS30ZPhGmHw9RqJiVoTA
         on+KOKfl0dATvZ45MXVFi8C1bT19YfxHdfeX4eJDycwi4011J0OpjZ7YUU29M5QxfHMs
         T0Zfv1DJG6nxjovOpr9/oN26Vjz1WCqDDZqgu0me+kiMi0woXN+kRo3yRJTYQH2AxeW/
         nxAw==
X-Forwarded-Encrypted: i=1; AFNElJ+rgUQGBvgs5kyDKDZGkYizx8Yv7cBaLchkpVTRtp/Rg/2L8q0c9/sVsipdxee824HNRyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx59i5nmEc4Qgx9ZEYqb5CRdAumSfw0pLTEGuSpUMJsZWOUaULu
	CAZmtrG8K7Gbb/BXPgfHmTkiPArRKpSusoETPGwvvG9yrlFuwyUwQKn4gLzn32E0gqzBZQ0cFMj
	9rN1wYlHA0DHPfDsbfcBhU/75ZMv60bdCnK0kTAqQCY/zJC3vj8sBUg==
X-Gm-Gg: Acq92OFPfIMh8DIKsDXhjB8V0ju+IZwmukP0ngXfxFLxpvNrZQ7X2pf4YUAAZ9yEUDv
	eJA7HtdKM9Hy2CRIetdIaa3u1pDuDwOIK/rKnRId8l4zNG6UKoZm/ZRhi8JUVWoIxBfbXXc55RO
	zSh2aagOeh6KoZ52wyC5RaedmrrcOewR5y39C7Ig3QZC/M2WhSB+7leX7OS14fxqc5hnuiJp82x
	1irCNUEf9ltSCcKyI5FVD6IcNL8etyqNYEQB48Zp3J6FF+HL1xctkFvLSA25eTPOTYW8Y/4EgoU
	OwTr4RWg9KHtmuWcZay7nTyd9sDCZH7OEwH9UyT+04inZxZ8LIBzIWsH7SoBrtIhD/FXSuSd9oj
	//Vwk9vR3XQCe0oTvqTV2HxEr2QZeBVfCs00qwi6CyUbRPG+aeb83Prs=
X-Received: by 2002:a05:600c:19cd:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-48fce9e1a34mr101445255e9.19.1778749510628;
        Thu, 14 May 2026 02:05:10 -0700 (PDT)
X-Received: by 2002:a05:600c:19cd:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-48fce9e1a34mr101444475e9.19.1778749510167;
        Thu, 14 May 2026 02:05:10 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd648a7e5sm51353085e9.3.2026.05.14.02.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 02:05:09 -0700 (PDT)
Message-ID: <73a19f89-ccd7-4762-8e07-812d8d95ead2@redhat.com>
Date: Thu, 14 May 2026 11:05:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 09/13] net: lan966x: add PCIe FDMA support
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Steen Hegelund <steen.hegelund@microchip.com>, UNGLinuxDriver@microchip.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Herve Codina
 <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260508-lan966x-pci-fdma-v4-9-14e0c89d8d63@microchip.com>
 <20260509082720.503A6C2BCB2@smtp.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260509082720.503A6C2BCB2@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 10:27 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 10 potential issue(s) to consider:
>> +static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
>> +{
> [ ... ]
>> +	/* Get all received skbs. */
>> +	while (counter < weight) {
>> +		if (!fdma_has_frames(fdma))
>> +			break;
>> +		/* Order DONE read before DCB/frame reads below. */
>> +		dma_rmb();
>> +		counter++;
>> +		switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
>> +		case FDMA_PASS:
>> +			break;
>> +		case FDMA_ERROR:
>> +			fdma_dcb_advance(fdma);
>> +			goto allocate_new;
>> +		}
>> +		skb = lan966x_fdma_pci_rx_get_frame(rx, src_port);
>> +		fdma_dcb_advance(fdma);
>> +		if (!skb)
>> +			goto allocate_new;
> 
> If napi_alloc_skb() fails due to memory pressure, does branching to
> allocate_new prematurely break out of the processing loop? Since the hardware
> interrupt was already cleared, and napi_complete_done() is called below,
> will this cause the RX queue to stall permanently for the remaining
> unprocessed frames? Should the code drop the packet and continue instead?

I went over the series and sashiko feedback, and generally speaking the
series LGTM, but I think this one is real and should be addressed.

Also it would be very helpful if you could (for future series/revision)
reply to the (wrong) sashiko comments individually explaining with a few
words why the are off: decoding the context requires much more time for
whoever has not wrote the code itself.

I understand that dealing with AI feedback is a pain, but, paraphrasing
a great aphorisms creator, I can assure you that ours (maintainers) pain
is greater.

Thanks,

Paolo

