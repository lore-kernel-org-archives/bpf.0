Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E52382
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 00:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065772; cv=none; b=LdSJllpu0lXI+Dj3Mo0luOO9pd20tsl5TAjlZTIOTQv9V4igpYCV8woQ3txFDrO6UxTgB/zkcGGTM6Mqczu2HH47NJ2ARkLB8tVYGvTpf2s0OCNF7JZgfJs4mDk+qXCFHA/ZojdRCR87W1oFBu7EvOTj1M94nKmTgBKUa88ZRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065772; c=relaxed/simple;
	bh=/CuFCCF24LMQQjfWv6oOXPtUlMc5UYwPTm8zHbh5Cqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3SIbXzkV8dBLWw2PjPPYkPoWl69mdvJH5GR1beJBr5fVsNPWxlIVJCYRs+RNp0/sSwpZow7esQ+SQuADXE/wPaBzNy/Z0KQLgTdtnCHAxn0jprul96Zpnx+ljRrcjiuBAz9WydN0VDI0PQmadlb5OeZX6R3VnSsk1qNbSstvns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eto+uV6g; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eto+uV6g"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4146562a839so10970885e9.1
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 17:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711065769; x=1711670569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxrIIWkS6fhb1jW6bU5pT4+LUeBFDIaosG8rt+z4Ck0=;
        b=eto+uV6gp5ol8sTtgwmZX4W+24f/qgYYs7KSHdDV+PCarnUiWw7mcF9+ueeXuPqZuP
         TO3BFt6D9z/kt2f6Sd04Iuh+SiX9JHMh3v+qkb7O1k8oXjr/oudFjTrHgFSIgJFF796B
         LPnNxxH4DSULswxY0bJJkLlOykDLMP4zuuvZ0HBB6/tENtglGCJFwXtb8V8JbnBnZ/bR
         xFrCL+nrahUwO3wezuoHw+FPp4HJ3zKtWH2ztfivJH//c5MxnHafu7y2A7y2xPEfYQy8
         DmXJHNwlOo+QA/6FxIwLalxvu1VfzMZAy4DGrQ/43QHlxqHYfb6xfROxCANOAJtrX7w6
         UtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711065769; x=1711670569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxrIIWkS6fhb1jW6bU5pT4+LUeBFDIaosG8rt+z4Ck0=;
        b=QLeo6VTaebxviGMmyf/rI69V3LtSLj1+y5jgXSai8NnWmh4VJNH9Der/1YNatU4SJw
         9/fGUJgzMuowP/yskQ1Q9gbbnMl+tw++yCJ+e7wH+Qbcsjuxkvgn8TzINnaZG9rr6aM4
         kNOniam9jJlTL9gZF9+s4VEwsyroewJtVwAJdj5R18uonODAtEclo4oI6idKgQe0t/Gh
         GgCOPwkMT93bydGfYb4VNzdyvWlVUw9PsAvuRV8LrvqI8aq5DXXCcrAjfWfXkuxnU5g7
         IeoNlZNiH8Jgw1m1Cc5fbbrcnPGqCmVh0sxvKZM78//+lx5jvDhdEqB6A02k/Skhtnbc
         0ECQ==
X-Gm-Message-State: AOJu0YwtBmBMqC0nIVX8w/RcaIFP+E4iWolkAA5wSGh8vvdEQpGRjagM
	bQaz+WMPFJ8BkTnsY/k7gXxh8tSASaaEtKzh7WyCz7SjqAnUsRlicWOGMIFhMJmHq4ws1FgrYeA
	IUq14J04K6dEjnS/tBg4WFywVbWk=
X-Google-Smtp-Source: AGHT+IFVXnl3sJZGnd57GMzZBHe+qqX9A4fFr3xMRXCiNcIgQlumghxiMPRw+3N36VlzCjMiom4h8bRXQExv8i+SpIQ=
X-Received: by 2002:a05:600c:1c26:b0:414:a89:3443 with SMTP id
 j38-20020a05600c1c2600b004140a893443mr364758wms.25.1711065769497; Thu, 21 Mar
 2024 17:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200114.2219721-1-yonghong.song@linux.dev> <CAADnVQL3yAnS4+A59OBmpbhEhQx7Was-EnTcLW9k4ddnXQi31w@mail.gmail.com>
 <559d9eb6-9832-4947-8d32-9be84c217659@linux.dev>
In-Reply-To: <559d9eb6-9832-4947-8d32-9be84c217659@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Mar 2024 17:02:37 -0700
Message-ID: <CAADnVQJ2vEebnbJ4t-zArLgLxdYtHUoPhvo0FsHYRWG48yqpLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] libbpf: Handle <orig_name>.llvm.<hash>
 symbol properly
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:55=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> >>   static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
> >>                         const char *sym_name, void *ctx)
> >>   {
> >> +       int lto_enabled =3D check_lto_kernel();
> >> +       char orig_name[PATH_MAX], *res;
> >>          struct bpf_object *obj =3D ctx;
> >>          const struct btf_type *t;
> >>          struct extern_desc *ext;
> >>
> >> -       ext =3D find_extern_by_name(obj, sym_name);
> >> +       /* Only check static variables in data sections */
> >> +       if (sym_type =3D=3D 'd' && obj->need_kallsyms && lto_enabled =
=3D=3D 1) {
> > why bother grepping config.gz ?
> > I see no harm in doing below strstr unconditionally.
>
> Do you mean we skip condition
>         sym_type =3D=3D 'd' && obj->need_kallsyms && lto_enabled =3D=3D 1
> all together?
>
> For condition sym_type =3D=3D 'd', Andrii suggested (in private discussio=
n)
> to focus on data first since that is the issue we hitted. Of course
> we could do all symbols here too.
>
> For condition obj->need_kallsyms, I can remove this one.
>
> For lto_enabled =3D=3D 1, the main goal is to avoid extra overhead for
> not-lto kernels.
>
> I guess that the overhead is not that bad since typically symbol name
> is not long. So removing all conditions seems indeed a viable solution.

I was suggesting to remove the last lto_enabled =3D=3D 1 check and
check_lto_kernel() since it will simplify the patch significantly and
won't cause any slowdown.
The first two checks... I'm not sure.
The less corner cases the better. strstr is fast enough.
Ok to remove them all.
