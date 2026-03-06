Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E18338596
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772780982; cv=none; b=JZhkzM9ZGe+yNB0V5X05t9FaTQSPB7IUX5wLwRQl3gUuoxsCK+tO2cxXLfBmX0R7YkmvwyVoOeXP9Yfo65wAgzD6G9Vmowy71lfvE+yX/SPVVLnoEncfwEk3RVHR4rNEV89zgNrLPIAVmlE0juV0FUfSg7IdBSCveRoUY88Xpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772780982; c=relaxed/simple;
	bh=3c3G7gTbbGM2kdQY8pNt+pXgxMBGHMP8rpi+FETST+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9CX88+TerHL7WE6i11VDtm38n8jCrew43wkbfqwCXqfl2k815k138me7KWOetI5qHmp5i7F5AjnoGuwz/kWMMcJv8pyhbHTSU9NMcuiyOs9S4LfkPS+WfQlaMmAA6V+xQbBfUb5IqIN8gYjJhK9piYtjaOprUcYt+8XuLkUeRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hO+i5/Cm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E63uX+gV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hO+i5/Cm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E63uX+gV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772780980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IgTNYo5LwwKKhpVD5dWuFZsc1r6p28t/OSOOaSHgRzw=;
	b=hO+i5/CmClm3lteD6ydAbMeLCzduZYu6OEhHbliwWXT8Fbidk3tDR1KX+X+9fK+NWxw3Zu
	vmdz8zTdtW5x0RCt8OOZY3SwFUn50JZ9bBkQPVwHRQcHuBZmy4PtajsufuOIUTrJPnEc/q
	HUsRl+ewMn516dhyufhZMBatoo1xUUM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-hCRyCimkPpG2S06zzfmnFg-1; Fri, 06 Mar 2026 02:09:38 -0500
X-MC-Unique: hCRyCimkPpG2S06zzfmnFg-1
X-Mimecast-MFC-AGG-ID: hCRyCimkPpG2S06zzfmnFg_1772780978
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439ca6a7506so3296121f8f.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 23:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772780978; x=1773385778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgTNYo5LwwKKhpVD5dWuFZsc1r6p28t/OSOOaSHgRzw=;
        b=E63uX+gVDFvsJQDdqFk6CXcWTMs6xYufadlBtqnkvBw0vrNv7AMCEE2HKMnrzU7djy
         oRTGNt7z5w901f2fFKT0FbyYSfphNIN/UjiYR6U5YIIqzL+HaF+mlU3KAUsMwwyhkdGN
         PZ/CuAtkyzl8s5xdK8jLuuwdcm1t4C4VN2pYUbAjZLpiiSj0LRflkiSe0+K3O2neTwYk
         zSZ3fRn4Qe/pJaRG/1ce0A8LKU0tR+/UuWfUmyop/kdI1yunOPTQXlaIiugoclePlL3L
         to16vvgB0PHGyz3O/jIKNX4kYvrRbxB63wQgYSPfMNW3U97m8JDI8rOerVkFugCJ5lGN
         +6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772780978; x=1773385778;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgTNYo5LwwKKhpVD5dWuFZsc1r6p28t/OSOOaSHgRzw=;
        b=AYSZdNHfEC5e0DBcNZ/uFghtFe6ZDYpnjrrCHjwrjvpxaIVwTWSXM9buGkFawKy60W
         IzaiExz+oXOUXN/sbYal+HgV7JuJkuVuGcL5WHDqNFjtGsxqvTJI1ZgdfKUeGR/YPmSi
         F13oAC5FHsjA4vbXoqQ+jGoR1S0XN6u/d1WWMUxm2AQTZpA3SybIKob5JmZn93DVrN1t
         4iq3Ty+34Qs511ZYmP6K9FhtoOdh1evjmOM0meh7ttK3CIVfR268abWA9ciSs6kJkNr8
         pevtiQ7c9vY5AV/DoBUpxfe5eLjCysofrMTbjeVId0Gr0GxBWuQA4echnIZweCaV7mCJ
         UOIA==
X-Forwarded-Encrypted: i=1; AJvYcCVFyKAF6fIRnTwRyzM8OJgt2iyyazO4GFRiEDA6ygTq8whF3/YUO6VxFXriW9oCRlQYNL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPk23/8Tm7E2TVz8M00GwCr0D3WMUg6WBIIWrsPwEKbAttGexo
	QVaU9mDtUViHYT1Ku8FGGKmMiUxxWh3zME3NLDI5rgKEzxyHLxasuSo/R46exfivmfCGYU7hiie
	Wxu04cLfW74nkaWAoJ998xqPojrabeXXIIPIXkApt1NeShIYRUEbJ
X-Gm-Gg: ATEYQzxL9VU/HyUptZyC2GyqPgNtU2ISCRxtQom2SHVTHV8Da7MiAS2V7aCq3wRhfzu
	lmAcMSo27/xJ4poXOe57Gv8D8mSUApss/q4qZjDQMBLh/pK928nkE8md+zBE324dI2097Do5kTL
	MXX1EzisDNqNIBvesoC0156iGFFJCMQmSWhPlMYokTr962Vm9esAO8HB+MHRSxmW7j/OZ3BXoo9
	84Mh4lCODZLgV1BORz12vuTpvLER4FslqfHgAzFC1t++5dj0gCLlZtTkZG//Tn5Calw9v0n8CIE
	2wpC71xfpI1H6+Vtcq0yl9+fY6Xrk8QkgGSXHH3cp1WSkYGo871Jg0qk5t2pDUnu+ojfGuL/D4V
	zUtAWhfarRXVd7ctyrEFCpMiZMBdqgHpWpZVhyKVa9k7zI7o7N4nJUbZx
