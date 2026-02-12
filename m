Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B63EBF08
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770880962; cv=none; b=SSASLtKSidJm0tYgcAeKIYZfHSsnp7ou/ws2Jo1GP+Rg/mRtdnfyUwLUoWafnLV4AGrSoH51GBPAYxyRMYmxF4366bERaSduTy1fTcaqXpPFM3rz1BFW5du+ZprOLV+W00OZg8vQMwweqKCnF0wtBrKjYYbuVATP4yP8Iq6k5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770880962; c=relaxed/simple;
	bh=L5mWZ0JdTKTe/SgMNKduXYZHBsafgrBn4R9cnjMHc3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ak4R63Bb5FCShuhA7XdQpnVk5sEyAT4tN2lKF9/fB6g97gr+KxwpSQ8YyMqgSWxvCM4hL0N5VC5XE4VQ4JT6ZnPyE12RYZgaZM7RF6WDxBQwYzAkmPLuAJZg0Xg/7GNsKiQj6xOk3HwVF1htwtM4Bk+IHu87NSt6qxZR/rvc37Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d53R9dRF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThHy+q+c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d53R9dRF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThHy+q+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770880959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7gyUzNC2+dc/g3Vkcuxvq6MxJ/53EScAQOI3su9xhk=;
	b=d53R9dRFVfuoakMWlmBPnAPstSF4wdUpG2rq9Na6XTbCW5cP6867xee6t+vY3qCbmx0qGI
	W9Qw/ZocjX94O7KaDx+DnwWwWFrpj+WDRkgfNVbFa3G7lPLZnw9pD6q3B9hP8cOmsXLFKV
	CV2Bu27G+kifuUBlcOP6L1nFrVlKUqs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-7-ALcHhMN-mEsqhVVWdMSA-1; Thu, 12 Feb 2026 02:22:37 -0500
X-MC-Unique: 7-ALcHhMN-mEsqhVVWdMSA-1
X-Mimecast-MFC-AGG-ID: 7-ALcHhMN-mEsqhVVWdMSA_1770880956
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43637c70876so4059446f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 23:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770880956; x=1771485756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7gyUzNC2+dc/g3Vkcuxvq6MxJ/53EScAQOI3su9xhk=;
        b=ThHy+q+cuOIvi8SFaU8+KnNZ7QcKT81sbcQia58bjwzZOSlS0RMOXmkiSjD63NT1uf
         FXKm0Kb0F3h1JADqjwiCQG9guKqfMrAo2UNVw3j/ozjQ5XjLJi0Onl7AQ5Nwm+4LLGyg
         eeGuc/Zf60OVTdll9ro53xzHO9D7WcdtbpVpdSbUkK+ZFl9X2ZDm/P+RowWQ7qKfIpiQ
         Ong8WjhNSY2bd2GCxQrE4vmMln6I+f/cEmhQj2BQ8elV3o7K7qjAxl7V57EzffH1t0fZ
         4dxZegSdk4N9JxnwxOKUf2vb0+i21DorpfFtfs7+iZWG508NhRf86Ub3lO1ZAcGgJPRW
         AtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770880956; x=1771485756;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7gyUzNC2+dc/g3Vkcuxvq6MxJ/53EScAQOI3su9xhk=;
        b=YDq081FANesDJ2HB30quKYL1LEveEVfuNqvN/GxlYzCeLtkp3U469ZNW76SRYYLLyw
         f/lplqmvWdFnuqniLxeC5Uh083OTusc4JpxC6axCVyr+jG3VgtV4cUcjpGZ8u0889/Oo
         1mu9ngmGZ4RM3lesuQCFb+slPq+A2i7+AFQS7qYcJ+/g4eVjIUHMIQOYqZRO7Ri0CCGa
         xbR2r2b3JQDqEDGgciqjbsYgXmI70gDzclukvNd1EWwAWoyuRBaGq+YigxGJdn1W0tMt
         YFHGQ0w1mcbnNCM77itEZPIajS3dC5nQfoYkYa4hXT9YJli/8bUhr0OC50qLONiUPYVE
         G35w==
