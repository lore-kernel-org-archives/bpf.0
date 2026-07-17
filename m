Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECEF389455
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784321923; cv=pass; b=SqVE2btqSn4xABixDw+mUhEodxF6S+4YKofrxnvZkeqeyremLA0E9GzbP6pbjxBPS6WlyYlV1dnj2oDBzpkapAU4NQdyKWAZhvmK5OFJw+Pdg/MfsFwfCVpmCz2N+LAfpF5/JUjrBtvZ64BTpgqaS/R5VwuDgYxt1w2uhYja5OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784321923; c=relaxed/simple;
	bh=AaHe0iwVYVtFnnVoU1xS/Nv4RLKGQrG7mpCjW+za+D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXAGSNeT43qWoIN80rSc8BRMEcMET2N5m8J+0NMXQxVkmeWzz0DQfkfwSX3icJd7sqEqjdtuTxA6GYVWPkVMo1MB7ixHpCjdCD9sFvfu0hKUYm7lAJjUI7qz+7crSlebhjyn/wRQJXl6cfXf9eCqlrUPpSHsrE+I3Fa2tBLK3pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVpeC9nd; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVpeC9nd"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso1006887966b.1
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 13:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784321920; cv=none;
        d=google.com; s=arc-20260327;
        b=a2qiBOKpQh1ZucCJRbArLFb8ILFue+GyPFWRTNZPtmkdp5I4VZGR/ic6ORVgcYVX66
         tWCQ3D/oGiq4bOoCzrGzc+cmJ0Nrw4CHCm0Tg1LvaX60b+r/Pzcr64tkyjgD6i7K8sym
         pVbHLmbSMd3CWUVTv75z6NYdpuqJ6KFa6spacOKTo5nXS3gmgk+XtSwxSjrzn8Q4GN8v
         QHebXT+zod5RmKzvoEQcHsEDz+Y/J/R3MZNBfmzqXGZOS4HFVJ84z+O5kh9CUM7Y9xGS
         /jl3rLF7h9vxlucDHDHRUfB6KwY8iZb2WlxGYs7Hvd/4BmzHcXJxncsxRkg5cqLVVgAu
         lYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AaHe0iwVYVtFnnVoU1xS/Nv4RLKGQrG7mpCjW+za+D0=;
        fh=C5ZMPx5yCaxKt4RmieJyu/T4225th2umXwv1DbV3zGU=;
        b=mrNdQnGf+I3kxr2RrwDjsvgdQCpX9byWuCc+v/TuYdNt/MIzIL7CfymHk2chP8USi6
         2vaYFFHXV5yCt6UVHfNdf69FqgkNenXGq+Fo012wP/0s+9q+YxLl6xSwpXnP6PuMZKFZ
         m9c2eYIHQXj/ULTfiCvKNAJOwCOtc08QPjqVd1QgJqcPYFwFsuJNm8sLWPMNWX/n4LXm
         1XRHId1fDuLauc4REdZw3tYphvSzz9mq+j4v9CXZK0tfk2ehDsuL4gvdZBgvHCYq7dAM
         N6claHF4C1xtYYH5F9TUms8L+Np1AIo82BQWNb6Xj0kwffawsaV0k+sBoPTtF/HSJeNP
         6tyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784321920; x=1784926720; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AaHe0iwVYVtFnnVoU1xS/Nv4RLKGQrG7mpCjW+za+D0=;
        b=RVpeC9ndGQDpzZfDpKyYMtGrZtjpJBZ94QRdXTHCTGgwVoZr+T0js/EvFsRQcjO9XQ
         LMXq7Dsezne9S3fLoKwn7NLsnr/aGxgTSI0y9l8hMXaCuacRiQic5ZP/MmaUvATT3Rq5
         DA5bXUVIVFwrHJYwviag556pXKmLA7V2en/lT0QrUhwIGSlhnM55n+jQXNmZVIxWu0Oc
         QhMUKV1S83Tv97PLkjvq2wvwIUHxg49l4X0EPvXKwSLzYOMQe23/PtaBwZE/gpE0JqTP
         vTJ3s0Z5L27/meSZdssRIinHYs9cby+VH6g1oLyPP8LgctvyUo83Gkq1tNDodM0i3+3f
         7GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784321920; x=1784926720;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AaHe0iwVYVtFnnVoU1xS/Nv4RLKGQrG7mpCjW+za+D0=;
        b=LeodOiLVZ9lE5G1/oCeTWE+e86KM3ZwMUyMgTXFz2apOuf931qBXnyDezozA/U7xXA
         fe7uFxhgTXRzbt/Y9CFZ/Rb5oGteiwrMXephc5ElYy0yVSQN0q6jpOEi0r7bl0CbOzcn
         Dydge2ohvcHCX7+dghtctaVMvr51EkT2DvfnXGKCb+s4tpfO8MqpnYq7VK6maJ/XNGeK
         BMbI2xl71CNBAgQlWXALzRDG+a3FhAQhv4DUPB7edKl7swVMuWMTWgKt4I9QtB7Ry1wV
         n5iYbACuZyoYN4slsXXM1O+z8KJ7wlvY2hd4ZYPK2GFa9P1b9b2y1xp3vb7cSxVQvaSe
         wmRw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0tVW8jLJQswIbQaea0B0RB7H6m5Sfmp0MB79DMs8iTZMFc4OqdGYDJDa6TGxRycsTnDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySZBtsS2FD5YnopsEtF00MuaDrUzxCsKZ+FHI3I/53ZTZFw80X
	Qhg/akepM1pU7+taA6Ug02N4DTa05YEtn38r1rdTdhA8o1++O0uSONOZUTbdAA/cdDKN1BsUJLn
	NFmXq/zYYI9G6Ajzupt0k2+1rqIhEFOI=
