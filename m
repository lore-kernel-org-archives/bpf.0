Received: from mta0.migadu.com (out-132.mta0.migadu.com [91.218.175.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82463B6BEE
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791138545; cv=none; b=uX8RRO/1xt5+IhT90nZYPO2LFrfu5ZTEFHeIAqHWCCD6KGja0ues+94aNOMeoRLzr7r+ItZ8h/I7tkKZqFu1snrBXVx+d7Uu79dSf9E4cq3A/3djDCdTt51sA/rpt8ZaNEYws1iQG8bdWhcnKT5XJ54iHmMw5VKG8oC8I3TjM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791138545; c=relaxed/simple;
	bh=/JJfxoccTSO/IWSwNFaAtt3wQ+uA3EvndcTwI0nvFEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DS/KwKL0rXdpYbXQR2uk3dWmMaU1iRkRvSv2W/GRGEFgPXHZ5/ZKIvlxTTJvztvMxZYJI6kKRUgYwBkiQBSLrwn5gxd235G/he8gkt1f7tASsLmEacgxnLMvBGKRFR1FrjcOCN9VER//8YMVkyl+JiLzlJYbzQxgGYtEoZzA+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mch8taTy; arc=none smtp.client-ip=91.218.175.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mch8taTy"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/JJfxoccTSO/IWSwNFaAtt3wQ+uA3EvndcTwI0nvFEQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791138541; v=1; x=1791743341;
 b=Mch8taTyebKGmYZZPXWfNRakxzQlp7rTHHsz6IsHRx5Rrokt5Urj/14Wpjq6PKDdNyDDQOh2
 bheMQwfpC44gDKSQ9TT7ETHc2utqQXv05wZg8dh72IbbSGaX41yLfXxptQ9dlwKwHNfxe1i2hQc
 rX2X8ZpC5IqFz1njbJZU/Bac=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 13b7940f81eed236;
	Sun, 04 Oct 2026 18:29:01 +0000
X-Mizu-Trace-ID: 13b7940f81eed236
X-Migadu-Flow: FLOW_OUT
Message-ID: <4d1009ce-c031-4abd-95cd-38d6e847a71d@linux.dev>
Date: Sun, 4 Oct 2026 20:29:00 +0200
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

Ok, will drop.

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

