Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DBD328B78
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632619; cv=pass; b=Mpa0ovUlVjg1+nfUSxh5fZpm+ZDHkaBkJFi0ZToIQL44E3WeVSPYc+4k5KV+Cu8yMgsKWd5HwVhO0gzPw/n+EChoqDaQyvzkQovWq3NjvZGVXdvVOuSmzc9OWL5jaM1kZgf1M2H8QqN/djTQOPUvOLk4uBc2DLxm85jl7K4hvk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632619; c=relaxed/simple;
	bh=T+rq7UOj7d+8qPf87RUCeDaUi1y9MEc8reKBqX50G1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsLB9Z9XBPQhD+27QsgrqZ9STt6REQQoeueE1+u12BdYDjOkNAaR4jcnoYxzrVPWwLgRsY6GQayD7JGr+hJGM2ag9mGZfYQJ9T2XKj+SUVLJT+O6pcEz3rFoiLkX0fQFNeqISR10m9mzavNq8J5nVFoe//RsyNYlzatXvO8tY1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1gJ6D6F4; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1gJ6D6F4"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9480ad2029aso75374241.0
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 12:36:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769632617; cv=none;
        d=google.com; s=arc-20240605;
        b=UzYMsGXOhAUH493Oa153nfhyH4SglWsqHgRF5GyMPIOK1Q23zRIstQdajTPK2819Ha
         Y6Wn0J+cKxtEA45zs3prMS9Rx8F/jlrnEVqMxrSLFDHeZPbJnWCZ3e7CzA4poFnAM8MU
         cASETmXtOFaL3aBUJFpGfbSorcsbbmBYjrhV6G1adP9HHX0PEOFnqODXd8FkPeAAwOha
         QlpnAa3pwCuMCKaFck1vUe7XpQzigZkQrFfRA0PzXyaE3rIMDT1vrxWh5X7iOSqm7Iz2
         3KKwFzheAgLTZUo51Af1SjuMvJevlySaMa1JHKV2bdfLyZH4kdaVyTpoidre+Q2vqFpj
         mE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SkiRjmckn2/8oWbFlJ/uLcOGnBa/tFh8Xiihp/LmEpk=;
        fh=at129HCtBLvYuOemyc8sd90VPb8ok717Q3vBPFx21xg=;
        b=CE2Hn3RT8UR2ZfuSBUVMourfJmhoZKt+RO9bjJAkk+eI9WJWvm8uSi5MMVWXUw0fOM
         rXugXQlDzj3CcNlHeH5ePS9CwkT8D+PofJ8F5T/dke22yfICBMoykaM5+3ovKb5dHu2e
         oqOhMWXaafdGtgdUnu4wiDMrA4UjjznDoPE8fPTd3JYBWCQ4gfsxMrU9+xjkm9+War0P
         3GtTJylul11rtZKgh+D/ppKS3PJsk1fewDdcoYKbt4NYQPqkA0u7pVXx+/w7I0PtUuPb
         hvzlr12eflSG+N47Aaou0xsfUIC1fuXYKCjGFAyHmeVg3CGo5a5OM2ya7zh6YHXF68nb
         RNpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769632617; x=1770237417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkiRjmckn2/8oWbFlJ/uLcOGnBa/tFh8Xiihp/LmEpk=;
        b=1gJ6D6F49aJsUPpsodSJ+Eq4lhlZIW1HC6bdE9JEMqPj0zqIQDpJ3OmZQTe8fTKQCW
         2IqDbHqUNCiT0FOaatyFJcFfboPmu6978IRPUuG/Ho0WH315WdVWEV62kJ2a1TKweAdh
         THbuSWw7eDyLAbD5IJ59CJy7DPCs2Sre00iRxl0x1MCxzKoVCBeHFI1RxWiekbBJhU+D
         5tN7B28uc26u5VhK6vQryvrewJqseY7ZbxQZKoo+6U7gReSJRSSvsYYXxf8s8fus0f9h
         0oIRPV0MDav6FkCucjwq64ko47te/lHJ0T4FvvaetESIWe4h+aF1UWm0qazQycdfAYoQ
         oCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769632617; x=1770237417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SkiRjmckn2/8oWbFlJ/uLcOGnBa/tFh8Xiihp/LmEpk=;
        b=GjdNxyAUO/bMISvijjnox9yLIl3+V33i8Ikt6j38RXfP87z5JYFtaKFv/7ix9moAuK
         CyKRpdJJmrZg1Pd6/hTPnbKKusVnyVgPz7SOTrMUkNBGh7duSPNE3thuuYOKv4zzpHU5
         Nw/D8mPUnuJrMUKCiH+uWcE+mmO3eHEEGqOP3nZydWzSAJiEcjH7yr1pIcEl5sDGErmb
         w4HF0n6is09K50wtj3MWGxxRemci5Qbjs6fukhTpdnNxR3I+ow6Aft6N16XFuju1D/l3
         Oo+EBVKMkETdEiOwekXlIO9bSuQc21x34ZLcRNaFP9RcQcjD2BTYIjdMVUz9UMk2vfNN
         KOOA==
