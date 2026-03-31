Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB413E1CFA
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973088; cv=pass; b=LjpXOuo96uVuc6oNMmuzmMrMZmBMjSEOf5sknZYDk7hztxw/VEZkIk2EPIOLh+YnDb8KFZTdF4ER0vXhFuFSNximU8E8v+jVXAlchieNT0uYeIG+g7EtQUCWW0LKZo6cF3sU8ytlgP0cktRRRe4y6ohiQ4VyrIQJtlmSXu990oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973088; c=relaxed/simple;
	bh=lw0qK5Y5enTL4yiuOyWunnaq/ADfKKe6VIfzVmc9Cyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fpdh3WlueU5uWgfjIGxkPCeq21PT0BcW5XxmteLERgUMg4IlfABmio8Omt3OAPuYEwTa+vOPoo5q9D9u5kALpZSpFNrbwaQePEMTq+rsBkVohjQXuLF/rwK0BkYZYbeBafCPnX78oov249jBveWJHkjIbAaA93FEZ+pFGDsxncI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmlDmYGs; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmlDmYGs"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d029f346eso1635361f8f.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 09:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774973085; cv=none;
        d=google.com; s=arc-20240605;
        b=Voejec0VQbVXqZZtM0bzYBtBQgNIdAruJ1sBKY0osYuOlVw0KXfTbIAUn8BnWUuotO
         rWfksCkcEjlvYgJ0U11q47I6rZqy4OZBHvfsorN9lmw8Ws3rIsmUtZX5bt0ZplNdZyvf
         sqgPazyRY8MofiJros6hxx9Aa8P8Oeh8/AdVE/Ma5cUEFkQdH39v9e+TAcrf3MgyrpJL
         pp6mU4JB4FmoNLgbG6PSaNrykLHPLP9g2l9WdbND7voI5Xi9Qt7GNgSVhBqkcQjABM98
         mYjsdW1SgELH2MPdqCBQcWe7k0bqOwzbUKDTrwjVzwIFRgtJXARc9CcaISAmXubJ90Bf
         nEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h9ZEEGIEi/p0o0CpUmmHqjNx4ZeZTOadC6J6tXu+ypg=;
        fh=vzihIXXCxZ8unB1XnnG0tvnPi8NPeVv18W6Pb8R1IjE=;
        b=LFs/BysEKLXPyaGVixGstrf64tLQNvVTMsXF+0oL7VyZ1M2fyTN2SZcrTJWkKyOEld
         hP/0VeSbVKgHaB3IgR5cgpm4IwL3QNowOz0vDt0+ciftFod6vmTI4/jzop+LI5a6XO23
         PesAoE30K5/nHflARmGrmc7ShVuqSkBcTr8bQ5Wxqv/9qbAkbQk5ACFMXbYWccoXt0F3
         DJKJfTu8yEouPMsS3PGVTZl00Cpxe/UT/TO5+5zSrpRCxnOMfxsR8w0YqkijBe/QP8um
         g+2/E9/ClaG97D+edFq2OTbJBE5NXQihXB3ISK2gvznEoX/j6hjxPuPad6fCY3wie/2J
         LNTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774973085; x=1775577885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9ZEEGIEi/p0o0CpUmmHqjNx4ZeZTOadC6J6tXu+ypg=;
        b=GmlDmYGsN3T9eFPq6aZ2gquEkYXF9l3GAgJqKFCPy4uTmK2XUYIuZyHBQyjgyKmjvc
         Jkhv3A9svFGenrOQd60EOy6kw1Hfjw1G+mawvbNnRqOrn9OMefOTOTVgDzgqZgU3yUZn
         SQquE5t6+U8eT0lNH0faHfq+ZIp/RgFG1VzgdA9MZEFndM8JkqUZRBGLOuLdkcsGB8Qg
         LsB0tVbhXM6IFyAlIAIOQCYAPFIwsdbejL0gOXCpBhV1vENgcJGJ/98MjiSL5hqtFJEX
         T7r3laf/xPrEiZDk7NRWJOBjdbshStt1wzkVph6YMxBmATq+AYVW0mYXe8ercOP3Mv9a
         3m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774973085; x=1775577885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h9ZEEGIEi/p0o0CpUmmHqjNx4ZeZTOadC6J6tXu+ypg=;
        b=CdfPraAfzRpHzwdhmqjD2iRYRPcOWFSW4fMB9OLMB9MJNvDEHPIFRpSXPdlzyLu1HJ
         N06xZj18nzzM1HFqXHxy0MooQPnFD60sjgJaaqsTf+lO5vaEHw6IJz1TvWxGYVCRYvCh
         /w6uaa+0lySqnQytfiTSsoYiBnVr9iOBMBaFozng8VIqA6Y14cVD3i43xcgE8htZnRWq
         Ce723524/t0hGM4VarWCe7mSCpGDVmDtTOusYC42aJ6Z4lAwpUbPWPrnYzK9fILcCflM
         ujhl2lefpM2mjoDUnCkAhlrqaFt0z2Oaj+tjaQlWP7KJxF16BZjZA4fSzTCsrawrC1Th
         aXQw==
