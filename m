Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620053C3F4B;
	Thu, 24 Sep 2026 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262200; cv=none; b=ko88s3RtZ5BKW2e1Rn+z4FfxIEl68ic+RHvmuhg25nhrvA+pK6pCNwthhi99pQUEVitTmZyZ5zh7f78JdOXNWofYY3nPgLzIBzQyhqT6H0wV7YzGB8mpOwPXg+FB7NROF47KoxO4wuXSJ0JY53G9uazcMR5zlPkos+QfB+/JM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262200; c=relaxed/simple;
	bh=FQnSwZUmrwrYXPPavatTEU6DVMM/WNs5hDeCgI9yiH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kkgqc31DRLw3P9xsRKV0cHnoBl0Ik6Rbd9biwmrlLPum5oQY/mzPH/iAuNS/STpH3lvHBp8lQwXPpKU4TPihwFkBx86Ppcnoef1zzq4ug7kOOL6j+ua23JJ4mtbOIGoHSm7km7jhC+YLIs3Wfe8/Q6FLhs3YrbTZCFxRKYpIdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKKlX2PD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKKlX2PD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441851F000FF;
	Thu, 24 Sep 2026 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262196;
	bh=rbI3J5MByOqOf6dl+z31TMJPnlEaks35mTvEW1B2isk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CKKlX2PDopw4V/FG5N+J2hHi95G/OP+TAIXWBHQEO1AKEU0nskH8Xd1WjjBpAHaej
	 qbQrqjWXnN7jt1t6tS49pbAys1YTcSbvK8HycJpXul+v1jpuCEDwV6Gl1jN3zW0tWh
	 j48OOJ5XWAJMgPLfDUh0TbX7OVTZYtzV9gazFKBY0htB+yRccKfU9KxPbeA5fdqPXz
	 lNVyfbU2Qe9jcIVAIpz2tr5j/Ln+wA0bGihFeni+XTPzrpp8f3Jpovw7BSEciXA4ag
	 +3b7lka90+Y5U1enhzdCgNZL+kM2w7upW0UY/lDsWkhulr2X+hhjiWk7yd/zqWB5EU
	 RHrc1vZrLL3Hw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 puranjay@kernel.org
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, pulehui@huawei.com, pjw@kernel.org,
 palmer@dabbelt.com, shuah@kernel.org, guoren@kernel.org,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] bpf, riscv: Add support for indirect jumps
In-Reply-To: <20260924102938-gotox-v2-style-question-cp0613@linux.alibaba.com>
References: <20260923130856.1157-1-cp0613@linux.alibaba.com>
 <20260924102938-gotox-v2-style-question-cp0613@linux.alibaba.com>
Date: Thu, 24 Sep 2026 17:03:13 +0200
Message-ID: <87ld8qpu8e.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey!

Chen Pei <cp0613@linux.alibaba.com> writes:

> Hi all,
>
> Thanks for the reviews. Patch 1 is a plain wording fix and will go into
> v2. For patch 2 I need your input on one thing before I respin: which
> form of the #endif comment you would prefer.
>
> Patch 1, on the comment above bpf_prog_update_insn_ptrs():
>
>> This isn't a bug, but could the comment say "shift ctx->offset[] by one"
>> rather than "shift the linfo array by one"? The jited_linfo was already
>> filled in by the bpf_prog_fill_jited_linfo() call above, and it is the
>> JIT's own offset table that is being rewritten here.
>
> Agreed. Fixed in v2.
>
> Patch 2, on the #endif marker in verifier_gotox.c:
>
>> [Severity: Low]
>> This isn't a bug, but does this newly introduced multi-line comment
>> follow the BPF subsystem style guide? The subsystem guidelines
>> explicitly require that multi-line comments have the opening '/*' on
>> its own line, rather than beginning text on the same line as the
>> opening marker.
>
> I would rather collapse it to a single line, but there is more than one
> way to spell it:
>
>   a) 89 columns, clean under scripts/checkpatch.pl --strict:
>
> #endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 || __TARGET_ARCH_power=
pc || riscv64 */
>
>   b) 101 columns, keeps every macro name verbatim, but checkpatch then
>      reports "WARNING: line length of 101 exceeds 100 columns":
>
> #endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 || __TARGET_ARCH_power=
pc || __TARGET_ARCH_riscv */
>
>   c) or a short marker that does not repeat the condition at all:
>
> #endif /* gotox-capable arch */
>
> I lean towards (a): tools/testing/selftests/bpf/progs/ otherwise only
> uses single-line #endif markers, and "riscv64" matches the guard, which
> is __TARGET_ARCH_riscv && __riscv_xlen =3D=3D 64.
>
> I will send v2 with the patch 1 fix and whichever form you pick, together
> with any other feedback, so please let me know if you would like anything
> else changed. If nobody has a preference, I will go with (a) in a few
> days.

Maybe just (d):
  | #endif /* gotox: x86, arm64, powerpc, riscv64 */

but (c) or (a) is fine as well, IMO.

Feel free to add for the series for your v2:

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
