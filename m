Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC5E17A2FB
	for <bpf@vger.kernel.org>; Sun,  5 Jul 2026 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783233260; cv=none; b=DvLvNU3EBXT5Kb2aiHo35maYfVBE4bELhfVAV8wEn6NcVKZKTokE8v2PuWENHOJHCMPP3uVkNTcSyaBosUfDpvlPqy9ItVV4h3OKLvfrxHf9PcPnGmEMLVBY3JMyb4KYS3Bo5fF4O1ki/wAn69lQpxEkZLpPQmDK7pVclmsJ1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783233260; c=relaxed/simple;
	bh=0gj25AcxXaZY3wfkyCCO/NgotCdf6ycAI6a/fTPiEAE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ONlPHJ5FYXXXzItHQH4ctk3xEVWSRBRrip+7/2p0knpYyPDF7FeV8lFcqgSQAiEkpYOPxPoEBTyTR67ew42MOy94CvovysZn7M7NwpHp1b8zRgLqzrtBkcSfo8FXooRmNCIG4i69Mjk+AkyJXxbiuObJGyLBGn3SZa0sdAnOrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpFA7uFk; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpFA7uFk"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso196056f8f.1
        for <bpf@vger.kernel.org>; Sat, 04 Jul 2026 23:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783233257; x=1783838057; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uMFNuiQLi+jHyd4V5cgqYeeAUFoLPydZ37tFvVF87E=;
        b=lpFA7uFkEOLCaTrUswkzPnja+/IsrbAIJK3qaNwSi1DZu0S1Jp3sW1xue6XURJ5hEI
         0o8BE5zsxvmU7t6LJVelFAkz83dAD9kaXHSA7Va7SB0W2mQeTQd6ILMLv6lLOP/pK3Q5
         Uj2yfE/iaVTvA4V8qG2PUlMgtjy2fTQJyy7Oe2e3j/tkLycLdvvZJL5NuukasoTVDhZ6
         I/2gOjSFRM/4E650I9bepTorzB8iCMI0p2eF4ZHJES9s8rludtIEw8HJTQswjwu8drta
         4B1fCttYygS1w9OhAv962VNlqch/AsreDkDpv4HiPAjEJO9RiCSuSb7Tqck7SzC8Y6p3
         6v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783233257; x=1783838057;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5uMFNuiQLi+jHyd4V5cgqYeeAUFoLPydZ37tFvVF87E=;
        b=T/8SU3nvpZHlnB2Ne8FEtpnfNWGVztbblP/k8TpaowckjEXFAIMbBB9llOAVGI+Iwz
         qm79QPmf18jP6qpTs4LMgqMG79RAEBwh8LiXgQcRdoQ6bl6/Wz3BJ+nxHOkHwCkg/lOo
         gpQzsa8FHjO3VMezy9EP4D/+/LR0aEL9GkCcg80TPJInmkBxjcOxk/NU+2mXQognw6py
         KvQamWrjIwhWupNxNAGocmVthDh2ctJuInnK4NOIOMKeV8B3uj9HZZJt1WZjl9At/710
         nz7FxWJ6rYgItNykrJ5fzVGbkYA+MRoiZvV9EHybTfR9dV2mtcr3FpHiHnHNwitaBZlY
         ZWAg==
X-Forwarded-Encrypted: i=1; AFNElJ+W9M0+BDqfMV0QF0dIYsHNlHfvn9IlS5NK+YsiAev/IbuAmcPazHK/L5ysbQDTkSGIl/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/XAQL3+1VY8IFg1lHyaL+FHomBQKrhvs0V12dSD7FcEV5YXm3
	3aqvaXX3jM8FBQWNEno0VxUT859qI/l7D5tMXQ4/Dwc4sIafuVa4jpJ6
X-Gm-Gg: AfdE7clvO226R4kJ+SSF+8ov/YU6WgwfUQSifq/kOyWjEn/1dj7hq20Y4waGhtloDaI
	4hJYVhvUt8j0KIPxqZ4ZkBMQqZ6Ewu6iIBx3hgJHWxwrhPyD6NMrIkpbo3y8fhfUZkpbyULB+to
	PAMKGKe4dnhX6mOT9BM24RTKTfl3sd5hNr+MH/Dak2qxCBi5V20Q8FIgAJkFKLR2LJTgTqJ2J7w
	yRxHcKV9uVewgGk9thi83NdBZv/SXgK/sMaQp+MPw8LhzV7UF2cpU+GybNBpyr+KbLSYEl6VQ/A
	XukgfEjBu5N4bgUtAUyTWOjBIdqp4fXiV4S6dWhes4RM46luMLZhAT5wZBMLscsHkZCWx2fJzQ+
	QCKXo/IIxLMH03uh/GR6cTR8HLeMD1GvsWMa1SgnromeCBjxC0Ve8PgDVR1RJIq0i9Rso2fDIkC
	PNK/lJm9iJ2yQRfB3i8cWNup6F/i0v/B6/iUjXcaGxZiRBk2IhXIhUmchazgv9q43r216BYzCz+
	4MqkPu79L1CoDzbrw3xXirG8eyMS9E/lc7Ln1aV03CRacyHmn99XfQj03YLIH1hnQ==
X-Received: by 2002:a05:600c:6308:b0:490:b2c9:e284 with SMTP id 5b1f17b1804b1-493d11f8dd1mr63935425e9.30.1783233257100;
        Sat, 04 Jul 2026 23:34:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6e4csm12693520f8f.10.2026.07.04.23.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 23:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 08:34:15 +0200
Message-Id: <DJQFFKHUGET8.2D2JRDZA26OIS@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <mattbobrowski@google.com>,
 <song@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/5] selftests/bpf: libarena: Fix can-loop
 zero variable definition
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260701225034.12628-1-emil@etsalapatis.com>
 <20260701225034.12628-2-emil@etsalapatis.com>
In-Reply-To: <20260701225034.12628-2-emil@etsalapatis.com>

On Thu Jul 2, 2026 at 12:50 AM CEST, Emil Tsalapatis wrote:
> BPF can_loop based loops require the index variable to stay imprecise.
> This means we must initialize them from a currently imprecise variable
> instead of directly assigning 0 to them, like so:
>
> static volatile u32 zero =3D 0;
>
> for (i =3D zero; i < NUM_LOOPS; i++) {
> 	/* loop body */
> }
>
> The libarena implementation of this technique is currently faulty. For
> the technique to work, the variable must not be in a map. This includes
> the .rodata DATASEC map used for const variables. However, libarena
> still defines the zero variable as constant.
>
> Modify the zero variable definition into a volatile variable. This
> change adds a complication caused by the compiler optimizing array
> derefences from
>
> for (i =3D zero; i < NUM_LOOPS; i++) {
> 	val =3D *(ptr + i);
> }
>
> into
>
> for (i =3D zero; i < NUM_LOOPS; i++) {
> 	val =3D *ptr++;
> }
>
> and causing verification failures. Use the barrier_var() clobber macro
> to prevent this optimization from taking place. Using barrier_var() is
> the only way to break the optimization, as annotating the index as
> volatile does not suffice.
>
> After that, remove the bpf_for() invocations introduced in libarena for
> parallel spmc testing.
>
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  .../selftests/bpf/libarena/include/libarena/common.h     | 2 +-
>  .../bpf/libarena/selftests/test_asan_buddy.bpf.c         | 8 ++++++-

No such file exists, did you forget to send the renaming patch from
st_asan_buddy to test_asan_buddy ordered before this one?

Please respin. Looks good otherwise.

pw-bot: cr
