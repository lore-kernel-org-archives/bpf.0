Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F55F26980F
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 00:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792284769; cv=none; b=aYTrWzqjwoya26/nRTj6ueiI6EFzD602wbUjP1qAhFyTvVTDN/mJkOnZTH11RLVpXKJ3T9Fk8dgbBHyPguamYmLx9MqEVqxcioTAiN1pbDwWQrN80gXrUDdF9BgMscflpgNzPXZCeqNck6H914gSaYIwlGhr/YxWnX1mzZJ7xpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792284769; c=relaxed/simple;
	bh=oS9dfUROtDHTJcaCOgtH8Sgai6aEj4oEhoL3FqbWuZo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=h4QhKkXrFj0IDloiGWpGckP4lAZwxj6tvHSF3+R/9mwD6vU4MabZ0P5YxoU97w2ngLlZ3VHQJZZXdWqZcv0xPtsq5OlKvca/xicCsVI0XE03dnzxn6RU+uU5RN5BTCyF+C71pvY2eTI2n0LteSbLHQTkRe8or+FRufn/3RDm+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrTblHNz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrTblHNz"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so946530a91.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 17:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792284768; x=1792889568; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oS9dfUROtDHTJcaCOgtH8Sgai6aEj4oEhoL3FqbWuZo=;
        b=KrTblHNzzOQA26l5UmBzHOZLd2i4tDSPYnsNsAG6p/BcqqoKQCGGb5bBdDb4H2alM4
         +nEzzvsriq6O01bH98sVffFOyC2oO5eEin3Qj+0EBm0r47Z2M2oH8ZLVbRa6+XuCOClI
         eDmYuKYevsVB2dBhA/+j5Dn61q87uOlHmQMQuE0kp4iOXCNS2SdnHmYfP6bwhn8KST3n
         yT9lEsJOzQVw3M98gLmj0b7k7CgJVhYA4vXaQpARc62epG0UVazcYpZ9cbVmpNPuO1jO
         02EZHs9tLNFUOypDkddxmb94IvYdzKOKj274Q+FV4u4q1/2aJZKiUepCMh2aELJu9ElZ
         Z5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792284768; x=1792889568;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oS9dfUROtDHTJcaCOgtH8Sgai6aEj4oEhoL3FqbWuZo=;
        b=Bv2afmEpRedmbDPgSsqbwdkduEXZN5IqqotMKtrps8GSngelIYVl7NgDBVnUy/3wsm
         O2hLJVzXo7GkqDXe4jSPNkS2WIZiOrYwKeDBhCkcn9WZedMstHMqWRULcUZrXr9D/8HJ
         v5ixzsaNh5VZt3ICYNefVJH9+9vQKyXoIrDopWP6k9GrRBaYN1MXWbGA+DZUBWWlf9vB
         OKE6+r2xul6zFp+XhMNVBfuYzvzp37Q8YA0573jyxOjbhsxoCC5RAno0vldv/CubcD0a
         TSNakzDBViQrjC2jpwj9zfwlKZr4ZHt+Qxq0dxZVBtIbNaNiquCkOYpzH06JKS0cHqlL
         E3Ew==
X-Forwarded-Encrypted: i=1; AKwUvBxliyWV6CMSu5+4nmObPKMaTWKH5lVewFwxj5SnA/zq8N/12VMBgPBwK+BUHh52BomiP/A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCeqcxCQrM0mUO2nEguKzVIZJH8dNg92WzkibyxdzooHbYdVUp
	8WN+kXc7Zhi//e7gtQyidmYDqunJBYWEH/dIbJdteEzXJ0bVhfbqQvH5hpEaew==
