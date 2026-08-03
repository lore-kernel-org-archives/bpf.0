Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA83A0E8A
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786516; cv=pass; b=PdcabJihWOB9Vz+/Iv3N1ySe1aYzJWq3Q93mHfLsY0yzVNjvuSKTBxyPZBlIFI4nmyMf0KPCuoomqaiqHTocOeOygGKVKpR0IHzAztwd/gAao+5/9GtaY54sw8YdSH4ZMWU5iAWVlc2A0OT0awx8xYO8iVfO1Pgh+vVA9SLg5nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786516; c=relaxed/simple;
	bh=8uk1eqYtcP37aMfvUdzoQpZ9Trs9Os3/bWv4dhfB5nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTuSnJZ+0nZ19ObuDhDMFm/aAhWtlulTsby9QOhzF9IJcmXWBC82fQUjAsCt13KgPDJfjoNqUuHwowJdEORJ6T2F/7Xy+pvrz4pu1WajXVl0a4nOuA7FXWQIivCLPRIcUgs7Ou4b5JMo+x+sRqqtuG437yrL3ZJTFJFSKI8o69k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ27+dM5; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ27+dM5"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8485ef63b68so4110821b3a.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 12:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785786514; cv=none;
        d=google.com; s=arc-20260327;
        b=PzDCpBt0pgbyunRkYUVbXv0ho2fN+uXrO3yuPRbM2NA4ABOQDzDCBk34I4Jqkqo3T4
         zMPSYWdY26LBCsACu80BWrhDr2VchDHeDSwFIHtCbt8xiHXsfuv/GELkjna2mJuCe4Ka
         XurgLjSLrQg/1eDbo3RStpGTk4ZX7dPyTWlAfwAemD1MbULZAW5+0DB5+RzcQJOoROyJ
         TPuSoiseotVmJg0hvBkCU1Cu5QzPuElqxoRsTOP+A2HQI2bKHx+zmsax37jE17HGslXW
         ZvplygfOAPtL0NRUDBUxRY6I2k6n6AmSrPEhrxSnxG3meQTHHU7spLQ3W5tz7QfTL+4s
         Dzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y5wvfIwSx21ee7WFRp/KStftuR8cZ/Pg2yrO4T18fHo=;
        fh=wHuiVW7+cSGi8lDsjv95MnsGFVbmaO0/sJyvUF+XqSM=;
        b=J1W4aMdOUtutepIFHhq0dmzorR/t13n7Ns+2reOpZxWbQpAdIpFiIfkVNXsgsJmsUq
         ijfS8HeEjUjU8wbB5HghIvnFsnP/vwOcy7N1z3e5spVpCugiBIt5mqDB907EoJyGI9Sg
         OdBpeie783tPBcb0YBC7WhJ4ONgY3bFSSyklgmDPnjutD9Vbfja7v8wx4m9mHqU3W6c8
         dnRQ96qrpJuYzSwuABwhEzzzPJvH3/s+gpbocE2fL7DtgC5ZprPIBGTHbqoXcF5emcQR
         7G11a/lzSEMFAO0u7s1czruvF/vjx/M5qgxKkFyOclxFTyXzGEGI+KWHde+or06dBCbF
         /OcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785786514; x=1786391314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y5wvfIwSx21ee7WFRp/KStftuR8cZ/Pg2yrO4T18fHo=;
        b=OJ27+dM5PoW9Roe7FnZJgHRT9O89S3GD40ZJLUky9Z8vQzdE9Bs8e0+tUJ5rHS1nou
         +tlmXzDwQ+mWraklUCFOqfl41uduDcv/MO78itRWdWyxi4FJGcpMI3yrwuqYjH7GEZEA
         EE8N3oW4JiUxWLQ63aWkVZmhnRM6MnLri9fYKktvavAlz0Hie7meF0Lk0EVJDGQFNrp7
         0evyP4TEQopVzMWx572Ginhl6Cuem22Iz/n//xETMLkK94R4yMaiYEijtx5HNmd0xQVq
         1rWYWs15hmDshdE0Hamybav7xxmnbGtUNQeOvdiv1waJnNipRAqfha8BDBQ/1ORhANLq
         aVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785786514; x=1786391314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y5wvfIwSx21ee7WFRp/KStftuR8cZ/Pg2yrO4T18fHo=;
        b=TFlY3pHy1xW8qogQvUcGZYji4nk/5rE2QWOEyjmcrYXSu5bgYDc+Si/cnwNdyZ9nJd
         KdEAaId3GmsaSxbiDfmypugL5xFF108OaIvHD3hKAfvlr4GSNPqh9Z3YTVki0+Si5IbS
         +GTJoHD5EHaNBbbtSRSDEhSIEol915BXbXoTzSUb8eR0Wf2XfCLL5NciW+mgV3IeF0q+
         IWXFNRhsPXhFuNbLF4xuu0yGCKN77iJUOEYYN6NLDNHZoOF8GHB3kK4tywX94LCqBoQ4
         YukUmG0PJO9hIRK2KUHwVI+YLYArc0AlE0i/H8OMGROR7yRfZksQezFKep15Q0wQWr/8
         Zg7A==
