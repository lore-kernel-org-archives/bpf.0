Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9F026A1C4
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660176; cv=none; b=j/GCm0IsIGKnAOzpACvS4CYlOX1YC4Euum82fZycsFEki6Xq0eikCiJY26jkO6uGE2H774PPk8EXbR/lP4MIbI5w9W8soi2p27iEg6y7TH0vPBQV8+AW3Cg68xzIomE3mdxSRYS9KKfLBh6eEfwuYAhI9hC4V0tl+q+J8p58WxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660176; c=relaxed/simple;
	bh=bWA0z99gJuvnS0hIP9mg04q8oaSKeEMhHyZo1KMd2U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ47fTRsMHyPSuAURzaM3UcSD4JsuWBH9UPrT9bO1EKTg1Lbq4oFSRCvaktF/oDPbx4ESurbpn4xYxUv6r+9QMfJJY7VZQIhQ5r+R4J+TQKcqBBGX61MWW+zMRI/lUCvpTrwfmXM8SBRw5iWVzI2q98iztal3I5k3ZNoWbaZ5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gxz5+gAw; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gxz5+gAw"
Message-ID: <72cf9c2a-cafa-46c1-8746-9a8b53e5c1c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783660171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qsf1a7+C/injUduJK+RTXrrNkY17GP4LO0keG5njORs=;
	b=gxz5+gAwoPgwh12XhEoES18sZEN2GzLC+S5ze3YgXPMPGD4XHLq1Cnp6gSI4bENhQlA4MM
	ZClnTb4giodnDH/dj5/TILZdHb6OO5gYlJrozTkSnhGeZfc3MU80KAkzFZ7MA6ZDhV+MpA
	LdBVB8Y8LPEaTuQGy1O6eADqYeW+yyU=
Date: Thu, 9 Jul 2026 22:09:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 06/12] bpf: Force JIT for programs using the
 R0:R2 register pair
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201010.2158718-1-yonghong.song@linux.dev>
 <cdff0944003193d4224a1fec5f1fb9fa8bd76801.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <cdff0944003193d4224a1fec5f1fb9fa8bd76801.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/9/26 3:27 PM, Eduard Zingerman wrote:
> On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:
>
> [...]
>
>> @@ -9877,7 +9886,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>   	} else {
>>   		/* return to the caller whatever r0 had in the callee */
>>   		caller->regs[BPF_REG_0] = *r0;
>> -		if (bpf_ret_reg_pair(env, callee->subprogno)) {
>> +		if (bpf_ret_reg_pair_mark(env, callee->subprogno)) {
> Also, doing this while processing exit is a bit strange.
> I think this should be done in do_check_common().

Before sending this patch, I found two places to do this, prepare_func_exit() and
do_check_common(). Since you mentioned, I will do do_check_common() then.

>
>>   			if (callee->regs[BPF_REG_2].type == PTR_TO_STACK) {
>>   				verbose(env, "cannot return stack pointer to the caller\n");
>>   				return -EINVAL;
> [...]

