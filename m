Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530018;
	b=0k2HxmXFFEpQXHnDsu/93OS53CX1OiURuMQXyUO3hwtGW9BgtFyufdifeTEI18Ozkf+T
	 Tao02qTZ8imjDD2FQf7BbKqckJsAE+zhSA/+wmrD92wFsdrvPV9f416EjLx7TfuQcJapb
	 jId1DIMscggIJSvJcHsuz857WQWaTnZEjE3VxjBOYts4tjXAHqwzLumcxoj8feWWu1pHO
	 MPeLUyzs0ZKY4FUtnkrI7jEfRfYWdvNiTmUIOhM9UOBW5mg4F0z9NtjKVYmYsAlsuobHC
	 czn0yoX9ChSPzzFd2b7cjswNMvrn1z+Or65+BWghcUlfmcfH1OlmpE0yLVa1kwlsX5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=tMlKQxPHdS+SZGeTLyjEKbCtsRNW6T5+1D/piqEps5Y=;
	b=4BCSENTjSRrjg4eexYcP4LChkUxdCegkh9UgRcXRnVLQHM4tHD8J4HpjOypxYsmV1gZx
	 W9W9SlL1FkvIri4ni1PB+1aSyPgRq/Wk0BtJ3KuOjZteSUZuKbmQwgM5BICcfSTRPY8vY
	 25Bml0b/WOEomynGdsmyHfH3VvOHiPj4JOp1786NnlNgT6gpu9fPR+L95+/EV5wkOPqP6
	 dFh8R5IfWSO9gvbm674hN50CJYcyLGpwHDJPGGsIaPI8bNwx6lwGRHCqzPR048D4AJH14
	 eUaq83G2sKJwqd8h/sgY+mWKEO3wCgYpNftN4GHN/vE8hQMoe4GgA18tP4UJzDTAM2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dOhmns8U;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288D606A31B
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 21:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3288D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dOhmns8U
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a0aaa0fd13so57122a91.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792530017; x=1793134817; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tMlKQxPHdS+SZGeTLyjEKbCtsRNW6T5+1D/piqEps5Y=;
        b=dOhmns8Uj25UGn30DeAmsy8O3UusmjXY+8EmlUaX6wz2MnrP1uxx1kKUc3sGfCvUyQ
         80Czi/5GLDrNDknany2Ae14PPqrzc2gbUnajP6EWRPlO3vWqK+MR8oVZ83KXtOeWyCAT
         Z+6MR7hGV1nF0LQFDWPMtPsMGH49sBpeYY54/N4pOBIMq4AeDGRUqgmcjnLyQplhPA8x
         lYV6kkZhiCSFcsrzffNVCocNzC2ZQV8lcoLDu97MlpmrSDf8xyg/7/iemXtzH4KRp3t4
         68uuWi+D0KO1xtp83MnjXyk9h/IiA4GZoGTgbbbLPim78ZuN92jFJI0St4kAGAwqYl0V
         gv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792530017; x=1793134817;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMlKQxPHdS+SZGeTLyjEKbCtsRNW6T5+1D/piqEps5Y=;
        b=KzCIbe70FDDt2P9gl8rYTJoRYK6uQ5sLICGKP45y7ofm9OZ7z3Gq+EYSnUZF5QRFSl
         qsiVLpcYhKs9G7/2lnKyvbPAc9qBpkjQ0EkW6IBSYfLbqYxM/v2lR1w61rffnC5pEpIR
         m4wyjkhcP3ZkmnQWft0OYgQ0A0Pm+BvC9tFe8ecmPNnEWs35u4P7mJSadk1g9o/EcxcD
         W7pPtbeiFzy9+OGBW7Lgm9aIeGlWO/m+RqHka0QlsS0QbB4FLxQWQgq4NqLZTxwlCjJn
         uunM8JKBvPX84QGMu2Z9se8XBEmKZyxqV6sdtnlM9E30KHuoz0HA86GxPBM9S0mu7Tiu
         3jMA==
