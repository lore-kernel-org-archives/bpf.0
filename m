Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2E3AEF4F
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977367; cv=pass; b=t9mhM5JdnEHa3Fw0TLiapzZTPK+gnYUGBqmqd6KyA4khJEMMiuUwkoXku6XuaBjPY58iuojIVbC+W0jjrV/0Q1ilQE0RRpKnm92ZgPws1giUIPnAiynDzg1gFLCqronWrBGaS3FBesYUNUSV1RRGvUOfjudXoFsPgZSJYrUWGcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977367; c=relaxed/simple;
	bh=trvdI0a8VZHf/ha3bFoj3a3QxrObHtVi7lvVYGKC+uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIyVUDY6VLZ2CuwnWixB8H19aMSDPg4zMUXG/ESi/pI9SCo4d04aj3o7MKHVoGt9F4u8i70CW22NvzXMIRB7PHHZ6a0o6Bs80HLwYWEO2pO+vxAnB4+MqXkGVyaNM1LM+cQAQuhVfU9+vZWxbC1/QmsR7q4gjGkluce8geiSi10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOzBZC2y; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOzBZC2y"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0834769f0so42745055ad.2
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 22:36:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768977357; cv=none;
        d=google.com; s=arc-20240605;
        b=WbzofuQwkiBW1Ga/HJVeD5jiMSHGUcEu33IN1w4CnUmzNBHrrOKn5pDY7WwQ6bLFZk
         4jHjc8ElsK9srkpxlDezb2uQ9mGt5CMiumTcQNClJNyIf6u5T4eOTfikJjl8kY0lpKd7
         7sJIwmHEgMynLcr5ukzJx+dAgcAQv4UGyAGbAEgpoJRIxdyRKpLazacLq9F58WSdrBlf
         YvxG9uI9N8JjUkjxU1U0SdVgAP/0WFaLQWSO8+QWZVJ5SWaMUZl7xxKNGWb/tuee0/au
         gkUEaL1Jw/mbTwndmAhlzA0uXMF0jDtse3nxXJCWDrGTCSHWbFKBsly93zvRxFn2Ax0A
         jbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X7jj6Vi4WLaF0iL4b2JIgloeXSGsPUxXEpOTubxKuMo=;
        fh=Mn6ToR90jDXpvUrIfU447J2IvaJEuDKz+Hky5KP3QKc=;
        b=jFXsDMtNoDfUA2vdXMXQ4qXQ0e9OKPTfwtTsU6VE/o8vWSkR2VC2n4A+xETatI8ByZ
         CDkfuQpmfquJAaxpgZRuHpwH8T0/ScG5BgfijvDvkreWo+3SrQ+PvJM3Fry4kDYasm7b
         J3EgZq62f4/szugUgx1c4jdIqHJypes1n7o2/IM265xvPh+GJio4eZXt6S6AidIU02o3
         OaWLgzK94YY04jQZbBaNbjukid9OPUw4isiR4cVsUnWqwN1lIB/wmPE/obv5/hWaHLja
         WoA0IuzPyn0SmpHmq41Y2ZOwprREk1ZYJK+zMdy7aq9jaE40t4+bE8kMgruttsHJU+sJ
         Aaxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768977357; x=1769582157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7jj6Vi4WLaF0iL4b2JIgloeXSGsPUxXEpOTubxKuMo=;
        b=cOzBZC2yVNULrKqFjBhck9VyIljo8eqn0CvPqIw1N1omamZ/Rzw80TkktbZNiyGwPt
         ToBn7p5LjS5Pp4Ex7IVTbNkKVrmIUw/kiKFnre6Az7IloyRixW6OvEn62xgDXR/GbTHI
         Zw0mDefmtSGaOfICnJ2AkFAgkwSs2/HnWMkIzHGzZRVE37y5wDUTd5f4DzX+pSZrpE5R
         eNei9wScYliV1ranCXSzMk6cljsWqNu1Vhu3hhnuamZc/ZJxIdQ05D0PMY77LHUGdxCu
         5Q28Wnh9nnAq+fBQGCug9FyKBpZyQtCU0rZITqN+3NvskS2j2sB58n+F7obNUV3G8/Fu
         x65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768977357; x=1769582157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7jj6Vi4WLaF0iL4b2JIgloeXSGsPUxXEpOTubxKuMo=;
        b=HrnDK7rqMRSaY+878MEBR860dCsG0vh+15Bmt6Y99t2c+7c4uafocPagDw2OLYf5mM
         U2NcXcVoXIS2u85VeAv0+REHNRvh6Ga+uHgNdnaGXuWRurA/BJeyqEyiJcImVDM28W/2
         wHRzDi+Jeg4GUL34kS4WEfKJl4i9zFVEKxrEDnSZ6Vtx9YpKEkyiol3v7OM1LokoXW4t
         JZSNzCByjNtpWbd32mZUiw3I4X5dMeOoHcmmN80A6yQwfTwA7EkMShU7FD92osISH9tc
         5M+TyNfl1vZh5rBC8bs5LUShcMaiIYUU+R65cSKbY2tH8ZQhAxumuVtV9ZHjT6yqBpVu
         tBcA==
