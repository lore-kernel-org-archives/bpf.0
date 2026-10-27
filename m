Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136335;
	b=AU/s6SJ6ExULB8RiUI2ja5GpDt2clhx5cReSW1RQhAE5Qoqc3Lyw6WZMyrcCprih3ISD
	 BPHwtwZ2q+BErMg2HeWgqB58mqIIgfhNuKBuuBgcJM6PjOI3epqx2Dp1tielbV62yBR+l
	 oRG8PodjlS3c9pEJMXdbSjppOaXbadtKUWIc++X8O3cA1BwBCkS5oCu/FHkbr49NVVyu3
	 pHO4oVy1olN00zac5QMKmZ/Yn1kCLSv7JQ+bCbom2tVc7lCUQQ1quDd8HVnf3KnGpvGSZ
	 8tSz7F5pkD+X8Uuw25PE3v5tAnaYt1T49BsTv1P5MGXrK2QD9gxRW3YCkIMx+E8vgdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136335;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CUHVnscxz9KWdlkIJtctuMicZ7e10/bxdWZ7lrf/UK8=;
	b=rnlGbBv3c8IhbCSog7Pp/jq/eKL6c98jSxRqEuhDlMrzFuyetaGOQPHudSZKcRp/V8Uz
	 5WmYPoSlM6eJ6MuDgm5lpPq8+GNJKsQFwQRlrW8zMk/V/V2sXT1Iq3CPj1SiMep+o3BkT
	 OoWqVNLvQtWLbS3I2diV77vio6CGlh3HzsHxpDDEYwhFMiPYLOlhV1+sIRoUQivwCw3hO
	 5EeY2L7Rg+kzRW8kQdFvGumfadgogVzrfbAqH+0Zv2lxWDy0omYem0gieLEpHX0UmTBE9
	 IujeDehD84IlNLa2i2kbPqZPh37faUYRbTCbaQUa62lJSFPU1gpcjyCWDxKa3VIAc/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JgQGtRpL;
	arc=none smtp.remote-ip=91.218.175.174
Received: from mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF05606A31F
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FF05606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JgQGtRpL
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YyF1ryobxuDxRGHzxIiQKCTU8hokG0FMcf/Z+ejvZA0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793136331; v=1; x=1793741131;
 b=JgQGtRpLEr8lBYOTiGgsRR4vSwrvs0Sq24B4oMAdjdtDJdQs6MF2P5TozyfP/0yiT71umyfF
 vH10L5craYLzgogR28Nkx8hmeqgEfKiZdEDudBuz7oKmAgCtDcCVKuYcz2hGnnpDlBGtItuQENL
 mSTCCQld1hF2JseSMto569nI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2788b59f2651cdd4;
	Tue, 27 Oct 2026 21:25:29 +0000
X-Mizu-Trace-ID: 2788b59f2651cdd4
X-Migadu-Flow: FLOW_OUT
Message-ID: <4d17fab5-5fe9-43b7-85a6-825c05b38945@linux.dev>
Date: Tue, 27 Oct 2026 14:25:23 -0700
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
From: Ihor Solodrai <ihor.solodrai@linux.dev>
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
 <d81831c3-85f0-45de-acb2-fbf630bdd573@linux.dev>
