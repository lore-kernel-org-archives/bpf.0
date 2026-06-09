Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6297DA66
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 00:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966013; cv=none; b=hAd1mIW7XIxfLj0m1FEVD/NfpaskdOnN/P8aorjanUJq1WXynTwGUhznhREYpWmzQoVmJfUS7fu6hrBcIyfpeHuD+BLvYpKl+MqSaBFqSVYyNK4MMf1yFlmeJRP0GOX/F4WBwel3GKvBHzMnVcr/xV6oWUNUAgpBa8X3T9COAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966013; c=relaxed/simple;
	bh=1c6GVyEHqUznm1wPAQqInkLwXybgFIgNCnqENXS3QZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2Dku7G6XdQUKZX41e1iKKVw/OjRZnEHhExAkhtfQyx4UidbspHOJT1OI09sZulCWrCI6XLDF4SPBM+5mxb8Keuuy6oicR+7ll57XcoA2ZY58IB5t9KOPXOhFnUVdLS78x0uZnUH/awK42soewFMvL4x/KhUQN1Dwm0YaJVl/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=udll/Dsq; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="udll/Dsq"
Message-ID: <9a3bfb46-9c25-4f58-afb6-8f6fcd0d0bda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780965999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7xJk0Ptl+ce7gdjtNlnmO7mmsxpuTx3CaJaKRaeCv8=;
	b=udll/DsqOj8ckljTu4PwwsOm17hsF/F+TZT0P68Ws9LtflozdAeHmv55kf+mh0QY/KNJFm
	0Ti1kH918LSM0ipGE3yC+n3likBqY2BkPsDzoVaL1G+LQCNxQ1RtwJ6u9o5FHUwheF30D2
	91gKBAjdf4YiVAAQBc45rcSQSGHN7kE=
Date: Mon, 8 Jun 2026 17:46:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
To: Alan Maguire <alan.maguire@oracle.com>, chenyuan <chenyuan_fl@163.com>
Cc: eddyz87@gmail.com, yonghong.song@linux.dev, andrii@kernel.org,
 ast@kernel.org, bot+bpf-ci@kernel.org, bpf@vger.kernel.org,
 chenyuan@kylinos.cn, clm@meta.com, daniel@iogearbox.net, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, song@kernel.org
References: <535798105630b24033f33f532051b93dc853bc0d.camel@gmail.com>
 <20260602085827.2562222-1-chenyuan_fl@163.com>
 <20260602085827.2562222-2-chenyuan_fl@163.com>
 <8f2dd2e9-726c-4295-995c-3bdbcda56070@linux.dev>
 <41cc6d1a.8310.19e91e9c5e1.Coremail.chenyuan_fl@163.com>
 <7a9e6b7b-f566-47e6-80bd-6fff7ed55241@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <7a9e6b7b-f566-47e6-80bd-6fff7ed55241@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/4/26 3:21 AM, Alan Maguire wrote:
