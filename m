Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575FD2F8E81
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841164; cv=none; b=TkZ4qNuwLmdanbbFzosnYS4JwT8s8b7e+Hl0t6a7m64aFuzRhi3lTp/4+CKDf0yUYGCtVxClaO/fQPh6eaU11EGSO6Y17ooXZ54kvBWSNjMgDe+wsOvxaKfubgDU2VeWqMGZWhnJ0JJ8VRH2uEfO3isTZ9bhWcNribcnF9mrX88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841164; c=relaxed/simple;
	bh=cRH6f3gL45eZeqlpepa5beYoJGeoBkifQQm+2f2O5kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBgILVWQnWs+d0Trr9k4eVRnbNNcAE/76HsADPZ1vX298ajif08yAnPFG+OXRetCvzwjsu2l/8fbAquILX7uUVHvd84vCutLC63NFH6/6j82CIGdxrC0nYI9Ewh31SI/l78q/X5/lz3oAsouz8AV5WfLnWGC935lyds13RRBhHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ivj57uns; arc=none smtp.client-ip=91.218.175.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ivj57uns"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cRH6f3gL45eZeqlpepa5beYoJGeoBkifQQm+2f2O5kQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788841160; v=1; x=1789445960;
 b=Ivj57uns7zosQHD5HD++J11fkKinsUaykSRU9NfvVPUUYXePJKRr3mR+Pq0TpMfZ62cWyidu
 NGF58kbxlmkq0BryR2FsYX1CBBDf0BgH/B1Rpqm40o5IRxqmSxqIJNGzf3MmpWBgI8KO9x/iPry
 Uxf2YZg7lpyuyfH1cra+UA88=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id aa02da0a3c645579;
	Tue, 08 Sep 2026 04:19:20 +0000
X-Mizu-Trace-ID: aa02da0a3c645579
X-Migadu-Flow: FLOW_OUT
Message-ID: <f552724f-e978-4cb4-a4c9-3069eb170027@linux.dev>
Date: Mon, 7 Sep 2026 21:19:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 03/12] bpf: Support by-value struct arguments up
 to 16 bytes
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260904051013.3978240-1-yonghong.song@linux.dev>
 <b138867c4eb9919dddb35a674224d5346c809970749a5a52f378fbc3ad19e376@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b138867c4eb9919dddb35a674224d5346c809970749a5a52f378fbc3ad19e376@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/3/26 11:09 PM, bot+bpf-ci@kernel.org wrote:
>> A global function taking a struct or union by value is rejected today:
>>
>>    Arg#1 type STRUCT in tar() is not supported yet.
>>
>> A struct of at most 16 bytes arrives in one or two consecutive
>> registers. Currently, the struct is composed of scalars.
>>
>> The slots of a value are independent of each other, so the compiler may
>> split one across the last argument register and the stack, as in
>>
>>    static void f(int a, int b, int c, int d, struct pair p);
>>
>> or place it wholly past the registers, and the verifier describes either
>> the same way. What has to follow the slots is stack_arg_cnt, recomputed
>> from the slots consumed, together with the "no stack args in global
>> functions" and JIT support checks.
> This isn't a bug, but could the wording be more precise? The phrase
> "Currently, the struct is composed of scalars" reads as a statement of
> fact about a particular struct, but the code enforces it as a requirement
> on every by-value argument through btf_struct_is_composed_of() in
> btf_prepare_func_args(). Would it help to say that only scalar-composed
> structs are accepted for now?

Okay, will clarify in the commit message.

>
> Also, the changelog doesn't mention that sub->arg_cnt changes meaning from
> the BTF parameter count to the argument-slot count, which is the reason
> the kernel/bpf/verifier.c hunk is needed at all. Would noting this change
> help reviewers understand the verifier.c modification?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33840714551

