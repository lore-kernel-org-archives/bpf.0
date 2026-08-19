Received: from mta1.migadu.com (out-16.mta1.migadu.com [95.215.58.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572113C1D5E
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 03:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110921; cv=none; b=P3HHjVlOzGmJvmLHrlLShHEcVgjCFlOKtrQLp9ug2BNtKps1zG4ZxtdqP4KuxTciDcROfLIUGO7hyngUyoYGzVKHxjDxwUWDpmSia4EdIsfJcwujj7rSmCt9p3+XLycXRlNjZinbDAHTW6333xWB/QZ+n8IW4N95CqQBovhLSoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110921; c=relaxed/simple;
	bh=HfftTJPjDEBiS3XZWyhFp0FadvVaxBSkPzKEctVPVgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ew9KjiVJGu9H7CgkQquyfSKJqKBAPPCN6bIYP1gzC+JvvnjzcWY+Un60RMaHH5nI17nSIgtTI1PoYlXf5JCxd3XUSQWpkR7smRic7PCSy/8ze6B/surY8LiFlyObN7N6wohnC/fzAai9y+z8is6mipqh0Y7eIHoV3enSFEettGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UbeUi2H/; arc=none smtp.client-ip=95.215.58.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UbeUi2H/"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HfftTJPjDEBiS3XZWyhFp0FadvVaxBSkPzKEctVPVgs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787110915; v=1; x=1787715715;
 b=UbeUi2H/T6ZrQArqTmm5HphKKnFP6dbjMvqL3pzjX1TxqRtClU8K3iJawzPReLH7OkTfxpbH
 fHMT/kJvKS64qHq4uMpo91mMoLaq05i1Warb1RIN/YeSBbRigeiHbwmx4D+Dy6qqlfgDmps5pU3
 kvirke5+oZErOXueoBmyFkUI=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f1b:84cb:1036:829e:9bdc:e63d] (2600:381:1f1b:84cb:1036:829e:9bdc:e63d)
	by smtp.migadu.com with ESMTPS id 0838e8b488fad00c;
	Wed, 19 Aug 2026 03:41:45 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <25af2027-05cb-4559-a828-9bb421f1ad5a@linux.dev>
Date: Tue, 18 Aug 2026 20:41:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 02/10] bpf: Add helpers to describe the R0:R2
 return register pair
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
 <20260817042151.2286855-1-yonghong.song@linux.dev>
 <b8ef4589e63fb411f830f426eb4890901e99f30c.camel@gmail.com>
 <dfb4d201de87590bbca4663ede19fd6c4044035a.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <dfb4d201de87590bbca4663ede19fd6c4044035a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/18/26 12:53 PM, Eduard Zingerman wrote:
> On Tue, 2026-08-18 at 12:51 -0700, Eduard Zingerman wrote:
>> On Sun, 2026-08-16 at 21:21 -0700, Yonghong Song wrote:
>>
>> ...
>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index b3c474ba7140..f1f1268d29c6 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -385,27 +385,70 @@ bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog)
>> ...
>>
>>> +static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
>>> +{
>>> +	const struct btf *btf = env->prog->aux->btf;
>>> +	const struct btf_type *type;
>>> +	int subprog;
>>> +	u32 size;
>>> +
>>> +	if (!env->prog->jit_requested || bpf_prog_is_offloaded(env->prog->aux))
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * Skip the main program: its return value is the program's exit code,
>>> +	 * read out of R0, so it never uses the register pair. An extension does
>>> +	 * have a real prototype for subprog 0, but bpf_check_attach_target()
>>> +	 * refuses to replace a function returning more than 8 bytes.
>>> +	 */
>>> +	for (subprog = 1; subprog < env->subprog_cnt; subprog++) {
>>> +		type = subprog_ret_type(env, subprog);
>>> +		/*
>>> +		 * This runs before btf_validate_return_type(), so apply the same
>>> +		 * type filter here.
>>> +		 */
>>> +		if (!type || !(btf_type_is_struct(type) || btf_type_is_scalar(type)))
>>                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> I still think that only !type check is necessary here:
> Actually: if (!type || !btf_type_is_void(type)) ...
> since btf_resolve_size() does not like void.

Thinking through. I think your above suggestion is correct.
In later patch "bpf: Enable aggregate return types up to 16 bytes", we have

btf_validate_return_type():
	...
  	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
  		return 0;
  
+	if (btf_type_is_struct(t) && t->size <= 16) {
+		/*
+		 * A global function's caller models the return as an opaque
+		 * scalar pair, so it may only return scalars by value. A local
+		 * function is verified inline, so a pointer field stays tracked
+		 * and needs no such restriction.
+		 */
+		bool local_func = subprog && !is_global;
+
+		if (local_func || btf_type_is_scalar_struct(env, btf, t, 0))
+			return 0;
+	}

	return -EOPNOTSUPP;

So only the above 'return 0' types are supported (void, int, enum, struct etc.).
In bpf_compute_subprog_ret_regs(), we only need valid type and type won't be void.
The 'void' type is for btf_resolve_size(). For other types, btf_validate_return_type()
will reject earlier.

>
>> - btf_resolve_size can handle any type
>> - BTF validation should guarantee that return type is not e.g. BTF_KIND_VAR
>>    that would trigger -EINVAL
>> - for local subprograms verifier checks if r0/r2 bear compatible types anyway
>> - for global subprograms BTF compliance is enforced.
>>
>> Could you please explain why would you want to keep it here?
>>
>>> +			continue;
>>> +		if (verifier_bug_if(IS_ERR(btf_resolve_size(btf, type, &size)), env,
>>> +				    "cannot size return type of subprog %d", subprog))
>>> +			return -EFAULT;
>>> +		if (ret_regs_cnt(size) > 1) {
>>> +			subprog_info(env, subprog)->ret_reg_pair = true;
>>> +			env->prog->jit_required = 1;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>>   }
>>>   
>>>   const char *bpf_subprog_name(const struct bpf_verifier_env *env, int subprog)

