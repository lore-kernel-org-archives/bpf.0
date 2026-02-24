Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7DB1A0BD0
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771966915; cv=none; b=GOjSbanOLLtCOdj5UoGsDF/s67fBQrj/2M7Hp0KHtBM4WKz9dVCU2VuZCP5PWXMuDhpQmHHGYsCLSLeCqliz+gQcMpEZ6T1jCXPi4C95KnXD3ljHGkt/wUIRIPgoRlolADdTcNKcMmNekC8LXvo/fx0BD24z6n3etk5W7gL9gEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771966915; c=relaxed/simple;
	bh=RsPVPaopC3BXTr46mcSYS7S0dKw/uRjutei23T7qobo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VhCW5oozd+xs88/96lCwZ5RGlQyMF/7ZmQLNWyD9usj/dmF9tBR+dSns6y3JuAKcnCxPkAGP85EzN+qHCow1vejWXJI/NngNNSiGKmn+9PziPlV18MUbwaQcteklDszd6/FPbEBhnnaU4hMShJD7giTtHXisB3/DByb5hYBJE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNJrq7MS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNJrq7MS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ABCC116D0;
	Tue, 24 Feb 2026 21:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771966914;
	bh=RsPVPaopC3BXTr46mcSYS7S0dKw/uRjutei23T7qobo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cNJrq7MSne/g/e1PNiCNGRpmnDJokkDLcgx5wBC9XvtlP0Hzbzt5bwO1SiZb6lP2f
	 HNqlj7tkMyGgA3qNI3iiKUHNxAZeXaA38o+/ffqVxKYmWXWVbxyv7OR9YRDuBpKPr3
	 vKyTF47Fj4CjzUYYw4fLJtXCmdZftRICoGqW//98YXFGwArwFREWYliCeCQfIBTCHp
	 PkGXv3ydXjc05SeUdf1r2bkwgguR5SNEZMg/roV4FSGfuA7+daia/ykBWPwvGBmxgy
	 Ti72dkJ/Ar6dnJS8rxkABhp9sm65r46ePRDyz1ATdTbvvdId/RAb2TNiE/GDh7wy7N
	 IYq/OWmP1/WeQ==
Content-Type: multipart/mixed; boundary="===============1101494537671284616=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <90202a7fb1a4fd05e2b5dae0d662fcbfeeef483fbe555305eaf15b75aad15a24@mail.kernel.org>
In-Reply-To: <20260225010950.20218-2-adubey@linux.ibm.com>
References: <20260225010950.20218-2-adubey@linux.ibm.com>
Subject: Re: [PATCH 1/4] powerpc64/bpf: Add support for instruction array
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org,hbathini@linux.ibm.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,maddy@linux.ibm.com,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Feb 2026 21:01:53 +0000 (UTC)

--===============1101494537671284616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 52162e4a7f84..9c27740650b5 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -318,6 +318,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  		jit_data->hdr = hdr;
>  	}
>
> +	/*
> +	 * The bpf_prog_update_insn_ptrs function expects addrs to
> +	 * point to the first byte of the jitted instruction.
> +	 */
> +	bpf_prog_update_insn_ptrs(fp, addrs, fimage);

Is addrs still valid at this point?  Looking at the code above, in the
final-pass path where (!fp->is_func || extra_pass) is true, addrs has
already been freed:

bpf_int_jit_compile() {
    ...
    if (!fp->is_func || extra_pass) {
        ...
        bpf_prog_fill_jited_linfo(fp, addrs);
out_addrs:
        kfree(addrs);
        kfree(jit_data);
        fp->aux->jit_data = NULL;
    } else {
        jit_data->addrs = addrs;
        ...
        jit_data->hdr = hdr;
    }

    bpf_prog_update_insn_ptrs(fp, addrs, fimage);  /* <-- here */
    ...
}

The kfree(addrs) happens before this call.  The NULL check inside
bpf_prog_update_insn_ptrs() does not catch this because kfree()
does not set the pointer to NULL, so offsets[xlated_off] would read
from freed memory.

The x86 JIT avoids this by placing bpf_prog_update_insn_ptrs() inside
the if (image) block before the addrs are freed:

arch/x86/net/bpf_jit_comp.c:bpf_int_jit_compile() {
    ...
    bpf_prog_update_insn_ptrs(prog, addrs, image);
    ...
    /* addrs freed later */
    kvfree(addrs);
}

Should this call be moved before the out_addrs label, similar to
how x86 does it?

Additionally, for CONFIG_PPC64_ELF_ABI_V1 where FUNCTION_DESCR_SIZE
is 24, the addrs offsets are relative to code_base, not fimage:

    code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
    fcode_base = (u32 *)(fimage + FUNCTION_DESCR_SIZE);

Would the image argument need to be (fimage + FUNCTION_DESCR_SIZE)
rather than fimage to produce the correct absolute addresses in
insn_array->ips[]?

>  out:
>  	if (bpf_blinded)
>  		bpf_jit_prog_release_other(fp, fp == org_fp ? tmp_fp : org_fp);

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22368663191

AI-authorship-score: low
AI-authorship-explanation: Standard kernel patch conventions with specific upstream references; no AI-generation indicators.
issues-found: 2
issue-severity-score: high
issue-severity-explanation: Use-after-free on addrs array in normal JIT success path can corrupt insn_array jump targets, leading to crashes or undefined behavior.

--===============1101494537671284616==--
