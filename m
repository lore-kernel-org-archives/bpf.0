Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF772BEFEF
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610527; cv=pass; b=NUQI3nmis30B7stxIhqQVfr0yAuOeSuGEqxYadqg2n+81keovqPnWznk4QrHPHru+sDI+bWfpxDljJSGGWh4KPf7sCmNt9dTBihgsJ6P2HuNGOCzqR9ALE76gr1QlQcrTONWdghvRbCUJRBd469gJiq1BqzylLPKY30y7t62MoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610527; c=relaxed/simple;
	bh=RlnS9GM2D1Do3rQ9pLqi2yNjdGaDFT+y0URV7WHLObk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWx9oU07KvYhIEVJ+W4RlIzoLgzgQrhc8hjuVWbYexxkj/5N2cuvGwPX93evmB7czdXl8ieV9eI0PTcrhQKvd9eZ3BIPE9+S4ffgheessQkxe+QyRKHz3R/j5XHN+dQ9Ink5AnxJ3IniWcr9zTe+FFgDvY3ghZ3IQsLzAinZi+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR6IHW2W; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR6IHW2W"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4359a302794so1829891f8f.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 10:02:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771610525; cv=none;
        d=google.com; s=arc-20240605;
        b=aDpHKVLWlNa1rUN7HAvqBu94Os8iIMZ++GRiZDBAoYYwrofCVsPAxr8o7ztIChvq7H
         h4GZJib0d5ixH/FMl13ivYU6MqD0zNa67q3O4chx3tsG9D8uogRLDi08LDjA2JQbE6Ro
         EL3o4JadYlYLaD/GvaIxbQpOVB8o+Il3mxcZtv3wwgOeJiY9+MlvortRbrl45joKTixc
         XI/PwCnWQFSS6q2avaPS8ByWK9yCXWu3Qo2cU6cPmMZDM2IvqFXfuoN6T+zR0207Ug8X
         81zq4+P4b+p68S4WHlbTiVXwFL1uC4ON2oMlJPpkPC/Bp1Z6U2tTvEHrqrkpuSj233Rm
         4vNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RlnS9GM2D1Do3rQ9pLqi2yNjdGaDFT+y0URV7WHLObk=;
        fh=BkMKMQlECH0BmFswuqi1KksooManfVinQ6QsQMEHmOw=;
        b=FB0Qn4tZ1fWqOhkWvV0yXGMRgje1EmNcBZe0b+ox42ySqwVx47SaOY/mZKWJFHxSfP
         LU+yzV/nS6Ti28XQHXDRa7Tp+AbHZsVFEHYJNySriizQ7MLhaB+Q30D+EEf0/lz5lhYd
         veekGKTXjDoM8LhHCHTe1RcLBHnWqEcogG/jvDxCffOKu/UaPQTcgLkLuXIjPjDSI6Sn
         L+AkHiYGFvpxEVg/TgqdJgyqX+ogBK3xjF2UPmgXsxeXs2hos/J7NWNBiKx9wYq9XoeE
         kU/HYDddp2wv+E2wlWOtw/QiE8rG0PzJYVLg9WZwokT4SegptJ3LeXUO+SoRpq7yJO+H
         Zx+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771610525; x=1772215325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlnS9GM2D1Do3rQ9pLqi2yNjdGaDFT+y0URV7WHLObk=;
        b=CR6IHW2WyAXGYUwZzmSNYdzaDk4kCyfzmtsTuhVMN8bdgfjTpF58oxUXLMQgWsjQiq
         Wys8jsSqrBDSQIs7u1X8Co5Vzh3KeCuirKYbYPCq5LfGupzW88bNxUoXIdZdPO0+DPTK
         S6S4SCHox7izU9DoJXZQAUuyOrvJX0qF/ryVuE4u8gWmS4Uo5ahOWL3KCTKZjv4yYHut
         J3mLMV8nshCUO7mRqsPqmDkY8WvK8FM5SmyNOLOM/yJkgHaEC3gXGV0pYETO4cik1iHz
         b07aMKzTxCiHXekmRPjNxigaS4gYKvKCyU1yamb5Z739fQeZAhkexjbUNfShXZegltts
         kaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771610525; x=1772215325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RlnS9GM2D1Do3rQ9pLqi2yNjdGaDFT+y0URV7WHLObk=;
        b=JwCu2RBy5O11fK2Y6O4uuemEvFS9fY0bUfgE4DyeW6N2pZ2Qgd0Uhot5Mz8CxYgcn+
         Zh44yzaPMpMg7fjz5535/TqCyVXKPVycmxidhHP0GD1dYGLBdzPpjUtgHInIrTmGEBFa
         hF6MzJGFeIo1QeIQi6ETTVX95v0QZGT3R4aazmXvZZvIr+vW15AD4SjG33zjPzHNEo1u
         uayXsjVHbtdyhJNu9XWNEwntD54AzOklwAcEgTecZ2r8gDEm+NGVWxMo8/6T6lT5fl7v
         h3OT9LohR2msQ4bKhmCh93LbQo5v9CNXglCPymaQxvOrkf6iQYvcIP5X5s6iAobMu8F7
         ah6A==
