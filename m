Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70033BC679
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773355384; cv=none; b=Ek4hLNSGuwMZTnmVsq9I6J6I2BX47/7K/K9YDh3Kge+8sPYvWWXA9Vbyo6mYOVrNpKC1KnxebGMnPH4of3eWU3hRz/AAdalxxOxc8erVg3KxCRW9WY38J0e34EosGCztfwb6kh77CIv9l/6RPaF3alwguE9cA0seCs4TKiwSN7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773355384; c=relaxed/simple;
	bh=oBpZEq7XaKhbMPeKOoQOwReV8l6uBXykFpANWvFD36Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3QmxZK5A8ynzk9NbR6clXXqPnAX4f30XepwiSFZJBnqzkyAkdyWG/hH1b64KHd+88l6HyjBpYqL2XWLnzhRI4dDEmZiH8VMzKZ5TsqV3BwA7kyOfBuMVNJjPVL3zCRi3fEG75ESaJscB7Bc7elnfp1FvyqJtPW9zRIwrmQpqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ORUO37l5; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ORUO37l5"
Message-ID: <3d069965-2992-421f-bb94-827bcb177f17@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773355379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7TTZlt+Oh5R8bonvxLWIztllC/URVxGt65WHBHQPDM=;
	b=ORUO37l5hMAL5waV0j2QF0AOIH+lxF//0h+WmRcCKhI1FMZPhG1Y2hjSZDzKdp2eFmhrnL
	aDKkzIUHI8BQIBz+0QQeueFloXCtq21ndGyH4n08zX9PoAbFF1z/GE0Ovav+7qKd+pPYgB
	7sMxa40i0JhdxCWXC7HkCPMcKGP3iak=
Date: Thu, 12 Mar 2026 15:42:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, bpf@vger.kernel.org, kernel-team@meta.com
References: <20260312193546.192786-1-ihor.solodrai@linux.dev>
 <CAEf4BzbhBqrPxAtw2xE2aeO8nVaHggV2TVNrMrTJVQTg05X0tQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzbhBqrPxAtw2xE2aeO8nVaHggV2TVNrMrTJVQTg05X0tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/12/26 2:24 PM, Andrii Nakryiko wrote:
> On Thu, Mar 12, 2026 at 12:36 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> The following kfuncs currently accept void *meta__ign argument:
>>   * bpf_obj_new_impl
>>   * bpf_obj_drop_impl
>>   * bpf_percpu_obj_new_impl
>>   * bpf_percpu_obj_drop_impl
>>   * bpf_refcount_acquire_impl
>>   * bpf_list_push_front_impl
>>   * bpf_rbtree_add_impl
>>
>> [...]
>>
>>                 /* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
>> -               if (desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>> +               if (is_bpf_rbtree_add_kfunc(desc->func_id)) {
>>                         struct_meta_reg = BPF_REG_4;
>>                         node_offset_reg = BPF_REG_5;
>>                 }
> 
> the amount of very specific "is this a special function X"
> special-casing is depressing... did you try to analyze if we can
> generalize this knowing which implicit argument we are dealing with?
> (not keeping my hopes high, but I had to ask)

I am open to suggestions, but fundamentally special_kfunc_list exists
because in special places in the verifier the function needs to be
handled in a special way ¯\_(ツ)_/¯

is_bpf_foo_kfunc() is needed with this change only because we have
to be backward compatible. It's either with helpers or the same thing
inlined, and helpers IMO is easier to read.

> 
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index 5208f650080f..f8a91fa7584f 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
>> @@ -1065,6 +1065,7 @@ static bool is_kf_implicit_arg(const struct btf *btf, const struct btf_param *p)
>>  {
>>         static const char *const kf_implicit_arg_types[] = {
>>                 "bpf_prog_aux",
>> +               "btf_struct_meta",
> 
> should we add typedef u64 bpf_implicit_offset_t or something like that
> to actually have unique and meaningful types for any kind of implicit
> argument?

I considered this, but didn't try.
Didn't see much benefit at this point.

We have to choose a convention, for example:

  "Implicit arguments can *only* be of particular types."
  (that's the current state of things, without the patch)

This implies that, at least in principle, the position of the implicit
arg can be arbitrary. But that's not true right now due to how
resolve_btfids is implemented (note the "break" in the loop) [1].

And because it's not true, I can get away with leaving u64 off as is.

If we also add to the convention that "in a kfunc, all implicit
arguments always follow all required arguments", then why would we
require all implicit arguments to be of specific types? Do we want to
enforce the BTF type in the verifier even if it's u64?

We are going to be in trouble if someone decides to add implicit
primitive arguments *only* (without a preceding implicit pointer).
Using an __impl suffix gives me an ick, so if we anticipate
such use-cases, that'd be a strong argument for special typedefs.

I think the is_kfunc_arg_implicit() in this patch is a good way to
determine implicitness in the verifier, so the above applies mostly to
how resolve_btfids determines which args are implicit.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/bpf/resolve_btfids/main.c?h=v7.0-rc3#n1187

> 
>>         };
>>         const struct btf_type *t;
>>         const char *name;
>> --
>> 2.53.0
>>

