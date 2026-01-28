Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0832F75B
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626174; cv=pass; b=KnI0bFlLnXKMVgd/EY5wGabpMUjLBeA267ZtkUxoKF1jG4207W6uQs23l9N1NKEbRo4j40MAwUXEOaaUwSK5QnZmbk7DzGvVGdQL610J8hY+K9YyRPv4e97BlC9mjVkseGmX2Et269f+R64RZPSxZL8JQm0+phzC/YLDHVhZN5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626174; c=relaxed/simple;
	bh=jjV5Od43uItyRHpvZGzXOvduel10uHKTWqh7dEC2oIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7b6GrpoOTB1FNVN3yP1lbOOAQ16OBiigjVWuv1zNDtqlCsRYEJoO2rtSECIxNf9z4KfoVNmDwHpMpHDK3BuU9iMXe5fU6QyqzG8F8YhqgUNci272ZuHh9FUsYIGfWAWn0410IXxQyiMw/c6bbHorsBtlzFtB/+KS9R1qK+Gg/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVNj3YeA; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVNj3YeA"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso1644245e9.2
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 10:49:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769626171; cv=none;
        d=google.com; s=arc-20240605;
        b=QtdKsW3Z4JVXMFNixQPj8s+BiGb42Wqm9AsbNyc0QPqMwUG05BAkqEN6/bhcp/0mLk
         /se34Vt/+8yhVMm45OkI1CdJUHaxYAqkbWN4CWoocN2eq0h8NNHFGLOjILHcGPjj2UHA
         4CzeZNwY9QCld/mu3aWoXAWWl562C64TyOHVWnUm/SW+f16LKb3nvaLA2mGsv+b0W5HR
         TJUpVfOwfI+X4+v33V0rxHiIv0lEKN1fXeqo29o01cSxK34Pg2M32EmTKCvX+5SsxZSb
         aySOSeJ3QIb3KkU6PGWGqZLJhscXLjrTgFSxh6631gUpdd+V2nt6wkodNDiKWyYuv/FV
         ecMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qGOxMm1K5WN+JT4uUn9nzJwvV/NU3i9BH4DGHjnCuXY=;
        fh=uSiSyFmSBNUwBrYKzxAIcCAM0R3LQzhce331I3X8N70=;
        b=Mtzw9h5p3y6jwfMqIqQjOFXGA4iWSEv26QYvwKLCKWgvkoIdX9yT0pDiMc4RywoyzE
         yBD+zPlSrGw/P8XdMtjF3OH8nE55qtnE8fs2GMEnGXBIV3xFxKN12MGe4D8qDQLoO2w6
         2YKlbJgFAkfrlMQLQTPFGfTX2viVI1Z3RN5SK64F0r/MPU25dItUEizUwk3EvyoTITbg
         TjpffVV31H4d1S/a1AjKddBOzxRJBUnmU2mDTqXZ3PNpMx93EXkqJQLe307KR7ZivlIm
         uPpHji9sc9OSyc5Kw7kexIH/ULTrDttQa2YyWYyqEAsmx+j1MdfhTV9buImbC/EsJjI7
         rVXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769626171; x=1770230971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGOxMm1K5WN+JT4uUn9nzJwvV/NU3i9BH4DGHjnCuXY=;
        b=nVNj3YeAP5cQf8s0J9mauGHzaGgztasziWZGIui/GAkpD7f2xBWfEyF6K0/i6tUe+m
         cqt9OlAQXhWmlaL2swKiI/4mVFtOKoGXbY39NLS3qUBFBqoP87kXvh1DraTSbw5cgyKi
         wiN2Vpmx3CvcC98ogwiTCFihJxl9+Pn0vXWAxQNq6HlhpL1KJ9l2dkiFyBEEroVNlD+G
         yZR9i/56Bu0tFskBO3O22upn3/vky5spNRiAia+pi31HjyBg20mzoCzCQwBTVqByfupN
         9GdR1+WsdqIsT634iRSYghrIpKBd0z1DDgjq2R6jR3pZ4kObBnx7STokE12gnZiN2xN9
         1/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626171; x=1770230971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qGOxMm1K5WN+JT4uUn9nzJwvV/NU3i9BH4DGHjnCuXY=;
        b=AL6dQxwuFZoK94m7mjxJ4dzNUJXmAci7KuQBuDvWFLLFzzgA4Bz3CYzhjiaqGj22O7
         oI+OQ5vL+NkXjE6+kxX4V1HhEgKpma49bkXlLoJ1JjfHsUOgQP2gyH6mmYWIXnxWMTu5
         M67xFBjM5V4QNgq+vxt3jUXAD3QFjbuM0BOu8WaCD8O65oLUqxlIQyXDBx7ZGpXIAa7b
         mFAYFCb+u/hBlkitTZ4Wn34rszlXW8hyuJdN/0YwDO45+j/UiCDJ+dNsc5dCzPHoQXb6
         dJlHL7WSbAQLxmWonXdA1h75zvOOJx/mb3B9aP5/MXu4r/YBJEusdkIZzIFpK7eXf7lx
         DoTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZQjkiiNMrd0nmMggH5Kg5hkwcKjrmitSbn+4LdL0hT5zoD74sd0vH4qeSP137FvGZtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ASqe/1TMlx7DtLoT8EXLVG8ZBbQUnaPl1ye1T3bcScoIWm01
	EIRIl27XznsxQq6fHN3JI8L8ec9xyQ2Er7cE0Yc3Uc37eGJxBQzc7gG+Q7i2CW6HyfrXH5zD2xE
	7OyXG5oAUX325WC7TaUHwu1FCUrjz2IE=
