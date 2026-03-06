Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C3A36AB43
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778414; cv=none; b=Y+tLznEMTF3CVBmpgjyXOm66kHqxqeA+HAAsRE7FkfOFN7Fu3HlrDPdmlIj5MOJbszYgMo5UmGT2C6wLhsLhkM3NxSFHqk7sdLE9LvDzJ8U3izSMxKO4Ik8UAB/YHb1VJuA8+M/8GR1ylEe4UG/b01gGVNX9wK++4lpoS5mqDjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778414; c=relaxed/simple;
	bh=t43Arh6aOk/VLUDEWJr60/kuvDuTyYOTJW1j44L3uZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzMKCRDN3sCbaFHtAcFctSDUpkgpEormL94DkOR5j/KxCczKFQwYmfQxiFcQrv8985r4SlEY9SsxWmhL+3qhnZX0lpg7egLaesFxhOm9GNnmpg+oMs/m6XFIeJ44GKgU37+Vv7stRTEoCoxIiLa/7kuN5GOX3E3bcPAXJ9Ytj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrDRG05m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+QyyLlX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrDRG05m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+QyyLlX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772778412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcEZWBO/Rgn+S6znBkQ1ckrlfg37jdpmt6xxTdXKWRM=;
	b=MrDRG05mP/oLuOpX2wF0MPxvuzFadD/OQYiB0FzBSjPdc3SFN/UfWAvS+mcwu9t7fFwlnW
	LxMEfWQKn9/je49iYgnvKvhxmr/AlpvBHvWWwd2ctJ5PjsS+k7bkfwBN43uRm0oBzHtdez
	QtsIilF6kZkYhj4BBcYff8eunDVY84k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ps9gOB7HOSKp2W-XhpHIUw-1; Fri, 06 Mar 2026 01:26:51 -0500
X-MC-Unique: ps9gOB7HOSKp2W-XhpHIUw-1
X-Mimecast-MFC-AGG-ID: ps9gOB7HOSKp2W-XhpHIUw_1772778410
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439c794ec8eso2847574f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 22:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772778409; x=1773383209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VcEZWBO/Rgn+S6znBkQ1ckrlfg37jdpmt6xxTdXKWRM=;
        b=X+QyyLlX23U/Ka83kdOl+NLYo6XItElxyvLwU3pVdwpDoXWOwQMfEPi7jiKie/C/ez
         t7Kt5D81+HlcoHx82z4paW4ZhAe53rhg6xXTCi3zUM7jMUXeLtE0EAK53giMRCkNuwvA
         AN+kTNGf6u2XNxylcHx7/V8P43Z0SuNimfb7hNyzHFV4ytwD++ySMDkqoK4PG/EtC8kH
         LG2ZGm86Ot5Dymr5OgZu4xD6HW7ljm4SXDi2SaV2XtxY6sqthGzIxskMvSmGtGiHVOsN
         mVNlzbZSH1uuxxXd/AL5PCVC50qawxoTsIqvpQfLob0WzDgEEz2jGGFMumwU9CI1DxDe
         DFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772778409; x=1773383209;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcEZWBO/Rgn+S6znBkQ1ckrlfg37jdpmt6xxTdXKWRM=;
        b=aFY9ccthaRZoOmrxTW8aUMlNw7OBd5LpL+hpk+ZZOH44DJsvnr9bS5Yb7yRwUFLgK4
         3fy/Gd6ltlVamvy2KEo6M+LtmXerrnvaiSKUqOqbv8jWae12y38p7r97QDB4sGiLHarT
         8Q8EYRKVwFwL9g10u/uvXSTJOHeetHNU9pxbpuvJnTkX2t2UZCTRKoALGrVdpafW20+P
         e7l3G3b12MYMZn6Y1OIM1XGm+n/0tP4RYY3PW/0JtYT3DNT37eb31rHncm0NK0d4ec7+
         BUH5n+QyamTFqGPQcndAfigV3zMrI6myE7WwjlCi98PrZ4mzj8SuzL3LK8Eyesyj2Dw/
         KcFw==
X-Gm-Message-State: AOJu0Ywm8QvEUFcgPWdAGeFnBSZP+v+EBRpoRdWab+QR6e2o1eqJqPxU
	TdKkm1UPi3SxCybkKbxSRwkYZD/YjT3FPPp8glcZiKbmkX9jIdJBivfkO/c3qof3c9K7QYQItuL
	OaLLdw6zPLDG0dIfLRD3MaPDb1KCZ9+tGDnbEqPiaCOt0KbQjyDFxMhzN9GE2jKg=
