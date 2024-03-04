Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD75C90F
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571956; cv=none; b=ZT5FtKLd3I2OhVcnbdFlGRyh7GfecG1N3RV0m2PJtmxVTuU0R4Fdh2OJcvw0H+7iCq+WbTgx+50iCK1FAzcRwN6/TexdSA4L1jQPJMFIbdxls9b8nzdfFOh8miCfn88OSuyDU73GwHdluT4gQCvSAyJCyXLWcZ9VlaJmYIXnQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571956; c=relaxed/simple;
	bh=tw2KTPemyZyi222MX3sziGGfQJy6wHdjZUTTF+KiOSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLaJH1dZrwiN+wqaTXBDRIUub1AWctuYz7P4+1JGcQ5dnUGVAQSeVL/mnQNbUqRdZCnpDMsaIsQ2hUW+a6wZZpdFC07+DyAGlahVl38PmPqBL4JbqdH2xy5fx2QQ28GTJQa3a3sjz729I91Qc0whhN0+a9nc4vYdCPVZvFX1C9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl1MyU4B; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl1MyU4B"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d38c9ca5bso2376352f8f.2
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 09:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709571953; x=1710176753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKDJoniJlb1Y7Lve6HZtXVf9kI3aIcrvEdXe1UbGU2A=;
        b=Yl1MyU4BBKNAjSAZ2y715tzUhP2LZYt3RBetA3LM/uRSty2qNNNOgmio8NUTnkYGHx
         Ar9cZ9wlTNTpMudIkOZ8XF9z+0XI6E/7kFSW+DRC9mSs9txUfFsnVHKTz0prEC3lntAs
         HTWi30vApxrYgdttS3dlKhNp8vrrhZVyiSr80KJfThGQRldQQCUQtN3EL8VB7fabGM+y
         q63P1KmGjmVMwICbZ8Rwm89izUb3egJ4JufdVKwmdDhHiwxhmSyfLAa/uaIdM8ZiNQfa
         FHad/+V3B4e8yhHRf33Qcoyrk8ROc1P2B0OSWBJyyQ2o/LrMxGisNs+skwQ+yHJ0rXgi
         uNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709571953; x=1710176753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKDJoniJlb1Y7Lve6HZtXVf9kI3aIcrvEdXe1UbGU2A=;
        b=lgGsWJmp0lx6JQM2e7smYBXg71CKZvEgE2h0xVNme80mJlr9/NSsAAIPd67bGeCiej
         kK0QowV6dN3Fki/IBr8Vg5uXml6G6u/3FSFZw96S5U+3LQ5BQIRWxgZj8UxjArR31gXn
         FgPwStybmSYPR0moal4rRxo3Y3nplm2vhS+eGHHXAZog8ixbNPO94g4Agvq2/6JIYroZ
         yB7FXMun/av7TYJaCIgJ+kahRouAsT5oI4F4JiVk2g0PaMc6rDgT2Br3eDf46puX7Gua
         9uXzSmQW3oZCF6JmOPvkr9ItPRgqQbYhrwG2/u5THSNRu1X68zCG97gffRMEWCNzRbZD
         LgDg==
X-Gm-Message-State: AOJu0YzCbkmqBZI3QLK/+X1lc4/J5QIBk7yej0lf1WpXWCA2oj4BNOuV
	4AqReN54yV+ZzP83PaV3s/dwrPD2BPIvCq0xLdxIZHwcHo8fwqXZNB2EjA6tAPpZI+9dpBYb4SQ
	SdJFo0vzw3NSqUiEUzJ7i+61GPWU=
X-Google-Smtp-Source: AGHT+IFFOxBqElwbetEw959W3ih4kYDuvgJeG0m1www75tlV9V5vSA4MGElmyZ0pFpXKdrae+ANZz6LJivR0I5JWah8=
X-Received: by 2002:adf:9c8b:0:b0:33d:47d6:c159 with SMTP id
 d11-20020adf9c8b000000b0033d47d6c159mr6804323wre.12.1709571953320; Mon, 04
 Mar 2024 09:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302020010.95393-1-alexei.starovoitov@gmail.com> <270f01da6e53$63e93620$2bbba260$@gmail.com>
In-Reply-To: <270f01da6e53$63e93620$2bbba260$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Mar 2024 09:05:42 -0800
Message-ID: <CAADnVQJRzLTs6mDTSofCgCxoR8jv8C30g_hHJREM8+fQpXe_Xw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 0/4] bpf: Introduce may_goto and cond_break
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Kernel Team <kernel-team@fb.com>, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 8:45=E2=80=AFAM <dthaler1968@googlemail.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> [...]
> > Alexei Starovoitov (4):
> >   bpf: Introduce may_goto instruction
> >   bpf: Recognize that two registers are safe when their ranges match
> >   bpf: Add cond_break macro
> >   selftests/bpf: Test may_goto
> >
> >  include/linux/bpf_verifier.h                  |   2 +
> >  include/uapi/linux/bpf.h                      |   1 +
> >  kernel/bpf/core.c                             |   1 +
> >  kernel/bpf/disasm.c                           |   3 +
> >  kernel/bpf/verifier.c                         | 280 +++++++++++++-----
> >  tools/include/uapi/linux/bpf.h                |   1 +
> >  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
> >  .../testing/selftests/bpf/bpf_experimental.h  |  12 +
> > .../bpf/progs/verifier_iterating_callbacks.c  | 103 ++++++-
> >  9 files changed, 330 insertions(+), 74 deletions(-)
>
> Don't we also need to add may_goto to instruction-set.rst?

If it was a real insn it would be too early to update the standard,
since it's not in any kernel release yet.

But more importantly it's a pseudo insn. CPUs/JITs won't see it.
I think we need a different document for such pseudo instructions.
Same thing for upcoming nop_or_goto pseudo insn.
