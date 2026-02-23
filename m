Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5734FF4D
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847561; cv=none; b=hfdAebYxCg6ooFZnTdZ1o6sPp62MFNY231qYh69odo11yHJ0Ud3UGINWbz8/hjzKkCYtGIkG10IUqAaamGEMGZsHij8MIsJRP+3hYns6bKYLuMgnjyYUyz/QfXmiAaBW7wHLsQXsIeim7qeOgoKj1O6ii6YvVppeWVWOfDgX5RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847561; c=relaxed/simple;
	bh=yoFHgM9+Mlrw4RBzyJBsdbZ1JR1zow2fnujol+orqEU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wc8NG7Wg5oxVQ6buWe6rwCHoFsicAE4fTM4yJcUYH/PhUcQFHGu+0/2xaBOMow3bEVfqber1Fkw4QwjFuiO9hY7CXNpCIjNbhjyX9JOdx5LUza4WfEXoQppA8vZ2fj/kBXEraIl4C62mTzZx5zD458BHE1Szj1D1fKMV4KoDLhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWCTRahe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PL77kHxm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWCTRahe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PL77kHxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771847558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+UCu4+UtCPWElkxi2K6F4aNzlRX2JMqSRFEG9Ahsyg=;
	b=VWCTRaheZjZKtDN2f5fIFpbN6VNq/ouzn3/f0k2iz254sZQv34zy7UwBwxsif+w+cDi2/L
	Nf0ba6p/TIqc6q4h3blhIobMK/dcqHw0+cEPNKKSem4m792/TAdRlMIJr4Pn+FTZfN3ECd
	EEU4LBwcArWuPG1amYs+LiE8z1tj+ms=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-AtdkgMbiNval3AK5HDlAqw-1; Mon, 23 Feb 2026 06:52:37 -0500
X-MC-Unique: AtdkgMbiNval3AK5HDlAqw-1
X-Mimecast-MFC-AGG-ID: AtdkgMbiNval3AK5HDlAqw_1771847556
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836b7c302fso37056205e9.1
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 03:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771847556; x=1772452356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e+UCu4+UtCPWElkxi2K6F4aNzlRX2JMqSRFEG9Ahsyg=;
        b=PL77kHxmapSMsg8MZIyEIhiD0V66NWOwFuzM4BZ6yrH+SOrEqd2zI9k8pj91LLaLiI
         nLJVU0l1GfCNTLlc4VYVO7qq5wTd+W87L4l/7FEl1X0PEAxiTIIkchoReipmdwlWhhNb
         vqjDhNP+q+9ushF56OKnjt43nKTzj+ajqu3BEGtjJTtQwXBeEUfSl78jzt+XXFhm2jZj
         9N0dspjEGZREYzhD0VR61FQXauZUDWO/8noLiiw3XgtFnm538qoJHS4g2SNovd8ROMH/
         Nj2kJud0vEPZtT4tkLR5FvYHUHbt2eJ87zYzgzQkSYFccYSKndugBUhn7V8X67JCYJnX
         b7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771847556; x=1772452356;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+UCu4+UtCPWElkxi2K6F4aNzlRX2JMqSRFEG9Ahsyg=;
        b=wmICdDj6/246ing0hP1Txm9fOPL/rLX9BpdQ90PmAZaoElsPMqZH6x9Q0m9ww72kc+
         HSMlLLDtScPe7xudeWeB6JP10dgM2ibjXCOTjQHufphQ4FjScNlRtIB1JFFJeQ+EzPa3
         XR5c0uN7HfD+kiKGk9Aj8+6LBR94qOW0YHSdpDslwbBEOxmyqJ5JMGtAFnmur60OuCs9
         c8OeOQEOyit+y5aFMNIq9n9QrtzwukMqMCJBvW4aBFhW3Tts3rA6DRBmmpBKbrDkp3dI
         JJ17DMnef1g/8hCCzj5P+hF7EZmssFw5a9O4HglFESl2G3ulPgyB2+4Y3fxTSe487752
         AbKw==
