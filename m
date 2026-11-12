Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794511490;
	b=fEijlEm9JmD+HF9czs7TlCYYIGDwICHkAmIK1O1qFKv5WXDSMbdl9zJZoVBEcHuMaMFh
	 wpHczc7qaAo/zYz3Inlb1arq8uRw//5kTnbiBbeDSw6I1vS4+r8thLeMUZuv2PW7Lsqin
	 qFZ7xbDKpA15Qn+WJR7+BpZufjOfH+m0q9zzwjiEeYberFT3qqTUAjL5S7T5p2miC0AzS
	 v9uM2ea2LHsMd/1bGsTShGx8J9Cd71/vnFSEFm98ttWJNeHakKGr13BnlGtiMSN4p0wDt
	 AOBUtE2gU5oWEnld8sRnVSarocJPsX0QR4wXnKnaiE0GlqomAP2wlB1PnFQygBQUgoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=jlygkzaiytXLTgXwrjQaRLpn1zirXNFAaFt+aJvGZ9Y=;
	b=LiWNgBboLf1IDvgx/PmovKwvCUqLpBYRZzQOjV2PRxxChfb1Wc6S7uAV8H6vn0M9JRgT
	 4+jH4Q1/VyT1aEi0NPNoOQxLXkgqJI98uahzYcsKLYaEJiBsF40fWvrNB0XbL4D+1y3Bz
	 Bm1BVzDBvLwecMemZajMYXltMiyhJZUxjByShT0npZsWtk6KfQ9BXrgeKM27TOkmCl31T
	 DGhlf53dKO020/oNRqy4JTzxA5sepEtpOREKGefUQhQMicx1hQAFtEh6xkD8IETUAfUZ7
	 MBphfeFQSTrtZDEZWhH9ggwnDp+qySB1G2mC/Yi2u0glu5XVar+jsPR4YpCaKFgrNNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=YQikDXDn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6173B606A893
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 19:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6173B606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=YQikDXDn
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a052288e41so2110b3a.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 11:24:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794511489; cv=none;
        d=google.com; s=arc-20260327;
        b=m8rwJoV8SCf3eCtkUTJ/5VpkL0RKeapti07ILv4j11n5qeY6Cy0YpLMC1enoDCRhBw
         fJH02NTltvHlQhvGrwEvS+1TevcpQ2mdez+OQu0ZuuBnmzdr7jZ7PPIWphbIF1hSa+QG
         c+D1fQ3OHMOvsGIK1bEwwXjhEOXhuulCJh/IqOSbkLU3pjApaeAbwUQHTxfcX6SZussE
         2s0KNb9Q6s9Hpb5SYJNZ5dcEYIyCJQf2ed0eU1OfammNCLLzIM2XVBDqU+TGwf2RJP0K
         adCMlJjw5lmudHjd/0tN9BOBj9jYHmIUKuWwwNnZLa5wyfB6d3wMbF1d8HgWlNKH2YFj
         CQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jlygkzaiytXLTgXwrjQaRLpn1zirXNFAaFt+aJvGZ9Y=;
        fh=mf5EVZun5581mPQ3B6XU/k1UuOq1dtpbkLbT0av5AvQ=;
        b=nw+oc5dVe02odtsNr76xFXBq3PTK3ua7aIL3Hw50ealoDYQmyKulBAurU5DuryDuHE
         YkOiwC4TgnUThe4h+OnUkAv2cJRI2Y0BDUAtCSl/UXgDTolDCDPmoS+1xfAeTHQknyXl
         Bvu8hltkwHYd/+jqfyi2rawP+0Nu3qb1TdkICuAA4S3UeyoFbAyZhV5Ow4rX+QZ+S8t9
         6OfUZO7ull1u6RKnuYAk1ICFfNMwGv8H9fjVJ0s1593iV/9/ICuV/rP8xmscLd4T2VGR
         uFKFSERE6OaAIZ1Tk1N9IbsxNlD5aEAvfeWPAXRpeCCeAaakbI4VSGC50BJN/FNZAK4o
         ezGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1794511489; x=1795116289; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jlygkzaiytXLTgXwrjQaRLpn1zirXNFAaFt+aJvGZ9Y=;
        b=YQikDXDnkcXNSoppt0sTKONosWFPIbhd/LmeG8Bbp8TUsqZzeSNXv1AZw0SCqyHP69
         zxhZlkWGWOCikEGCKQF6poLCuTxFwnb1CeYYXNvrDr6Ky+eAXsaI5gYneSmFpyRtz4Ly
         DVWNnMo+PfYfBiMh1AjdstdZIj58YuG+jCvSpSu96HYt9+yqle+LwYqP4paX+Cn9+m+7
         vdpovau1a3G4WJbl9brgP7Qn2duB8fEFz4TFO6lQIXMB2+uYVoGFxNgeJgim3R0q2225
         cudwhQZLNxK7969rLcScmJGGc8ryJbks8ZvGNMYDxCfHafF0/jcXiuzDkzM3zyF4NII0
         NzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511489; x=1795116289;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jlygkzaiytXLTgXwrjQaRLpn1zirXNFAaFt+aJvGZ9Y=;
        b=wZOgAoJmtLRchqDtnKNdjESf7KZR5WFl6e1mMnBswyiLAhZxynCY+dUkxBSLIGZm50
         MzDeipqVmdmFg0K6wNezEtAgdEYx1hH+Us3AMjNtZVj9rJ3OO4GcVbCrwN8BTdw6fhMq
         wJcUR5fkf3r/81JFXQQWFimbMBXaZV3VsxFFgF+mUoAyZijWlBu0cwkO6WQyS13Ii40h
         eBw/VJcsiJAqvCrHJW8zZc3p9Ama89h3IoFiv+VgG6F7IeeRF8LxTtxiYNl2WXNygQoz
         +2uhujL/jwSwIyj4rKP7rz6MKOHCJwMmKI4QTvfv5PNmC9454AoMkYAEV0krtI/sMAUW
         2CHA==
