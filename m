Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C6306B11
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862095; cv=none; b=PKngAkmyRYWPAnTn8leepn4RLo4Wby7Rhc79gHlCm/FA1FndFacLZ3ECEcIKqUKqeu642gvumKa5pUQtLwxW9Su91aKana/2BQ2WNiwPp36KeLvQSSrWgPbpm6nAIZElMCtVEbMdR9cjthQqIhtWJJeFDT6kgSnZR8B8i7GV50w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862095; c=relaxed/simple;
	bh=R1AUHGXxe3dGgZHbFkQxH0f/b1HLtXH7ZZMS1myvRDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5FbxRkRX4EpFl9WCTWQ+Lt0D69xidHud5bpzvPpcNiBv2vYBPUEs/Qh0S7qzxEjQtyf/5HNtXV8FCWbCHeKeTibHq4QEUEIj/GOrgg+F/mDSf/LPdaHw7uDSMkHVEpVWxPH/SImAqyxPHo2uGPUSIIelwr8/dgJGHQI3xaj0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AV/trNVK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AV/trNVK"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65a40f3f048so8340492a12.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 07:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771862091; x=1772466891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyQb0+priOw9IUD9vV+F9EltCgHvh5WCMeDq2M8hato=;
        b=AV/trNVK+3bVsOKnp5bahBdRAH07bioQbb+KQdhDdReRC6BRzawScBjHSwKs+AhGUB
         iZ9AQZGG3s1e+nAmEEy0xHhD3d4xIMx8y6Z/yQ+wTJ4cVxHc/yg6MwgGVLPyxT8IAAou
         uhFX6ih3LF71xZRew+arQeEsEDozLUMo0ojuRIG+gJWYkQ5RxV+70Hk9wxWOgbNJv9qb
         MhGWm8RpXByui/rR61Hket8H6wtRBMr7N9b1zwc3gputqFhlSuzGn+NSwyrtYpPRpk/h
         VJ3oaez6xGsaRenOEca1c0+yQ/C/yHzImvR9FrZ7toR2aDszDqjbeA8idHsvmj2D/i1e
         QYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862091; x=1772466891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyQb0+priOw9IUD9vV+F9EltCgHvh5WCMeDq2M8hato=;
        b=BJFCG/yFGbW8N6ZeZhwuXJw6kcqpAaVcjUNF5fuZxtZsjwluv1kNYEavBo3/2oaVLq
         ccCCS1G5gN4yMVux/KX6vnblmuiddTMIC9GRIzGbZt0ri6imxyoMA3ZRYZpQOJd2E4K/
         Vg8z1HWRi7u7Vm4TWXLXiJCR0vhnOGoLAFxqeXEr+jH6oVeLoIzXnxz3HNiIsG19u5aT
         pGsIzLcWrEZJvfbpaEFTidVr4J+MM/KAB7DwO73DofCgGAc5T1eFlS+uXoW1uc+6W5fn
         3x/9WlYaGw+NAi086sReCaV0Q8KlKlRM1mGcestKTyFUVa3LicsTpY4FgnsJC4ZJJDpR
         0KoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOZK0PV15s/eIdP0kpCvljeFLsTfoaGKkMTugAdmKQX5RIuGtnBPKtq6QYi2C/fl7E9b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDXbYHZXgRnQ4vMc3+NodpslDayzQqYok3qRzkWmEjQD+CxTi
	Ne9yWACsgKbGQ4dTOTRwJIS0Q0JilSp5o4qWxbFdox2XbZ4iy2wS6I/5
X-Gm-Gg: AZuq6aJ1NnSFZCMy/eN4K1N9bwml2cD5ABNTpYqTdJ2e72Sec5wlId7Lx4aMGdCwR3q
	4YfE3IQkyh/HJ+nzhM4LcSLGHZhMuyCM3Y1MlZ2MYql93N8OI/fz5AsafGjMp2zdaQbhIKLAD39
	Obaruh9jfchRwF5lVdfZ3RPdWXvuaGJItpv2Ze80wBOpnuCNMzswCzH7+11TV1v+HsGFCCaOhhb
	rg10XT3LMXkg/lK9xoqvA8wXf6m8IiiVhMO5cHBsVeaEflnHSO9TDHzMKEmMj0Ra4alKKjJvd1R
	rD/YYxUdc07ecEN9NrJxoDQo976oLdyZNmNP/yAAqVe0TR5d0QaaSOU9Om+YHhwTACyrzNQBCj7
	1gM/xZqvjVd7uuUWcrgeX4lJm2bh+Iq+9hxp3duPBVo3z4jKewz7PEoaaxIKryKJP2ZfMKt9LQh
	BVF2IR4eXVi8466hU+clFPtPMGyJbAI3wtCS3oY6h1wCQFa/rnDXzVAUOyG50P416eRVUiR9f4B
	r7q7cfguO2Tit/i8Y+u47TPH+QKvlQsHiBX99Q2iW8GY5/r7DHIJxGsSC66RyyFSshuRzZ5sL6w
	Ww==
X-Received: by 2002:a17:906:19cb:b0:b8f:8e99:7860 with SMTP id a640c23a62f3a-b9081ba9436mr397974566b.46.1771862090575;
        Mon, 23 Feb 2026 07:54:50 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084a4d6e1sm341510066b.0.2026.02.23.07.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 07:54:50 -0800 (PST)
Message-ID: <7e772d91-a546-40ed-90c0-29e2a9721c53@gmail.com>
Date: Mon, 23 Feb 2026 15:54:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] User space RAID5 with ublk and io_uring BPF
To: Xiao Ni <xni@redhat.com>, lsf-pc@lists.linux-foundation.org,
 linux-block <linux-block@vger.kernel.org>, bpf@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
References: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/26 05:38, Xiao Ni wrote:
> Hi all
> 
> I'm doing some work on user-space RAID recently. I'd like to propose a
> topic for LSF/MM 2026 regarding the implementation of RAID5 in user
> space using ublk and io_uring bpf[1], particularly focusing on the
> challenges encountered and potential kernel improvements needed.
> 
> Ublk raid5 uses the ublk framework (tools/testing/selftests/ublk/),
> with the goal of leveraging io_uring's zero-copy capabilities and
> BPF[1] for performance optimization. The implementation includes:
> * RAID5 stripe handling with configurable chunk sizes
> * Multi-queue support via io_uring
> * Degraded mode for single disk failure tolerance
> * Integration with io_uring BPF struct_ops framework
> 
> During the implementation, I encountered several technical challenges.
> The primary challenge is performing XOR parity calculations in a true
> zero-copy manner:

I aim at similar use cases, i.e. interacting with registered buffers
from BPF, but based on a different BPF-io_uring implementation. I'd be
interesting to discuss how the kfunc API should look like.

-- 
Pavel Begunkov

