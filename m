Received: from mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6E38B12A
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787938823; cv=none; b=tFO2OyGillFeN5dKbdigO60UwlU4W4Yu1o9hQb4ekPrQlunSTS376f81pYYjJK0vjYf64uWb2v6KlCTJPGKskR9ENCjtvfP2FV8fU57YOKk6qviZakzBLm/ZhJ65Innf06BrVBotqQ7khyJuoF4c2FXlU/QbEx95mtlo8TvYO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787938823; c=relaxed/simple;
	bh=tjqdLI9dDs7YXvD8uA0WyW2s+ihkxDITagZYf6JoSwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5gkwsqSbbQyT5l3xH7++g+aCBcvn/6VDMv682mUjbJwnZsOX8rAcJsI+pX+Gc75dbQtU5NfSjRK8ngPer9mbS3XYqUGBT/P7NAP18h0m3fnQzTy991SZrgEP/LKa0/JuQLHTPOQmL5Hs+LbJ653y3leNvisDs07uiYHRCIAVXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VWhVQzmr; arc=none smtp.client-ip=91.218.175.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VWhVQzmr"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tjqdLI9dDs7YXvD8uA0WyW2s+ihkxDITagZYf6JoSwY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787938818; v=1; x=1788543618;
 b=VWhVQzmrKxQXsdw6zvKaldqMpZX2CteNGXUs+zXm2KQXgCQqjZ4XfpTXE9CF2O2ieHnMJNGk
 npFVUmszW3H9LGhnvk3cKnNYFtwRzbKCQzeROdd6Lwi1tzmiKP3MBUL59ChwqbrtHMHAp8GB5/t
 fwGWy7ByNNrHdFOfaXJlKIXU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 530129a2e723ee8f;
	Fri, 28 Aug 2026 17:40:03 +0000
X-Mizu-Trace-ID: 530129a2e723ee8f
X-Migadu-Flow: FLOW_OUT
Message-ID: <00a44bfd-4503-4b62-964d-d6e3b01a67b4@linux.dev>
Date: Fri, 28 Aug 2026 10:39:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 02/11] bpf: Drop the recursion depth argument
 of btf_type_is_scalar_struct()
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260827061125.2516013-1-yonghong.song@linux.dev>
 <2c5f70a3b993229bd5edbd754adc21195dd802515a2320523ce443859f03bef7@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2c5f70a3b993229bd5edbd754adc21195dd802515a2320523ce443859f03bef7@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/27/26 12:04 AM, bot+bpf-ci@kernel.org wrote:
>> commit 05b126fd8e09fdf16e522924b7a453dc9050c44b
>> Author: Yonghong Song <yonghong.song@linux.dev>
>> Date:   Wed Aug 26 23:11:25 2026 -0700
>>
>>      bpf: Drop the recursion depth argument of btf_type_is_scalar_struct()
>>
>>      btf_type_is_scalar_struct() recurses into nested struct members and
>>      carries the nesting depth in a @rec argument, so every caller has to
>>      spell out the 0 that starts the walk.
>>
>>      Move the recursion into a static helper that keeps @rec and leave
>>      btf_type_is_scalar_struct() as a thin wrapper over it, so callers only
>>      name the type they are asking about.
>>
>>      No functional change.
> This isn't a bug, but would it help to say the split is in preparation
> for giving the walk extra state, rather than presenting it as call-site
> tidying?
>
> Looking at the next patch in the series, 'bpf: Let the by-value struct
> walk take the kinds of member it accepts', a @member_kinds parameter is
> added to exactly this walk helper, which looks like the load-bearing
> reason for introducing the wrapper now. As written, a reviewer reading
> this patch alone sees only a cosmetic change and has no way to tell it
> is groundwork.

I think we are fine. This is a pure refactoring to remove a parameter
for a global function.

>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 004b06785521c..3eb61edc8c5e1 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -1489,7 +1489,7 @@ struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
>>   void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
>>   bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
>>   bool btf_type_is_scalar_struct(struct bpf_verifier_env *env, const struct btf *btf,
>> -			       const struct btf_type *t, int rec);
>> +			       const struct btf_type *t);
>>
>>   int bpf_find_subprog(struct bpf_verifier_env *env, int off);
>>   bool bpf_is_throw_kfunc(struct bpf_insn *insn);
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 5d8162e13c208..bc3053e81500f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -11647,9 +11647,8 @@ static bool is_kfunc_arg_implicit(const struct bpf_call_arg_meta *meta, u32 arg_
>>   }
>>
>>   /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
>> -bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>> -			       const struct btf *btf,
>> -			       const struct btf_type *t, int rec)
>> +static bool btf_scalar_struct_walk(struct bpf_verifier_env *env, const struct btf *btf,
>> +				   const struct btf_type *t, int rec)
>>   {
>>   	const struct btf_type *member_type;
>>   	const struct btf_member *member;
>> @@ -11667,7 +11666,7 @@ bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>>   				verbose(env, "max struct nesting depth exceeded\n");
>>   				return false;
>>   			}
>> -			if (!btf_type_is_scalar_struct(env, btf, member_type, rec + 1))
>> +			if (!btf_scalar_struct_walk(env, btf, member_type, rec + 1))
>>   				return false;
>>   			continue;
>>   		}
>> @@ -11686,6 +11685,13 @@ bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>>   	return true;
>>   }
>>
>> +bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>> +			       const struct btf *btf,
>> +			       const struct btf_type *t)
>> +{
>> +	return btf_scalar_struct_walk(env, btf, t, 0);
>> +}
> This isn't a bug, but since the following patch renames both of these,
> could this patch introduce the final names directly so the call sites
> and the header prototype are only touched once?
>
> Both names introduced here are renamed one commit later in the same
> series: btf_scalar_struct_walk() becomes btf_struct_member_walk() and
> btf_type_is_scalar_struct() becomes btf_struct_is_composed_of() in
> 'bpf: Let the by-value struct walk take the kinds of member it accepts',
> which also re-touches the include/linux/bpf_verifier.h prototype and
> all six call sites a second time.

Not sure what is going here. The following is actual code:

+bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
+                              const struct btf *btf,
+                              const struct btf_type *t)
+{
+       return btf_struct_member_walk(env, btf, t, 0);
+}

which does not have btf_scalar_struct_walk().

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33045482525

