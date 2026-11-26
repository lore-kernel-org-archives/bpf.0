Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699736;
	b=w85U0YFXkm7ULMP5gl7xdyJAdlgZDNwUj0oqKr6LsqDMnn/k1fas/A8esNGG/jTml1yT
	 oP2AShuGwDamKuk/pzgxW+AedGjqgozs8bqxrwDFxvzUGlgtkKw7cHYvto+kaFMsShREt
	 veCPrxTScUgvQcGjcNZ9Rk89fqG//ZCcPdH//4XjS7ON8VdYNpTYJdq1gF3iwcQMiHTVf
	 DUok3WLUVYOEW22+44qCjFKCog+B+T8osraV68T0s+5PMM2Fwg8Ho9MgOiRdncBD7zL10
	 vJXE0SAkHNRb8byRkqsu9+fE1tUeBrE4mIwjlGlApPaUwA3gejSy7xh6K9W0/soQ6uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=khDlV/uVb7yVp3Pf5oNr3rLfI0ItUKfUVqPraLCpERk=;
	b=mktlIDQsBbaZM8QlQbJdJTVfrVFuJ/F5r9U/h7M8PVcQ4hnwfKDiLHe4doFMU3eXXqrV
	 vrmUvaSV1BY37w4ToACk4B2ZYV+O7DHBA+/XpNkbMsuqEJLW5w0uf8wxMmbJsNaIHwj1J
	 96C8wmr1NHO34tOSbfNP4S60lDr9kJhy0DOjmRl228gBW98iYX8NM0zF2ubBy8wxhS8Pu
	 vcfC4Z12FsSkK+emskSHArX7/SdqXEzYjE18dVl5zgIrPFFEhCCNEll/9tMduo6+ruMC5
	 pmMbsscPS7LZRrC7PIvuI0Unw7OeGd0dq3otyPPZLKUyQoL424objh6TxOnLv0sxIkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SH44WdX9;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FEB606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96FEB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SH44WdX9
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso70353635e9.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 05:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795699734; x=1796304534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=khDlV/uVb7yVp3Pf5oNr3rLfI0ItUKfUVqPraLCpERk=;
        b=SH44WdX92ksXSRH+ab8E2oa08/03RYfoeEv268K13eXX+hq+PjRe96ouXLuBO9hKcE
         TNhcFXICNFW02wGh2k8woc6/qES2xRJ9qAtYUbuuvs3p+vjj3mASqGHYjUqSCJcWZSo1
         A15BMGgb5HDo4nSHEmAEWSnSaFWfx6pQPlPlps6uer5KdJvJjYuWGJnthqjnVBgaXr8W
         WgabKNnixiSPU4wbFskSChCt8R674GfUL1nZzxGi3DreppPRB53Eq/thl5xhzM4HVUBD
         jOhB41iytFgIj8yM0jFnbkK9JGdqrWex8dwdf+KJeNE23DDPxJSn/gAlk2ghkoiqR0bq
         8kIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699734; x=1796304534;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=khDlV/uVb7yVp3Pf5oNr3rLfI0ItUKfUVqPraLCpERk=;
        b=oqXHG1pMc/x63r6fD4b3MA4OHcijUENvnbjN4n1apq+1c5f4utH+OQkEKN+/jk9nCM
         v/AeQsTcLfbG9HZrOn5wZMC/xg0re5qUrq5LKfm3JXA78DiW1QiK1dkSBNfy1cufNHr0
         9SR+yaZChItxhajG38vv85haDLwPo/xa49jIvZpS8lF0625eSBFOk2+JxR2b+0y2dz3O
         yZ924TFRE3ppkeBPFTz7jPzwFd2l1fETYf0bw4jfQ5BCk9kWTnQHH/S1mbl9CaEUyKk3
         4Hlj6ftoCJoL37/qnBxGXBYenPWndffnxFISUaKAVW2isqC7pvk95fBAoDYMXNsA0dc7
         jcqw==
