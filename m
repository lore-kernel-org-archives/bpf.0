Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D17503BE6
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459125; cv=none; b=fOoCMUUlhAi+orgMiOgyNJyT82V0jr5i5j7V+ZsMnuqKKkkxhj+0illZXT9Oupsw9PS/q+eQBErGDaBxcIUIicpxnF6A3WAa1rt7euvMuFHZHbTfJOpr1iZAVEapIlPvT/36/3wtK3rgPByNg3LDzyjZu+5t52eObaTGqHtQ9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459125; c=relaxed/simple;
	bh=JaAIToqJe/P3pIrQXtRbjZu6nKRueJFYXuA4sBKvDSc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OT2hNQwRKnnLJAeC8M1CcT+IzV+GMHwcTfQrXzi9WoAip4Y3J9plB6uEY615eqoc8ep+AY63L2UzjdEvhpX9Fw0I7Qy/2NoybWHdW/bTzYxIN87VLebi4P0oaG0qqmiENEsvq8+pgnUSLAR29hPqYxQ3ywqYZ9T0LubxYvFnJ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKNHWHoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKNHWHoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D071F000E9;
	Thu,  3 Sep 2026 18:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459115;
	bh=dCPhqnaktmyNKbjRwCvFj7pUURr+ZP1R6v7oLe6bz88=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PKNHWHoCPO17cLOuNa/H0ESVl7GMeL3Ubn0iGxg+jC6FG5bo/7fLaNNCPHAARjbKY
	 tfVbvLNgzUwVkeALcBY1nBdWO3iqD0UTHl30vkmGnNPUp4Rakc4un2OMELhZa6qM7F
	 HMD3Ni1r/NcjgPIezbB87yMu1qtp2qYrV2u3WasfE+ExxsPid6mhXiCGC/CVzgzckv
	 2kl5/X7WMley2rD9d9ERuMUt8AYKCWj5zirQOFx5I4Cy1NGlTLnCFT3FMS4mu4/tIV
	 ayEBF50NCTUkbGzMauHCdM6CTw8Jfj7GddL9z9eQ9lufDlRfdU9HS2MSwFu96B8iI2
	 lWEy+8fP1rRtw==
Content-Type: multipart/mixed; boundary="===============4746331264557210915=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2ddb3272d086e995630c56ed4c2cc2cdec75debd5fff9c10cb0bfe8c0fe664ef@mail.kernel.org>
In-Reply-To: <20260903171542.1438050-2-eddyz87@gmail.com>
References: <20260903171542.1438050-2-eddyz87@gmail.com>
Subject: Re: [PATCH bpf 2/3] bpf: update disasm.c to print BPF_PROBE_ATOMIC as atomics
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 18:11:54 +0000 (UTC)

--===============4746331264557210915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: update disasm.c to print BPF_PROBE_ATOMIC as atomics
>
> bpf_convert_ctx_accesses() rewrites an atomic on an arena pointer from
> BPF_STX | BPF_ATOMIC to BPF_STX | BPF_PROBE_ATOMIC, this patch adjusts
> print_bpf_insn() to print such instructions as regular atomics with a
> 'probe_' prefix (instead of printing them as BUG_XX).

The changelog says the instructions are printed "as regular atomics with
a 'probe_' prefix", but looking at the implementation:

    const char *probe_pfx = BPF_MODE(insn->code) == BPF_PROBE_ATOMIC ? "probe " : "";
    ...
    verbose(cbs->private_data, "(%02x) %sr0 = atomic%s_cmpxchg((%s *)(r%d %+d), r0, r%d)",
            insn->code, probe_pfx, ...);

the code emits a separate word "probe " (trailing space, no underscore)
at the start of the rendered instruction, producing output like:

    probe r0 = atomic_cmpxchg((u32 *)(r1 +0), r0, r2)

rather than:

    r0 = probe_atomic_cmpxchg(...)

as the message suggests. For the fetch/cmpxchg/xchg/load_acquire/
store_release forms, this also detaches the qualifier from the operation
it qualifies (e.g. "probe r%d = atomic..._fetch_...", reading as if
"probe" modified the destination register).

Should the changelog describe the emitted "probe " prefix, or should the
prefix be attached to the operation name (probe_atomic_cmpxchg,
probe_load_acquire, etc.) to match the message?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33784588558
--===============4746331264557210915==--
