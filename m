Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597FE3D0A3
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932695; cv=none; b=OnqSNqpVjx6FsYgHh+H4doR3TEOjOZinDlwXaLT2W/OMLhrF6h0ei0HyaTgn0F58EjV33sG4zDWFmAyOamt5HQMFForCiQnnavbrb5egfmiokfnzU7b52d9Iv98Ryvo89HMl8FBuwstkvikTwYEmaoSWzQtFja6t29nLUKJ0iJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932695; c=relaxed/simple;
	bh=49RUetNo5bXg0nbJcebvc4jIa4RPguuY/I/4PVEIKtM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzqXXeQwUTjgLHvvl968ZGTfhX0B6wq1lR12MQ89U+lCm7TePJ7KWiMbLZFcYjJMGtO5Qmff8HFEmdUdEWgGFKw5axuX0zuQP3nAfkl9ShNydIYhLAKs633JT7LAWQcXT0Sa96PIoNPfs7hRX4yMNR7OXnbNG8vjQC7nETg6mU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlTyPfVR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlTyPfVR"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46a7208eedso556387566b.0
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 04:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710932691; x=1711537491; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7XaVC9NsrGTzZGKwGEg6cxOTk6vEtF8q2TYV8MAccUI=;
        b=KlTyPfVRfMFopq1KUvfQgkku3QX5rT9431D0oUV+s8bzmfqbUqHjt4tdvEBVx+iy8K
         C0kyeKhT9Rh4tldAgBRlBqxER5ZI+MulDIa0eIeOLJLV1p1pdwCsJyejzavasrO0xf8E
         I5oNkZEbX/EEZk9ptH8NueHrG2/YOD6nqWZ9Z8lOwawQ5ytwcYyQCE5JArmZXUo1jh2c
         NnB5C6EYb/ha799zmTw1VppBGZbog23G9iKARUuzDn0h27ZhwjPS0LKXGy2Tsnlzobr3
         /oPQ7pNCsdWY/6DA8ResRwgUHrBk1cH/VKwLbohIpnncrHBMtDHxzGCjFZrQQsKPhu6H
         kOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710932691; x=1711537491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XaVC9NsrGTzZGKwGEg6cxOTk6vEtF8q2TYV8MAccUI=;
        b=EnBQN9oSagUptak4wp3QEKUr6MoZtosPmqUw0GGAGSVrAiMihETMmNZwI8i9q8PyG2
         E+NZYwSSe7yvvIhG2I7UJJm97i5ZKQeunwHYURFMxiSwpauyFX3PbR1/igVbhNqYZhyz
         Q5/TWuSw8JSTCblaMTIXeQjqdJWNV+URGDV+BswnAnIVZqqlKmW5AfnIJpo6yZeii1v7
         NYgu2yuQCSJQpwSvdfaEJc9jMh1ndas0emATPHthQvWzqa8WVHqE9OKAUxuRIPoJd+DG
         /thk0i//W0EfmQFtMDTSpdyKhrr5HBtJgB74ZLuormCs5lJOMfWGS0zB2/OAKBkyBG5Y
         ubaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcf1DUaAnZN6YOiWXUNSeTwMWDcVwKzn1ly8S/5R/UZ0206gsNjtmqPJ03tWQsjjvlMHj7xQ9YB5kz+ORHAgsIvMIt
X-Gm-Message-State: AOJu0YzifCn9J0EA+AToJvuzT9FBiG8gtI2wrKkiLOjfvbp3sdMqFxGe
	m999Y45LLo1E7mqG8AIGYIiBJX2sN9JMjG9OiquMHOOkqLj2laTc
