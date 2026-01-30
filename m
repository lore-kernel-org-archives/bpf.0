Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D32E6CA0
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806029; cv=pass; b=d5kEJNBN3EptQLvC/MrEkQueMg0ccaVbszHkYITOMf0poRy8wuKowFHM9Vvtw0rTg4hn7T/r12N0AOhEuxNGiZ6g0Y61mB1XI9/hY6nbs37eZNR4dNmNruhmlps83zY9LTybq2hzppJEbBB30W5EoJuCnxvjJETVfJzK+jQMXKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806029; c=relaxed/simple;
	bh=8CQieW4zdJSkblH2IT6Ccc+MZy3x+qlzVvgvvJlI84Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2+FcQmOfwO9qcSZBxPN35Zx/BRGP0rXDrRCKqFr9XHaUjjMwKuU4h5s9hOkhoie6lpyANer0Eein2kAfeqgupECRWiZEZXyNxXRZXVyweEzxiyZSRhpAF7RkVlyOkKIeuALlFKoRdlXyKaz2aomZlziKCxuDzor1I66bfyqxwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpLSexXU; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpLSexXU"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a8a7269547so24499275ad.0
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 12:47:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769806028; cv=none;
        d=google.com; s=arc-20240605;
        b=iTC/mLmDqjWrM+S5mDH0qhGrHDJgkfcslVy95PAJlR2wgnrnh9em1Pig4NrDdDc8Nd
         DZ/suHmSJSdWlY/KBWSCwT4yhd2fxpqNhN4gUPr+vi7QHHT3iYYYB4SbrB8hvJTi4h1w
         0/pbDqyPds8FldUlGAY8Rd4e/9UW3qkoOXhNupSUvWA/J320r+HcAQRdpLhpNG4oYWt3
         mjS4EtYB2clBji1zbpQ+agS9bkIlFapECoCMyBInimZG2roNXbHbCnwJVOpprZKExiVM
         2336l4R5+IW0N9xkSgDldcerdwEUf1JbeF4TgO7QiTiQalLJUFcA44mvyp4LspDnDqpS
         1Y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8CQieW4zdJSkblH2IT6Ccc+MZy3x+qlzVvgvvJlI84Y=;
        fh=+SkcSsJGSV1v7RaOTQb+bPbwV/W5yCnqlSZXmgMZHbM=;
        b=aOJUk6r0lpQmLHb7yOr2jLBH/Nutaw6qp3Gw+wt+UnglTl4tA4O/wzaxIQhogvsvG7
         12U8vBDP8ALtcQhrYDDqCpHOR9HnVqEyKuIbkXBe1tHTm2AuFh8mQe0vg/7bYVFdEfuj
         BII9gr4gg49K2jfJ0I9GkiOGFKB3Xgg2e0wmtVzoJpw/xvMMV97gk82zdvONrVumb7Gp
         qdQNjcI3Q28rt9BPX6DTSwI0QUPG8wlYaLWy+EM5vnuqrk8E7kLKEzaDsWZiDzTHPx1j
         x+lOpcllbs2q0HHILQZ5yreesf0UbgANOJ9UVZXo1WIo4ivItGobjkSJbrPICeYHc/tJ
         sTfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769806028; x=1770410828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CQieW4zdJSkblH2IT6Ccc+MZy3x+qlzVvgvvJlI84Y=;
        b=OpLSexXU525ANR//240IpDzoNjDwqAvSJ8QdDgKvGJ4f/TfMej/Z5vZePduwTkcLNe
         X8gSjQtej+nvQcZh7aBXhUVOjBmqN8C81b6GJjd/bqPjk13ALW+yM5+yUWl9Xm1crOAY
         UfbEZ/CeOnVV3CtLsMXalL6H79UbVqVHHYHHZSVXAGHRRMwSCMhMJ/63Ht9bALn4NPma
         Z6ViAqZHsA2eZXLhK6nu8VMI1ju3HTxdgetyFAKcadD++itLmtEA8WqmmBnn2kyOmdYV
         PHTNvMntZxNSRiugYvhd0uk47Odo5ixT7oExTlKfegxfkDZSyeTznBkBn5FlcQV0GHj/
         r36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806028; x=1770410828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8CQieW4zdJSkblH2IT6Ccc+MZy3x+qlzVvgvvJlI84Y=;
        b=MiY1kFKuTUrcFV2XTGBXyT72qc/6UvPWGW6xV96KIzuNYYAfFG9SKD1eNJ6FmlZ5c7
         s7UQkncstNcqWPgyhCfI2Y3KvcqmmubjRmkVN62NqzMF85jC1Gw2LseddRNodm8e9x9Z
         iJpkNasB/ShQ9Jd1/kglj0n/zxq5dELUC3tWONjMGtLMAsQJ5g9ISI8G3WMpLtURCBpV
         6VWLo6KtIcxFxfF95DiPn58tD2f2JFoCZ4JsNE4xTXJM4Ogvil/0hhehBSKsUTDoYren
         a1MHekrd5B0e2klyahYMvL8hGzLmaOcYH4i1n+IYGIZSPNVNC8yraCTIy2WOAdCoDlHJ
         V2Og==
