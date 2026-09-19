Received: from mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B162D781B
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789845233; cv=none; b=DJG/LNnmha+YXOQ2ZzUy4ic0Sf8dkwJkQ+FU14SJ31m83YKvExmu34MN6TLOb2AaJLawQxordBxJ4oMONR8RBgGm3nMnWDnse/od6c6OYruy3BlOek8Sfhchd4Vdniep9hXT+//OFUoXLa9rcxbwPZXUtLGABE5v+GTkEoJWpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789845233; c=relaxed/simple;
	bh=dMACzPwKf9OnNgF5dmd1gu+4vv2u1CPWxvleDzkeWAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyMl9u6+dg5WFw9ajBij36V1Yu+lG4x+ArxVwzEgzT1p1FxpgBXHlJN/YfbBkgE4h2eU26wnyWLjcUtG/iYz1wD3WHuOR88KIN45GGygnDM9oLlnqO8fDn/RS7Ueob8RtEn1nMT8uTXzucEn8HJiQYbaAFSRQozK7jXltzoDWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wAv9UG22; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wAv9UG22"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dMACzPwKf9OnNgF5dmd1gu+4vv2u1CPWxvleDzkeWAU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789845227; v=1; x=1790450027;
 b=wAv9UG22LfwEqjVovcXzdQg2ZPhgG5g8igmWTvtRuTWYb2XhKaioIyIfwUehzI93gelyCwsD
 ZKo7J6Bx2m0vzQsKtNKocmlEO7gm/kZlmBRdhlvkBnm07+uk0Kdhj94vmXLxyfwHKaYyphkeZtz
 QtNrf5hpurFFzF9iiDJO+rAs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5ac2c5782724c2ec;
	Sat, 19 Sep 2026 19:13:47 +0000
X-Mizu-Trace-ID: 5ac2c5782724c2ec
X-Migadu-Flow: FLOW_OUT
Message-ID: <978c00dd-073e-4850-928f-21a50b5b52ac@linux.dev>
Date: Sat, 19 Sep 2026 12:13:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 11/20] bpf, x86: Dispatch exception cleanup pads
 at run time
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055742.3932170-1-yonghong.song@linux.dev>
 <DLJ12W1FWIT3.3GC1GC68Q1ANU@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLJ12W1FWIT3.3GC1GC68Q1ANU@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/26 10:02 PM, Alexei Starovoitov wrote:
> On Wed, Sep 16, 2026 at 10:57 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index d4a980140b48..9d0dd54773e8 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [...]
>
>> +			if (bpf_is_unwind_resume_kfunc(insn)) {
>> +				emit_return(&prog, image + addrs[i - 1] + (prog - temp));
>> +				break;
>> +			}
>> +
>>   			func = (u8 *) __bpf_call_base + imm32;
> bpf_is_unwind_resume_kfunc() matches imm == btf_id && off == 0, but by
> now bpf_fixup_kfunc_call() has rewritten every other kfunc's imm to an
> offset from __bpf_call_base. A vmlinux kfunc that happens to sit
> btf_id bytes after __bpf_call_base gets JITed as a bare ret in the
> middle of a normal prog. Looks incorrect.

Right, bpf_is_unwind_resume_kfunc() is not correct as it compares
'imm == bpf_id' while imm has been rewritten.
Will fix.


