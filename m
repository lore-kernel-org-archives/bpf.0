Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05D1C84B8
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873274; cv=none; b=HlpcGDMb0mk6/+aR3HooHcprBDafOczsfW/gAbWJ0at9nPiMyEewwG1TwKIq/5m+/vP4WTHn9Zdi4FGR/REORL3AAiFxN63am+oYXEvUPLNwr6l46YNR60Xs00ky3wNycAItUJv+lAu8CjvSdJKHu0X/qL/Lok5+cD0w5RNNVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873274; c=relaxed/simple;
	bh=uNHlM/OUghmwUIr/wXolzpk141kMEK6lQsQNkhJQWYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFg29IavYfygy4xknnuXTCeemwSL3VJg2msQyk+m8vjUlF/oISHTB79JG9mi9C40K3fLQbIZ1ejNikZjFQ9n6Hvhl7jW2IXn6EzT3zLmRhZ8ouP96Eiea6higKP1fDvjzab+mc0ybhyqCsFnPluUZJIQ+oX/KMUGQ7zDxSXoYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ie+hQ9RR; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ie+hQ9RR"
Message-ID: <0bad7d06-f9a4-47a2-b693-8e47db97aadb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773873269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0nz43ZyUEaOpti8hfoI/xldq3VsdhOhkYb/sEsBuEFk=;
	b=Ie+hQ9RRZ0XqlBqfAPVZzT+kM484sFKwph7lJB7V7fjG4nEo03MuGdh4e3ySe35DLe6XdS
	W0iwlHcaxgIMr3W/KncvDs/SmVmJjkkSD9r1W0cHACnYSq8VaZCHJG4adgKA7G8hhFStlJ
	8HlF0BPlrvZrvyLYZxJssdUaHnwD4+I=
Date: Wed, 18 Mar 2026 15:34:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Update kfuncs using
 btf_struct_meta to new variants
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com
Cc: alexis.lothore@bootlin.com, bpf@vger.kernel.org, kernel-team@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com
References: <20260312193546.192786-2-ihor.solodrai@linux.dev>
 <2512f1b588a1828236698c2c6228d9dc3892d98b33c534a8cfe4c288860e1ff3@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <2512f1b588a1828236698c2c6228d9dc3892d98b33c534a8cfe4c288860e1ff3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/12/26 1:05 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
>> --- a/tools/testing/selftests/bpf/bpf_experimental.h
>> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>> @@ -8,156 +8,11 @@ #define __BPF_EXPERIMENTAL__
>>  #define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
> 
> [ ... ]
> 
>> -extern void *bpf_percpu_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
>> +/* Convenience macro to wrap over bpf_obj_new */
>> +#define bpf_obj_new(type) ((type *)bpf_obj_new(bpf_core_type_id_local(type)))
>>
>>  /* Convenience macro to wrap over bpf_percpu_obj_new_impl */
>> -#define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_new_impl(bpf_core_type_id_local(type), NULL))
>> +#define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_new(bpf_core_type_id_local(type)))
> 
> The comment above bpf_percpu_obj_new still says "wrap over
> bpf_percpu_obj_new_impl" but the macro now wraps bpf_percpu_obj_new.

Will fix.

> 
>> -extern void bpf_percpu_obj_drop_impl(void *kptr, void *meta) __ksym;
> 
> The extern for bpf_percpu_obj_drop_impl is removed here, but later
> in the same file the bpf_percpu_obj_drop macro was not updated:
> 
>     /* Convenience macro to wrap over bpf_obj_drop_impl */
>     #define bpf_percpu_obj_drop(kptr) bpf_percpu_obj_drop_impl(kptr, NULL)
> 
> Was bpf_percpu_obj_drop missed? Every other kfunc in this commit was

Yes it was. Good bot.

> moved from the _impl variant to the new KF_IMPLICIT_ARGS variant
> (bpf_obj_new, bpf_obj_drop, bpf_percpu_obj_new, bpf_refcount_acquire,
> bpf_list_push_front, bpf_list_push_back, bpf_rbtree_add), but
> bpf_percpu_obj_drop still goes through bpf_percpu_obj_drop_impl.
> 
> The macro is used in test_bpf_ma.c in batch_percpu_alloc() and
> batch_percpu_free().
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23020502189

