Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09FF400DF9;
	Tue, 15 Sep 2026 03:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789441962; cv=none; b=fDj3BSuALXTF2fSACw48gleBmPvo36/KS3w0Af7axsJKtFvz2ZGxBj2Ms+kIpznerFs06JFdcHh2kIHHtW1EJg6SF5ANgdxJ+Cko3n23WrpwB5rknFoEnLzkZwKdY55yl8qtOgLizqcY0UUq24GItlosteW4/nP6jEQ/n/xXIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789441962; c=relaxed/simple;
	bh=rR4qtcfV6dGekQxWtQzlCeu/hSyRm2X/ReDWx9bEPRA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bzXM5qgyRAhJakSuGEMDXcIr30YVYFSyIRXGbTWxb9x3PnqSNd5qFM1lmIUfI1jylJWgx7VICyeHG8jrzIzpAkYXw9ghbt4mpImr1TuV5Qeadh9K+yNXi2TjFq0i27ac25YwQsy4P/IFCwXbgAN+4RnrA0JkIehttFclPtC6R1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjmEZXBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjmEZXBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3808D1F000FF;
	Tue, 15 Sep 2026 03:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789441960;
	bh=AGyxfMY7mRLg7RdqDOpR31C+9QubzxVRaARAf48yENw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YjmEZXBg5QgDif1FxXMtiVWZOo80XjLl/zOighOcnVefl1/UOGZIRgHP2CR2IKMtc
	 ShRSbyWxoAmHy0Muxf/CKgVmkBV6ksEMhZ4h7xkYpXourGq54ORLexGB68dnPaNete
	 2gCLa2FojehG0c8mpKqCB/bwEs9oV0xzQh9PlrHtBZPe5g8sf/K10bCib004TI0FlJ
	 eh4fo2CnAM401IWO5UaPjiw/e0WJAULoioM5ny6IEJXw071d9rWzz3WDcLL5t/MuCM
	 qrqfnmXjqB+rLxjeISp35YBUUW83FZEWa3rXYZHgpCTKwElWtBNYuGREeu5dVW7nE/
	 Z6+md8oDRFq/Q==
Content-Type: multipart/mixed; boundary="===============4776717470903757029=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f796970e2e9f0e1946440afa2167290c4696293959a70d2c598f96d7a68ae169@mail.kernel.org>
In-Reply-To: <20260915021338.1520964-5-main.kalliope@gmail.com>
References: <20260915021338.1520964-5-main.kalliope@gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpf, x86: Add BPF_JMP32 | BPF_JA support to the i386 JIT
From: bot+bpf-ci@kernel.org
To: main.kalliope@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,udknight@gmail.com,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,hpa@zytor.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,visitorckw@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 03:12:39 +0000 (UTC)

--===============4776717470903757029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Select the displacement by instruction class and reuse the existing
> unconditional jump lowering, including its self-jump and no-op handling.
> The shared unconditional-jump path handles instruction zero separately:
> its start is the prologue boundary, which has no preceding entry in
> the instruction-end address map.

The new arm at arch/x86/net/bpf_jit_comp32.c line 2536:

    else if (i + ja_off == -1)
        jmp_offset = PROLOGUE_SIZE - addrs[i];

This isn't just new-opcode handling. Before this patch, BPF_JMP | BPF_JA
with i + insn->off == -1 would execute:

    jmp_offset = addrs[i + insn->off] - addrs[i];

which reads addrs[-1], one int before the kmalloc_array(*addrs, prog->len)
allocation at line 2627. This happens because the i386 JIT uses a 0-based
addrs[] array where addrs[i] is the end offset of instruction i (line 2603),
with no entry for the start of instruction 0. The x86-64 JIT avoids this by
using a 1-based array with addrs[0] = proglen after the prologue
(bpf_jit_comp.c:2088).

The out-of-bounds read is reachable when a privileged program has an
unconditional back-edge to instruction 0, for example:

    0: r0 = *(u32 *)(r1 + 0);
    1: if r0 == 0 goto +1;
    2: goto -3;
    3: exit

At instruction 2, i=2, off=-3, target is instruction 0, so i+off == -1.
push_insn() (kernel/bpf/cfg.c:113) only rejects targets outside
[0, prog->len-1], so -1 is exactly the boundary the old code got wrong.

Should the changelog say explicitly that the instruction-zero arm fixes
an existing out-of-bounds addrs[-1] read for BPF_JMP | BPF_JA? Would it
make sense to split this into a separate patch with a Fixes: tag so it can
be backported independently of the new gotol support?

Also, the identical boundary bug remains in the conditional-jump paths that
were left untouched. The pattern addrs[i + insn->off] appears at lines 2454,
2503, and 2516, so if rX == Y goto <insn 0> still reads addrs[-1]. Does it
make sense to fix all the jump paths together to keep the file consistent?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34921540254
--===============4776717470903757029==--
