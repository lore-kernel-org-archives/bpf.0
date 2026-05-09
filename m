Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5B03932DC
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334253; cv=none; b=mFjuEcVkd2lkDYeEIo/ASp1ibD6BjzKwOgw8mDxnVIPqXYUDTtNMN6A/1m/+iKgNkne1q/tPQ025hY5Gpc8GppHtDKww+dO1LD6fd3e4O/s28v+uUuV2jr9/HhC7nZrwLqf2ZV+T3RkblxiximZyW/NxmyRrFCU2gyy2wni2VN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334253; c=relaxed/simple;
	bh=EItFukBZHihPAqnSKcifQSaMA/6ak7SU3XLqj2mJSfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5fLA/mmZO0QO1hCJ4aZySyLOk130u230rFckqURy0cCHBiM4JzI69MnGJinx2qyZ6eIiXa8Dd68iidJSt19TciEkoMCCbMnbrdrdi3MCt4lrTLgUrmBrMlcFb3xodIIM6xl/FT5hMjuKeAWlZGJkJY8W/sfMleUj/H8I2SlXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tl5cdJuA; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tl5cdJuA"
Message-ID: <4230ccc8-e8dc-4596-ac4b-c86b20adecd0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778334249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EItFukBZHihPAqnSKcifQSaMA/6ak7SU3XLqj2mJSfk=;
	b=Tl5cdJuApT3oqPLp31RMlPB5RTHIAeXtnJCQxot/+mcVSEZSCHvsTFxtMh51uOUt3lQ7+5
	hSaHwAv+GpvZ3Ta589olLQdrM2iE9p2y2MxE4NpzKKdZ0HZk3ADPOo7pD45/PWmrA+ln7N
	26CRuaXQCSKGhBHvauX4QP7lqinoa10=
Date: Sat, 9 May 2026 14:44:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 21/23] bpf, arm64: Map BPF_REG_0 to x8 instead
 of x7
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>
References: <20260507212942.1122000-1-yonghong.song@linux.dev>
 <20260507213156.1139442-1-yonghong.song@linux.dev>
 <DIDHQFKDC6HH.4WI1HOEQ6HT5@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DIDHQFKDC6HH.4WI1HOEQ6HT5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/8/26 8:01 PM, Alexei Starovoitov wrote:
> On Thu May 7, 2026 at 2:31 PM PDT, Yonghong Song wrote:
>> From: Puranjay Mohan <puranjay@kernel.org>
>>
>> Move the BPF return value register from x7 to x8, freeing x7 for use
>> as an argument register. AAPCS64 designates x8 as the indirect result
>> location register; it is caller-saved and not used for argument
>> passing, making it a suitable home for BPF_REG_0.
>>
>> This is a prerequisite for stack argument support, which needs x5-x7
>> to pass arguments 6-8 to native kfuncs following the AAPCS64 calling
>> convention.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> That's not right.
> It should probably be:
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

My mistake. Will fix.