X-Forwarded-Encrypted: i=1; AL+hErFAGhGk2fAPQp7AeHsgfsUi/QiCSvn2XDaDFyy27QYgeKCvN8S3J2qb8YTkQbSUVq4YUw4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/M2mUE350nr7PTzAoiX2pjbbq89jmodM7gmYa2cTgDU1SWh034
	MQrx36SOprNCnpf5cQG58CLJAHu2Qa7Y/l7/lIHuxe8cGPBTSaoa6PvKLSKhZQ==
X-Gm-Gg: AZFdTZcOFIwB7wPm1K1Hq3yurQzdjQ4snF4A1N7U3Z6OKicWyuDxV1aiDygQm2RSIoC
	TII3Ov/HGiADjr4KlIkMnLrdS1N32FhCq51L0F5q29PTLiU3WEjV6FnFtCGjxovCvZXiogeVmaQ
	4mlMX+yCt5Qpj7+xx4KBeQT8NgLGOy44X1hskPdM2IFqT8wdctN94JlD4xk91XO/MusiOgw5xU9
	kuHVbsPds1rkWsZIXaSvGFnDxEjzbxtlqOogMpXhDCz/MFM+PkPSxRioh7VN5TgbE63iJc5fiSi
	KX6c9hCU7g4N6FHx1NLkoOmbQRG3ud0NoIXfFG50I1WVd086p53pkwuAEmb+6yQQE1qpB5ZTlgH
	0GfAJTd6ln8BKF8H3KMSacXOkZET9xGJrbKfyG6DTfXB9vzXwbFjNtkAeUFLpL79oDoaePT1aS4
	sJWHUyUA/MHCLbrV/u6OJBvr3JR3sFY0V97InUszQM3NUQJG9MQWfLI9oEJ2pJlCd1XTj7qITzt
	qp68G5ruDsvbJvy8EbOtBSd4NLeulGhSIfbywFCU2nGkXTWP2EWkbUFxQ9vUZpvHPLP0wNNxbtZ
	CF6j3lfHui12BmA23HyuZIH1F9S5lG15TAJ0ZAxKZstYWxmS9+T2zvy/tD6aypck5ldGUPH6ftt
	5U5rHsw3Mn1bQ71MUmotNf1Wv98nQxqMOrWfNbXfcL3noRffg84zZ2rLecvs=
X-Received: by 2002:a05:600c:530e:b0:4ba:eb:eb9b with SMTP id 5b1f17b1804b1-4bb8880aba2mr414364835e9.8.1795699733503;
        Thu, 26 Nov 2026 05:28:53 -0800 (PST)
Received: from [10.54.182.141] (82-132-213-247.dab.02.net. [82.132.213.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe48sm37152734f8f.23.2026.11.26.05.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:28:52 -0800 (PST)
Message-ID: <11a00d5a-18cc-484c-9861-37fc116f6dbf@gmail.com>
Date: Thu, 26 Nov 2026 13:28:47 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/bpf-ops: validate loop_step before registration
To: Sechang Lim <rhkrqnwk98@gmail.com>, axboe@kernel.dk
Cc: io-uring@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261119115942.3613868-1-rhkrqnwk98@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261119115942.3613868-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 11:59, Sechang Lim wrote:
> A struct_ops map with only ring_fd set leaves loop_step NULL. The
> struct_ops update path skips a zero program fd, and bpf_ring_ops does
> not validate the completed value. Without BPF_F_LINK, the update then
> calls bpf_io_reg(), where io_install_bpf() triggers a kernel warning
> before returning -EINVAL. With BPF_F_LINK, the warning occurs when the
> link is created.
> 
> Validate loop_step before either registration path. Reject an incomplete
> value with -EINVAL so malformed userspace input cannot trigger the
> warning.

Looks good, thanks for the patch.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

