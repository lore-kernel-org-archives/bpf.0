Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC92D2E7657
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302704; cv=none; b=oTz5qBTD4Ys4d1vAm8Cdlz/doTJoPsVOqOmocfAIGLuSmlVFgsKCLnUEKjVDRJj0QhYMvZ+C1PrIMOFIVdwAPELKiPwcG9QUaWjnbRT89gPbYaFvgUlElIMpYi/G99sD6UWSKhhQbviH6ZcEJeaEz5lUlEdemZLpVfC3YP29eMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302704; c=relaxed/simple;
	bh=d5tS/VYQvy11KKQdbITdO/cb5iPgnZacDSb2hI1SQqQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RE0SJuLBfemRjH6MNOHAYlTumKWTrnbNi8vhBzZfy+tyyXpgbrgoU9T4hqPTIG3gaZK9BElgpmU6Z3Jc9z3cbKc+KevEpTdE8E9fac6zn96w89epFjzvSiB7oGb5wKdsqO0hNXS3Pg5BctjCU/uS/Zc3D7ZyziCrsdE/UKYhU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3n9ziM5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3n9ziM5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso88826735e9.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 01:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780302701; x=1780907501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAW5Os4pfjenGgpPUMRcNNYStYiDsva7wTl5T8rnAg4=;
        b=e3n9ziM5q5lYUTkuy/hA3RlCALxNikIWvqDE3QUaJXe3tk/p12rM+cwTQmuH+N966B
         fitQ7pfkbYaRmYSpHhIf3klMBkdon8RguTOgj7CAMBjsy3kn7zwr1ShVCVuYqPL1cuDm
         n3B3Ab6uayfZ0z26kQGOfvOBPWV+jwqWZwLfQey8waeSd9GvHF2VpDj0v/VCqEUDIJQh
         TG+yVL2zJVt4MIzOtKiQfzt7BKOh75kzIIoqgBZIHl21ylCv3JrxxGRAF+Gy+PwgZmAd
         uQjgm+3L8rus1bceNdunvAzBbr2q93BLLAJj2d2G7RD8fkTTSg3WsGScKZAqtQrulvOb
         aIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780302701; x=1780907501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAW5Os4pfjenGgpPUMRcNNYStYiDsva7wTl5T8rnAg4=;
        b=WmToCs+vkXNbduJKUpRiPtBYybrBe3+JCVux981PLl6a1mR0eBkm7bTdorkcxOaYnG
         v9tOJoZZnqFhu7z5aHmd+ly52rEXO0laNjY36LvSoUS88dJnnf5CUYyzS+kpGFvAw7Zs
         26AZw59Gt9qTEQR4jlRtw9AO+gITfMbjkiUZOMHCWw+yzeo1cVe/9NSiohQl0Bcr8a2F
         EQ/tGYD8g7V7C/NlZfvOcRjtslluFVIzHy61aAx+yDbzf9Kda7q52ugeOJXTBxCMbcY1
         O9UI1v1kZnD552fu66Cgto1uIxDszqSyBDCQ1/N63XfUCT+VXVSLcrSE6UwLJOPBDmM4
         uTLw==
X-Forwarded-Encrypted: i=1; AFNElJ+sXXs443es49ka2AcFBNtqqtQiD+CnVwyHbc4LdjLaA63sgUyL7fM/6OqairTtthhglkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LNs9KjxPZLcZ7jFu8hX5tR6AE117c7qwkySaCsBUrdqIEtZx
	+r5RR6T6ZtRJszDCFNj7eNf79VA3UQPrVEXc+Q0gZEoSfubfgg6ksvF4
X-Gm-Gg: Acq92OH13lsYHJ4I/v1lmPGyV7aa4HO7oUMt379R4HbeAay/BG6cPcxAELbMg26wGqs
	Z9MJcFlMDjVQLOKwNVWTtGIhRUp/P4em7PjjE12sVp6FYZ2qNF3zn8fB74Dk82keCUfqL8y/9GD
	q+Y+I+aHLIcBkbOsMbPP84ygYNtZZ36DzrU5xEwrBIureHTykANpvGs51GumZ30BtJl0cGB/+rV
	hw3dsIL0v0z8i7siAM0HLE9eNY1wQJMukfCmBKgx/w1RTTyuw6aoxsJvduYzc4iI5IPZrOvYpNK
	gOm/kEFQV8WA44Q3TGskkf7GDGgYl1/J2PQUcO5tvZ5mHKT+Us92/cSnbCDcvKFGpo3Ewvat99A
	GoIIHe0U12Bzs6ZzgeQxjOSxk4fi+KGIGPyFPRzh7icc5r5DUsLEM5gWLKD2hyS/PrgmMQEVjI/
	6RDof57W+L78dk6pVi889hbXv/HA==
X-Received: by 2002:a05:600c:450b:b0:490:6e11:c303 with SMTP id 5b1f17b1804b1-490a29213bamr196953175e9.13.1780302700991;
        Mon, 01 Jun 2026 01:31:40 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d696f25sm349567065e9.5.2026.06.01.01.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:31:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 1 Jun 2026 10:31:39 +0200
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 13/13] selftests/bpf: Add tests for forked/cloned
 optimized uprobes
Message-ID: <ah1Da9KoU3wjjBV4@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-14-jolsa@kernel.org>
 <87ldd3665m.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldd3665m.fsf@cloudflare.com>

On Thu, May 28, 2026 at 03:00:05PM +0200, Jakub Sitnicki wrote:
> On Tue, May 26, 2026 at 10:58 PM +02, Jiri Olsa wrote:
> > Adding tests for forked/cloned optimized uprobes and make
> > sure the child can properly execute optimized probe for
> > both fork (dups mm) and clone with CLONE_VM.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 88 +++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index efff0c515184..033d32b4cc27 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > @@ -4,6 +4,8 @@
> >  
> >  #ifdef __x86_64__
> >  
> > +#define _GNU_SOURCE
> > +#include <sched.h>
> >  #include <unistd.h>
> >  #include <asm/ptrace.h>
> >  #include <linux/compiler.h>
> > @@ -936,6 +938,88 @@ static void test_uprobe_error(void)
> >  	ASSERT_EQ(errno, EPROTO, "errno");
> >  }
> >  
> > +__attribute__((aligned(16)))
> > +__nocf_check __weak __naked void uprobe_fork_test(void)
> > +{
> > +	asm volatile (
> > +		".byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n" /* nop10 */
> > +		"ret\n"
> > +	);
> > +}
> > +
> > +static int child_func(void *arg)
> 
> Nit: Could annotate with noreturn:
> 
> #include <stdnoreturn.h>
> 
> /* ... */
> 
> static noreturn int child_func(void *arg)

yep, will change, thanks

jirka

> 
> > +{
> > +	struct uprobe_syscall_executed *skel = arg;
> > +
> > +	/* Make sure the child's probe is still there and optimized.. */
> > +	if (memcmp(uprobe_fork_test, lea_rsp, sizeof(lea_rsp)))
> > +		_exit(1);
> > +
> > +	skel->bss->pid = getpid();
> > +
> > +	/* .. and it executes properly. */
> > +	uprobe_fork_test();
> > +
> > +	if (skel->bss->executed != 3)
> > +		_exit(2);
> > +
> > +	_exit(0);
> > +}
> 
> [...]
> 
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
