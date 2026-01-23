Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E660434DCFD;
	Fri, 23 Jan 2026 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155667; cv=none; b=h5/5apieTd5IFNv9kEATlw4zSr5Cec/V7TYR1cbjuWfJuOjFATpIqa8a67IguZnUp+SQfmHWqPKNGisYkEUoiK1oBmVz14b17tUIHfYrZnbRllGEx4KcWyhHrJa84K6Quo8TsQ8GTfCgJU4OM+oxGJGsxhjcmKUKRQLRXSEs2Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155667; c=relaxed/simple;
	bh=MNLq0TR3j0UA8d5OisfSqyfsUMVNqiXwyp43jN2pjBQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HPribGTnri/+BL4uGh40wakTxJF0sAphDhsCDpmnM/bEHzvBzHIhgIqxT7TkCu0jL7S2Sbo+DNDuA0prGDZbk8+Vn3t7ULDmaw1vqs52rFkUe2u4fILNYrTsg/wEnxgxGHKagSwnGx9BHT+qlXwQxeqOdcMZniTJJ50SYd/+i1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTxTgKNL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTxTgKNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00561C4CEF1;
	Fri, 23 Jan 2026 08:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769155666;
	bh=MNLq0TR3j0UA8d5OisfSqyfsUMVNqiXwyp43jN2pjBQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=oTxTgKNL5uX2CuYvWo5rYQ8mx+/675qFuSI2m7WJdhKAs9gZryGijMx5k45hbzfXA
	 Z9O0PGB2UIzui/VZjUZWuYtAGhVcMhSDn4ORlg+Iolstj/zIaM6wW5tC2mUUrdFbej
	 VHEZaimQiu4GJVKOx11/K90i6k8iUfldQ8N3aiyvNVeXcKtFExdPpzF6b4kO79hg7H
	 LBxNOI4YKiiss2hPvVAr49fKdk7pLdoQU+KPshrnUczmCtM6nTJnAnU38KzOVGkxsh
	 I0Ml/gmpwlLEUqn//sMzz6dWZBMioOfTvKuSqWQGSS20vwO1M8IZHakYmafxrh1Ab5
	 X9xLBHpxS/nSw==
Content-Type: multipart/mixed; boundary="===============1006796912899658288=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d91544bd4b513290bf468386c0261f913b59b761c34405839c424f8eaf8b1d04@mail.kernel.org>
In-Reply-To: <20260123073532.238985-3-dongml2@chinatelecom.cn>
References: <20260123073532.238985-3-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v11 02/12] bpf: use the least significant byte for the nr_args in trampoline
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,dsahern@kernel.org,tglx@linutronix.de,mingo@redhat.com,jiang.biao@linux.dev,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 23 Jan 2026 08:07:45 +0000 (UTC)

--===============1006796912899658288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 41bbed6418b5..b3f912ad18ba 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -23779,12 +23781,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  			    eatype == BPF_MODIFY_RETURN) {
>  				/* Load nr_args from ctx - 8 */
>  				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> -				insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> +				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
> +				insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);

[ ... ]

> -				cnt = 6;
> +				cnt = 7;
>  			} else {
>  				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
>  				cnt = 1;
>  			}
>
>  			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);

[ ... ]

> 			delta    += cnt - 1;

Note that the bpf_get_func_ret block above correctly updates delta after
patching.

> @@ -23808,12 +23811,15 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>
>  				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
>  				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
> +				cnt = 1;
>  			} else {
>  				/* Load nr_args from ctx - 8 */
>  				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
> +				cnt = 2;
>  			}
>
> -			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>  			if (!new_prog)
>  				return -ENOMEM;
>
>  			env->prog = prog = new_prog;
>  			insn      = new_prog->insnsi + i + delta;
>  			goto next_insn;
>  		}

Should there be a "delta += cnt - 1;" before assigning env->prog in this
bpf_get_func_arg_cnt block? When cnt is 2 (non-RAW_TP path), the program
grows by one instruction, but delta is not updated. This could cause
subsequent bpf_patch_insn_data() calls to use incorrect offsets.

The bpf_get_func_arg block at the beginning of this patch has:

    delta    += cnt - 1;
    env->prog = prog = new_prog;

And the bpf_get_func_ret block similarly has delta updated. But this
bpf_get_func_arg_cnt block goes directly to env->prog assignment without
updating delta.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21278745581

--===============1006796912899658288==--
