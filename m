Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD8C31619C
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770818104; cv=none; b=ZfvMzHtvdYeStmqZ6uXJeDa1BjrSbG46z+ukeMwTXAVfziOxgbUlTKlJZ2b/NB4uvL1hYOvzq8eSexWdpY8weyrY0XP9UhTM7GXfS4ScaIYQN05qLe/SZ6Z/pyJpDPGQslehuVao67Q8RsJf6KiALBq7n7qK2MxK2dRQsPZvevM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770818104; c=relaxed/simple;
	bh=h8TVSxpF3S1g75wMSlh7R5WYJJefy9r9FLsaDGtf4F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5G8g6dCk61LegXAHOKvuNcstdlWiiq4AciGiReo8AQBj7/MksoAwPlLX3HawMd70ugMwfxgdXC6jKv5KLEIjGwH9M19pDQS5cBxIkjAjhBJN/nmi0eeq64sdD+hNPMOYrZU8l1VYEn3aRe2c4F4QshpcvHzPsMY5aqbg/VRaRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9QWd3ar; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlM5J7Ge; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9QWd3ar";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlM5J7Ge"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770818101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ig06o4Gr91sCSE6EwffkQG2fdhXjgVUS7BCrFHVvq6c=;
	b=g9QWd3arMXqiIcQN3sMGmA+KzeSYT2DpaigzxT0VlzE9kVV65NhgUuuGqP0RA90IuMFEaT
	pibtNsQSMq1w0e1mYAscNK1rofTIQIqN0FkR1WGXkzEZtwjlQRS78B0BNTAomhbvVTwZqL
	2Xbh4wrIrKmQ0g8u/BEKLpUOBHLNR68=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-kMQxQPA2PYKcIs4yoY3TvA-1; Wed, 11 Feb 2026 08:55:00 -0500
X-MC-Unique: kMQxQPA2PYKcIs4yoY3TvA-1
X-Mimecast-MFC-AGG-ID: kMQxQPA2PYKcIs4yoY3TvA_1770818099
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43768e2aa4dso3141817f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 05:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770818099; x=1771422899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ig06o4Gr91sCSE6EwffkQG2fdhXjgVUS7BCrFHVvq6c=;
        b=FlM5J7GeM1XZXzXDAqjZB6Z86b/Dvm/DTgjsdopVPwi2XtmTf8DXVX+0VgjdlKXhaZ
         1YsDus2/s06urloqhOEoq5IIO4mIPHFMDPcp31B0lMjFzPXptObjd82NS1G8OdaZO/O1
         tFh1YXkeNEeHEk3UBJAq7T9nJ+6DblOSIbvQUgC5+cKJ/7LKCN67KjXV0BaufzOjSRSp
         bEwLYnc2xMVh5tIMcHBkFUWl+GLn5miL8T09WrTqotV6cDl09w+suUVv3I8y2EiUS5QV
         PSoUZqJaFdL5ja2IZP1ZaJpPfPnykG93ViSXtiSxLXAPTvzt7doIWp4taSJRwQ02Mg4N
         eKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770818099; x=1771422899;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ig06o4Gr91sCSE6EwffkQG2fdhXjgVUS7BCrFHVvq6c=;
        b=mFj4+mFW5cW2bq0H2lTQqbwz9OUS2dQ+Icm+CRWs5b6Z5YkcwSUEF+vR3Yc8IikEDJ
         SSnQS4AbJmnr5KaCBwHiUYjiccJawUKczCc2n2Vb9Fr6dpVCcZiDPyog+GATTIL8PUcY
         TkMtXYzerZfrWiEB9vQr2/D38+2mRXy7L46rv7AobKbqYm42cnXCOCyQAtk1bTmn6Gy3
         kKpTHQJ6fGsI14GBuKQ2dySWQVnfUZeoCE8hmDr4yxXs+0YUL8gLmJc2pEXn79jobY3h
         8R9PyAb+MHMpXjmq0/NkRPow7Wd7q7EO0tBVSq+XG6QoPcudET/Sj7UCCdqcOpQrJz2V
         AdmQ==
X-Gm-Message-State: AOJu0Yzch9IKIWD7LzdkXXN0/R1FukUIQZnRApr+/1OnUsOwF4yJKGay
	RniLvkjRPlJPXZ0Lqp3VCJnWRzOVI9UaR3F60GADA5OwkpVzb+wIcMjT2NuNPw70x4xTrfWq7ve
	VGczc7IfK9KotIt1xCgSJAgkZ67J2uoV9scIcDunKuG5R7k4iKi97
X-Gm-Gg: AZuq6aJXgn5MVCGgxlsl5JxZko/3kzFEouBS0jRZsFYkEMdweJfbYNvh7yrNp3X2gle
	sIw23kINb/g3gITpikcNo3NJeRcuH9pSPhdS0/4vpK04DUzfkr+m8jVczGtJ0Fy3UF2px61kxl4
	yMx3T9uf1V3p5kaui0YVae8nisrMtlgcf1Ouo6kPxGJrWI9IgK7Fff/Ciq+n2bh1aPMoOt5MA+4
	ULf3YRfYRts8pN0u5BQes6/FiTmoM6DcvvuuJZM0WHin7RbFBo/HNFDdLy+gjIhRjD7Rurt/lqV
	qrb+HDJI2/fq5OEqFvL9IWMVDMoUIVym1eSsDO26OMWLzCLBWSvif5+Hp8Rm9O4/jn6qiBzSKC6
	t6CnCfYZq