> On 04/06/2026 10:14, chenyuan wrote:
>> Hi Ihor：
>>> Could you please elaborate on the "incorrect type information" generated 
>> by pahole 1.30?
>> I extracted the .BTF and .BTF.base sections from the same 
>> bpf_testmod.ko built with pahole 1.30 vs 1.31 to compare: 
>>
>>   # pahole 1.30 — bpf_prog_aux in split BTF, NOT in base
>>   $ bpftool btf dump file btf_1_30_base.bin | grep bpf_prog_aux
>>     (empty)
>>   $ bpftool btf dump -B btf_1_30_base.bin file btf_1_30.bin | grep aux
>>     [3172] STRUCT 'bpf_prog_aux' size=2016 vlen=87
>>
>>   # pahole 1.31 — bpf_prog_aux in base BTF, NOT in split
>>   $ bpftool btf dump file btf_1_31_base.bin | grep bpf_prog_aux
>>     [10] STRUCT 'bpf_prog_aux' size=2016 vlen=0
>>   $ bpftool btf dump -B btf_1_31_base.bin file btf_1_31.bin | grep aux 
>>     (empty) 
>>
>> pahole 1.30 places struct bpf_prog_aux in the module's split BTF 
>> (instead of the distilled base).  pahole 1.31 correctly moves it to 
>> the base BTF. 
> 
> Would be worth digging a bit more here I think. To confirm is this
> the v1.31 release where it is fixed or the post-1.31 pahole (i.e.
> do you know the top commit for the fixed pahole version)? 
> 
> pahole uses the libbpf machinery to do BTF distillation in .BTF.base
> so if we know which libbpf sync has the fix that will be helpful.
> 
> The most recent pahole HEAD is synced with libbpf v1.8, but I
> suspect the previous sync that occured just after v1.30 (so v1.31
> had the fix but v1.30 didn't):
> 
> 042d73962d35 ("pahole: Sync with libbpf mainline")
> 
> is the one. From the commit log:
>     
> "To pull in dedup fix in
>     
> commit 8e64c387c942 ("libbpf: Add identical pointer detection to btf_dedup_is_equiv()")
>     
> sync with latest libbpf."
> 
> My suspicion is that since v1.30 didn't have that fix, dedup failed for 
> struct bpf_prog_aux on pahole v1.30 so it wound up in split BTF and base.
> v1.31 had the fix so the module bpf_prog_aux was correctly flagged as a
> dup of the kernel one, therefore we did the distillation into .BTF.base
> correctly.
> 
> Does this fit with your observations?


Hi everyone.

I've been scratching my head trying to understand exactly what may
cause the divergence that Yuan reported. It took me and the bots a
while, but I think I figured it out.

TL;DR is that compilers may produce multiple DW_TAG_pointer_type DIEs
in DWARF for the same field/arg if they differ for example in address
space. The libbpf commit 8e64c387c942 ("libbpf: Add identical pointer
detection to btf_dedup_is_equiv()"), that Alan referenced looks like
the right fix for this for the BTF generation.

Since the fix is already there, the recommendation for people running
into this is to update their libbpf to at least 1.6:

    # in https://github.com/libbpf/libbpf
    $ git tag --contains 5ee9fbf7d769fb4e84881e0a073d6259b8555880
    v1.6.0
    v1.6.1
    v1.6.2
    v1.6.3
    v1.7.0

Now some details. Consider a code example below.

base.c:
    struct aux {
    	int __seg_gs *pcpu_a;
    	int __seg_gs *pcpu_b;
    };

    int base_use(struct aux *aux)
    {
    	return aux != 0;
    }

module.c:
    struct aux {
    	int __seg_gs *pcpu_a;
    	int __seg_fs *pcpu_b; // <-- NOTE: a different attribute
    };

    int kfunc_pick_a(struct aux *aux)
    {
        // TYPEOF_UNQUAL macro is referenced in Alan's fix (8e64c387c942)
        // as a trigger for the dedup bug
    	__typeof_unqual__(*aux->pcpu_a) *plain_from_typeof_unqual;

    	plain_from_typeof_unqual = (int *)(unsigned long)aux->pcpu_a;
    	return plain_from_typeof_unqual != 0;
    }

If you compile module.c, you can see in the DWARF there are two
pointer DIEs for int * that only differ in DW_AT_address_class:

    0x00000040:     DW_TAG_member
                      DW_AT_name ("pcpu_a")
                      DW_AT_type (0x00000057 "int *")
    0x0000004b:     DW_TAG_member
                      DW_AT_name ("pcpu_b")
                      DW_AT_type (0x00000064 "int *")
    0x00000057:   DW_TAG_pointer_type
                    DW_AT_address_class  (0x02)
    0x00000064:   DW_TAG_pointer_type
                    DW_AT_address_class  (0x01)
                      DW_AT_name ("plain_from_typeof_unqual")
                      DW_AT_type (0x000000b4 "int *")

Then when you use pahole (without the libbpf fix) to create base BTF
from base.c, and a split BTF for module.c, you can see struct aux
still exists in the split BTF, and the kfunc_pick_a() prototype
referencing it:

    [7] STRUCT 'aux' size=16 vlen=2
          'pcpu_a' type_id=2 bits_offset=0
          'pcpu_b' type_id=2 bits_offset=64
    [8] PTR '(anon)' type_id=7
    [9] FUNC_PROTO '(anon)' ret_type_id=3 vlen=1
          'aux' type_id=8
    [10] FUNC 'kfunc_pick_a' type_id=9 linkage=static

The reason for this is that pahole generates a ref type for each
DW_TAG_pointer_type [1], so there are two BTF IDs for int * in this
example. This then makes the struct aux BTF referenced from the module
and from the base "different", exposing the dedup bug.

The DW_AT_address_class is never even loaded and is not taken into
account anywhere in pahole. But that seems fine, I suspect there are
other examples of valid DWARF where the difference is not relevant to
BTF dedup.

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encoder.c?h=v1.31#n1647



> 
> Thanks!
> 
> Alan