X-Gm-Message-State: AOJu0YwanjZwUWmIiZS2rprvg5hbgOx3VwHhQnts85YnyM7VvaQ27sdU
	8pvODNMFhk42pJnjPI4+xIEJkj8p/uf/AS4k7v0zjpvIv63/cThA1jStWROidlbdhZEQp8CLHpd
	BrWndUSDTGdJIetz6w6U4PleDAzQ3MoUz14hsYEIor96CY7aNkIYA
X-Gm-Gg: AZuq6aK8NRXZlOK0Wffa/Lz8/iKm/UXTq36tCArW35S3xCIziDm75G2qcyplSPuXtuV
	9RVRzg42N2FOonFOfxS3aeksT59tK5Hxcp7g0WF6AHrXj84hNeyhG3G9b9E4j+UM3aIICTJhwa8
	gZM/pCTPKVh5RMY7XAL/o79d/h29t56zUdWmDD30WwYKoRUOIAnHFg0fQnI6vvUtK7gukoxlhGc
	mvly8OjeyC0d2VUmLSmQ+IbiFkxSkZglT7TtuoFAnKsVS+J6MdWCdgcHgD/IqgiVH81U/JQ5vy0
	A9sxJOrKOFpajZgPbbmlAUwYo0NNhrduhBzNYfpEJhqfqUbF7z/wKx+q0WUN5k7V2ABrHIaiC8U
	DDDZ0pVBj
X-Received: by 2002:a5d:5f55:0:b0:437:7168:af52 with SMTP id ffacd0b85a97d-4378aa021c2mr3256436f8f.11.1770880956117;
        Wed, 11 Feb 2026 23:22:36 -0800 (PST)
X-Received: by 2002:a5d:5f55:0:b0:437:7168:af52 with SMTP id ffacd0b85a97d-4378aa021c2mr3256396f8f.11.1770880955683;
        Wed, 11 Feb 2026 23:22:35 -0800 (PST)
Received: from [10.43.17.26] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d36f86sm9349531f8f.7.2026.02.11.23.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 23:22:35 -0800 (PST)
Message-ID: <582944ed-ddd6-4843-ba36-b4aed03c5b2f@redhat.com>
Date: Thu, 12 Feb 2026 08:22:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/3] Separate tests that need error injection
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jordan Rome <linux@jordanrome.com>, Qais Yousef <qyousef@layalina.io>,
 Hou Tao <houtao1@huawei.com>
References: <cover.1770736390.git.vmalik@redhat.com>
 <CAADnVQLfV3PPYA8=EXDKwoQ925_W9HANf7gSn2=_fd42HD_FiA@mail.gmail.com>
 <d92e60ea-d590-4ce4-961f-4e8ce1cb0c42@redhat.com>
 <CAADnVQK6qP8izg+k9yV0vdcT-+=axtFQ2fKw7D-2Ei-V6WS5Dw@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQK6qP8izg+k9yV0vdcT-+=axtFQ2fKw7D-2Ei-V6WS5Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/12/26 02:42, Alexei Starovoitov wrote:
