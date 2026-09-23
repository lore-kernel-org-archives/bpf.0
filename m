Received: from mail-pj2-f21.google.com (mail-pj2-f21.google.com [74.125.227.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B23537FE
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204152; cv=none; b=km8MmfmlDXrG2QXyJBjYZHWdACKYnbu/NR/uXmdBetmfOJ3TPHALRqLb+Eg94/9n9haFaI0Fgz/zvP+DSa9LzPwhDwoxBceW9wDQfPQ073T6feRQW7n71xMs/PHEkl7qbYEKsygOO25A5bZN9910M3HYMshNGPMMordHxmFmFFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204152; c=relaxed/simple;
	bh=Mv5nMxGjXfBmeqXqUI9FM4Et6lA3qj56wOs79P3rdKI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=b3PXK8F1K60fhr66YCPi1yyFbdEQXlLP8vjtNe8wVysaeJEMxte4LGle5fL/MYbi+rBD9DYVHsGWDyzx6edFznUK8mUJA47rI3IkJ/JkoB88wkRaDSGV5zDiJZCZkQDPupvXTWCXrfPUS1lqT7NsC8yhXKm0NVWEmjTC0+XAv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If7d4tWA; arc=none smtp.client-ip=74.125.227.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If7d4tWA"
Received: by mail-pj2-f21.google.com with SMTP id d9443c01a7336-2d747f0b25dso9317925ad.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790204147; x=1790808947; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VkVyETEvIfFqCTDaVFYFDJ9vOsB4y2E+1sqksFOPboE=;
        b=If7d4tWA+2bgLhrZX/Wi7Xb5QSC4rhYScup02FduzEKDn/eMb9X8NU7Un5GRA8F7AR
         v0NnX0iQtj3qqtOAVglcLvb8ns7rNbiS50ee7VZ0sTQNclbumcsl6xFUVcBm7JoZYfIx
         sESgLTHhpJ4wGslQYkQxrwCihdHN5ZBC/dysWWHVb2u3BixIsCPWoGmqs7Ws+QEmOop/
         ey5gTAop5fhOlM25IuUXhwM9OFi7ngpOsKc97YeQPY866zhPtgVbSrJpjVrW7/tCdH9b
         Fpsadkg9ZdPOs46zUC7EQZUUFXW+9i/rrnZ71lCP2MRz3uTsPXvtJBqPO5k6YluRGmGI
         X+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790204147; x=1790808947;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VkVyETEvIfFqCTDaVFYFDJ9vOsB4y2E+1sqksFOPboE=;
        b=egcP+kO2EQXSOFX5A7D2h4R2WNJAxFRmfnWRTgMrG1vJSy0M2Gy4fzaaxMAMYgos69
         SM0CSUcCsvIDFLKJ2wwDo98q2bpvtnKgPEyeA5T5BpG92tHXDRosYLCX/u5iQPdevO7O
         LDOUuaowbw6SUmpie6CECQqF3zec+vMxDX/ztyTpP5vje4tk3lVN8sYRmvlgkrK0Hwaw
         W18nQrsgPvv7QEe67vTEe0Sy/VGKHBX3KDYnpQtVujRRMiDytgcbMhN6+P6yxMX1H/ei
         lloQ3xgEXGxADgNFJ/ymwHzZ4jpzoas1QezaOWZiVnIhuTPxsTK2mJj9SQbP9hqxh+7Q
         l9CQ==
X-Forwarded-Encrypted: i=1; AKwUvBxonVTZk3BWcqOu2zKZ2yYajCbZe0hTOsncvCdu8duzh00t2HWUaZ86/Cs3WfZS3eH/KyE=@vger.kernel.org
X-Gm-Message-State: AFuF++nhs2mN/P13FiDoxXhxwtm7PwgIo6FwZrsDBfEx5VGnQ7QPg8+L
	BL9tA51kLMzJZZwGCy4TNonVKiWQfOnOu6OJNCs1/TNIpurRSPQPTcWJ
X-Gm-Gg: AYBFou2djUMDfxojNflLEZyHwMd0u/iVt2e9fD/1cJOLAavn6WGevEYBCVzipGMunfH
	pcsnrU0FWAHVw92Lndz6brzYyw37YHbO3NYMivzHDJygR7qBoo8BSj2FKhzj1zpNkxjMTBhb6h6
	+NXxTd0eoRffzvwDBCn1ybE57JvRQXRHJ+WkrJot6X9M5rLc3+G68hL9U57KLWoGb1R7yhXEW0Z
	kkksLRGi9ppxopDnulP/rrGcRsSEhQhhGvRYKuG7VxY4wUoBZAKumilyMIWdQreFucw+QTAj5s5
	0oG50jWCUXZskNO9RnH7hHtqItAS0wrKAKTgJQa6ydjh2t9MxC0Mqh+taLGAVJme2UdH6OtgnYp
	dluT4t/lTpQu9J8DxSmrQ6k9i7UXS3hDTUktkFL6kCd3DdVTPyaGC+EjQ5TqCkXzX5Bd2brfCQp
	LHNsWZjW/+btM069d000WtvbkZKwNJVgtpnZ9Jp1wHoJpvyTSPaPFZNXUAYncHGCXTw4HnbBuLI
	tyaWO4cizPvtOiO0PJYSk5eJbP5El7n6nEV0mbOy1qReXEaetnsBatF4Os2KgBWRvlCmjJy7lEi
	FSY=
X-Received: by 2002:a17:903:1aac:b0:2dd:c100:313e with SMTP id d9443c01a7336-2df7e256059mr5039585ad.58.1790204146987;
        Wed, 23 Sep 2026 15:55:46 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6afc80easm17247065ad.30.2026.09.23.15.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 15:55:46 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:55:46 +0000
Message-Id: <DLN2ENBJI5F7.1S4FUJ3ROP51V@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Tejun Heo" <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 12/18] bpf: Size the per-frame verifier
 structures for a 2 KiB stack
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260923191139.2816206-13-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com> <20260923191139.2816206-13-memxor@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 09:11 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> -#define FRAME_HALF_SPIS		(MAX_BPF_STACK / BPF_HALF_REG_SIZE)
> +#define FRAME_HALF_SPIS		(MAX_BPF_STACK_JIT / BPF_HALF_REG_SIZE)

MAX_ARG_SPILL_SLOTS in liveness.c is still 64.
fp_off_to_slot() returns -1 for anything below fp-512, so
  r6 = *(u64 *)(r10 - 520)
makes r6 ARG_IMPRECISE in fill_from_stack() no matter what was
spilled there. The next load or store through r6 goes to
record_imprecise() and marks the whole stack of every frame as read.
A prog that keeps spills below fp-512 gets no help from liveness
and all of its frames carry 8 word masks.

The numbers in the cover letter are for selftests that fit in 512.
Pls share veristat numbers for progs that use more than that.
