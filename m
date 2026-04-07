Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021A337110;
	Tue,  7 Apr 2026 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775587265; cv=none; b=IlSDsCUjZU6HJKGtKvAdYak+TW0utvKRDHQ9sexX13tRW312WSU9Dn1bK+r0tJq4c5J5Hf5xzChdnE8JGABBOUOzZ1lqWDsc+hg6K4hy40yujwNOniwEXgtYW2OqL1srpON0fyCiAZ87kxP3lcdkUx5IpiIbV2D+QdRK+s2BJCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775587265; c=relaxed/simple;
	bh=Vgoh9psjabACNffbt+5ZY22uG8xKmP766hYx26sSqj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9N1fw1vCoa/TCPLh6TfMoohHy4lv1MxAmLUPnFQOAGl+IpdZNzedkWFBg2dnD6yuqvcwUnlN2WyIDeE9eLWb24duYHmKOC9wbhI5Y2bW35J/9DucgcPfJ1BFSbHAY5qVMpYdnoF0s7jI8rXTQDcOgeE4dmYBnQVwlRIfE6Ifwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h0+xKwvt; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h0+xKwvt"
Message-ID: <82148eb1-f270-48f1-8900-e0becc6384e8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775587250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pbB/7yM9qnWDUuBrZvpjAMidUIj7HvUtBOVsbYidjw=;
	b=h0+xKwvtmES4t2E/F0q+G9TXlDuoTaDFh/rZeodnMPmb8RXBsVHH8kYLzDhV1NPWTdjP29
	WyuA/8QwIb8Xp+cGHq57odMx6LDxhDsStTjof8Hg0zpFTUlUNoBkTXLTNnnR97OoVyk3GT
	LlCJKOYwAKdYmx3n2sW7LhOjM/FdhWE=
Date: Tue, 7 Apr 2026 11:40:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 1/9] bpf: refactor kfunc checks using
 table-driven approach in verifier
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Chengkaitao <chengkaitao@kylinos.cn>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20260329140506.9595-1-pilgrimtao@gmail.com>
 <20260329140506.9595-2-pilgrimtao@gmail.com>
 <CAADnVQ+xS4ti=cSqAnG4ePmjEZXUb-8Ss9cjkWiiWgtv-_NNVQ@mail.gmail.com>
 <CAAWJmAYxbEX0M3JFJn11WOfvRoLrxnuXtkDp5omt-FJYwc8mpg@mail.gmail.com>
 <1fcda49a-caeb-42b9-9727-d1ab3d07d84b@linux.dev>
 <CAAWJmAYNS-NaY-57Pt=GC5qSpbfJLKwydVXfem6ckwgFW9aTnw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAAWJmAYNS-NaY-57Pt=GC5qSpbfJLKwydVXfem6ckwgFW9aTnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/4/26 3:38 AM, Chengkaitao wrote:
> On Sat, Apr 4, 2026 at 12:49 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>> On 4/3/26 10:41 AM, Chengkaitao wrote:
>>> On Tue, Mar 31, 2026 at 1:05 AM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> On Sun, Mar 29, 2026 at 7:05 AM Chengkaitao <pilgrimtao@gmail.com> wrote:
>>>>>
>>>>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>>>>>
>>>>> [...]
>>>>> +
>>>>> +/* Kfunc family related to spin_lock. */
>>>>> +static const enum special_kfunc_type bpf_res_spin_lock_api_kfuncs[] = {
>>>>> +       KF_bpf_res_spin_lock,
>>>>> +       KF_bpf_res_spin_unlock,
>>>>> +       KF_bpf_res_spin_lock_irqsave,
>>>>> +       KF_bpf_res_spin_unlock_irqrestore,
>>>>> +};
>>>>
>>>> I think it's a step in the wrong direction.
>>>> I'd wait for Ihor's BTF_ID_NAMED cleanup.
>>>
>>> After reading Ihor's messages on the list, if I understand correctly,
>>> our two approaches seem to target different problems. What Ihor's
>>> work appears to achieve is the ability to remove the entire enum
>>> special_kfunc_type. My goal, on the other hand, is to replace many
>>> scattered func_id == special_kfunc_list[...] comparisons with a
>>> table-driven approach.
>>
>> Hi Kaitao,
>>
>> I appreciate your efforts, however after a quick pass over the changes
>> you propose (both here and in the new series) with respect to BTF_ID
>> macros and special_kfuncs_list, I don't understand what problem you're
>> trying to solve.
>>
>> The inherent complexity is in the fact that the verifier must know
>> when a particular BTF id identifies a specific kfunc, or whether it
>> belongs to some pre-defined set of ids. This is why
>> special_kfuncs_list and other BTF_ID_SET/LIST-s exist.
>>
>> And so there is no way around defining those ids and sets *somewhere*,
>> and so far BTF_ID_* macros did a fine job of that, all things
>> considered.
>>
>> AFAICT your changes simply move around the same definitions from
>> functions with if statements to constant arrays with a runtime search
>> on them (which is slower by the way). What is the benefit of that vs
>> the current implementation? We still have to maintain those arrays in
>> the same way we have to maintain the is_foo_kfunc helpers.
>>
>> Your newer proposal [1] takes the same idea to the next level, by
>> introducing an entire new BTF kind, new ELF sections and a bunch of
>> macros that are no less complicated than existing. And all of that
>> just moves the same arrays "upstream" to the .BTF_ids section. Again,
>> I fail to see any benefits to that complexity. Having differentiation
>> between LIST and SET, and having to mark START and END is not a
>> problem that needs solving IMO.
> 
> Your analysis of the code implementation for the new proposal is correct.
> Let me elaborate on the purpose behind my approach.
> 
> ****** Purpose 1 ******
> 
> As described in this patch:
> https://lore.kernel.org/bpf/20260303135219.33726-4-pilgrimtao@gmail.com/
> 
> If we want to add a new kfunc, bpf_list_add_impl, we would today have
> to add "btf_id == special_kfunc_list[KF_bpf_list_back]" (or similar)
> five times in verifier.c. ...

