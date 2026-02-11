Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48861309EFF
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824455; cv=none; b=AdDNh21eTixkfcycCyYcWdyKOV/1QEYe4UK8noi4QRB8EJXxpWMFctDCMYG2c3Ef/kOCjv5K7dEKnnxwumviKS1H+fXRgpRQQXU89Vqh56JBseZ5wyuRx0Ijngxr647EuZ3DSxFBl1JUmvkuSkeJGr2p23iZuK7/+oLXRVaGJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824455; c=relaxed/simple;
	bh=gar//loSr4yv/50iCK+pDKH4gpzEImR6mB669ItJ9JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ej0aS9dd1atArZ9byy0/J4g+Z2ip5WFSAMPCcGDieo7Ix7swYxDFp9gHy3w+r5lOrMthRvoc457V5jTMS1IAGqWcH3uSmviTtnVS6bDQAssfGUXMmhNuWEanbAQvORjxHARBFI7lySxU4UR66revPcmTFhRdbVCYe/guCo71o0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKS5w1iG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKS5w1iG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so65922255e9.3
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 07:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770824453; x=1771429253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdKarRN1NSXhH05CU/sjeG4t0zo/Q2fYiKAEmozL0tE=;
        b=DKS5w1iG0tANc7OrknUKzYtZaEK+wslS3ZD34Jwi2JeOO3yLBmdBtV89yN/1mDSGan
         SBI3fsi+wTotQQjIw7oDtW0I5x/v48YnRfnJ9a33m9sTV7cYAG9ZXtUcn7BIHbUVhnWL
         XjRj7eO5k+eaLxmDTqpzJPiU9Z/sxCYssLi8TZAmicVZLkE2GO037Usl5RdmuipYakOm
         fsITy+6oSADtPg9X+Nze6ZV4UfwAA053CPSmNsSdyS1OWsshO9UG7lcFGtvsMbeLSs5d
         60YOVDF2VR6LPXsKVwwDIgcbx8iJJnB1ZDHl17bRyIR8XuECwcRCP7VFcBlsV1ip8SIV
         CqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770824453; x=1771429253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdKarRN1NSXhH05CU/sjeG4t0zo/Q2fYiKAEmozL0tE=;
        b=Ys1fQ447ive1dw+FyRmx5YUVAFu1AtOmnxKj9Sh3iliOZFcbVTKCmKRNk/iVU8sRXM
         P9fFjWMxZ395r/s8bQ8iAmhdA2XQ6qhRFoQpquyM9sN0ONPt4gQtgVcS4Myt9EEISXYI
         4oNgOYhK28L79QjlFCvKKS6l1pkrMtGnrR3APhZcmbXIe53xOQK5UHRkfHB11yx7j7R1
         kpNAY7e68JNa0k94gZC/gf9cnVKDoEPRz/y8ZK1xLoJs7dxNa7vrthAlvK0kbaW7V3gC
         OoRI0HG2rNyHdc4CXRme4uKIq4ktG2o4D5i6eRytzAXnQjqqpPbXb5xghSdBr4xaUwKE
         5Dhg==
X-Gm-Message-State: AOJu0YyuDj6/t22CqASZXOozuceA0G7T58mWK/KuFPYBe4ZK0WMHHUFL
	nHD4lf3NdjPPI8GsG4CkIDhkqK2XTm+JtyUQgE0nN4au06H2b9UyDn3fXgKoIySi
X-Gm-Gg: AZuq6aKi8I958A6dDXIcp+Hcutb36zceIbWbQYclZ/x07BjjcIN1Cmkfe8H4UqpgQhY
	ik7mBbYE0pB6Inp80lMV9sp0W++ORH2chL2lNxW/KhO7GCsvhYrr40NALVhrZ0U6235qAic6eut
	Mf6GMbtWImq2VQzmoxp8XPxrJw4xAI6vDmLDF9JFFOmnUHGowYFDZMJ+DxmDyaShxo9HkEkgwvI
	CSm/5F7G/W4t0g4sYnCDBf5toekuZTwlXguRmw4cA2Z/oDDaVjZbI41w4aP81RJcQEbiUGzzKs/
	YxN+0iq5buRXwu77SB6UrM0VxVdS+GwVOo8TmrwJ96iPyQyeH7WS2gVKDRX7Qymst6tPRPCeunx
	c600S5ZKKXhEJ+X5If7q2paY68CGxbjUYHcG5GInuDhUcLkVchF38meUpzoTBirr8181k9vkAEK
	swrtypruTSUmHTiXfHI/GRUWeEWonbI/y1Otmbl1gGJOb/7qa+9fDSkfgtn4J/ipFYcacahg7Bq
	cf9WYeKC5LiFAC/ZYGl8AH2XTtbbonctDDtE7H7zLQFTelpIZ4IS7wEyESaAxbU4dlWsoyP7eEq
	mg==
X-Received: by 2002:a05:600c:8587:b0:480:6941:d38c with SMTP id 5b1f17b1804b1-4835082d177mr90270985e9.29.1770824452529;
        Wed, 11 Feb 2026 07:40:52 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dd20519sm85013405e9.15.2026.02.11.07.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 07:40:52 -0800 (PST)
Message-ID: <8bdb51d2-0935-41ba-bca6-c9d575c7ae99@gmail.com>
Date: Wed, 11 Feb 2026 15:40:51 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] io_uring/bpf-ops: implement bpf ops registration
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1770818588.git.asml.silence@gmail.com>
 <7ca5070830c022493eaf45948e146f418aceb747.1770818588.git.asml.silence@gmail.com>
 <55db7c09-5bc8-4dda-818d-53130400ee50@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <55db7c09-5bc8-4dda-818d-53130400ee50@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/26 15:21, Jens Axboe wrote:
> On 2/11/26 7:32 AM, Pavel Begunkov wrote:
>> +static void io_eject_bpf(struct io_ring_ctx *ctx)
>> +{
>> +	struct io_uring_bpf_ops *ops = ctx->bpf_ops;
>> +
>> +	if (!WARN_ON_ONCE(!ops))
>> +		return;
> 
> 	if (WARN_ON_ONCE(!ops))
> 		return;
> 
> ?

Good catch! I even lightly tested it before, but seems like
there is a delay before the program is actually destroyed
and you could still call the function without crashing.
I'll add it to selftests.

-- 
Pavel Begunkov

