Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58995225416
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 03:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778903511; cv=none; b=hyW1TbaTyByCg40RAdOYQcSDkUQT5JNCJ5ktoG7kNlF4jXnIjUl/NkD9hoSfYJbspebSrN99YWPKFv7+fWyPKtvuHFKqI8/QtrJl7acXXe3YujviVd8erRI5cb+TZXLqJox0WbBQ3LL/mMz8hw28q+PEBxNrYxVoqjGOns+YYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778903511; c=relaxed/simple;
	bh=OXwC77Eg8RYHOONBItTMZUqZfVOYz2LjHVNFU5kUjOc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XuvjMOAgCi/YfmdlA0o1t9dsNNpEBXTnhYAnzP3MLutEl+yVTr1rWqQ8GEtdHVEWWfiUWiW1Mlpujtc63vwrKzUTAR2KX9dOL0OuzIFki7Fbcn8eOPlvezxgPXldIZDQiHRtzoOpZxQBwlJmXiwFg9j9F0n1NvyDxm/qogKKSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/839noM; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/839noM"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so6329185e9.2
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 20:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778903509; x=1779508309; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXwC77Eg8RYHOONBItTMZUqZfVOYz2LjHVNFU5kUjOc=;
        b=W/839noMBIAIBxdD/DNIc6eSrl8Q94ogqvaleFNJHE+2F7ZJ0AD5phPrVH+6wudIsR
         zLxtFs5tcQ/3UAtvUT48uJr8LRI79BUnenkzpWNfcXRTQCTd8DLgfncxXxcSCi8I5hD7
         wVWyWHlVE0iqUsBG1yA7dNEX06mJ7eK5sAt6nOLy/o7HjfQ1aw2VE92ZMpdmvT1mlaFv
         zoGYskppF187vjg+/1pVxrbeJ9NXvtQJe7wSCW8TeCT9xv/PuOOqRs4+GKk9LzqmKOQ9
         sp50nlktql5zZBkcmX94FUxrYyLo+3UpI13SBsxZSXcEMDAM3t1aYDE5D+GSe1jG11tI
         RAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778903509; x=1779508309;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXwC77Eg8RYHOONBItTMZUqZfVOYz2LjHVNFU5kUjOc=;
        b=dA9TOXcCTsdxdrTebSgRJlF5vtHQbhQ4QFnGSm/EGj1lZOw+aB+qkK08O0Gb32CSB1
         f4ghuxT1P1vjNIbPEk0cz/JykK7PWLNm0VigbO/ApCXH0pKWjFda0WfQxA0LlNzLYVcO
         9euDUQfA5xqKz1VX6PQy4GoLA1LiuqrMconI7qjlCJNKvIzu0MlzHegBfwXTRmfsqSPf
         60HHKcW05Pr38lb13ZzhD7gF32AZRHRmdn7pPkKGQLgVNz5kEDz+vTQpnVeFLV7htgD3
         2ilHpUZrPoaDbaKnLmrzLGSwxefeiE4eD8kEjSDzSun9G6RWbfxkOB0PH7FuPsxpXOc5
         Mtrw==
X-Forwarded-Encrypted: i=1; AFNElJ8kxyP5yYQgOV24S13guZ4Qk0Du/wUHe+KvGdZkl66QxbBC7EHZfD8H78KoGfRETFCo530=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhRoqgYSVv5+5q5Yrsd/aSCHxxK1R0dYVO+t4F9VjgJqsy67+x
	+Hrk5ETho/etM6T5kSl/ENrBI8509rJCfpNWwXaqf4gPNeKTYMDT2Za8CdIY1eAP
X-Gm-Gg: Acq92OHG8QEFbnkpZDDK97gYIPKdDOhPZ29z5uEPw22sbhq2eeRzRPsVFdXamF2nllb
	ULwUDFE04+aIs8S2BfjAGBjST+yXVpV4sFJe+QwpxHMtpbQcQ81WsqAcNHsmTiiCiJh4+qBuayL
	a4iS1qQN1uhY9gA6WgmrLL+k5eFcR3oOAou1Ds2lGi6Z65DrnYcMigpizrWZSFdwMg+jqDBjOJg
	MoC6s8rSN6UTqkQgm+/TnTQ2XRmeT/+he+9cq//0mfCCt4LH+2ebIxix9ZDfPY7eOwexW+uHBip
	3LYcBiFEFdTPWSAnHI7iMfdRsj2i62ssaZl99MOU6qtZCQMUpwJ30x3RY8N6Ux9qu0j0CRlkgN0
	qTZrjmQP5wcHVZrza03RaSUPqwiCMVcZZn6lqJWNGUONX7/MfyxUeXEBESYLqLQmQ2VKR9mmEP2
	5xZBXt5zY0D83clE3+8OG7/3IIloqnOy+bVLQ2qqjJc35ir1hznX3RXKg+m18cDFbcgpbnvN3Ds
	yw8Bt6lyS3rTZXHUAnxSMaYPZGRNXyjVf+gEWSyjrBTEPFPJQrSx7Dx+Mr/uOk8lQ==
X-Received: by 2002:a05:600c:c087:b0:48d:c0a:3813 with SMTP id 5b1f17b1804b1-48fe60de6a7mr74767885e9.3.1778903508593;
        Fri, 15 May 2026 20:51:48 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7543asm27685025e9.28.2026.05.15.20.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 20:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 16 May 2026 05:51:47 +0200
Message-Id: <DIJSNXM0DL9L.1VDFFWJXB84PU@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>, "Martin KaFai Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 6/7] bpf,x86: Fix exception unwinding with
 outgoing stack arguments
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260515225035.821178-1-yonghong.song@linux.dev>
 <20260515225106.824804-1-yonghong.song@linux.dev>
In-Reply-To: <20260515225106.824804-1-yonghong.song@linux.dev>

On Sat May 16, 2026 at 12:51 AM CEST, Yonghong Song wrote:
> When a main program with exception_boundary has outgoing stack
> arguments (e.g. from calling subprogs with >5 args), bpf_throw() fails
> to correctly restore callee-saved registers, causing a kernel crash.
>
> The x86 JIT allocates the outgoing stack arg area below the
> callee-saved registers via 'sub rsp, outgoing_rsp' in the prologue.
> When bpf_throw() unwinds, it captures the main program's sp (which
> includes this outgoing area) and passes it to the exception callback.
> The callback gets rsp and rbp, followed by pop_callee_regs, but rsp
> points into the outgoing arg area rather than the callee-saved
> registers, so the pops restore garbage values. Returning to the
> kernel with corrupted callee-saved registers causes a crash.
>
> Fix this by passing the main program's outgoing_rsp as the 4th
> argument to the exception callback. The callback adjusts rsp with
> 'add rsp, rcx' before popping callee-saved registers, correctly
> skipping the outgoing arg area. When outgoing_rsp is 0 (the common
> case), this is a no-op.
>
> Fixes: 324c3ca6eed6 ("bpf,x86: Implement JIT support for stack arguments"=
)
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Do we need any adjustment for arm64?

For this patch:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