Content-Language: en-US
In-Reply-To: <d81831c3-85f0-45de-acb2-fbf630bdd573@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/27/26 11:26 AM, Ihor Solodrai wrote:
> On 10/27/26 11:21 AM, Andrii Nakryiko wrote:
>> On Tue, Oct 27, 2026 at 11:15 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>
>>> On 10/27/26 11:03 AM, Andrii Nakryiko wrote:
>>>> On Fri, Oct 23, 2026 at 3:27 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>>>
>>>>> bpftool wraps the C dump in a clang attribute pragma that applies
>>>>> preserve_access_index to every struct and union, so field accesses
>>>>> through vmlinux.h types get CO-RE relocations. GCC-BPF supports the
>>>>> attribute but not the pragma, so it gets no CO-RE from the header.
>>>>>
>>>>> Jose proposed replacing the Clang pragmas with per-record attributes
>>>>> in May 2024 [1]. The declaration attribute support in btf_dump [2] now
>>>>> provides the per-type control discussed in that thread.
>>>>>
>>>>> Apply the attribute to each struct and union definition instead, as
>>>>> kflagged decl tags rendered by btf_dump. Add the tags to a split BTF
>>>>> over the input, so the input stays read-only. The tags use the
>>>>> __bpf_relocatable macro, which by default expands to
>>>>> preserve_access_index if compiler supports it.
>>>>>
>>>>> Clang output is unchanged.
>>>>>
>>>>> GCC-BPF programs now can get CO-RE relocations from vmlinux.h, however
>>>>> the selftests GCC-BPF build defines BPF_NO_PRESERVE_ACCESS_INDEX and
>>>>> is unaffected yet.
>>>>>
>>>>> [1]: https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/
>>>>> [2]: https://lore.kernel.org/bpf/20260929234608.48503-1-ihor.solodrai@linux.dev/
>>>>>
>>>>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>>>>> ---
>>>>>  tools/bpf/bpftool/btf.c                       | 62 +++++++++++++++----
>>>>>  .../bpf/bpftool_btf_dump_sorted.expected      | 16 ++---
>>>>>  .../bpf/bpftool_btf_dump_unsorted.expected    | 16 ++---
>>>>>  3 files changed, 65 insertions(+), 29 deletions(-)
>>>>>
>>>>
>>>> [...]
>>>>
>>>>>         printf("#ifndef __VMLINUX_H__\n");
>>>>>         printf("#define __VMLINUX_H__\n");
>>>>>         printf("\n");
>>>>> -       printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
>>>>> -       printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
>>>>> +       printf("#ifndef __bpf_relocatable\n");
>>>>> +       printf("#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)\n");
>>>>> +       printf("#define __bpf_relocatable preserve_access_index\n");
>>>>
>>>> why not define __bpf_relocatable as
>>>> __attribute__((preserve_access_index))? then type definitions will be
>>>> a bit cleaner and we can basically drop BPF_NO_PRESERVE_ACCESS_INDEX
>>>> eventually, and instead you'll be able to just `#define
>>>> __bpf_relocatable` to disable relocations (or if some GCC version
>>>> requires some quirk, you'll define it wholesale)
>>>
>>> The problem is in how libbpf dumps the attributes.
>>>
>>> __attribute__((__vmlinuxh_local_foo)) allows to have a single BTF tag
>>> emission logic in bpftool: always emit the attributes. And they remain
>>> opt-out in the generated vmlinux.h because __attribute__(()) is legal.
>>>
>>> In order to enable
>>>
>>>   #define __bpf_relocatable __attribute__((preserve_access_index))
>>>
>>> We need to move the opt-out to bpftool level, that is: optionally not
>>> emit the BTF tags. And that then brings up a question of adding a
>>> runtime flag, passing it through makefiles etc.
>>>
>>> This can also potentially break existing progs that depend on
>>> BPF_NO_PRESERVE_ACCESS_INDEX.
>>>
>>> So going with __attribute__(()) looked like the best
>>> backward-compatible option to me.
>>>
>>> I'm open to other ideas though.
>>
>> So we always emit __bpf_relocatable next to a type, but then at the
> 
> Actually, I just remembered that it is worse than that.
> 
> Per-record, libbpf dump can only emit either:
> 
>    __attribute__((%s))
> 
> or, if kflag=0
> 
>    __attribute__((btf_decl_tag(\"%s\")))
> 
> See btf_dump_emit_decl_tag().
> 
> There is no way to emit arbitrary __foo identifier.

Had an off-list discussion with Andrii.

In the next revision I'll make a libbpf change to remove the
limitation discussed in the thread and allow BTF tags to represent
arbitrary identifier, not just attributes.

This will give more freedom to BTF consumers when interpreting the
tags in general, and bpftool with this series will become the first
one using it.


> 
> [...]
>>>>
>>>> [...]
>>>
> 

