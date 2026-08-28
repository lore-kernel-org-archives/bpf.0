Received: from mta1.migadu.com (out-145.mta1.migadu.com [95.215.58.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9236404E
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914314; cv=none; b=mtjXRRHsuO0y9ayuz2DggMY7L3l2FFM6UcOskoIWL3M3wvx0IyKByp0aQKV4oI0fiqKZ4VV+2GfgHAmULdtt/xEN0LTO02GIQzjNSzGzwugN+UMJ7OAhTslrXkPUSz4tpxci2+PKMfI3K2bMR1/keHqrH5/tGJFaN11a7Ba+ce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914314; c=relaxed/simple;
	bh=xpfRNVI2oTQwjRWSMrvqdTsXHjUS3tjZksuFmAJK9L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gw/pICEAEzFShGOaQN4h5gR//RO1XtUnETSYgCX6LxIqP0Om6rGsycI3oxoXIbQ2CbpcTOQM3fva1RMUMk6sRxqEy7kSFznLHIka9pSiXJ8E+n6msB0rI+2ypNZZlIjB1cIaLWOGqU303X4vu1UZ0qL2Kal1XzVvBJNcpSf3Azo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Do9LaygB; arc=none smtp.client-ip=95.215.58.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Do9LaygB"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xpfRNVI2oTQwjRWSMrvqdTsXHjUS3tjZksuFmAJK9L4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787914309; v=1; x=1788519109;
 b=Do9LaygBjHBydNISAhcsO1+JgkY47fatmbbHpflfPD88ruOW670dl3mRkhkVVT/rrH+Dc1MS
 3bqVHgizwk7r+Wm07x8RONyiEMx9caOGgoKv/Qo0nCtmpIiN2Jgb8hULPutvMPBmeko2IVU3Ji2
 +oW6P0xZUbQqxdgYAGBP8F88=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 73e9394acd25084b;
	Fri, 28 Aug 2026 10:51:39 +0000
X-Mizu-Trace-ID: 73e9394acd25084b
X-Migadu-Flow: FLOW_OUT
Message-ID: <8b3e7f24-795d-458b-a24e-fe154b0cf03d@linux.dev>
Date: Fri, 28 Aug 2026 18:51:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf: Fix NULL-ptr-deref when dumping a key-less
 BTF hash map
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260828093142.179856-1-jiayuan.chen@linux.dev>
 <20260828095416.50FE61F000E9@smtp.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260828095416.50FE61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


on 8/28/26 5:54 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] btf_modifier_show dereferences NULL when a modifier resolves to a void type.
> --
>
> commit 36dc7c26f56375bd142801da1fcbc83e4a765c35
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> bpf: Fix NULL-ptr-deref when dumping a key-less BTF hash map
>      
> This patch fixes a NULL pointer dereference in btf_type_show() that occurs
> when dumping a key-less BTF hash map. It restores previous behavior by
> rejecting key-less BTF in hash map check callbacks, and adds a NULL check
> for void types in btf_type_show() to gracefully handle any other paths.
>
> Reported-by: syzbot+37b56485bbbf90ad8489@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a8f4e88.27659fcc.2ceef7.0008.GAE@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index da36d4b9d31ab..c32265dc4ae7e 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -8229,6 +8229,10 @@ static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
>>   	memset(&show->state, 0, sizeof(show->state));
>>   	memset(&show->obj, 0, sizeof(show->obj));
>>   
>> +	/* A void type (e.g. type_id 0) has no show op, don't deref NULL. */
>> +	if (!t || !btf_type_ops(t))
>> +		return;
>> +
>>   	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
>>   }
> [Severity: High]
> This is a pre-existing issue, but does this fix need to be extended to
> btf_modifier_show() as well?
>
> If a user with BPF tracing privileges invokes the bpf_snprintf_btf() helper
> with a btf_id of a modifier that points to void (e.g., const void),
> btf_type_show() will see the modifier type and pass this check since
> modifier_ops is not NULL.


Right, good catch. Passing a "const void" type_id to bpf_snprintf_btf() 
resolves to

void in btf_modifier_show() and hits the same NULL deref, which the 
check here does not cover.

Shoud I add the fix in this patchset since they are all about "show" 
semantics‌?


