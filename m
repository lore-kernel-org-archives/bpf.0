Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C874B25B0BD
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848310; cv=none; b=pb9wA88MPhotEnFZ5/hTQIFi1gvIfDMHFM8BmWHauuwCQScrtPEOK0UdTkcsJUqp2eLBrfHmDu0DCi5P4qI291bOCwnhiYq2XJGi8DjlCURFvIEV6kS1tzM0EDWQPrUobpEO4qNFOAmnck/zbOBVh5jHQvJPZHZLGXZ+SsFgxjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848310; c=relaxed/simple;
	bh=Gq1l/dOJCnw13gEUFF3MujTjV34THBAh60WMjZhwMHU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1usc/j5ZVhQPmQ0QsvFI17VgC5wLH8QppH0B5AHxMV9jyzBRLJUh5JqE530F86SFDDKbVdll4UH4a2HWgeYYyWRTTkdEe8ewXKRdiS5cf5tHOCtwb+S1Z4rIXmM2dvsxYw7DvHS0QwjvkDWuaqxK6Z8ZtvJYmcyJnAKIDg5r8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnhRcxWC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnhRcxWC"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so107233065e9.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848307; x=1779453107; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y5r3xuLgzQez/AFiVWNQEpff7q5PfulknpJ5ImJJtT0=;
        b=KnhRcxWC+J8fNV3jrEt+Two+RmxXP/b0T0IidaEh2NBzWeNdyKGcRh/DEgTc7Evn6A
         zuQZF5DOLrgF6Evr8ylMiTQTkHKRdjy5oTaVIlHI2VF8jOlZpDELug3befBk6X9wMl+B
         cpDT0TgJnIA0I4Q3zwOZjaV70RQC2O4pamXOZrGwdzBhBnCYYKG/EHdIp5tcM6cpkVrq
         iGLUbE/7/IXiN/4a4cRk1M4cehnANE7W1mvIQaEXh7qbaoGcAaXQXfWUrSq17vMwqFbH
         1h+YHyFraR+4+/JxZpHbvFkJSjld/hWNEjbkzMRRtggN8cWMxh97YPFpfgjDvWabtTTK
         WrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848307; x=1779453107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5r3xuLgzQez/AFiVWNQEpff7q5PfulknpJ5ImJJtT0=;
        b=E3vBKw5Pj7l5X8SIDSxbJX48UnPdBsmCSu0w6sUZQYQ06LWfshvBv4tQY9UucNdguH
         8KGa4JUj6Jo/IO8iEL64j2eTAcvCDSe1Gk1XQaBSONsi/h8jjtH9kEGHs8nPpB5L4Kb4
         /yGJrBj19EmLXHs9BWOj7sW57m77NPz4O/+twdvd1axTj/a+xcJSf2qkUTOsTJ9nT3d3
         gsCIB2vYihqk6x5FQjmbBt5VWj8pXGaG1ai6yg7Vbb78u35CNshqaKYAIMtelVbbbCKz
         xPGRPlbToi0em8e44uut/2HRIBaTvJ54qBBn/Qw2AL9qw/eypUa9bQ3qEHSs3Y7yKb01
         3/1A==
X-Forwarded-Encrypted: i=1; AFNElJ9oVVb1+G4uKV1HH26wFB0Mx2SF7LxEIrEWx/Jlwyx2hkj9z2dRqdY5dOEm4+tQ7RG4c5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ7pp52RI6czTVAreHnYkVPAAUFPmUv7ubG3qkIIs0bCaj+DBh
	Khp3L22x55DUPhFgIJjvt6a1qUUw68ed+lW7YYgHVxQX9JhcDMY3OQlk
X-Gm-Gg: Acq92OGGClI8is10jVE1c2NV6XiBK1iP56SxdaK4+FS7WQGcAAX5cJfCz4UzpRLbqqu
	h5rxEPUwz0gpMnIhYSO8ryZD34Z4uKoS0nklG3secEBHVfol/wzOzw2EBMZeLW2nmkMP5uN9CY3
	9ri4BnoAQ2998Kk491DixppoB+AtLn8VxuO2BmYvbRFx0zvVQoObDFOLPdzCFgQfc6btW9AIEet
	CZ1mtQuXs8qCN1XQ9H4PIAKtiMu7N/9PxBZwAT0uLgP0BbOGlr9NVs1mP+L7v2XcCCh3tAYrvUH
	pdCr1lE0k9CM+AjLAtse0E7/lyZ4HwnUnXABW4isfjH3kCqqYDKuTGdtkujIJT9BIxeC+/EAjRT
	1zPjk30sa+dRSjMjCGNhspwCvK8k8Hi6iFWYbQtuCo1bIMghiI0PJo8o8uqpcEIrFJXfZZX5d8e
	g5lHWmIPGf9w2Tv28=
