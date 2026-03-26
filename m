Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E6370D79
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552394; cv=none; b=Lm3SoFluXYVMV5GenNYQnvmU4yieyrUiOM12tRgiskvvHJglirjlcxcpw0ToLIiIBM0OX28AJfgDfb+xlC5mjPi4iP9p2ZDkZwc32WQ3ldAXR6i6Cgk966pIl37USPSw42CvDtkNUa92zRouPbpHMckj7nRnKL+CYMLL8jBdIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552394; c=relaxed/simple;
	bh=pf9ZQ+lH647zhszsz3EhxQRLQrAmDImDzxZwYHkEDoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjSNg+wz1jvdFUkwzNDjFX+T+1BLHr8n4vXt6SRIcwxmGD8WpF5ncTGn+NPmCn38bA+uj/ieonDG0zH2l5/4Cpgf19BS6qqt8xMR6+Stp5kVeIKOaWKyboGTzOpOezOtbmmEmNeGPU2HkSKSm2kiZtcoWI0W2pUDwt54rmD7ft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gQLvUhWT; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gQLvUhWT"
Message-ID: <21e5333c-0b57-46ce-99c8-f6c414270e70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774552390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enFT8MncxCfJ7fwyQpwtjf6fdkgaFofiamyW0Qdby6U=;
	b=gQLvUhWTgs0MCeZvHRlf+L1q+FERKX7ASZuuF2MkWx+nExXfxxEZkQsLGKt4uVVBUB09zq
	qn7aVjwzIXWt/Xk6Vo2ZOb6XZR46kxuHYp/VGZqgmk8HThQT3mxM7lK5DHE0pV/z70iOv4
	EoT8aDIP4q+r08Hik5mSMCY24iJLcPk=
Date: Thu, 26 Mar 2026 12:13:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <CAADnVQ+iXJK46cFcGN-Ta8KGxe7Y+m_DxgWNS=QC-gOWT=WxCw@mail.gmail.com>
 <b040711c-0fd1-475f-b807-e4e0b4324f6e@linux.dev>
 <CAADnVQKVEYhFXGXJ0u6TWQDe4t=zmq_tLpGKe2n_pOYT-J58qA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQKVEYhFXGXJ0u6TWQDe4t=zmq_tLpGKe2n_pOYT-J58qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/24/26 10:22 AM, Alexei Starovoitov wrote:
> On Mon, Mar 23, 2026 at 12:58 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 3/21/26 1:27 PM, Alexei Starovoitov wrote:
>>> On Wed, Mar 18, 2026 at 4:42 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>>
>>>>                                         const struct btf *btf,
>>>> @@ -12594,6 +12620,14 @@ enum special_kfunc_type {
>>>>         KF_bpf_session_is_return,
>>>>         KF_bpf_stream_vprintk,
>>>>         KF_bpf_stream_print_stack,
>>>> +       KF_bpf_obj_new,
>>>> +       KF_bpf_percpu_obj_new,
>>>> +       KF_bpf_obj_drop,
>>>> +       KF_bpf_percpu_obj_drop,
>>>> +       KF_bpf_refcount_acquire,
>>>> +       KF_bpf_list_push_front,
>>>> +       KF_bpf_list_push_back,
>>>> +       KF_bpf_rbtree_add,
>>>>  };
>>>
>>> it's not an uapi. no need to add them to the end.
>>> Pls add them next to _impl flavors.
>>>
>>> The whole thing needs a full refactor in a long term.
>>> special_kfunc* thingy got out of hand.
>>
>> I thought about this a little and tried a couple of ideas.  Here is
>> one that looks a bit better to me than KF_* enum: BTF_ID_LIST_NAMED()
>> and BTF_ID_NAMED().
>>
>> I vibe-coded a PoC [1]. Essentially, we add a set of macros to
>> generate source-level stable symbol for each BTF_ID_LIST entry. Then
>> it is possible to refer to the associated value directly by name.
>>
>> It looks like this:
>>
>> +#define BTF_ID_LIST_NAMED(name)                                \
>> +       __BTF_ID_LIST(name, local)                      \
>> +       extern u32 name[];
>> +
>> +#define BTF_ID_NAMED(list, prefix, name)               \
>> +       __BTF_ID(__BTF_ID__##prefix##__##name##__##list, "") \
>> +       extern u32 __btf_id_##list##__##prefix##__##name \
>> +               asm("__BTF_ID__" #prefix "__" #name "__" #list);
> 
> ...
> 
>> [1] https://github.com/theihor/bpf/commit/be38dde0a027d7ab84d8d20ac266251fb938ceb6
> 
> too much claude in there. It talks about everything except
> important bits.

Yeah, sorry this is a classic case of AI over-verbosity.

> How does the above 'asm' magic work?

As it turns out, asm() magic isn't even necessary.

Currently BTF_ID_LIST with subsequent BTF_ID create symbols for the
list and for each entry like follows:

    __BTF_ID__##prefix##__##name##__<counter><line>

For example:

    __BTF_ID__func__bpf_obj_new__8524584

These symbols refer to a piece of memory storing BTF ID of course,
which is how resolve_btfids can patch them and kernel use them.

So the idea I vibe-coded is simple: let's directly access these
symbols at the source level instead of maintaining an enums.

The obstacle to this was `<counter><line>` suffix, which exists to
avoid conflicts between BTF_ID_* containers in the same source
file. But the suffix also prevents us from using the symbol directly
in C, since you don't know the <counter><line>.

Well since every BTF_ID_LIST and co has a unique name (at the source
file level), we can use it as a disambiguator suffix instead of the
<counter><line>, getting something like:

    __BTF_ID__func__bpf_obj_new_impl__special_kfunc_list

Having that we can add extern declarations (so that C compiler is
aware of the symbols) and a helper macro to reconstruct the symbol and
read its value:

    #define BTF_ID_NAMED(list, prefix, name)		\
    	__BTF_ID(__BTF_ID__##prefix##__##name##__##list) \
    	extern u32 __BTF_ID__##prefix##__##name##__##list;

    #define btf_id_named(list, prefix, name) \
    	(__BTF_ID__##prefix##__##name##__##list)

    btf_id_named(special_kfunc_list, func, bpf_obj_new_impl)

I don't know why AI decided it's a good idea to add one more level of
aliasing here with asm(), but it is not necessary for this macrology
to work.

Additional caveat is that resolve_btfids needs to be taught about new
suffixes, but that's relatively trivial.

The above works, and the question now is if we like this mechanism
more than current setup with explicit enums.

> 
> Just to clarify. This potential cleanup is not necessary to land this set.

Ok, I'll respin, thanks.


