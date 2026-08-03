Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582D4137BA;
	Mon,  3 Aug 2026 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770746; cv=none; b=YakMCClwZHtFUAhr+K9fIEcQJZpysHtmgb9H9oYBVWxlM58sWLXJ5/gBUM9VB14jTjwhxvX4UlmtNi2p6VzhAKOFw7OmxdIIsxZlkhk9go9E9FIxMN9zeSolAASw47dOuCwiWVJbLPkn7o+YUk0ULzzVJbmAtDHD9H0kH64NbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770746; c=relaxed/simple;
	bh=685gOGA1JBRnVwTbxL6njPLjS1t2t5hs19cEbiUrGg0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=T6Lh3sVNwN4inT+RvPfR9nZhijC6XMW72vhav6iCp2Ioyy+XA/vxSKoZlMGwO79ek6uW6iu/zL3fnNiqfP33nVX26W87ym9oWG3AhY21MLeBiE4ZhwDyWGf/8+ooq/pZCVW+ulqF0iD8g1dYQKZzUDY07tzLM++j3p5q6czhNdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVw1O/We; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVw1O/We"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21721F000E9;
	Mon,  3 Aug 2026 15:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785770744;
	bh=1OuYmz3KcfLod+bZYz6CUkSXqCIHMw2uLNQ5Mlf59Nw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bVw1O/WeLsUr/4nkfxdCp+RRrgilQqeZIutNrTS9hGrcDIJqv1VqhGK4hzIPpt6Er
	 13+Vfdoy7c/BDSd/nNOLsr+/gla7QOfJ9KP1sLhcfXu6Yh4aiNuHC4zcapcMHsiy4U
	 JnV7CkfqfqyR9JFBgXLBq+CtN7MqEELQ5TFkREl8WbKxpLHM+dDmyfufr2yh4i4JPf
	 tWuf0ZS9+XIkrxXzyFWdKujKsLfWyoYaOsjmZ0rchxwLJdqI9zUJ6O6KAT90yOHe7s
	 06s9/Zs0Z5vNBLPmuy5hE+dXZ2KFi/xJsBWquvVKNFz/nwQIvRu4GofBtWGTHb43TS
	 Ud1mD6t3MFzJA==
Content-Type: multipart/mixed; boundary="===============5234048644432632214=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <18e8ba9303a6041520433c7bad9187e29a756908385e6b2607de1ae82db67beb@mail.kernel.org>
In-Reply-To: <20260803-c3-035-sanitize-err-v1-v1-1-93e5ff61731f@mails.tsinghua.edu.cn>
References: <20260803-c3-035-sanitize-err-v1-v1-1-93e5ff61731f@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf] bpf: Fix sanitize_err() register selection for BPF_K
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,sashiko-bot@kernel.org,chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 15:25:43 +0000 (UTC)

--===============5234048644432632214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fdc5fbb1f78c..e5a8547ad723 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13562,6 +13562,7 @@ static int sanitize_err(struct bpf_verifier_env *env, const struct bpf_insn *ins
>  	static const char *err = "pointer arithmetic with it prohibited for !root";
>  	const char *op = BPF_OP(insn->code) == BPF_ADD ? "add" : "sub";
>  	u32 dst = insn->dst_reg, src = insn->src_reg;
> +	bool src_is_imm = BPF_SRC(insn->code) == BPF_K;
>  	struct bpf_reg_state *regs = cur_regs(env);
>
>  	switch (reason) {
> @@ -13571,7 +13572,7 @@ static int sanitize_err(struct bpf_verifier_env *env, const struct bpf_insn *ins
>  		break;
>  	case REASON_TYPE:
>  		verbose(env, "R%d has pointer with unsupported alu operation, %s\n",
> -			regs[src].type == SCALAR_VALUE ? dst : src, err);
> +			src_is_imm || regs[src].type == SCALAR_VALUE ? dst : src, err);
>  		break;
>  	case REASON_PATHS:
>  		verbose(env, "R%d tried to %s from different maps, paths or scalars, %s\n",

Can this code path be reached for BPF_K instructions? The new src_is_imm
check appears to be unreachable.

All three call sites of sanitize_err() (at verifier.c:13765, :13858 and
:14610) fire only when sanitize_ptr_alu() or sanitize_val_alu() return a
negative REASON_* code. Both of those functions begin with:

static bool can_skip_alu_sanitation(const struct bpf_verifier_env *env,
                                    const struct bpf_insn *insn)
{
        return env->bypass_spec_v1 ||
                BPF_SRC(insn->code) == BPF_K ||
                cur_aux(env)->nospec;
}

and check this at their entry:

  sanitize_val_alu()  verifier.c:13415:  if (can_skip_alu_sanitation(env, insn)) return 0;
  sanitize_ptr_alu()  verifier.c:13469:  if (can_skip_alu_sanitation(env, insn)) return 0;

Every REASON_* return in both functions is downstream of that gate, so for
BPF_K instructions they return 0 early. This means sanitize_err() never
executes for BPF_K, making src_is_imm always false inside that function.

The change adds a variable and an always-false disjunct to the conditional,
but produces identical output for all reachable cases. Note also that the
sibling REASON_BOUNDS arm two lines above uses the same regs[src] test and
was left untouched.

If this is defensive hardening against a future change that removes the
BPF_K gate, should that be stated explicitly? Otherwise the code and commit
message imply a functional fix when the behavior is unchanged.

> commit cd52f137178ae1ebdcb1abceac8ccda767f69fe2
> Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
>
>     bpf: Fix sanitize_err() register selection for BPF_K
>
>     sanitize_err() determines whether the source or destination register holds
>     the pointer by inspecting regs[insn->src_reg]. For BPF_K instructions,
>     src_reg is zero because the offset is encoded as an immediate. R0 must
>     therefore not influence the register reported for REASON_TYPE.
>
>     Treat BPF_K as an immediate scalar source and select the destination
>     register for the diagnostic.
>
>     Fixes: a15970d916b3 ("bpf: Simplify sanitize_err() signature")

Does the Fixes: tag accurately describe a bug that existed in a15970d916b3?

The format of the tag is correct: SHA-1 a15970d916b3 is 12 hex chars,
exists and is reachable, and the subject matches exactly. However, the tag
asserts a reachable defect that the code analysis above contradicts.

The commit a15970d916b3 replaced the off_reg == dst_reg comparison with
regs[src].type == SCALAR_VALUE, and its changelog states: "regs[src].type
is safe to access, as it is not mutated by the callers." That commit did
not introduce a reachable misreport, because sanitize_err() was already
unreachable for BPF_K via can_skip_alu_sanitation() both before and after
it.

The scenario the current commit message describes (a pointer in R0 being
selected as the reported register for a BPF_K instruction) cannot occur
because sanitize_err() is never called for BPF_K instructions. Per the
reachability analysis, the emitted verifier message is byte-for-byte
identical before and after this patch for every possible input program.

If this patch is intended as hardening for a future relaxation of the BPF_K
gate, stating that explicitly and dropping the Fixes: tag would more
accurately describe the change. Otherwise the tag attributes a bug that
cannot be triggered and may cause this to be backported as a functional fix
when it has no runtime effect.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30825118624
--===============5234048644432632214==--
