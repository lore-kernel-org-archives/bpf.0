Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB320468E
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778331383; cv=none; b=Bq3YiTMUIGknKgsyIySeicQ/0OSqgYtjTkxYqAul/26XEydJiDkXyq7JjXbvpMXXuNa9i/FXnkj5L+/9yv/Ea4rWWPf0H2Y32VTqFfCiLJ65JceuTqxmPiEGaXraVbE73f7KCZS+SDP1QPDKjRY6HS/q+qqM5+9uK/Y4+J/2BeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778331383; c=relaxed/simple;
	bh=2VrnzwuNaWCQNTBlBadpyM63Phmh8PTREYS6ER72OGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNJ2zb8Hyi/JrmLXgSKXQ/lo2UUX3qN8wKwyqiJL+lRr2uLKtybqGy+ES/WzHqJxFWIWqYwvMnwc8DLUaiQdhNAFeCetnLty0eUhZdxKLWMU4+vQYys/bTNGpChPV91DIKSzKvnUxrq3s5q9Ad+OYgoqAqXZz+M1osLh7+NH/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gqDS3NDq; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gqDS3NDq"
Message-ID: <e682c84f-f305-4da8-adbf-8d84bbcf3dd6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778331379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SbYxq/+U/BjWFH5CXSxAAeQCa8U4QfJwhh0qqGVlpzM=;
	b=gqDS3NDqdiU3KKgL4q5F+zztF0DA55HzFSYyYtcattjyYSdmVQqpZCO/O2SiiVISoMy3vv
	zu8ZUCh8XnL8ylaJ5wyG0ZGjqFHEzMoRG5U951gTYxQDIWmNX0AD5RF9AuDXFrwihPkKkq
	Pq8ON6s+tegJRABj+XBuPQq0hQBdez0=
Date: Sat, 9 May 2026 13:55:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 05/23] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260507212942.1122000-1-yonghong.song@linux.dev>
 <20260507213008.1127429-1-yonghong.song@linux.dev>
 <DIDHP578A7HC.1LDN8799EQTFV@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DIDHP578A7HC.1LDN8799EQTFV@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/8/26 8:00 PM, Alexei Starovoitov wrote:
> On Thu May 7, 2026 at 2:30 PM PDT, Yonghong Song wrote:
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index fba9e8c00878..0ff8cdf4394f 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1123,6 +1123,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   
>>   		func[i]->aux->name[0] = 'F';
>>   		func[i]->aux->stack_depth = env->subprog_info[i].stack_depth;
>> +		func[i]->aux->incoming_stack_arg_cnt =
>> +			bpf_in_stack_arg_cnt(&env->subprog_info[i]);
>> +		func[i]->aux->stack_arg_cnt = env->subprog_info[i].stack_arg_cnt;
> replied earlier. Should be no need for this copy.

Okay, will do.


