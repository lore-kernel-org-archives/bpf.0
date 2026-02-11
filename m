Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E033C528
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853612; cv=none; b=ueW53oWNyp9AplGkaNEWiagDfg7cuELPoyFAPz6ue7+srhwUkq1KYmeT4BwBpbL5gMh4xJrOW0IKjT3ahE2sx7iRRBIihSxR4Zv89OQnbUsw9uXY6drhZGCQSL6RX3QVbl2xfOHQZbFwQHwq3npUkURRogB60F/24sPmzGXZXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853612; c=relaxed/simple;
	bh=uKFp3S4VhPQDRDIqG7t6XPgMhT7MK902dEW6crTPgKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXACZCaEBRSMa/CGgbdBaA33gUF1pAsWs82aFVQyYoI7tA0arE0FaKFufi55AS6H6HmlPA+5G/HNZPFKdM5WgpXq0jC5N1tucHDgDvR4h5NKP1w6x2GWQrCZDS/O7ZQdQ42vPIPFAKoiehgN0XaV0rsPjlgpLblNaKXvqdn5HCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxXbxR5X; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxXbxR5X"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so109771095e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 15:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770853609; x=1771458409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SNiJ8/0ZZ/fEThLSok06MI/kbgOPt4mcJz11Wg17Xpk=;
        b=DxXbxR5XxPMx8fMfdnEMfsbkuxQwxfBxTwdXNy9Vw/1cXC5bPoaMWVPuEUgCRR6CCb
         K+VE4BLTTYwUNcDPwM6iZDqkzP8c10dzo8T0Ck+j7iKc2Y/MMeR517I6aRIFQESQ1yNH
         1h0p4K4Zio6A1G3FLR31YzvbUO5eipoXXsgxkd71bW1WbWzJuHB96yKXIm8RThCHEtiu
         iYo+YMrgeNuZTsrV/2p7oFSC9Ep5eTQQ5sOJfjXaRZSLJ898HU1Opuc2QJje/hlYb9+O
         KXVPrnVKlx49q+CM07YlJ4VM9QEN9CcEzgCXItJpFrLL5OwSLfnH+CGFBep4ttLUMo7C
         zbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770853609; x=1771458409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNiJ8/0ZZ/fEThLSok06MI/kbgOPt4mcJz11Wg17Xpk=;
        b=BX6eN+wAgoGYMRhApWmL+ifaZVvnTIPaFgM84bN60wkQd26x4/jkLABkZdSYxuQim8
         W/vHzzFJMlIp/xB/ebEK1/6HFlmDuNbrdZg6lLx3bB+AcoAPQpIj/I486yV6GQ3yGTz3
         X/378UTWpQrG8pU0OnBM+vVzSUSW/e+rukiMqadSpDHvcELE4dDy3kNIQmpX+Ol12quM
         wHa2tP6ru7Nk09e7fxglDc6y+uFxDbHAKA19YhmN1+EXpFRsggrxu4E9ClYghH4+K8lG
         JvZL048DYh4Ax3fHlLs8RtvbscYAwVxZZTX0JcVAZTekgA78AHh+BmKa1moe+n4H55TT
         59Yw==
X-Gm-Message-State: AOJu0YzbuaXy7aKeDZwqeQ/6l+quXAt4+BKhOto8lxiIp/ggxq9NQ1jP
	KVVYbFCYhMcuIRU2WuMpfy3jxLh2zwX42xJVZ5z6bqiwjg5sMYwaJLfN
X-Gm-Gg: AZuq6aKdhu8ys05c0pVVs7K0BmHvyrutBxBFmDeb2bzZoJIptbdP+EuudvJ+sn7mpw4
	TufeTCn8pI2iRuBxtB9Jb0dgIxk2VgGgzHGCeTI/c8H0P3AB51GZX2mYLJDMN4/qzUhbtIKdHyx
	XJGXKbCTwsUZ0G15hsgEiR4ttvYVjIM4xdRY8N2zQJ5PJuxXhG2P1jJt3F0/Pdw2zNSeW8/GOVz
	CMgKYWv7cnqjD/n9mToDotvIgU3KllYcjg3Ah63V4HlwuAGOVSsWXgFWhgZr7CA82vlMnXWqOXA
	WKm8HmSZZluRvteSVodZ7XadnCscbzJaiI+UOEUH7UuMpKyXmmdV7gkIgV5xkAw6tPNM9MCJQd/
	J7p2+buBPEtx/0bUd8oUvlDxh1JiBzKpYVF6dInWOUj+/u57nOwpT1mWIVn+m39jL02R0ntbTBD
	B7NGo5YjS6Q3Vsx95iTt50SDR/x7Ws3j1LzOWpGs3D0zcgY/pNn00Ga7ufhqtwmNbVRhq5/Lc5I
	D/n9bndW1jV5Ng=
X-Received: by 2002:a05:600c:19c6:b0:480:6941:d38c with SMTP id 5b1f17b1804b1-483657159c9mr10588785e9.29.1770853608926;
        Wed, 11 Feb 2026 15:46:48 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836131d4e8sm17108345e9.31.2026.02.11.15.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 15:46:48 -0800 (PST)
Message-ID: <15f98c92-99e0-41d0-ac9f-4fe4f1065565@gmail.com>
Date: Wed, 11 Feb 2026 23:46:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 2/2] bpf: Use kmalloc_nolock for
 bpf_task_work_ctx allocation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20260211163927.665785-1-mykyta.yatsenko5@gmail.com>
 <20260211163927.665785-3-mykyta.yatsenko5@gmail.com>
 <CAEf4BzYZUnansvKncz=8MFYmjdodu2zd0ZPWskkq45otpqv0hw@mail.gmail.com>
 <CAADnVQ+6-82Pe9Q9zLAq2rbNFrVVp=zBRCKHErWVjXduVnt0wQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQ+6-82Pe9Q9zLAq2rbNFrVVp=zBRCKHErWVjXduVnt0wQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/11/26 21:37, Alexei Starovoitov wrote:
> On Wed, Feb 11, 2026 at 1:28 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Wed, Feb 11, 2026 at 8:40 AM Mykyta Yatsenko
>> <mykyta.yatsenko5@gmail.com> wrote:
>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>
>>> Replace bpf_mem_alloc/bpf_mem_free with kmalloc_nolock/kfree_nolock for
>>> allocating and freeing bpf_task_work_ctx. Now that kmalloc can be used
>>> from NMI context, it is the right generic mechanism for memory allocation
>>> in BPF kfuncs, even in restricted contexts like tracing programs.
>>>
>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>> ---
>>>   kernel/bpf/helpers.c | 9 +++------
>>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>> LGTM
>>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>
>> BTW, file dynptr is also still using bpf_mem_free, consider changing
>> that to kmallock_nolock as a follow up as well, please (and I guess in
>> general we should do an audit pass on what are the other bpf_mem_alloc
>> places that should be converted, but Alexei is a more authoritative on
>> what are the remaining constraints that would prevent some
>> functionality to be switched to kmallock_nolock).
> After reading 2nd patch I realized what 1st one is for.
> Let's first wait for sheaves and Harry's follow up to land:
> https://lore.kernel.org/all/20260206093410.160622-1-harry.yoo@oracle.com/
>
> then we don't need patches 1 and 2 and can just use
> kmalloc_nolock() to allocate task_work_ctx
> and kfree_rcu() to free it with defer to irq_work when irqs disabled.
> kfree_rcu_nolock() will hopefully be introduced in 7.1
> then we can clean it up even further.
Got it, thanks!

