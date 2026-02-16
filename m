Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA066261B8C
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771227999; cv=none; b=d0aNiQJGeOcJ0Jt8dF8z+yGOS0k0hXaAKzAjm2cYS7qpQ5OYWpjlp2Y9gYV9ZY5PdMBWequ8BHv8YXnRTS/vAjD150AQiSBQZnH04Ob1K/rhzYSl9udJ1h4YXokoBbOOLZpOKB6Xyf/k8JNuRsdU7oHBrFKoEKcqV7HOQE+D9iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771227999; c=relaxed/simple;
	bh=wSut9FQtLKMO4EcUHdU6CefWIva5CurqBWcTHuoynR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5H1clxkuZjJcKMt5cryyVV8sJzg+xpGEiBTT0Ht2IxTh/+ylJW0elX0keDM+IsE1nx8Z7EnYAkAmXjHgVyRKh52j11xysvMF+J2Y89hNASDnXwjHpkiam4hCY0NHwiqfFiagzhrPyLy9Dzn/HxiFaA+dQ8GSKpV7IktAxKnspg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgTz5Asb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aR18t/pM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgTz5Asb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aR18t/pM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771227996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=prqHiuIU7QidyeE7+h6YUHswcoSlCUWh2j3N2qfWoWU=;
	b=bgTz5AsbsIBe7Dszwc6J4H6mBjOccY/tRbFXYBH+poYIRdkzaNOFdvzDsL6rj/o5Yc6RcG
	P4Dl9PdRYfnO23MTAcG1XVqGE2C4bEBDavCCV2O/MQij7eOT14P1+6Mm3Aj5wZBCRgfTJr
	NSsGRjK5c0b+MV7REbT9G5SXjpW3YmE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-hUoRGwTMPdqK5UPAZJDohw-1; Mon, 16 Feb 2026 02:46:32 -0500
X-MC-Unique: hUoRGwTMPdqK5UPAZJDohw-1
X-Mimecast-MFC-AGG-ID: hUoRGwTMPdqK5UPAZJDohw_1771227991
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48079ae1001so23761045e9.0
        for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 23:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771227991; x=1771832791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prqHiuIU7QidyeE7+h6YUHswcoSlCUWh2j3N2qfWoWU=;
        b=aR18t/pMwqlC4bqEYAZuelQIsVhiXCvJ0sQLJXzBUrJBp1c5ppP2tUkSN6lsv7ToFD
         r/vrGzc4/BSA5UuoZLOpOUfZGtUdYLvmhOfBBYBTA26tlxRGxuXdpJ9/2vE6eCqGqYnn
         ofmfVqcYjeJX6sx/+cqNxSdfyQrDr0kfcD6VIlBgQO1Tw0+IxaDClAZBeFtSzwS9YW2k
         BfaXIHXmDTgAba9lD7AOTffLLWIMkrfksIi5kaa25ldfQwibxfryoUugtYySn5OgrNZR
         SbMhOcOVGccXUfKVgXDUiVaqNl7olqQdS8DKkXDsd4XNhL5X+Szl1XQe2xXxW9Mc7qFw
         6VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771227991; x=1771832791;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prqHiuIU7QidyeE7+h6YUHswcoSlCUWh2j3N2qfWoWU=;
        b=ST+6t3YA6DOZR3NjQTm2GT0ZSixYVoh+xXzh7san3xNpRXT5QOZFbjavk9nHj6dIB3
         8txb3ZGn85HEl75tqyEoxI3OxUwV2K5AV+QkMGVjFY+qt3s/C1ltH+KLZSKL+W2RXuKk
         hkxt1PB7EkbuxmHtinL9wjYLWmCvfkN9ZVjxVOd+r9wEIe2uY0LmIGtLT0whk2n0SwZy
         q2u0sNW3s7s6A0vCavfxlKZZ2sUJFRcCCeusCWRJHUIgG9Ccv8kiXQkFbQoAR3g8CB2b
         6rJ1AhsFTwo182dbVkmqaTT3ehhG76yF/QbUbwFHyByfxU34a42T2979+xbFCPsbkmcm
         rmmQ==
X-Gm-Message-State: AOJu0YwU+NjC3sr2sKxzt8pPzqpBli79BtggtCJfcU5uO9cWeZyjKZyD
	5r8golFY94Ihouq4tCTmklcsmT/bpYf81feXoiRjgUED9CKhi5qXLGWjhYqxO08pru2G8b2804K
	I4IkMqjG7r0wwwJng+HHbhiyO6x/VoFtFyiHmSt+aHGv4XsE4xxaw
