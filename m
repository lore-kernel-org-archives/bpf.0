Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A73CEB8D
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090466; cv=none; b=bwC5Jt0dq8It/di1aN7JHFgHNqSha1oqCfzvTrsJXghDc4ZUrbYC0u4sRLqQutao4y9TGqyDGbwmP0GQHcOJhh+QZiyUcDidmtt8PZtEjvVnswd6UdjuHgWQ71sRvt2hJHix8GXQ6D3tVuBTn9Sf01LCe6fWLcyA0dpbWI3Hp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090466; c=relaxed/simple;
	bh=s1eLIhaTJqfaDV+w4RtVPu7koBsSM/jB9ejz7RfaXX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkGQ9H+o+mMg1OFgPb2ryw9RgMTvzUL0bEV9ejj3NJwf6+XH2AsK2cdP6GoodMTkhBhuGqjIAFRoLKuXJR90AmzLXyx4ZcSir0qJgseXW+vTOnISmqDL01CJ3IV0S6/oscxh7g+7kUs1WP3jnvO/VTtYBe8EcGasqK3Pxss0ESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oy3J0Z9i; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oy3J0Z9i"
Message-ID: <eec4249a-bd91-4a26-a1b2-e41faf4bb3d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776090462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUOQbSrZ6DKvUJDOk/Jo8LQHcVnQZxjKh6Xf2t/ykMk=;
	b=oy3J0Z9iXiUjMUSblm86DIz3CAc75BBdJWQbxyO7wqHc/MhYOc3gczGM9Y5VTG3PBSLNto
	poQUe5ujehnmTzwx1KjhUgC2LCcL4tAlxbubyRUOUhrcHphEjF+XyV90dCxfE3pL4GBA5S
	FIma63Vz9sHVgu+hjvd9VnEgADYL/gE=
Date: Mon, 13 Apr 2026 07:27:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 04/18] bpf: Refactor to handle memory and size
 together
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260412045847.255351-1-yonghong.song@linux.dev>
 <834331bd3a4dd3bc2a3b365ae9dcf8031f22041d33623c1712432f5083f15c9a@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <834331bd3a4dd3bc2a3b365ae9dcf8031f22041d33623c1712432f5083f15c9a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/11/26 10:31 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4c67a15c73e1..cddd39ebb40b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -8591,11 +8591,13 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
>>    * containing the pointer.
>>    */
>>   static int check_mem_size_reg(struct bpf_verifier_env *env,
>> -			      struct bpf_reg_state *reg, u32 regno,
>> +			      struct bpf_reg_state *mem_reg,
>> +			      struct bpf_reg_state *size_reg, u32 mem_regno,
> The function comment above still says "@regno is the register
> containing the access size. regno-1 is the register containing
> the pointer."
>
> After this refactor there is no @regno parameter.  The parameter is
> now mem_regno, which is the memory (pointer) register, not the size
> register.  Should the comment be updated to match the new signature?
> Something like "@mem_regno is the register containing the pointer,
> size register is at mem_regno+1" would match the actual interface.

Ack. Comments need update as well.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635

