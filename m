Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2B530595B
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780624624; cv=none; b=AqO13AO/nq7vsC3Iiex2fT0njNrFWWNquoUA411ruFJjxpOqFidnd+VVQyF0MT8c8lGjEp9ia3HDl8cfOfJlrIaiWGmZiHsPJ7QmF+Ra2AW3Zdm4N8BUKWebbsdg6B3SMEOPpdiomF65GUAdnPEl6OY3Y0Q6U6CwbvI8hSbQ8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780624624; c=relaxed/simple;
	bh=jadmf9VC1LDUyEhkM6b+U+lNaW2DjPMJVqrBELeHNbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6tHB2PwymBf8YZC4JF9xfrcUz83r4VXKrhfu8t9y/+XlynrBfwqbLL6cZ+KEQkuI/ScvMOEfsOkT4mr+JvIGUjQjuBPgzyU0kzSihVHctqukZjTRSD3znwvdICLA4CjEvoQwTZ+utDBmUIm3COdekHP83e/V2w8gKxASOlMV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVvAkU6/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVvAkU6/"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b9033d230so775556a91.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 18:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780624618; x=1781229418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9fHnE5/aWcHmZBAbpBqPooAqFKln3As1ZY+Jwjk9ec=;
        b=YVvAkU6/xKVGEpkNZ/LsWpFaCRYcyKQS7WdojY+UBhjCVOnwjwJm0TMrhu29xV1Z+Q
         Kr7ZiSAe26bxM/9256JDsXPgzZ57cqbOGo3btDhkXeofw5x+Y9tr7hWC/DiSZRy2dCAA
         3BHtDHJpMULM0WeZZ7GvPqd+LA8NTtDyez18z/mgZWTXWi3ZuxhHZFLT2c6mjumxsE8L
         hp/u99c5lqOclMyeBVpunZGHZPVvxabnLMT5MdXjlQmVXUusRFvG6g1cwXImig0CN4a3
         xgojwQxCN+erWpquLN43kqk6r7Jpbm/jN9VMzpzSj/pilR/cchAzrnvyEVGCkCJmxQt2
         GHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780624618; x=1781229418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9fHnE5/aWcHmZBAbpBqPooAqFKln3As1ZY+Jwjk9ec=;
        b=kVxKCq1lQ1CnBR0IaCQC6+h2cp0HbNEEf1TnKYE1g7z0IGfbtxBvehsIdHEhgBQtIr
         0gJxXtFVcTMvkyHHeLwOphuFA6lhUsOTk6Lkq2xw2dWShyUh+dlQLszw0bitNV1nZVoX
         bq/Vb6EEsjbRLUAqEAOkkWnGVfz/iB6VsJSDmLLzp+86ia3oLSIJjwMgbl8ik7GPM8oq
         VT+Ka3PK4/eF014PafQwzXDBbcma27IIQQ8QC2GcWb2tDqsHuEVHeBQlflET0XODWvqJ
         COTI6n9TAZHEdP8VPxoeciAvjFCmyONroMJYTzZARuWNYi+6V9762l2nBhN7+FQdObcQ
         axkw==
X-Gm-Message-State: AOJu0YzLOQ00mgvwLmAL+BDtLYkurEUgxGtp8ckBiuiA9fOwzvTtoFXi
	LUjmVvy7TR+YffOn28wqTykM/QV4zgg1QGYyNNo0HQbhg3+Ctg7T+Jdk
