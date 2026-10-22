Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792691820;
	b=k+jayEjK0uSUmPjP7ktQ2G1aJuhY7HiA5FEDLpvrJXFBU7mKCTLTB5L6Pge15toHP+Mq
	 1C/OqDD92Sn3CBMOtEpji1QjLGnaSnLGhpKr4+4Om/R80aeMTmSOBD9BcxpmVyPjt21nb
	 D3ByLyCWJDHDPHj2FTxGlZhEe/IBiIBJOPIZhBRtGJpB55XGUcGEUiAre6Eb8rsvm3L2x
	 B0pqd2iD2BR34yEbtCXuwRd7Oo1rhrafzL1Jaa/8W2c+w8NRF3vEMQWGkg1DIOhtpxDsS
	 aFGSzl5uIvVcYBRf9Tn0e1uecV/5RJrz0DeJm94OQCpVnVzWnX5xrxmGB9wMofKStDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=BIrmnsOR+HHqvO287vhtPz0FYh6eka7mZUJWsTNMmN0=;
	b=axqPcYVSIbZQIG2dhIQgmBY/lsyk6KO6NFkl/dnH4Xe1vFoQlH2gYiiHDERlmIGvwE9c
	 bfWeeGZvpfg91tTuFfSQD5vfAtelSVcO55790ZWdbRn/bRQuhaOSUbvV/kSq99JhPJmPJ
	 0f18eNwgZ3WHDRD4uDuSZ8WEHp9Z0TCJzXDjqSPhwk+8UN9D0ixQBQzVYe5xiYyvjuS8x
	 xrg8SEBZNVeOn6blXEUbwXTJiGh0s3wKrvu9yz56tQw8kT6srJZlukWYOsiOnvfrhqoDi
	 gD5ZMd+CJm2bsZlDtFx3FM7HbSAsGNEUVHfCzkYeAp4JQRqEyq+hWVo1OQ3n87oOMYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YFdp+eNt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16729606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16729606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YFdp+eNt
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9f6a16afcso4705ad.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 10:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792691819; cv=none;
        d=google.com; s=arc-20260327;
        b=dnOupbuB7rrcbgbHt+aiGUA4I3TAwdThX+Kqlejv2KAggzZIlqxWgsRd9FJrzK9zAB
         MTZbpUvISn5oZD0A4k0kn30XcbJyKW/uqF+6R528gyw8F3ShBc32E/LXSgp/Fa/tkjd4
         HxyFjc6dbopMNZHRfzV7lP4eD2HMGErkBiZJAXxfOkZdviTWt8LCSej2YRW5Qvdby8mR
         J7VLCgqrdDkI4ffdSBytie1bipNpSsghy27loU8qKXSAb0dAelqj/zizQOXYs91q6lnk
         7DwHWdYmvwBhNJh0wqMEIw4q7K+m5sUbeu5yO1bO9Zelo9rNOSxSdUSKH1cLJqUrnUYK
         lW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BIrmnsOR+HHqvO287vhtPz0FYh6eka7mZUJWsTNMmN0=;
        fh=mww8FZlJSOPmBs0vTO8IKwY698HsGhN9taQ00L+YiPY=;
        b=WTJoGKqBXlq8FUzhsy8Yr+eYuIOAife8LvAKMqxugKh3VGt6kTORT/QMD9OAMEtCM1
         1iVrnBoPlAjuV0++Il4ETH/uDKrRqg1vD3xlziMhVmzZM+a+UPGUScwGzeM08UHkNvFL
         f6ReHmNgkbDCQ76Cpgy0kbirmTW8JRHAuhcXTzMVsUIeRjZzrioYqDSkvdGLux0bHa73
         6E48UQ47bXN7LeWsU1gZ975ZIWkmvyFZhiI3gUeQQgGMvrbhlI/m08/VVCv17Xr75C/g
         7hfNhsUpcsDsCACKqVKXR2LmnGexxrRytDiMhT7yeiiSwAv2XJ/SBG6FssIPLueEagfx
         0AmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792691819; x=1793296619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BIrmnsOR+HHqvO287vhtPz0FYh6eka7mZUJWsTNMmN0=;
        b=YFdp+eNtUuEUTvr6WJyWDSWbgr6375Hv/W+rTk2td6itbHuLtatk8TV3FBePVM7v0W
         +q+UbeyAt0FTXceQoOBjMY/Ttfd7dUv8kQJ8yreK2BjsATGe11z1rwVU5iXiMvJ3Dqg+
         9CVMbQvVQ+s09u+L4/Qu3i27gNo0YA03TQrfaezeGuyKv2F88/DFShOTND6gd0rdAtjo
         9OgISODKkk6HDUFhd6tONLgbIZKHIQ/LSOJPxFqDhy86TBHzPOEa0QWqIRCc/4wp5rla
         DJdBFgmSiM6TL4oYHtefgccGo7BRzxU0mdcGk/pGx1FgArFziiCHYZrSeVpxvNTcWRgI
         g6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691819; x=1793296619;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIrmnsOR+HHqvO287vhtPz0FYh6eka7mZUJWsTNMmN0=;
        b=kWgkuATIXWpk7+2VoErEMpIqdYjPlVaUTDizbgLCG5JEMysMkGPVGCxhBzhpJlr3u+
         rks/MDX8lxR2n4PET8LuNcHRqOp2y0RGzqxDDPS/l/YfnpU14uR2DrPvMd6lFrKgc6uD
         AiJ2iyFwtduZSJEmKSZudWKEuQ2kKoZhEQ4bcp0lP3PyyJEh7fTxk1q04DonZbav075a
         FLqiYfxOEvvoTs/acXeoVsS9KfodTZgrquZWlJGmySRb3wMl6BNTN1i8A2TJwmYPvoeM
         Y7uXJUm1Grbo5IW0a1OkZs2mjiQA8Oeau/ZT77cFx4hkJm9kG/QtY+UoljerhlPMMbS9
         PFsA==
