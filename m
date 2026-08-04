Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7956844AB68
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838256; cv=none; b=rGaSv/xdw31k5to+cgWNCVU0onFtK3zZTPj8Moxr7m70OJVaxnE5J+nrHZfGU6scUiVQDk018XMcuh79jqKe/xIrEKFYe/DDMUnvXne8jVrrmhHKYMyjvQe0Td928IPDcAbpXBvL9TsO6eU3l2vz77bP+jCCxY2QUt8QW28RLCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838256; c=relaxed/simple;
	bh=3LS7SmQMPn4ZNyRcndgHfU64Fewo90PTywg0Ik5GaOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVEl2ADoyhFcV3h9XosmWbby/jYPWTjMcfnd9sXeHzFPtCq6s6CQBAEHhpRnylE9UhIu8AJIiZ93fAg7VDc7kdjkBljiHkUNnyk64qHrhlS/IxCXNmMTNYB1G6mnOGWyDfK2slDVw3Szj4JNjrttR1ptjYquUfIJF5v+csKgBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U4/3lqSu; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U4/3lqSu"
Message-ID: <dd8e114a-7aa0-4657-ba28-2929ebca0973@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785838251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqmXyZ+ydu7k847fTb4+bNha4IF2MJ31SeOi++fTq9E=;
	b=U4/3lqSufnDD0WS5sbifzBSyaHsEbf5BNCXi/uyqz6hi+Xna/FK0CQnOcM3ZhkLu83pTr3
	R3Hw8XFVfgc4di7forFSx9gLSZcWAXTpa/uTd1w8jWWaEbHDv6GkHSxQydN3qcwir9Ml9+
	o08Az9uXAV9mqbmBmG42P/TBbx0veh0=
Date: Tue, 4 Aug 2026 18:09:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: add KF_SPIN_LOCK flag for kfuncs under bpf_spin_lock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kaitao Cheng <chengkaitao@kylinos.cn>
References: <20260804083212.79271-1-kaitao.cheng@linux.dev>
 <DKG0YUDSTBUY.1X220287HT9V3@gmail.com>
 <4aa061ed-6640-42b4-9f12-e33edb8ba1b2@linux.dev>
 <DKG27RH0P7OV.36PQRQ6C74UR0@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <DKG27RH0P7OV.36PQRQ6C74UR0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/8/4 17:42, Kumar Kartikeya Dwivedi 写道:
> On Tue Aug 4, 2026 at 11:37 AM CEST, Kaitao Cheng wrote:
>> 在 2026/8/4 16:43, Kumar Kartikeya Dwivedi 写道:
>>> On Tue Aug 4, 2026 at 10:32 AM CEST, Kaitao Cheng wrote:
>>>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>>>>
>>>> Introduce the KF_SPIN_LOCK kfunc metadata flag in BTF so kfuncs may be
>>>> explicitly marked as safe to call while holding bpf_spin_lock.
>>>>
>>>> Allow kfuncs defined in kernel modules to be marked with KF_SPIN_LOCK.
>>>>
>>>> Example: BTF_ID_FLAGS(func, $kfunc_name, KF_SPIN_LOCK)
>>>>
>>>> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
>>>> ---
>>>>  include/linux/btf.h   |  1 +
>>>>  kernel/bpf/verifier.c | 20 +++++++++++++++-----
>>>>  2 files changed, 16 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>>> index c09b7994de4e..380dc10b6750 100644
>>>> --- a/include/linux/btf.h
>>>> +++ b/include/linux/btf.h
>>>> @@ -79,6 +79,7 @@
>>>>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
>>>>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
>>>>  #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
>>>> +#define KF_SPIN_LOCK    (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
>>>>
>>>>  /*
>>>>   * Tag marking a kernel function as a kfunc. This is meant to minimize the
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 7aa47342dc65..9f3feba3c2fe 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -11657,11 +11657,21 @@ static bool is_bpf_stream_kfunc(u32 btf_id)
>>>>  	       btf_id == special_kfunc_list[KF_bpf_stream_print_stack];
>>>>  }
>>>>
>>>> -static bool kfunc_spin_allowed(u32 btf_id)
>>>> +static bool kfunc_spin_allowed(struct bpf_verifier_env *env, s32 func_id, s16 offset)
>>>>  {
>>>> -	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_id) ||
>>>> -	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_id) ||
>>>> -	       is_bpf_stream_kfunc(btf_id);
>>>> +	struct bpf_kfunc_meta kfunc;
>>>> +	int err;
>>>> +
>>>> +	if (is_bpf_graph_api_kfunc(func_id) || is_bpf_iter_num_api_kfunc(func_id) ||
>>>> +	    is_bpf_res_spin_lock_kfunc(func_id) || is_bpf_arena_kfunc(func_id) ||
>>>> +	    is_bpf_stream_kfunc(func_id))
>>>> +		return true;
>>>> +
>>>> +	err = fetch_kfunc_meta(env, func_id, offset, &kfunc);
>>>> +	if (err || !kfunc.flags)
>>>> +		return false;
>>>> +
>>>> +	return *kfunc.flags & KF_SPIN_LOCK;
>>>>  }
>>>>
>>>>  static bool is_sync_callback_calling_kfunc(u32 btf_id)
>>>> @@ -17289,7 +17299,7 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>>>>  				     insn->imm != BPF_FUNC_spin_unlock &&
>>>>  				     insn->imm != BPF_FUNC_kptr_xchg) ||
>>>>  				    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>>>> -				     (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
>>>> +				     !kfunc_spin_allowed(env, insn->imm, insn->off))) {
>>>>  					verbose(env,
>>>>  						"function calls are not allowed while holding a lock\n");
>>>>  					return -EINVAL;
>>>
>>> Why not apply it to all of the existing kfuncs? Also, use [PATCH bpf-next] subject.
>>
>> I do not think all kfuncs are suitable for the KF_SPIN_LOCK context.
>> Kfuncs marked with KF_SLEEPABLE are an obvious example. Developers
>> should add KF_SPIN_LOCK with great care and ensure that the kfunc
>> does not sleep and is safe to call in atomic context; otherwise, it
>> could easily introduce deadlocks.
>>
>> However, the kfuncs explicitly allowed by kfunc_spin_allowed(), such
>> as those covered by is_bpf_graph_api_kfunc, is_bpf_iter_num_api_kfunc,
>> is_bpf_res_spin_lock_kfunc, is_bpf_arena_kfunc and is_bpf_stream_kfunc,
>> can be marked with KF_SPIN_LOCK. We can then simplify kfunc_spin_allowed()
>> to rely solely on the flag.
> 
> Yes, of course. I meant those that we maintain as a list in the verifier.
> KF_SPIN_LOCK is not a very optimal name. Should we do KF_ALLOWED_IN_LOCK_CS?
> A bit verbose but better captures the intended meaning.

The existing KF_* flag names are generally concise, so a much longer name
feels somewhat out of place. I would also prefer the name to preserve the
full spin_lock semantics, since "lock" can refer to many different lock
types, such as mutex.

Alternatively, following the naming of GFP_ATOMIC, could we call it KF_ATOMIC?

-- 
Thanks
Kaitao Cheng

