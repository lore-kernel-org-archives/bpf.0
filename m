Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9F1DE4FB
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782258178; cv=none; b=rx8zuROC+XlRkQN4z4gO8axxQRwNKlyUtCr5o+tkudHy9r1quBzsk1jtKLfyAdFOp2Cp7VeQ4IfxfcWPKwdX8+9HHgUJ6CcQ/ewWF7sIPi9u6FnmGchVkQej2sYJoVdm9qiB85f+IdNEv8G4L0Cv7GXmYeqi1guKUIzmgZpt+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782258178; c=relaxed/simple;
	bh=qhoPAfQeG4qnFQmUNASdln+cz56oe6Buv10Jhv6L54o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RFFvS886qjz4IPSRz1HvTa8ldtOvRmscf7JCpWq+0W9Z/zAro0BC1fGBJFKR+8XvKsvJuNMhN2FvHOVMzmMztSdAHy1I1UaVfptoVt/8mgUji06yXXMUNN9YlarDkfZ03rlXdyv2sxPHHAir95B6GP6PWez/zyHA1G+3CBTtEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=OwQAgP0S; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="OwQAgP0S"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13981833e13so504690c88.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782258176; x=1782862976; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GKhSNnJ4cBq/7w4xkjirABVDHsqyagldA7cY6Lkw5k=;
        b=OwQAgP0SALX8CxPI+yg0K0kunV4CjBAwjreQZ3Ke2Ul/xSolt0wU95niSJCr9gaJ95
         oaOlgyR25UhwNXwhzAw+9R/4HcJeqLpYswHEt1lBIRQ4NuJRgE24k4hwKDxWcjCi5qpA
         64mRF/i/gHmKEgdxRIXe7UMDsGH59NhNSiCjdgvgHs4q9PA0C2EVjcz1I+hsH7mX9IpU
         T8a71K2zsEjONOklkk/0XXBpifrE3ouQKUXBaWfLoIKtFhqHqGKYC4M4dC9KdqyoHKJ8
         NiKrOgjhRAPza8Y0WOcnCRO6pd3TS1QhcKUeFSTMyfyPGhRkKmZ1SuYIfsCp4R7gHlrn
         /sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782258176; x=1782862976;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1GKhSNnJ4cBq/7w4xkjirABVDHsqyagldA7cY6Lkw5k=;
        b=Ja4ZPhVJGbRVXQL+waXTEGIqxc+zA0OlvPYbGlnK6Ipn6ndvsehDw9b6rOsI98luqs
         ngqS9oriohpcN6bkWdDnL1gedgC3u/pHiwW59P856Kp2xC0Nse3nqpw5qM0a4YbeMs1m
         F1i6x0jH/4+XehLRHsXwKW1lr/37H+2b5K4jP6cNRm9V1BpBb983pt0wayFJhYDi4uTi
         VcQge2gu231rgHfugG66z6ZqETtHTSiMX8qR99IGcHkCy8a7KpgqYlTLvv9uxq/CgwoZ
         Y4g6wqpzFnZy9bWYeEBh/AC9kuohVv3M8upKoprgpRMuxJTh6uXlwtP5skZx7lApmqym
         sS1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqZc7QxA8dclnb1hVL8MGlHcOQJNL6W57yztApiJ16TvlEjFE5waWtVkkPoFMK8yKh4USI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6JdgPAORwxB2AkW374+1XIyrHTXnBZ6R6uMhhzDlWBGoD0yo5
	yK+qSO5o7B/JvT1/xwCdiq7BQRbFwtPyXeOFLF4A+JBJzUR/WUFkjFXjh+VHOq8GpeZspO0XX2D
	ruXZF2RT06g==
X-Gm-Gg: AfdE7ckt8HTM+9fXCxkRZEaWaF7eZwZONQ9EWdmxJgiLjiH40c4JNnHne674nzQWCIV
	3c8hO2PysafZ7wMqJz90FnMJtx0dGZTOtOywvleyKF3y+jWm9WcSZb9JgmFVTXzmNtd3kfsBGwO
	duBYqKS01s4PjulUyLJPVioiT9CBVNO9/oRtqIMi2ddvHfJ+5uwtT21voPnw5QmccRC5AnHb/bC
	JWRWb+M/KhFLE56AuN06TgmMk3okOFBIcEmRGDyZZ+0+szQnfYQAdSUxhxalnnrxrFweNdxHnjF
	YhrwZhHaryayBK3z5EHiUxaIQMzhlNqkPiPjJRvIKwz4f4WeBWoTOnHaRCaMbtA8FdwnzpDU3eY
	n49eT+7CVzSGJ4tIVRuiyyYNAqAex5t6wJqAao0Wiy7nrXuRv3UGGVvjjCJvyS4W9NbCJsQ==
X-Received: by 2002:a05:7300:2384:b0:30c:57ae:2cbf with SMTP id 5a478bee46e88-30c58d33b73mr6294766eec.35.1782258176311;
        Tue, 23 Jun 2026 16:42:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2526])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f0a9sm19776660eec.2.2026.06.23.16.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 16:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 19:42:53 -0400
Message-Id: <DJGTSLYKSIWE.B58OC67S6FHA@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <mattbobrowski@google.com>,
 <song@kernel.org>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: libarena: Clean up
 allocation state before buddy tests
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618085626.19633-4-emil@etsalapatis.com>
 <52707834463b9ad1861552674b98bcb2f92d6601295548454770d883c8c43536@mail.kernel.org>
In-Reply-To: <52707834463b9ad1861552674b98bcb2f92d6601295548454770d883c8c43536@mail.kernel.org>

On Thu Jun 18, 2026 at 5:47 AM EDT, bot+bpf-ci wrote:
>> Summary: The buddy allocator requires the global BPF buddy allocator
>> to not be already initialized. However, the test currently merely resets
>> the allocator before the buddy tests instead of destroying it, and the
>> test worked because the buddy test happened to run first. Properly
>> destroy the allocator instead of resetting it.
>>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> This looks like a bug fix for the buddy test harness, where the
> run_libarena_test()/run_libarena_asan_test() path only reset the
> allocator rather than destroying it.  Should this include a Fixes: tag?
>
>   Fixes: b1487dc1b181 ("selftests/bpf: Add selftests for libarena buddy a=
llocator")
>

Not triggerable until we add the tests in this patchset.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/277496=
30149

