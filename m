Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCAD3AB5DA
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668690; cv=none; b=SPnWG1yco4Y0WXvP8H0uWEAs4Zxt7XhruYHgjiRw2ZmCbIh2f3gcTNZaP2ZzgDgPvBdz4hix+63Eh7r+9jZQd1gl7qK4xWgfVIkV6Ak5rnbqoaw9/bGNCYdB4icAjmPnXlrDa8wIxUPmfv79MIcGgrnRpQwMCBjGfLFgPh/n2m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668690; c=relaxed/simple;
	bh=Wkv+s85rwWZ5piXWqHMeQMXYcmTUnZn0alyy8atYvgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwnMSeHtvv+lHiQbomf43CcTpOjuN/+Js04iJyVyuo/xF9LawDHlVGDqYqLyAHPBrkeQTwzX8zt2WWXSXs12bneWElQEyZeFABNtTTyc++BOb+JRJEnv8CZ2UDBgnRYQ3HCsqs+M3CCNQ72FhLt1L7doIibeib4fDlOu9na2Xnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzsAIqJl; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzsAIqJl"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso3095224f8f.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790668687; x=1791273487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yoLBw0IOCugG7zrnD8JOCvM/hkOUx7LAFNAqI5HNZok=;
        b=CzsAIqJlp0AePPzf1PBLfZZ1L8BZFXtVsAJgL7Clu7txr7N2cuYoj0VeK0rgIrU3bu
         sONaDciKGfXMKvzFDqYQRNb7HPoGt5vrrfTTR0JO5cU7Nw7UPCz4Qu1deGitjY3l9r68
         /bMLU4qGKS8LzpYAcTJ/A183+K+NS03fhA7A3BpCItoC3XDeqjhCHYRkNdaVfQI5pBiD
         ba7jged85i/o2Fqi5CVvMOLAjNeVY16qOjWkjSiQiEVKOZsdB4/AOueGG9D4WYETNpsf
         m/U7ut7QWbd7EevvRpHefNCinr81vqEHDazptR6kZW0jrumHrhs/nxZOO2T8/GF3OrBb
         /x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790668687; x=1791273487;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yoLBw0IOCugG7zrnD8JOCvM/hkOUx7LAFNAqI5HNZok=;
        b=i5SVFSyMZWCy9uxdxXSkQENaQ+UWIxLfqd9Tx2uXYIrepOLTyDTnFedY6tBvgosc00
         YRopNXuJRJusa/Qz5FByAfbAHVEGCQns1tRy3h8bImeabbm0UY3th+9InVoxvdNXHABq
         Hl4lLWfVpdrerlPNw8G7GvOmTK6TXWQMSbZxKPnGGu0NksxS8CIXNwaCwrriftE80QCU
         wSTIFzxdsZQH6P8h2ls0hGkktb1F4Y7HqPA73Uj/6H/r68uOrfjIUqRXK/4LxDInnS1y
         Llbk8TVAPfk10rP7OGC5pEiLLe+lrHEPnHass5LcslKuh4aSz980UPFjF87w4HkkrOaH
         eBHQ==
X-Forwarded-Encrypted: i=1; AKwUvBw10uhLb64fVxFn9YzEnjjvynzkDWiOswgwZ+JeprHNMye8KfHlAp9zez+NnTYL5zJzvGs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhoSSh9gjCrR+2BVggkcLxf4tivvF5rGNucLBHlTHpzzVlHKm1
	nDdtF0eeCLMEp7R4Xe8gdbLIrRMm6Frj4Lu762LEaZLCDVYsnjuWOlhl
