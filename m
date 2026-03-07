Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F28329C54;
	Sat,  7 Mar 2026 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772903664; cv=none; b=DPfua/pRV9nyeIxZci3F/DNG609+kACbsYWUonpZKqA+2a/MJHuqAwLikLf0hskRH39Ua7XENPVPXkVX6++gO65/Q6NitVdLkwMyS8++RwaVljn5+zFiWzj+DkVUmI+XnxxlvZxLzSnYJ3coGmUMBey45Y39Hs+onDSFTvsgaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772903664; c=relaxed/simple;
	bh=wvZwCWzoV2syxel4bj9Num7rqlKF203cjboJ2bIy5os=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QwhH6HRakSoHCRayf8/w7LPf2oQNflu8VBP0Rqw0W/f7+AFc5RBQNeQ1bW2QvRqmQIZ8mmrPCukYzX61jvcO20TbvRKAkIufcLLCXVNMPdzixuQFnrAjITqs0SpG7pbn2OOvd1fDfLdezVk6Lls7YjB58xtstLoumSeQ2CvTIyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS8+3rL6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS8+3rL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4CCC19422;
	Sat,  7 Mar 2026 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772903664;
	bh=wvZwCWzoV2syxel4bj9Num7rqlKF203cjboJ2bIy5os=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IS8+3rL6RB502TfkKEXzwAn5AFGRVyuTCJw5q7ZBwEizqrRWLHH8PMtZ1VowKnACT
	 kjcdRxbvbDnN7bYPUCWaCoHtJ6/WLK+CGRKbYE4SQdgB1ZgE7PIFso4BEH5ouAtJxV
	 Kh091a69PK1EM+dj+qSwgo4TvGKuuu1NpteP+knzwQWYOuD0HENSxIqu478wPyQjUd
	 N9wGUhAKgspQwMknQ/ZMorLOMYbh2WiXDUjkH2hMyWP6RiMNCMf8reomc+Mde9I4Vm
	 POXZG0p95e6lwN2hXNru55BlF7mn4qv8Jnx/1riDM7yeIDHPCFZjvclfdN9hrYDoAW
	 7oRiHM6Pw5VfQ==
Content-Type: multipart/mixed; boundary="===============0778104764128759318=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ca484ba53c9ce4dac51c7ae3e8888cfe561b31c3826880c6fc89d5581c6de2fa@mail.kernel.org>
In-Reply-To: <20260307103949.2340104-4-xukuohai@huaweicloud.com>
References: <20260307103949.2340104-4-xukuohai@huaweicloud.com>
Subject: Re: [bpf-next v7 3/5] bpf: Add helper to detect indirect jump targets
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,a.s.protopopov@gmail.com,list+bpf@vahedi.org,linux@armlinux.org.uk,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,davem@davemloft.net,udknight@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  7 Mar 2026 17:14:23 +0000 (UTC)

--===============0778104764128759318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1475,11 +1475,30 @@ int bpf_jit_blind_constants(struct bpf_verifier_env *env)
>  		insn = prog->insnsi + i + insn_delta;
>  		insn_cnt += insn_delta;
>  		i        += insn_delta;
> +
> +		/* bpf_patch_insn_data() calls adjust_insn_aux_data() to adjust insn_aux_data. The
> +		 * indirect_target flag for the original instruction is moved to the last of the new
> +		 * instructions, but the indirect jump target is actually the first one, so move
> +		 * it back.
> +		 */
> +		if (env->insn_aux_data[i].indirect_target) {
> +			env->insn_aux_data[i].indirect_target = 0;
> +			env->insn_aux_data[i - insn_delta].indirect_target = 1;
> +		}

This fixup handles the displacement caused by
bpf_jit_blind_constants() itself, but adjust_insn_aux_data() has
the same displacement behavior in every caller of
bpf_patch_insn_data(). Several patching passes run before
bpf_jit_blind_constants() in bpf_check():

  convert_ctx_accesses()      ->  bpf_patch_insn_data()
  do_misc_fixups()            ->  bpf_patch_insn_data()
  opt_subreg_zext_lo32_rnd_hi32() -> bpf_patch_insn_data()
  fixup_call_args()           ->  bpf_jit_blind_constants()  <-- only fixup here

All of these call adjust_insn_aux_data() which does:

  memmove(data + off + cnt - 1, data + off, ...)
  memset(data + off, 0, ...)

This moves indirect_target from data[off] to data[off + cnt - 1].
Meanwhile, bpf_insn_array_adjust() preserves xlated_off == off:

  if (insn_array->values[i].xlated_off <= off)
      continue;

So after an earlier pass patches an indirect target instruction,
the insn_array still says the target is at off, but
insn_aux_data has indirect_target set at off + cnt - 1.

If an indirect jump target is also, say, a helper call that
do_misc_fixups() replaces with multiple instructions, would
bpf_insn_is_indirect_target() return the wrong result for that
instruction? It seems like the fixup might need to be in
adjust_insn_aux_data() itself rather than only in
bpf_jit_blind_constants().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22803043949
--===============0778104764128759318==--