X-Gm-Gg: AZuq6aJKKZ+EYV0i7Ib9AGrQZG13DV+s45IoLOl9CsuNIHpideSJBFBxWbQYpoMfASU
	KDTKQ3NE0ODbpnTaJvsangpYoGGRQgM3Dqmc+BmKGltvDeOdbcLCynhWr/zSw1FMcyguq9j7lvI
	LivSWXQXJI+xdRE4HQzouEAL2YxB18YuwFmWOnex0Y4mzwQbLPbhyfJSe+cV9KXyBArW2nRS8zh
	h0KmrgzRMcrAXUuxr031JiKvZc4+PL5nOQf96whIY2Y5HxoWrbrzubl9SZqQsNklSRMVxtglt4C
	+nNFts94h0ubdoaVopCnNA1JXQxg12JJ5iQzRXtEC0hkp1AdS+zIjdS/ly2x6jHCzg/Ib9f0irG
	G0cuxSuOJ7gVR4DEzB3rm4kY/lFSTaEo3LtMW+upy6DWXZR5IG+Q03Iyh
X-Received: by 2002:a05:600d:108:20b0:483:80b0:b245 with SMTP id 5b1f17b1804b1-48380b0b344mr61715965e9.9.1771227991239;
        Sun, 15 Feb 2026 23:46:31 -0800 (PST)
X-Received: by 2002:a05:600d:108:20b0:483:80b0:b245 with SMTP id 5b1f17b1804b1-48380b0b344mr61715735e9.9.1771227990714;
        Sun, 15 Feb 2026 23:46:30 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc85csm24800164f8f.22.2026.02.15.23.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Feb 2026 23:46:30 -0800 (PST)
Message-ID: <fa67d3db-273f-4e4e-90a2-ba805f484bd1@redhat.com>
Date: Mon, 16 Feb 2026 08:46:28 +0100
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
 <d2706604-1674-49fd-a150-7ace8839657f@redhat.com>
 <CAADnVQLT7cGgExtaqusyk+XwrD=-x15kL0veJB5YPewjPo=PUg@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQLT7cGgExtaqusyk+XwrD=-x15kL0veJB5YPewjPo=PUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/14/26 00:13, Alexei Starovoitov wrote:
