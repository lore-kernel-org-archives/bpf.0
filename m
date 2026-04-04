Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7008D212566
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775346594; cv=none; b=LFYSHErEh9hJ2tqtSKC7PTCjNUBPRxYlwSIXIs7tVAE2yuzhrlxhEfY5FANANM8R8V/jKks4i+zo5YPxHJGyvT62rNn9UQe1xTwtw5hZxvifPlsSJRCMSZ/tZv9lOnRfPetqJa1UmIzbilB8xOcLqzsAEUvsmR/cVWRBZt5r3n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775346594; c=relaxed/simple;
	bh=0pfYSD1KjFJJOfbe/xzXakqDAr3dURE/DFzt7FRhLk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPNfmAH1jl6lQMpKssnuFxyRzKyATdGK641HyFDjDhbPvkia+TpGch0pOO4h30Km9Z4REs6/4zD9KUgWO4KVZjZ8HGOuRxp+22GmX7SgbC+unHUJtfQX6WHF0mOKPwA1mH7R4Uttop7HzHT6zYiYS/DkYVOFojN1SFI3GiNwSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSJ1wKqv; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSJ1wKqv"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5091ed02c54so921201cf.1
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 16:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775346592; x=1775951392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pfYSD1KjFJJOfbe/xzXakqDAr3dURE/DFzt7FRhLk4=;
        b=JSJ1wKqvQ4LldFK2J+87r1XXS+jqw0zvG8ycYsiNeK6FQGv2aKQJ1lTYwE3LFreI6H
         h4WXdR4iRSW3lZZd6qVme6gmatUK6ohA0kLxgOzlQoNosbB3mkZWTsyQnG+dJOf6bugs
         eYFqNuk0eznSjEjjYM7MabD+BNf0zPntUYBCY3U46htvJ5zj6h5oX1pR869ouafy4fKt
         ncQ85ZkodudK2nvy0/laH1IFTW+4dCsN3SQdo19v/bEscg+sX2sk7p/8KKd/EMGEfanD
         3CBceoFqIeQb5SjHYAPKwiRjogZPZAdIXPr5Fo5D499TFx4sO31NwBKtMo2dobJ+Rmjf
         gcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775346592; x=1775951392;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pfYSD1KjFJJOfbe/xzXakqDAr3dURE/DFzt7FRhLk4=;
        b=Edl0K6rGnbocdYD+bYnHknn1raJ0k4qnTg6NC/bzwII3rUgdDOxCdMk55nMHCE/sAl
         6r2UDwbRSQTQ59EkB956sJpvmAIplopmLG/Nu0iSnl1frRVe+MeKEoBEwNaxWZ1CRQMU
         F4XB9bUO/MxL5vyTrWe/iR2T7T+U35mNAmOIA9OQEQI6Ugld4O0OOGhHzChb8uXJ1R9E
         cTDfrf4DbiZX8dIxoHUZUBkvh/XBU4drM+K9wiycq4YnQp2e37BBy027efk89e0SCArA
         kFapui2rB5XpW7LP1uO0KmKOBJQRUXFYNuJO3Z8fi/FrUHwgtkoCbdjbWjbr4LyC0Nxj
         LrxA==
X-Forwarded-Encrypted: i=1; AJvYcCUXuYQz14IitnqXdUyqVGCKsKv9u8/zjUOqTrvj0zhFHzdeClEQ6EH6xh0qiYP23eekyWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTRyjpfJQ/39DusUd91FecPiCXVYJ3B3dEkyttcBMZyyhkqIT
	ml0xXEqr0y6x2CArdEbLNzaV4v7t3jdemn8B3IebrZGpjBZ9RjXCQdZIvzQ1nGk96Q==
X-Gm-Gg: AeBDievC5j/txcHKYwAOeb5eDWAyo2UX6vDkhrzZiBZUwNOi8qCjChkX70hE7kr1exN
	iPntws3m1VRQSSj5POge7s4CD1IyNa/eWLDMzIDzULpXftvOeNyFcRwPk6rxvUCKL6rVtU3JVXs
	C2FdDXasTHHO/iEJh413M2Y3+/StWA4Xfa6YZhBNhsh92gjTuIiTy1QbQVbIBgSQxNsFMsGGbDp
	PfaDjY5/Pa4ayxGKeuTSp1te3X8X16Ra2BP2LL6i5nSUKNTk9Ncaj9BJOCkadHHN+229LyaRHWq
	3oLevbcWjfTp81fzp+cv9xCc3+QDeHguoppokKBUkFee276WQukKZIZXcVXDt85z7OWwKdKdk+6
	z7cobAhOd4sZ6Ppx4HCkVjzlDB3Af8uIF/f+NbM/HhYWuNIvfJIrWkkPJRs2GivH3vuSCKCqHMh
	g3fFC9utrX5vslczvNUy0C/6J4LgsKh4ICMcqVCVwioyeadg6EohwHchMC3jn8LQ==
X-Received: by 2002:ac8:5ac3:0:b0:50b:71e4:878c with SMTP id d75a77b69052e-50d66447232mr26755041cf.15.1775346591828;
        Sat, 04 Apr 2026 16:49:51 -0700 (PDT)
Received: from [192.168.1.27] (d-24-233-113-28.nh.cpe.atlanticbb.net. [24.233.113.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5969156d3sm83343806d6.31.2026.04.04.16.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 16:49:51 -0700 (PDT)
Message-ID: <5d187926-356f-4653-9c17-903b5de5719c@google.com>
Date: Sat, 4 Apr 2026 19:49:48 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] bpf: calls to bpf_loop() should have an SCC and
 accumulate backedges
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Levi Zim <i@kxxt.dev>,
 bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, Matt Bobrowski <mattbobrowski@google.com>,
 Josh Don <joshdon@google.com>
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
 <ed857a23-bd73-4915-b080-558b5934bc8f@kxxt.dev>
 <79ac0188db82c675e62c36c8ab036b45cef3f3f7.camel@gmail.com>
 <9a418287-f8e3-4064-8364-ff85793de74e@google.com>
 <1c7bfc3f-c327-4777-a70f-48144aa0864f@google.com>
 <DHJUULDO4HLP.23SBEUOEAGN0M@etsalapatis.com>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <DHJUULDO4HLP.23SBEUOEAGN0M@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/26 5:58 PM, Emil Tsalapatis wrote:
> Late reply, but while in bpf-next there are still stack space
> limitations, the maximum call depth of 8 is now gone as of commit
> 6c8e1a9eee0.

sweet, thanks!
