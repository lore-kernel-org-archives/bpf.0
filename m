Received: from mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE13377A85
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133771; cv=none; b=QBpAtiVV3QaHVgx/nlVRz7aySPg1zHVNpVLiLwR6aaS3QdVlWeLGT50lXP8WIOvZ28pakGiP1DMSaGgoYrvM3virI4YVdkkfPcL8IUzPjV5hH6XpySqU1V3vkPnoveiFoPuf6GBU9UeW8D0M/TJOLtOWZUqM1Z3yV2TdRLjEGYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133771; c=relaxed/simple;
	bh=uoxdWrK070zk+RhaPnauKaqc02kIUxPDX0WvC2vJ8t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqvKJBcdXU/LsvAOgJIA2A/IuS1fhZKsiA6uVkmKMttbpoFtzF6KEE0geZgx0/U/jjw1kT36LqXC8D8u5JLndvyQEdx1u1n8dxCFGDFd2ZP+RsqJVIxyhAXPtP1eR07yi/eyUf5/2b8l6mXxigGYR6bMNXxea+PPE/Bu7eVFQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xGaeZwko; arc=none smtp.client-ip=91.218.175.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xGaeZwko"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uoxdWrK070zk+RhaPnauKaqc02kIUxPDX0WvC2vJ8t0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790133767; v=1; x=1790738567;
 b=xGaeZwko55Zmo436N4+ibX5jbnxO0EychSp88EArCmh05vLD94pnamOBZaAZwyzN1q8cJOtf
 nTPZaSxm2ljc2WynrXOGUpWly20//N4+49I+jbTfPAaD0sYt+M0cBXsVWGv+mt5iedDmD2wTpXe
 L+cVV4aFXYLXJbWB6wk8Qz10=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a94d06017295b8b0;
	Wed, 23 Sep 2026 03:22:47 +0000
X-Mizu-Trace-ID: a94d06017295b8b0
X-Migadu-Flow: FLOW_OUT
Message-ID: <3cbb41d8-7f9a-4b28-9afb-4de04c874585@linux.dev>
Date: Tue, 22 Sep 2026 20:22:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 10/20] bpf: Dispatch exception cleanup pads
 from bpf_throw()
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210124.1720888-1-yonghong.song@linux.dev>
 <19302dc5c59170ec4980d2757a1c2aa91bed07e5.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <19302dc5c59170ec4980d2757a1c2aa91bed07e5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/26 2:38 PM, Eduard Zingerman wrote:
> On Mon, 2026-09-21 at 14:01 -0700, Yonghong Song wrote:
>
> ...
>
>> +static int cleanup_pad_body_for_subprog(struct bpf_verifier_env *env, struct bpf_prog *sub,
>> +					u32 start, u32 end)
>> +{
> pad_body{,_bits} are redundant, jits have access to insn_aux_data.
> all this machinery can be dropped.

Good point. This can simplify the code a lot!

>
>> +	unsigned long *bits;
>> +	u32 i, cnt = 0;
>> +
>> +	for (i = start; i < end; i++)
>> +		if (env->insn_aux_data[i].in_cleanup_pad)
>> +			cnt++;
>> +	if (!cnt)
>> +		return 0;
>> +
>> +	bits = bitmap_zalloc(end - start, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
>> +	if (!bits)
>> +		return -ENOMEM;
>> +
>> +	for (i = start; i < end; i++)
>> +		if (env->insn_aux_data[i].in_cleanup_pad)
>> +			__set_bit(i - start, bits);
>> +
>> +	sub->aux->exc->pad_body = bits;
>> +	sub->aux->exc->pad_body_bits = end - start;
>> +	return 0;
>> +}

