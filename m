Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0AC42F712
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374110; cv=none; b=V5ELkuz6dJ+6l0L/BaRuUf4Yc6uSqE7DuaveXchQx11rB75a2izAfaKgZ5eO6BikoiLOPuRsonPdxnOiTEA246GWcmHHK/okHVQ3gTOpR7z43zK7iVzm1XtNpSd7VT54FAfRPYYaBSdlWdDp1J/oUNBaxf4uXt91BD8iZL4GtAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374110; c=relaxed/simple;
	bh=+zlMuA2f63v5NWpjsw4zSCanE6j88FQ9OFKGCMT/pr8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IwHmfRt6pONLUjybsJljoReHX3KButDR8+x4dOZWOWDjUE6SK+WHlAF6nGbyOIRE8e+4GX9tI/fyDEuO/4EXtFrwqhmFKlMmhiZCLBwdKNXnXjUO+aP/ECphZ+g9YcuPH7d+ZodU1WpTzgf6pq/yBRuN+P/gonbWm4s9ZHFkjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbSEW43e; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbSEW43e"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381891a9525so3236394a91.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 14:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783374108; x=1783978908; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+zlMuA2f63v5NWpjsw4zSCanE6j88FQ9OFKGCMT/pr8=;
        b=YbSEW43eA1z+271o7PfrKK+pq+7klwmvcPWU8umS52VlXAyoevxDAcq7gDXNuWvx9O
         GKejDwYlQ/ODv/dl3CrZiYuWWAI+Oe+gh/A7cut4y9LrYm6MsjS5KQO63xw8+Gk/p7WW
         J2cVZ4NGmZGAPp7skpAN7P6IiS7nFyl8/J8E9rzzb3uKwMJa+QjrflA+tvDwyefAxhLF
         j1hOUwR+4QdUrdMeirfVAN/NMHuIKgv8Nwinb0F+N+GzH8oo/gQv+AOqrQAZTEzUh44p
         HTm8TG7B+V/RfhUWVZH7vqg415fEu9cd6RMXfzNWbAk3ayTwKIo2OnyEjzo/7vGA0t2v
         ORyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374108; x=1783978908;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zlMuA2f63v5NWpjsw4zSCanE6j88FQ9OFKGCMT/pr8=;
        b=M6MmSMl0ogopwuTavf2qTGoDtVQ2NGkYUW71xpwSXOzeS/ZyZTxytjTZOFUYb5nmfP
         NCZWd7y/rqydZ73VihVws5frFvlJhWtPxcpTuIjO/Q/L+fb1OIbQ/vdpJUBXiAOTGHcB
         4Y4T7x4+M0IEdPPZNcvG7Kjq993D3/e0KnqmbofGqKMY0NoX5ObXUjUXyt3WrAh+vkr8
         xXknX+l/1HvePag8FQhJBZsZtDUfl/IztqxB745Crpkd289U5FbOvXruyrUEH4Al5OQY
         D5IPoJb+Hn2RQzpPlpRfPqTD+30M+vo4vhXOmhRfG8WwDJU5KIoHEr5YN7ErfKHi7/cm
         QMbQ==
X-Gm-Message-State: AOJu0YwrBLYPH7h16uAsn9QUnNsOgF1HLD1avjtJ5ohzUGm9k2q5mLVp
	MqZqChUu5/FK1emlS7Awg3hxmUMSmNFt6hV2ChB89T+LofVLp7z7d0XR