X-Gm-Message-State: APuU4Z8FRPOEnEKGrHez2Jc6OUOZc61GMM96D/LcYcMwZTu4jV6RLpq0
	F2wSi8VCc437US0A9N9iPUSNSGLmXBaZXpPbHYzGFVYCCYZMhP+AdoDoG2tCIBDjYmrsY4EFyn9
	Aq5qOSxPMjlm8iCPepqfEW+QCNzOEQKtIFEayhUt3wg==
X-Gm-Gg: AYBFou2kPV0p6Zxod4Qllp5MZH7qmNZTuDI9yL69YnwDCg5vaB1BPgYrzCE6ENH4fvT
	Q8eoyYjlyUhDM+gtKv+usEo5FSOtqC8bufcTRxvKnURFB5MZJMWneVVWjtXkHuz1PfS9pEd+fNL
	w+Q06Q83kZmqN/v3bV3YXGR2dTJojyb3G/9xImcQFqBkQQmU5qDhapYhBlinnYmcF9UToyiwNTJ
	Buu1MsdJa7Q7DImT4dZVgo6I/e5+dEy8b3vaPhaNozkcYT/Sm8WUDKnfpiNTAdSD/vTVxmm46HC
	F1DTwqAmjjLrKUKlplbPGg86YrOd/0vH6LocmZmqJpKnWplg7xCBzNw5ZLYiOG/hmtgW+UtLeJJ
	Lkdq09OFcb/UWFgDrQZ6l2DavTkl8kirpXw==
X-Received: by 2002:a05:6a00:3d89:b0:8a0:92ec:5f1c with SMTP id
 d2e1a72fcca58-8beaf2a4d6fmr712148b3a.0.1794511489473; Thu, 12 Nov 2026
 11:24:49 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com> <DMSU4S7392QQ.357Y29RMDZ8BJ@gmail.com>
In-Reply-To: <DMSU4S7392QQ.357Y29RMDZ8BJ@gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Thu, 12 Nov 2026 21:24:52 +0200
X-Gm-Features: AclHuK-ZDEUJCai-MX-vK2KnyCinEohrdaF3lHXe5jxxeIvqToo4i-MZUdaZeSs
Message-ID: <CAPnbwjrBnhnJt7BC-QBEJNh9Jp3bP7WXVnT38mLv9txFrftcZA@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v2 0/5] bpf: Check recursion per
 task for preemptible programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The link walk doesn't look too bad,
> but pls share bench trig-fentry/exit/rawtp numbers.

Got the numbers below, bpf-next 0fb18ce8a2e9 with and without the series,
x86-64 VM with 4 vCPUs, lazy preemption. Each value is the median of
10 runs of:

  ./bench -w2 -d12 -a trig-<x>

  (M/s, median of 10 runs, min-max in brackets; non-debug kernels from
   the same config; bpf-next #2 is a second boot after the series)

               bpf-next             series               bpf-next #2
  trig-fentry  39.71 [38.75-40.43]  40.35 [39.74-41.12]  39.75 [39.10-40.08]
  trig-fexit   35.67 [32.67-37.56]  36.70 [33.26-37.79]  36.56 [31.69-37.60]
  trig-rawtp   41.07 [40.43-41.73]  38.15 [37.78-38.87]  40.30 [39.86-40.92]

In these runs, fentry measured about 1.5% higher throughput with the
series. The fexit difference is comparable to the variation between
the two baseline boots.

raw_tp is 5-7% slower, outside the run-to-run variation. Its run
context is a C local in __bpf_trace_run() that grew from 16 to 32
bytes, and bpf_trace_run1() now zero-fills more of it, realigns the
stack, and checks jits_use_priv_stack, which a raw_tp program can't
need after patch 1. I'll try to trim those and send the numbers again.

> Maybe we should do a per-task array of progs instead to detect recursion?
> It's likely more cache efficient than link list walk.

I think it would bring a different set of trade-offs rather
than a clear win:

- I believe most of the time the chain is empty, so there is nothing
  to walk and an array wouldn't save anything.
- A fixed-size array would require choosing a capacity and an overflow
  policy. Its setup cost would depend on the generated code; the extra
  stack initialization in the raw_tp disassembly is a reason to check
  that cost.
- The chain reuses bpf_ctx and the existing stack-allocated contexts,
  without a capacity limit.

do you think it is worth doing?

> A prog with a scratch map of its own is correct today and
> that's what plenty of production bpf progs use today.
>
> This patch set will make them send corrupted events, and nothing counts
> this corrupted events. Today, at least, you have a miss count.

 agreed, can we consider keeping today's per-CPU guard for
 the programs that depend on it?

- programs with a private stack (as in v2);
- programs that use timed may_goto;
- programs that use per-CPU map values: lookups, bpf_this_cpu_ptr()/
  bpf_per_cpu_ptr(), and bpf_for_each_map_elem() callbacks;
- programs that can reach a tail call, since a tail-called program
  skips its own guard.

Only the remaining programs would get the per-task check. Extensions
(freplace) of raw_tp and tracepoint programs still need a rule.
Preemption-disable, as you suggested, could later remove the drops for
the guarded programs as a separate step. The commit logs will spell out
these trade-offs.

> With the link list approach every B gives A 250 ms more:
[...]
> So the promise of may_goto that I just fixed a week or so ago
> will be borken again.

right. The proposal above keeps the existing per-CPU guard
for the relevant programs.

Thanks,
Mike
