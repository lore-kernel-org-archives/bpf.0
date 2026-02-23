Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47599313E36
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859185; cv=none; b=gKhebW7Y10QBZlWzCq4Uv3zZrSrzbRjZerhLlci/oAHZg/qhgIrjgoe+UDrm5/pefuQoU1Oz5LCEm+GQJrsxa2ws/IVbOvz3CoZTc54n3Chdwel6Fox8LgyjI6Zw6wAN1lAZIRK0Bc4zuFyITM/D4GC6xjnUua7OcSzaP1E87XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859185; c=relaxed/simple;
	bh=IHV7aqPp+bGHxNZCJm3n893oxNKmSFA6/AU1Qstp97c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFfa5szZRPB8tkIwSQmWW0EqvgGpP3N6e1+qX7pIZ4g+e2onZxoQIH/SwpWJjCHZRr0vSLE3T8D7JgePiF3gWIAj4XInm0TgseUn2skg5eo/YhGfzjj4rS1IYOJRQV1OIPL80PXuTnvNYJ4xxlRJgCOxVPODZBuSw9VYXE9xtHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i522L5Tc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i522L5Tc"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48371119eacso51586335e9.2
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 07:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771859183; x=1772463983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEkms4j98deJ+XfmVJdJr2vX/lC1EVAkdFYjsx1rvdU=;
        b=i522L5Tc7mhKMN9JxKVr1ZG7Ak+qXF34I9m34qefivKv7ApccK76nCoHsVmiDpFDF6
         QrjJZnPKdn8guVFbSQmf/sxztrzBYIB7kEODFW78DoBS5GX2p91CAg9gtTDZYVJu5THe
         SKoBhuW2HhjbJCNbBRDXGkpN03C4f5UP15fLddAYqCiW0cmxib5Bq40W7CKHiUMnowdP
         8UwrPi4SfLwjMhv/h8o9lTWZxoLxIRjlj+7jN9Xwa74DDkBJDJaPMqg+TZ8sM1MYtaGP
         Xvx+xLLNnrLe6WpxcqprMMnyGN6Yp7GrzwwZswPbDHtok/3ipDHuQLeDdWVR3X0qMcRl
         tOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771859183; x=1772463983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEkms4j98deJ+XfmVJdJr2vX/lC1EVAkdFYjsx1rvdU=;
        b=vdpHq/S2h38yioTFjsszgJXfhdmE9IShYkBB+jL0hpqgeMY1MId969spMoYbkejH3l
         nmrofRqbp82/SNNjzkotud44TG5VjisDyt2sr1rPf7ojP08i5gScWy2vNg5NyHnroMUv
         ucg27/AguPAwDvoBQnVZ5Nm2wAWtcPxunvnZoTuTyPOipEUSlg82UEBtNyr1Frp418iE
         Awab5GOU5y4veADBhT9ny+N+nG4V0UlWyzeyTfXRDEDGD4Z2w4GkJOUdFYWPVwIFeflr
         NuQENa25KgrEWDMxWghMJBvFJIiu/XhzOWb0I0wTcdIKwOfTx9QABg84UYFnuk3CcUDY
         oInw==
X-Gm-Message-State: AOJu0YwBQ4RRxL8LwsuU7/C0T5s5EjMmkEcxZ4Dkp/uPOUvX/sSIb9Sj
	u8krDRAQYJbWr3NNuVBzmcqtqLRf1a7pacxGJx5fkKwzYPz5p0mKh5FXp3QktA==