X-Forwarded-Encrypted: i=1; AKwUvBxkSqXZVhA53p8eKnbBPmNw3czMasahAOX2hNlzWTHqjm7AXAu1a9GEbIDBUUuGGkM2mRM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXEYq4YKtqziqDpTLJWj2/TAfuS2oG9LS8RnhCikZk3a509J4u
	yg5Gs6jf6d2uXnCFJiQDoA2hkHggNnZj0JEYA12u4vzvBFaEsCltruKNTh6j/w==
X-Gm-Gg: AYBFou2dtKbTJi59FJngS78uTkeN5+M3gfQAFwCV5r5MzundR0pWKXUG+DBu6Fvnv+R
	kkMAMzMf70dnqu+ZcVuH+VMtX/lT/R3mYKvNB52YINCrUpQH2xoikc4z7ZOsWZh6lSD1YDS2C7G
	Fxs8Dv6QpaCqUF/4gq/7exB/eu89g477a9eSmADdPGOWieXnez3RVlx6ruiE7XaVOtn6XE1RE5f
	52Z/jLJ87JGYAQd7C63OsWhDeYloo7DHJJgqvAq0pU3o2MAK5VOwJOOsiCTfdMQW6gXlgJK0DlY
	DPMULYcZ7bC8+pp9EwDQl6XuZaJwGg0extE3OQsRca2L+/alxkuGCIMz67TrtTB7WlT17aaUG2F
	pjsuDQF3Jyzp1xIu9tAVew8IdQKm9ukMaFXf6oz2KNL1tPpWZrkg3zvfH7lxAj/wYE37Zmw1Q21
	r1e15M1M8U/+hrIKY0Zj+iF+m/ZDNVYCdSaXWUTzPEdi7olhmzIPwdTMIZU9vV8b1jwgicOwOU1
	1hJ34IAbw9q72Ybj0eD9Guix+YvVSez9KP+eI/pzbadj8Dwx5PpBcVVqTxdDQJNv39Ajj54toWN
	2lI=
X-Received: by 2002:a17:90a:c887:b0:3ab:884b:65a9 with SMTP id 98e67ed59e1d1-3ad86f3c4abmr85001a91.25.1792530017325;
        Tue, 20 Oct 2026 14:00:17 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813ee970sm909417a91.16.2026.10.20.14.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 14:00:16 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 21:00:15 +0000
Message-Id: <DM9YUX1TXEEC.1FCUJ0M8D7HGU@gmail.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <martin.lau@kernel.org>, <mason@kernel.org>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: support 32-bit linear scalar
 evolution
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <eddyz87@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <77720df26bea4edfd16a92d307115ad152f9ab558df8848fd8e0d7cb31e9f5eb@mail.kernel.org>
References: <20261020-scev-32bit-v1-1-838f34f9f0cd@gmail.com> <77720df26bea4edfd16a92d307115ad152f9ab558df8848fd8e0d7cb31e9f5eb@mail.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 04:35 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +	if (!scev_value_compatible(env, st, &initial_val, &bound_val))
>> +		return false;
>
> For a pointer-vs-pointer JMP32 latch (allowed for privileged programs, since
> check_cond_jmp_op() only rejects pointer comparisons when !allow_ptr_leaks),
> can the computed max_header_count end up smaller than the real number of
> iterations?  bpf_widen_scev_regs() and bpf_clamp_scev_regs() then bound the
> induction pointer's range with that count, and the memory access checks
> inside the loop depend on it being a true upper bound.
>
> Would it make sense to return false here when latch->jmp32 is set and either
> initial_val.ptr_reg or bound_val.ptr_reg is >= 0?  zext32 latches cannot
> involve pointers, because ALU32 on pointers is rejected.

Yes. Seems like a real bug.

  r1 = map_value + 0, r2 = map_value + 56
  l: r1 += 8; if w1 <= w2 goto l

max_header_count is 8 and r1 is clamped to 0..56. If the low 32 bits
of r2 are 0xfffffff8 then w1 wraps to 0 and the latch stays true,
so r1 walks past the map value.

pls fix in a followup.
