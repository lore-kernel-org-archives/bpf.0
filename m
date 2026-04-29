Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590702EFDA6
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777503311; cv=none; b=k7VZFwi35qENxv4HevT+IJAd9Us94FNoS+ohosCp1LUJ82mABYI0zIFKSqKv12Qhz2kbSqmb8wPWcDUBx0EIn8eTqqzmR4lIc3q7DWgHVLtcb91trWjVWHZjLdP9dTiC7Vr29NBH2Yo4wZGuCe9D/mWiVwQIn6zhirnyXoVIK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777503311; c=relaxed/simple;
	bh=VTIrMGmdAJmuAYVwd8MFv7OEW/WKt9BuDeuRb707dn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbLSgeChADYXHl0POkXFC/BXLwHn8rSYynqT3vW/1xY8eWZP4NSIPxJhf7ZYQsd17F8b9jPzhhA1ZsTPytOj8ISJraNBgrLV4MEAoKKqkuKhR1I4KudX68b/8OV+KAlcAr/1tx90dfNdFGhM2ogqu4y5soJZMAjepR91pv+fVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ubts3PlG; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ubts3PlG"
Message-ID: <5a11f86d-ba74-4c90-ae81-7d9cfc119da5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777503308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4De/6p4FKgX1vIRfTEfZcdkRk+3wRWu1EgsLqSth7KU=;
	b=Ubts3PlG1F2tDXPr+tGnJ94at0lwpTzW1SZoGinHDw46GSCqTfOOSz9A6WH0tNsfErbav2
	ibRk0L/F6atQW5ADFvw3D2Yfw2dXzXBKLgX2SoaWnc33O+4/900viUlW440HjOaPASla0J
	0Gq4HSmPxywNUbBMyeip4ZYMn0SXmJM=
Date: Wed, 29 Apr 2026 23:55:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 03/18] bpf: Refactor record_call_access() to
 extract per-arg logic
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
 <20260424171449.2035279-1-yonghong.song@linux.dev>
 <06f9e1f9f49dbdb0eb96152c3421e83b9cfb474b.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <06f9e1f9f49dbdb0eb96152c3421e83b9cfb474b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/29/26 1:51 AM, Eduard Zingerman wrote:
> On Fri, 2026-04-24 at 10:14 -0700, Yonghong Song wrote:
>> Extract the per-argument FP-derived pointer handling from
>> record_call_access() into a new record_arg_access() helper.
>>
>> The existing loop body — checking arg_is_fp, querying stack access
>> bytes, and calling record_stack_access/record_imprecise — will be
>> reused for stack argument slots in the next patch. Factoring it out
>> now avoids duplicating the logic.
>>
>> No functional change.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
>> +static int record_arg_access(struct bpf_verifier_env *env,
> [...]
>
>> +		for (int f = 0; f <= depth; f++) {
>> +			err = mark_stack_read(instance, f, insn_idx, SPIS_ALL);
>> +			if (err)
>> +				return err;
>> +		}
>> +		return 1;
> Why having both 0 and 1 as success return codes in this function?

You are right. Will remove 1.

>
>
> [...]

