Received: from mta0.migadu.com (out-130.mta0.migadu.com [91.218.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676F474246
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791138538; cv=none; b=LAJmq3oDI78AD1m7aDisT/Tt10Nrgr5teqV6wpz4dTzYtB8/Dom0haiK4pk/9XpEYURL840FcblpNPJGVPOeh0nH7eZjOEBOGSbvGXDwQtwzI6rIeDUH1d9CG4ydDBu8CVK4ONjIaLnigIiqIu2eyqor+SPPQ9qe7JtT3Vxt4XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791138538; c=relaxed/simple;
	bh=kkAQWjUJGnmwAIUiiUF5dx2QOJM4xnihqjaLQOSF4dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeljPIO4kyfNlhW30Iiqvoa4GZMFSppvdw4mmDOVecl3mrunpO2s8g6fWZKAt3thwt7mDg8brDRWsVkQGxJQ3i3IX80an3v84WbuPogfIgwISlaOjAfNNbrDf/F6WPPvqskn8TWxgv3OH212I3mZeZSXh1opTrjh7rasvou7/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EZdOJIzl; arc=none smtp.client-ip=91.218.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EZdOJIzl"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kkAQWjUJGnmwAIUiiUF5dx2QOJM4xnihqjaLQOSF4dc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791138534; v=1; x=1791743334;
 b=EZdOJIzlh/iv7u0uiIvEKESiTYGicHowcehRaZMWcfJDrYUIFvcPvneFacuBJP5hT3dNXC8I
 1Tw/x0QIyviFfAD4YI1sBJ4SyVevRW7JYy8zTV0OukyR3UD6kau9LvUiU6++OFfM6bpz5iJM5RR
 e3YI+ltHhfePym8zIxlAklz8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 94ccf02eea5fdae3;
	Sun, 04 Oct 2026 18:28:54 +0000
X-Mizu-Trace-ID: 94ccf02eea5fdae3
X-Migadu-Flow: FLOW_OUT
Message-ID: <2339982d-8b4d-4d25-8ae8-5c4ac920587c@linux.dev>
Date: Sun, 4 Oct 2026 20:28:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 11/22] bpf: Dispatch cleanup pads by rewriting
 return addresses
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133103.1340994-1-yonghong.song@linux.dev>
 <DLV7AATHIGX1.2HXVWUG223ANC@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLV7AATHIGX1.2HXVWUG223ANC@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/3/26 2:26 PM, Alexei Starovoitov wrote:
> On Thu, Oct 01, 2026 at 06:31 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> +	if (!bpf_prog_need_blind(prog)) {
>> +		ret = bpf_exc_attach_main_prog(env, prog);
>> +		if (ret)
>> +			return ERR_PTR(ret);
>>   		return bpf_int_jit_compile(env, prog);
>> +	}
> bpf-ci is right. The table of a prog without subprogs is never read.
> Drop bpf_exc_attach_main_prog() and these hunks.

Ok, will dropl

>
> [...]
>
>> +	rcu_read_lock();
>> +	prog = bpf_prog_ksym_find(ip);
>> +	rcu_read_unlock();
>> +	if (!prog)
>> +		return !ctx->cnt;
> fexit attached to a subprog in the chain stops the walk here.
>    main -> A -> trampoline -> B -> C
> C calls bpf_unwind(). The return into B is rewritten. The next ip is in
> the trampoline, bpf_prog_ksym_find() returns NULL and the returns into
> A and main stay as they were.
> B returns 0 through the trampoline to A at callsite + 1.
> The verifier didn't see that path, or removed it as dead code.

I will reject such a case (fexit, fmod_ret and fsession) as they
all have the same issue.

