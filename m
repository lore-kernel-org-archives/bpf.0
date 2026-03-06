Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875733A00C
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 04:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772771221; cv=pass; b=tGBoXK8MIou9XRx3Dr09jHskZnqPxZSiVGiqovKEsM3b3kJMKW6FKM10fkhUEKAHCFJxFWP0EX8wUlkKf4M5vfVsCWfi1X6bZ0Wuwd5c+MP4bcDS7lzGeYJERW8Zpy8DxCNGvliqnmYwrk4oGdKKfXlSSaTJ2li784n4JY5uUHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772771221; c=relaxed/simple;
	bh=Vloi2pXy15+ibnsQ3+S9JTS28TZwgWWwoNlasz/n8q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slMc7O97i6R34Ux2/cp+zqhvT++mt1AOCDSuJkldnQrHN8sZVkq3nDE1IF5npCYGeW9yroa23C5TXDK89A5hrFgvZOrhInm4/C33LMj8VKF37qdmO1h6iI6OtlhHm4V5UCJ7Q+b8h508lvWdb3GKkMIIr3oKxNnjbmuCmrfVoD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqDwcYtt; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqDwcYtt"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-439b78b638eso5521139f8f.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 20:26:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772771218; cv=none;
        d=google.com; s=arc-20240605;
        b=A2YXFIbcmn9TXSYCcxhZ9nRYHGrVumEQgDPwQfOLY2hYTuo7xwN1tveKXG+9cNsm64
         jI6jZucMhCiHfyJWYvhGe6faa7M940kzHzapsNVWLvTFTxGmlyOIYBh9hckha2wvJn/Y
         grhZmMCByKXebA3R5u1XTbmMi0oPLuXRlV3x1ISGOVcRoY1CveviVey7MasgGZ+oPL9J
         um2MasvNmTBD6TwxuW33ivCsDCmP2+u6tTttl/Pa07zn7mfAmwW3bX4V9onGhxazl7+f
         uyHdoC7lTgLAmk1u5d5RUfgzlw3tgDeu9L+i6Md3qPP5MncCLyAuG/iNH6xIa3H3BHvC
         YUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Vloi2pXy15+ibnsQ3+S9JTS28TZwgWWwoNlasz/n8q4=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=LlFFwRJNJ6UWHNZud0GrAR4Vs/4uN/FPJdJC7HXVa07ik41zSL95/LGTZZQQKZJNQB
         vI9YyYiSBNU2/RSBsVd84DPuPQLQFLtz3Ro55/B8CTHF/pTofhN12E9Ms7gq0Dskmund
         bhpWkFqSfNJJ0bdudSsF/BDJqlKNkZU02NhsXs/SvG7sTaRDKeKQY3Yut0A+1w6htrCZ
         Q7BpRbElpqV0aTLCsRb2IOcTpWrnBnxIt6ynPXnKOuhdMUeoaum7wzLD4ZC87+a8ftfw
         OFpNl1e5/nitQe6D8KowtLj6gCbHW1f/Gi0YtJ+UBcn1fZVHfAr2Yw0HdzUw/qtiAVL7
         iEmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772771218; x=1773376018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vloi2pXy15+ibnsQ3+S9JTS28TZwgWWwoNlasz/n8q4=;
        b=DqDwcYttVaVsai+pRvfNLV1adRJupY5x18kbHACD6s27bDr2VJQI0upRlrUnbFsaXC
         RwZoIrFWlCZ5qjrTKuqWkADp/9rgYjR60Bpd0T79NX3JYtgP6PJZI9aPmLD3zSnfFBkU
         q1ck+/NxGJtQsyfzsqdA647fWNh2uVp8jZduuZKZyYrmfOplqumn8Td4LYT+sw3IVqeX
         ZRHitHPihOgEvM50vPmuiYkaDzQremDTnV50lPPaeRnVnVDrlbHjEaNMC0B+oKrUrtK4
         pNAYChXBNCimnZwtTcF9K50WGOE7G9nqpZRxnpBfHZC4549GZaYFuykON0ohG2zQJcWJ
         uwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772771218; x=1773376018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vloi2pXy15+ibnsQ3+S9JTS28TZwgWWwoNlasz/n8q4=;
        b=J8SkFRRVprcnG7ZXqci2WP7unY52Wk6YSa851CqEsa4o8FKCAqm/1ggNH5DrUnXGvO
         iEcedmlROkYlHYT8MDx9tWTQzaAcbmfOp8J+NutT96l13vkk9oThXATQf2Gf+Wx7tX70
         yfQCSJ7ZTxzFPgHkd355EmIG1ANBXwPXnlCQ5gtyTUPPMoop3MThAhHt7wIBIckVU5J6
         yVkcMt4We6Fo0iTo3qEWXJHA/vGi7rUSsppZG+CUYDNyMjg3CP9LpLgDgwvVtiRIqYih
         Ep2QkbPrbpMt0XkUeUG9UPUpkPNEhFHqiP+hL9L0D0L9GZaOGHmMUJ/rYgofL/5UDF4t
         ljZA==
X-Gm-Message-State: AOJu0YzoAQddiErFEQg8AegJJ0EdRJi/HbexA0N84RVIUabMpzAOb39S
	qYdHA/nH+gEwxqHiUuwUHhy5qpjxz95QIABmRy5QoQLNiayKpgXex1sTWkqNSK6DHgPa0MhFG2m
	7yBFTqiAPyKgU1CfmI6cPQzipiFsQtuU=
X-Gm-Gg: ATEYQzyFpsgdLOyJ3+Zor8aYhNPIgqjGnuQPrSos65r15tXuxb65M2rE0MUx3F9buC5
	4INAiVYql0nnx3GQR7HuTRalLTMSkz4Ih8fIqdHbrWQyOnbQiGeHPWDyOw37xRp++1C9Haz8V/S
	EAk7pcLyCHO14OvhPc+Xl4QHSmiqkR48h129LeNHLvw77qkkBU3L53i4s628jSTFq2w0VXDsPuk
	fywfDEXinIvWWNbors0IJB5rwz1mzv7TuFqMCUQklv5Jev2pbSVq9UBp3arlR489kciq5pUBRzN
	T/4SnbRFMPybSGdRPkPbWAjw7RzB6koSZKLXNrhGPME6jG2OwDS9UjU8L/U=
X-Received: by 2002:a05:6000:2c08:b0:439:b4dc:1e23 with SMTP id
 ffacd0b85a97d-439da89be8fmr953680f8f.44.1772771218212; Thu, 05 Mar 2026
 20:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com> <20260225-sleepable_tracepoints-v2-5-0330dafd650f@meta.com>
In-Reply-To: <20260225-sleepable_tracepoints-v2-5-0330dafd650f@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 05:26:22 +0100
X-Gm-Features: AaiRm53lhHk2nvRljRUIlesOINgfq8CiLXLvDlPTOH-0mg0POAv-yVtMgvd6Y_s
Message-ID: <CAP01T75VP80HtosXxvq41WyNVU4zBnRG=-g--dDxsuba_Q_dCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] libbpf: Add tp_btf.s section handler for
 sleepable raw tracepoints
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Feb 2026 at 17:29, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add SEC_DEF for "tp_btf.s+" section prefix, enabling userspace BPF
> programs to use SEC("tp_btf.s/<tracepoint>") to load sleepable raw
> tracepoint programs. This follows the existing pattern used for
> fentry.s, fexit.s, fmod_ret.s, and lsm.s section definitions.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
