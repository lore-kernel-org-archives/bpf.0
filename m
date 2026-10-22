Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687919;
	b=MsZ8en7oYALHmkLkbSZKFU1eFJB32+6duo9d52ip4SuK0c998W6qV2b7XY/JE9vXvaHn
	 LXzsT+uvsC79bOSJI+cSdyVLnyHON7nSAMG7uioA0ehZlKFGS0uezEdUpk4iMgKZqvH50
	 CLH83CWq4WR+IRWDQKRmXbNcF7yswtNrNmnN4pbc1b5wtLDtoOzdsDZCb6yu53Q2Mcgxw
	 bQTQQc16rZRQaiIE5fklZvRjrpx51ywH+bpPLwOS0tcxzWEfRtgp59PHMiSu7D64yx4tN
	 lKDGVBc+DW2sP1gvCDFK4sCq12l+SYenACkLVFtZpVR8TESjgZF7Uyf+sPXuPcqL6iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687919;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=tuRBDQXIglNsNpVlhJ9Y8TkYhVV4gjsx/U9WZcno/ts=;
	b=Wgo/conZJdAP/ISHU2fBgprDTo8AOvO+eHWIaoutLOpaewwYGUghYzlsEg5GKtXt04x6
	 jy61kRcE05XgFsDPgwpQAFqkqcZa5OfCddQAojl4pswMq55S4uTZ/ZWydS9WJ292/30hH
	 hoOGCZ5ad5itkWw2VVFitx52MEAxgL9ok/quRcT4NrO1mIdhOstb7m7j9wDvL0gEtARD5
	 AJAt+/oEkQg3T5uqPSs5qmPlanEJ01TqaMFb/mOh4TfkEHPLFlpaX0nRca2yu2E+pqR+r
	 MDuRKyc36r1iN8E8jnvqTTAWvb7VbuPFeKYPTg+txIIa7j8Rz9BY4Qi8fv08tHjLSug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNc3iFBC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A8606A325;
	Thu, 22 Oct 2026 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNc3iFBC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08991F01825;
	Thu, 22 Oct 2026 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792687918;
	bh=tuRBDQXIglNsNpVlhJ9Y8TkYhVV4gjsx/U9WZcno/ts=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iNc3iFBC0OPpHOm+rAi8382YSgC+AFwspQWQko/NOxECUJmQSMbP+ZdQ/SajtJi5s
	 BlRq4FOHd5BbsKDJK601Z9sGgXywYZXaBWtgziQ/sVH5A1ZNVJg15Q1Gb6CkC+qtRj
	 xYsF/ITCoSRXKFvp1d1rrm9UfJAYyOnrs7iTI40cLQ8bNvJRM//jOtqC/tH1vbmNJ7
	 LZ09SjdLSp88FJ7F/3UIkzjaPBqY6I7CaGqg/xo6XaXKJ2VIgL+kBe5tfVSehcccKA
	 YPiKBzON8xkQoGWiKw8JKZMoDWMSkBbT03+7WIPwocmHsZknI3TrHrlJr9cYcvZAa0
	 U4+mTjNl0iawQ==
Content-Type: multipart/mixed; boundary="===============5763911803851566355=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f322da16c05367f7eefb943720b419d6fbb31d94cd188e9c04143fb08dbe77fb@mail.kernel.org>
In-Reply-To: <20261023-bpf-hmul-v3-2-b99e808cb28b@outlook.com>
References: <20261023-bpf-hmul-v3-2-b99e808cb28b@outlook.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf, x86: JIT UHMUL and SHMUL on x86-64
From: bot+bpf-ci@kernel.org
To: tangyazhou@zju.edu.cn,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,void@manifault.com,bpf@ietf.org
Cc: john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,puranjay@kernel.org,xukuohai@huaweicloud.com,bjorn@kernel.org,pulehui@huawei.com,catalin.marinas@arm.com,will@kernel.org,mark.rutland@arm.com,luke.r.nels@gmail.com,xi.wang@gmail.com,corbet@lwn.net,linux-doc@vger.kernel.org,ziye@zju.edu.cn,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ast@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 22 Oct 2026 16:51:57 +0000 (UTC)

--===============5763911803851566355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, x86: JIT UHMUL and SHMUL on x86-64

TL;DR: bpf_jit_supports_hmul() has no caller, and the verifier appears to
still reject UHMUL/SHMUL encodings, so the new JIT code may be unreachable;
other JITs could silently emit a low-half multiply. Is a verifier patch
missing?

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -3444,6 +3444,12 @@ bool __weak bpf_jit_supports_unwind(void)
>  	return false;
>  }
>
> +/* uhmul and shmul */
> +bool __weak bpf_jit_supports_hmul(void)
> +{
> +	return false;
> +}
> +

The commit message says bpf_jit_supports_hmul() "allows the verifier to
check JIT support without adding rejection logic to every unsupported
backend."

Is there a caller for this hook?  Nothing in this commit, or anywhere up to
the end of the series (bpf, arm64: JIT UHMUL and SHMUL), calls
bpf_jit_supports_hmul().  The arm64 patch only adds a second override.

The verifier also appears to still reject the new encodings.
check_alu_fields() is unchanged across the series, and for BPF_MUL with
BPF_SRC(insn->code) == BPF_X it still has:

    case BPF_MUL:
    case BPF_DIV:
    case BPF_MOD:
        if (BPF_SRC(insn->code) == BPF_X) {
            if (insn->imm != 0 || (insn->off != 0 && insn->off != 1) ||
                (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
                verbose(env, "BPF_ALU uses reserved fields\n");
                return -EINVAL;

The BPF_K form has the same check.  A BPF_ALU64 | BPF_MUL instruction with
off == BPF_UHMUL or BPF_SHMUL therefore fails to load with "BPF_ALU uses
reserved fields", which means the new bpf_insn_is_hmul() branches in do_jit()
and emit_hmul_aux() cannot be reached.

It also leaves the hook unused for the JITs that ignore insn->off for
BPF_MUL (x86-32, riscv, s390, powerpc, loongarch, mips, sparc, arm32), which
would emit a low-half multiply for these encodings once the verifier check
is relaxed.

Is a verifier patch that calls bpf_jit_supports_hmul() missing from this
series, or is it planned as a follow-up?  If it is a follow-up, could the
commit message say so?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39814644569
--===============5763911803851566355==--