X-Received: by 2002:a05:600c:3f1b:b0:489:1c5f:3a9e with SMTP id 5b1f17b1804b1-48fe60e7fa1mr56068155e9.13.1778848307045;
        Fri, 15 May 2026 05:31:47 -0700 (PDT)
Received: from krava ([2a00:102a:4039:3341:dfc:8dc0:b9c5:81b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5376812sm60960175e9.11.2026.05.15.05.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:31:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 May 2026 14:31:44 +0200
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
Message-ID: <agcSMMhucO_ZzCqP@krava>
References: <20260514135342.22130-1-jolsa@kernel.org>
 <20260514135342.22130-2-jolsa@kernel.org>
 <2qkbqj7c2bi7li4crheoarasvokrtxbb7ikofdv5zvsvgww5lx@bjd73tm2prfj>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2qkbqj7c2bi7li4crheoarasvokrtxbb7ikofdv5zvsvgww5lx@bjd73tm2prfj>

On Thu, May 14, 2026 at 06:54:37PM +0200, Jakub Sitnicki wrote:
> On Thu, May 14, 2026 at 03:53:36PM +0200, Jiri Olsa wrote:
> > Andrii reported an issue with optimized uprobes [1] that can clobber
> > redzone area with call instruction storing return address on stack
> > where user code may keep temporary data without adjusting rsp.
> > 
> > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > instruction, so we can squeeze another instruction to escape the
> > redzone area before doing the call, like:
> > 
> >   lea -0x80(%rsp), %rsp
> >   call tramp
> > 
> > Note the lea instruction is used to adjust the rsp register without
> > changing the flags.
> > 
> > The optimized uprobe performance stays the same:
> > 
> >         uprobe-nop     :    3.129 ± 0.013M/s
> >         uprobe-push    :    3.045 ± 0.006M/s
> >         uprobe-ret     :    1.095 ± 0.004M/s
> >   -->   uprobe-nop10   :    7.170 ± 0.020M/s
> >         uretprobe-nop  :    2.143 ± 0.021M/s
> >         uretprobe-push :    2.090 ± 0.000M/s
> >         uretprobe-ret  :    0.942 ± 0.000M/s
> >   -->   uretprobe-nop10:    3.381 ± 0.003M/s
> >         usdt-nop       :    3.245 ± 0.004M/s
> >   -->   usdt-nop10     :    7.256 ± 0.023M/s
> > 
> > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/kernel/uprobes.c | 121 +++++++++++++++++++++++++++-----------
> >  1 file changed, 86 insertions(+), 35 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index ebb1baf1eb1d..f7c4101a4039 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -636,9 +636,21 @@ struct uprobe_trampoline {
> >  	unsigned long		vaddr;
> >  };
> >  
> > +#define LEA_INSN_SIZE		5
> > +#define OPT_INSN_SIZE		(LEA_INSN_SIZE + CALL_INSN_SIZE)
> > +#define OPT_JMP8_OFFSET		(OPT_INSN_SIZE - JMP8_INSN_SIZE)
> > +#define REDZONE_SIZE		0x80
> > +
> > +static const u8 lea_rsp[] = { 0x48, 0x8d, 0x64, 0x24, 0x80 };
> > +
> > +static bool is_lea_insn(const uprobe_opcode_t *insn)
> > +{
> > +	return !memcmp(insn, lea_rsp, LEA_INSN_SIZE);
> > +}
> > +
> 
> Just a thought. See if below maybe reads better when plugged in.
> is_call_insn can then be removed, I think.
> 
> static bool is_call_past_redzone_insns(const uprobe_opcode_t *insn)
> {
> 	static const u8 lea_rsp_call[] = {
> 		0x48, 0x8d, 0x64, 0x24, REDZONE_SIZE, /* lea -0x80(%rsp), %rsp */
> 		CALL_INSN_OPCODE
> 	};
> 
> 	return !memcmp(insn, lea_rsp_call, ARRAY_SIZE(lea_rsp_call));
> }

yep, might be easier to unify that, thanks

jirka
