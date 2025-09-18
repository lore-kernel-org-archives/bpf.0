Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8BE2F532C
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202361; cv=none; b=fReJPiRNHDdOxuI39PQ254k/+2pQbOpYoEAp6ivP4TC+jST/2JbeaUYPK/Exp/Djy8eqO87zWpX/OEI3CMB9I9Uok05Jza8hwbCQjNkhfkmpy9HMrfmcv+fRYc3G+XbHvz0RtUg4jdeYIDlNpLS6TfxPTb7cxsalfOFhuOaswCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202361; c=relaxed/simple;
	bh=oxJiGbOc7aw1fHkiA7J0rf4ilEqD7BsiiYiwS7xl7ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+JtwGWmaaSW26EhK8Pjk3QIcuVG5r/f2gogpNMM+aJTPKKgYmzIHY5At1GgzHcU29RQu0wb1UJiIdQKjOakRjdvmRuENkI0hClQWHEz+CS1GadzC3Tf50VHUYkNCp5LFZkdKUc0ZhQ8gqp+GQqFD33u7PpHgX4ZH2SXx4bsdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9b85mSE; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9b85mSE"
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-ea5c9dcba4bso675141276.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758202359; x=1758807159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUE2gHe7YLhn4Tjh2XvbUIgWYcWs0P0Yu4OFl5btK+s=;
        b=e9b85mSEB47sS0mS2GbuuQO1ayTgmwZYK3NBmGqGS7jT/5manA4HtHpOxRdRV8zLj+
         z9EcVKd+fqcPamejFyryVzwCXGjPu4NamsdB7CSdT41b2KE4/07gcmBX8qS2jHLRK3s+
         JSn7fA//iVqqkfTrGo8O7ebpLYO/AZwTdA8Aoag2iX72bwB4KAf2TEt35vKKMgYXLUpe
         AcFbk/bQOLK7i1t1/szrdq6FPieJUILtOemL7mUMA9K/Ney3ABb3GUesQWdyVG74Lte2
         llEctmqHKv2Hgwc1nxrxyHHv+crS5CRg/L77L7xWE59ntRt0Nd5KYvyaT5z5e3nbSyYZ
         sqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202359; x=1758807159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUE2gHe7YLhn4Tjh2XvbUIgWYcWs0P0Yu4OFl5btK+s=;
        b=xKj25Ir3C5Z/jA8OMiXPNhqtT+PbHjOFkrY6Ug24fVnmkIy3IwgisYFnIEQDBloz4s
         6OlglTv2vvk1788+ncpKj++ygzhDkyfyKdOQNs7tzabmQEJvmdBnjYfzjAEbw/rgP0+R
         S77fAYW+7hM/+jdv/Fg9Q/p42qLfcXERpl+GGu9ns5fGtPEdaUa8+crVzg3Z2+k2hMXt
         H5xDwdgJQlmyjBp5XHI4Hmq5dHc+DMl1ixI3pTYaofbdbXVV+1xuv1onVFys9CjTgSDf
         1yJAVlFR6a9FTjSM6yH7r+IrQC5I4wjrTsSmR+V3vvMXY9nOot/OsO8S0u1rkHVMl4/E
         CMpw==
X-Forwarded-Encrypted: i=1; AJvYcCUCdVzXFEjhT4BmfgFZp+lZ7Y66OdEUZI7zzzr6a6r1FA6J9HwN1htwtGkkgXM+wa6cGrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1MLBcwFSQGU/BQhRsGOqNslEBYaMhMPE54lWgt5OOLaP41xD/
	Xt1HMzCmgIsrLK/flyjxLwn2GAUlQqDSd5NpoOHE3PUO59rrrwzHIeRJ2lhjEz4lrI45r5QcB6P
	gUVlbooEMCfV4tA9/A8MVEAJi/8xjeFQ=
X-Gm-Gg: ASbGncs/8pgU8ZsVtArj5L3Gs+pSZmt4EhkBUASO0SDFFGevlkSVVeYCXwCt3vGI8i2
	TO5C4ThBUmdEPNOCEqYaNrIlnfqpQSLEzYJhzQLaP77HPKJq1kQmE1rry/zBlfpo+gqFLEvTp8n
	Z0ovWREuC0N5s7denZks7t7Shg7T7Vuudr8T6o6nIw17Uspg5RjOnA7PwtloTNRfo0lK1BArEw4
	MDMxiwSqOTkpSsny2w83VsTKw==
X-Google-Smtp-Source: AGHT+IGtqcAVAFdskQ3nvvg5tGb+wpuXkBl7+z9D1cZ5z+zV4plcRbO2+OWKDjgQB6MO9fLNyoHo4500LAblOC9RzIA=
X-Received: by 2002:a05:6902:6203:b0:ea3:f114:75e7 with SMTP id
 3f1490d57ef6-ea5c0687159mr5679817276.28.1758202358485; Thu, 18 Sep 2025
 06:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn> <20250918130543.GM3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250918130543.GM3245006@noisy.programming.kicks-ass.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 18 Sep 2025 21:32:27 +0800
X-Gm-Features: AS18NWBtunmHG653NSNG_FTMHgwxFNYu3n6X3_LSv7HnFAXelTzRmzVHNLLq10M
Message-ID: <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
To: Peter Zijlstra <peterz@infradead.org>
Cc: jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, kees@kernel.org, 
	samitolvanen@google.com, rppt@kernel.org, luto@kernel.org, 
	mhiramat@kernel.org, ast@kernel.org, andrii@kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 9:05=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Sep 18, 2025 at 08:09:39PM +0800, Menglong Dong wrote:
> > is_endbr() is called in __ftrace_return_to_handler -> fprobe_return ->
> > kprobe_multi_link_exit_handler -> is_endbr.
> >
> > It is not protected by the "bpf_prog_active", so it can't be traced by
> > kprobe-multi, which can cause recurring and panic the kernel. Fix it by
> > make it notrace.
>
> This is very much a riddle wrapped in an enigma. Notably
> kprobe_multi_link_exit_handler() does not call is_endbr(). Nor is that
> cryptic next line sufficient to explain why its a problem.
>
> I suspect the is_endbr() you did mean is the one in
> arch_ftrace_get_symaddr(), but who knows.

Yeah, I mean
kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
arch_ftrace_get_symaddr -> is_endbr
actually. And CONFIG_X86_KERNEL_IBT is enabled of course.

>
> Also, depending on compiler insanity, it is possible the thing
> out-of-lines things like __is_endbr(), getting you yet another
> __fentry__ site.

The panic happens when I run the bpf bench testing:
  ./bench kretprobe-multi-all

And skip the "is_endbr" fix this problem.

__is_endbr should be marked with "notrace" too. I slacked off
on it, as it didn't happen in my case :/

>
> Please try again.
