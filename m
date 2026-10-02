Received: from mta1.migadu.com (out-196.mta1.migadu.com [95.215.58.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4C7DA66
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968016; cv=none; b=ZKVjCZZ3ZsITCihRmhDSKOwG2CdKMgJlBmz9HjsV9Lhe6CXQg1E7nf38JJ4iok8sh1E6mYVV/rK5PQlJkHx3n8CfSxf2HlahZVbRsoBAjLFPBo8ijTl0RzH0TRoCLiOfBAlJs33O2XSx4OUycVvNHM2eFkxMdTP54aiI6g8d9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968016; c=relaxed/simple;
	bh=DjzYXIoxVBzxg+kr697NRK4nOJQirBxRSWXPZQwikRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gasxn16nTZpZSA5SxN50+1GoiaYXkzetbwLOAGiG0Tp4HgBHhuiVAxtdOuvMoAr1rRxB/yKLSapRsmiIRBgYFZL7HvURqldqyHQ965y3n68qidR9oQuU10XJXdGfZ4zXhGml4egohlCOS8W9JRgDG6PdHxs5Hh3BEsmLG8E9sHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EoHOlOTl; arc=none smtp.client-ip=95.215.58.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EoHOlOTl"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DjzYXIoxVBzxg+kr697NRK4nOJQirBxRSWXPZQwikRI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790968011; v=1; x=1791572811;
 b=EoHOlOTlBz4oudb9yIDe0seIP6yfFeeCm5/IGS98Gn1oVw6gT3jXiKK0G4oE1cFPfSBUBfKl
 r4V2RhwoIu1PpJ4nE1B9A/jxWHZrNyNlkq+iwMqGcDjuvlFkDAav7h+aNi0jHDqrUq180uR/lPl
 Lsw8EDFSEM50xSfn6dPcdMcM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 847547db9df22a20;
	Fri, 02 Oct 2026 19:06:51 +0000
X-Mizu-Trace-ID: 847547db9df22a20
X-Migadu-Flow: FLOW_OUT
Message-ID: <24f7d004-9e71-41ca-abd3-dacf952ede23@linux.dev>
Date: Fri, 2 Oct 2026 20:06:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 05/22] bpf: Prepare for an exception cleanup
 table before the CFG walk
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261001133032.1338455-1-yonghong.song@linux.dev>
 <0660232bb0b94d963dba9a2f9022669c4e97c5e0a94bd7acc674f21f18b036e6@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0660232bb0b94d963dba9a2f9022669c4e97c5e0a94bd7acc674f21f18b036e6@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/26 7:31 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Prepare for an exception cleanup table before the CFG walk
> TL;DR: bpf_exc_check_prog() rescans the whole program for bpf_throw, and a
> later patch calls it at every bpf_unwind() visit, so verification time may
> balloon on large programs; suggests caching the result.
>
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index 3ea1bff5cc90..e12cdb12cde3 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
>> @@ -141,6 +141,85 @@ int bpf_exc_check_info(struct bpf_verifier_env *env, const union bpf_attr *attr,
> [ ... ]
>
>> +static int reject_throw(struct bpf_verifier_env *env)
>> +{
>> +	u32 i;
>> +
>> +	for (i = 0; i < env->prog->len; i++) {
>> +		if (!bpf_is_throw_kfunc(&env->prog->insnsi[i]))
>> +			continue;
>> +		verbose(env,
>> +			"exception cleanup cannot be combined with bpf_throw at insn %u\n",
>> +			i);
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
> [ ... ]
>
>> +int bpf_exc_check_prog(struct bpf_verifier_env *env)
>> +{
>> +	int err;
>> +
> [ ... ]
>
>> +	err = reject_throw(env);
>> +	if (err)
>> +		return err;
>> +	env->prog->jit_required = 1;
>> +	return 0;
>> +}
> Can this scan make verification time grow with the number of bpf_unwind()
> instructions the verifier visits?
>
> The commit message says the checks in bpf_exc_check_prog() are also run
> "at every bpf_unwind()", and a later patch in the series (5de314709a62
> "bpf: Dispatch cleanup pads by rewriting return addresses") does that from
> process_bpf_unwind():
>
>      static int process_bpf_unwind(struct bpf_verifier_env *env, ...)
>      {
>          ...
>          err = bpf_exc_check_prog(env);
>
> Each of those calls reaches reject_throw(), which walks all env->prog->len
> instructions looking for bpf_throw.
>
> None of the things bpf_exc_check_prog() tests can change once do_check()
> is running: the offload flag, jit_requested, exception_callback_subprog and
> whether a bpf_throw insn exists are all fixed before the main pass.  Only
> env->ops can change, and only for struct_ops, in check_attach_btf_id()
> before do_check().
>
> So the scan gives the same answer each time, but every visit costs
> O(prog->len) instead of O(1).  That means the BPF_COMPLEXITY_LIMIT_INSNS
> budget no longer bounds verifier cost linearly; the cost becomes roughly
> visits * prog_len.
>
> For example, a program with about 500K reachable insns plus a bounded loop
> of the form "if (x == i) bpf_unwind();" could reach bpf_unwind() tens of
> thousands of times within the 1M processed insn budget.  Each visit would
> rescan 500K insns, which is around 10^10 to 10^11 extra iterations, or
> tens of seconds of extra verifier CPU for a single load.
>
> Would it make sense to run reject_throw() once and cache the result in
> env?  Alternatively, the bpf_unwind() path could re-check only the
> gen_epilogue condition, which is the one that becomes known after
> bpf_exc_prepare().

As you mentioned, yes, this is an optimization issue. We can remove
bpf_exc_check_prog() for checking per bpf_unwind() insn. We can do
a collective checking after all insns are checked. This way
bpf_exc_check_prog() will be called only once.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36872142096

