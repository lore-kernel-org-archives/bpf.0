Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125607;
	b=KTo29emqe56lKrcmK3SLhbBK/gCFtu1slpF9ccqSGsk9J2ik26bIpor5rmFcsHXDWc/5
	 5d5BrNuwX3UxhuccVd7VroKrWZ8mTQbrls6qrI21nU+44NbUQd0g3CslbMg/nt/7EuxK1
	 z+HsAtIvmYFTgW1k4/xcDjnnraiowryqa9CXgTl0J5/A+S/rcT8eWA2S6soHNbbIgXcSc
	 abHKMXQ2rOE5iickF25UAJiHdasoGN8GhK8ywho+KPJKWOdSGNct5wzioq8XdLuK1LcQ+
	 5BfU5ruJStcz1A3NloGizQh9YhGiquTAw6+X+PWjYgM+0XfrzSydf3RMO8giAR/DkSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125607;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CaiwK52O6JveeQJueYZooXR3KsamZD6i50fp9vQ+HzU=;
	b=RfJo/uSP7YYlIaigQpcyKWNwja9mfn8/CNxapqr/Nd9Xz1/kTejOcEFVJwTEsJ4kLw9/
	 S77borFgWzFfdKV/u8qzIf1wGo366quTihKoKRGVjw9cFSrUXAJX45YOi5VRTNqWL4PAe
	 waR8Fk3X7gm4dh/Hp7f2SD+Hzffkk+m8+RIJXs06erS6JDD0Q2xMxk4y95pJ91YFJ9wvI
	 dOod81ASTazRv/niMYNtECqBjfn1D/fcRJ1bg+NjRGZS2NNQ02BPUFz+QaSCtob3aZamU
	 zhpSPd87u0MDqAag00HVHujldMaT/HVJ5rZYF5MERUyq3SxX67HSRtXc4UTu4GuMoFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sGeSsXWs;
	arc=none smtp.remote-ip=95.215.58.38
