Return-Path: <SRS0=rZCH=SH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4B9C4360F
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 07:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0753D217D7
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 07:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfDEHon (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:44:43 -0400
Received: from www62.your-server.de ([213.133.104.62]:49942 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfDEHon (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Apr 2019 03:44:43 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hCJWi-00014K-0u; Fri, 05 Apr 2019 09:44:40 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hCJWh-000OHd-Pt; Fri, 05 Apr 2019 09:44:39 +0200
Subject: Re: [PATCH bpf-next v3 06/15] bpf: kernel side support for BTF Var
 and DataSec
To:     Martin Lau <kafai@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "joe@wand.net.nz" <joe@wand.net.nz>, Yonghong Song <yhs@fb.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
References: <cover.1554314902.git.daniel@iogearbox.net>
 <62cf123c51006a02c1ffa9aaaf2881a8eb292d59.1554314902.git.daniel@iogearbox.net>
 <20190404192049.qyae2zfzadb7os3a@kafai-mbp.dhcp.thefacebook.com>
 <20190405070312.uprjxyzyg6r3sm4l@kafai-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fc153a37-b59b-c0e7-c05a-ca5a499c30f1@iogearbox.net>
Date:   Fri, 5 Apr 2019 09:44:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190405070312.uprjxyzyg6r3sm4l@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25409/Thu Apr  4 09:53:59 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey Martin,

Thanks a lot for the feedback, much appreciated!

On 04/05/2019 09:03 AM, Martin Lau wrote:
> On Thu, Apr 04, 2019 at 07:20:51PM +0000, Martin Lau wrote:
>> On Wed, Apr 03, 2019 at 08:22:57PM +0200, Daniel Borkmann wrote:
>>> This work adds kernel-side verification, logging and seq_show dumping
>>> of BTF Var and DataSec kinds which are emitted with latest LLVM. The
>>> following constraints apply:
>>>
>>> BTF Var must have:
>>>
>>> - Its kind_flag is 0
>>> - Its vlen is 0
>>> - Must point to a valid type
>>> - Type must not resolve to a forward type
>>> - Must have a valid name
>>> - Name may include dots (e.g. in case of static variables
>>>   inside functions)
>>> - Cannot be a member of a struct/union
>>> - Linkage so far can either only be static or global/allocated
>>>
>>> BTF DataSec must have:
>>>
>>> - Its kind_flag is 0
>>> - Its vlen cannot be 0
>>> - Its size cannot be 0
>>> - Must have a valid name
>>> - Name may include dots (e.g. to represent .bss, .data, .rodata etc)
>>> - Cannot be a member of a struct/union
>>> - Inner btf_var_secinfo array with {type,offset,size} triple
>>>   must be sorted by offset in ascending order
>>> - Type must always point to BTF Var
>>> - BTF resolved size of Var must be <= size provided by triple
>>> - DataSec size must be >= sum of triple sizes (thus holes
>>>   are allowed)
>> Looks very good.  A few questions.
>>
>> [ ... ]
>>
>>> @@ -308,6 +320,7 @@ static bool btf_type_is_modifier(const struct btf_type *t)
>>>  	case BTF_KIND_VOLATILE:
>>>  	case BTF_KIND_CONST:
>>>  	case BTF_KIND_RESTRICT:
>>> +	case BTF_KIND_VAR:
>> Why BTF_KIND_VAR is added here?
>>
>> If possible, it may be better to keep is_modifier() as is since var
>> intuitively does not belong to the is_modifier() test.

Hmm, agree, it's probably better to keep btf_type_is_modifier() as-is,
I might have been mislead by the comment in that function. Need to
double check whether that could trigger the WARN in btf_type_id_size().

>>>  		return true;
>>>  	}
>>>  
>>> @@ -375,13 +388,27 @@ static bool btf_type_is_int(const struct btf_type *t)
>>>  	return BTF_INFO_KIND(t->info) == BTF_KIND_INT;
>>>  }
>>>  
>>> +static bool btf_type_is_var(const struct btf_type *t)
>>> +{
>>> +	return BTF_INFO_KIND(t->info) == BTF_KIND_VAR;
>>> +}
>>> +
>>> +static bool btf_type_is_datasec(const struct btf_type *t)
>>> +{
>>> +	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
>>> +}
>>> +
>>>  /* What types need to be resolved?
>>>   *
>>>   * btf_type_is_modifier() is an obvious one.
>>>   *
>>>   * btf_type_is_struct() because its member refers to
>>>   * another type (through member->type).
>>> -
>>> + *
>>> + * btf_type_is_var() because the variable refers to
>>> + * another type. btf_type_is_datasec() holds multiple
>>> + * btf_type_is_var() types that need resolving.
>>> + *
>>>   * btf_type_is_array() because its element (array->type)
>>>   * refers to another type.  Array can be thought of a
>>>   * special case of struct while array just has the same
>>> @@ -390,9 +417,11 @@ static bool btf_type_is_int(const struct btf_type *t)
>>>  static bool btf_type_needs_resolve(const struct btf_type *t)
>>>  {
>>>  	return btf_type_is_modifier(t) ||
>>> -		btf_type_is_ptr(t) ||
>>> -		btf_type_is_struct(t) ||
>>> -		btf_type_is_array(t);
>>> +	       btf_type_is_ptr(t) ||
>>> +	       btf_type_is_struct(t) ||
>>> +	       btf_type_is_array(t) ||
>>> +	       btf_type_is_var(t) ||
>> is_var() is also tested here on top of is_modifier().

Yeah, correct.

>>> +	       btf_type_is_datasec(t);
>>>  }
>>>  
>>>  /* t->size can be used */
>>> @@ -403,6 +432,7 @@ static bool btf_type_has_size(const struct btf_type *t)
>>>  	case BTF_KIND_STRUCT:
>>>  	case BTF_KIND_UNION:
>>>  	case BTF_KIND_ENUM:
>>> +	case BTF_KIND_DATASEC:
>>>  		return true;
>>>  	}
>>>  
>>
>> [ ... ]
>>
>>> +static int btf_var_resolve(struct btf_verifier_env *env,
>>> +			   const struct resolve_vertex *v)
>>> +{
>>> +	const struct btf_type *next_type;
>>> +	const struct btf_type *t = v->t;
>>> +	u32 next_type_id = t->type;
>>> +	struct btf *btf = env->btf;
>>> +	u32 next_type_size;
>>> +
>>> +	next_type = btf_type_by_id(btf, next_type_id);
>> Does the BTF verifier complain if BTF_KIND_VAR -> BTF_KIND_VAR -> BTF_KIND_INT?
>>
>> The same goes for BTF_KIND_PTR -> BTF_KIND_VAR -> BTF_KIND_INT.
> I was about to try but it seems I cannot apply the set cleanly.
> Likely due to some recent changes.
> 
> After a quick skim through, the above cases seem possible.

The tests currently only check whether we end up at BTF_KIND_VAR or
BTF_KIND_DATASEC, but as far as I'm aware would accept some intermediate
BTF_KIND_VAR type, which should be better rejected instead.

> If rejecting the above cases is desired,
> I think it may be easier to check them at the individual
> type's _resolve() instead of depending on the final resort
> btf_resolve_valid().  The individual type's _resolve() should
> know better what are the acceptable next_type[s].

Makes sense, I'll change that today and add more test coverage for
this particular case. Moving the check into individual type's
_resolve() handler is indeed probably the best we can do at this
point, though unfortunate duplication.

> I was thinking btf_resolve_valid() is more like a
> "btf verifier internal error" to ensure the
> earlier individual type's _resolve() is sane.
> 
> It seems at least the modifier_resolve() and ptr_resolve()
> are missing to reject BTF_KIND_FUNC.  I will code
> up a patch to fix BTF_KIND_FUNC.

Okay.

>>> +	if (!next_type) {
>>> +		btf_verifier_log_type(env, v->t, "Invalid type_id");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (!env_type_is_resolve_sink(env, next_type) &&
>>> +	    !env_type_is_resolved(env, next_type_id))
>>> +		return env_stack_push(env, next_type, next_type_id);
>>> +
>>> +	if (btf_type_is_modifier(next_type)) {
>> May be a few comments on why this is needed.  Together with
>> the is_modifier() change above, it is not immediately clear to me.

Yep, the change in is_modifier() needs to be dropped.

>> I suspect this could be left to be done in the btf_ptr_resolve()
>> as well if the ptr type happens to be behind the var type in
>> the ".BTF" ELF.
>>
>>> +		const struct btf_type *resolved_type;
>>> +		u32 resolved_type_id;
>>> +
>>> +		resolved_type_id = next_type_id;
>>> +		resolved_type = btf_type_id_resolve(btf, &resolved_type_id);
>>> +
>>> +		if (btf_type_is_ptr(resolved_type) &&
>>> +		    !env_type_is_resolve_sink(env, resolved_type) &&
>>> +		    !env_type_is_resolved(env, resolved_type_id))
>>> +			return env_stack_push(env, resolved_type,
>>> +					      resolved_type_id);
>>> +	}
>>> +
>>> +	/* We must resolve to something concrete at this point, no
>>> +	 * forward types or similar that would resolve to size of
>>> +	 * zero is allowed.
>>> +	 */
>>> +	if (!btf_type_id_size(btf, &next_type_id, &next_type_size)) {
>>> +		btf_verifier_log_type(env, v->t, "Invalid type_id");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	env_stack_pop_resolved(env, next_type_id, next_type_size);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>
>> [ ... ]
>>
>>> @@ -2622,13 +2983,17 @@ static bool btf_resolve_valid(struct btf_verifier_env *env,
>>>  	if (!env_type_is_resolved(env, type_id))
>>>  		return false;
>>>  
>>> -	if (btf_type_is_struct(t))
>>> +	if (btf_type_is_struct(t) || btf_type_is_datasec(t))
>>>  		return !btf->resolved_ids[type_id] &&
>>> -			!btf->resolved_sizes[type_id];
>>> +		       !btf->resolved_sizes[type_id];
>>>  
>>> -	if (btf_type_is_modifier(t) || btf_type_is_ptr(t)) {
>>> +	if (btf_type_is_modifier(t) || btf_type_is_ptr(t) ||
>>> +	    btf_type_is_var(t)) {
>>>  		t = btf_type_id_resolve(btf, &type_id);
>>> -		return t && !btf_type_is_modifier(t);
>>> +		return t &&
>>> +		       !btf_type_is_modifier(t) &&
>>> +		       !btf_type_is_var(t) &&
>>> +		       !btf_type_is_datasec(t);
>>>  	}
>>>  
>>>  	if (btf_type_is_array(t)) {
>>> -- 
>>> 2.9.5
>>>

