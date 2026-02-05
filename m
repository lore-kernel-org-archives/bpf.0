Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539BB13A244
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770251589; cv=none; b=IGNFVUfObkWjAodYkXGLH6JO2PTnJvfukZedFRQeDyAc9IoAXPPRUYOq4bOiCe2yN/fMAE4cxpBqTY8hBgq/v+kXUv4UESsA6fRZ9NEeS01pprmegybqucSCbPnx/uOrg28MhwkfTwMuZ3g4IA+D5l+QHRmCdvVekDhtBk4m1zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770251589; c=relaxed/simple;
	bh=9pxlpjRaLErQ4Ay/iZtV7x9PZue/Wz0S/gFaMjDZUgg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YMngsFG5m9EhSztYfR7FJUM+2XFnXSQGhwDedX9GIExQdCbFA7J6NWo0i6ry8KcFiEL0rTbpsg38sUcZfnvvy4G0sM9elac+ejKjM+TsKDoSsfSHxRjLnW+TQEnYD8mHXDZqnz70CPpToLdjPSinGU15yF+2kb2PmNa9EZoYg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJD7lmOp; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJD7lmOp"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1248d27f293so1076535c88.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 16:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770251588; x=1770856388; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AEJyr5eD/wJ7UmxUsj4/BPzc4evxz4IHu8tyN4UFT8I=;
        b=iJD7lmOpYeM8lGuuy9udCWo6GSCWkeuEOnVtcou8pJAYsnHcm7IMKqzCTpBPJalbMd
         vHmyEqLlHm8c21IVKJ7dsWZPPgq2//u3yFnp9T+KsdAWllVWypzMo6ywMSNtKVrCaKG0
         8aawCNVBvWKB8Ubp33PROuSp/TdGMIskfmEeDLzpQz3psRWaDckCG+MD49YPps+xYgPn
         CY98FV7pRFZcF6+MRP4ZgVTaTDRf9snIAmIR+L6eTJa92oJaNQ9kOnO626IdQNan31vv
         vVc1p59fqyh1yh4DGgg8CdhLcpV7ZhrRaI8sF/uFZAjbBVcaAi12xlbh2adA32eCLxXA
         gNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770251588; x=1770856388;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEJyr5eD/wJ7UmxUsj4/BPzc4evxz4IHu8tyN4UFT8I=;
        b=Ckwpo8v34NlcoDqeLFkzrTI1lSTT9UnkRPnzhkaY6wafOD7KRBxr96NFLP6T2xhPFN
         O1E01Om01Bvh9Ck9TdtWrQuinSOGAUyRwn0ah1zTmzrAWI5NhKqn9NN5scyhiVIJfa67
         88YguYQwSfAuwR6vNeR6hy9czqO7sNfkK3a4uiYkopQ2r0mWhtUSIDtBjZ37PCPMoLMR
         9lSpQAiGab6nuTopjyPldcKA2bK5+/A9qEa1eZ7hd5Y6F/h9JO+SbfJtn9mfUsJ3ypb0
         77tmYfbngYidgnFRGXp8ayMXIrjvF88iIZ4tgXJsGGsPeBcIJenK2uACF6WN7Ej958Ay
         qduQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBcKwjYoYBbuDPRyu8LyGy8wRWc48yy1SUcJEx2xItzd0wHwK2I5YbPaeN+UfzyYH7gOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhtxx7GNF5NaZDoAYV6HhWuNazwRU6Gy9BT0rjDzJRS7S1BZ20
	fwu+MrHAHU6O9VofAcXcvqhTNJt+nB+umb0OQiecK2JnFmj/VZ/ppaWM
X-Gm-Gg: AZuq6aLhxPRttB4N9c15HSqiJFJQNRTuSINwf6avebrLj2WldKvYlIm1b43o/qz0Uss
	Q2J6/a9jr8+RPc6u/3EuGFVSUQWqfPom/zxxg5z0dm+7IhIyhLz1Qz7fwlfYsficOMR2oHIVaoR
	irmPPKnFHnaf/v+xTcO+kbFM7dPcmJaRlWS8THR6iX+AtUF/fELG7EGgE7oOJ/q1P97nks+Em/f
	oUfqPDbEiCsFuvky0vEO/rMp5uEUg6CNwYeMBtJQf4JSzF2RekjIO7ojuNVL1Qgdw/jvJKyKs1V
	VNifOsWpmAUt4lSSRZ//DfasDKruBm5AxTTMJhlgytRfYGdreNv3lhne9hMRgrjaZcU50yN+KSm
	BIz/3r0gpfaNk34+hlHsp7vmsEV0YlO3c/NuTfpPenJg8C0jd48u7Yyv4GZKFsnor+NdK4rDsBr
	n37H8Dr8qX2dpGUD9CK0GyWPkqtNBRt8dHOZ/JJeUpUPCrS20ec9nOqZMVxvDR4NhjBJl3
X-Received: by 2002:a05:7022:92a:b0:11b:9386:7ed3 with SMTP id a92af1059eb24-126f48d96f2mr2478169c88.48.1770251588336;
        Wed, 04 Feb 2026 16:33:08 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ac05:8e30:1e93:7ef5? ([2620:10d:c090:500::2:5ebc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e107b4sm3309730c88.7.2026.02.04.16.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 16:33:08 -0800 (PST)
Message-ID: <724c37abf5249d48701e337fca1571de1eee4b18.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove unnecessary volatile and
 barrier_var()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Wed, 04 Feb 2026 16:33:06 -0800
In-Reply-To: <20260205002508.808963-1-puranjay@kernel.org>
References: <20260205002508.808963-1-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-04 at 16:24 -0800, Puranjay Mohan wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c b/tool=
s/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
> index 99c8d1d8a187..b50dc92b2126 100644
> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
> @@ -14,7 +14,7 @@ struct {
>  __noinline
>  int subprog_tail2(struct __sk_buff *skb)
>  {
> -	volatile char arr[64] =3D {};
> +	char arr[64] =3D {};
> =20
>  	if (load_word(skb, 0) || load_half(skb, 0))
>  		bpf_tail_call_static(skb, &jmp_table, 10);

I think 'volatile' is used here to force specific function stack size.
W/o 'volatile' compiler will throw the variable away.
With 'volatile' one should check what's happening.
Could you please double check?

[...]
