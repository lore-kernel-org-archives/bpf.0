Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0126A37106C
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643173; cv=none; b=TGuO0lWfOhFh/5MJw7y9pYCZNucg6fHbm1AJ7WOAjsC7VyHVN8l2/US7aJtFx6e7MfvVCdmAr3t3nNJUkyC5JKI80uYaeedFsgrmYr5jz8hr0jAcySKerSwhE9Xn1ovYB271Lq1P8cp1Pkh/IJDW582Ss/LRES7PIizzd9VEjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643173; c=relaxed/simple;
	bh=lFMlxuHuQNatwP/298euwWe4W5AWRCLhAN0tMT0uRXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eV589/Qo12s5cts2wD+Pe0+B1oJUZZuEHicf4L90lG33kSeUXUZmPgPh/aYMqapybwCn8zONRamJP/obSvSsVLixfE0GmVARcj1vzErltgRTxojDP/vuAwqxhZeSrVGn3JeU3RkoTwnvBX6B7SwjrdE4keZBxS4Gh8436HVazQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpvFSzEl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpvFSzEl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4834826e555so3886595e9.2
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 05:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770643171; x=1771247971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T12PfmGNrlhLUzqVu+EHiA/TP/C6rIKdT0c7j2WefHk=;
        b=QpvFSzElqQihzx1gmPa4YB2pD9otA6Z33zvvcMYOL7GGZLFr5Tg7y0MrG5X6BV+Qrz
         XwuwIxorNWKasD7KGiXMB8j2/NeZOojMY9aAo/S37XG/Ax44MIgW36W7JbkDEMXK+pw/
         Z1LIML0wQQnESdi6IHqdt7Eh6mCvIG9mKkOUmeqRcICfVX6XvxIrWofGfJZbP5HQvkwu
         t5KSTNnBHI9xU7f+L6YDnSJ6vIut9r6eOCf3MWE+ZIExAgovefW5crjNZvy7mJET5SjO
         2aVBofxRX27qoGOPJS5dNX6YKTgE7y7xAmOrmxP+AdaWtkLi+B/wLiSk+k+PS1AL++wd
         YuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770643171; x=1771247971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T12PfmGNrlhLUzqVu+EHiA/TP/C6rIKdT0c7j2WefHk=;
        b=CvlegVcfgGfH4FagjB/D98cGgeDgq9KVMzCs3muIGE53Q1i1Iw2BYvEm61IFJSK5rr
         Cyoz57ZOgnoBYzhhPo7Sh4bNsJpopD0uC82JdaKn41Neo0JU0T5niMPvhFyY6AhceorE
         zWRCiGhEYxmEhG0/S0+O+TiF7oYnP4sb18pFmGVijTztuMtMidR/AoPN3Ai8Qa0Vplz2
         2FN0btcBJwopapDhlv2vim4udExq5MJba89Pok1EYOTSC98HqN/od5Lit9XMR/sKZWZp
         MBfCMi/6+wzoQ9pHcC6QeQZfJbyt0TrE979yawuqmkHafI+EnxMnBfU1fbuyKT1pB8Ki
         rr7w==
X-Gm-Message-State: AOJu0Yzh9yvGbFDkIqsvn4EYUe45sXwvrvMwjiVOZGGtjFyLIUFH84+j
	emOYsC+/PSTeuntAEqAsTUeVpsRvtW3LY/5MFtHgZKrbsCdXn6ULn3dM
X-Gm-Gg: AZuq6aLj15DHy9d4AeqC51EgPKYsIAXPPLdArYb7yYTtQB/LTIrrGnmEAvrQH3fXJrX
	xtFWFmeCVgpTwyBTcZcXYvkhksjTszhG8NnXRiMLYqkjWI3O9+NYamxZ1lWYgE8fZuCbJPFhCBa
	1CiSekMDFwz75dHK/ZV4swspD7Y4VtKqL48OJnOM2F2AQzzRxMd/3RCtEiNGyjK62qgG5Bja8yi
	/NsDRY00FifqI/RvHnw50oYXoIs0tPfl9k5l8BI6BLA2WULnVZ0ED0GGHGt1XxPZIu+tl9JnCAW
	uTmsbOCMGpyaaobDOXWB3od/yQR9Q3y9KEUuchi0+Z3ZzQ0aaNTxeRGESFHzE1iOdZLDNmR5uYA
	Vk5X6YbqTE/SJNaXoa953rwz62rYHnEmZL9feFcL6Nt2ha9VZr36sg7qMeRPCxN6dK2pA8qJ356
	moFR5surnHTGwXfPE5gyuT
X-Received: by 2002:a05:600c:c16d:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-48320216097mr151636715e9.22.1770643170873;
        Mon, 09 Feb 2026 05:19:30 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629754c62sm24877625f8f.38.2026.02.09.05.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:19:30 -0800 (PST)
Date: Mon, 9 Feb 2026 13:27:39 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, aspsk@isovalent.com,
	syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com,
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v2 bpf-next] bpf: Fix a potential use-after-free
Message-ID: <aYngy0xZohOKbUdE@mail.gmail.com>
References: <20260209124653.56103-1-a.s.protopopov@gmail.com>
 <896dfc751c8e3c2b98b9b36b05bf75956640d3b9dca70d24d18eed82c4f662c7@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <896dfc751c8e3c2b98b9b36b05bf75956640d3b9dca70d24d18eed82c4f662c7@mail.kernel.org>

On 26/02/09 01:06PM, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index edf5342b982f..24de90357450 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -21333,29 +21333,28 @@ static int find_btf_percpu_datasec(struct btf *btf)
> >  }
> >
> >  /*
> > - * Add btf to the used_btfs array and return the index. (If the btf was
> > - * already added, then just return the index.) Upon successful insertion
> > - * increase btf refcnt, and, if present, also refcount the corresponding
> > - * kernel module.
> > + * Add btf to the used_btfs array and return the index. If needed, refcount the
> > + * corresponding kernel module. To simplify caller's error checking in case of
> > + * error or if btf was added before, decrease the btf refcount.
> >   */
> 
> The updated comment says "return the index" but the function now returns 0
> on success rather than the actual index. The old code returned
> env->used_btf_cnt++ (the index), but the new code returns 0:
> 
>     env->used_btf_cnt++;
>     return 0;
> 
> Should the comment say "return 0 on success" instead of "return the index"?

Yeah, thanks

> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21825693233
> 
> AI-authorship-score: low
> AI-authorship-explanation: The commit has standard kernel formatting, addresses a real syzbot-reported bug with proper attribution, and shows iterative development through review feedback, all consistent with human authorship.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Minor documentation issue where a comment says 'return the index' but the function returns 0 on success; no runtime impact as no callers use the return value as an index.

