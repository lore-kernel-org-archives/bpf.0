Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8A3C3450
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031591; cv=none; b=YNHgGrHZ1bMPMSMcCHB3HMlP+/vmb9fyDQSjD0VlcMywHh3gKhtNlP+zS20u8gHWdVkZLBoNQJ4vjNuzU3uHRgj8SV5CV3HTT3kLRT+JTR9lXhBe+EeNCGLHoIRyIDPTq33BTx9JaEwp5tqP8KZ9/Fc+8Dfb3Kc74q5XhT9Uk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031591; c=relaxed/simple;
	bh=g2TLxqmYsDcWlbonN1FiCOaGRb1Al5ceMdi+LTYuhG4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LSA6/UkS9evQTiRSdOBNCSudoF6hGvhItkq9EeIC5dOO7SwBVTej3j4Lmc2h0qVs9m8KS8D7TMwJd4/R5bC+fLTPNnTUqmsPXYuVdzYAqe4ssP5WZBTXUFPpH6j3+qfQ+MSO/SN9GLkwzhGHZrECEjH6C69LEjL8SJ6z9Eyvhbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfX0AKNk; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfX0AKNk"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6a30bcadd95so901199eaf.1
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2026 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783031587; x=1783636387; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wzsqf9gTGwcZ883+EjWafMl/QLmheDnAUcy/59Dlq2M=;
        b=CfX0AKNkR98+VtyMs+zHftNOHI6rI+iRuZ33w7BnZMBr1SBYDfAiHi5ilq0HkLdtEt
         yjb0+ROxMTH7sY4+hZRxKeSOAT+Q3lztQeflQU3+3cIxH59t9x/2im/CeSUIspb5byBq
         BxpfPJWh8yqYN5lB3ta9ho17myFvpyS36lKsoUXE4iIIkjMHJf54fj1p4TaDj1QJ18cQ
         cTR0a5teGeD2j8w3sh1iNx79EWRRQ/qKGx8lgRJL7VbKiYC3Ab5Hk4yrmIYP+ACBVEM+
         8/Ee4YsJPpHKjNhjCQ8jQWOgTc5ooLmfchsVF8+1c1MokUjHNHvN0jl/bqZ2PQCGW8vU
         Pc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783031587; x=1783636387;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wzsqf9gTGwcZ883+EjWafMl/QLmheDnAUcy/59Dlq2M=;
        b=F8H1zuamf1ggdStLznO2czklKNHTYfI9wzaIAo5g6gJhrYJ79eL77Hmn71gasuYcf2
         w7og6VsPo/Cj7PAuiNMEt5CO4kKKcorr7WXmWZgSzX3fa9oIg/XmedH9NYojC+xpcV9A
         kXaccmgQ2msV4pfcJJlN3FZ2Ps+aAhWM13bQKsSMU9PRU/zxKKzg5xnMB9PRtFqOrifU
         ytYPN2+8GyyRMZ3GlWTQuz0alMtREoyd+MugwFLJMtdWDvFV9bWat48w+QMxdlSB6wOX
         GBBiqMYDKhpdn5R8QXzoEMjaGaZxJ+weBmEpIHPNZnix2ZDs/vuApaRJ2ZbKp7TicZRr
         yhQw==
X-Forwarded-Encrypted: i=1; AFNElJ+HOYn5dJbDJezCHxvU2rUry9ibA0lpl4peHVlGQR684RM7qT1vE/vrdF8Qb0Yc/mZXNog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIH2DyNKU0BlomIAf283ey6bIsvWT5w7hKTSWBdYbF/OFJ2gy
	dMOurLbZZCvso7rkVDv+1xgpM2kUP8RJlTBP8Qn30WxW4+9HaJLWZ6co
X-Gm-Gg: AfdE7cmVILeL5Bd813b4SMUsS6tjML7nVZdSuW+ssEcAu2qftwrtxju5IqASFNZvZ4u
	nC3T444Ging0xDJJ+v2fZAyQFUM7Tqf4ARQNrhIOXpKZyqdnAqeawBK1h/q3jiaxSvRn3feJaUr
	lhJBDrJmN1n/+igcDaFBzQMM4BONAWtLWMc+BaXeQRX7RWXgBhoNvCAJmxZ+kGH5zXwWriv1boW
	69mKUjVcuRpU8EiKtrhJorud0EJ0Hh918WREnI4yRBEZwheQL1+CHtXHQUgRRKZQ0MjQ9zlI/bj
	EOMGIKmrg2UTlX3GcXlIOC+P/QYBeoZp03R9T0YHdRn/0wS7l9REP6vB73wi74UAu4cTiWRqbdo
	fo6SZtlulWhDkyr7UHV5olCUuir3ZpCHhwVoZloljq+fMz0ECiV7/sNhVKvGc967r00wiEgio6S
	nsHBe7hT1l/FizdZgvuaN4OEcdIRStxGsm6LX+yiAoscJZL8NGHPREJN2z8KJDSret1ovy09ims
	uuMtw==
X-Received: by 2002:a05:6820:1b06:b0:6a1:93a5:cd6e with SMTP id 006d021491bc7-6a31d501303mr856042eaf.35.1783031586590;
        Thu, 02 Jul 2026 15:33:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a310020e13sm3009434eaf.7.2026.07.02.15.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 15:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 15:33:04 -0700
Message-Id: <DJOFY21DYUI4.19WKQ3NPZ4H5R@gmail.com>
Cc: <ast@kernel.org>, <kpsingh@kernel.org>,
 <James.Bottomley@hansenpartnership.com>, <bboscaccy@linux.microsoft.com>,
 <memxor@gmail.com>, <torvalds@linux-foundation.org>,
 <a.s.protopopov@gmail.com>, <bpf@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Verify signed loader metadata at
 load time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>
X-Mailer: aerc
References: <20260702143605.252797-1-daniel@iogearbox.net>
 <20260702143605.252797-3-daniel@iogearbox.net>
 <CAHC9VhQD4RHsGiTMVCCTN+eB71-Ueopke8XghExpNJ2PSNa_jQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQD4RHsGiTMVCCTN+eB71-Ueopke8XghExpNJ2PSNa_jQ@mail.gmail.com>

On Thu Jul 2, 2026 at 3:05 PM PDT, Paul Moore wrote:
>
> As I mentioned previously, the security_bpf_prog_load() hook should
> not be moved.  Its placement was deliberate, and moving it as you've
> done in this patch creates a security regression.=20

not true.

> Without this patch,
> for processes where SELinux is preventing BPF programs from being
> loaded, it is able to do so before the process allocates a potentially
> very large chunk of kernel memory, up to one million BPF instructions.

only when signature verification is requested and the hash over insns
is what your hornet thingy did too.
So no regression whatsoever. Exact same behavior.

> With this patch, even in cases where SELinux will prevent the BPF
> program load operation, it is not able to do so before the process
> triggers a potential sizable memory allocation, opening the door for a
> local DoS attack.

Not true either. Worst case is 1M which is 8Mbyte.
Not even close to anything DoS worthy.

> In an effort to work with you on this, I did bring up two alternative
> solutions: a new LSM hook for the signature verification, or the use
> of the existing security_bpf_prog() hook.=20

Sorry we're not going to add new hook because Paul has
non-technical grudge against bpf.

> While I don't like to do this, you haven't given me much of a choice;
> the security regression can not be ignored:
>
>  Nacked-by: Paul Moore (don't move bpf_prog_load LSM hook) <paul@paul-moo=
re.com>

of course. will keep it and let Linus decide during the merge window.