Kaitao,

I think the maintainability pain in the current verifier-side kfunc
handling is clear, I don't think anyone would argue that it's not a
problem. Your bpf_list_* work is a good demonstration of that. I agree
it can be improved.

That said, I don't think extending .BTF_ids and/or BTF is the right
way to solve it.

> ... Under the newer proposal, that is no longer
> necessary: defining the kfunc and its verifier metadata in one place
> is enough, for example:
> 
> __bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
>  struct bpf_list_node *new,
>  struct bpf_list_node *prev,
>  void *meta__ign, u64 off)
> {
> /* kfunc implementation */
> .......
> }
> BPF_VERIF_KFUNC_DEF(bpf_list_add_impl, list_api, graph_node_api, ... )
> 
> If BPF_VERIF_KFUNC_DEF is extended further, BTF_ID(func, bpf_list_add_impl)
> and BTF_ID_FLAGS(func, bpf_list_add_impl) might also become unnecessary,
> so the snippet above could eventually be close to all the code required
> to add a new kfunc.

Defining a kfunc metadata in one place is a reasonable direction in
principle, I agree.

Where I disagree is the mechanism. The complexity does not disappear,
it just moves into .BTF_ids, new macros and resolve_btfids. The
primary consumer of this metadata is the verifier, and I think it is
better to keep that metadata in verifier-local C definitions instead
of encoding it into .BTF_ids. Adding more indirection to this will
only hurt maintainability IMO.

> 
> ****** Purpose 2 ******
> 
> The kernel no longer needs enum special_kfunc_type to list every KF_bpf_*
> entry. That information is folded into the .BTF_ids.##sfx section instead,
> so kfunc authors do not have to touch or think about special_kfunc_type.

This is not an argument for the .BTF_ids extension. Removing
`special_kfunc_type` mirroring is useful, but that will be addressed
directly by the targeted cleanup already under discussion.

> 
> ****** Purpose 3 ******
> 
> As described in this patch:
> https://lore.kernel.org/bpf/20260303135219.33726-6-pilgrimtao@gmail.com/
> 
> In is_bpf_list_api_kfunc(u32 btf_id) there are on the order of eleven
> "btf_id == special_kfunc_list[*]" comparisons. As more kfuncs are added,
> every is_bpf_* helper will only grow longer and the verifier will get
> more repetitive. With the new design, those is_bpf_* helpers can be
> removed entirely, including the awkward scattered "btf_id == *" checks.

The repetition is real. But removing is_bpf_*() helpers is not
automatically a simplification if the same information is now encoded
indirectly through section layout or local const arrays.

The same metadata is being maintained somewhere else, with more
indirection than before. The complexity just moved around, and was not
reduced.

The scattered "btf_id == *" will remain as long as it is necessary for
the verifier to do certain checks or other work depending on the
kfunc. Whether it's an array lookup, helper call or anything else in
the condition, the condition must be there. Refactoring can't reduce
this complexity, without changes in the verifier control flow.

> 
> ****** Purpose 4 ******
> 
> It pushes us to untangle messy verifier safety cases and make them modular,
> so they can be expressed as parameters to BPF_VERIF_KFUNC_DEF

Again, I agree with the premise that verifier safety checks could
become more modular where possible. But I think we should first
separate two questions:

1. What kfunc properties should be declared centrally?
2. Where that declaration should live?

While I'd like to answer (1) with "all of them", I am not convinced
the answer to (2) is .BTF_ids or BTF. A better C side declarative
representation would give us most of the benefit here without making
the BTF tooling more complex.

Here is how I think we should move forward:

  1. Your bpf_list_* work is orthogonal to BTF_ID refactoring, so it's
  reasonable to first focus on landing it without changes to generic
  kfunc handling.

  2. I plan to send patches (soon) for resolve_btfids, and then for
  BTF_ID macrology to eliminate the enum + array pattern. You are
  welcome to join the discussion and review / test the patches.

  3. After all of the above lands, we can come back to the general
  BTF_ID / kfunc handling discussion. If you are interested in
  developing this further, I suggest to re-think the approach and come
  up with a "single kfunc metadata definition" that doesn't require
  significant changes in .BTF_ids section layout.

A slightly off-topic comment: the usage of `_impl` pattern for kfuncs
should be considered deprecated. Any new kfuncs that work with
verifier-supplied arguments should use KF_IMPLICIT_ARGS mechanism.  So
the `bpf_list_add_impl` in your seires should only have one version:
`bpf_list_add` marked with KF_IMPLICIT_ARGS flag.

Thanks,
Ihor


> 
>> [...]
> 