X-Forwarded-Encrypted: i=1; AJvYcCUrKft5Q5q3D1WSJfaPnwZRiXxe1rZUSqv67/o+e6VYVau6c9vglvIbKEBTc3U5FufNXf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/eJJn19egJvMb1rjjD2/ZPGSQ0Q/ceS1D5OEkcVKzlCe0rHPL
	0CahfbTe1fLM2cZ+lnn75AMJoqlJY12c6KzoYTJ2S01kId8n0OwU0OHemQFx9NmEn2S8DUhFLgE
	Sa9alkwZ6s897hWZUCpf53sP5hvLmX28=
X-Gm-Gg: AZuq6aK+Q6TSVvGcWwCbNmmMXYxB9ychDCCG3cyEGCJ2HfaqZQHFX0DOmgz20NLv6Ir
	zDKQkYjQPO5MKncj19Azo5rUIhe9Mq3+decwSXQ9LL2G3G0mbQG5QcC0NfiGcH+sE4yZLPLGLqR
	L+VBT6ppakiviUYrWjSosmiOwBJNlVr6rv1Tky/HJFgXwXHD5FA2uyJAWaj2yv9AIJ8yHVrlNhL
	wpzhOkevdd+Md51AJUXPBsYaOea4m+aeHF01EWXUIFJ1IyFp03Krsmtc3NbpcuvrigQi4HNEsxf
	2gXszO/9yRa5FiICbZ/MDYSTz1UYcWmkMdzjxUQGcN6nYXgqnAm7fL3I4DT1L0VAgKAQ6ss5JGr
	ljD99kcqt0vggFMoO1XL9SswLfw==
X-Received: by 2002:a5d:5e01:0:b0:437:68d5:f165 with SMTP id
 ffacd0b85a97d-4396f18f81fmr1472813f8f.55.1771610524629; Fri, 20 Feb 2026
 10:02:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <de152bf4-a168-4017-98bc-d5f64b0a01e6@linux.dev>
In-Reply-To: <de152bf4-a168-4017-98bc-d5f64b0a01e6@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Feb 2026 10:01:52 -0800
X-Gm-Features: AaiRm511z7iA54I8TmA_kvKmQWhFaG1KcZe13Seki_XTPsYnO-2wU6Y_K01Mi7s
Message-ID: <CAADnVQJwJwnwU0uOVqrdfj=n40YBNVt5HpERGw8Lqa3NtvGFdA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Recover true signatures in pahole
To: Yonghong Song <yonghong.song@linux.dev>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 8:10=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> People often trace kernel functions in order to get some insight in kerne=
l
> from corresponding bpf progs. But if the kernel function signature
> has changed due to compiler optimization, users may be confused about
> why their prog won't work.

This is all good, but what is the status of recording
inlined and partially inlined in BTF ?
I think it's a higher priority.
I'm talking about this patch set:
https://lore.kernel.org/bpf/20251008173512.731801-1-alan.maguire@oracle.com=
/
I think it should be finished first.