X-Gm-Gg: AYBFou1HMyFTLdVaH44V7CkOVMP3lQVHJP1MNJLkIVat8xsllgV7bbeFQASHPmv8XxZ
	jozrwASlh9XBT+CY93VUyQaUTVjl8ypxo/9QdyJKrnplckS1Oc5vX4nfwdNTecj/MAK7c8o1hmR
	QXmO3QKzaOKaaGm5kvhykh0ZNHOezFvVRheKowJlGlsIaeTMa5+N/B9JrNnvgFmc+XeG4T71EvM
	fo7/HGLX7JW6U1M3hbX083l0Z1X/Uhkylnxghp3tC683j86QD9ipidjk0h12S39/HkqkU+Pr3n/
	HsSEGvTTC367nP/QiRKc+WgqrddYlFAY5b2DUXnSdXybp0MraUHS9bl19G+Uyk7gQuZRlM9WIxC
	qzTdlTTLNMpyk1stAdHci6HolwdMT95e/BDZeRZrZ1eUYNG0zYX8FgaHwq/7dabm7Jq9kqJto/y
	egrEccuBWeeiKFSUckhTNopuFYgUjGd32J3p5gr5+GOIh2DXq4Pkt6poNSHf1O6hiXyk9PUWyXi
	za+hr5I
X-Received: by 2002:a5d:5f45:0:b0:487:aff:9952 with SMTP id ffacd0b85a97d-48872a714b8mr26780551f8f.16.1790668687183;
        Tue, 29 Sep 2026 00:58:07 -0700 (PDT)
Received: from [192.168.18.21] ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af5056b1bsm2025044f8f.17.2026.09.29.00.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 00:58:06 -0700 (PDT)
Message-ID: <96c2224e-e4cc-4d84-b92c-9c09022ea489@gmail.com>
Date: Tue, 29 Sep 2026 10:58:04 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Zero-fill non-target CPU slots on BPF_F_CPU
 insert of new per-CPU element
To: Leon Hwang <leon.hwang@linux.dev>, ast@kernel.org, daniel@iogearbox.net
Cc: andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928214932.544124-1-omermetekaya0@gmail.com>
 <8fce9ea9-1947-4ec4-9154-cb71fbd75671@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
In-Reply-To: <8fce9ea9-1947-4ec4-9154-cb71fbd75671@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/29/26 08:04, Leon Hwang wrote:
> On 29/9/26 05:47, Ömer Mete Kaya wrote:
>> pcpu_copy_value() with BPF_F_CPU copies the value only to the target
>> CPU's slot and returns immediately, leaving all other CPUs untouched.
>> When inserting a *new* element, the backing per-CPU area may be reused
>> from bpf_mem_cache or a prealloc freelist without being zero-initialized,
>> so non-target CPUs retain stale contents of a previously-deleted
>> element in the same map — a same-map information disclosure.
>>
>> pcpu_init_value() is used to initialize newly allocated elements, while
>> updates to existing elements call pcpu_copy_value() directly; non-target
>> CPU slots intentionally retain their previous values there.
>>
>> The onallcpus=false path in pcpu_init_value() already handles new
>> element initialization correctly by explicitly zeroing non-current CPUs:
>>
>>   if (cpu == current_cpu)
>>       copy_map_value(..., value);
>>   else
>>       zero_map_value(...);
>>
>> Fix by adding a zero-fill pass in pcpu_init_value() after
>> pcpu_copy_value() returns, covering only the BPF_F_CPU new-element
>> path: iterate all CPUs and zero-fill every slot except the target.
>> This leaves pcpu_copy_value() unchanged so the update-existing-element
>> semantics are not affected.
>>
>> Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps")
>> Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
>> ---
>> Tested with a reproducer:
>> - Before the fix: CPU 1 retained 0xDEADBEEFCAFEBABE from the deleted
>>   element.
>> - After the fix: the non-target CPU read back zero.
> 
> Could you add a selftest to prove the issue?
> 
> You said a reproducer. But, I don't know what it looks like.
> 
>>
>>  kernel/bpf/hashtab.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 8cc07e54daaa..dff4321f2828 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -1099,6 +1099,16 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
>>  		}
>>  	} else {
>>  		pcpu_copy_value(htab, pptr, value, onallcpus, map_flags);
>> +		if (map_flags & BPF_F_CPU) {
>> +			int target = map_flags >> 32;
>> +			int cpu;
>> +
>> +			for_each_possible_cpu(cpu) {
> 
> But wait, the 'map_flags & BPF_F_CPU' has been check in the first 'if
> ()' condition in pcpu_init_value(). See the previous fix:
> https://lore.kernel.org/bpf/20260924102321.2120434-1-donggeunyoo.kernel@gmail.com/
Ah yes didn't see his fix, and it looks much cleaner.I think mine is no
longer necessary.

Thanks,
Ömer