> On Fri, Feb 13, 2026 at 1:22 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 2/12/26 17:35, Alexei Starovoitov wrote:
>>> On Wed, Feb 11, 2026 at 11:22 PM Viktor Malik <vmalik@redhat.com> wrote:
>>>>
>>>> On 2/12/26 02:42, Alexei Starovoitov wrote:
>>>>> On Wed, Feb 11, 2026 at 5:55 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>>>>
>>>>>> On 2/11/26 03:42, Alexei Starovoitov wrote:
>>>>>>> On Tue, Feb 10, 2026 at 7:14 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>>>>>>
>>>>>>>> Some enterprise kernels (such as RHEL) do not enable error injection via
>>>>>>>> BPF (CONFIG_FUNCTION_ERROR_INJECTION and CONFIG_BPF_KPROBE_OVERRIDE).
>>>>>>>> When running test_progs on such kernels, a lot of test cases fail since
>>>>>>>> they use sleepable fentry or fmod_ret program types which require error
>>>>>>>> injection to be enabled. While it is possible to skip these via custom
>>>>>>>> DENYLIST, some test_progs are not properly split into subtests and
>>>>>>>> therefore must be entirely skipped.
>>>>>>>
>>>>>>> Something is wrong.
>>>>>>> -SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>>>>>>> -int do_probe_read(void *ctx)
>>>>>>> +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
>>>>>>> +int probe_read(void *ctx)
>>>>>>>  {
>>>>>>>         char buf[8];
>>>>>>>
>>>>>>> @@ -37,19 +37,19 @@ int do_probe_read(void *ctx)
>>>>>>>         return 0;
>>>>>>>  }
>>>>>>>
>>>>>>> -SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
>>>>>>> -int do_copy_from_user(void *ctx)
>>>>>>> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
>>>>>>>
>>>>>>> sleepable should have nothing to do with CONFIG_FUNCTION_ERROR_INJECTION.
>>>>>>
>>>>>> I may be missing something but I think it is directly dependent, at
>>>>>> least for fentry.
>>>>>>
>>>>>> In bpf_check_attach_target (kernel/bpf/verifier.c), we have:
>>>>>>
>>>>>>     if (prog->sleepable) {
>>>>>>             ret = -EINVAL;
>>>>>>             switch (prog->type) {
>>>>>>             case BPF_PROG_TYPE_TRACING:
>>>>>>
>>>>>>                 /* fentry/fexit/fmod_ret progs can be sleepable if they are
>>>>>>                  * attached to ALLOW_ERROR_INJECTION and are not in denylist.
>>>>>>                  */
>>>>>>                 if (!check_non_sleepable_error_inject(btf_id) &&
>>>>>>                     within_error_injection_list(addr))
>>>>>
>>>>> Oh. That's an annoying side effect of disabling error inject.
>>>>> fentry progs are not injecting any errors. They just use that
>>>>> list as allowlist of good attach points.
>>>>> Let's explicitly allow all syscalls here.
>>>>
>>>> Ok, I'll post a patch.
>>>>
>>>>>
>>>>>>                     ret = 0;
>>>>>>                 /* fentry/fexit/fmod_ret progs can also be sleepable if they are
>>>>>>                  * in the fmodret id set with the KF_SLEEPABLE flag.
>>>>>>                  */
>>>>>>                 else {
>>>>>>                     u32 *flags = btf_kfunc_is_modify_return(btf, btf_id,
>>>>>>                                         prog);
>>>>>>
>>>>>>                     if (flags && (*flags & KF_SLEEPABLE))
>>>>>>                         ret = 0;
>>>>>>                 }
>>>>>>                 break;
>>>>>>             [...]
>>>>>>             }
>>>>>>             if (ret) {
>>>>>>                 module_put(mod);
>>>>>>                 bpf_log(log, "%s is not sleepable\n", tname);
>>>>>>                 return ret;
>>>>>>             }
>>>>>>     }
>>>>>>
>>>>>> If I read that correctly, fentry must be on the error injection list
>>>>>> (which is populated by functions marked with ALLOW_ERROR_INJECTION when
>>>>>> CONFIG_FUNCTION_ERROR_INJECTION=y) to be allowed as sleepable.
>>>>>>
>>>>>> The other branch for fmodret id set seems to be only relevant for
>>>>>> kernel modules which explicily register their functions into
>>>>>> BTF_KFUNC_HOOK_FMODRET set.
>>>>>>
>>>>>>> While CONFIG_BPF_KPROBE_OVERRIDE affects a single helper.
>>>>>>>
>>>>>>> Both fentry and fentry.s should work fine on sys_nanosleep.
>>>>>>> fmod_ret is also completely independent of these two flags.
>>>>>>
>>>>>> For fmod_ret, we have a very similar code:
>>>>>>
>>>>>>     } else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
>>>>>>             [...]
>>>>>>             ret = -EINVAL;
>>>>>>             if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
>>>>>>                 !check_attach_modify_return(addr, tname))
>>>>>>                 ret = 0;
>>>>>>             if (ret) {
>>>>>>                 module_put(mod);
>>>>>>                 bpf_log(log, "%s() is not modifiable\n", tname);
>>>>>>                 return ret;
>>>>>>             }
>>>>>>     }
>>>>>>
>>>>>> with
>>>>>>
>>>>>>     static int check_attach_modify_return(unsigned long addr, const char *func_name)
>>>>>>     {
>>>>>>         if (within_error_injection_list(addr) ||
>>>>>>             !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
>>>>>
>>>>> Same thing here.
>>>>> Let's wrap within_error_injection_list() with bpf specific helper
>>>>> that in case of !CONFIG_FUNCTION_ERROR_INJECTION
>>>>> will allow syscalls anyway.
>>>>
>>>> I would argue that fmod_ret should remain gated behind
>>>> CONFIG_ERROR_INJECTION. It's a similar concept to kprobe override - it
>>>> allows to override the execution of the original syscall and return a
>>>> custom error code.
>>>
>>> Definitely not. fmod_ret and error injection are two orthogonal concepts.
>>> fmod_ret was introduced to be independent of error injection in the
>>> first place. fmod_ret is a deliberate spot to allow bpf to change
>>> return code
>>> in production.
>>
>> I'm not sure that was the original intention of fmod_ret. Even the
>> original patch set mentions that error injection needs to be explicitly
>> enabled [1,2]. Changing that is IMHO a significant shift which needs
>> discussion.
> 
> That discussion already happened when error_injection was forked
> as a config flag and went to default N.

Then I'm a bit confused about the purpose of error_injection. The
description of the config option says:

    Add fault injections into various functions that are annotated with
    ALLOW_ERROR_INJECTION() in the kernel. BPF may also modify the return
    value of these functions. This is useful to test error paths of code.

    If unsure, say N

But if you say that fmod_ret and error_injection are orthogonal
concepts, then what is error_injection good for without fmod_ret?

>>
>>> While error injection is a debug feature to stress test the kernel.
>>> syscalls are in fmod_ret territory, since this is not debugging
>>> and not stressing the kernel. ptrace can change syscall returns without
>>> bpf, without fmod_ret, and without error injection.
>>
>> The thing I'm worried about here is that allowing BPF programs override
>> syscalls will esentially allow to implement a BPF-based rootkit. I'm
>> well aware that BPF is root-only (although there are ways to allow
>> unprivileged users run BPF, such as tokens) but if a potential attacker
>> gains root access even for a short time, they can install the rootkit
>> which may live unnoticed from that moment. Which is not something we
>> really want to enable in production. For ptrace, my understanding is
>> that it is significantly easier to detect if it is used.
>>
>> If you don't mind, I'd start with only allowing sleepable syscalls (when
>> error injection is disabled) for now.
> 
> I mind and I hate the reasoning that in kernels with error_injection=y
> bpf is prone to be a rootkit. This is just a security circus
> detached from reality.

Could you share a bit more details why? I'm not a security expert myself
but it seems to me that intercepting syscalls could be used to implement
a rootkit. For instance [1] does something similar, although they use
bpf_override_return in syscall kprobes. So, I'd love to understand why
this is detached from reality.

Thanks!
Viktor

[1] https://github.com/Gui774ume/ebpfkit