Received: from mta1.migadu.com (out-38.mta1.migadu.com [95.215.58.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3FF606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE3FF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sGeSsXWs
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Sj7RmU3NGIMJfyC+AiEYWymxAuEy0te1KR93Jo/i7Ns=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793125603; v=1; x=1793730403;
 b=sGeSsXWsOCLaNHRzyVAKDNx8Qg5nICpqYxD6V49/pcSZDd97egV5gw5/BMH2WWjhWgUdru+p
 MpnKSfWEudWd55UM5/RMjmHWfHoSj5Ddnoq6Wkq7S1OsHXZM0NLFuoayoaqIOfpKMFmmkI0KGtE
 1rGF9n2+4TktvrpPf6DeOn7U=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 03b5d29ff8c80ba1;
	Tue, 27 Oct 2026 18:26:43 +0000
X-Mizu-Trace-ID: 03b5d29ff8c80ba1
X-Migadu-Flow: FLOW_OUT
Message-ID: <d81831c3-85f0-45de-acb2-fbf630bdd573@linux.dev>
Date: Tue, 27 Oct 2026 11:26:36 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/8] bpftool: Apply __bpf_relocatable per
 record on BTF dump
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org,
 Alan Maguire <alan.maguire@oracle.com>,
 Cupertino Miranda <cupertino.miranda@oracle.com>,
 David Faust <david.faust@oracle.com>, Ian Rogers <irogers@google.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Vineet Gupta <vineet.gupta@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
 <20261023222652.3927736-4-ihor.solodrai@linux.dev>
 <CAEf4BzYuEetnwDnm38J_MEG4-ZcQHfZwg=L1FcFtgXvAn7NSAA@mail.gmail.com>
 <882895bf-db14-485a-bd6f-0241b1eba1ba@linux.dev>
 <CAEf4BzYwORw44UFwt6Kiy+Y3hj3m0=wYzPiH7e7wDsAW58xxBg@mail.gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzYwORw44UFwt6Kiy+Y3hj3m0=wYzPiH7e7wDsAW58xxBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/27/26 11:21 AM, Andrii Nakryiko wrote:
> On Tue, Oct 27, 2026 at 11:15 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 10/27/26 11:03 AM, Andrii Nakryiko wrote:
>>> On Fri, Oct 23, 2026 at 3:27 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>>
>>>> bpftool wraps the C dump in a clang attribute pragma that applies
>>>> preserve_access_index to every struct and union, so field accesses
>>>> through vmlinux.h types get CO-RE relocations. GCC-BPF supports the
>>>> attribute but not the pragma, so it gets no CO-RE from the header.
>>>>
>>>> Jose proposed replacing the Clang pragmas with per-record attributes
>>>> in May 2024 [1]. The declaration attribute support in btf_dump [2] now
>>>> provides the per-type control discussed in that thread.
>>>>
>>>> Apply the attribute to each struct and union definition instead, as
>>>> kflagged decl tags rendered by btf_dump. Add the tags to a split BTF
>>>> over the input, so the input stays read-only. The tags use the
>>>> __bpf_relocatable macro, which by default expands to
>>>> preserve_access_index if compiler supports it.
>>>>
>>>> Clang output is unchanged.
>>>>
>>>> GCC-BPF programs now can get CO-RE relocations from vmlinux.h, however
>>>> the selftests GCC-BPF build defines BPF_NO_PRESERVE_ACCESS_INDEX and
>>>> is unaffected yet.
>>>>
>>>> [1]: https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/
>>>> [2]: https://lore.kernel.org/bpf/20260929234608.48503-1-ihor.solodrai@linux.dev/
>>>>
>>>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>>>> ---
>>>>  tools/bpf/bpftool/btf.c                       | 62 +++++++++++++++----
>>>>  .../bpf/bpftool_btf_dump_sorted.expected      | 16 ++---
>>>>  .../bpf/bpftool_btf_dump_unsorted.expected    | 16 ++---
>>>>  3 files changed, 65 insertions(+), 29 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>>         printf("#ifndef __VMLINUX_H__\n");
>>>>         printf("#define __VMLINUX_H__\n");
>>>>         printf("\n");
>>>> -       printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
>>>> -       printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
>>>> +       printf("#ifndef __bpf_relocatable\n");
>>>> +       printf("#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)\n");
>>>> +       printf("#define __bpf_relocatable preserve_access_index\n");
>>>
>>> why not define __bpf_relocatable as
>>> __attribute__((preserve_access_index))? then type definitions will be
>>> a bit cleaner and we can basically drop BPF_NO_PRESERVE_ACCESS_INDEX
>>> eventually, and instead you'll be able to just `#define
>>> __bpf_relocatable` to disable relocations (or if some GCC version
>>> requires some quirk, you'll define it wholesale)
>>
>> The problem is in how libbpf dumps the attributes.
>>
>> __attribute__((__vmlinuxh_local_foo)) allows to have a single BTF tag
>> emission logic in bpftool: always emit the attributes. And they remain
>> opt-out in the generated vmlinux.h because __attribute__(()) is legal.
>>
>> In order to enable
>>
>>   #define __bpf_relocatable __attribute__((preserve_access_index))
>>
>> We need to move the opt-out to bpftool level, that is: optionally not
>> emit the BTF tags. And that then brings up a question of adding a
>> runtime flag, passing it through makefiles etc.
>>
>> This can also potentially break existing progs that depend on
>> BPF_NO_PRESERVE_ACCESS_INDEX.
>>
>> So going with __attribute__(()) looked like the best
>> backward-compatible option to me.
>>
>> I'm open to other ideas though.
> 
> So we always emit __bpf_relocatable next to a type, but then at the

Actually, I just remembered that it is worse than that.

Per-record, libbpf dump can only emit either:

   __attribute__((%s))

or, if kflag=0

   __attribute__((btf_decl_tag(\"%s\")))

See btf_dump_emit_decl_tag().

There is no way to emit arbitrary __foo identifier.

So the only way to make it work is to employ string replacement hackery.
We can do that, but I don't think it's worth it.

> top of the header we can define __bpf_relocatable as empty if we want
> to disable relocations (either because compiler doesn't support this
> or user defined BPF_NO_PRESERVE_ACCESS_INDEX, or user manually defined
> __bpf_relocatable).

With current implementation defining __bpf_relocatable as empty still
works as opt-out, because __attribute__(()) doesn't affect the
compilation.

> 
> I must be missing something, why doesn't this work?
> 
>>
>>>
>>>> +       printf("#else\n");
>>>> +       printf("#define __bpf_relocatable\n");
>>>> +       printf("#endif\n");
>>>>         printf("#endif\n\n");
>>>>         printf("#ifndef __ksym\n");
>>>>         printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
>>>
>>> [...]
>>>
>>>> -#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
>>>> -#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
>>>> +#ifndef __bpf_relocatable
>>>> +#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)
>>>> +#define __bpf_relocatable preserve_access_index
>>>> +#else
>>>> +#define __bpf_relocatable
>>>> +#endif
>>>>  #endif
>>>>
>>>>  #ifndef __ksym
>>>> @@ -30,19 +34,15 @@ struct holey {
>>>>         long: 32;
>>>>         long: 32;
>>>>         int tail;
>>>> -};
>>>> +} __attribute__((__bpf_relocatable));
>>>
>>> e.g., I was expecting to see just __bpf_relocatable here, without
>>> __attribute__(()) wrapper
>>>
>>> are there any downsides to that? that seems how attributes are
>>> typically hidden in kernel, for instance
>>>
>>> pw-bot: cr
>>>
>>>
>>> [...]
>>

