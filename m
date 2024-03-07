Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AD335C7
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709852575; cv=none; b=JcI1eQS2BobCeDjYm/5T3On/+S9vt7G4KJ8BbU0r9j1SuTW2adxaglxxNXuPxxotTIiHfiAQV6xiM4520Qe881hjvhn5I9vaDdH3extpbcjfwTrFLQUbwN2EpZjFWuxSjtcf8pgpIahzv2u5u4xlshpBTXjTS7/gQQpnnvxCzTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709852575; c=relaxed/simple;
	bh=9KKhtwnASWRMx1q4RYJmtGiLzk9MB788R4Lfv3Kb3WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXwoYZqG8Ua0KTGpvCXQ0BLvq8a1JVtBIvrbYvRpWS0+Sr9RAGNQmYArvKhMxG5QyloNCuH8D6lRCdh9r86US4BerYR4ppNxK4ngqwmdOJ+b0Rvecv3vB9+o7BZ2+1Twx3xH40To+Bcr7PQV43wczTScFxVHMwgBsRuDwm0pxTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFUruNR9; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFUruNR9"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6098bf69909so13427717b3.1
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 15:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709852573; x=1710457373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tt7DerqK6vSXKH3qsw0FdsRP/olVGmGsqI8wpkP34/c=;
        b=HFUruNR9+PD+bAjOMLwia8iZg9Y5aTje5ND46xuUrZdNcfrSAYThTx0QcIVBK5UQRO
         xlBu4A45qANn/2hgO44p905zBwSyRnVV4TaqA82byIW0cQErIHhahUwROcx4FTq3b0Y/
         kAsbqooy7AJF4mL/g10bUfALwtm74Cr9x2CGVdJtTWH8rhNa4fBlme7+tyBlUEbsU5cW
         jeqFjlPo7M1WCTEHWPRTk3mRzWVrk+bjZ/gLnTRrafDvOybvvpaZ4kjZ/9e6ZQuuv5rz
         x6BtjbCP5rEQBKy4tnuHSBKtIbxzvcMwWRN9+MoobB6H+2fQcwi5eB7XlOiaaNw28c0w
         BDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709852573; x=1710457373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tt7DerqK6vSXKH3qsw0FdsRP/olVGmGsqI8wpkP34/c=;
        b=WR3vEHON5h6DfGVtOIrVOhs6iohmNjcKXTGWqRFOZL3RF2KAypReXFB6ikANhBoFVL
         ZS7tsrG3rrmYapS08FkR1cj2NKvmC9faQvO080zhQUohqj3yhHRIaOG4kUOGetu6KksS
         R4Fh/PKGyGBTErS9VQv8wSXVH2ORJmznEl5YxL1qKLTXkMKHqa05fRf1Uj2uR5oU1B1w
         9xvqIaz1qNG+oqqNwwrUMosQxv11+N/mQuTQmFfhNmUkmG4Y8fCb9slx7R1QWnvwyZIu
         eUgh4Rb3PrXAEUIbd7cRL8o8RJLy2gkOK0iNUXQpn3MM0/XV2poYC6nkCYpeT1t6IaeC
         pJ/g==
X-Gm-Message-State: AOJu0YwUvz7TiQiQMV6R4ZWKri++sRPC12K/lZRmTnzHRi3lFdM/O0Yf
	sySNVGH8LsGQSN0fGXNCmzQP1ixFNDLoXNyBXXeIQSxTBpS1p+X1
X-Google-Smtp-Source: AGHT+IFojAoWkaB+zxeR+2JeMuO9FbQgxYwMeJSo/oeTxvMuEHJjsizJJciPOf3SEVqbosQH2wOD6w==
X-Received: by 2002:a81:840f:0:b0:609:3a5c:b2be with SMTP id u15-20020a81840f000000b006093a5cb2bemr1968749ywf.24.1709852573180;
        Thu, 07 Mar 2024 15:02:53 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:3e27:94b7:4919:8737? ([2600:1700:6cf8:1240:3e27:94b7:4919:8737])
        by smtp.gmail.com with ESMTPSA id dg8-20020a05690c0fc800b00607f86fa184sm4332614ywb.99.2024.03.07.15.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 15:02:52 -0800 (PST)
Message-ID: <412c987b-b1c4-4761-83e4-d46c78a255be@gmail.com>
Date: Thu, 7 Mar 2024 15:02:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
To: Song Liu <song@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 lsf-pc@lists.linux-foundation.org,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Oleg Nesterov <oleg@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <ZeCXHKJ--iYYbmLj@krava>
 <23f9790d-4ab1-4edb-9262-6f982413b3e9@gmail.com> <ZedT8S-GjNOry5LZ@krava>
 <CAPhsuW5_6vkL58Efm3qL9G9W+7i=XVicoLXT6_G+T7TLx=zQJg@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAPhsuW5_6vkL58Efm3qL9G9W+7i=XVicoLXT6_G+T7TLx=zQJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/5/24 15:53, Song Liu wrote:
> On Tue, Mar 5, 2024 at 9:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>
>> On Fri, Mar 01, 2024 at 11:39:03AM -0800, Kui-Feng Lee wrote:
>>>
>>>
>>>
>>> On 2/29/24 06:39, Jiri Olsa wrote:
>>>> One of uprobe pain points is having slow execution that involves
>>>> two traps in worst case scenario or single trap if the original
>>>> instruction can be emulated. For return uprobes there's one extra
>>>> trap on top of that.
>>>>
>>>> My current idea on how to make this faster is to follow the optimized
>>>> kprobes and replace the normal uprobe trap instruction with jump to
>>>> user space trampoline that:
>>>>
>>>>     - executes syscall to call uprobe consumers callbacks
>>>>     - executes original instructions
>>>>     - jumps back to continue with the original code
>>>>
>>>> There are of course corner cases where above will have trouble or
>>>> won't work completely, like:
>>>>
>>>>     - executing original instructions in the trampoline is tricky wrt
>>>>       rip relative addressing
>>>>
>>>>     - some instructions we can't move to trampoline at all
>>>>
>>>>     - the uprobe address is on page boundary so the jump instruction to
>>>>       trampoline would span across 2 pages, hence the page replace won't
>>>>       be atomic, which might cause issues
>>>>
>>>>     - ... ? many others I'm sure
>>>>
>>>> Still with all the limitations I think we could be able to speed up
>>>> some amount of the uprobes, which seems worth doing.
>>>
>>> Just a random idea related to this.
>>> Could we also run jit code of bpf programs in the user space to collect
>>> information instead of going back to the kernel every time?
> 
> I was thinking about a similar idea. I guess these user space BPF
> programs will have limited features that we can probably use them
> update bpf maps. For this limited scope, we still need bpf_arena.
> Otherwise, the user space bpf program will need to update the bpf
> maps with sys_bpf(), which adds the same overhead as triggering

That is true. However, even without bpf_arena, it still works with
some workarounds without going through sys_bpf().

> the program with a syscall.
> 
>>
>> sorry for late reply, do you mean like ubpf? the scope of this change
>> is to speed up the generic uprobe, ebpf is just one of the consumers
> 
> I guess this means we need a new syscall?
> 
> Thanks,
> Song