X-Gm-Gg: AZuq6aLNJKL/6fu0cHmQ50Tc+3I8XnDS9nuYFQJoKFO6AsmomZXQJ1CPdyTudjs1t/H
	1cpfsdc3mHdhBIaA41qMLy7GLYMszrh38rOXQLtUV2I7LviKV+tyCXaXRt54/YshcnTZtZcB478
	11qUhupY1KqWkk8ccj/20C/IYdyGA/a8EG3LHfAZG0te/Q+gKUbjOnv/XzbtgCiwPqhGvFeiSR7
	olrzfMsNcG7P4acgPO66X/gtqJBQ6zcYCbCQI2uj4X6RTvmsiLb+Ty/RuNXF2uopBkS/oTDjTYs
	fiT4XL3XchufPsfLI180cKred327thoK4fX0VeNDU45bPX8tYn2kF3k/ZvVF61T7cSGqwcewN+Y
	SMxIA1gn9SG7HDt8AUA4Z1RTEFPWps7wgKscUxQS/7kfBfL6/HMGnz4B7UxxLGTYKXPYRwpQffD
	xiW4y4L5DL5JO8we9fyLRVo8BydSqHuCQRgeUOAdWZrH4S5tAYskKzGvPSqg7KgIpME8tZpsH2c
	Iz09YPLV1jq/dvMpb9XUffdBti+aGJYrqjyWsY=
X-Received: by 2002:a05:600c:450c:b0:47d:73a4:45a7 with SMTP id 5b1f17b1804b1-483a96377b1mr144550165e9.24.1771859182508;
        Mon, 23 Feb 2026 07:06:22 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325::38a? ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cb4bb3sm194526255e9.14.2026.02.23.07.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 07:06:21 -0800 (PST)
Message-ID: <b22117fa-84ba-4f9d-982a-bbaaae35eebd@gmail.com>
Date: Mon, 23 Feb 2026 15:06:18 +0000
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
 <d808f483-3c0f-4323-8faa-0b7d49c539e3@gmail.com>
 <a7e1f667-04ba-4fe5-b21e-8c47e68213d3@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <a7e1f667-04ba-4fe5-b21e-8c47e68213d3@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/26 14:39, Jens Axboe wrote:
> On 2/23/26 7:32 AM, Pavel Begunkov wrote:
>> On 2/23/26 14:14, Jens Axboe wrote:
>>> On 2/23/26 7:11 AM, Pavel Begunkov wrote:
>>>> NOT FOR INCLUSION
>>>>
>>>> Alexei asked for extra more realistic examples. This this series is
>>>> based on top of v9 of the io_uring BPF series and implemented as
>>>> selftests. There could be more, but I stopped with 3 that should
>>>> give an idea how it'll be used:
>>>>
>>>> 1. A QD=1 file copy program that show cases state machine handling.
>>>>
>>>> 2. A BPF program rate-limiting the number of inflight io_uring request.
>>>>      That's a good example of what users asked for before but seemed to
>>>>      be too niche to be plumbed into the main io_uring path.
>>>>
>>>> 3. A toy example of how BPF can interact with registered buffers.
>>>
>>> Let's please keep examples in the liburing side, where they can be
>>> with the documentation too.
>>
>> I got you a liburing example
>>
>> https://github.com/isilence/liburing/tree/bpf-ops-example
> 
> Right, but that's just the nop thing, which isn't really interesting
> outside of doing basic verification of yes indeed the kernel side works.
> 
>> but need to sync with the selftest. I think I'll rather keep the rest
>> into a separate repository instead of adding all helpers to liburing,
>> which will inevitably do similar things but deviating in API and
>> internal details. And it's simpler on dependency management instead
>> of requiring libbpf / etc. for liburing. I wanted a space for
>> misc io_uring bits that doesn't make sense to keep as core liburing
>> anyway.
> 
> liburing should have support and documentation. It's not that hard to
> check for libbpf in configure and either build the support or not. Once
> various feature support ends up being fragmented in the ecosystem THAT
> is a mess for users, I'd much rather have it consolidated and deal with
> it on the liburing side.

What kind of support do you mean? Installation, removal, other BPF
management is all on the libbpf side, e.g. skeleton open/load/etc.,
and with it generating new structures for each of them, I'm not sure
how to make it into some generic API whether it's liburing or not
instead of making users to fill in the gaps, nor I think we should.
As for figuring out right helpers and abstractions for BPF program
writing, it'll be a gradual process, and I'd rather have it
separately, it's not like I can reuse liburing for that.

-- 
Pavel Begunkov

