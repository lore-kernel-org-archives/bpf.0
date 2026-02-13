Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747234C830
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770974523; cv=none; b=PoSbcXZEXYq7Bx4kwpuRkAT4DUkaEWjXyoWvHrnmzVwByNSW1vAx+zPxKt8e31n/uHAKYMhtFLiL4pXUiFkE+9z4pUQGnLgES52oFc9MkP1f6R4fh8P2MTeVI5PHvpa4tu3GpXB5eW7dy35TP8BVSXsESqClXxLECC69T//v2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770974523; c=relaxed/simple;
	bh=DNcTZj4Gbp2yQ2ZU8mY1+rIzsmWpjJNNLEBAqbx5Ut0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRaadQjmEDl66TRvmsXN5kX4zvhLWgflDWq+vF7qaa210AZnJNoWXPgWzPSG73Jm6ZDrJd8Fw3TkW+eOFg22G8C0JBM/QezsLCL6sBytPsJlYmd3XBnwyQH/yCwE6J43GwKNXa8YdLWj0ErNUyc0B2x1nbvuWVDI8y/pJ+OkWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSZHcE8/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlaJ+Fa5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSZHcE8/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlaJ+Fa5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770974520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lat9jxcpi5v3pQYzHUgq6dAsI2dlXvBskwFQsBx5We8=;
	b=ZSZHcE8/2Wtam/+OWLgG5EW46JYimlCSd871OOTZasM0CYh8LTVYz1ZWxn/6VrAQcE+365
	fQOUbrICVdnGnzMx/+7HnEejnDGQoOU7Hzcwk71ZMA+OWRmnddpT1gt8UVwFLCv+cS06LH
	TURq+4xkeHlKCBYXHciJS9ywWDsyw3c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-ltwbhvpdNg6ZrnR0h8KaHA-1; Fri, 13 Feb 2026 04:21:59 -0500
X-MC-Unique: ltwbhvpdNg6ZrnR0h8KaHA-1
X-Mimecast-MFC-AGG-ID: ltwbhvpdNg6ZrnR0h8KaHA_1770974518
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-435ab907109so527110f8f.3
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 01:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770974518; x=1771579318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lat9jxcpi5v3pQYzHUgq6dAsI2dlXvBskwFQsBx5We8=;
        b=NlaJ+Fa5hLXaHRM0IcwuzGrGbcn3rtGVnIsoX+jedkDGyRICmRmHXR/mcoD6vCTGfd
         VKfShPAfl21YbpiBwqENaxtMQNjIM2nqE51sCh4Yc68QtpqvmMiruvyGOFs6a3QzhbAc
         AkG3VQRQX+VCaMKrgA4kesI1hQIsIxRdxODTdEsQLhtHlHTbO4eL2B98a9ESfiq0BHqp
         fWdnPm9EemymqNPx33uZAIOjkZJDKoNgRlt4LqiHxCqNJgQvLPbmZz4/iHwnBf9k7byd
         SQYvVn8OhTlzHv5HMarhq/VdIkGlZ9XcaoW7YlY+pOJJL2HUfmSLexJRP3THQDAJEVj6
         X8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770974518; x=1771579318;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lat9jxcpi5v3pQYzHUgq6dAsI2dlXvBskwFQsBx5We8=;
        b=ScFsj12YtES2iDBaSTHUlElwSam49X4tCwoJZ64vTYmNZ3IgLsijq6uUPQsPSSBgim
         AJZlFLJ9AZ6DcEk0H/0MTzdEwfYiFxkuAhZCp9CcSzQXgW02SZc5NyBYB0mrCB+4yuCS
         yz+nl2l9o6YeHYGQ4pXS7DfEknXyKaWiPg8rrAwXITATLIvkjcdnyWKR9mQpALT/Ovsk
         FHmVkiHj+V+9ALzbRqXdnm3wgg3CMxE6eS1DyJgna3/o4Ykeu19e6im/Sj027TjluWNT
         aip12H1+Tt5yUQtsi2xMw63RUamr/xsvKphVC12niX3YgLAprOE+LBTav/fR405PdHXH
         K8eQ==
X-Gm-Message-State: AOJu0YyqWPh+5iuOWbiRz5+sM2d4ylDvzXlD5vuwVYAXtcvdrmorG/f6
	kXxlN8fAyeGxFDkS5e+2n6WqpX9R03sqivOzN90I57LlO5mUiDAFHbZCn5jpoX0shqgQswdvPJ6
	lD7EWNnMhN5MSZPm18twMd54DS+/cR8mPySuF7/yqv31x3UfQ/bu0