X-Gm-Gg: AfdE7cl5Bv8yWOWmuQCjQ4mwkPhpOXQtC3vVlHNq2eMKzOcpcyu0nqoF5RP8ldw3HkV
	zlYkJEqw8EaDgQfZFXGnf193Ah33TEhC8t1qnZl4TaAA3YTLBlEWf3u/y8z/2i8sW/3wUXGI3wq
	e1a+aVw0StQFx/jC1Vk6pql+j6LTfAiNS6nKcC6j6JOmq0QTj8ES6HtN5Vh8+DU/6W6vl+Cb8K3
	2u6GJOyPbBEj4YgYCAxLPt9A+PTe+8YT9Mo70j2X+i9qhxz5wBtLgptRjGAxiGVWvUZxN+6VF/Z
	eYgCYUkavsEsIIYawpJ+P460ETCRnpJS6fiJQFjkQowZ6YdFOMl/dnmCSfB55qM2kmVj67W4sNA
	lsa+GM4Lw6Xnj6q26pEMryRj0jZ7iGsWyddLaNJbm9JoI5tZYNoo6vk8iyMP9ngVbfut3iddyVW
	ERBKu8VMFzaqmRwNJCfCTRfPSJPug7Sa/U0VM9t6DR1xGNTSc6jJFF+r9V+6THhI6gAXBldA==
X-Received: by 2002:a05:6a21:e8b:b0:3bf:b931:b3ec with SMTP id adf61e73a8af0-3c08effc8c8mr2675609637.57.1783374108056;
        Mon, 06 Jul 2026 14:41:48 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:612f:7084:be32:532a? ([2620:10d:c090:500::1:55b9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483e0a2sm587541eec.12.2026.07.06.14.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:41:47 -0700 (PDT)
Message-ID: <abd697d839043d80e0230d2b9ab30b214dfa34d7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v8 2/2] bpf: Reject programs with inlined
 helpers if JIT is not available
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jiri Olsa	 <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, KaFai Wan	 <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev, Leon Hwang
	 <leon.hwang@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=
	 <bjorn@kernel.org>
Date: Mon, 06 Jul 2026 14:41:45 -0700
In-Reply-To: <20260706040006.10331-3-yangtiezhu@loongson.cn>
References: <20260706040006.10331-1-yangtiezhu@loongson.cn>
	 <20260706040006.10331-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-06 at 12:00 +0800, Tiezhu Yang wrote:
> When an architecture (such as LoongArch, ARM64, and RISC-V) implements
> bpf_jit_inlines_helper_call(), the verifier skips rewriting the helper
> call offset (insn->imm) during the bpf_do_misc_fixups() phase, because
> the helper is expected to be inlined by the JIT compiler. As a result,
> insn->imm remains as the raw helper enum ID.
>=20
> However, if JIT is disabled at runtime (net.core.bpf_jit_enable=3D0) or
> if the JIT compilation later dynamically fails (e.g., due to OOM), the
> core BPF subsystem falls back to the BPF interpreter.
>=20
> When the interpreter executes (__bpf_call_base + insn->imm) with the
> unpatched raw helper ID, it jumps into an unaligned invalid address
> space, triggering an instruction alignment fault or a memory access
> panic.
>=20
> Fix this by setting 'jit_required' to 1 when helper call rewriting is
> skipped for JIT inlining. Loading will be rejected early with -EINVAL
> if JIT is disabled, or safely rejected with -ENOTSUPP during runtime
> selection if JIT compilation dynamically fails, effectively preventing
> the kernel panic.
>=20
> Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Suggested-by: KaFai Wan <kafai.wan@linux.dev>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---

Sorry, I'm late to the party.
As far as I understand, the patch #1 doesn't really change anything functio=
nally,
it just adds the flag, right?

As for the patch #2 and looking at the helpers that jits currently inline:
- bpf_get_smp_processor_id (implemented as a function in the helpers.c)
- bpf_get_current_task (implemented as a function in the bpf_trace.c)
- bpf_get_current_task_btf (implemented as a function in the bpf_trace.c)

It is perfectly fine to call these as helper functions even if jit is
not available. But this was broken since:
2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
from May 2024, so I guess nobody really cares?

Imo, the simplest and least intrusive fix is to add a wrapper in the
verifier.c that would call both bpf_jit_inlines_helper_call() and
check if the jit is enabled and use that wrapper instead of direct
calls to bpf_jit_inlines_helper_call().

Anyway, since this was broken all-along, might as well land as-is.
Thoughts?

[...]