X-Gm-Gg: AZuq6aKymoatDqWdJ8Zbgd44SjVNAxt+fm0q0pIL8FCtgSJoyEyw3g/pEWabRymANNi
	yJS07IutKFgHT9+0Fm5nMAK1sHSus2jzUw88tkuogWtinx0SLMXCHIULwLk+ZsPWpCbPbC0ixRq
	ng5aH27rn49E15bDOfCr+LRkRMlfeokJXq8qcAr6q0CRtRRYcZomCSV9vR+8eXCmiitVm8LRlUw
	uKHRkokFAhzZ4YLR1jWXvqKx/3tNvHkDi3QB1DZYFa/NBxbfCaveCvQN7UhKm7OJhxX6qnl9GKB
	7DNuzlPcg/SqvQmPuUbgO7dlZyXttiiYJ1RmKRs03ZzXI2gt8F6tKZMrVl4VvWTfKBejnC8sE8u
	xFTrrTe6t/SHd+w==
X-Received: by 2002:a05:600c:4f82:b0:480:4d39:84b3 with SMTP id
 5b1f17b1804b1-48069bfabe7mr87977985e9.6.1769626170838; Wed, 28 Jan 2026
 10:49:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128150112.8873-2-leon.hwang@linux.dev> <e64c4137e7f262e6fdab272e8ee44c8a129a36eb6d0186914375d6ba20d88474@mail.kernel.org>
 <65231eeb-1f00-4af2-9234-a290ea3f6585@meta.com> <a10afa70-29b7-48ab-b241-8b0f602abe2f@linux.dev>
In-Reply-To: <a10afa70-29b7-48ab-b241-8b0f602abe2f@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Jan 2026 10:49:19 -0800
X-Gm-Features: AZwV_Qikusk2Q6YhJBvTgmuieIgLLJz7FiVhBc9lpkAd7bZar_-wkLjd4ZlAf6c
Message-ID: <CAADnVQJV=e2VgQzkpsUQwexhaVZMs7uXHCe1Fa6VwbVNUMPghA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add bpf_arch_supports_fsession()
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Chris Mason <clm@meta.com>, bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 9:34=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 1/28/26 7:35 AM, Chris Mason wrote:
> >
> >
> > On 1/28/26 10:26 AM, bot+bpf-ci@kernel.org wrote:
> >>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.=
c
> >>> index 5a075e06cf..070ba80e39 100644
> >>> --- a/arch/x86/net/bpf_jit_comp.c
> >>> +++ b/arch/x86/net/bpf_jit_comp.c
> >>> @@ -4112,3 +4112,8 @@ bool bpf_jit_supports_timed_may_goto(void)
> >>>  {
> >>>     return true;
> >>>  }
> >>> +
> >>> +bool bpf_jit_supports_fsession(void)
> >>        ^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> This is the actual function name in the code.
> >
> > Ihor, I think the script parsing review-inline.txt chopped off the
> > part of the review where AI was complaining about the commit message?
>
> This is the email body pre-processing in KPD, yes.
>
> At some point we decided to remove the commit message before sending
> an email, but now that AI reviews the messages too, I think we should
> just send the generated review-inline.txt as is.
>
> Alexei, wdyt?

I think KPD is only supposed to trim the header until 'diff ..' line.
In this case there is no 'diff', so I'm not sure why it trimmed so much.

commit sha...
Author: ...

are useless in email reply, so we should still trim them.
