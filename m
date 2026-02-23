Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C51284883
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856098; cv=none; b=bSjcmNhu/7IkMlCEN8cGxN9hPNqe0+yQjoTnfVAVpJ9/w8T5MCWGEzr5WRUEJvvx8KUzr1Uwxe5kK/gwWnyZEJHlIeNaA76k/rR97nIwr125Bkz+/5OIUSZh9XjCFoWEIt6xlHovpGOrLOedWre/Ed6cbcDicYSlAztZzpvkR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856098; c=relaxed/simple;
	bh=H2jrWjwNR/gUdKONLXS6LvcNwyFd90yQbxCggKjpgV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxE6dG9Rn62wVBltuy72xZZ7rRkO4W0DMs2vvrHk0Ny+/VDhRKCkHnwCpupTFdK8Eff9fL+Q40CCWwU1q09U2MviIiwhkLH1s5xHWdIWAe1S8pBvaFAwds1HDcDyM3fwpfNf/1xbt1wtjl/9Wg/hGZo8zU2pNkn/iZSKbVOXt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ct9ndkmy; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ct9ndkmy"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-66f747175d8so2538398eaf.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771856095; x=1772460895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85tbePhfgcNJBXnitvJ3AoABj6IMgYNXONGM7ClTMEM=;
        b=Ct9ndkmyd/O1K7daR57aLTu9S7Fmj7NNyVTgCrxvynmhvWp3SAZBvjgJRfWR0xC2j4
         ZATPyNy3fyLqPsFilE6dmPlcMjl+b4nkFKl8ONd7Iti67IiHoEeCWRhd8XfOdRhLb/1V
         XAIZD4pjy5wqLVoKJCQ9vB2b6NoEU67WmoXgOwBMgsP8WxRY/39A6Idm67SaSd0mQp4/
         YMavf3Gqa+Mixe13hv6NF+8x2/yfYRmljKKC19o2KVatM3sk9nqZhmA/KxM9fHu9gCsA
         x5DkQGdgpRTxDvCvDqPv2i4Fn/lMPvwpSpA2a6wPg/yrTo4tiX+kEow8SO8FZ3TPTTe9
         Ad/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856095; x=1772460895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85tbePhfgcNJBXnitvJ3AoABj6IMgYNXONGM7ClTMEM=;
        b=tmxRyVUb+fU3ClPZ2VRRHeGYUsJl1Ljbse97aQCInlla/uLFuU8tAQeYlVmj1IyxEd
         /qoQDbgBisSFOenfmdaxO4mJeEkVrUoVVrbz6nC0x3FNsbycw2YNRG7LTJRbq45NT6ln
         fpAADKaPb8Mk+mHvahuoax/5Juqk7LT7NE7wL40tkj/g1ZA+44jFju/+J9NuSt3FLbUk
         BlLSS1Z4eBR0Bt/KCnQI9+uQKkM/SuAFdgdIF1C/nIn41QYXeOcopgELxIKhltIeHy8A
         BnZYr5OEKNddQlDYW1oVr5HT1u6pcPXVGmtw7IsgVzj4nakwnsLVI9871hhhilrFxqp3
         2fLw==
X-Gm-Message-State: AOJu0YxTjKf575hbpW4gZrHRgtBoixnMDMKqeWrZ2QwvsepREJLIYGYf
	tBN653IvTFOXyDq6oC12yc1g1DMz3ApFrYzAY7w51m2F0ih7XOzJpbHNJwwYZEmp34U=
X-Gm-Gg: AZuq6aJzF4Y+uSgRzdX3QxJJ5FHhwNbaYcXAaYEnVpp30VdJVsXubxsrurRKpRkkJb4
	R6rd7v244qOxx0iGR1zkVGZwrVDLP8rlzd95jEMf5ldjLaSkgVoVoQVc+yc42Ef5CIfJjCK+OqC
	tGzXV/XaBoNycGqFfr+24UCqQHQioyibJuWA/Dy9PcT8wpjLm4jdn5BVRd84mdJ7t28UAckUMAn
	VdNOuNXlLmZ6SqoRhekAX1NpMgupTEnlo4I+bvfNFWP66ead4M/7S6/KhfLDryBBzlqqQ89AE+h
	ijBo7V9YTdNIkgDfEHa459vZ8buXtNe2/TPvKzkRoFIN8ViqeUZk2p6Hngcmqe3z0aDP+YxuwFg
	5qB5v9khfFfbTxR14uSH7S+zsfP44MC8n5xtnE5E+qOLlhRRcEexmT1A75Cv+5qyJ8QgGyEch6O
	jO9+PlxEgVqQEuO+4olW6yBaufr+hlNyFy89JjEDJIZ5PO0wbQuFPV2Eatkc8/Z55wv/HMRIsPG
	Yiq/bIR1g==
X-Received: by 2002:a05:6820:1624:b0:678:7fa2:aa6 with SMTP id 006d021491bc7-679c450719cmr4818167eaf.57.1771856095672;
        Mon, 23 Feb 2026 06:14:55 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cfed28esm7460837fac.9.2026.02.23.06.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 06:14:55 -0800 (PST)
Message-ID: <9c8d6af7-8546-4409-91fe-85f92a08f503@kernel.dk>
Date: Mon, 23 Feb 2026 07:14:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] extra io_uring BPF examples
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1771850496.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1771850496.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/23/26 7:11 AM, Pavel Begunkov wrote:
> NOT FOR INCLUSION
> 
> Alexei asked for extra more realistic examples. This this series is
> based on top of v9 of the io_uring BPF series and implemented as
> selftests. There could be more, but I stopped with 3 that should
> give an idea how it'll be used:
> 
> 1. A QD=1 file copy program that show cases state machine handling.
> 
> 2. A BPF program rate-limiting the number of inflight io_uring request.
>    That's a good example of what users asked for before but seemed to
>    be too niche to be plumbed into the main io_uring path.
> 
> 3. A toy example of how BPF can interact with registered buffers.

Let's please keep examples in the liburing side, where they can be
with the documentation too.

-- 
Jens Axboe

