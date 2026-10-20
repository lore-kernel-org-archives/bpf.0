Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456552;
	b=3XNg5lopBRYQclWoO7o6YKs0tNJgHeaD9ybxm582QSmdvSORXNKZRLo/gStQcZLPxjXs
	 DEL8scjOD5GoMPtUGT2UyFRi96+Tl0giIgImOKwVC85mHS58WNNyvah+J80MSIHCD1bjE
	 A6AeMRXV91m25EnjfNDqnx6e8qTlXhC+BIQFFEv/3kL3hN0jUt5ldVW/GlZ1n2Gn9XRJI
	 RXwS4205VqwH0uOg8HyJ3lfHMKee4ylSSFm7EKroN6nDQseg5N3szBCRuN73UqLH27/VL
	 H/NARcxWOv2SIz6MmqnoTLCirnn8D0gyaRMctNDw/oZO1uP0u6bF3oBUYoWixS93sBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=oayzeq/ffRRZK2XsT9LR9PLQ/VgPUckLtfFvkcIvl5I=;
	b=FGnuwg43KjsOB0QjiMzKGVgCPaSBt0cxwarU7R0d562IacAVIiA/F7JPbfODHQh6XrGM
	 EAoJEAJrkWdMroSYoF7lZL7jJECWhwiT7Kgb6V3TmRJLD0u7kG+oMJSvOmoMN/03tG7g3
	 /5CVOIrIB4QoJRHXx8PBEoSAbSESq5Ythz7PR3OGfxi6WA9TKgrZW2J6VzhKiBrVlQB8Y
	 tIoEpM/BmGY3LO18X1daViI/yvGnBbkDYwHQzAFP5Y7vMI3Bt5je/R9oQsoXlCqrJQET0
	 MVNS93EvRqEGR5mk1bGmR89WOdE4fLylKmPqx9kySBLP3lxJLB34SbQ4QLCHeL9BknQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eAEVRu2V;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30264606A323
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 00:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30264606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eAEVRu2V
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a706146559so2062207a91.2
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 17:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792456551; x=1793061351; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oayzeq/ffRRZK2XsT9LR9PLQ/VgPUckLtfFvkcIvl5I=;
        b=eAEVRu2V4UqcP56T4HZZ1IlytaLi5bONS8LprSycjgJbf6TD/KsczqfSf33xwoFgiP
         cO2CNmUYrXJl1hyP73PYfr4VL3zcDyPMQuXqD8A3/m3qg17pDBC+FwZMchuT1GEVYkqk
         Pno/b/ifwhs88auTwgvA4hVBT9I0+QanT3SIWcEM8qinBfPLg2YMUKPorVsKw8OIvSRR
         pfUJN9UZ+YcsaxATxIwIOPMNsc+q0p+0SwvkszAbxKE6vg+XgyxyV/UcvARA+I7QZjXb
         f8O8GAbTEe7rNqCQj2mcN0+QhyQ35IqE1ZGA/SqzpRwP/EUm3ht4nFbFBTSEGZzual/A
         LOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792456551; x=1793061351;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oayzeq/ffRRZK2XsT9LR9PLQ/VgPUckLtfFvkcIvl5I=;
        b=2NJs9IP1RVv06ltB0+8eGgT8nYHZTV9YcMneZC8/56PqYaScaFJznrT58EN4Isdgi9
         qVuusEfBHdgaWIJmFberDWh+CggT/9FQAgwa6feRf2qgWJ8oANq/e8WO/P/OQxEcJCLO
         5Yu51FekN9gCyiOQ4SLQB/AfilEH9JoqWu++hZ6PucuzRWW4MMsCEhu+7/gydQQ9uRjZ
         Vxf3wW/3UlIY7/YSWXLPVygfSPsLZKFrMPZUd0rXTNX19eJyWqaFq+o7WRUAxA0vGHVy
         EDTOllYCdyU3NBT8tjgH43O6Y26LsDFOUG8/vZ9ePf5EJeB4K9TptZAyf8qCr/RXcjds
         HtBA==
X-Forwarded-Encrypted: i=1; AKwUvBzUQyD043oei5+xVY7kD1yA/NuGhXEOUg2pwMjcaCjetnF+mzJLT1KQY4ALDfY4LHeZbf8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNrRKfzlCycBl6JAfQC2gHezeBypCD+reNeZIQlngYCGrUE3y9
	+jZYezEV28SwLuQRETyd1Y9npcwzH+mTs85uW8CZebbkzDhsD5j7ODi9
X-Gm-Gg: AYBFou1/cJ+Vb8Wz4FfV57Y1ANOUDUBIywLdUYYgQV0N3vp4qcW1enUs+I2wbjV9Hrp
	MYROM8h5VQNktHpS8TD0ivSuVH+VBHrKI/tT1FNfiNsGgFRO5138UNNXEev/WPBJwiz5gfRToY8
	jASUPbWP+zCnsftMRsMIsEqQCTa4hVq+rqCRkFbe/REnVFKxfyebI4Zy0MSCyecnb+HoiEQc2It
	qpWOZ3Bf4/Am0J0DouY+RSMLE0rqSHULDXsXEQ58m3L4EWgpAIUlGum/B1ZCv5r/au55v7g3caW
	lbUwAyjUNk8zXX1jRmnP/LkZY2Yd/yG9MRjlswIAzBe4zBgg5sOunR76+GX5z01UfHq/E+DrA2c
	hLepdqIZ5eliyEtExl38Sl2vIEr+elomu2JrJhuMm/3KvqM3fC+gzawE5OZ1lvd8p+vLZr9Foji
	uTpV3OsAD/DaBj1g0PvsEzhr5d31ZvcL7lLAl7bQ0aM77Jlu1lXbDoZrJWzTv8eaSxd5JAq/7pT
	9alp65P3kXqN49dgUReHN/BnbqgaG4f6+yM9/kuqAbyA1wUVLD/Jtusp/ClhbXI3Z9gnhRGAYPm
	efE=
X-Received: by 2002:a17:90b:35cb:b0:3ac:8fff:5a1b with SMTP id 98e67ed59e1d1-3acef3d9570mr8518570a91.34.1792456551322;
        Mon, 19 Oct 2026 17:35:51 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d56eddbsm1552366a91.9.2026.10.19.17.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 17:35:50 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 00:35:50 +0000
Message-Id: <DM98TFI010XS.5UZ5IEJBS2RQ@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?q?Adri=C3=A1n_Garc=C3=ADa_Casado?=
 <adriangarciacasado42@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Add __printf attribute to
 bpf_diag_source()
In-Reply-To: <20261019195916.186225-1-adriangarciacasado42@gmail.com>
References: <20261019195916.186225-1-adriangarciacasado42@gmail.com>
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

On Mon, Oct 19, 2026 at 12:59 PM Adrián García Casado <adriangarciacasado42@gmail.com> wrote:
> @@ -794,6 +794,7 @@ static void diag_print_insn_context(struct bpf_verifier_env *env, u32 insn_idx,
>  	}
>  }
>
> +__printf(4, 5)
>  static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
>  			    const char *fmt, ...)

1. This doesn't apply to bpf-next. 
2. The warning was fixed a month ago:
commit 7f2b0b57a8d7 ("bpf: Add printf attributes").

pw-bot: cr