X-Gm-Gg: AYBFou3S8MLBevUP5N8cpiPB9Q0u8Wk3D2giEathMawuczWhgoQwXQA375esD+uRJ53
	xolRxTh36y1p1BV4s5K6tCSrxG9IgcoyUg2zmKH6n0H/qakOgPFhov+iblPeDY1xcHi+gVf5sc/
	rPVAfCGCjQZnK4RHUzmX3cAqga6/+pSAbtuAzuOuJP408Cw9+kAyb7sAdn/EQfIV9crgz+uECuF
	Zkj5ZBC2xRN7R7r41hTrs9bOll3NX5nbaYQ5pwK1VoYdVKXInDiDSDxrjpwD0gwkF7GJqhtoR11
	GXmmgD3gckqLqZGgIhKSD84SeI77SJqpWjuzZxV2P31uRbU3d1OMmcLC8l/E332rupJBtKTNcF9
	jiVsZZg1y7kAnLSe6F7KNaa+gtrWWZ4NxwrHubcg8XmhRhrbGywYayaa7F+7DYa/ftUcwRDDQRa
	Ppgez2E22yYaetXOm1i52/57xZhwDpV6MJMvmV0bHiFhNeDLOyQYFFct1yfTiRJVjCHZuQn9n6J
	PDGrvZ3WCpF6GbXpu3u7n8v6Q4N+kSqgMDK8D2m8HTWmvdz2p3CIbvJVs0/Z1m8kHwsEjqaSR+H
	qAg=
X-Received: by 2002:a17:90b:2b48:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3acef0c88a8mr3507029a91.33.1792284767800;
        Sat, 17 Oct 2026 17:52:47 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947d2706sm14951503a91.16.2026.10.17.17.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 17:52:47 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Oct 2026 00:52:46 +0000
Message-Id: <DM7JXB4PREVH.1BHG31CCNRXF1@gmail.com>
Cc: "Andrea Righi" <arighi@nvidia.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Josh Don" <joshdon@google.com>, "Vineeth
 Pillai" <vineethrp@google.com>, "Balbir Singh" <balbirs@nvidia.com>,
 "Shameer Kolothum" <skolothumtho@nvidia.com>, "Himadri Chhaya-Shailesh"
 <himadrics@protonmail.com>, "NchangRoy" <royfru44@gmail.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/5] bpf: Expose pinned arenas as sized bpffs
 files
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
In-Reply-To: <CAEf4BzZZRrD86ZswsB2r-swqNi7D1p52Vs=fQ9MXSgGATN31Jg@mail.gmail.com>
References: <20261010224902.1232178-1-arighi@nvidia.com> <DM6HVNSP3USV.AJSWS289Z3I9@gmail.com> <CAEf4BzZZRrD86ZswsB2r-swqNi7D1p52Vs=fQ9MXSgGATN31Jg@mail.gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 12:52 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> kernel to do that. But once we have the ability to create ARRAY from a
> bunch of pre-existing memory (e.g., from memfd), this can be used both
> in a guest and in the host, and both models, guest allocates or host
> allocates, could be supported with the same model.

I don't think it will work for their use case.
With array of maps scx needs two lookups and two NULL checks
on every access, and the result cannot be kept in the task ctx
which is in arena today, since ptr_to_map_value becomes scalar.
unless everything is converted to magically bounded array, but...

> annoying, but what if we teach verifier to just automatically add
> bounds limiting sequence (e.g., masking if value size is power of two,
> slightly slower sequence for non-power-of-two, of course)

while working on arena ~year back I tried to add runtime masking to
ptr_to_map_value and couldn't figure it out.
then in ~april I tried again with llm-s and failed again.
the main issue is that ptr_to_map_value is a pointer,
and progs keep adding random stuff to it.
There is no way to split it into 'base + offset'
and apply mask on 'offset'.
I tried alignment tricks, like align each ptr_to_map_value's base
to 64k or such, but still failed. Something needs to remember
upper bits to see when math overflows.
That's why Barret was using explicit mask in C on every array access
(when he implemented all kinds of complex data structs on top of arrays).
Every access in C was base + mask(offset).

Array from memfd is a separate topic. So far I'm failing to see
a use case, but if it's not a lot of code, then why not.