X-Gm-Message-State: AFq9FYIKYjga17cRPJawQpQqcLURl5R2vmVVK659XjKg+a6QlTa6zjDA
	fULNCNAG+hwDzqPpF2eSvajyHiBBK6YxHGbcpaQ34e2P00fhwDIUELyB51thsnNJnfpRx60rZiZ
	8EB3dFaTKold1p+6jzHDPbKHeAuFby3dXKFt8mIao
X-Gm-Gg: AYBFou3am9z8mcN1+v1x83obfKeqby+WZhe36T3KkaEzHaMA4zo2RgU38tzfB5A1lg5
	u0kWyggrXIr2xSVq2hUqagveXeRA7IoW5nQAw5O6PEjo8Q77SbdFEP/HsabTPr2pVXJk9PYR2/v
	vhRioI3x0FQaCRpZqAr4sZ8ukjiXP8z1bCkTfGj73jiTyqU2T3EdvMN+FLqRVg8OLT3WrbNh/qq
	nHdinHVnR3GGZEnXTSEvk+TNlC+xp7qSuffcvgh4HaP5NcceY5Ns7njSq6yE+Rx0LxyRtruCdq+
	S2dvLo/TYJkEzqN8B2pa1tWLccdQVWnXYmwvqh6J6umTBtDSG9YHoSyqkhK2Cb1chamXCmSbcOK
	Udf+/Vc85P+YjapdV4ogg+4W2t9B6vFe8oMp3XyBw9vZiBx3zaAKDDZgrhXuTThLYAHW0XGHmFh
	6Xpio0Sb2DPlcQJHJ/O7pVpw==
X-Received: by 2002:a17:902:cece:b0:2dd:3a08:d47b with SMTP id
 d9443c01a7336-2ea7c856829mr195125ad.13.1792691818910; Thu, 22 Oct 2026
 10:56:58 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com> <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
In-Reply-To: <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 22 Oct 2026 19:56:22 +0200
X-Gm-Features: AclHuK-YCNtnPegYnn9KvUKugGxObkR7MWrtu-3qSRj9_sjY2T5TwF4c4QpzRSk
Message-ID: <CAG48ez0cG532aaXZF_asCDk+fsnQmE9L5PA9T+JN6OGdx6yjGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/9] uprobes/x86: Don't WARN if an optimized
 probe can't be written
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, peterz@infradead.org, 
	mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org, 
	liam@infradead.org, ljs@kernel.org, surenb@google.com, david@kernel.org, 
	vbabka@kernel.org, hughd@google.com, kees@kernel.org, mingo@redhat.com, 
	tglx@kernel.org, x86@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:57=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> @@ -1197,7 +1194,7 @@ static int __arch_uprobe_optimize(struct arch_uprob=
e *auprobe, struct mm_struct
>         if (IS_ERR(tramp))
>                 return PTR_ERR(tramp);
>         ret =3D swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
> -       if (WARN_ON_ONCE(ret) && new_mapping)
> +       if (ret && new_mapping)
>                 WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NU=
LL));

Not an issue with your patch, just FYI regarding this preexisting
WARN_ON_ONCE():
A failing small GFP_KERNEL allocation could theoretically cause
do_munmap() to fail; the VMA tree has the ugly quirk that you can't
reliably _remove_ elements without memory allocation.
