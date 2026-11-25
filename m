Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631158;
	b=u1UewajTSGZ5pyyUbQk4EE2S61HFK/7Bor0jRseRJ72ntfhiL+rIiVBnqD+d98eKMNLV
	 wmbyUBhvc7rW9fF7yrbo03pMhe64Y+l8ZPxeR+dITI10qeJ6ct69vSOBlc2OaCVtxPgzn
	 839WwsQNUFB8AjEL3oS6fNZh0jGWmZOdSPrtICJER3sAnYmFT2+25fbOggEClI0r8XNNa
	 dSH/kGtMCUN9ne21a+UGT1xGSyaeVPoGDJFkyPJBD8DyzTJYdYbzEjDsKsdcB3ssCCnbJ
	 OMG5ThAfX7wuuVviYOoAItcmMAlhdknXotaxRrZQMdqUlNQzNcxONUYYfSRdcl/+DmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631158;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=PcmMKl91HOVLOKsRXZDbgF0WRiMyFUgXNkGoYaDuV8k=;
	b=OPM964QGKYe068hyRixNkg6eu4HR+eGW+HzqWMgfwB8UjoLScNfKozoQoT64+5rlhO1q
	 zhmjiW5Alvo0nS30uvRe/e5XYp5xBNhgyTBo6CpDKVku0CwmwhCNFppVfH+qEmBN28x3M
	 nNkaet6tM5DmjYehGwgAZwM4Bfb+7d5qh6CJ2eDxJJLmfGexW23iR16tpa+aIMG+RoRMp
	 eiNHATkF5NrAifeoV7sE7GrLzRIWn7l1v8M0yFbtnb8ejtXeg+CO0gA3HRqRaBMxJqI9Y
	 SG0rhaP0YVKReR/U5ee22xPgxhnUeACBkUizB7Y5Fmpzal6sfoE2VKjCBHypCEg6yqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVf9xX7B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86527606A327
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVf9xX7B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5CA1F000CA;
	Wed, 25 Nov 2026 18:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631158;
	bh=PcmMKl91HOVLOKsRXZDbgF0WRiMyFUgXNkGoYaDuV8k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fVf9xX7BsHcZhmpE38xwRY9ZfL695tvuNBQuJXuHcK0sh3LK1cBPqndxZlI0X7ayA
	 uADbW9SLDV8yeMIxzonpZTDq4TF4kwEOJL4gaLez1Ig9T09mx+Tb3vZJ2+2ZPmx8rw
	 uZg639V6nwjqVRzqaFZ87MZPJu6hwSizxmclWkLjYiruc1A5TEuxD3v6KMbQ3FnAos
	 ioL9A8moVsaN5OQW+nS5GalTu1Tfr0+zNudXuiCvLI/sN5UBJL/ELJ5c/WkwlKqWUR
	 f2t4xbNNHT46arZyRlHZbdFjw87Pgnw7z+b1dxOJ8chu1g6F7knOmg943F343VuS55
	 07nrFU39s5JQw==
Content-Type: multipart/mixed; boundary="===============3722584201307066673=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c2b3a794a7d02fb89a6fd86f5a21c31ff5c64cc88c15919a48fb7a51601ea5ed@mail.kernel.org>
In-Reply-To: <51ae120f0b3cd8c20dbaaf02c9c384dc2afab6bc.1795627805.git.m202672221@hust.edu.cn>
References: <51ae120f0b3cd8c20dbaaf02c9c384dc2afab6bc.1795627805.git.m202672221@hust.edu.cn>
Subject: Re: [PATCH] bpf, lsm: Mark IPC control hook perm parameters nullable
From: bot+bpf-ci@kernel.org
To: m202672221@hust.edu.cn,bpf@vger.kernel.org,kpsingh@kernel.org
Cc: matt@bobrowski.net,paul@paul-moore.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,emil@etsalapatis.com,m202672221@hust.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 18:25:56 +0000 (UTC)