X-Forwarded-Encrypted: i=1; AJvYcCXu+hsi+DwPa2e5Ad96sgqA4sWt8Sf5CwIUQWKftVtSC/RM0NSWtp3fWRJm7t40vF5IWnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6geleC1WmQpc9KnCGMYWJnOSNobXOXVDBFBPWKaSyEU89vIRl
	klutxQOCIJ5K61K9Aoff+50Cr7gbvatfmgH5tsoT7Hl4gTegq8j4K2nQ4qfEWpmWlnEW/uBp5rb
	sQxPuDsx9KJM50pKArH0cHntKGBlFJckA3jl7OpB3
X-Gm-Gg: AZuq6aJr0+E9dd+rDNjOLaMXnpGxgQwXjzLTgvKB633oZcrofBmPtjLZJSK7WGWQRwS
	+r8v/eIAIBjs3fHnv8H/bM22PmnL7SO+v/LYzYzRb5z3AntkIS1HE6ifDZEtUleLZjhBzj2ZG0u
	a434xFRtisECLnE+FcfIyGfHKyMvk77Hi3SwT5lXIwkoMOBs5yxOH0BQDkUrMe6IE18brP0NTVt
	Tvtj3wXCffT3RgDtBwaQZAXAEXQV9vS6+Hh1ikIP1OA7hdOyVu7LxZEZ2pzslKv91QJ7p4sTv//
	kO6jfyY6zrcur9xYeyG8CserTQ==
X-Received: by 2002:a05:6102:948:b0:5f1:72a7:f879 with SMTP id
 ada2fe7eead31-5f72378e7a1mr2305450137.28.1769632616747; Wed, 28 Jan 2026
 12:36:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126142118.2ea3cf13@gandalf.local.home> <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
 <20260126192010.4f14bcb9@gandalf.local.home> <CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
 <CAP_z_CgozbHejsuKeLRQHN-bz5jPA+C+c0GBNitgEvwOucm8TQ@mail.gmail.com> <CAEf4Bza91wTWzESxAyz5qP4e8siwGn=rvm-Few6xT_VpW9oJzw@mail.gmail.com>
In-Reply-To: <CAEf4Bza91wTWzESxAyz5qP4e8siwGn=rvm-Few6xT_VpW9oJzw@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 28 Jan 2026 12:36:45 -0800
X-Gm-Features: AZwV_QicKm5Rky0hM2dQo5VX2OWvxNVv1BVwejzondR-3e4VRt2ziWlizyXCCFQ
Message-ID: <CAP_z_ChhkA1W_5Bd0GQYpo2Vb-p-zP+Lbdp1cZw8Fr_WHQ=TcQ@mail.gmail.com>
Subject: Re: BPF with deferred stacktrace and sframes?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 10:56=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> I'm not quite clear on why blocking 53 times in the kernel before
> returning to user space matters for capturing user space stack trace?
> Given we haven't returned to user space, its stack trace will remain
> the same. You'll need to schedule task_work (see
> bpf_task_work_schedule_resume()) just once and capture stack trace
> just once. How you join that asynchronously (from the perspective of
> the point where you called bpf_task_work_schedule_resume()) captured
> stack traces will be up to you. You can send it through ringbuf, or
> store in some map, or whatever makes most sense for how exactly you
> structured your BPF logic.

Yeah, it's exactly this async joining that I'm referring to.

If the thread blocked just once before returning to userland, I could
capture a synchronous kernel stack trace and store its ID (along with
the amount of time blocked there and the number of times it blocked
there) in a simple structure in task-local storage, e.g.:

struct block_info {
    __u32 kstackid;
    __u64 sleep_nsec;
    __u64 sleep_count;
};

and then once the user stack trace ID had been captured via task_work,
I could merge it along with the data from "block_info" into the final
BPF map. The final BPF map's key is { kstackid, ustackid }, and its
value is { sleep_nsec, sleep_count }.

But a thread that blocks multiple times before returning to userland
would have to track multiple distinct kernel stack trace IDs and
multiple distinct blocking durations before it can join them with the
user stack trace ID. And the fixed-size structure used with task-local
storage wouldn't be ... up to the task, as it were.

Blake
