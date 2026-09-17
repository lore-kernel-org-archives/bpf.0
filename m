Received: from mta0.migadu.com (out-102.mta0.migadu.com [91.218.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79381AAE28
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 03:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615530; cv=none; b=jz3fGrIIwM/2QKW3rvH9XK5eqatlT2fM3GnEdeqNOt+WcBa12aSHSOkB+HwV76f+8SBXBRTbFhig3DG9wczdjnv/75qrY1hvTrWeWyGRxoaNxl9ZvjpJgDPx1R+89OzysT+iUCvjfM2PoJr8fSWuj8wRMz6W1f2PEdqJbGgZJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615530; c=relaxed/simple;
	bh=gKClaQzo4/W3jWTT1BaotNjSG0KreDggKfJIP1buHOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJPF9sZ+l5px5VcQd7jIu5aSIRq4jAc8C0aKUP1pB5vujJcDkqiEclFnrIzlgy0Y5vGj5GxuW1klOl8xDwmCyOJsW8zoGWE23JnvH+Ovlrkj3EQJGCJvYAB2m5VYtOB6fLlsHxN+b8+Xk3d5FYutFO6JTrHLwi8jIRxKD6FwFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BrnGiZJe; arc=none smtp.client-ip=91.218.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BrnGiZJe"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gKClaQzo4/W3jWTT1BaotNjSG0KreDggKfJIP1buHOM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789615526; v=1; x=1790220326;
 b=BrnGiZJeu6pFWjZXGEdrBrBvIF43jzLyE8yMLjNWSChj67yGk4asPlIvm9tj08Dmg7a+S5Vc
 JbT7I9pVqOkOscQvxztk2bW37xdBwgbKZgWwqUK1o/3lkgB4eJl7hUQY2Do1XGQQM+/4ALgYyWV
 +ZXQFjpv6yxDjdpmSm78iXEM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8f14ccf14acb3226;
	Thu, 17 Sep 2026 03:25:23 +0000
X-Mizu-Trace-ID: 8f14ccf14acb3226
X-Migadu-Flow: FLOW_OUT
Message-ID: <9a3a4128-8a21-4169-8a81-6310bc0d356b@linux.dev>
Date: Wed, 16 Sep 2026 20:25:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 2/4] libbpf: Render decl_tags in btf_dump
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
 <20260917012037.1396254-3-ihor.solodrai@linux.dev>
 <DLH87NTSTNKF.1GYVTW5UIE63R@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DLH87NTSTNKF.1GYVTW5UIE63R@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/26 7:12 PM, Alexei Starovoitov wrote:
> On Wed, Sep 16, 2026 at 06:20 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>> BTF_KIND_DECL_TAG is an attribute on a declaration: with kind_flag=0
>> the tag name is the argument of a btf_decl_tag(), and with kind_flag=1
>> it encodes a complete __attribute__.
>>
>> When doing btf_dump, render both forms at every declaration btf_dump
>> emits - a record, a record member and a typedef:
> 
> [...]
> 
>> Every decl tag in vmlinux BTF is a bpf_kfunc or bpf_fastcall tag on a
>> FUNC, which has no declaration in the C output, so generated vmlinux.h
>> does not change.
> 
> iirc the goal of this series is "bpftool btf dump file prog.bpf.o
> format c" and skeletons growing
> __attribute__((btf_decl_tag("contains:..."))) on members.
> Pls say so in the commit log.
> Otherwise it's 200 lines of code for "generated vmlinux.h doesn't
> change".

Hi Alexei, thank you for quick review.

The decl_tags is an old generic gap in btf_dump, which gets closed
with this patch.

The "contains:" is not the use case I had in mind, but yes, it should
be covered as well. The next thing I planned after this lands is a
bpftool change to get rid of:

   #pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)

in vmlinux.h, by emitting the attributes explicitly per record.
It's been discussed a long time ago, but never picked up on libbpf /
bpftool side [1].

I'll add a paragraph describing potential use cases in v2.

[1] https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/

> 
>> +static int btf_dump_cmp_decl_tags(const void *a, const void *b)
>> +{
>> +	const struct decl_tag_desc *x = a, *y = b;
>> +
>> +	if (x->target_id != y->tar
> get_id)
>> +		return x->target_id < y->target_id ? -1 : 1;
>> +	return x->tag_id < y->tag_id ? -1 : 1;
>> +}
> 
> nit: return 0 when equal. cmp(x, x) != 0 is asking for trouble.

For a valid deduped BTF we should never get a duplicate (target_id,
tag_id) pair. I'll see if there is a way to detect this and -EINVAL

> 
>> @@ -220,8 +258,18 @@ static int btf_dump_resize(struct btf_dump *d)
>>  		err = btf_dump_mark_referenced(d, t);
>>  		if (err)
>>  			return err;
>> +
>> +		if (btf_is_decl_tag(t)) {
>> +			err = btf_dump_push_decl_tag(d, i, t);
>> +			if (err)
>> +				return err;
>> +		}
>>  	}
> 
> \edited robot voice
> 
> On either error d->last_id is not advanced but d->decl_tags_cnt keeps
> whatever was pushed so far, so the next btf_dump__dump_type() walks
> the same ids again and pushes the same tags twice -> duplicated
> __attribute__ in the output ?

Yeah, my clanker flagged this too. I decided a mid-dump retry on error
is a weird case to support in the context of btf_dump, so ignored it.

Andrii, do you have an opinion?



> 
> pw-bot: cr