X-Google-Smtp-Source: AGHT+IGtomrhfb3hp4n/SQkDF8Rjb7hnBqxy4DcRTP4QKwHvs8DDn4tPQA7w8vzUwIauwyBfCcb5Ag==
X-Received: by 2002:a17:906:ae56:b0:a46:bbc9:a8c7 with SMTP id lf22-20020a170906ae5600b00a46bbc9a8c7mr5430497ejb.71.1710932691252;
        Wed, 20 Mar 2024 04:04:51 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709064ad700b00a4479997b97sm7175584ejt.66.2024.03.20.04.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 04:04:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Mar 2024 12:04:48 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
Message-ID: <ZfrC0NZWxmWBuUIe@krava>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
 <ZfnoK8aQDJMgOYfY@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfnoK8aQDJMgOYfY@krava>

On Tue, Mar 19, 2024 at 08:31:55PM +0100, Jiri Olsa wrote:
> On Tue, Mar 19, 2024 at 12:08:35PM +0100, Jiri Olsa wrote:
> > On Tue, Mar 19, 2024 at 11:25:24AM +0100, Oleg Nesterov wrote:
> > > Obviously not for inclusion yet ;) untested, lacks the comments, and I am not
> > > sure it makes sense.
> > > 
> > > But I am wondering if this change can speedup uretprobes a bit more. Any chance
> > > you can test it?
> > > 
> > > With 1/3 sys_uretprobe() changes regs->r11/cx, this is correct but implies iret.
> > > See the /* SYSRET requires RCX == RIP and R11 == EFLAGS */ code in do_syscall_64().
> > 
> > nice idea, looks like sysexit should be faster
> > 
> > > 
> > > With this patch uretprobe_syscall_entry restores rcx/r11 itself and does retq,
> > > sys_uretprobe() needs to hijack regs->ip after uprobe_handle_trampoline() to
> > > make it possible.
> > > 
> > > Comments?
> > > 
> > > Oleg.
> > > ---
> > > 
> > > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > > index 069371e86180..b99f1d80a8c8 100644
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -319,6 +319,9 @@ asm (
> > >  	"pushq %r11\n"
> > >  	"movq $462, %rax\n"
> > >  	"syscall\n"
> > > +	"popq %r11\n"
> > > +	"popq %rcx\n"
> > > +	"retq\n"
> > 
> > using rax space on stack for return pointer, cool :)
> > 
> > I'll run the test with this change
> 
> I got bigger speed up on intel, amd stays the same (I'll double check that)

yes, I'm getting no speed up on AMD, but Intel's great

Oleg,
are you ok if I squash the patches together or you
want to send it separately?

jirka


> 
> current:
>   base           :   16.133 ± 0.035M/s
>   uprobe-nop     :    3.003 ± 0.002M/s
>   uprobe-push    :    2.829 ± 0.001M/s
>   uprobe-ret     :    1.101 ± 0.001M/s
>   uretprobe-nop  :    1.485 ± 0.001M/s
>   uretprobe-push :    1.447 ± 0.000M/s
>   uretprobe-ret  :    0.812 ± 0.000M/s
> 
> fix:
>   base           :   16.522 ± 0.103M/s
>   uprobe-nop     :    2.920 ± 0.034M/s
>   uprobe-push    :    2.749 ± 0.047M/s
>   uprobe-ret     :    1.094 ± 0.003M/s
>   uretprobe-nop  :    2.004 ± 0.006M/s  < ~34% speed up
>   uretprobe-push :    1.940 ± 0.003M/s  < ~34% speed up
>   uretprobe-ret  :    0.921 ± 0.050M/s  < ~13% speed up
> 
> original fix:
>   base           :   15.704 ± 0.076M/s
>   uprobe-nop     :    2.841 ± 0.008M/s
>   uprobe-push    :    2.666 ± 0.029M/s
>   uprobe-ret     :    1.037 ± 0.008M/s
>   uretprobe-nop  :    1.718 ± 0.010M/s  < ~25% speed up
>   uretprobe-push :    1.658 ± 0.008M/s  < ~23% speed up
>   uretprobe-ret  :    0.853 ± 0.004M/s  < ~14% speed up
> 
> 
> jirka
