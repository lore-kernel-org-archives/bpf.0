Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9325E31F98F
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786941530; cv=none; b=j5MNBwTLreQculTK6W5yuSAVl0mPlvDWeTNAbaviJfBuUe65w79nedt/V791bMSAI8Eu7TPAbecd2TAaG8v4Mcr2GqtCUTW+7D437P7tTtdCbLEOPiI/qHWkUCyDs9rAdPfasPK+XVR8sPZlZZDS4Rt0NWok4dT5DfjVijSvnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786941530; c=relaxed/simple;
	bh=fkQiXS2dj0HIQT6nxsCnV4dj4UNnrygOECOoDn6j4q4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=TZ4KcVlUIsOR9mIlyFofYSj6wPax9p3DF+NOqTZYuIC+Yn+7DLHTDS0d/iqdXiWO7NZZ74fwQcVspmd9W41tWknniSJkVVSnGOwJRcOFULtD+IeOtDRxwGiWRsUXxCVIPJg0j55Rk4wFhX+rlFLo8mW/EDAlpAgZj/aj9b4bFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpUqrq+i; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpUqrq+i"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fcb9d4b33so1273080f8f.0
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 21:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786941526; x=1787546326; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1c8foKhzrYQ6izTIE48GxSA/nmG3AeRv3jsPbmv5QtA=;
        b=UpUqrq+it8QQ/2LMCtrVz01FKOqOhA/D7TSemGKnO3ONZW/+I+D/9hXvSQM3faKxBH
         EF4ufoiaoVZ3RXDBX3eZc5P0YXqhP7lIMvbRTHnWp+k2Hi6oU3s7qC6O/51miUWFbvDa
         LMO8jPVt5m29KtXx0mtgc5Z9h77DjZLHtmiuBlXjXXEzbB+DbhaA17vjDsfoZX124dL1
         tDhXfvpkWP30KuEUEj/ndKqgX0zs5lissCUVQwNiE6xBYjjEKwYeH3JsWL36qrRUXMCa
         BEAcmUw4qjCachSVd8sQkGVJ55UNLXYiGqMM6uESuYBiX7pYPhO7KYaVRYxWQZCFWBXq
         SjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786941526; x=1787546326;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1c8foKhzrYQ6izTIE48GxSA/nmG3AeRv3jsPbmv5QtA=;
        b=dQ6qy3cQedFwTpJLA0zkt5ojBCcRqMhOLTChpxMQL5DqSP6C+6ZQfBDqn9OA6ZQahY
         eJBfcpIscJFELtg2PG7qE06xTtvGBt8boljZLo+uJxBJ/HUqpn5/CbZotkQsVKyijQZf
         cvy0EimxQXCfMLMUDEbWOdqgUNqfA4Dto6AO9icxRmoqf+HwukWzKXQHrAfOP527dXgO
         eabh0LqjwjspQDoqbn6l0dAcXUAG+FRJIXksrcgMpr2mP5gtmrhozgrmvxloGBemUQdx
         Ohdio4wghea69I11MDCPpjAr7lbqKqS5BKVWkl9e4eU/qhYXTK89rxxyLamZSZFieY/a
         +bpQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTwYJAl5nlNG1+JCWKptQzyISiXsOLhbwsXheCwtWWHnCyCN6XOUzY8VJTXL1zkvBzMtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzELnGayW/3LYAFlqQkOc9Yn8rHydyLOUZtwpx58VMQxAEx/jbm
	AXbzmH2F+co0xi8SSPXq/GcbFhK9YUJC7+LTavTT3+3N8ovl986JpvhT
X-Gm-Gg: AR+sD12zUvb7Vn+jrsGIaIuqpe3UZqB9CGoly8wYIHe/41tiGukI/j09FKNcQYRW/UB
	rYpwSV95JIMU60LWF7c7aH8hOINJ3Wy8s9+isyrWU70D2f9WFhtplLB2BFFSKWKpHrvNLRCODZL
	I1dXsc+GBuzFzAZCvVvGuDjAWTnD4RK/a1l6CjmcS2qMro87VV4FIVXm5IAiX/YE9CiIFOoYgOq
	dSiJyWr3UKvh7newaTyWITRVj6BYkMGoGNXw3u+xQm2pqRrP5pOiM+//3nyHFgCiU0T46cL1IX9
	TTu+jPtN+qvyPBok+EMQiqBrTW4mtVn84SO2Hqbn6yqLfGsGKM0wZW/gj9eFYw70aRT5yBkaxlM
	dWFk19+yMn8Sxa/pfhDPHF6CXuZL0rHghGQxBSnM5zVQqA5tCIP2FhjwONY2Xs47LZecWanIKE5
	rp6BDFtR4T1BH88gaXntyU7yeMKTB0/1tu8uq2cx2o4e5lwW+owMpQnd3Cr10GFb/fPfxnpTlei
	gD286PcyJ6oXuoeeDMuf6o4foTBfrFhmItbhWDU/UJlARGG38MRq3Eb4Htfk0Y3EfAXpZy5yNeo
	ZXGakf7/u0soNe/29wNBhtvYyLU=
X-Received: by 2002:a05:6000:25f4:b0:47f:7129:6e2d with SMTP id ffacd0b85a97d-48160751f31mr34517595f8f.17.1786941526370;
        Sun, 16 Aug 2026 21:38:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c57fsm625297f8f.22.2026.08.16.21.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 21:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 06:38:45 +0200
Message-Id: <DKQXWK0ILLSS.UF4CVFD9NO3I@gmail.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Vincent Li"
 <vincent.mc.li@gmail.com>, "bpf" <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, <loongarch@lists.linux.dev>
Subject: Re: bpf selftests timer_lockup intermittently locks up kernel
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <CAK3+h2xOSEZUHhou7N2cRL-aGrZCNSm45g+P7thObMe+fpgYCA@mail.gmail.com> <d06a7557-fb51-2be9-63cd-3269533476b2@loongson.cn>
In-Reply-To: <d06a7557-fb51-2be9-63cd-3269533476b2@loongson.cn>

On Mon Aug 17, 2026 at 6:04 AM CEST, Tiezhu Yang wrote:
> On 2025/8/25 =E4=B8=8A=E5=8D=882:26, Vincent Li wrote:
>> Hi,
>>
>> I am running bpf selftests on a Loonarch PC and observed intermittent
>> kernel lockup by timer_lockup, then I can repeat the lockup just by
>> running the timer_lockup in while loop every 5 seconds, I could not
>> find a good x86 machine to test, and I think this might be
>> architecture independent. I don't have a good way to capture any
>> kernel log messages for the PC after the kernel hangs, and I had to
>> power reset the PC.
>
> ...
>
>> #458     timer_lockup:FAIL
>> Caught signal #11!
>
> I recently spent some time investigating this and
> managed to reliably reproduce the issue.
>
> After adjusting some kernel configs and parameters,
> I successfully captured the call trace.
>
> The following patch fixes the issue, feel free to
> test it:
>
> LoongArch: Fix __smp_mb__{before,after}_atomic()
> https://lore.kernel.org/loongarch/20260817035908.460-1-yangtiezhu@loongso=
n.cn/
>

This looks correct to me. Also, nice that the test actually reproduces the =
issue
without that store-load barrier present, which is good validation for the k=
ernel
side fix.
