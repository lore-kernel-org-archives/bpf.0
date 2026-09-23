Received: from mta1.migadu.com (out-13.mta1.migadu.com [95.215.58.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C841B355
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186483; cv=none; b=ACBJUd2GAnVEagUI7QSvBQ0z8+gT9QvMcuxDcKndmkElcFjbDnPB6g3dNpSKWr5YdyXs9etQP2c6Hj4IvKAbnM5jqu218KBYq7djpyLYUhL5aHFeqaMAZxYCkysZEXvVNOuPeCMvm1dFOuNXtw3CyPy/f7Or7xhlOPZpfBX55s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186483; c=relaxed/simple;
	bh=gtvFUMn2jOu52uQcq+9/FR3Cvfm61iHPxeFcFGYsegI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SndLsUfxmbGGyOZxgx3S8rTvQkXgbdIQlV2fP7XK4ZutL7xh4yTZOFRvQHo/z6JoS+K/Depab8xXNlgDJYy9l3Efymd6UF6jLTQPrXhjnbcX91xwgs0IOhE6+KpZBpZ3d95hjDLOcbhNuJrtRDzPJlSbSrbXnb0YTQY5Q3dO3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ho1caNiC; arc=none smtp.client-ip=95.215.58.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ho1caNiC"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gtvFUMn2jOu52uQcq+9/FR3Cvfm61iHPxeFcFGYsegI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790186478; v=1; x=1790791278;
 b=ho1caNiCi3aUCWjXra31eFuRv96os8AgE6vTXosnHoFx7H/GN9OPWodjOlqL/KB5sQE9+0PP
 bpw9BJRJdDRKiSepXktAb89YuUu1cgjPlLD6Y0+BnPR2xZOdfsm09C/0QlXCTSiaSa0Y98Xb0Wb
 HKRmwCq/dOF+FAwegqEYHUyw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1e591b363971c872;
	Wed, 23 Sep 2026 18:01:18 +0000
X-Mizu-Trace-ID: 1e591b363971c872
X-Migadu-Flow: FLOW_OUT
Message-ID: <6ade3aa7-a77e-4a69-81d7-4514a35bc4d3@linux.dev>
Date: Wed, 23 Sep 2026 11:01:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 08/21] bpf: Walk the exception unwind in the
 verifier
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
 <20260923045927.2418543-1-yonghong.song@linux.dev>
 <2333883f3fe2abcc40679edb4dc11f7b9bf5d1dd.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2333883f3fe2abcc40679edb4dc11f7b9bf5d1dd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/23/26 9:34 AM, Eduard Zingerman wrote:
> On Tue, 2026-09-22 at 21:59 -0700, Yonghong Song wrote:
>
> ...
>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index e12ec91b8150..3146f707e030 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -429,7 +429,8 @@ struct bpf_jmp_history_entry {
>>   	u32 prev_idx : 20;
>>   	/* special INSN_F_xxx flags */
>>   	u32 flags : 4;
>> -	u32 : 8;
>> +	u32 unwind_frames : 4;	/* frames popped to reach this landing pad */
>> +	u32 : 4;
>>   	/*
>>   	 * additional registers that need precision tracking when this
>>   	 * jump is backtracked, vector of five 11-bit records
>> @@ -510,6 +511,9 @@ struct bpf_verifier_state {
>>   	bool speculative;
>>   	bool in_sleepable;
>>   
>> +	bool unwinding; /* an exception is in flight */
>> +	u8 unwind_frameno; /* the frame whose landing pad is running */
>> +
>>   	/* first and last insn idx of this verifier state */
>>   	u32 first_insn_idx;
>>   	u32 last_insn_idx;
>> @@ -991,6 +995,8 @@ struct bpf_verifier_env {
>>   	} cfg;
>>   	struct backtrack_state bt;
>>   	struct bpf_jmp_history_entry *cur_hist_ent;
>> +	u8 cur_unwind_frames; /* frames popped to reach this insn, if a pad */
>> +	u8 unwind_frames; /* frames popped, staged for the next insn */
> Similarly to v4, stashing these variables into env in one place and
> reading them in another in order to push to jump history is an
> obfuscation step. Why don't you want to push to the jump history right
> away? Like in [1].
>
> So far the only field in env that changes with current verifier state is insn_idx.
> I don't see why this feature requires adding two more such fields.
>
> [1] https://github.com/kernel-patches/bpf/commit/fbc89e90cacd207b4271da25ed7a380f6b56125e#diff-edbb57adf10d1ce1fbb830a34fa92712fd01db1fbd9b6f2504001eb7bcc7b9d0R5604-R18577
>      (with corresponding changes in backtrack.c in the same commit)

Okay, I looked at your backtrack.c and verifier.c related code.
I will use jump history then.

>
> ...