X-Gm-Message-State: AOJu0YxoCzpl0F5K72+kKUobOmy0ZRLa9BJZulP5Ie+uRDhqV6pY3o8w
	84luQrQ/6rAsrNGpkpaergxDUoARs74eur4Ulo0NFMDBTHkgz74oqw8VbmhHNZofkyz4ZyeVcex
	170sfaLLnNOfjLMPQwBDZhM4OHSa81ASnmpdUejn7FbuiVvBw5AdN
X-Gm-Gg: AZuq6aInMutLz1I1aCuIvz7tIo9+Ttsjm6HNi7G4g1ZaLz24WAJ5DC2E6FKWN0oymRT
	969Nzdy3KQHMSwkqvtuDWrzdau4qD/pirWky/osRQg6UkvkVucgV+qqnQ4n7/fDB/K8s6UQNhQY
	ti7NnaYyFtGUw3bGK/xW2von6sSfMHLKuqrNoEJyO0J39m7l7dEVvAGBfM4tqPrxk3pE25qXJTO
	pJjEdHoA6qyWh9y8DMncjgPd4+jkpo2eBQLsmWRoC2f8mR5f2PTQ5g6Os1mDDKAqnT4McmVFDTA
	8V7KbMlj5svjftWS5quXUaHJ7fztzlOG9FUjQcTpz/b5dz9VlqHn+i6m61nWw3owlxW6c5yTY9t
	QkzNI1GQ21GZAC6inHO7caZ1zLfYSN74aAA+v5eMvnpSQT3SnYMYgBsSQ
X-Received: by 2002:a05:600c:154b:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-483a962e38bmr125052955e9.21.1771847556053;
        Mon, 23 Feb 2026 03:52:36 -0800 (PST)
X-Received: by 2002:a05:600c:154b:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-483a962e38bmr125052355e9.21.1771847555453;
        Mon, 23 Feb 2026 03:52:35 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bfa015sm18488022f8f.8.2026.02.23.03.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 03:52:34 -0800 (PST)
Message-ID: <0675cf92-1833-4f1a-bd8e-53de5cc1ed7e@redhat.com>
Date: Mon, 23 Feb 2026 12:52:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/3] Separate tests that need error injection
From: Viktor Malik <vmalik@redhat.com>
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
 <d2706604-1674-49fd-a150-7ace8839657f@redhat.com>
 <CAADnVQLT7cGgExtaqusyk+XwrD=-x15kL0veJB5YPewjPo=PUg@mail.gmail.com>
 <fa67d3db-273f-4e4e-90a2-ba805f484bd1@redhat.com>
