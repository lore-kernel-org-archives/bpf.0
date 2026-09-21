Received: from mta1.migadu.com (out-160.mta1.migadu.com [95.215.58.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1718E4E0B78
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016269; cv=none; b=B/tRn3IB6Wr/0ubT1+mddzAQt3iQZ6M3YA0hkxHASycKU+6BE+LIBhbdzCeWFX0ibCFfS7sV2oPiskgKCSgwRhMrTeJv0Sg7GiaX2powPtQPTqzQ5P9KLX2KYHnxEjxo7qZea/izeSPDOkEulwZ06zPiVroHQ7KV+kb9SnywWxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016269; c=relaxed/simple;
	bh=4whLlJ5HdZQmQogZNAqZXk4GU1IkwKwJWSrRgBfhUrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4eud6F4SwSccMm+5+OvVFiVoH/ZsVKilWqAc2UbM1v4QpR1b6x6QbdW6BLNkstX9plndf+lZaDc4154Q+vav+QT7GSSYs7gZ5rM2owIPWv7YY98545iLHybpmgPHbUq0FQWiQZak9RAOCajnzxy2KnGnhExFrFwnG5KFIe2sgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w1qNfZPx; arc=none smtp.client-ip=95.215.58.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w1qNfZPx"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4whLlJ5HdZQmQogZNAqZXk4GU1IkwKwJWSrRgBfhUrc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790016265; v=1; x=1790621065;
 b=w1qNfZPxwwUUWhfwhnUMoSWUAe/xr4J6zMgZN0ZTB9JcYHdEJ5wOrsIeG7AYGJTcPiL6LBul
 C1Ymh/SrgJDqopLDS8xpfJyoX3Caye+0XNiYDXgq6R2LLHG7rLCBaZqQyP9rUdzcAO7dG6l/KTE
 gB3Y2gjSNZkHYnJoK6b2Y+EA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 581e5963eac9bec4;
	Mon, 21 Sep 2026 18:44:24 +0000
X-Mizu-Trace-ID: 581e5963eac9bec4
X-Migadu-Flow: FLOW_OUT
Message-ID: <2b813393-f754-4047-b792-6878adcaf3cb@linux.dev>
Date: Mon, 21 Sep 2026 11:44:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of
 bpf_reg_state->id [NFC]
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-2-vineet.gupta@linux.dev>
 <DLDKB6BTHVXE.PFK87O3QY1J5@gmail.com>
 <f575fe19-a5a0-4f43-b1bd-cdec2c6e9830@linux.dev>
 <6289e47f004b8b0d5ce55143fb1d55f7306856c0.camel@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <6289e47f004b8b0d5ce55143fb1d55f7306856c0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/18/26 4:13 PM, Eduard Zingerman wrote:
> On Mon, 2026-09-14 at 18:17 -0700, Vineet Gupta wrote:
>
> ...
>
>>>    static bool regs_exact(const struct bpf_reg_state *rold,
>>>                   const struct bpf_reg_state *rcur,
>>>                   struct bpf_idmap *idmap)
>>>    {
>>>        return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
>>>               check_ids(rold->id, rcur->id, idmap) &&
>>>               check_ids(rold->parent_id, rcur->parent_id, idmap);
>>>    }
>>> Also even after above change to check_scalar_ids() the check_scalar_ids() is still
>>> no equivalent to check_ids() that regs_exact() is doing.
>> ... Right: reverting back to what we had before.
>> FWIW Eduard had suggested to use regs_exact; I'm not sure if he had
>> something else in mind which we might be overlooking.
> I missed the check_scalar_ids() vs check_ids() difference, sorry.
> Also, yes, let's squash with patch #2.
>
> ...

Yep, will do.

Thx,
-Vineet