--===============3722584201307066673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, lsm: Mark IPC control hook perm parameters nullable

TL;DR:
- Commit message may misdescribe the problem: LSM perm args are trusted, so an
  unchecked NULL deref may oops, possibly a regression since c6b0337f0120
- Minor nits: EPERM vs EACCES, misleading IPC_INFO | SHM_INFO comment

> Those carry no __nullable suffix, so
> btf_ctx_access() types perm as a plain PTR_TO_BTF_ID and the verifier
> accepts a program that dereferences it unconditionally:
> [ ... ]
> This is not a regression: the parameters were never annotated, and the
> NULL argument is part of the hook contract

Is this description accurate?  For an LSM program, btf_ctx_access() ORs in
PTR_TRUSTED when prog_args_trusted() is true, and prog_args_trusted()
returns bpf_lsm_is_trusted(prog) for BPF_PROG_TYPE_LSM.  None of the IPC
hooks is in untrusted_lsm_hooks, so perm is PTR_TO_BTF_ID | PTR_TRUSTED.
The verifier log quoted in the commit message shows this too:
trusted_ptr_or_null_kern_ipc_perm.

The difference matters for the oops.  A plain PTR_TO_BTF_ID load would not
crash:

    static inline bool bpf_may_fault_on_deref(enum bpf_reg_type type)
    {
            return type == PTR_TO_BTF_ID || (type_flag(type) & PTR_UNTRUSTED);
    }

bpf_convert_ctx_accesses() rewrites a load from a flagless PTR_TO_BTF_ID
into BPF_PROBE_MEM, which goes through the exception table and reads 0 for
a NULL+0x60 address.  Only the trusted load is emitted as a direct BPF_MEM
load that faults.

LSM arguments became trusted, and trusted loads stopped being
probe-converted, in c6b0337f0120 ("bpf: Don't mark arguments to fentry/fexit
programs as trusted.").  That commit replaced prog_type_args_trusted()
(TRACING || STRUCT_OPS only) with prog_args_trusted(), which has
"case BPF_PROG_TYPE_LSM: return true", and removed the PROBE_MEM conversion
for trusted loads.  Before it, the same program read perm->seq through
BPF_PROBE_MEM and got 0.

So does "This is not a regression" hold for the crash itself?  That seems
relevant for stable backporting, since the trigger needs no privilege.

There is also a smaller point:

> and BPF_PROG_LOAD fails with EPERM.

The path that prints "R6 invalid mem access 'trusted_ptr_or_null_'" is the
final else of check_mem_access(), which returns -EACCES, not -EPERM.

> diff --git a/kernel/bpf/bpf_lsm_proto.c b/kernel/bpf/bpf_lsm_proto.c
> --- a/kernel/bpf/bpf_lsm_proto.c
> +++ b/kernel/bpf/bpf_lsm_proto.c

[ ... ]

> +/*
> + * Strong definitions of the IPC control BPF LSM hooks. The informational
> + * commands have no object to authorize, so they pass a NULL struct
> + * kern_ipc_perm: shmctl_ipc_info() and shmctl_shm_info() call
> + * security_shm_shmctl(NULL, IPC_INFO | SHM_INFO), semctl_info() calls

This isn't a bug, but the comment reads as a single call with the bitwise
OR of the two commands, and no such call exists.  shmctl_ipc_info() calls
security_shm_shmctl(NULL, IPC_INFO) and shmctl_shm_info() calls
security_shm_shmctl(NULL, SHM_INFO).

IPC_INFO (3) | SHM_INFO (14) is 15, which is SHM_STAT_ANY, and that command
goes through shmctl_stat() and passes a real &shp->shm_perm, not NULL.

Could the comment say "call security_shm_shmctl(NULL, IPC_INFO) and
security_shm_shmctl(NULL, SHM_INFO) respectively" instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45672586202
--===============3722584201307066673==--
