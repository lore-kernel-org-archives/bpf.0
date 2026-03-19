Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB9D3815E5
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914283; cv=pass; b=n8EEYy5vEQiNrUNHzRJIoM6xN8o3mLqevoZ0V7UlSne5LpYVW+G+tprp0q+IPz2UAewkPHQe/0zJvIcdYVvlRznkq5s5G5YguygBslZnD+IgAFHMaTIDhnT8ThJQG7/pTIaYXP4QMxuHBdkhhFT9mzTn9OfhHqlPBvZeLcyDkPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914283; c=relaxed/simple;
	bh=NRv43bQrsM2L3o6um70KBvPv6yFENMJl/KF2RXnDZE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3zBxxOGRiZgEixranH0yFE1TAq1D9lGThWA2e7/jlYyA8CgtvvTnDHsj/DaKTQKsJXlJkIBKv778OxcHxETo7dx1ioINIlf7+uqL5oZMMp6cSAZN03GTxdcXbDenk5syJjVQOv9Mqy8ahGmyIjGH7MooWzImgp6taDtmCS8x2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVEU4TnL; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVEU4TnL"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso6092945e9.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 02:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773914275; cv=none;
        d=google.com; s=arc-20240605;
        b=h8U3dHDKOe3LBO00AegvGqGO8DBZ5TLYUBPJrJxk07i/r5ox2SX8cCyI5HELHFFgP8
         pVvULn6vGAAKWYcWYcBZcuEFanhZ0zvedJD+CFkx4CNK9bvI3DadI5xA2B+cCEw6mGx/
         hxl9mrKXRqshnj6e6KyVYXfdhmKBvCj2C2TC7EN998vuVSYlUPLXjITewo1p3rzPisGP
         V0goVTeBH3ifGNLkY87tQUr+GOeJTv5wWqshcsxZUoMvSgr+TR08DXNyQzhF7lkD0Z6n
         ym49QnRaxlrXRHir57G6C8OoZ3H3tewoBzv7D3h62mbN3Mmm8tsZrTrztWPSNm8g2mY+
         2Sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NRv43bQrsM2L3o6um70KBvPv6yFENMJl/KF2RXnDZE4=;
        fh=2TRrcgVb5Vf5+T+Zis9foCjsnuQcIZGHFH/KdsX9YcI=;
        b=Xt2ddXh2m1TXEirzGAGXavsSSwhyhBJiruJx4qQ38EnmbqlidrxyExXDR3unopL2wK
         Io+/+H7dRuB4EF5tpB0562XaAXKoEYg112SDRRkMF9BzhhuLFGCO3yVUJm5NZoWiz4YH
         TwjzvEeJI8MRvHmC11vcGuNcUecqiNJ3F6aMcsMSwyDME1ewa9vJtbTCQEBVnlbMc8gJ
         S9KFAHQC1ydLkDiEsP9tVsm5Nqst5NKnsVqRkDgBpmazBfvOFfFXPv5mSruOvHvyhm7a
         Kv3Y1sGAq0P4izgkC/ps+1eC7lW9HDdda2W1Rz+O0FZOFKPuFksbySXQaBG7cjCbooyb
         HZGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773914275; x=1774519075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NRv43bQrsM2L3o6um70KBvPv6yFENMJl/KF2RXnDZE4=;
        b=nVEU4TnLe0SXKP2d3ni8H2RXEWGU+TH4lY+05eGkLWImCGSuld1kbwYqVEOzR8ZiJP
         d/1pZTN/K0FY0WYYgCV8KeOYGrHqoh7e9pK3sMyLNa8tMNLeIDAuEuJchGZjlb74My+f
         hrUNgkzalzoSftCPlEgAEsi1u5ldcqiLB9FDmXBxKS5hyUfJjpCY+sqqMfc2gW2ZX3wl
         PxzgEIdm3EsojJPXDS9e3+QmB6mjcL90l7/PsfJyI4YCI7fEj+Wv5Qb3HHFEoNRGaMq/
         r7RGFCqZWPH8hai6BsiySnjfNhPysPfx9EyRxeL6fnzL5VaxIBRP4621PSjFyKkL6t10
         /7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773914275; x=1774519075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRv43bQrsM2L3o6um70KBvPv6yFENMJl/KF2RXnDZE4=;
        b=HlwsKlDbbbr+YvW1aJR/sXg6mSzYDjX6T1mNrrd964ggisL2C9KdpsVd0EJFV6r7bq
         UcDXD8Mg6ZuaW5Upioun1/yNQcajj2K81pC1ogLfy7tKAsceEZcSvU3+GZN80WzX2zrk
         6xoiRUMHadBxXumzj39hq3wJK2+eEQeGCYpcmGzO71YsRKGCAD0ExQ6kzyDCH6YlR7bN
         kdESqn56jzoVJHPSVv/gflqx2uLyfsRM7Tf8g1vSfkHBuk75PkOAqAHK9J4hvkZ4xZdr
         X1FbzPhdE1ZvgTJuh2MtMoGDBjz8AhKFBg5z8Kd5lo7UOSexW8lzbTTKCv38r1qV4uqj
         jk+g==