X-Gm-Gg: ATEYQzw9DeDAq76cI5NtbVvn1DfiRSzUPsg75aT1j9feAthFN6nyLmZK7Ut63ChCqC8
	jdEUodrCycF6Se/rQ6/c6UkEhY+9YZDgk0331cCM051UbYomNUibKFUHEapeTnyi8CT97F/zq/Q
	Ev+SF50CDv1kjxx/RsWv/SJFXlXEcV3KxshJCPmQ4Ib4jHgFk5v2lyk5mN0eyoK3OIs2kO+Y3E0
	h6fUMFsZdgPyA/QvFUcZGjaeXhtkBbDkJlixOmvDDOSHfHLXrvZZRZq08uZX3IXxQAoQh4B9FmO
	IGE6BYAxUJm5ERMyzOr8kgMW1pdI1xqSIBV/IR/iwBUCSiABBVD9bCuV08+JVpvP2W3HXupv84V
	Ewq71nPmzvzBkQhBlVKp8mzHa3LJL31s/SMCG+GfnpB2Dk5FgaEqNkIAe
X-Received: by 2002:a05:6000:2204:b0:439:b1d8:608e with SMTP id ffacd0b85a97d-439da35f606mr1476246f8f.13.1772778409479;
        Thu, 05 Mar 2026 22:26:49 -0800 (PST)
X-Received: by 2002:a05:6000:2204:b0:439:b1d8:608e with SMTP id ffacd0b85a97d-439da35f606mr1476212f8f.13.1772778409080;
        Thu, 05 Mar 2026 22:26:49 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae57c05sm1382562f8f.39.2026.03.05.22.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 22:26:47 -0800 (PST)
Message-ID: <5e5115c4-5ff9-46ca-aa95-74b1de26f073@redhat.com>
Date: Fri, 6 Mar 2026 07:26:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/3] Always allow sleepable and fmod_ret programs
 on syscalls
To: Leon Hwang <leon.hwang@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
 <f93e9762-fa64-481a-8537-12f6af95abf6@linux.dev>
 <CAP01T77dvSCyGq4L6XFS3uMeB7dTwCRvbePL-mnbEHDU7xvm=A@mail.gmail.com>
 <e7316548-8f90-4569-8ef9-e7a14a5ccd16@linux.dev>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <e7316548-8f90-4569-8ef9-e7a14a5ccd16@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 03:16, Leon Hwang wrote:
> On 6/3/26 10:14, Kumar Kartikeya Dwivedi wrote:
>> On Fri, 6 Mar 2026 at 03:04, Leon Hwang <leon.hwang@linux.dev> wrote:
>>>
>>> Hi Viktor,
>>>
>>> On 5/3/26 23:25, Viktor Malik wrote:
>>>> Both sleepable and fmod_ret programs are only allowed on selected
>>>> functions. For convenience, the error injection list was originally
>>>> used.
>>>>
>>>> When error injection is disabled, that list is empty and sleepable
>>>> tracing programs, as well as fmod_ret programs, are effectively
>>>> unavailable.
>>>>
>>>> This patch series addresses the issue by at least enabling sleepable and
>>>> fmod_ret programs on syscalls, if error injection is disabled.
>>>>
>>>
>>> Could you please explain more about the purpose in cover letter?
>>>
>>> I'm curious about enabling fmod_ret programs on syscalls, as they are
>>> able to modify the retval of syscalls.
>>
>> It was already discussed at length here:
>> https://lore.kernel.org/bpf/CAADnVQJ4PU7bCb5XO9+zMZhLRSdbCKwxG6Rtojh2Rc3UZ8H43Q@mail.gmail.com/
>>
> 
> Thanks for pointing this out.
> 
> Thanks,
> Leon
> 
>> I think the next version could include a link to the previous thread
>> in the cover letter for posterity.

Good point, I'll definitely add a link to the discussion.

>>
>>>
>>> Thanks,
>>> Leon
>>>
>>>> Viktor Malik (3):
>>>>   bpf: Always allow sleepable programs on syscalls
>>>>   bpf: Always allow fmod_ret programs on syscalls
>>>>   selftests/bpf: Move sleepable refcounted_kptr tests to syscalls
>>>>
>>>>  kernel/bpf/verifier.c                         | 79 +++++++++++++++----
>>>>  .../selftests/bpf/progs/refcounted_kptr.c     |  4 +-
>>>>  .../bpf/progs/refcounted_kptr_fail.c          |  2 +-
>>>>  3 files changed, 68 insertions(+), 17 deletions(-)
>>>>
>>>
>>>
> 