X-Forwarded-Encrypted: i=1; AJvYcCUK1ZxTO0A+0ps2+r5+/2vFQtrHJYES9EdJlaYRY8iUkDMePG+xNF1A/HCBbz6sl+eysac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1wRRA7YBhIChLhdGq99tuI91mlw6iPKKwPM8zrIoO/ktObyf
	DpIaT4NUELLnXDWe+N3ToRAk5tpMMgvS76GxAUwaiQS4E0VjVSQjYE6qF8uBY+gjyxrAKQXvM/Q
	Oe1oIxHoZNh8R0G6ogegg84H0W7q+nQs=
X-Gm-Gg: AZuq6aJV4zM7IAiztNcrZsEGHwxit5BRkwemptDzxGdfn7zFkAog8qSZoD01hkU4s1u
	3akcsprZd5F1RROzpkC57c0ZJGPRYl2NPBRTiePi90BJVzAknWJq+S49ZKrR0jbT4j1XdhACukT
	+16VhT/rqg+fTYT26CXD9JYtXxabfc1jNupHvOh5bBzwKlB8m2tgeI4rUFji4moZ+giGQJaGG03
	+wj2QCFjk4uMEK0dFGQcXtgwpNf9QvYNzcRx4QiDt1yMXO78vXU/x8vPiYT2yOVZHAmQPmyO7Ip
	K9AAZTwSdv0=
X-Received: by 2002:a17:903:2b07:b0:29d:7b9b:515b with SMTP id
 d9443c01a7336-2a8d96b1051mr48787345ad.20.1769806027867; Fri, 30 Jan 2026
 12:47:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128233425.374535-1-mykyta.yatsenko5@gmail.com> <2b6f4cd9-ff0f-4a91-90ef-8d8e6812f80f@kernel.org>
In-Reply-To: <2b6f4cd9-ff0f-4a91-90ef-8d8e6812f80f@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jan 2026 12:46:54 -0800
X-Gm-Features: AZwV_Qi210mJuCzNNteRDylDR0i4a9V7EEL7JaDgT4PF9K_wd0onfCvx8Zqs4vQ
Message-ID: <CAEf4BzY16OkoUQZ-Vaywb0oAL=UGY=8FVcBWLVM8oe=-bQ=4xg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm dependency
To: Quentin Monnet <qmo@kernel.org>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 9:34=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> 2026-01-28 23:34 UTC+0000 ~ Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > BPF selftests depend on the bpftool. In some environments we may link
> > bpftool to llvm dynamically and then try to run somewhere where llvm
> > library is not available.
> > It's simpler to avoid llvm linking altogether in those cases, this
> > change allows to do it.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>
>
> Hi Mykyta, thanks for the patch. Do you have any other solution to make
> it work on your environment? We've been rejecting similar changes in the
> past, because we don't want to encourage people to strip away the
> disassembler when shipping bpftool [0], so I'd rather avoid adding this
> if you have another workaround available.

LLVM is a huge and somewhat problematic dependency, so I think it
makes sense to allow to opt-out of it. Of course this shouldn't be
abused by distro packagers and they should strive to provide
fully-featured build of bpftool. We don't have full control over this,
but let's hope they won't cut corners (either way they can always
apply some ugly local patch, if they decide to cut LLVM dependency).

But for a lot of environments this might not be worthwhile to wire up
LLVM libs. I haven't checked if this is the problem for bpftool's
bootstrap variant, but if LLVM gets pulled in for that one, it's
especially bad :)

>
> [0] https://lore.kernel.org/bpf/9ffd4b6b-0073-cfef-5889-cb4d0b838f8e@ioge=
arbox.net/
