Received: from mta1.migadu.com (out-37.mta1.migadu.com [95.215.58.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05CF59D623
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788893010; cv=none; b=RMREOIoxSgmxiR3a9Hj7iNwms4kjm6ua6HZYQeKjyjY7Ufm7ArkeKzo1EzHj27aWx6ykGa4Vo+ih+YOHDBqnUd7erlm7Os04V+K3RFNhA+vI6bZx454gQa9cEtIXagQBoy5l+plbP7c2I338y//Y6N8ww3OpuJ0RRGlUE+2ZnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788893010; c=relaxed/simple;
	bh=47i6+SjiQJR8VHEQkWXDtlI/FeWngzD6VcHgsv+cLoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JghXiFMUjptbsNCf/RCCQy8gaWqXjwitu7Y6PyLmES9qGvHn9rC3wpUMcToKajXwNw6dr/S5A93WeJwoWVSlsfZw1dv6/mkDutZQhre28j8MZTsc/48dmABLYPnGcFmPFQEkXHigDqlxKS9uPuxbVqm8sLl6P0vP5kLqMBknK3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sdqhBGiF; arc=none smtp.client-ip=95.215.58.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sdqhBGiF"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=47i6+SjiQJR8VHEQkWXDtlI/FeWngzD6VcHgsv+cLoY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788893003; v=1; x=1789497803;
 b=sdqhBGiFxDs7P6eCkgsqlSY479Muiy4r7XYIqdpRVO8CQ9i2DnCWLXX0tgyVRjGJg3SqQPs8
 Yu8NI26N0SUDRRO5CiWL0gNC2r9LoumTJ2iQCL1uYLehKi6UZCdMtf8u/MVPAhvZtm1aqftmhdD
 wEdUe0jhr3A/scBNuzB2gj6Q=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c64670e3f84097a4;
	Tue, 08 Sep 2026 18:43:23 +0000
X-Mizu-Trace-ID: c64670e3f84097a4
X-Migadu-Flow: FLOW_OUT
Message-ID: <1eef259d-e0d2-4b73-99eb-c7fb736a7846@linux.dev>
Date: Tue, 8 Sep 2026 11:43:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 07/12] bpf, x86: Place kfunc arguments per the
 SysV calling convention
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051033.3979978-1-yonghong.song@linux.dev>
 <DL6XUEHAJN3Z.20UKZKTLHI2XZ@gmail.com>
 <f034ac4a-2829-4932-b3f8-b13cee4688a6@linux.dev>
 <CAADnVQ+bKmypdfAPXdk9jDN3QedX9EO9YXHFudLu71AR02Z3CQ@mail.gmail.com>
 <7be30b65-0a22-47b6-8635-e0054c6cba24@linux.dev>
 <CAADnVQ+gGYA+gvEOwvqWCSg4jd4CUsxL2ZWUJCtFAhiq2o2Tbg@mail.gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+gGYA+gvEOwvqWCSg4jd4CUsxL2ZWUJCtFAhiq2o2Tbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/8/26 8:24 AM, Alexei Starovoitov wrote:
> On Mon, Sep 7, 2026 at 10:02 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> The following is what I was suggested:
>>
>> llvm: no change,
>>
>> x86_64 jit:
>>
>> +bool bpf_jit_supports_kfunc_arg_slot(u32 slots_used, u32 nslots, u32 align)
>> +{
>> +       if (slots_used >= 6)
>> +               return IS_ALIGNED((slots_used - 6) * sizeof(u64), align);
>> +
>> +       return slots_used + nslots <= 6;
>> +}
>>
>> arm64 jit:
>>
>> +bool bpf_jit_supports_kfunc_arg_slot(u32 slots_used, u32 nslots, u32 align)
>> +{
>> +       if (slots_used >= 8)
>> +               return IS_ALIGNED((slots_used - 8) * sizeof(u64), align);
>> +
>> +       if (!IS_ALIGNED(slots_used * sizeof(u64), align))
>> +               return false;
>> +
>> +       return slots_used + nslots <= 8;
>> +}
>>
>> The above x86_64 and arm64 will reject for certain cases as in the above.
> If such rejection applies to bpf2bpf calls then we cannot use this approach.
> rust-bpf is using i128 here and there and we cannot change standard rust
> crates to shift arguments to satisfy JITs.

The above bpf_jit_supports_kfunc_arg_slot() is for jit, so this is not
related to bpf2bpf calls. bpf2bpf calls work fine.

>
>> The alternative solution is to change llvm's. Let us say we want to have
>> arm64 calling convention. We may have
>>
>>      slot 0: int
>>      slot 1: empty
>>      slot 2: first64 in int128
>>      slot 3: second64 in int128
>>      slot 4: int
>>      slot 5: empty
>>      slot 6: first64 in int128
>>      slot 7: second64 int int128
>>      slot 8: int
>>
>> in llvm and it matches to arm64
>> but it has some issues in kernel as some slot is empty. (slot 1, slot 5).
>> and it needs calling convention change for x86_64.
> Are you saying that x86 won't have slot 1 and 5 empty?
> and first i128 will be in slot 1 and 2.

Yes. For x86, it looks like
     slot 0: int
     slot 1: first64 in int128
     slot 2: second64 in int128
     slot 3: int
     slot 4: first64 in int128
     slot 5: second64 int int128
     slot 6: int

> So if we go with arm64 convention the x86 jit would still need to shift.

Yes.

> If we go with x86 convention then arm64 jit would need to introduce holes?

Yes.

>
> While current bpf convention forces both x86 and arm64 to shift slots?

The current bpf convention assigned arguments in order without any gaps.
So yes, it will force both x86 and arm64 to shift slots.

>
> I think it's better to align bpf with either x86 or arm64.

I did some investigation. Looks like pretty hard.
If we want to align bpf with x86 calling convention, we will need
6 register arguments, alignment requirement for stack (__int128)
and register backfilling as the *common* calling convention.
This will make arm64 harder.

I think we can do a better job by having common struct for the above info:
    nr_arg_regs          // 6 for x86_64 and 8 for arm64
    even_reg_align       // true for arm64
    backfill_after_stack // true for x86_64
    pad_stack_to_align   // true for both arm64 and x86_64
    others if needed

With such information, we can calculate position in verifier.c.
So we have minimum change in JIT.


