Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E038DC0
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923657; cv=none; b=TBD+Ae32b4WYwILF/yqpMUgwNL0gF2EPjYndTRqylOfLGPniKDZi00XdphqC3GDl6QPT/1Neth1CLhXj0hp2+dgaZ9uWYd0lrT/oWQBvx4JuMc1MD4BeUzgoMCI7BrwTAHCgXiR9/UAlzD64nO1z1jhR4MyVoZ0VzrJ/c2S/63w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923657; c=relaxed/simple;
	bh=x2/JS1PipRqIAQdBnHtQ/Lnn44o7sAnzzdZI5eF1158=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vB4cEjCMExMN8OIviPyYn+EbriOYw2BvIjNmnPHI73Mmv66plpofFey2gPM2a55saVSP1lKf9jrJAtgZZOXEIFNDXk61s8oslMnx3D2PFa6dLQfa2LDKAGVqdPLVrz+RsKomoLM4HCu4Q3pY9upCNYyQLLIiRHiKIzIizga091w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAiFQOgs; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAiFQOgs"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d094bc2244so87604061fa.1
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710923653; x=1711528453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oCfGvKEfJR5Jks4nqNQHSwFBppJg5/9jMlRRQa7P4qk=;
        b=BAiFQOgsigP/Gf2tQHhonan7KCKv8oS+ldGj8q4TnTP3oPZFA3/tMEYFhmADD4+9sJ
         28umc4lHGdpxSg1eWkZiG3mLvVtYz6SzFBaFvr19SJmsmGYBxwbkirczrbF/TdNF8Iv9
         x/SdcWnPGQ8Cydf2uPdF07oZmHtWEq+xFPqeP87+8Hr7yWkUr9FetMZ8LS/FWrejA5ix
         TIJ3YirIsqllbIkxD4xzTCy6Nti0NcMyR6QNe5GoOOp3H6q9gDPLBJ1NE13tUAnrrI8y
         4SVfu4pEFdpZ55yzgrJoSgC4P5wjchaYyGwxuAAgveuQ7lpJ2OyBCg71PPth8vh8unv1
         XiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710923653; x=1711528453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCfGvKEfJR5Jks4nqNQHSwFBppJg5/9jMlRRQa7P4qk=;
        b=Ix0Pb6iWwU46/dFYoAAf5+tXz8PEWptVCAFsIQcUA+YkX/ks7mtAfcl18QdpmOg/XV
         oeK9D8tRYagq3vUBb9xnR6WioGLbMKt5W1/Z1DyLfXcwG6zKkGqUDcdkxS+3MNOdSxsu
         U79mzR7ldv3k2rf6AgR50EEQvRZeXOU0n0fLOnzkFXHyJjvy4THIraFHZd6tEn7QVTLr
         EX+C/yE5wvHaEFJsOQrwZaEUQ+CZvfWtj2A+QXFlVhTYCog/P5u5Zh2JROqQr5AmaeuF
         jui2Flu5RkOf4EQwEpH4JH25uWt5woe3QYhPTgvzmw/iTOznykQOHbu22zPpjF7WlLdm
         WzHw==
X-Forwarded-Encrypted: i=1; AJvYcCXNtmHkletYhbTgSBB9LgTARd7B5gQSHy1JFEGLqFqbtoFO/8tyg5x9A6oinUMX9q0KeIfK0ZLtROWCGO+pieURfdja
X-Gm-Message-State: AOJu0YxJ3YMfQjYLFbSCJbEO7WCh3zF6uRV79a0IKuAuGLrmfcg0dmHc
	jMcGB6sI0fFl+zK0z9Hw0rpiqZLlN948m+hDXCux8RIkFLFHYCQl
X-Google-Smtp-Source: AGHT+IF8KqI/ceVP79UlTjPH4d0nM1ljjanij72Sq/9rYB+Fo1hiBH5TS2dz/3jkoNjLrhJl+QQHnw==
X-Received: by 2002:a2e:a99d:0:b0:2d4:ad34:85a7 with SMTP id x29-20020a2ea99d000000b002d4ad3485a7mr4103769ljq.29.1710923653214;
        Wed, 20 Mar 2024 01:34:13 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c468500b004132ae838absm1458239wmo.43.2024.03.20.01.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 01:34:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Mar 2024 09:34:10 +0100
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH bpf-next] bpf: avoid get_kernel_nofault() to fetch kprobe
 entry IP
Message-ID: <Zfqfgn6lqwRCFQaD@krava>
References: <20240319212013.1046779-1-andrii@kernel.org>
 <20240320124742.5652f47b8f6dfea24cf84ce9@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320124742.5652f47b8f6dfea24cf84ce9@kernel.org>

On Wed, Mar 20, 2024 at 12:47:42PM +0900, Masami Hiramatsu wrote:
> On Tue, 19 Mar 2024 14:20:13 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> > get_kernel_nofault() (or, rather, underlying copy_from_kernel_nofault())
> > is not free and it does pop up in performance profiles when
> > kprobes are heavily utilized with CONFIG_X86_KERNEL_IBT=y config.
> > 
> > Let's avoid using it if we know that fentry_ip - 4 can't cross page
> > boundary. We do that by masking lowest 12 bits and checking if they are
> > >= 4, in which case we can do direct memory read.
> > 
> > Another benefit (and actually what caused a closer look at this part of
> > code) is that now LBR record is (typically) not wasted on
> > copy_from_kernel_nofault() call and code, which helps tools like
> > retsnoop that grab LBR records from inside BPF code in kretprobes.

I think this is nice improvement

Acked-by: Jiri Olsa <jolsa@kernel.org>

> 
> Hmm, we may better to have this function in kprobe side and
> store a flag which such architecture dependent offset is added.
> That is more natural.

I like the idea of new flag saying the address was adjusted for endbr

kprobe adjust the address in arch_adjust_kprobe_addr, it could be
easily added in there and then we'd adjust the address in get_entry_ip
accordingly

jirka

> 
> Thanks!
> 
> > 
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 0a5c4efc73c3..f81adabda38c 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1053,9 +1053,15 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
> >  {
> >  	u32 instr;
> >  
> > -	/* Being extra safe in here in case entry ip is on the page-edge. */
> > -	if (get_kernel_nofault(instr, (u32 *) fentry_ip - 1))
> > -		return fentry_ip;
> > +	/* We want to be extra safe in case entry ip is on the page edge,
> > +	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> > +	 */
> > +	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> > +		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
> > +			return fentry_ip;
> > +	} else {
> > +		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> > +	}
> >  	if (is_endbr(instr))
> >  		fentry_ip -= ENDBR_INSN_SIZE;
> >  	return fentry_ip;
> > -- 
> > 2.43.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
