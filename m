Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8417F332614
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995029; cv=none; b=FSrCR/YQxemluVazZskajayXqtYI9NpW7NtRbYZYzGm3YsXWR1we2qZdUE/JY6dqmXDJ6VnzyAagB4sFUgmXRwQ9OlgUuyvgIDTqJ0XRszmAyrxe6ehTh8wtWiB0IewJmhZP+PD5LA37VTaSBhtasdluXMaaeb+LymtB+Svd2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995029; c=relaxed/simple;
	bh=K8frdBABQTHnYOPCz7lRyQO1DmkEKU2R0HUuxZ8ZLug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m4vkxFpMzlZBtaZ5O8OG8jQ0BRPRJAk1KeMT0Ks/Aw097wrzqHQN8AEOM4AVALIa/b3YGb0iLOzJui4bJfBIeeu1Aus24f9nFURDtvPimmjE00sUBKMGCuu88qfYsOxFd6NCjpE8HDB2qU4PY5HDcXd0taBRpXcKH/VsQIlKYVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGtoNnHo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGtoNnHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C5C1F000E9;
	Sat, 25 Jul 2026 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784995026;
	bh=q+bZcpWIzM285uhwdSMmj00EnzLw8ldlrADhoZalLLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YGtoNnHoSQqPHQ7jN/SRW2DqXT+H3+mTvgP1i4j/TpjCgO0oYYF1mS5KutjXiHOnG
	 2hiVeRwPdgos56T9/HZlFSRmhDlXG2jocTOVVIURnAMH8AND5d/TezKAY5xYAm1wwb
	 3zO/tPeP3VwWrcvlpVkmagECh38SmEnFrWqnJ/Jq20yTfwtFwhBey5St3qXtCx02fM
	 1no/ER2k7g4cGbNK7MNjhQ14gJnt2zwQpdgy5rJznyZZbg0koimIO1plAOTvXbHM0p
	 qTJSDxkfuw6OPma83qUpwfP25RpZFCUm3BsajsLsMYIRPl5HhMRQZFMM2LSE4ht25/
	 pc+z1XxQbW0Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 8/9] riscv, bpf: Adjust bpf_func to account
 for CFI offset in bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260725154915.2488611-9-pulehui@huaweicloud.com>
References: <20260725154915.2488611-1-pulehui@huaweicloud.com>
 <20260725154915.2488611-9-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:57:05 +0000
Message-Id: <20260725155706.54C5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_jit_free() ignores the error return value of bpf_jit_binary_pa=
ck_finalize(), leading to a Use-After-Free and Double Free of the JIT ro_he=
ader.
--

--- Patch [8]: [PATCH bpf-next v3 8/9] riscv, bpf: Adjust bpf_func to accou=
nt for CFI offset in bpf_jit_free ---
commit a0a806deebfc4afdceb1a23fa093826ade44c8cf
Author: Pu Lehui <pulehui@huawei.com>

riscv, bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free

When CFI is enabled, the actual BPF program entry point is shifted forward
by a CFI preamble. This commit subtracts the CFI offset from prog->bpf_func
in bpf_jit_free() to restore the original JITed allocation address before
freeing it, preventing an invalid memory free.

> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index cbfcd287ea166..059db1adeaf8d 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -237,6 +237,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>  			kvfree(jit_data->ctx.offset);
>  			kfree(jit_data);
>  		}
> +		prog->bpf_func =3D (void *)prog->bpf_func - cfi_get_offset();
>  		hdr =3D bpf_jit_binary_pack_hdr(prog);
>  		bpf_jit_binary_pack_free(hdr, NULL);

[Severity: High]
This is a pre-existing issue, but does ignoring the return value of
bpf_jit_binary_pack_finalize() (called just prior to this diff snippet)
lead to a use-after-free and double free?

If bpf_jit_binary_pack_finalize() fails, it frees ro_header internally:

kernel/bpf/core.c:bpf_jit_binary_pack_finalize() {
    ...
    if (IS_ERR(ptr)) {
        bpf_prog_pack_free(ro_header, ro_header->size);
        return PTR_ERR(ptr);
    }
    ...
}

Back in bpf_jit_free(), we ignore this failure, extract the same freed
header via bpf_jit_binary_pack_hdr(), and call bpf_jit_binary_pack_free()
which dereferences ro_header->size and frees it again:

kernel/bpf/core.c:bpf_jit_binary_pack_free() {
    u32 size =3D ro_header->size;

    bpf_prog_pack_free(ro_header, size);
    ...
}

Should bpf_jit_free() check if bpf_jit_binary_pack_finalize() returned
an error before attempting to extract and free the header again?

>  		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725154915.2488=
611-1-pulehui@huaweicloud.com?part=3D8
