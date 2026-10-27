Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124942;
	b=utB5S0Zsa9gcXOBSw1NHuVmeL2udj1fCZx1L7zBmXfG9BjicvqxrDxtGsXruQ8X3BitT
	 0UihR0HJP3e9QRK85fYGjBRX/37Z1jTJUttbOt7NhwLW2txNWKeIVAvjcMNq1ebcR4tsb
	 x9bvi+31ZChzkjn2BXI0uthPvRgCiDS8/k2d1h5g25OqH5eBO54HRO92qSYmu6ZF632s0
	 69ta2afwfPZ+nhE2bJUG58Tm+iCm+j3pbkyxwfYORfgDHVgiibb2aIc1lDVC2x3Mzdd5U
	 SfonkyugIdyJ2kbiMM5gtfIFBzt38Xkw8+kMeG2IaQYa4jzDx8zpuNOXxPYiGos9VSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124942;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=JYiuW4CSVpwsSczxIY5JITmNLBQP8gvyp6Kv/ySe3s4=;
	b=G1cILT4zy89yhaz8UIOX3HEcxhAlM/2d2sLhZbVvjB8egT4yNxw3HIhYtjH5GyTvNzyB
	 ZSkW5kltPTy8A1BKuQ/yImiuTNG6yikGH9NacSbTZ+HP+FINr3bmwl/aGAsMJG6Wby/Z1
	 GESD3xc0NFB5FK6aDKmNTt3hI9cXM5PBikylajQ0FMYDk26K5+XdLJ8hnnJqiM6Kis87L
	 wNU3pxh8aFAyG5LHzX9TZK2V8cKNjEPzv+i+nfx1A9W3FXnSG+H+UCRUAJ9qJaEUG8BCg
	 sn47ioBh655IHHeISEoM6X+j3C7qPWlx6+y8MBt3viCqGuFpMNSeFD2sHS+ivAtuYeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eJHVL+aU;
	arc=none smtp.remote-ip=91.218.175.227
Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5F606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AB5F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eJHVL+aU
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ib5wKXDqdPOov9+i1vxZNv2/J6ARxcDkd9z314p7gxU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793124939; v=1; x=1793729739;
 b=eJHVL+aUrbMpGHErC1heY6Y7ympp5Tlf4F5/sMzx2e2W2G5tn5leZdhK9nwj2kFuXLs7VhTB
 zxvxtGBItCSlDMmDCWl8e8i4jIs1GGDBetRN/MR7YYQkc/CiG/Fbks+BxnDuKS+HTaBw9rRniiO
 lBBFWiyKKrxQgsfY8bT66tYc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4e2801868caebc88;
	Tue, 27 Oct 2026 18:15:28 +0000
X-Mizu-Trace-ID: 4e2801868caebc88
X-Migadu-Flow: FLOW_OUT
Message-ID: <882895bf-db14-485a-bd6f-0241b1eba1ba@linux.dev>
Date: Tue, 27 Oct 2026 11:15:19 -0700
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
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzYuEetnwDnm38J_MEG4-ZcQHfZwg=L1FcFtgXvAn7NSAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/27/26 11:03 AM, Andrii Nakryiko wrote:
> On Fri, Oct 23, 2026 at 3:27 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> bpftool wraps the C dump in a clang attribute pragma that applies
>> preserve_access_index to every struct and union, so field accesses
>> through vmlinux.h types get CO-RE relocations. GCC-BPF supports the
>> attribute but not the pragma, so it gets no CO-RE from the header.
>>
>> Jose proposed replacing the Clang pragmas with per-record attributes
>> in May 2024 [1]. The declaration attribute support in btf_dump [2] now
>> provides the per-type control discussed in that thread.
>>
>> Apply the attribute to each struct and union definition instead, as
>> kflagged decl tags rendered by btf_dump. Add the tags to a split BTF
>> over the input, so the input stays read-only. The tags use the
>> __bpf_relocatable macro, which by default expands to
>> preserve_access_index if compiler supports it.
>>
>> Clang output is unchanged.
>>
>> GCC-BPF programs now can get CO-RE relocations from vmlinux.h, however
>> the selftests GCC-BPF build defines BPF_NO_PRESERVE_ACCESS_INDEX and
>> is unaffected yet.
>>
>> [1]: https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/
>> [2]: https://lore.kernel.org/bpf/20260929234608.48503-1-ihor.solodrai@linux.dev/
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  tools/bpf/bpftool/btf.c                       | 62 +++++++++++++++----
>>  .../bpf/bpftool_btf_dump_sorted.expected      | 16 ++---
>>  .../bpf/bpftool_btf_dump_unsorted.expected    | 16 ++---
>>  3 files changed, 65 insertions(+), 29 deletions(-)
>>
> 
> [...]
> 
>>         printf("#ifndef __VMLINUX_H__\n");
>>         printf("#define __VMLINUX_H__\n");
>>         printf("\n");
>> -       printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
>> -       printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
>> +       printf("#ifndef __bpf_relocatable\n");
>> +       printf("#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)\n");
>> +       printf("#define __bpf_relocatable preserve_access_index\n");
> 
> why not define __bpf_relocatable as
> __attribute__((preserve_access_index))? then type definitions will be
> a bit cleaner and we can basically drop BPF_NO_PRESERVE_ACCESS_INDEX
> eventually, and instead you'll be able to just `#define
> __bpf_relocatable` to disable relocations (or if some GCC version
> requires some quirk, you'll define it wholesale)

The problem is in how libbpf dumps the attributes.

__attribute__((__vmlinuxh_local_foo)) allows to have a single BTF tag
emission logic in bpftool: always emit the attributes. And they remain
opt-out in the generated vmlinux.h because __attribute__(()) is legal.

In order to enable

  #define __bpf_relocatable __attribute__((preserve_access_index))

We need to move the opt-out to bpftool level, that is: optionally not
emit the BTF tags. And that then brings up a question of adding a
runtime flag, passing it through makefiles etc.

This can also potentially break existing progs that depend on
BPF_NO_PRESERVE_ACCESS_INDEX.

So going with __attribute__(()) looked like the best
backward-compatible option to me.

I'm open to other ideas though.

> 
>> +       printf("#else\n");
>> +       printf("#define __bpf_relocatable\n");
>> +       printf("#endif\n");
>>         printf("#endif\n\n");
>>         printf("#ifndef __ksym\n");
>>         printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
> 
> [...]
> 
>> -#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
>> -#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
>> +#ifndef __bpf_relocatable
>> +#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)
>> +#define __bpf_relocatable preserve_access_index
>> +#else
>> +#define __bpf_relocatable
>> +#endif
>>  #endif
>>
>>  #ifndef __ksym
>> @@ -30,19 +34,15 @@ struct holey {
>>         long: 32;
>>         long: 32;
>>         int tail;
>> -};
>> +} __attribute__((__bpf_relocatable));
> 
> e.g., I was expecting to see just __bpf_relocatable here, without
> __attribute__(()) wrapper
> 
> are there any downsides to that? that seems how attributes are
> typically hidden in kernel, for instance
> 
> pw-bot: cr
> 
> 
> [...]

