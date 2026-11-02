Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606012;
	b=hRnv1DLyBvhgy5bdyJt0xqYKxP5nByFJGIb2fNOJ+PSlfq8TcFmzOcgyB3jzJX0Tlk2Q
	 +4J4RWRPslZIoO9d6U/aE7tuNqGeSHHkXbtkyWxjJ0icUFDqLne2bz7znCVYQC4Li7JhA
	 kCvr46yfShIsXTX4io1BDJ7N8QAQjafvHX3XLl/F/f53woLm5TqDwL7OaNHrE91mpzVkt
	 0XjGW0UnyZv/2HnkxIFVpNSxOndePdGo2jTbxWQMjv4H7fY/8TeDWXENl0fChbS8lnU3J
	 AUfj/ZNxX5Z+sLCwSB68bA1q7/tdbStl2yscIh9bi8Hv61BntLzW0RJJWMrNb17ymNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606012;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Luo2bAX7yeRQwp4e4M++8eGqx6UvBaGXA7aY4b+XOzk=;
	b=HGwtGGKTV0Pqa6YaGDFYdApQnr96JbUrGT5WhSwypkcAZVGkjXpqGIrxjs/tnIpEdt/l
	 M/2fDRdHmPEagp3A26vRLnbVCfBx6TRHOFnFX99VudnIE3gLM+Y9Ie4ZRG67z1TnACUv4
	 jUOLN+16le3nK8FncaACQ717TYog1bIga7gzGJpoD13ck6KameUySXNPjyxtbxmSncuGv
	 p6C5QGV5st/090WrilsOU3EizX3wX6Mu26VRQ9XAPq6BiqpaFskrd4Y3q9o/8vKocUr2m
	 EbMxmieG2hlNgeBWLjj2pJzywGYydyY0xhIp6oouQPgJHraI4R03Y+g41rFA2NarXXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c1a/i3zB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A20606A324;
	Mon,  2 Nov 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1a/i3zB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC321F000C1;
	Mon,  2 Nov 2026 07:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793606011;
	bh=Luo2bAX7yeRQwp4e4M++8eGqx6UvBaGXA7aY4b+XOzk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=c1a/i3zBzv4fFytx2Tkk706g1Ui2r7930b7gIIWifBBmlR+NYx18RTi8xwlcYw/I0
	 jGBaBi+etZyNUchMDySNWG6Rl0ZIHFLgAhd/qWC2JmTBO73CXGH68/vDsFBVb36XGp
	 qv6O4hPpOJGzc5tSUNMDvu5nPNqATwzqqTq35iIPAZtjTGu9J+128wLGpYu17DB6ro
	 4O2n0FfrkEjRXewQzHQKmqFsaRQxGdqAxb8B9++ZKe+OBmFTZBzGKrJy/XkVlIOMva
	 AuXEflVxPhYGProcLaqF9dmsPhXbv9zoS7U6fYWjRCY6Qz4M//m/Ca7azm73lrNb4+
	 80tctmXBuZnyQ==
Content-Type: multipart/mixed; boundary="===============8188945401036519252=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c3b8e6ae47164ab1a643a1730f0600993de03c8a30e35122a9812ac73d807697@mail.kernel.org>
In-Reply-To: <20261102072808.23080-3-yangtiezhu@loongson.cn>
References: <20261102072808.23080-3-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v1 2/2] LoongArch: BPF: Use beqz and bnez instructions for trampoline
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  2 Nov 2026 07:53:31 +0000 (UTC)

--===============8188945401036519252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> LoongArch: BPF: Use beqz and bnez instructions for trampoline

TL;DR: Commit message only: the claimed branch-overflow risk looks impossible,
since trampolines fit in one page and the old code behaved identically, so the
Fixes: and Cc: stable tags may not be justified.

> LoongArch: BPF: Use beqz and bnez instructions for trampoline
>
> Currently, the implementation for BPF trampoline branches does not match
> the existing technical comments. The code uses larch_insn_gen_beq, where
> the comment indicates beqz should be used.
>
> Moreover, the beq instruction belongs to the reg2i16 format which limits
> the jump offset to 16 bits (+/-128KB). After using the beqz instruction
> which belongs to the reg1i21 format, the jump range will be extended to
> 21 bits (+/-4MB). This mitigates potential branch overflow risks in the
> complex BPF trampolines.
>
> While at it, also apply the same optimization to the bne instruction by
> replacing it with bnez and adding a corresponding comment.
>
> Fixes: f9b6b41f0cf3 ("LoongArch: BPF: Add basic bpf trampoline support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

The commit message says the new instructions "mitigate potential branch
overflow risks in the complex BPF trampolines", and the patch carries a
Fixes: tag and Cc: stable.  Can a beq/bne inside a LoongArch BPF trampoline
actually go out of range?

bpf_trampoline_update() in kernel/bpf/trampoline.c rejects any trampoline
larger than one page:

    size = arch_bpf_trampoline_size(&tr->func.model, tr->flags, tnodes,
                                    tr->func.addr);
    ...
    if (size > PAGE_SIZE) {
        err = -E2BIG;
        goto out;
    }

On LoongArch PAGE_SIZE is at most 64KB (the 64KB_2LEVEL and 64KB_3LEVEL
configs), while the beq/bne reg2i16 range is +/-128KB.  So no branch inside
a trampoline can get near that limit.

bpf_struct_ops_prepare_trampoline() puts a single node in
tnodes[BPF_TRAMP_FENTRY] and has no fmod_ret branches, so its only
conditional branch skips one call sequence.

Even if the range were exceeded, larch_insn_gen_beq() and
larch_insn_gen_bne() return INSN_BREAK, and validate_code() in
arch_prepare_bpf_trampoline() would then fail the trampoline with -EINVAL.
The old code could not silently emit a wrong branch.

The old and new instructions also test the same condition:

    larch_insn_gen_beq(LOONGARCH_GPR_A0, LOONGARCH_GPR_ZERO, offset)
        -> beq $zero, $a0
    larch_insn_gen_beqz(LOONGARCH_GPR_A0, offset)
        -> beqz $a0

and likewise bne $zero, $t1 versus bnez $t1, each replacing the same single
nop slot.  So the patch appears to change no behavior and only makes the
code match the existing "update branch with beqz" comment.

Could the changelog drop the overflow-risk wording, or describe the change
as a cleanup, and could the Fixes: and Cc: stable tags be reconsidered given
that stable-kernel-rules requires a fix for a real bug?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41407991756
--===============8188945401036519252==--
