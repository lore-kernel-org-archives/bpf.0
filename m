Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795832186;
	b=IUGXYL9CwUf3MZ4zq+GLHZaQ+SJqWITIBakCuJZ22YdNTwCVii7PtD2/Ao7NjmqzOqbU
	 OIN0btcChVWo9eVwzkYAsCDcjzagO9YL8YN/biSc2fTA3D8XlDIpSsOk93DsNQdKoAk19
	 j/+em6R1I/5zOzKOqRi/a1gbHgfgE1Pq6rJo7shGtBK5TotApsVZJrn9KlWSiXXKorsH9
	 45b41vea1jEQ3OSskaGcUZb00WULD5X8U/imHcOT8Mrw/hCA6gLvw2kJJlZ4Ujow5UPAg
	 aEFGyJzRn46TMJx0yy0VdiW8JfoFIDhFmFBGJyRVW7S/YPlzyriUqoXpoKki55oqBfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795832186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=v+AxhUWo7ZwVXmdndnrjQUEctBiASldH/hTh0wDhZIU=;
	b=qAG7NwRae6PaWHOTmQTliHKdPcm7i9WfCDemSHHHkXo79fTlWdJstkb/ChrNklH9+GIs
	 5JvlBBf7KqmcCU3VcUesHcOhkhZf38lWODjjQcB72JK7kiCiwm5NjsrnriUbB4yqT+aN6
	 odEZEBNTpvo9ScRZkLqmEx12fu7dIj1jo/OzvImkKA/bNMwkXAw04goQe0kd4pI2fAtp3
	 2nkHvTB6xGHRRb/SPF+tej1WnpcM6aa+WPM7dTB/9dL1vnWM8+n8LrsDhyfJrgUipxtUd
	 BqCkHWiuH2BXfjk5ZIIAg2E9iBldC77CEbJDys3f+YzIWHMSrYkw3UIKTIhocCLcWjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jfLKUxRx;
	arc=none smtp.remote-ip=74.125.231.74
Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC50606A696
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 02:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFC50606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jfLKUxRx
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-4ae5a7c2df9so6202964fac.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 18:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795832185; x=1796436985; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v+AxhUWo7ZwVXmdndnrjQUEctBiASldH/hTh0wDhZIU=;
        b=jfLKUxRxzVjznTzOjzTi27sB88YII7kx9GiZRaDra65sYcrOprif6zZubhcJznjfBx
         iZ9299XcQ2SK0u4xsPfq31/wpFVKoltXwrRVRuJNkAGF5tnDajRBZK34PVMU9xC7LdXZ
         we3HuB3wiZdmNZJTEKUgblZ3ImL+JYWgObPDMNkB3ZgE+4sB/DHMX0v27dJNqIz281gW
         dUVbeElPoFNJJagEzfyzTCZq1gmSxXpmlsgEDIGNGoRacmxQ+FNUyXRWVgGvlEOo7S7I
         urBoihgWQ8gq36vOUZ/XgWHkkh2J8xo1Pr59qSzZen5PV4REf38XLBvylLZFr1Bp0xgr
         joBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795832185; x=1796436985;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v+AxhUWo7ZwVXmdndnrjQUEctBiASldH/hTh0wDhZIU=;
        b=BzTxd9jlCtoGpj7wIi5ek5OnFFvn1KrthiuDu6a98ou1cIot2KdWhYT/aVQymNSX0B
         pjKGXTyWmj8wyTvBQiiPar4Gv5QXAUcI8lyZN7KCsQWC3Rs/XbS3cvXhLzenoo2ffKrH
         OVVDdaPGFkjB/YPOjOeziQtOc66U6qLCGOE8kuRehoEq7lmTAIY4WGMHYksfC7WZDbpw
         tg6RZM1FEI3PtBIo/smI7uFVjG6vZPsfoDjYFsaW6rtOR49NtO+j1CHIKSdvEzSpVwSt
         xsvV6/30L5lNW/aJyWwK1Ndhnhfo5IQnjg/nuNXqt225pn4wATOxCcMDP3NS6jh3/Zvz
         NwDg==
X-Forwarded-Encrypted: i=1; AL+hErE8fso8AZ/5TwJkarvhoD1hZq1jvkM7/HM2Mgv3N4opKntan1sRE7+7LW9ZE5fradgRwNI=@vger.kernel.org
X-Gm-Message-State: APuU4Z84h4JUxSeXVRPsii0lUvZFjo+vTj+RCytDUer6KGZ2L+m6VaD0
	+2p7Xa9BcmHcVjIlbGgZU8nqELPdirBEGNlCtSfUX5G5tpne9gBHTJPgYA5UQHupikE=