> On Wed, Feb 11, 2026 at 5:55 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 2/11/26 03:42, Alexei Starovoitov wrote:
>>> On Tue, Feb 10, 2026 at 7:14 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>>
>>>> Some enterprise kernels (such as RHEL) do not enable error injection via
>>>> BPF (CONFIG_FUNCTION_ERROR_INJECTION and CONFIG_BPF_KPROBE_OVERRIDE).
>>>> When running test_progs on such kernels, a lot of test cases fail since
>>>> they use sleepable fentry or fmod_ret program types which require error
>>>> injection to be enabled. While it is possible to skip these via custom
>>>> DENYLIST, some test_progs are not properly split into subtests and
>>>> therefore must be entirely skipped.
>>>
>>> Something is wrong.
>>> -SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>>> -int do_probe_read(void *ctx)
>>> +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
>>> +int probe_read(void *ctx)
>>>  {
>>>         char buf[8];
>>>
>>> @@ -37,19 +37,19 @@ int do_probe_read(void *ctx)
>>>         return 0;
>>>  }
>>>
>>> -SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
>>> -int do_copy_from_user(void *ctx)
>>> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
>>>
>>> sleepable should have nothing to do with CONFIG_FUNCTION_ERROR_INJECTION.
>>
>> I may be missing something but I think it is directly dependent, at
>> least for fentry.
>>
>> In bpf_check_attach_target (kernel/bpf/verifier.c), we have:
>>
>>     if (prog->sleepable) {
>>             ret = -EINVAL;
>>             switch (prog->type) {
>>             case BPF_PROG_TYPE_TRACING:
>>
>>                 /* fentry/fexit/fmod_ret progs can be sleepable if they are
>>                  * attached to ALLOW_ERROR_INJECTION and are not in denylist.
>>                  */
>>                 if (!check_non_sleepable_error_inject(btf_id) &&
>>                     within_error_injection_list(addr))
> 
> Oh. That's an annoying side effect of disabling error inject.
> fentry progs are not injecting any errors. They just use that
> list as allowlist of good attach points.
> Let's explicitly allow all syscalls here.

Ok, I'll post a patch.

> 
>>                     ret = 0;
>>                 /* fentry/fexit/fmod_ret progs can also be sleepable if they are
>>                  * in the fmodret id set with the KF_SLEEPABLE flag.
>>                  */
>>                 else {
>>                     u32 *flags = btf_kfunc_is_modify_return(btf, btf_id,
>>                                         prog);
>>
>>                     if (flags && (*flags & KF_SLEEPABLE))
>>                         ret = 0;
>>                 }
>>                 break;
>>             [...]
>>             }
>>             if (ret) {
>>                 module_put(mod);
>>                 bpf_log(log, "%s is not sleepable\n", tname);
>>                 return ret;
>>             }
>>     }
>>
>> If I read that correctly, fentry must be on the error injection list
>> (which is populated by functions marked with ALLOW_ERROR_INJECTION when
>> CONFIG_FUNCTION_ERROR_INJECTION=y) to be allowed as sleepable.
>>
>> The other branch for fmodret id set seems to be only relevant for
>> kernel modules which explicily register their functions into
>> BTF_KFUNC_HOOK_FMODRET set.
>>
>>> While CONFIG_BPF_KPROBE_OVERRIDE affects a single helper.
>>>
>>> Both fentry and fentry.s should work fine on sys_nanosleep.
>>> fmod_ret is also completely independent of these two flags.
>>
>> For fmod_ret, we have a very similar code:
>>
>>     } else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
>>             [...]
>>             ret = -EINVAL;
>>             if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
>>                 !check_attach_modify_return(addr, tname))
>>                 ret = 0;
>>             if (ret) {
>>                 module_put(mod);
>>                 bpf_log(log, "%s() is not modifiable\n", tname);
>>                 return ret;
>>             }
>>     }
>>
>> with
>>
>>     static int check_attach_modify_return(unsigned long addr, const char *func_name)
>>     {
>>         if (within_error_injection_list(addr) ||
>>             !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
> 
> Same thing here.
> Let's wrap within_error_injection_list() with bpf specific helper
> that in case of !CONFIG_FUNCTION_ERROR_INJECTION
> will allow syscalls anyway.

I would argue that fmod_ret should remain gated behind
CONFIG_ERROR_INJECTION. It's a similar concept to kprobe override - it
allows to override the execution of the original syscall and return a
custom error code.

> 
>> My question is: are sleepable and fmod_ret functions supposed to work
>> without error injection turned on?
> 
> Yes. since they're not injecting errors.
> 