X-Received: by 2002:a5d:5d0f:0:b0:439:a95b:3c44 with SMTP id ffacd0b85a97d-439da8808f2mr1662449f8f.30.1772780977620;
        Thu, 05 Mar 2026 23:09:37 -0800 (PST)
X-Received: by 2002:a5d:5d0f:0:b0:439:a95b:3c44 with SMTP id ffacd0b85a97d-439da8808f2mr1662400f8f.30.1772780977141;
        Thu, 05 Mar 2026 23:09:37 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dadac2a7sm1863780f8f.15.2026.03.05.23.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 23:09:36 -0800 (PST)
Message-ID: <862423cd-ee96-478a-a13f-cd4ab5f4ba7a@redhat.com>
Date: Fri, 6 Mar 2026 08:09:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] bpf: Always allow sleepable programs on
 syscalls
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Shuah Khan <shuah@kernel.org>
References: <cover.1772721009.git.vmalik@redhat.com>
 <0715e86d7461c20d318594c770b6fa4c71f299c5.1772721009.git.vmalik@redhat.com>
 <69b41a54-fb91-4924-999a-06ba94edf72a@linux.dev>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <69b41a54-fb91-4924-999a-06ba94edf72a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 03:05, Leon Hwang wrote:
> On 5/3/26 23:25, Viktor Malik wrote:
>> Sleepable BPF programs can only be attached to selected functions. For
>> convenience, the error injection list was originally used, which
>> contains syscalls and several other functions.
>>
>> When error injection is disabled (CONFIG_FUNCTION_ERROR_INJECTION=n),
>> that list is empty and sleepable tracing programs are effectively
>> unavailable. In such a case, at least enable sleepable programs on
>> syscalls.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  kernel/bpf/verifier.c | 54 ++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 48 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d92cf2821657..cb80a3ddb7a4 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -24930,6 +24930,8 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
>>  	return -EINVAL;
>>  }
>>  
>> +#ifdef CONFIG_FUNCTION_ERROR_INJECTION
>> +
>>  /* list of non-sleepable functions that are otherwise on
>>   * ALLOW_ERROR_INJECTION list
>>   */
>> @@ -24951,6 +24953,51 @@ static int check_non_sleepable_error_inject(u32 btf_id)
>>  	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
>>  }
>>  
>> +static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
>> +{
>> +	/* fentry/fexit/fmod_ret progs can be sleepable if they are
>> +	 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
>> +	 */
>> +	if (!check_non_sleepable_error_inject(btf_id) &&
>> +	    within_error_injection_list(addr))
>> +		return 0;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +#else
>> +
>> +static bool has_arch_syscall_prefix(const char *func_name)
>> +{
>> +#if defined(__x86_64__)
>> +	return !strncmp(func_name, "__x64_", 6);
>> +#elif defined(__i386__)
>> +	return !strncmp(func_name, "__ia32_", 7);
>> +#elif defined(__s390x__)
>> +	return !strncmp(func_name, "__s390x_", 8);
>> +#elif defined(__aarch64__)
>> +	return !strncmp(func_name, "__arm64_", 8);
>> +#elif defined(__riscv)
>> +	return !strncmp(func_name, "__riscv_", 8);
>> +#elif defined(__powerpc__) || defined(__powerpc64__)
>> +	return !strncmp(func_name, "sys", 3);
>> +#else
>> +	return false;
>> +#endif
>> +}
> 
> At first glance, it is not a good taste to hard code these prefixes here.
> 
> Furthermore, the arch_syscall_match_sym_name() of ftrace does the same
> thing. Consider it instead.

I did consider it but arch_syscall_match_sym_name() matches two strings
(the arch-specific syscall function and the generic "sys_<name>") while
we need to just check the prefix (we don't have the other string).

Another generic option is to implement has_arch_syscall_prefix() in arch
code, next to arch_syscall_match_sym_name(). But that seems like too big
of a change in ftrace for a small use-case such as this one.

That's why I ended up with the current form. In addition, arches
hard-code the prefixes in their syscall code so we'll have to hard-code
them anyways, no matter the solution we end up with.

Viktor

> 
> Thanks,
> Leon
> 
>> +
>> +/* Without error injection, allow sleepable progs on syscalls. */
>> +
>> +static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
>> +{
>> +	if (has_arch_syscall_prefix(func_name))
>> +		return 0;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +#endif /* CONFIG_FUNCTION_ERROR_INJECTION */
>> +
>>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>>  			    const struct bpf_prog *prog,
>>  			    const struct bpf_prog *tgt_prog,
>> @@ -25230,12 +25277,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>  			ret = -EINVAL;
>>  			switch (prog->type) {
>>  			case BPF_PROG_TYPE_TRACING:
>> -
>> -				/* fentry/fexit/fmod_ret progs can be sleepable if they are
>> -				 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
>> -				 */
>> -				if (!check_non_sleepable_error_inject(btf_id) &&
>> -				    within_error_injection_list(addr))
>> +				if (!check_attach_sleepable(btf_id, addr, tname))
>>  					ret = 0;
>>  				/* fentry/fexit/fmod_ret progs can also be sleepable if they are
>>  				 * in the fmodret id set with the KF_SLEEPABLE flag.
> 

