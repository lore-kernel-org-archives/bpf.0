Received: from mta1.migadu.com (out-111.mta1.migadu.com [95.215.58.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474721A262A
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789839174; cv=none; b=gts/CMSIgYCmm6/ebpJQhWSJZHl95DcX1Np79G0q/XlRad7LZZPtNf+ZrO0azwLwkX3IZ3kAVM7eUYBYcyfHobod/5k95pbh0RgFZKEtmMGID7S9CT6E7szDW7ARi2eoU2C7yFBjbmmZ8BKqGMcXwJO7nHOVwCeu/6L0jLzwQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789839174; c=relaxed/simple;
	bh=ymlogA30i9B8E/U0OlUaZVK+x3fFDIw4of2VH+NmyjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8n7Whh3l4E4ZvEDID1oJZh7LP4ww7Sero4WsdhgMoG5r0Ix36YpSdQwlvxpwD9RgfxV6Hola7TAJtqSxjYqIz0WVr7gxB675W2+j1nV2am2gKyZd0cib7nQbytIOBSQbgHw9fLnsJCzOR6mN1lauQUu+oMELBEKc/Kpt1z5MTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UlyzKN2B; arc=none smtp.client-ip=95.215.58.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UlyzKN2B"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ymlogA30i9B8E/U0OlUaZVK+x3fFDIw4of2VH+NmyjI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789839169; v=1; x=1790443969;
 b=UlyzKN2B9Qbb3GnCnHWFV6JTanVL06VKiJXVEO993X9h2clVr8bZmRhtjrVkxTM3V0vBYWWb
 4MPuToEcwb6X2Oj6hN1wkl6YJXl7cJtG84DW0+bw4kiFTN30Dz+ej+a89oYQb0QHLRXLNJ9eGUq
 fMCRJMkqhkCYlE9K+wXyAtkI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e7a9e43ca0fa8c19;
	Sat, 19 Sep 2026 17:32:48 +0000
X-Mizu-Trace-ID: e7a9e43ca0fa8c19
X-Migadu-Flow: FLOW_OUT
Message-ID: <b6a90c30-1264-4e89-ab41-f9599e9b47bd@linux.dev>
Date: Sat, 19 Sep 2026 10:32:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 07/20] bpf: Refuse exception cleanup shapes
 bpf_throw() cannot dispatch
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055721.3930090-1-yonghong.song@linux.dev>
 <DLJ0YN08I6GZ.324HCC3XBJ738@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLJ0YN08I6GZ.324HCC3XBJ738@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/26 9:57 PM, Alexei Starovoitov wrote:
> On Wed, Sep 16, 2026 at 10:57 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index dfe9c2a9ce7d..b2bf831242b8 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
> [...]
>
>> +static enum cleanup_insn_kind cleanup_classify(struct bpf_verifier_env *env, u32 i,
>> +					       int *next, int *target)
>> +{
>> +	struct bpf_insn *insn = &env->prog->insnsi[i];
>> +	u8 class = BPF_CLASS(insn->code);
>> +
>> +	*next = i + 1;
>> +	*target = -1;
>> +
>> +	if (insn->code == (BPF_LD | BPF_IMM | BPF_DW)) {
>> +		*next = i + 2;
>> +		return CLEANUP_INSN_PLAIN;
>> +	}
>> +	if (class != BPF_JMP && class != BPF_JMP32)
>> +		return CLEANUP_INSN_PLAIN;
> robot voice:
>
> LD_ABS/LD_IND is not plain. bpf_check_cfg() treats it as an abnormal
> return and gen_ld_abs() later patches in a real "r0 = 0; exit" for the
> failed load. With this classification a pad in a tc prog that keeps
> skb in r6 and does an ld_abs passes t
> he "reaches no exit" check,
> cleanup_check_pad_insn() doesn't look at it, and check_ld_abs() only
> wants no locks/refs held at that point. At run time a failed load runs
> the subprog epilogue on the walker's stack: callee regs get popped
> from arch_bpf_run_cleanup_pad()'s frame, leave/ret with rbp == the
> unwinding frame goes straight back into the BPF caller with garbage
> in rbx/r13-r15, and the rest of bpf_throw() is abandoned.
> Treat it like BPF_EXIT here or refuse it in a pad body like tail call.

Yes, this is an issue. For insns in landing pad, we should not allow
LD_ABS/LD_IND since they will have a hidden return. So the above suggestion
to refuse it in a pad body is correct.