X-Received: by 2002:a05:6000:2404:b0:431:35a:4a8f with SMTP id ffacd0b85a97d-4377a596f40mr9580267f8f.47.1770818099257;
        Wed, 11 Feb 2026 05:54:59 -0800 (PST)
X-Received: by 2002:a05:6000:2404:b0:431:35a:4a8f with SMTP id ffacd0b85a97d-4377a596f40mr9580226f8f.47.1770818098771;
        Wed, 11 Feb 2026 05:54:58 -0800 (PST)
Received: from [10.43.17.26] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d48954sm4368554f8f.12.2026.02.11.05.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 05:54:58 -0800 (PST)
Message-ID: <d92e60ea-d590-4ce4-961f-4e8ce1cb0c42@redhat.com>
Date: Wed, 11 Feb 2026 14:54:54 +0100
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
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQLfV3PPYA8=EXDKwoQ925_W9HANf7gSn2=_fd42HD_FiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/11/26 03:42, Alexei Starovoitov wrote:
> On Tue, Feb 10, 2026 at 7:14 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> Some enterprise kernels (such as RHEL) do not enable error injection via
>> BPF (CONFIG_FUNCTION_ERROR_INJECTION and CONFIG_BPF_KPROBE_OVERRIDE).
>> When running test_progs on such kernels, a lot of test cases fail since
>> they use sleepable fentry or fmod_ret program types which require error
>> injection to be enabled. While it is possible to skip these via custom
>> DENYLIST, some test_progs are not properly split into subtests and
>> therefore must be entirely skipped.
> 
> Something is wrong.
> -SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> -int do_probe_read(void *ctx)
> +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
> +int probe_read(void *ctx)
>  {
>         char buf[8];
> 
> @@ -37,19 +37,19 @@ int do_probe_read(void *ctx)
>         return 0;
>  }
> 
> -SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
> -int do_copy_from_user(void *ctx)
> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
> 
> sleepable should have nothing to do with CONFIG_FUNCTION_ERROR_INJECTION.

I may be missing something but I think it is directly dependent, at
least for fentry.

In bpf_check_attach_target (kernel/bpf/verifier.c), we have:

    if (prog->sleepable) {
            ret = -EINVAL;
            switch (prog->type) {
            case BPF_PROG_TYPE_TRACING:

                /* fentry/fexit/fmod_ret progs can be sleepable if they are
                 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
                 */
                if (!check_non_sleepable_error_inject(btf_id) &&
                    within_error_injection_list(addr))
                    ret = 0;
                /* fentry/fexit/fmod_ret progs can also be sleepable if they are
                 * in the fmodret id set with the KF_SLEEPABLE flag.
                 */
                else {
                    u32 *flags = btf_kfunc_is_modify_return(btf, btf_id,
                                        prog);

                    if (flags && (*flags & KF_SLEEPABLE))
                        ret = 0;
                }
                break;
            [...]
            }
            if (ret) {
                module_put(mod);
                bpf_log(log, "%s is not sleepable\n", tname);
                return ret;
            }
    }

If I read that correctly, fentry must be on the error injection list
(which is populated by functions marked with ALLOW_ERROR_INJECTION when
CONFIG_FUNCTION_ERROR_INJECTION=y) to be allowed as sleepable.

The other branch for fmodret id set seems to be only relevant for
kernel modules which explicily register their functions into
BTF_KFUNC_HOOK_FMODRET set.

> While CONFIG_BPF_KPROBE_OVERRIDE affects a single helper.
> 
> Both fentry and fentry.s should work fine on sys_nanosleep.
> fmod_ret is also completely independent of these two flags.

For fmod_ret, we have a very similar code:

    } else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
            [...]
            ret = -EINVAL;
            if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
                !check_attach_modify_return(addr, tname))
                ret = 0;
            if (ret) {
                module_put(mod);
                bpf_log(log, "%s() is not modifiable\n", tname);
                return ret;
            }
    }

with

    static int check_attach_modify_return(unsigned long addr, const char *func_name)
    {
        if (within_error_injection_list(addr) ||
            !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
            return 0;

        return -EINVAL;
    }

So, again, the function needs to be on the error injection list to be
allowed as modifiable.

> 
> Please root cause it instead of hacking the tests.

My question is: are sleepable and fmod_ret functions supposed to work
without error injection turned on? I'm happy to discuss that instead of
hacking the tests but it seems to me that it doesn't work at the moment
(also confirmed experimentally - turning CONFIG_FUNCTION_ERROR_INJECTION
off will make many tests fail with "... is not modifiable" or "... is
not sleepable").

Viktor

> 
> pw-bot: cr
> 

