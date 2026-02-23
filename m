Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356D81A9FA8
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857133; cv=none; b=U161dqTcccHrUHWwDO6tUMz3tOBZ++Ywd7hiNssb/Q0q1pmdVlvxQXS9ldrDZitCwtrv71tfR3od9AMAEvYYz1q/YCI6T8zpbIjSpEaSsnWW+3FcDGLuRS1oUWbPizeHRLqgAHQ16QeJlyrC1At/i7Xnsl4MoMQaM5c+A6dq3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857133; c=relaxed/simple;
	bh=3Zc+uRiN58XFWN6+0rpSke7KZkfFbqBysqOWy4wmT1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XON3gkP0Rgro2heYvhs39jRkKAK8zbwc+hHCxlmYu4FOesNg7aigZnUqO1iazxVZIPtwuwEu+UoT6zVpAz5I+ubkizzb1bMQ+GUDutHsT7lVvG3+5RJTbsCmnUmw8I/xYHGlI87i+d79E11oSJ0QNctqq9y/HWv3jDv90EADfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsBUlvFa; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsBUlvFa"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-436356740e6so4648668f8f.2
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771857130; x=1772461930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LI6emMZxIDfCxoTprBZThTpHOJPMdNw9OcTGSAjJRdU=;
        b=BsBUlvFaz/6WOdxeea7QWZnjghwGTeHq0E65RnDfk6pEMjsYhbrKMo0E81MW2v8TOd
         EGfsn3vb8mtyb8eSXYroV5to0qFmfDSot1Y8BJM9afnWNNACxOvo7wfwEHRK9d+CFxxl
         zmX/attaLTy3B59QfIHxxs7Syc60C65CBdSTMKxpxHyBMprI6Idx67nR6/JU2yZyIwEH
         4kwXSWQnLZNsfmJgDKVOpi2iN2GXm53N4seoixBogIPT62wqB/dOL/epnvcf70tPKlKZ
         6qbp5Dh2KLwgB2Q9gPnhlAbm6ajHRKdZ1Tx5cGyKZ/+cS2U/Q7pEm6yKOI/q9TdRnoR7
         YEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771857130; x=1772461930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LI6emMZxIDfCxoTprBZThTpHOJPMdNw9OcTGSAjJRdU=;
        b=k/72hxCjvPf48758Wbn5uMD6ymI7ToIcovQknKIKe7FOuvnuWzqvtURYxt8brPO9qX
         mrrmRzsMMZDZGnFS/qWPI7BU9vupqbJSnh4DI4i0ZMOtEGkMMyj5FM2VMYZ8fBUEiUa1
         x6KkeF+ztZ3FRg1Nv+Dk9OAmF4trgjbqKuhTuYdpsWwlt4J0ApWxCyX/zJRs1g5S1eWN
         YSW2yHfb3XVjPQeXf1W5r/QpnUR+AfreiX+04xV4lBoR88f6B+qGvGeHklXB6GOpLn/J
         QwCPkQ3FBTZf8XAS63McOZR/ZQicDmF39yFrH4GJB09+7tjYcDICUUN3o0MsOa4YHS1U
         wyjg==
X-Gm-Message-State: AOJu0YymlKJ5m+euYM5J4t6XitxmUDhRYg3wG456woY6/ESQWRFGJl4/
	+9bAJkmA/3dYIYBWWcQ5mIqrw6AroU9bC37WCwlJ22tXpfWNB0uYi4vW
X-Gm-Gg: ATEYQzyMx8JpcdzJ/hsCSaBqE0yYRdsXI5EnBJ/pqi//C3NK1VT22LbPoAxj1ha8HHQ
	0c74cEtf2onxE/hiagkeU4Y9/kOqE/BTReJ0bogqeOo0V6E+Bcv8djZs4CbQjfYmVi//COpMaj7
	dfbvQnlWg8Dim4dseiwbbnDt7WwORndt5RlJ/vzl10M9RDz3aSv5N4TvqctSc1KY+pSuf+F4WY6
	ixkRSEP3ZjSEuiq4lO53gEohQbEfFi1SFgG482z3Cl4qBDU67ybSHNsGYxP2d7AC1FWoP4ZSdW9
	Ta6SwqZKaEzEHaxJJldW3ywN6kTJXE713xX/5ExvLST7RjGkeVXRPR9OjIsuO7Zy/zLnILpG9ec
	Ty5Lzmt7OgfWjGjr0t0K3LnGWa0ABAVBf2Hx4X6GtiYYZCgbp20Dhv1NR+C7a+E7FeW1LaAzVyP
	rORtpn3kwDGALWr2xXE3xSLhJHvFYlHwRzIKDdjxN91RtLamQQtNIvkkEXz4xRKl+tFFrOizxOC
	4SzS+LCil3vVbF3uvuXuL/ZKjRzTVaiOkYzkvU=
X-Received: by 2002:a05:6000:430d:b0:437:6758:ce80 with SMTP id ffacd0b85a97d-4396f160edamr16697608f8f.25.1771857130330;
        Mon, 23 Feb 2026 06:32:10 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325::38a? ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff27sm21293391f8f.22.2026.02.23.06.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 06:32:09 -0800 (PST)
Message-ID: <d808f483-3c0f-4323-8faa-0b7d49c539e3@gmail.com>
Date: Mon, 23 Feb 2026 14:32:06 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] extra io_uring BPF examples
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1771850496.git.asml.silence@gmail.com>
 <9c8d6af7-8546-4409-91fe-85f92a08f503@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <9c8d6af7-8546-4409-91fe-85f92a08f503@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/26 14:14, Jens Axboe wrote:
> On 2/23/26 7:11 AM, Pavel Begunkov wrote:
>> NOT FOR INCLUSION
>>
>> Alexei asked for extra more realistic examples. This this series is
>> based on top of v9 of the io_uring BPF series and implemented as
>> selftests. There could be more, but I stopped with 3 that should
>> give an idea how it'll be used:
>>
>> 1. A QD=1 file copy program that show cases state machine handling.
>>
>> 2. A BPF program rate-limiting the number of inflight io_uring request.
>>     That's a good example of what users asked for before but seemed to
>>     be too niche to be plumbed into the main io_uring path.
>>
>> 3. A toy example of how BPF can interact with registered buffers.
> 
> Let's please keep examples in the liburing side, where they can be
> with the documentation too.

I got you a liburing example

https://github.com/isilence/liburing/tree/bpf-ops-example

but need to sync with the selftest. I think I'll rather keep the rest
into a separate repository instead of adding all helpers to liburing,
which will inevitably do similar things but deviating in API and
internal details. And it's simpler on dependency management instead
of requiring libbpf / etc. for liburing. I wanted a space for
misc io_uring bits that doesn't make sense to keep as core liburing
anyway.

-- 
Pavel Begunkov

