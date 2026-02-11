Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11442DB7A6
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823322; cv=none; b=EYwfe9skMrYM5tU0GNrra/r2L9SSROC1JhGi0+kqqSWVUMQ9T3cYWV3k5oV+jjGG46kfnKmLIzJXzcq1FjTPmMvlDcdY2wE5Ij6FML/TFhQSzNTpkY9h6iyNMqGwpBmMsXTqJwt3ESyYy1OK16jclEX9lSgHA1vbvlxWMe1qt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823322; c=relaxed/simple;
	bh=Y7SlTxzS2VnMDuAASMDM/Pc7J/4udBIFLvJlJIOJobA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkeUMXMsauphDUV1g+XnTN8O9KRu1m0bC+3S6XQKDR8y7Mi5jeccno0vSbVaTKNXgXEqS9wpmdB9V8TzqivvHlESISMvepkFPZdVd/E94O/6Rsga0VjBJAF0lWzLV9U8oXmKmgRMomlVEKELTWzt1CNV7uL47jG45IoYljlh0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EK54rvKq; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EK54rvKq"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45f015a3259so1998007b6e.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 07:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770823320; x=1771428120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQsZus6B6A2LGmBZfcvwZ5r04q2Vs4rLburhJBVv+Qo=;
        b=EK54rvKqXRcj27ID2/ELDBPIaEGh2PE7Owr0N1zTNLC7Am21SrwExpwilO1ZOSy+f1
         CIPpUh0h0dsb/nWyZAJZEnIaqj9mVGAj1u5H4CN5gWBhjXsO9bQJpifndEvuj7HeyWgr
         zbmN9s+mFzqEDfMdgWX/EmTkVw88nQrFkyyDSibPFztLLvV3LnssgQvu/Wg3QgUZtvkO
         EW7JTKhbt6QLncCSDRccDEP+gUulUn6WGCU43f1+gxWNIHH78IpUd2n0K4UHv2FktuDE
         Ad80FQs8+e1qE+R8QIArPq3Ly39uz7piNvq8UXRP/0uX0pkteJjoD5SIKkWP+rIUlFo8
         FfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770823320; x=1771428120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQsZus6B6A2LGmBZfcvwZ5r04q2Vs4rLburhJBVv+Qo=;
        b=cvKj1g7wRx7jFLSWAk9CvTMDdom9v17Rx7LETSj36zS0GxDmi9LxKjR4R13NYELJUp
         wucbq+2m+T9e+wRrzzQMOeV/hcErL46aaegpfeErkMHkBqmu28JTOvvDrXIda9gj+O7G
         uEXGHRfRpIg6nz/RHPg+P/RGkbCqSL29RSDu8dTCmcuujH/MRry6rhttE5pBFmDA4rDm
         H4MAGf5mFO8/BencJcBB/xDahXOP5yihgn5Ja7u4jffXqlIpRf29rvTViyi6PXNEzKxL
         PIrfBnHkM8bMy3zwd7d2QZUFcqFle1Y1tq00kTV976n/EeDPsJWYLSGKEtJ+dHkaCnmd
         fTvg==
X-Gm-Message-State: AOJu0YzFgO0oAhr7T+04HIXBBVBWubX6PUnldI76Dlo9xfr9aULXYWty
	YwqmebpS5r8WGoFpefJkbASytDPZdGj/fePJQMGC4YjBP+znpBpLg7/BEGzEgCMiqF4=
X-Gm-Gg: AZuq6aLnPaoWtFA9rylPrTDb35i04T2iYkkcUrPTgVAMP2Yj+GL8IgPvpQH00iMFxt+
	/SyFGOcTyjEsSqEpXIx+pwiFXu3xO/eiA752jTw2sOU6iCezy8OUTFdE8UyX3WRNm725mazrjrN
	3cPS71hk2fk2d7jD5oIAEo2dTRtVwRbwOyZkz59lirBAwrFcOnkYpdkzrbuw4L0HRrPQ2oeFpwl
	UXXodgMi54kxHPnBtTme2X6CUyN0PzemiqLD/p7V7OtHRSjbawbS3JkzQ1spJZZUOyNMkbtGQqo
	1tcV1cS7AE2YlwkFLUeA2Z0fLrUMbenObZzunP+zWfLpexcQo5PEpTenQdCg5nAvQmHFqb5+0Ow
	DQP/W+eTxRU2CBOIiZprDJzdwN1971Ebjrrel/fbTuKBvTAVECOI+MD0VbC2TVJHet3rOYjgRun
	a3cLm+0ADFu0P8BM4iWZobhG4Cwz1N7GOZuacq8JJwMCC7rC/0imHR2VGmdSRrmufS721WXrGh3
	ZzEzeZ41g==
X-Received: by 2002:a05:6808:c23a:b0:45f:1387:973b with SMTP id 5614622812f47-4636627303fmr1352710b6e.6.1770823319741;
        Wed, 11 Feb 2026 07:21:59 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4636b0c8606sm1116368b6e.18.2026.02.11.07.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 07:21:59 -0800 (PST)
Message-ID: <55db7c09-5bc8-4dda-818d-53130400ee50@kernel.dk>
Date: Wed, 11 Feb 2026 08:21:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] io_uring/bpf-ops: implement bpf ops registration
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1770818588.git.asml.silence@gmail.com>
 <7ca5070830c022493eaf45948e146f418aceb747.1770818588.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7ca5070830c022493eaf45948e146f418aceb747.1770818588.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/26 7:32 AM, Pavel Begunkov wrote:
> +static void io_eject_bpf(struct io_ring_ctx *ctx)
> +{
> +	struct io_uring_bpf_ops *ops = ctx->bpf_ops;
> +
> +	if (!WARN_ON_ONCE(!ops))
> +		return;

	if (WARN_ON_ONCE(!ops))
		return;

?

-- 
Jens Axboe
