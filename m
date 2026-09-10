Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2DA4AA031
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055621; cv=none; b=sTWBvoTKtJ3R6BJUZNKWdWR2jTRs5EsNUdUDxzqhzk1xecDzM0ttf7TQ5xiMEo81Bm9vb64SJlzgtjDTnc3W6kua9AVQ+bBmFEAg9pfxLn8B18zdSunpFdn0yTFYVCxh2NhGq/az8FKLqhKrRaJkyjBEiW9zypcHcSJ5nVe23oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055621; c=relaxed/simple;
	bh=4aaIq6KvNTg3QGAdWis/Bsx3wM5V85x896JhKURjmfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cce8xN1aq4juI2Nicud1AN173wrut7IK4rYwo2rXt64Zg8D8gJtW4xoRPMGgJdBcNHqPmQQXUKru6XDcU3+SGKmLqg+660tkeX8/1ACL1mcKKiTjqPNaNcMsCHqDh/GAu06cfYSElKmxgruXBoX6GJifVakna3gemegyTtPy4KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=CAFRLLmT; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CAFRLLmT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VwxdGBYPRSR9gi5t2PK3Me5/yk+1N7Qkc/0i7ma3OSI=; b=CAFRLLmTZ8Jknh6rFdUybx1K+7
	RHw9jWIpodInRZkttePP8pXj6I9RTceKBX+7tcOQ+2/d6nVHGWR+4VtaKGY38xd9AYFqK9HYNmdux
	Nj9fuKwmWmcsYhLLf1nLyAT6ZjSlNxE/WWMuTsWu0pBI1f/hmrGCQ1FZvc9x0vvkkmbrVEEVvJ6UM
	3RE4DsjvljTTKLXJV6kZGQmuroK3bEeXrEL2XpJ65x2FxxR8hQvO+xql2QTlcHc7uk8AAa3Ve8GFt
	IWjA1INY+ln2ngqDEGU0KbNqQSAbxjC3F3JrtOA784NGkfXZohYNc9fsEzbHdCENJRBHtNtMCl3ZX
	xxGNqy5w==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4h5k-00094S-2I;
	Thu, 10 Sep 2026 17:53:36 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4h5k-000Jkd-0L;
	Thu, 10 Sep 2026 17:53:36 +0200
Message-ID: <7598df39-e4b3-434c-b4ff-67efb8b6d8e9@iogearbox.net>
Date: Thu, 10 Sep 2026 17:53:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 2/4] bpf: Require CAP_PERFMON for kfuncs reading
 memory
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org
Cc: memxor@gmail.com, eddyz87@gmail.com, info@starlabs.sg, bpf@vger.kernel.org
References: <20260910142107.40582-1-daniel@iogearbox.net>
 <20260910142107.40582-2-daniel@iogearbox.net>
 <DLBR1FDW787I.2PNNYKF8PP4MY@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <DLBR1FDW787I.2PNNYKF8PP4MY@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28119/Thu Sep 10 08:24:09 2026)

On 9/10/26 5:41 PM, Alexei Starovoitov wrote:
> On Thu Sep 10, 2026 at 7:21 AM PDT, Daniel Borkmann wrote:
>> Mark fault-safe probe reading kfuncs as KF_PERFMON, similarly as we do for
>> the old-style BPF helper equivalents. bpf_rdonly_cast() is included in this
>> list as well as it returns PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED for an
>> unchecked object and is using fault-safe BPF_PROBE_MEM.
>>
>> Note that only the void form of bpf_rdonly_cast() produced a register that
>> was readable without CAP_PERFMON. For a struct type id the kfunc returns
>> PTR_TO_BTF_ID | PTR_UNTRUSTED, whose dereference has always been gated in
>> check_ptr_to_btf_access(). The flag is not conditional on the type id, so
>> for the latter it only moves the rejection from the dereference to the call
>> itself, which is the better place to report it anyway.
>>
>> The bpf_stream_vprintk() and bpf_stream_print_stack() kfuncs are marked
>> as well. The former ends up in the same bpf_bprintf_prepare() as the
>> bpf_snprintf() helper, where %pks, %pus and %pI4 read through a program-
>> supplied address and %pB resolves one into a symbol. The latter walks the
>> stack and prints each instruction pointer via %pS.
>>
>> Fixes: 4665415975b0 ("bpf: Add bits iterator")
>> Fixes: 65ab5ac4df01 ("bpf: Add bpf_copy_from_user_str kfunc")
>> Fixes: f0f8a5b58f78 ("bpf: Add bpf_copy_from_user_task_str() kfunc")
>> Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
>> Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
>> Fixes: e91370550f1f ("bpf: Add kfuncs for read-only string operations")
>> Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
>> Fixes: 19559e844184 ("bpf: add bpf_strcasecmp kfunc")
>> Fixes: b5b693f73589 ("bpf: add bpf_strcasestr,bpf_strncasestr kfuncs")
>> Fixes: 1dc669646762 ("bpf: add bpf_strncasecmp kfunc")
>> Fixes: 63328bb23f26 ("bpf: Add bpf_stream_print_stack stack dumping kfunc")
> 
> Let's drop this Fixes list altogether, since it will only cause
> headaches to stable folks. We don't need to backport this everywhere.
> Not really an issue.
> CAP_BPF alone can leak memory via HW speculation,
> so this patch isn't strictly necessary, but I don't mind closing the hole
> since AI keeps reporting it.
> 
> Also pls add bpf_get_kmem_cache() as AI suggested.

Ack, will address and also the one from your other email.

Thanks,
Daniel
