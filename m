Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD332C2356
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626927; cv=none; b=KFN2AnQIXGvguQ8rCELua1/gg3E28G3Gwg+aMrZOHuS/fHzwI1FYCHx3IOAl3HwpWuydHZ4nME5PC9lFKwO7/bT31Ex4yGwY8/R0malanruNKqykTwpCYK0UUdneDqjatQjGro374caQtoFal0YiOPjL6aAK26yvl4B3SwwfenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626927; c=relaxed/simple;
	bh=smZcoEAnOnGbWYQjTEx4wx5SsMpqu349Lu3q9NZylXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8aCYxZ4qwM29RjifDPhv8t/m38v16bzsmnowtNMGZtMFRHnX7tw6e7m+WsS8x/nJJbrGZTC3PdHRGyErkVzxtuoFXN7mUNNLm8v6c8wyFK3YKcKovyRhCRCrpmEOmmznHW3Sl7ef9fIDnd9wpHhLRp4bcAM6smrZ6jwv+e8w4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuMGdiZt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuMGdiZt"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so29737275e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 14:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771626925; x=1772231725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2s/8SzLr1kQgVOYkjFZAPLW+HaH7/zQRc6LGXmo8T8=;
        b=LuMGdiZtIGXiPOqiMTVh85w5df5SxWALOuHvXa8LYn8GM6OnPCRLFNrOqEuqYBXOjb
         m5nbiQfpYj3zF2Sjx9s8u3iloTRDiwk9Az/iJbKEZDi3woDcFX0rcgTteG91TJzIqCJ0
         bEZCQ0tI/05Q5Oofze0LQLj/4rllL/D5DwblPlZcgrwa8xTNoazSGy1fU9jVSeuvDCqg
         VAWM0/rUfK8HgOn2yN2V1qTjUISkKnAVy5a2IRR1LHFxQZnd1S91wZMYzWpAVmB7F5zU
         Iv/hYRtDMcTiuharygouoedW5F6YJsbu5tmvvo/7K/j4ACjuvHrKarTalwhZEWFhk2IN
         krcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771626925; x=1772231725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2s/8SzLr1kQgVOYkjFZAPLW+HaH7/zQRc6LGXmo8T8=;
        b=hpNnDz4KS2Alr7NVMbM+LR66L+OULalmcVlC6v+BnIsUCx7mGlKc1mgeOQgkNFj0tz
         hoJZBd4tD2cArRVjnFCOtLpaVzcIiQ1bvTptpC5sy7jltDYVSKYH0JeJ2fmaH7WR1W9P
         PayopjzlfWK4xuM+5Yl5pQ1iDzkJHLBmy6tzYCVcPk/1YDWBp0NcndBLCF0kbaNJD2l6
         PeGe7LuvnKEM66aHsv41Fkh4estxpm2uARh/o1uskwov1rEqhCgD2hADSIiOk3wpd2OY
         4LidF36NcApM9qolPe1Yz89OQXND7c8YCIvaEMKAnb755sH+etVbOowqQ5L7GJDBGpQa
         6DUg==
X-Forwarded-Encrypted: i=1; AJvYcCULQOATxJbaeT0X6wV7BC7fTplTBS5OIGjK3Db6fzJvISi+9HxZbv4qzyZXoYmO1Uv9yI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgPbg/YCYb43xgXgzkL1ILU1RK5BTKjRGo0c3wyGY14PuZWNTH
	iP9sdRUrBFIRlJbNpzGnMM0rzuRVih9b95CRTP4YAmgi3G1iFE7BCHUb
X-Gm-Gg: AZuq6aIPiQwsua+gTeDWeqyZ4PTi5poV3It0D9CRDrn+oHmiJ9c/b47LF1K4WDbVJ/0
	P306jbjluREdwXjiNUfoQgGBE+egNp0ij0e6A0fQwxmeTug9N3WYgW9GPLR1z6B0Cux5wzPgIad
	/EKRT5RCACv9rFnB3ICYZhgMKrPsX9CvilP8U0s1k983e9yMv9yiXAFTrag3nduDAkHzuFnWAoH
	4G88UbF1K6V6jQSEeT1YVrsSnADuUhISzi295UGB+vUuqprqEeOQAkDGRoSrPMbUV5dCpHBl+0Q
	9KJR+XMJz4Phe6y4y7+wAQppQmc7z/I/zdIOr0wRbG1x8EhLLV2AlNPH6tTDRepi1R4KZza6i6X
	ptyRdA/Cm+CZYnBjicOtZgiuVypJ4xkC+juSbgIUiPYBq6ocGxjdmMAgsPuhLCpRXZ9Pd4IgIIZ
	JPIzYtBLLsG64fBTqKVsppZvty4EfWD1fgpERX0igu1WTOFxn2QLC1HkGb0Rs3aSQKubknRP4T8
	389ZlGJrdY/jPv3gFc8RXBcQUHyGQX5YI5SAUUkaBhL3irwTq/tbwsPWGEkpWnHHDbIXrvqgcFY
	Nw==
X-Received: by 2002:a05:600c:8a0a:20b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-483aaa168b0mr1609075e9.20.1771626924446;
        Fri, 20 Feb 2026 14:35:24 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b3dd7sm101429365e9.2.2026.02.20.14.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 14:35:22 -0800 (PST)
Message-ID: <591a7f0e-7b78-42f1-9486-163249f5e306@gmail.com>
Date: Fri, 20 Feb 2026 22:35:21 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] selftests/io_uring: add a bpf io_uring selftest
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: io-uring <io-uring@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>
References: <cover.1771327059.git.asml.silence@gmail.com>
 <7cc147a959ac068c55dae4f540e38e9e4ab121e0.1771327059.git.asml.silence@gmail.com>
 <CAADnVQK0RaOA9ZYZdYyQxOzLde9MR8HpMM0SexcW59A9u7X2Jw@mail.gmail.com>
 <84e2f3ad-28f0-4e9a-804f-2647cba9b30f@gmail.com>
 <CAADnVQLSEoZ0V1m5j3ggX0o0gzVKyiDHL=J6F0wRXB8qk-MCGA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAADnVQLSEoZ0V1m5j3ggX0o0gzVKyiDHL=J6F0wRXB8qk-MCGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/26 17:45, Alexei Starovoitov wrote:
> On Fri, Feb 20, 2026 at 3:41 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> I had such examples, but selftests is not the best place for that.
>> It can use abstractions, and I want to make them reusable instead
>> of people copy-pasting from selftests.
> 
> Sure, but please still post them as extra patches so it's easier
> to see what's the end result.
> 
> Also please reply to that thread:
> https://lore.kernel.org/bpf/CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com/
> 
> It's not clear to me whether your io_uring+bpf setup will work
> for Xiao's use case.
> I don't think we need 2 ways of doing it.

We discussed this with Ming on the list before, that's one of the use
cases I target as well, there is no reason why it shouldn't work. The
difference is that this approach gives a flexible framework for
extensibility and covers a good bunch of other needs, which is exactly
the reason I moved from a BPF opcode approach, while Ming's proposal is
more specific but argued to be a way easier to plug into ublk servers.
If you ask me, we need a solution that covers a broader spectrum of
use cases, but I guess it all can be argued in either way.

But it'd be interesting to discuss how a BPF abstraction around
registered buffers should look like. E.g. passing an index to
all kfuncs like that, or making it a KF_ACQUIRE/RELEASE object, or
maybe something else. I'll reply later.

-- 
Pavel Begunkov

