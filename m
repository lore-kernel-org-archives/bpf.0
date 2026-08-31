Received: from mta0.migadu.com (out-129.mta0.migadu.com [91.218.175.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC6D39CD04
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788144183; cv=none; b=bPM1xl4HIkLiC9Q46i+WtpdMygDvf4ijXBxzp+UQk8v5KVidf//ietlG1vQ2PUZntb1S0vBgvH6/3WvzrD7mwXXiphy1sfx1mN7a0ubN4IzbYdfJpXLjlfi4Wu2BTAT3RjdNOc1ABQCPmRUiH09V48iGmSOgfXVHU1MZ3VgZpzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788144183; c=relaxed/simple;
	bh=KXRjTbNPhT0bxKewVq3i8YrIISuj+4E4J7j0D0Dbz5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WW1qELNnQUXsFTiVZS19X+tPQito9M7ymxB8UxqgwUOF0NxhMHRgPL6vMrxLdknl9XWMfhHuKqq3jiYvWlUNUlwFWiNDShbDvMzAwPspZdu4odkh4iAVNWFQNgSpZzgxFGSV0XRTzlR7EyS/+V3I6uleJ+GNBSfQphbiYlxBVuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lVB49Csu; arc=none smtp.client-ip=91.218.175.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lVB49Csu"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KXRjTbNPhT0bxKewVq3i8YrIISuj+4E4J7j0D0Dbz5s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788144175; v=1; x=1788748975;
 b=lVB49Csuts4152UVZsIvbgzF4vjU5YIzyA/S2eKsIX5MfyUqCVBetvPgE+PB8KoDKkNkyty1
 1OBbh3/as5Zy2SozIcWku5UUnYbuOcRgxg78e1J+81uM2gY79/hkav/VI4p9U1fejrgGd92VVWt
 EXGw+iPpn/SK3f1pmIvyzsTs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b1467ed925ef6645;
	Mon, 31 Aug 2026 02:42:55 +0000
X-Mizu-Trace-ID: b1467ed925ef6645
X-Migadu-Flow: FLOW_OUT
Message-ID: <86697482-9edf-4b78-8fcb-6cea1bdf7db6@linux.dev>
Date: Sun, 30 Aug 2026 19:42:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 12/12] docs/bpf: Document arena pointers in a
 by-value return
Content-Language: en-GB
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260829061514.1690730-1-yonghong.song@linux.dev>
 <20260829061615.1700421-1-yonghong.song@linux.dev>
 <DL1W44NTIQ1U.1BH6B0V44EFSA@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DL1W44NTIQ1U.1BH6B0V44EFSA@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/29/26 6:33 PM, Kumar Kartikeya Dwivedi wrote:
> On Sat Aug 29, 2026 at 8:16 AM CEST, Yonghong Song wrote:
>> Section 2.9 describes the by-value return contract as scalars only, which
>> no longer holds: a kfunc and a global subprogram may now return a struct
>> or union whose members are scalars or arena pointers. Update it.
>>
>> Note that an arena pointer member is handed back as a scalar like every
>> other member. That costs nothing: the program has to cast_kern() the value
>> before it can be used, and the verifier allows that cast on any scalar, so
>> the member gives the program no reach it did not already have.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   Documentation/bpf/kfuncs.rst | 39 ++++++++++++++++++++++--------------
>>   1 file changed, 24 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
>> index 89dea6b0b024..ebe37c1fe9d2 100644
>> --- a/Documentation/bpf/kfuncs.rst
>> +++ b/Documentation/bpf/kfuncs.rst
>> @@ -581,20 +581,29 @@ against the arena. Larger accesses must verify the range explicitly.
>>   A kfunc may return a scalar, a pointer, or a small struct or union by
>>   value. A scalar or pointer of up to 8 bytes is returned in R0, as usual.
>>
>> -A struct or union returned by value must be composed only of scalars
>> -(recursively), where a scalar is an integer or an enum; arrays of scalars are
>> -allowed as members. Its bytes are handed back to the program as the raw
>> -contents of R0 (and R2), so a pointer field would be laundered into a scalar
>> -and escape the verifier's pointer provenance and reference tracking. A struct
>> -or union with a pointer member is therefore rejected at load time, and so is
>> -one with a floating-point member, which the ABI may not return in R0:R2 at
>> +A struct or union returned by value must be composed only of scalars and arena
>> +pointers, where a scalar is an integer or an enum and an arena pointer is one
>> +carrying the ``btf_type_tag("arena")`` attribute. Those may be nested in
>> +structs and unions and in arrays of any number of dimensions, in any
>> +combination, as long as what the nesting bottoms out in is a scalar or an arena
>> +pointer. Its bytes are handed back to the program as the raw contents of R0
>> +(and R2), so a member of any other pointer type would be laundered into a
>> +scalar and escape the verifier's pointer provenance and reference tracking. A
>> +struct or union with such a member is therefore rejected at load time, and so
>> +is one with a floating-point member, which the ABI may not return in R0:R2 at
>>   all.
>>
>> +An arena pointer member is handed back as a scalar too, but nothing is lost by
>> +that. The program must ``cast_kern()`` the value before it can be used, and the
>> +verifier allows that cast on any scalar, so a laundered arena address gives the
>> +program no reach it did not already have. The result is confined to the
>> +program's arena in either case.
>> +
> I think it would make more sense to support translation for returned arena
> pointers as well, i.e. KF_ARENA_RET + the case you describe above. Like, anyone
> who would use this tag in a struct being returned to the user would probably we
> working with the kernel pointer into the arena.
>
> I think permitting them in the verifier is a good first step, but it isn't all
> that useful unless the translation is supported as well. Otherwise, the kfunc
> has to do it manually, which is a bit of a pain, esp. without access to the
> program's arena's base addresses, which isn't always easily possible across
> various program types.

Probably you mean something like below for input argument 'addr'.

+__bpf_kfunc struct prog_test_ret_arena bpf_kfunc_call_test_ret_arena(u64 addr)
+{
+	struct prog_test_ret_arena r = { .a = (void *)addr, .b = (void *)(addr + 4) };
+
+	return r;
+}

Yes, if kfunc itself wants to do something (esp. dereference of the addr), it cannot
do it.

>
> I can look into doing this in case you don't have cycles, but overall should be
> fairly simple to plumb support.

Sure. Please do it. Thanks!


>
>> [...]