X-Gm-Gg: AfdE7cmluvNj42Dc9nsh919PUgBFcnnv6t2ip1XoeECEyQdAuSBMuTaqYhjZpolmkXU
	eE4y37HgpVdDw5Ce5mrCSgcr07e6+Ptlm7UMZi04cUcs0lGf04JMKR0gE7iYPZTRXpkwHTEyPZL
	qeVRKrtD5D+RkMViwt3NvyN8Eo4cWrkq/fYI/Elz6cQs8/Y5NN191rD5xMauU6mW2IL/rZ/YIGm
	8PiQRQYjA0PN8JAal0F5Cii3chY7X+o7NUTGqMfoQETtpmmS01sHFMvKRl9YEO1
X-Received: by 2002:a17:907:e84a:b0:c16:e3b:7d6 with SMTP id
 a640c23a62f3a-c16b4807dfbmr161386766b.54.1784321919929; Fri, 17 Jul 2026
 13:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717190544.257306-2-main.kalliope@gmail.com> <730b11181226fe2aa47c5add541431bb8bd4b4fa6af6e3b41bd8a09161d2f51c@mail.kernel.org>
In-Reply-To: <730b11181226fe2aa47c5add541431bb8bd4b4fa6af6e3b41bd8a09161d2f51c@mail.kernel.org>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Fri, 17 Jul 2026 16:58:27 -0400
X-Gm-Features: AUfX_mw5OXvfAs5aw8AM7JmHJ5eQ_cpkeps9DzlUhM-9RWXoRJOLw6wcPpuOJ-w
Message-ID: <CAJZwKkjUR3FLKwY-WBSwFgK_nLrV20nGGtHZOt3Jf6SXpgyurg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, parisc: Add support for BPF_SDIV and
 BPF_SMOD in the parisc64 JIT
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, deller@gmx.de, James.Bottomley@hansenpartnership.com, 
	bpf@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, visitorckw@gmail.com, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 17, 2026 at 19:16 UTC, sashiko-bot@kernel.org wrote:
> [High] The patch implements BPF_SDIV and BPF_SMOD for the 64-bit
> PA-RISC JIT but omits the 32-bit JIT, causing signed divisions to be
> silently miscompiled as unsigned.

This is a 2-patch series, and patch 2/2 ("bpf, parisc: Add support for
BPF_SDIV and BPF_SMOD in the parisc32 JIT") is the one that modifies
bpf_jit_comp32.c. It threads is_signed = (insn->off == 1) through
emit_alu_r32()/emit_alu_r64() and uses the $$divI/$$remI signed
millicode (ALU32) and the hppa_sdiv64()/hppa_sdiv64_rem() helpers
(ALU64) on the signed path instead of $$divU/$$remU/hppa_div64().

Patch 1/2 adds those shared helpers in bpf_jit_core.c, which is why it
does not touch bpf_jit_comp32.c. With both patches applied the parisc32
JIT returns the signed result the verifier and interpreter compute; the
ALU32/ALU64 SDIV/SMOD test_bpf cases pass.

Nicholas
