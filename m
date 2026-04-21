Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF4273F9
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 04:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776744258; cv=none; b=YSrlqV1bt6GMrZSvUzowfPZNmMs7gdeIKDpHZ+a3v9znfCC6XKhvOPSf1D8dmM+bV8XQiarVJEyznfjnt8pcafdu+1XLf7QLstsMn9/Qq5ekAoRrTh8y55+h2Hd5/vY048IVvr2wXveEoDZz6FygKQchAZ4zi3ALkwpZgy/82MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776744258; c=relaxed/simple;
	bh=+65MU1mn8sc1oOklB1XUMgj41eQbpNfOJoOydtYRVgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxTur9B2T7Cvxv+CBOZarSyBcynxNT/TZZBkju6XvGOmhKmG4eFBqidwx3avyQyOCgZ/i/9v32sYutfAavYORz6je2RN+j9Rnm94R8dR3QustmNFGUaW62q9OjfvaoncHGHf7Z9vjfnIAzxCuNZnGELMTcF6MOgScd8gePM5mes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AbGzzn2v; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AbGzzn2v"
Message-ID: <67008584-6e09-4837-97a5-b61a060a7ce1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776744255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdYDlONfkQY+EDhjSo9k0qpWdTyk4nLUEr3ovOgWv9E=;
	b=AbGzzn2v1ZA7PkhIgxln61U8WTHmWZYK2RHpiF/enbhpLEBoeMbqz2werfFv9gEftMXJOD
	o2zqpkqOrX4S3kGgj5Ni3Nnv/I5bRTupox4xURCMZkwmaOMszr8ZO4P+akO081ESot7zlR
	5pm7F8DaCOXO/DwGfCJGYHh3leVK/x8=
Date: Mon, 20 Apr 2026 21:04:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 03/17] bpf: Refactor to handle memory and size
 together
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260419163316.731019-1-yonghong.song@linux.dev>
 <20260419163331.733278-1-yonghong.song@linux.dev>
 <DHYE1BFZ7PIB.1ZNRQN7ZDK8EZ@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DHYE1BFZ7PIB.1ZNRQN7ZDK8EZ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/20/26 4:58 PM, Alexei Starovoitov wrote:
> On Sun Apr 19, 2026 at 9:33 AM PDT, Yonghong Song wrote:
>> + * @mem_regno is the register containing the pointer, mem_regno+1 is the register
>> + * containing the access size.
> wrong comment. should probably say that size_reg is the register that contains size.
>
>>   
>> -	WARN_ON_ONCE(regno < BPF_REG_2 || regno > BPF_REG_5);
>> +	WARN_ON_ONCE(mem_regno > BPF_REG_4);
> this warn is too late here. Can be removed.
>
>>   
>>   	memset(&meta, 0, sizeof(meta));
>>   
>> @@ -7129,8 +7130,8 @@ static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg
>>   		mark_ptr_not_null_reg(mem_reg);
>>   	}
>>   
>> -	err = check_mem_size_reg(env, reg, regno, BPF_READ, true, &meta);
>> -	err = err ?: check_mem_size_reg(env, reg, regno, BPF_WRITE, true, &meta);
>> +	err = check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BPF_READ, true, &meta);
>> +	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BPF_WRITE, true, &meta);
>>   
>>   	if (may_be_null)
>>   		*mem_reg = saved_reg;
>> @@ -8594,7 +8595,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>>   			return -EFAULT;
>>   		}
>>   		key_size = meta->map.ptr->key_size;
>> -		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
>> +		err = check_helper_mem_access(env, reg, regno, key_size, BPF_READ, false, NULL);
>>   		if (err)
>>   			return err;
>>   		if (can_elide_value_nullness(meta->map.ptr->map_type)) {
>> @@ -8621,7 +8622,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>>   			return -EFAULT;
>>   		}
>>   		meta->raw_mode = arg_type & MEM_UNINIT;
>> -		err = check_helper_mem_access(env, regno, meta->map.ptr->value_size,
>> +		err = check_helper_mem_access(env, reg, regno, meta->map.ptr->value_size,
>>   					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
>>   					      false, meta);
>>   		break;
>> @@ -8665,7 +8666,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>>   		 */
>>   		meta->raw_mode = arg_type & MEM_UNINIT;
>>   		if (arg_type & MEM_FIXED_SIZE) {
>> -			err = check_helper_mem_access(env, regno, fn->arg_size[arg],
>> +			err = check_helper_mem_access(env, reg, regno, fn->arg_size[arg],
>>   						      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
>>   						      false, meta);
>>   			if (err)
>> @@ -8675,13 +8676,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>>   		}
>>   		break;
>>   	case ARG_CONST_SIZE:
>> -		err = check_mem_size_reg(env, reg, regno,
>> +		err = check_mem_size_reg(env, reg_state(env, regno - 1), reg, regno - 1,
> or moved here.
> I would just remove it.

I checked logic and it seems this warn should not really happen. So removing it sound a good idea.