X-Forwarded-Encrypted: i=1; AJvYcCUnhcXZVwXD/T/zKrPwS6xT0Y+jwW2WXvT9M6FdAaBpig2/r8cBPtMJMUAyD+TcjP0o2Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6KBP3coErrSE7grppxO98UxzzY4Myh1IcTR/vm3odZslgT7YR
	a9ufUSHK2iLZoVyaJ1rY3DGIeYcRkI8YJSoEAXHcvvelODACr9otTuoSmdLdp44V9eJ2KZ0W74J
	0i1bPZGvzAzHx6riK7EH/2c1k3HTwe1g=
X-Gm-Gg: AZuq6aKg+RlqDspls4V8sG5I7RQaKnIJto3z/HgN2Wz6eJowmPQuLjj71EgAvkvtRBS
	KcW2pVW4XVgOZ8BWdxwX9e+W9HQ6ODMG5yHrN6k684vUvp8uwQJ07m9jL31QmJIjyokGJOBpjmf
	OhWUed7I2KGAJ+DlwJL8dwFRihGHJKWagVKHpogwOptMZ9wZWl4jY3C+gEqJeRXNdil8O3d/6gE
	my2jeJSndxVDCL604Es5CPeDk02OwK1u+AWhR5cwTlqn6hQqq5MNHhQZynMhIFiZcl++gI=
X-Received: by 2002:a17:902:d4d2:b0:2a0:acca:f3f0 with SMTP id
 d9443c01a7336-2a71893cddcmr150614405ad.49.1768977356681; Tue, 20 Jan 2026
 22:35:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <20260120070555.233486-2-dongml2@chinatelecom.cn> <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
 <10788751.nUPlyArG6x@7940hx> <CAADnVQ+Om14RF1GvA0vkhKdsCtVGzbacftEZarLJ-LKdYXUZ+g@mail.gmail.com>
 <CAEf4BzbVGx+0vn6n9T3rpePN7D4Mm54Xzc1spdSjvmrj1mV-0Q@mail.gmail.com> <CAADnVQJZ=OSrQZn4Dk6iK0Os9Uxa5CgLXwjcSh4qOq95xx0uHQ@mail.gmail.com>
In-Reply-To: <CAADnVQJZ=OSrQZn4Dk6iK0Os9Uxa5CgLXwjcSh4qOq95xx0uHQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Jan 2026 22:35:44 -0800
X-Gm-Features: AZwV_QjOr_ehj8PtJmMMlBQZTUy6a8f_4Wha0__70LtdJHYQqw_Mxp7ZpXy9RnM
Message-ID: <CAEf4BzbER285+j+DLsRdTyw1z_f=6-DYW8k88ehqi_mNW4Kv_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 8:46=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 20, 2026 at 8:12=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > >
> > > Looking at the patch again. I think it's fine as-is.
> > > fastcall can be a follow up.
> >
> > Yeah, it's fine as is. But it still seems like
>
> Thanks!
>
> > verifier_inlines_helper_call() is an unnecessary extra hop we can
> > remove (even if it has to stay arch-specific).
>
> I'm not sure that we can, since it's used in two places:
> get_call_summary():
>                 cs->fastcall =3D fn->allow_fastcall &&
>                                (verifier_inlines_helper_call(env, call->i=
mm) ||
>                                 bpf_jit_inlines_helper_call(call->imm));

well then, just ignore me :)
