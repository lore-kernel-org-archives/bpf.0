Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023DB321F5E
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255126; cv=none; b=H8ErpkX3F6qDmwNWX/T85gxCr73+U/ANbOeMq9sR5U9oO2ycVgdK8N51hblLJVyQaX5T4QUsrb3QzaLJERNoJ3s76wM6IvcDGCyTrwNryncijzv9RyVyQtLo9IWXvmhVtiFWrKFF5r4Feckgdv7HPR4TELA76tnHxuIGjrBS/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255126; c=relaxed/simple;
	bh=7q0RKV3IdkkhJeFEs3BavJiJ+arthFxw0WLD8uQ1XZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6ylsrRwCVYMkj9+nenDPDLW/Dlwb4cbeXyvTcxxz2qjLtn2mmJQD9yjJfudNG4p58QU2t48+wGWprqtNZu1MSIpLJXyXjtXI5QoFhQpokP0GBu/ghcyURP9hvqs1qyLMthdRHNgMURnJTM2ZWTKn3UGVvbpgM/1mXHAjD3v/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZpyVf+XG; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZpyVf+XG"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d15b8feca3so3889165a34.3
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 07:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771255124; x=1771859924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tysseZpmf8fckvxYvgGdMxT1h2rzxCV2cwV2N9mdo4o=;
        b=ZpyVf+XGDQwsvM5GLm+x2lwW/Tb+3yop9SR+E6jgWc9mioo5FjeJEc2EbWSo4HajpR
         4WartCGItVe7mN1+E2oSF4Gng8mj8oGvswFWwox086iJea79ZwBv45ISLJrpUrgDqauC
         q/ApaEk6hxDHQV+5Y5XLwTAgpyzkQOOpx2soAbOOxxUVOzvwvD4V4UDFTuzSF83L2e53
         HirtKaGg9zBL2VbpElgF1D4zJe/qzPpPyd3YvGH+bZ1tc04Rnyaw+ue/9SAFT8GhIqjk
         sB5bKaBb90fwWeMt+bbnWhPG1Ug+gfJkDa+9Q0lWMujl0JXq4sG3xB6H/0fJEhcsAKJ8
         l6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255124; x=1771859924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tysseZpmf8fckvxYvgGdMxT1h2rzxCV2cwV2N9mdo4o=;
        b=fPVcZ5lxDAGhg6t2nB8ZTvPeFj1/MdrXTuD0pY9UdhWSEOl1w5Kti7HqQpI2bCjejo
         EIMDbblMpzq8vTVbut5BKwArQi/0DdNOI9Wh2oK9XUK6Y0AqDzb0j4LOjkNxdMqX6m5J
         TM+P05v3q+VouzeWi5Wj8ZbeGq5KZ/SYTfggeeuvqpqooc6dQmRo5oNVUj7vtzkjdXSg
         +G4/OOliHYwYQ8kh4r1EzqabHaFrqRLEv1MUuRYEK/8815aNF3eLXxIl/rAtFDWtNhnk
         qfxuIe4RvkNgpXSpqDbwhBEXi0EfiSl6D/itzG2X/lK2Ptx4FyV/DamH7h89/Jl8hCZ4
         MZiw==
X-Gm-Message-State: AOJu0YzyIOFipbplf4jGUjUa/gTBDbJpLxVieKTngXDrKZs6p0ky1Pa4
	EoQGhaPolDnMqAQ8tCguse8qR/UfJwm5WP8j4mg9v002kSthR/oo9JRx3XUGP5pk+q0=
X-Gm-Gg: AZuq6aJH0MiEbT7nH9jHRjKvYQJRctRl7rngw3ktIxgYLWAjzRpNJx/Gp8Yq6f0R3qw
	qiWiHXvQX1H2t1k4TDpscIrHtRyAglI8v6b1wb76bEmlZZripcSVsos//bOGhXkxa81Bj+C+6h/
	h9eE14cfc5dE/8bW8a+FEyQ7S/RV0KNHxwtzMfhh5A7vFkmn09+eVpKFO56D8PtV0r7cuAhriwM
	6TGWE0d8gcpVM6W0kAWDP4+5FDELZ7ltqyrFtaaK8AXmkNRfSM0tlP2X92scueitNJTB5CaW2i5
	MsFpNLZqGefZ78W+91rpFzi5KcwJrSQh4FZoq6cAO5qb585u9CG87bNOevistw/QsYVGTHbeXOa
	hI6XwAALEJbZxbcVxg9xwJ9kh08Gn27jIH9/AgDfCxTQ6aPW4gfNbgo0Rkq9y5aVbaRnHtSJuUl
	Kdd4Xt2Dbc6+zSVfxn909FXV2B5H+P3fgi/hx0Y4pwF6TQLAmFJ4qsdKlUANh9RYh0h/xJ1Hnym
	SCccYwhZw==
X-Received: by 2002:a05:6830:f8f:b0:7c7:471:55ff with SMTP id 46e09a7af769-7d4c4a14747mr6077995a34.10.1771255123953;
        Mon, 16 Feb 2026 07:18:43 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a76f96b8sm12707223a34.21.2026.02.16.07.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 07:18:43 -0800 (PST)
Message-ID: <ab4c6ffd-d7d2-45fc-bbd5-b6663d5c41e2@kernel.dk>
Date: Mon, 16 Feb 2026 08:18:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.1 v6 0/5] BPF controlled io_uring
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1770836401.git.asml.silence@gmail.com>
 <d56b5f70-382e-4017-81f4-c9ae7a6c1b56@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d56b5f70-382e-4017-81f4-c9ae7a6c1b56@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/16/26 7:23 AM, Pavel Begunkov wrote:
> On 2/11/26 19:04, Pavel Begunkov wrote:
>> This series introduces a way to override the standard io_uring_enter
>> syscall execution with an extendible event loop, which can be controlled
>> by BPF via new io_uring struct_ops or from within the kernel.
> 
> Let me know if there are any concerns or comments. There are some
> parts that I'll need to add like timeouts for waiting, but those
> will be natural extensions, and this feels like a good base to
> move forward in general.

I don't have any complaints on it, but would be good to hear from the
BPF folks.

-- 
Jens Axboe