X-Gm-Gg: Acq92OF94iB2hnPeXclUHEvkEmZXiS6OMwErNqD37ohFr2MQWM/PGU4TrFmZAhNjWSo
	QrAtTEmzL6JAuQ5sJB1FzAduHhuE/iGWU3jaoeBBfOuwJVuyLh9UYNYPCpVT0aKp7cc0hNh6BLq
	XwXeWrGWDpeJ3RGuqYBGEiwxC3pmTg2ahMC2p0k1gpOYYoIwjrWX2KUkEZmKYB40CryKTN4QITG
	+4pLvgXwGFSHHArgz8kNdY0iiuJkQCrLP4ANW/ZryjjV3DH+qvtAaKko3h5THrvlDVDlAARAnOM
	mPlDLBhff48KTyyzPhpb6wrFkVai4IQSdhpe6gMkZnNriFbymENHr2RKu0lJ35MkURqOFetNnj7
	BZVkFQLsEBvhlJ2MngsfCs4Vedbc1ME+mdotDcY8ZlDLJwBaSxi4vAMDFzYQ2datGyoKxScMHZ0
	e1mFN69aZ9Lh13WsVvPiYQrB8veWJCVGLpaWw6qbG8zhPE8dV3puQzdA==
X-Received: by 2002:a17:90b:2f0d:b0:368:3830:a8bd with SMTP id 98e67ed59e1d1-37131041514mr487063a91.7.1780624618384;
        Thu, 04 Jun 2026 18:56:58 -0700 (PDT)
Received: from [10.22.65.66] ([118.201.124.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827f1sm5711912a91.3.2026.06.04.18.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 18:56:57 -0700 (PDT)
Message-ID: <ca0d8a38-90e2-4f59-b24f-856f6e99ab63@gmail.com>
Date: Fri, 5 Jun 2026 09:56:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Check tail zero of bpf_map_info
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Yuyang Huang <yuyanghuang@google.com>,
 KP Singh <kpsingh@kernel.org>, Dave Marchevsky <davemarchevsky@fb.com>,
 Stanislav Fomichev <sdf@fomichev.me>, LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com, Mykyta Yatsenko <yatsenko@meta.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260604150505.99129-2-leon.hwang@linux.dev>
 <3e8f405c266d6f15cc2ffeb3ffbe3674b19633c43048c1942e9a33db86c4c811@mail.kernel.org>
 <CAADnVQJHCwcFQG5FiejiyTHEFBRGrKqaGAfwVZJXANWuP9rJww@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQJHCwcFQG5FiejiyTHEFBRGrKqaGAfwVZJXANWuP9rJww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/6/26 00:39, Alexei Starovoitov wrote:
> On Thu, Jun 4, 2026 at 8:45 AM <bot+bpf-ci@kernel.org> wrote:
>>
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 625a4366fe6d..1007fb7c87e9 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -5400,10 +5400,11 @@ static int bpf_map_get_info_by_fd(struct file *file,
>>>  {
>>>       struct bpf_map_info __user *uinfo = u64_to_user_ptr(attr->info.info);
>>>       struct bpf_map_info info;
>>> -     u32 info_len = attr->info.info_len;
>>> +     u32 info_len = attr->info.info_len, len;
>>>       int err;
>>>
>>> -     err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
>>> +     len = offsetofend(struct bpf_map_info, hash_size);
>>> +     err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), len, info_len);
>>
>> Does this change break the ABI for existing deployed binaries? Previously,
>> expected_size was 104 (sizeof(info)). If an existing binary passes info_len
>> = 104 with uninitialized stack garbage in the 4-byte padding,
>> bpf_check_uarg_tail_zero() would see actual_size <= expected_size (104 <=
>> 104) and immediately return 0.
>>
>> By reducing expected_size to 100, actual_size > expected_size (104 > 100),
>> so bpf_check_uarg_tail_zero() will actively check the 4 padding bytes and
>> return -E2BIG if they contain garbage. This rejects previously working
>> applications.
>>
>> Additionally, does this actually protect against the stated future issue?
>> If a future kernel adds a new 4-byte field, the struct size stays 104, and
>> the new kernel's expected_size will be 104. At that point, those old buggy
>> binaries passing info_len = 104 will once again hit the fast path
>> (actual_size <= expected_size), skipping the check and allowing the
>> uninitialized padding to be consumed as the new field.
> 
> bot's concerns are valid.
> Let's add __u32 :32 to bpf_map_info at the same time.
> 
Will add it.

Thanks,
Leon

