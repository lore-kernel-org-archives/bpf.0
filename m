Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2711A262D
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421784; cv=none; b=pjzuJhXQ8mE6keK6tFaFbajqQ8EZIhrxee+qztJ7ZFx0yhPLcNwrVEKt8DLQ10VgMY4pjX13nMxx3Ji0yGPQb03Vebp5LFm5wX5hkqjFKEu4u78hlDmpeMsfYs95RLCnrodxujXedF/hO0dKSjpIafMLeHy7gzNhl2qWBlHPCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421784; c=relaxed/simple;
	bh=A+WXTstUxcKaLepw8t9nCK7iUvvTFBkbEFELMLCy0W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GztRvcZRxSmLUGE6FQ6onzJNLGUFSvoFSFgRO9a9VQk0CRyFBESxOQvz7CEOiacEmOAoTG49EuBA74NSpD4s7DCQ+c4jYTDAAStVbf661XxUEfMpoZTlQtAs3ZAyDUPOYyMCqMbfiokyUH8o+yJjZ1XuXt1EMxcgc/kj3LloYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ve73xa2X; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ve73xa2X"
Message-ID: <5e8cc9c2-ae36-493b-922f-0d86f253265c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786421780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9lh2mxXE/1eT8QFiP+o80+j1yeKAizjNvQKCJk7L6Q=;
	b=ve73xa2XsyGfwb2PKCl84SxrDYxPijtyxrd4ae7gqU5IXQ4UWBhcU7MktJ2NWAL681cUAT
	NlOEp7Bso2V83QcHkMNEq5JmgC4diWvuj+CnunZeMKv0Z26boxarSxHpq521ZAIdT/HvuB
	0HEa9ea8Tm/oAYdoCWHBqY7pYCYNQJs=
Date: Tue, 11 Aug 2026 12:16:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 03/10] bpf: Introduce global percpu data
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Quentin Monnet <qmo@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260806163125.11172-1-leon.hwang@linux.dev>
 <20260806163125.11172-4-leon.hwang@linux.dev>
 <8ea2c2ef5a50333c84865d09c860a9617edbda9b.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <8ea2c2ef5a50333c84865d09c860a9617edbda9b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/8/26 07:22, Eduard Zingerman wrote:
> On Fri, 2026-08-07 at 00:31 +0800, Leon Hwang wrote:
> 
> ...
> 
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 440e73e1b11b..f2398749103b 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1817,6 +1817,43 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>>  			goto next_insn;
>>  		}
>>  
>> +		if (bpf_jit_supports_percpu_insn() &&
>> +		    insn->code == (BPF_LD | BPF_IMM | BPF_DW) &&
>> +		    (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
>> +		     insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE)) {
>> +			struct bpf_map *map;
>> +
>> +			aux = &env->insn_aux_data[i + delta];
>> +			map = env->used_maps[aux->map_index];
>> +			if (map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
>> +				goto next_insn;
>> +
>> +			prog->jit_required = true;
>> +
>> +			/*
>> +			 * We are *skipping* first half of ld_imm64 insn
>> +			 * with 'i++;', patching over second half of it
>> +			 * with that same half + mov64_percpu_reg insn.
>> +			 * All because bpf_patch_insn_data() can only
>> +			 * replace one 8-byte insn, which does not work
>> +			 * well for ld_imm64 insn.
>> +			 */
>> +
>> +			insn_buf[0] = insn[1];
>> +			insn_buf[1] = BPF_MOV64_PERCPU_REG(insn->dst_reg, insn->dst_reg);
>> +			cnt = 2;
> 
> Hi Leon,
> 
> Sorry for joining the discussion so late, but Andrii asked me to take
> a look at the verifier part of the changes. Could you please elaborate
> on what exactly does not work with 16-byte instructions and
> bpf_patch_insn_data()? Note that e.g. 'if (insn->imm == BPF_FUNC_timer_set_callback) {'
> case in the same bpf_do_misc_fixups() applies a patch containing BPF_LD_IMM64().

The BPF_FUNC_timer_set_callback case is different from this patch.

The BPF_FUNC_timer_set_callback case inserts a ld_imm64 insn at the
position of the call insn.

However, this patch is going to insert a mov64_percpu_reg insn after the
ld_imm64 insn.

Since ld_imm64 insn is a 16-byte insn, the new mov64_percpu_reg must sit
after the ld_imm64 insn by 'i++'.

Then, let's look into bpf_patch_insn_data(). bpf_patch_insn_data()
utilizes bpf_patch_insn_single() to insert insns at the position of one
8-byte insn. See memmove(..., + off + 1, ...), the *1* is for one 8-byte
insn. I tried to modify bpf_patch_insn_single() to add 16-byte insn
support, but that looked much complicated against this patch.

Thanks,
Leon

> 
> The rest of the patch lgtm.
> 
>> +
>> +			i++;
>> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>> +			if (!new_prog)
>> +				return -ENOMEM;
>> +
>> +			delta    += cnt - 1;
>> +			env->prog = prog = new_prog;
>> +			insn      = new_prog->insnsi + i + delta;
>> +			goto next_insn;
>> +		}
>> +
>>  		if (insn->code != (BPF_JMP | BPF_CALL))
>>  			goto next_insn;
>>  		if (insn->src_reg == BPF_PSEUDO_CALL)
> 
> ...

