Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D237A82E
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059187; cv=pass; b=LqqEb4fTcQi8gmfoYUfbaztxJXWQuj+eqHEwdypWLZSzE9tQCQnztg2QncHODx5GB7JKkWcPvDu/ZFeIOaYfv9Jx8DaNTQ4V5l6mgoxuoUv4m1UnRnXjg0PPfYKs3eAj4+MMhez3MjUbCWhwZMJ/MhviVJOxwnsX0qtIdsP09cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059187; c=relaxed/simple;
	bh=jI5V3tWpdMHRo0QrWwUwJBIeKxjIwvEQeenkJyJuwxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ajru1VJ1T9U2awqbDDnAyUhh26kd9Oqpj9UzwWgL5EtwMjOjfM9Xyby5angZF0NKvkpOj2hsT1oOweOnR9/0i5LWxHwvfNYX9TsVhkMkeRlwQZqRbU7QlB8isoKoFvVy4jlrMMSUr0rviAX44L3oTKr7xLGc6Y+AzHVHiIdhwjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pC3z9B41; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pC3z9B41"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15f6d667bcso591321766b.2
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 12:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784059185; cv=none;
        d=google.com; s=arc-20260327;
        b=UlwTRAUlo/RrvfpHY6EReUnlDmMvgqx8hAz/EilGb60VASs/kpVb7hz0/6qBsTOBKZ
         xOSI8cdbDTZJhLFHymXoec4/QLTlyS0guApnqcLvBZTB8ptSE5hG4pRFhPtT4AH8EIE9
         CVDmvijiVObJ9erYTeikmp1LZGC5WSLGv+fr8o24gNr1h9G63+cq8iNEfeSO+YLK5ztg
         +/KunkrVIDxvdOZZ9sVU0gGP0m8I2rZWNIR2G9bQRoe/9mHwIbymDW1mqauUpSVzJxrl
         iV53MZZ8mH37JGWDQbNfh3mdkNl4nE14DUQETwEBlfA0SDLFlcxe6vIwk+VJNJ880W0L
         Ne3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=buY38vxHP2OUQVk5XzFGddWBnQtMpHC1RojiGdPVoiU=;
        fh=qGtVJODNCOMvWgzKIKsl7uq2aTmX4nd1RttMg/zz63Y=;
        b=pu+EW+OCtyVtuC1y0OZQT7mivv034pPyUCq3JxyzgoyO6OOrCIq4+BCyRLJ3ZNRhI8
         SzYf03sxG+cDIKbpHekvkUE1LC2oWfytll+kUzZKPOgSvj2zyWYCbMzjOze5qnFgeC4o
         HpiJ6qvDqRJ784lQkCdR1BA5QVb1/oH1MXTI3V6wR5FGi/UVOPcI37QGCRm06hbdApUi
         rO1CuOLWuah9Fsc5bckMnj9Lrj+OBBlBXcV7ysv0u3ep87IDjQQRDSsk3THTfJ2f0D3a
         p93334/UmvpYFYbxd4xH54fE+SfLQ0WECvi2Y8ME5JDhn1po85uPN/m3ikCTjVoE0ouk
         QwcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784059185; x=1784663985; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=buY38vxHP2OUQVk5XzFGddWBnQtMpHC1RojiGdPVoiU=;
        b=pC3z9B4142qVHqqBr0hUyPxTlm6hZ5c+tMZ0nsG/N8/8Pw0sJfSBaFsTk5Y21zafW0
         64sGSbHEkzJnlEPXJp6Cxfb0FO2ZLblS3aPcovNex30cEnl+slTTEs/xMsUNh3C+JRE6
         mZO9dUqTOAPPYovOpu06ODybD+Ekd/+f0xSQFKR8lkhh0d+5RA0JmMY3scYLO8dExcEZ
         aYjo6hkkhQO1Y67Ky70oO2o2pzyjXl+jUF5ZnNS7KZjoVrCQ0lX2jEoaSfO8AEBcWLcd
         tnkPAg6lNoriJnFHCrcxHcJF2/anXcP6iOLdUnMXLoiFnnoR+0Ja7JFQ1pGO17OZUdhk
         20pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784059185; x=1784663985;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=buY38vxHP2OUQVk5XzFGddWBnQtMpHC1RojiGdPVoiU=;
        b=kxcHNewaV/Ifeux39ZBAEpKxrvkPPifWtSkBUB5W2akT82gurechpYuUGpWLV4Ahpr
         pcu5d1L+6lY0riLOBqCMJ+led7129KXiGlqr5TCkL7qRVa8+r+qnIT/ngscrdxvICiuK
         OHSLTV3F60vQGJfX6wq5yj0WfcMEsGnl1bVwbXRgNdm13iQsiFTp8BxZ/3RP7C7vBCdP
         F8pOLEIQIky214pzv/aQEOp5gesWOuYvM+TGsn2oDJ5mPT7XIxfVbbj0dmYa10nba5Sd
         Y9/YWp7kORIGTck9JjuM2aei0vrbBn2OXV0Efct+TiSe+8K4e2C1z9lEbQ6NNt+Momkr
         evmw==