X-Forwarded-Encrypted: i=1; AJvYcCUyounZkFAsszQBqfXjeqpwjwtbM+26O7EFx1aLJ6Pfm5di2s4boMHLM4D+9grlmZpgzRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/G3bdUZfQxF38Wki2nVpiHTzyUmR8YQHaE9cwb5oDhmVN8t9
	lDFnbHkrcLOltV6l07+fS8HM0LQG+UBFLSzPGyhAgSMPYmPGRr/D3N4DduM5bHduUXfZQyfaBwR
	P4IM5pZvZ5lfb6QG7u/rlLzLtEb1HHEo=
X-Gm-Gg: ATEYQzxBiucF9v32K4oIApetps8zeQV6MzaDu8FV0UCwpb4RHA+Beos+3KklZiR1vTg
	9Uwxlf72b5VeLt+X4HqS5AMD99MdOuusWSgCrIdjMXqTC+V4KhUPJEZ28Ko2XmF9MF2zqwd+Tna
	eKeVo/Otq0H5ahnBNnxmbY9+WHVZq0nggGsdEOTVzmvKrPB3poBtMn+pXf+DG1O0bh/kidhb6bb
	Jmul5Uppx52KCuQK9JGfpGA/pin9JR6SZ9Ayb4x/E5QGtw/trmldj8s5rMujyxigG2JVh55FxSK
	naHZz53GsxWL+5SWO4OAkOXD58f7lEjL1wuTzZxW78jCfMmZ0c1z/A6LGffcNG3fMltTepCO4/Q
	6qptby7RBekNZRbYW887HttXg+CmJk2XxQ0rm
X-Received: by 2002:a05:6000:2886:b0:43b:4e13:221f with SMTP id
 ffacd0b85a97d-43d150df39cmr297837f8f.47.1774973085077; Tue, 31 Mar 2026
 09:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331005215.2813492-1-memxor@gmail.com> <20260331005215.2813492-2-memxor@gmail.com>
 <CAADnVQKP3bmuDP2NzKYhU776RFVuN4fOs3y-kyQ8AFzsoK3_2A@mail.gmail.com> <20260331120329.7126fe6a@gandalf.local.home>
In-Reply-To: <20260331120329.7126fe6a@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Mar 2026 09:04:33 -0700
X-Gm-Features: AQROBzA7CXezpa4ebEgnr7LuXNaCCCbqemQl0W4e6niI9av8I6Tp-wHBMfp4OLI
Message-ID: <CAADnVQLjsJCyPBXdEy5A0r_es8wyDJVFXJh+PNU2dMVUMD0DJA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/1] bpf: Fix grace period wait for tracepoint bpf_link
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 9:02=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 31 Mar 2026 08:27:22 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > > index 22ca1c8b54f3..8d6df1e7b5da 100644
> > > --- a/include/linux/tracepoint.h
> > > +++ b/include/linux/tracepoint.h
> > > @@ -122,6 +122,11 @@ static inline bool tracepoint_is_faultable(struc=
t tracepoint *tp)
> > >  {
> > >         return tp->ext && tp->ext->faultable;
> > >  }
> > > +static inline void call_tracepoint_unregister_non_faultable(struct r=
cu_head *rcu,
> > > +                                                           rcu_callb=
ack_t func)
> >
> > The name is too long. imo.
>
> Don't like typing? ;-)
>
> > call_tracepoint_srcu() ?
>
> I don't want "srcu" involved in the API. That's the internal workings and
> who knows, it may change in the future (like it did going from RCU to SRC=
U).

so? When it changes we can rename it to.
I don't think "srcu" part of the name leaking anything.
