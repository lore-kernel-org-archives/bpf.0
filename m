Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A456E053
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196352; cv=none; b=aOV/AYX+byykQRGLetbUbMIsh1CNG7W2cnZNyWbUkrULon6XukpI9RzPm4qYm5Hs+ujbjsNFWKsUb2lt4sCNivdjuH4/tSUbiOq048kaO2hwInt/sneGZhR1dvQ4j+3kkA111xNEVvgH2HN/M3a6gP3OP9feMuTSefGhVhkAWws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196352; c=relaxed/simple;
	bh=bjwZnyi9kfqMo1cRNnmD24SEUqe6wrt1eRLPhvDPOgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHp7hCq1n9swMnRsHxoSQlrWlAXBHWEFh0FQybBdsIm+fwp9Bkhjjj+o7PYX6/G7v2H/TjpiXXxVHcQ9dw/Pb7hoYyfzCHQ0EIPAn7S6fQpnI9k/wpJH0GsgGPXYZtMrCdB8Xnq8veY7GbjUnqchdcJaYEvxbvlkxg/xrtrwWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P8REf+Cp; arc=none smtp.client-ip=91.218.175.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P8REf+Cp"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bjwZnyi9kfqMo1cRNnmD24SEUqe6wrt1eRLPhvDPOgk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790196344; v=1; x=1790801144;
 b=P8REf+CpyUla2Ou802UxMmg4WgtfYYfKXgRZb55mPXRFvRJIz0+3vksrVsgkVKvXiPV6UOWc
 OESE28RH3w3LGIAjB6yVer49xZxoGWPiqe3fgF5QvesMuvZKejgwHnj3QE0tDE/xiYdEF/rcB7K
 Mdn3G4LiWdy0QrOvGoZNg8Uo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2ba393c5287b4f65;
	Wed, 23 Sep 2026 20:45:44 +0000
X-Mizu-Trace-ID: 2ba393c5287b4f65
X-Migadu-Flow: FLOW_OUT
Message-ID: <40c6a390-fa87-471d-b75f-9d08b0791e70@linux.dev>
Date: Wed, 23 Sep 2026 13:45:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 12/21] bpf, x86: Dispatch exception cleanup
 pads at run time
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
 <20260923045948.2420512-1-yonghong.song@linux.dev>
 <a47eb8c7aa3c9806b2a4e01554f5c6daa3fa9f6c.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a47eb8c7aa3c9806b2a4e01554f5c6daa3fa9f6c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/22/26 11:45 PM, Eduard Zingerman wrote:
> On Tue, 2026-09-22 at 21:59 -0700, Yonghong Song wrote:
>
> ...
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index d4a980140b48..26df52050cd7 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> ...
>
>> @@ -2024,7 +2034,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>   	/* Exception callback will clobber callee regs for its own use, and
>>   	 * restore the original callee regs from main prog's stack frame.
>>   	 */
>> -	if (bpf_prog->aux->exception_boundary) {
>> +	if (bpf_prog->aux->exception_boundary || bpf_exc_force_spill(bpf_prog)) {
> On option to avoid spilling all the registers would be to use register
> liveness information at call sites and collect a union of registers
> alive at landing pads for all callers of this particular function.
> Wdyt?

I will try to fix the above to avoid saving unnecessary callee saved registers.
The below is the code in x86 bpf_jit_comp.c:
	push_callee_regs(&prog, callee_regs_used);

>
>>   		/* We also need to save r12, which is not mapped to any BPF
>>   		 * register, as we throw after entry into the kernel, which may
>>   		 * overwrite r12.
> ...

