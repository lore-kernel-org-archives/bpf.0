Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792563348;
	b=tMI1jDcteLC9FmppqIkVLqR7BArXngxJ16noBzqVP7dfHZ1eod8/vSWBEDrQt8yac9e1
	 epLNaN7Iv7xvMq8wNC5i+6eKhIg33Mx0iHPHrw8dvo1t83RB6SZ+S5f+4AclJVrhYihkZ
	 EazI5iOBenXtfjpUExba4MJWecoQNw58uIEUC8YRuRvtkeNZvUNU3dIiB2J3A4AXYCe21
	 DsLWDt/uHS5GErjA0LnpJgugaxSrnSu+NKtlcgulJ7SrHJU0DxyWEA400n/5L+DsaOeIH
	 OUKupBu0xR3qd8Wn1n1WRPe1dNkoQHrFjxmy4y8LKDHkIkyItYv+DW+1jMGH1oQ73Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563348;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=NE6FODam8Y7torIkBq54ShtdSgWpLFBkxmVPgOM97Y0=;
	b=waYM5vI/3ok4c+VG3RN/T8nvReWN0kuOBctm6AFbXF93x1d/NcxT2MlWGOz/g2nl77uH
	 pMwlDYW9B5vVsfJnXvfnBpXruAtkwL0uQUYjiYGW6ZLBG6ta9pRZu9YeWxqbDk1OuWD8l
	 1zehCyXMcDHti+a1WkuY9HqFpOO8nkwoIiUIyGo+MhXoQs0FyYETA/+xF1zE3pWxvXVx3
	 uMg9LQ3QPtFOy5lw8azSYT7Lct3xFEcDmu5N6jAJpYY23lflZICLrna1SXvJ+0UBYG03u
	 ZHT0Hml5ZrXD2HWr4r3i39lQj1kfs+cwqT7H1MOBLcKbicwJmPwc6uaRum+HPU8ZADg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=fail reason="signature verification failed" header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlpfCuDz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365D606A31D;
	Wed, 21 Oct 2026 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlpfCuDz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36271F000C9;
	Wed, 21 Oct 2026 06:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792563347;
	bh=NE6FODam8Y7torIkBq54ShtdSgWpLFBkxmVPgOM97Y0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZlpfCuDz9DktGxquPoD47fDuegagqTC+8TMUopcdjmjJoKn/9B9qXwlflzzjqXoui
	 TX+FEMbLmX7o1R4ezKKM8Eqj1Kq61xBv14gu3mA4o2KRLsYRQtgNvgh5QOkMq38dXp
	 9crrqBTNujdEaOj3GR+yYJdV6jMHqEvngqY0Dtk6dcclBTM6FpkHqOuw5j48GNTsxq
	 Roq4V5fFgCtxlBMqjogysyrThlB/dvisoCi6GDuGvH8S5mkGpjhXEekE5ICe6hpUBG
	 KfnKFZ+GmCyRwhW+QcdzPKr4tsZIbLNunaSkQV88kvTAgSc9XkhnXudfodi5mQCc0H
	 vphogldSkhgOQ==
Content-Type: multipart/mixed; boundary="===============8716026043077091956=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ade7e1bd9d4c7a3975fed8e1bea08fd66cf1b03c9c7df26f4f9fe07d36187dfa@mail.kernel.org>
In-Reply-To: <20261021-bpf-hmul-v2-1-88e260099f7d@outlook.com>
References: <20261021-bpf-hmul-v2-1-88e260099f7d@outlook.com>
Subject: Re: [PATCH bpf-next v2 1/8] bpf: Add UHMUL and SHMUL instructions
From: bot+bpf-ci@kernel.org
To: tangyazhou@zju.edu.cn,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,void@manifault.com,bpf@ietf.org
Cc: john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,puranjay@kernel.org,xukuohai@huaweicloud.com,bjorn@kernel.org,pulehui@huawei.com,catalin.marinas@arm.com,will@kernel.org,mark.rutland@arm.com,linux-arm-kernel@lists.infradead.org,linux-riscv@lists.infradead.org,list+bpf@vahedi.org,linux@armlinux.org.uk,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,James.Bottomley@HansenPartnership.com,deller@gmx.de,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,luke.r.nels@gmail.com,xi.wang@gmail.com,iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,davem@davemloft.net,udknight@gmail.com,kuba@kernel.org,corbet@lwn.net,linux-doc@vger.kernel.org,ziye@zju.edu.cn,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ast@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,
 yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 21 Oct 2026 06:15:46 +0000 (UTC)

--===============8716026043077091956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add UHMUL and SHMUL instructions

TL;DR: Verifier still rejects UHMUL/SHMUL (off 1/2), so the new interpreter
code is unreachable; once enabled, JITs and range tracking would silently use
low-half multiply. Should the UAPI wait for the full series?

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f29b0aad440c..90c30e5d790b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -34,6 +34,12 @@
>  #define BPF_FROM_LE	BPF_TO_LE
>  #define BPF_FROM_BE	BPF_TO_BE
>
> +/* BPF_MUL off values for high-half multiplication; BPF_ALU64 only. */
> +enum bpf_mul_variant {
> +	BPF_UHMUL = 1,
> +	BPF_SHMUL = 2,
> +};
> +
>  /* jmp encodings */

Can a program that uses these new encodings be loaded at all with only this
patch applied?

check_alu_fields() in kernel/bpf/verifier.c is not touched, and it still
rejects any BPF_MUL with a non-zero off:

    case BPF_MUL:
    case BPF_DIV:
    case BPF_MOD:
        if (BPF_SRC(insn->code) == BPF_X) {
            if (insn->imm != 0 || (insn->off != 0 && insn->off != 1) ||
                (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
                verbose(env, "BPF_ALU uses reserved fields\n");
                return -EINVAL;
            }
        } else if (insn->src_reg != BPF_REG_0 ||
               (insn->off != 0 && insn->off != 1) ||
               (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {

Both off == 1 (UHMUL) and off == 2 (SHMUL) fail with "BPF_ALU uses reserved
fields".

That means the UHMUL/SHMUL arms of ALU64_MUL_X and ALU64_MUL_K in
___bpf_prog_run() cannot run, and BPF_UHMUL/BPF_SHMUL describe encodings the
kernel refuses.  bpf_insn_is_hmul() in include/linux/filter.h has no callers
anywhere in the tree, and bpf_is_hmul_variant() is only called by it, so both
are currently dead code.

The commit message mentions interpreter support, but does not say that the
verifier change is left for later.

When the verifier is relaxed, the JITs and the range tracking will also need
attention.  The JITs ignore insn->off for BPF_MUL today; for example
arch/x86/net/bpf_jit_comp.c emits a plain imul for
"case BPF_ALU64 | BPF_MUL | BPF_K/X".  adjust_scalar_min_max_vals() models
BPF_MUL as a low-half multiply.  Without changes there, JITed programs would
silently compute the low half and the verifier's bounds would not match the
real result.

Should the UAPI constants and the divmul64v2 group wait until verifier, JIT
and selftest support land in the same series, or should the unused
bpf_insn_is_hmul() be dropped from this patch?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39552088777
--===============8716026043077091956==--