X-Gm-Message-State: AOJu0YwON03aOt7ds3DFJs1cs58jwm38dq3KkjXeBEa2TlVGNnM+r0FP
	62cw8/80Wx2+W+K4Q++W4b5BjIbwH2yRn+rzqA9V2VrTrQraOn6B5ctUdBXGH33lY8EQUUcZaFm
	LWYeVJdWvzROl/XqQ4P1nR4+7WHuPpaQ=
X-Gm-Gg: ATEYQzwog9mB6r0ybHirR86rSxTxnMNMpUfchrGN7iTh97LMrSZmDpBrbCaHZ1peCsN
	I4Gx59yZwgr+nKOGzIzywD21U9L+lkOtUoPcsH+h7oYqRbprJyKKMHkYgibaV5i2QB0Vex0NW1n
	yuR4eYl6ghvSKqv0U0wpxjnIQEIJUkeiYzyffqGAVQj6tDF+5C64bpzJDhN7aUPeSMojtoYdnxk
	Drtri+OHi/so1AClnnmVQlsUaifTNo+pVe4DqygP3y6u/3Em+pv1MP9ltj0fLjHQ5LbryOFb+6e
	1jQfUrQTCuicyLFxcrWh7dWjSvhlGR9X44cJ2EfLfcEEDHtRlPdXckVhVIk=
X-Received: by 2002:a05:600c:a118:b0:485:6e40:5584 with SMTP id
 5b1f17b1804b1-486f4440fa7mr86330065e9.6.1773914274859; Thu, 19 Mar 2026
 02:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318174327.3151925-1-puranjay@kernel.org> <20260318174327.3151925-3-puranjay@kernel.org>
In-Reply-To: <20260318174327.3151925-3-puranjay@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 19 Mar 2026 10:57:18 +0100
X-Gm-Features: AaiRm516OdNYEwTl_hUS35JLRLIniFmmR5MvB9cIkgM3E7aMzOrXiemcBSIlS5M
Message-ID: <CAP01T741H_sVxWNTO+mMPc+eQSaYD2gmm1mMmSRjmaKAOwpGDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Consolidate sleepable checks in check_kfunc_call()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 18:43, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> check_kfunc_call() has multiple scattered checks that reject sleepable
> kfuncs in various non-sleepable contexts (RCU, preempt-disabled, IRQ-
> disabled). These are the same conditions already checked by
> in_sleepable_context(), so replace them with a single consolidated
> check.
>
> This also simplifies the preempt lock tracking by flattening the nested
> if/else structure into a linear chain: preempt_disable increments,
> preempt_enable checks for underflow and decrements. The sleepable check
> is kept as a separate block since it is logically distinct from the lock
> accounting.
>
> No functional change since in_sleepable_context() checks all the same
> state (active_rcu_locks, active_preempt_locks, active_locks,
> active_irq_id, in_sleepable).
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