X-Gm-Message-State: AOJu0YzjXsCKEh8oaVQJpLTrx5mZejtbJzEKkppqyPM+WfizUcc5Fnv/
	FQjcUaTkdekj/AyGM31aVdrOauLo4ievnUMJHpJecXFV7bZZZZFeDJ+2oQXi00CJlhKcA6z4T/F
	kS1QWZeqbnWpNqzL0DdyDHmWALeCutHEMT4Bk
X-Gm-Gg: AR+sD10BoDRmD11M4rVd4WCp4A0w/V50iTI0hbuMC8+T1j1dkG+1r44bfIO2kK5NJ2r
	PlAgRfYNOmkaxh/DwOH73rK0qvBnpj2TJBwHu1uOK3L3WXVUzytptnPgSin9rPlFmJFQxW+0g0U
	e9aLEp1tJgWNJwShaBXtZsPYLXoIm0s0/P9jado6hegm8NfzVET+SQJHQyPpBH2gxoAOWw5l2FG
	FwvG+ZNJQhDNR6Kt72WK0ujI2uvCvMmj90WlZUlCpEgYqa9xbd6Ilx9h5rtN6T+WbeQacNYQ3vS
	m4PmZs8hjJIfR+qnkKK7aJD4UaWYGvPgWpWufARHCx+fiPZqXzEhmLM3QoVriIUCzKAd3zJEkts
	nRFdhernnofVuZPGxeRHpYKQgM97zt4nLwSkZyCdWGA==
X-Received: by 2002:a05:6a00:9283:b0:848:19f6:4dfb with SMTP id
 d2e1a72fcca58-84ee48ca014mr10039301b3a.56.1785786514228; Mon, 03 Aug 2026
 12:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803072733.191502-1-memxor@gmail.com> <20260803072733.191502-2-memxor@gmail.com>
In-Reply-To: <20260803072733.191502-2-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 3 Aug 2026 12:48:19 -0700
X-Gm-Features: AUfX_mxjq3rbD8MM9D0mIhzRyI45pmcTSkXAOixNqeDfilVk_oo99C80J_EvkRg
Message-ID: <CAEf4BzZwSogfspAQG6M4X5V4P+=-W1_hV65+6vpTDy5aaVYmPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Show more useful info in stack depth stats
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 12:27=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Currently, stack depth statistics are too crude, listing captured depths =
in
> subprogram-number order. Since libbpf determines those numbers, it is har=
d to
> associate each depth with its subprogram name.
>
> Print the maximum stack depth and each subprogram on separate lines:
>
> stack depth max <depth>
> stack depth subprog <number> <name> <depth>
>
> When no subprogram name is available, print <unknown>.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 13 +++++++----
>  .../bpf/progs/verifier_basic_stack.c          |  4 ++--
>  .../bpf/progs/verifier_bpf_fastcall.c         | 23 ++++++++++++-------
>  .../bpf/progs/verifier_private_stack.c        | 15 +++++++++---
>  .../selftests/bpf/progs/verifier_var_off.c    |  4 ++--
>  5 files changed, 40 insertions(+), 19 deletions(-)
>

given we are going for quite verbose one line per prog/subprog format
anyways, let's make it actually even more useful and emit
insns_processed as well? I'd probably keep total line (processed N
insns (limit 1000000) ...) for backwards compat, but also have
per-subprog + main prog line with insns stat and stack depth,
something like

subprog 1 (sub1) insns 123 stack 16
subprog 2 (sub2) insns 345 stack 32
prog (main_one) insns 643 stack 64
processed 9999 insns (limit 1000000) max_states_per_insn 0
total_states 1 peak_states 1 mark_read 0

wdyt?

this will give better and more targeted information on where you
should look for w.r.t. verification optimization opportunities

and we can later add some other useful stats per-subprog/main prog as
necessary without any major breakage (tool just need to assume there
might be more stuff after "stack N" eventually

[...]
