Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F73143740
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280417; cv=none; b=aHE9YNZ36nXfXjKrYWAQB5AHsQBk/chuQaMfhy87LnkyB6NuLgKAJZ+s4M8eB9lFKKJIhT3mIK0H2yA1LgXlYrvQW8Clh2TNrQqZRjmXr0D9TvTV8IipF/jpEIn2OlTAX6yJnTfzPKWn91nfUXiiaOKhU/A7pSjBtWyg3PHN1Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280417; c=relaxed/simple;
	bh=GoH2vZtMQEyHzGMu+xjFvhPYeQ0PSvOxNtV0ej76tc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcmIhyQ0fm5S08tNcjGZEOFaWB+KK4uaytuwernm7d8RxBgzWE9RTRmbTo0JRb27Peba4+7yDDrKPmBI+obBX1srzM05JwSAULkkT/m9e5CP+oz/4N9j4xnb97iphXGDbQfPq/4JEfrbN5aRC4/A3DKk3e/s9rtFE0t9MS96QRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XogGqnUM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XogGqnUM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd6d4832dcso8513425ad.0
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 14:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710280414; x=1710885214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgAoRXoGVuTzBazMoZQBPTv5bpPC2DD6aVA+CvxbndY=;
        b=XogGqnUM7Bh5JnuGKX06R/t/aiIHEjMIZc3n0YJXm9qy17C5KE2EMmkT4jIjsZRc+H
         iHaaWfyDOtg8cY1T1XXgkM4hhZcfH6mx4cBz6rxxk0LoEPf/RIlo/H2Cz5XlBawAjnC4
         cHVf975xy9zEAKCSx7CRpeU54++CYA5IrKic0EY03Y/Jf7lwgNRe00mWQGzhOLtakdy9
         QsO2GuZIeP5uUUbpkU8epQ6F+4dNH0DKJQVU5lzhkC/3iuJhYkoDXfhqjQYYOeYUiTk1
         cveG00kt4oO+O0PdddOwdQCvFbawaTvKxu6zdu9ZR4I06nMVbZ35RE5bFb1pz6PUxr5l
         9xRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280414; x=1710885214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgAoRXoGVuTzBazMoZQBPTv5bpPC2DD6aVA+CvxbndY=;
        b=OPpuDr75uRABsf5SUlqpE5nI6EbwbsLn5q+5SM28xYw6CT0bG8wYV2l9BLI0c5uQOh
         cAnioKaPmjP/ipBPVvUqH2kLpdeOskmPBXoczFREIgHrzHc6IrEiRHG2FQOJ/5Zo0KrI
         h4+wwdXhJQlD7iBV8EblGxMcTNJXz/stJQ2Wcp0ca05rnNqsxZRZtjHKNsEcvSjjF3SZ
         iq3NOMUpgVPb8+rnVUH86SQVnUz5f009Pv7M8C+15aeU5p2/lc/4lElflOP1t5wGXR+E
         FKkTOvhxmjqqxcgC+m8equR+dPZalVhLweLX6BlmaGnGhdp3TcDQUF72aE8VFqJwz+Jm
         6Z+g==
X-Forwarded-Encrypted: i=1; AJvYcCU2Wf1rK0qQstG9ZaJmXOPpv2Zvr8BxgIkyKNjNZ0pxCugw4vaU91l8zN5sxzMxN0NK3eTht6moAVZ4v+JJeWgorXeY
X-Gm-Message-State: AOJu0Yzd/1AgdQYSQPSkH0J46U0GX82ONW2vNj26mhQ8wqw0J07SqEtN
	2898gWRN33tdMNCM/ntGmmCuQl8VMf4wGFIGqryccetCtSls8jLwRkwYBvEM2G8=
X-Google-Smtp-Source: AGHT+IFm+/i67+6f03mMl5NqpTg05G9OjYuNth18e7nFR3xYoxgZgBTMSLZXo7FSveVxVdE8GFo8GA==
X-Received: by 2002:a17:902:8a91:b0:1dd:7350:29f6 with SMTP id p17-20020a1709028a9100b001dd735029f6mr3069799plo.3.1710280414017;
        Tue, 12 Mar 2024 14:53:34 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902e74600b001dd69a072absm7228013plf.178.2024.03.12.14.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:53:33 -0700 (PDT)
Message-ID: <72921846-16d0-438f-a6b0-eef704542e6d@kernel.dk>
Date: Tue, 12 Mar 2024 15:53:31 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.9
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <20240312042504.1835743-1-kuba@kernel.org>
 <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
 <20240312133427.1a744844@kernel.org> <20240312134739.248e6bd3@kernel.org>
 <CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
 <39c3c4dc-d852-40b3-a662-6202c5422acf@kernel.dk>
 <20240312144806.5f9c5d8e@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240312144806.5f9c5d8e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/24 3:48 PM, Jakub Kicinski wrote:
> On Tue, 12 Mar 2024 15:40:07 -0600 Jens Axboe wrote:
>> Hmm, I wonder if the below will fix it. At least from the timer side,
>> we should not be using the cached clock.
>>
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index 9a85bfbbc45a..646b50e1c914 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -1044,7 +1044,7 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
>>  	unsigned seq;
>>  	u64 vrate;
>>  
>> -	now->now_ns = blk_time_get_ns();
>> +	now->now_ns = ktime_get_ns();
>>  	now->now = ktime_to_us(now->now_ns);
>>  	vrate = atomic64_read(&ioc->vtime_rate);
> 
> Let me try this, 'cause doing the revert while listening to some
> meeting is beyond me :)

Thanks! I think the better fix is probably the one below. I pondered
adding a WARN_ON_ONCE() here, but I think just checking for in_task
state is probably the saner way forward, just in case... But I strongly
suspect the previous one should sort it for you.


diff --git a/block/blk.h b/block/blk.h
index a19b7b42e650..5cac4e29ae17 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -534,7 +534,7 @@ static inline u64 blk_time_get_ns(void)
 {
 	struct blk_plug *plug = current->plug;
 
-	if (!plug)
+	if (!plug || !in_task())
 		return ktime_get_ns();
 
 	/*

-- 
Jens Axboe