X-Gm-Message-State: AOJu0YyYq4zl08+auPGHdGYyKFGbYb4edqOmCYqjEcSKdBezss0LCv+c
	jucViFc/O4BjF5PbFlswGoNLrZdUP+zcWIQ+SOo6PGYh5ItD+fSV0Q+5i7XerkChAN6RFX9hNdR
	F7/pvsD3P6nD3bGwUQCbhMAlOLRXcSmLgLMbcvjtsyA==
X-Gm-Gg: AfdE7cmFsPELpoqV5b6Cxgzh1CVSfpLht5PG8vE8jltECRvJwj2R42Av9Gjgja1pxL6
	dAnBe5u5DAFEEjo9iJfEAgLGghPt2nKe9KPGh44plR7Qe3zNlebN0edGPiMmncLgLbUBqHP7HYQ
	UgmDGsqx5EqOMK+PVEoqCoB0EYtW17giTg23BUWR8KfX68tOyCVl0Ooo+5DwEgs6b1kRdZYt05k
	cIRj4ktrDZzOaiuDhOmxfP8iJpchHptkWuZtMUfuEzTPlzDjQKjS2hVZA0FY/Z5pTrFsqxTrFU=
X-Received: by 2002:a17:906:9c87:b0:c15:cfb4:6a6 with SMTP id
 a640c23a62f3a-c1679447ac0mr8575966b.30.1784059184321; Tue, 14 Jul 2026
 12:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714023939.616686-1-main.kalliope@gmail.com> <b72813f0ba5f1b0477d538a852642fc8b07240ea61714931893d59d659e2f4be@mail.kernel.org>
In-Reply-To: <b72813f0ba5f1b0477d538a852642fc8b07240ea61714931893d59d659e2f4be@mail.kernel.org>
From: Admin <main.kalliope@gmail.com>
Date: Tue, 14 Jul 2026 15:59:32 -0400
X-Gm-Features: AUfX_mwJmm4GaHzoriii73SskjFE016gUQgVqJvqNOsCBBKFHg9lmg9keP7jh18
Message-ID: <CAJZwKkg2Q2sJUS+2A-r1TB9sWoZuZmhyrLkLWZsDTMHH+rL0sA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, x86: Add support for BPF_SDIV and
 BPF_SMOD in the i386 JIT
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, udknight@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	visitorckw@gmail.com, martin.lau@kernel.org, yonghong.song@linux.dev, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 14, 2026 at 03:36:45AM +0000, bot+bpf-ci@kernel.org wrote:
> This looks like a bug fix for the i386 JIT compiler. The function
> emit_ia32_div_mod_r() has only supported unsigned division since it was
> introduced. Should this include:
>
>   Fixes: 03f5781be2c7 ("bpf, x86_32: add eBPF JIT compiler for ia32")

The i386 JIT does not implement signed BPF_SDIV/BPF_SMOD. Commit
ec0e2da95f72 added these instructions and updated the verifier,
interpreter, and x86-64 JIT, but not the other arch JITs. This patch
adds that support, targeting bpf-next as a feature, so the Fixes tag
does not apply.

Commit 03f5781be2c7 predates these instructions.

Nick