X-Gm-Gg: AZuq6aIX+5j/2xkW87xKEl+MaaPabSeMvN0XGp493VARWxTyk97VKcmW4pmHBjDo1r7
	QntnrVtbXCwcq1fhVv/EBTfdqpN+bWv49b/mY2Xx427/bW4S0v35cDs/2R7e05It06DcNbXOPgq
	qwHLaBl6/6WAZKjrgeBBVuQktIXqmfi3EIbqcogQ3yLA1ObbIm9LGS2/rQsATckYs7AhiIkR1bQ
	xpeklQZsqVsUT+9mxRF3fbMo4zVqkreoIEvgwWtrSSriU21DWWTzhYsNrMWuQ44xLyXEwXRFsL1
	uXLRzBkFgkpA8psQGskjLEQwQ1nEM3E80FlsisbZF1rMLK8CdarUdUnL7eDcblV5QbBwEsKD01b
	Y/daT6OUnQMMHdhGCr85c6+K1OvE/fAWhqb6lik86oa1hMuvfiBtPOIm/
X-Received: by 2002:a05:6000:2083:b0:437:712a:fac9 with SMTP id ffacd0b85a97d-437978cf216mr2239374f8f.23.1770974517614;
        Fri, 13 Feb 2026 01:21:57 -0800 (PST)
X-Received: by 2002:a05:6000:2083:b0:437:712a:fac9 with SMTP id ffacd0b85a97d-437978cf216mr2239294f8f.23.1770974516975;
        Fri, 13 Feb 2026 01:21:56 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6a5f0sm4204928f8f.11.2026.02.13.01.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 01:21:56 -0800 (PST)
Message-ID: <d2706604-1674-49fd-a150-7ace8839657f@redhat.com>
Date: Fri, 13 Feb 2026 10:21:54 +0100
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
 <582944ed-ddd6-4843-ba36-b4aed03c5b2f@redhat.com>
 <CAADnVQJ4PU7bCb5XO9+zMZhLRSdbCKwxG6Rtojh2Rc3UZ8H43Q@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQJ4PU7bCb5XO9+zMZhLRSdbCKwxG6Rtojh2Rc3UZ8H43Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/12/26 17:35, Alexei Starovoitov wrote:
> On Wed, Feb 11, 2026 at 11:22 PM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 2/12/26 02:42, Alexei Starovoitov wrote:
>>> On Wed, Feb 11, 2026 at 5:55 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>>
>>>> On 2/11/26 03:42, Alexei Starovoitov wrote:
>>>>> On Tue, Feb 10, 2026 at 7:14 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>>>>
>>>>>> Some enterprise kernels (such as RHEL) do not enable error injection via
>>>>>> BPF (CONFIG_FUNCTION_ERROR_INJECTION and CONFIG_BPF_KPROBE_OVERRIDE).
>>>>>> When running test_progs on such kernels, a lot of test cases fail since
>>>>>> they use sleepable fentry or fmod_ret program types which require error
>>>>>> injection to be enabled. While it is possible to skip these via custom
>>>>>> DENYLIST, some test_progs are not properly split into subtests and
>>>>>> therefore must be entirely skipped.
>>>>>
>>>>> Something is wrong.
>>>>> -SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>>>>> -int do_probe_read(void *ctx)
>>>>> +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
>>>>> +int probe_read(void *ctx)
>>>>>  {
>>>>>         char buf[8];
>>>>>
>>>>> @@ -37,19 +37,19 @@ int do_probe_read(void *ctx)
>>>>>         return 0;
>>>>>  }
>>>>>
>>>>> -SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
>>>>> -int do_copy_from_user(void *ctx)
>>>>> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
>>>>>
>>>>> sleepable should have nothing to do with CONFIG_FUNCTION_ERROR_INJECTION.
>>>>
>>>> I may be missing something but I think it is directly dependent, at
>>>> least for fentry.
>>>>
>>>> In bpf_check_attach_target (kernel/bpf/verifier.c), we have:
>>>>
>>>>     if (prog->sleepable) {
>>>>             ret = -EINVAL;
>>>>             switch (prog->type) {
>>>>             case BPF_PROG_TYPE_TRACING:
>>>>
>>>>                 /* fentry/fexit/fmod_ret progs can be sleepable if they are
>>>>                  * attached to ALLOW_ERROR_INJECTION and are not in denylist.
>>>>                  */
>>>>                 if (!check_non_sleepable_error_inject(btf_id) &&
>>>>                     within_error_injection_list(addr))
>>>
>>> Oh. That's an annoying side effect of disabling error inject.
>>> fentry progs are not injecting any errors. They just use that
>>> list as allowlist of good attach points.
>>> Let's explicitly allow all syscalls here.
>>
>> Ok, I'll post a patch.
>>
>>>
>>>>                     ret = 0;
>>>>                 /* fentry/fexit/fmod_ret progs can also be sleepable if they are
>>>>                  * in the fmodret id set with the KF_SLEEPABLE flag.
>>>>                  */
>>>>                 else {
>>>>                     u32 *flags = btf_kfunc_is_modify_return(btf, btf_id,
>>>>                                         prog);
>>>>
>>>>                     if (flags && (*flags & KF_SLEEPABLE))
>>>>                         ret = 0;
>>>>                 }
>>>>                 break;
>>>>             [...]
>>>>             }
>>>>             if (ret) {
>>>>                 module_put(mod);
>>>>                 bpf_log(log, "%s is not sleepable\n", tname);
>>>>                 return ret;
>>>>             }
>>>>     }
>>>>
>>>> If I read that correctly, fentry must be on the error injection list
>>>> (which is populated by functions marked with ALLOW_ERROR_INJECTION when
>>>> CONFIG_FUNCTION_ERROR_INJECTION=y) to be allowed as sleepable.
>>>>
>>>> The other branch for fmodret id set seems to be only relevant for
>>>> kernel modules which explicily register their functions into
>>>> BTF_KFUNC_HOOK_FMODRET set.
>>>>
>>>>> While CONFIG_BPF_KPROBE_OVERRIDE affects a single helper.
>>>>>
>>>>> Both fentry and fentry.s should work fine on sys_nanosleep.
>>>>> fmod_ret is also completely independent of these two flags.
>>>>
>>>> For fmod_ret, we have a very similar code:
>>>>
>>>>     } else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
>>>>             [...]
>>>>             ret = -EINVAL;
>>>>             if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
>>>>                 !check_attach_modify_return(addr, tname))
>>>>                 ret = 0;
>>>>             if (ret) {
>>>>                 module_put(mod);
>>>>                 bpf_log(log, "%s() is not modifiable\n", tname);
>>>>                 return ret;
>>>>             }
>>>>     }
>>>>
>>>> with
>>>>
>>>>     static int check_attach_modify_return(unsigned long addr, const char *func_name)
>>>>     {
>>>>         if (within_error_injection_list(addr) ||
>>>>             !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
>>>
>>> Same thing here.
>>> Let's wrap within_error_injection_list() with bpf specific helper
>>> that in case of !CONFIG_FUNCTION_ERROR_INJECTION
>>> will allow syscalls anyway.
>>
>> I would argue that fmod_ret should remain gated behind
>> CONFIG_ERROR_INJECTION. It's a similar concept to kprobe override - it
>> allows to override the execution of the original syscall and return a
>> custom error code.
> 
> Definitely not. fmod_ret and error injection are two orthogonal concepts.
> fmod_ret was introduced to be independent of error injection in the
> first place. fmod_ret is a deliberate spot to allow bpf to change
> return code
> in production.

I'm not sure that was the original intention of fmod_ret. Even the
original patch set mentions that error injection needs to be explicitly
enabled [1,2]. Changing that is IMHO a significant shift which needs
discussion.

[1] https://lore.kernel.org/bpf/20200304191853.1529-1-kpsingh@chromium.org/
[2] https://lore.kernel.org/bpf/20200304191853.1529-4-kpsingh@chromium.org/

> While error injection is a debug feature to stress test the kernel.
> syscalls are in fmod_ret territory, since this is not debugging
> and not stressing the kernel. ptrace can change syscall returns without
> bpf, without fmod_ret, and without error injection.

The thing I'm worried about here is that allowing BPF programs override
syscalls will esentially allow to implement a BPF-based rootkit. I'm
well aware that BPF is root-only (although there are ways to allow
unprivileged users run BPF, such as tokens) but if a potential attacker
gains root access even for a short time, they can install the rootkit
which may live unnoticed from that moment. Which is not something we
really want to enable in production. For ptrace, my understanding is
that it is significantly easier to detect if it is used.

If you don't mind, I'd start with only allowing sleepable syscalls (when
error injection is disabled) for now.

Viktor