Content-Language: en-US
In-Reply-To: <fa67d3db-273f-4e4e-90a2-ba805f484bd1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/16/26 08:46, Viktor Malik wrote:
> On 2/14/26 00:13, Alexei Starovoitov wrote:
>> On Fri, Feb 13, 2026 at 1:22 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>
>>> On 2/12/26 17:35, Alexei Starovoitov wrote:
>>>> On Wed, Feb 11, 2026 at 11:22 PM Viktor Malik <vmalik@redhat.com> wrote:
>>>>>
>>>>> On 2/12/26 02:42, Alexei Starovoitov wrote:
>>>>>> On Wed, Feb 11, 2026 at 5:55 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>>>>>
>>>>>>> On 2/11/26 03:42, Alexei Starovoitov wrote:
>>>>>>>> On Tue, Feb 10, 2026 at 7:14 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> Some enterprise kernels (such as RHEL) do not enable error injection via
>>>>>>>>> BPF (CONFIG_FUNCTION_ERROR_INJECTION and CONFIG_BPF_KPROBE_OVERRIDE).
>>>>>>>>> When running test_progs on such kernels, a lot of test cases fail since
>>>>>>>>> they use sleepable fentry or fmod_ret program types which require error
>>>>>>>>> injection to be enabled. While it is possible to skip these via custom
>>>>>>>>> DENYLIST, some test_progs are not properly split into subtests and
>>>>>>>>> therefore must be entirely skipped.
>>>>>>>>
>>>>>>>> Something is wrong.
>>>>>>>> -SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>>>>>>>> -int do_probe_read(void *ctx)
>>>>>>>> +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
>>>>>>>> +int probe_read(void *ctx)
>>>>>>>>  {
>>>>>>>>         char buf[8];
>>>>>>>>
>>>>>>>> @@ -37,19 +37,19 @@ int do_probe_read(void *ctx)
>>>>>>>>         return 0;
>>>>>>>>  }
>>>>>>>>
>>>>>>>> -SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
>>>>>>>> -int do_copy_from_user(void *ctx)
>>>>>>>> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
>>>>>>>>
>>>>>>>> sleepable should have nothing to do with CONFIG_FUNCTION_ERROR_INJECTION.
>>>>>>>
>>>>>>> I may be missing something but I think it is directly dependent, at
>>>>>>> least for fentry.
>>>>>>>
>>>>>>> In bpf_check_attach_target (kernel/bpf/verifier.c), we have:
>>>>>>>
>>>>>>>     if (prog->sleepable) {
>>>>>>>             ret = -EINVAL;
>>>>>>>             switch (prog->type) {
>>>>>>>             case BPF_PROG_TYPE_TRACING:
>>>>>>>
>>>>>>>                 /* fentry/fexit/fmod_ret progs can be sleepable if they are
>>>>>>>                  * attached to ALLOW_ERROR_INJECTION and are not in denylist.
>>>>>>>                  */
>>>>>>>                 if (!check_non_sleepable_error_inject(btf_id) &&
>>>>>>>                     within_error_injection_list(addr))
>>>>>>
>>>>>> Oh. That's an annoying side effect of disabling error inject.
>>>>>> fentry progs are not injecting any errors. They just use that
>>>>>> list as allowlist of good attach points.
>>>>>> Let's explicitly allow all syscalls here.
>>>>>
>>>>> Ok, I'll post a patch.
>>>>>
>>>>>>
>>>>>>>                     ret = 0;
>>>>>>>                 /* fentry/fexit/fmod_ret progs can also be sleepable if they are
>>>>>>>                  * in the fmodret id set with the KF_SLEEPABLE flag.
>>>>>>>                  */
>>>>>>>                 else {
>>>>>>>                     u32 *flags = btf_kfunc_is_modify_return(btf, btf_id,
>>>>>>>                                         prog);
>>>>>>>
>>>>>>>                     if (flags && (*flags & KF_SLEEPABLE))
>>>>>>>                         ret = 0;
>>>>>>>                 }
>>>>>>>                 break;
>>>>>>>             [...]
>>>>>>>             }
>>>>>>>             if (ret) {
>>>>>>>                 module_put(mod);
>>>>>>>                 bpf_log(log, "%s is not sleepable\n", tname);
>>>>>>>                 return ret;
>>>>>>>             }
>>>>>>>     }
>>>>>>>
>>>>>>> If I read that correctly, fentry must be on the error injection list
>>>>>>> (which is populated by functions marked with ALLOW_ERROR_INJECTION when
>>>>>>> CONFIG_FUNCTION_ERROR_INJECTION=y) to be allowed as sleepable.
>>>>>>>
>>>>>>> The other branch for fmodret id set seems to be only relevant for
>>>>>>> kernel modules which explicily register their functions into
>>>>>>> BTF_KFUNC_HOOK_FMODRET set.
>>>>>>>
>>>>>>>> While CONFIG_BPF_KPROBE_OVERRIDE affects a single helper.
>>>>>>>>
>>>>>>>> Both fentry and fentry.s should work fine on sys_nanosleep.
>>>>>>>> fmod_ret is also completely independent of these two flags.
>>>>>>>
>>>>>>> For fmod_ret, we have a very similar code:
>>>>>>>
>>>>>>>     } else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
>>>>>>>             [...]
>>>>>>>             ret = -EINVAL;
>>>>>>>             if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
>>>>>>>                 !check_attach_modify_return(addr, tname))
>>>>>>>                 ret = 0;
>>>>>>>             if (ret) {
>>>>>>>                 module_put(mod);
>>>>>>>                 bpf_log(log, "%s() is not modifiable\n", tname);
>>>>>>>                 return ret;
>>>>>>>             }
>>>>>>>     }
>>>>>>>
>>>>>>> with
>>>>>>>
>>>>>>>     static int check_attach_modify_return(unsigned long addr, const char *func_name)
>>>>>>>     {
>>>>>>>         if (within_error_injection_list(addr) ||
>>>>>>>             !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
>>>>>>
>>>>>> Same thing here.
>>>>>> Let's wrap within_error_injection_list() with bpf specific helper
>>>>>> that in case of !CONFIG_FUNCTION_ERROR_INJECTION
>>>>>> will allow syscalls anyway.
>>>>>
>>>>> I would argue that fmod_ret should remain gated behind
>>>>> CONFIG_ERROR_INJECTION. It's a similar concept to kprobe override - it
>>>>> allows to override the execution of the original syscall and return a
>>>>> custom error code.
>>>>
>>>> Definitely not. fmod_ret and error injection are two orthogonal concepts.
>>>> fmod_ret was introduced to be independent of error injection in the
>>>> first place. fmod_ret is a deliberate spot to allow bpf to change
>>>> return code
>>>> in production.
>>>
>>> I'm not sure that was the original intention of fmod_ret. Even the
>>> original patch set mentions that error injection needs to be explicitly
>>> enabled [1,2]. Changing that is IMHO a significant shift which needs
>>> discussion.
>>
>> That discussion already happened when error_injection was forked
>> as a config flag and went to default N.
> 
> Then I'm a bit confused about the purpose of error_injection. The
> description of the config option says:
> 
>     Add fault injections into various functions that are annotated with
>     ALLOW_ERROR_INJECTION() in the kernel. BPF may also modify the return
>     value of these functions. This is useful to test error paths of code.
> 
>     If unsure, say N
> 
> But if you say that fmod_ret and error_injection are orthogonal
> concepts, then what is error_injection good for without fmod_ret?
> 
>>>
>>>> While error injection is a debug feature to stress test the kernel.
>>>> syscalls are in fmod_ret territory, since this is not debugging
>>>> and not stressing the kernel. ptrace can change syscall returns without
>>>> bpf, without fmod_ret, and without error injection.
>>>
>>> The thing I'm worried about here is that allowing BPF programs override
>>> syscalls will esentially allow to implement a BPF-based rootkit. I'm
>>> well aware that BPF is root-only (although there are ways to allow
>>> unprivileged users run BPF, such as tokens) but if a potential attacker
>>> gains root access even for a short time, they can install the rootkit
>>> which may live unnoticed from that moment. Which is not something we
>>> really want to enable in production. For ptrace, my understanding is
>>> that it is significantly easier to detect if it is used.
>>>
>>> If you don't mind, I'd start with only allowing sleepable syscalls (when
>>> error injection is disabled) for now.
>>
>> I mind and I hate the reasoning that in kernels with error_injection=y
>> bpf is prone to be a rootkit. This is just a security circus
>> detached from reality.
> 
> Could you share a bit more details why? I'm not a security expert myself
> but it seems to me that intercepting syscalls could be used to implement
> a rootkit. For instance [1] does something similar, although they use
> bpf_override_return in syscall kprobes. So, I'd love to understand why
> this is detached from reality.

Looking into this more, I assume that the premise here is that injecting
errors into syscalls is not sufficient to implement a rootkit, more
mechanisms are necessary for that (even [1] uses bpf_probe_write_user
which is by default enabled on any kernel). On top of that, there are
tons of other ways to compromise a system using eBPF so enabling error
injection doesn't change much in that direction.

With that, I'm ok with enabling fmod_ret for syscalls even with
CONFIG_ERROR_INJECTION=n, I'll send a patch.

> 
> Thanks!
> Viktor
> 
> [1] https://github.com/Gui774ume/ebpfkit