X-Gm-Gg: AZFdTZcDmf9oRgcF7ZZeFl7r8vgApAkrbYY6oCTJ7eNmppex8EIpr2O7QmP/uSu9LIF
	OIZjsdJQOVK6A19I2ZgquEdD+xz9f+Va+twj346Phwn93FnTibYOUQno6nRPiVtObSidpNRpKem
	3BjwpHgrt/yWnmoFDP8uX9Z0egpX2DcJuoJFXpQ3wO1YMPYaS86osAIf6SLvJEU38nwwV0VaGQC
	LHHhp1yKnJOkT4ihxK5ZWOqzPsTIC3VFyOqkXIFM9LiESq2X9V3VH/vqgGzafx6d5pbZ87/vFIr
	Rx73OMatw5YNtrDX8IwcymSfVfDJSY0LYxkIwIf6/6k/v4CHod7Spyet+sc98LQDR9t6mi4yNLS
	9KtOQJuZmxgtCH8z+N7YP2xlSVj5o58OJQaNbkKcOQ4YrUJ0euc3ZFiggvSS7SU0dsjbcgY1z8+
	jG9k2as9K9puV4DPMzTzmHUBIopM7jv1CROC07U/EBzMXwWuylpgeRHYYDt2IxNX36AWDOta6TK
	T/s7nQ6M+J4P4g1K3iCsVTQiml6vaaeosBPr0MJSPvAa0ny1Z/fZRcC9TVmOW9txeWO7gyh0uR0
	NW1ZcOl6up7yZz+i2580bVigpCyA1y6+Jlh8xIFaYvTltOhRSKaSj6iLhCjlpHEDBZbNC1p4+7b
	0pAcOLP+oY5mbTg0bRWowUEOEJCRarONyV+oH
X-Received: by 2002:a05:6870:41d4:b0:4ad:852b:333 with SMTP id 586e51a60fabf-4bc8307d56fmr25048990fac.50.1795832184572;
        Fri, 27 Nov 2026 18:16:24 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc61081159sm22936697fac.15.2026.11.27.18.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 18:16:23 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 03:16:21 +0100
Message-Id: <DN6HDN2N87GO.C2NVM588C2DP@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] x86/mm: Resolve BPF exception fixups
 for user address faults under SMAP
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <cover.1795829324.git.memxor@gmail.com>
 <0a30eeab6bea7ddfc0202d1970ab1b7f3a4d580c.1795829324.git.memxor@gmail.com>
 <sashiko-outbox-238412@kernel.org>
In-Reply-To: <sashiko-outbox-238412@kernel.org>

On Sat Nov 28, 2026 at 2:46 AM CET, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] x86/mm: SMAP does not fault on supervisor mappings below
>   TASK_SIZE_MAX
> --
>
> commit 9b387754d627ac256ae9705ce7d6a4e7a2935051
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> x86/mm: Resolve BPF exception fixups for user address faults under SMAP
>
> This commit resolves EX_TYPE_BPF exception table entries on kernel-mode r=
ead
> faults in do_user_addr_fault() under SMAP, allowing the x86 BPF JIT to om=
it
> its software range check before PROBE_MEM loads.
>
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index aa88370ce7394..9fe8705eff043 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -1263,7 +1263,16 @@ void do_user_addr_fault(struct pt_regs *regs,
>>  		     !(error_code & X86_PF_USER) &&
>>  		     !(regs->flags & X86_EFLAGS_AC))) {
>>  		/*
>> -		 * No extable entry here.  This was a kernel access to an
>> +		 * The CPU refused the access. If the BPF JIT marked this load
>> +		 * as one that may fault, skip it and zero the destination.
>> +		 */
>> +		if (!user_mode(regs) && !(error_code & X86_PF_WRITE) &&
>> +		    ex_get_fixup_type(regs->ip) =3D=3D EX_TYPE_BPF &&
>> +		    fixup_exception(regs, X86_TRAP_PF, error_code, address))
>> +			return;
>
> [Severity: Medium]
> Can relying on SMAP to refuse PROBE_MEM loads below TASK_SIZE_MAX allow r=
eads
> from supervisor mappings in the low address range when a temporary mm suc=
h as
> efi_mm is active in CR3?
>

Which is fine, the read just goes through in that case. Bot is confused abo=
ut
the semantics of the feature.

> [...]
