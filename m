Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC61282F30
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531023; cv=none; b=Jv1B2otZ3R7GSxDdChUN0MZsJRNNFqZfcD6Ur2hTLSpEtVVHayTfDoiigfy5I0ZseZL/7d+UhE4uVuUExekDRN0mVRgQgQ+qMxRuOOR2Vt/lfYuVB/kQDZI5P85weAGVQtpxrOsz/YjXGidRzS2UO2pn6GgUdczbvAg3fsNh1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531023; c=relaxed/simple;
	bh=3ddAbr/DMm39kdnOnxL7Hc4rOhOd6c2qp/GtUEradQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTmTVmRU+uTVd6iDHxzpHUZSIf0QrYFOURzx/2w6A4GF3uOTtpdtF+OVXRwvoph0GlaHWF2q2aIfki5YKcw5ZxYxJdgbzyveRgQUt2SrgHPZA3aIDdowzqZ38cGUkumCS9hYMNoOkYFdWRrPcJHQFlo4rkyfnzWnFcOL/elgdeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ilBjRVzQ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ilBjRVzQ"
Message-ID: <376af95d-14c5-49e3-ae12-98896a83d9e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776531020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WLO/jKiWMI3UgiM42LANXQxLPLx1PLK6us+QRVy53Ac=;
	b=ilBjRVzQKXuq4QcicNcPq7Cn2vxJ8FturLrMnkgI0fkNmwu9dUFCWuvypbYuAusr9FSzCN
	Kue24ZxAcrcDpHAiHyVt2sZ702EX1RVX0t/8KG0OH63MBpIi/vtZQMsGCm4x/F2I3yofM+
	x1afpmT5hKMMtk8LundKrcE6LXbwYAI=
Date: Sat, 18 Apr 2026 09:50:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 06/16] bpf: Limit the scope of BPF_REG_PARAMS
 usage
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260417034729.2629367-1-yonghong.song@linux.dev>
 <20260417045015.4CE60C19425@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260417045015.4CE60C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/16/26 9:50 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [Critical] Early returns in dataflow tracking passes skip necessary state updates for the destination register during BPF_LDX using BPF_REG_PARAMS.
> - [Critical] Permitting BPF_REG_PARAMS causes severe out-of-bounds memory accesses to the `regs` array during the main verifier loop (`do_check_main`).
> --
>
> commit d68722297de575b838cc2f76141cf9c052e63448
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Limit the scope of BPF_REG_PARAMS usage
>
> This commit restricts the usage of BPF_REG_PARAMS (r11) to specific memory
> load and store instruction forms. It also adds early returns in dataflow
> tracking passes to prevent out-of-bounds accesses for stack arguments.
>
>> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
>> index db73c4740b1e1..09db7fdb370fd 100644
>> --- a/kernel/bpf/const_fold.c
>> +++ b/kernel/bpf/const_fold.c
> [ ... ]
>
>> @@ -51,13 +51,18 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *
>>   			   struct bpf_insn *insn, struct bpf_insn *insns, int idx)
>>   {
>>   	struct const_arg_info unknown = { .state = CONST_ARG_UNKNOWN, .val = 0 };
>> -	struct const_arg_info *dst = &ci_out[insn->dst_reg];
>> -	struct const_arg_info *src = &ci_out[insn->src_reg];
>> +	struct const_arg_info *dst, *src;
>>   	u8 class = BPF_CLASS(insn->code);
>>   	u8 mode = BPF_MODE(insn->code);
>>   	u8 opcode = BPF_OP(insn->code) | BPF_SRC(insn->code);
>>   	int r;
>>   
>> +	/* Stack arguments using BPF_REG_PARAMS are outside the tracked register set. */
>> +	if (insn->dst_reg >= MAX_BPF_REG || insn->src_reg >= MAX_BPF_REG)
>> +		return;
> If we return early here during a BPF_LDX instruction where src_reg is
> BPF_REG_PARAMS (11), doesn't this skip necessary state updates for dst_reg
> (e.g., registers 0 through 9)?
>
> Since dst_reg is not marked as unknown, won't it retain its stale tracking
> state? Could bpf_prune_dead_branches() rely on this stale constant to
> incorrectly rewrite conditional jumps, allowing verifier safety checks to be
> bypassed?

Good point. Will fix.

>
>> +
>> +	dst = &ci_out[insn->dst_reg];
>> +	src = &ci_out[insn->src_reg];
> [ ... ]
>
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> index 332e6e003f270..0c7eef3385513 100644
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
>> @@ -1068,11 +1068,16 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   	int depth = instance->depth;
>>   	u8 class = BPF_CLASS(insn->code);
>>   	u8 code = BPF_OP(insn->code);
>> -	struct arg_track *dst = &at_out[insn->dst_reg];
>> -	struct arg_track *src = &at_out[insn->src_reg];
>> +	struct arg_track *dst, *src;
>>   	struct arg_track none = { .frame = ARG_NONE };
>>   	int r;
>>   
>> +	/* Stack arguments using BPF_REG_PARAMS are outside the tracked register set. */
>> +	if (insn->dst_reg >= MAX_BPF_REG || insn->src_reg >= MAX_BPF_REG)
>> +		return;
> Similarly, does this early return skip clearing the arg_track state for the
> destination register when loading from a stack argument?

Same, will fix.

>
>> +
>> +	dst = &at_out[insn->dst_reg];
>> +	src = &at_out[insn->src_reg];
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ff0c55d803117..f25a56cfabaca 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -18487,13 +18487,22 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
>>   		return err;
>>   
>>   	for (i = 0; i < insn_cnt; i++, insn++) {
>> +		u8 class = BPF_CLASS(insn->code);
>> +		u8 mode = BPF_MODE(insn->code);
>> +
>>   		if (insn->dst_reg >= MAX_BPF_REG) {
>> -			verbose(env, "R%d is invalid\n", insn->dst_reg);
>> -			return -EINVAL;
>> +			if (insn->dst_reg != BPF_REG_PARAMS ||
>> +			    !((class == BPF_ST  || class == BPF_STX) && mode == BPF_MEM)) {
>> +				verbose(env, "R%d is invalid\n", insn->dst_reg);
>> +				return -EINVAL;
>> +			}
>>   		}
> By permitting BPF_REG_PARAMS (which equals MAX_BPF_REG) to pass this validation
> check, won't this cause out-of-bounds memory accesses to the regs array
> (e.g., struct bpf_reg_state regs[MAX_BPF_REG]) during the main verifier loop?
>
> When do_check_main() processes these instructions, functions like
> check_reg_arg() will attempt to access regs[11], which overlays verifier
> internal state.
>
> I note this regression is fixed later in the patch series in commit
> 6ec4a3fcb5e83 ("bpf: Support stack arguments for bpf functions"), but it
> appears to introduce an issue in this intermediate patch.

Yes, this patch should be after "bpf: Support stack arguments for bpf functions
" patch.


