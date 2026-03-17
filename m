Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579A942A80
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773380; cv=none; b=By5xj9yznoAYRo2biAXb/TTcIn0mhrs1pqI43hKuMrxsoJKkaGlgal+d/wkj42ikL3E4UCMcprkhSpiCD1kqSeaadWCTV+1b00TzW1183HcUbcDzOrikGdhulTVJCZ5rKFgcRsVaTgi/cb6gTG+oK2fg6av1lvKaxg1Jvz+PpYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773380; c=relaxed/simple;
	bh=gn4xRhGUeUFSqpXwVFn4olG8Lc/o5U5g9uUQbuHmFrQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBXpoE3xuRHXU2KvcU3ou/JyG6McZfu5s3/CruC/qSNbupfub6QLtqWEcH0lKtA8N3gPF52GszCoBCOlmYBQs76wlkmlhDLQl9RgAdmNNRCq3I9UIQJ+WS5QpVz9H7mzgL4tvUREY8XiPFbWw4V1WSrEYGgDqqhmd3IBrIHf6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGThrhZ3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGThrhZ3"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82748257f5fso119728b3a.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773379; x=1774378179; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gn4xRhGUeUFSqpXwVFn4olG8Lc/o5U5g9uUQbuHmFrQ=;
        b=bGThrhZ3iIU9T+FWRxPHnh5lHqDFZRRmRQeScJpqa85lV/yx1EO2W6lpQ0tdHq8Pzu
         psjvnSddvYs/JGw4VJrVMmMEZK87PAkYNiaJMZvhGL479vi3HMm8wev3yqbDuX+YXb6M
         t5CxDJAH1DQ9cC92ZYjoAud+hnTKXbVDX8Cs32HWan7RgEaWL0k5A1CssD/h1GGf1FaX
         OtmerThvm+jP3c6kcS67SQlxxLb4GlPbbKp+g0tY8Qsvz9g8R/qy1c4bpOziht1NBp53
         3Q9cIEp2TgHkt/vCwcAMFNYQlf3WQCXgbq9u9mDbt5zBuPpvZva5vDGUXgD2CWfhxk6/
         eeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773379; x=1774378179;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gn4xRhGUeUFSqpXwVFn4olG8Lc/o5U5g9uUQbuHmFrQ=;
        b=KQQ5SMUQiY8mClne6MwUN20XJxRF4oGyaq0b7HiTekPsHoqRfsr6qq9BI1Fc6QZi48
         YulCR58rU1rZnozSV2hgnRWTLRU+BocNhg7wGoWWzyaGZ+fXptnYi+/Rrus9r4Feu4QY
         LwMa4E3LFtuqNrXBtnGf3qRoOncBw/NenS36wQCJnhJIi7U5Vdg1N0W7hxhV/Do1Oa4e
         7omJ052AinpIsFM8mOICbmNIl5S8omDgtMUcuwck6UnM+mC5gcA+/wH6oYZbJfhX00Eq
         zYeLlH67QfCUy4DfFaq34WRcGM1rR8OKJK344jz7xM/Re3lfT7hUiiv8h6m1j87hZqXV
         mNRA==
X-Gm-Message-State: AOJu0YxhB5LYKqjHja6oCU3jsTy0Ae4d3DBg4W+9wLmugk1nIYVXpfse
	v38eB0BS3rtuMwsa1nYAObmLJStngekYMOZ1vI/6pM3BCJHmaA49A5t7
X-Gm-Gg: ATEYQzzhPnB8xZnxRKV+9O5BhnuHe4eVhiKvk/NPkTahCu5omVgRg3vGzY8aTD3vwZQ
	S6E8Pmjg4tUjyHlKgKtTShcKPdXix9ig6Tr+xhiyL7ZwU2pgBrDp7qBsD9WTv7AB6aiveKUlVFE
	IkMLLMA9+l/RHJa9cBwVvHiOtZSrbIh2HoDKx6SorwBeHlTCAxz3+xCnIROQMSJrnQcnS1SELJI
	cgJaXNWrV8SMW3WPsvsEFoMyqpYgUrkPFPHDwKzVVNVzz8SBRBVLSU+j4FoIzsUhAefa8/3qZOu
	MXaQHcbRnpM077582X7JRT94U0PLlgBspSq/vCihgqRw06dFNDTvCu4jN3EyAJjf+9goJfK50aG
	XvkaqDVsuj8BfKnntTxWz9HG8nuIVXzG0VoN2s5GVEWyn12Srrjp5rJ+/WLuOxve0/tkIReQ66N
	4sbiLx9YUFjYTpzmKwd449oogcSJJE5Nj/c085QmTxSZuP43Mwryem
X-Received: by 2002:a05:6a20:d43:b0:398:5f66:bf59 with SMTP id adf61e73a8af0-39b7e0766e4mr3735686637.36.1773773378682;
        Tue, 17 Mar 2026 11:49:38 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e546877sm328725a12.17.2026.03.17.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 11:49:38 -0700 (PDT)
Message-ID: <c867fba43c9182113604fa2435abff782bea254c.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 05/11] bpf: Preserve reg->id of pointer
 objects after null-check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Martin
 KaFai Lau <martin.lau@kernel.org>, Kernel Team	 <kernel-team@meta.com>
Date: Tue, 17 Mar 2026 11:49:35 -0700
In-Reply-To: <CAMB2axOmWD8oDc-TVxS2NzWjvvwXCo+N-kyqj2UWV8OTe5_yiw@mail.gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
	 <20260307064439.3247440-6-ameryhung@gmail.com>
	 <CAADnVQKkXKyqqW5zFC+N2NaU+7wD1XouqF9T=ReNivCKDWcFiQ@mail.gmail.com>
	 <CAADnVQLCKi_QL1FeybW+6MH6FAOAoRJyW06UvtX3my3yNSH5eQ@mail.gmail.com>
	 <CAMB2axOmWD8oDc-TVxS2NzWjvvwXCo+N-kyqj2UWV8OTe5_yiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-11 at 16:46 -0700, Amery Hung wrote:
> On Wed, Mar 11, 2026 at 3:30=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >=20
> > On Wed, Mar 11, 2026 at 3:26=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:

[...]

> > One more thing...
> >=20
> > How does it interact with reg_is_init_pkt_pointer() ?
> >=20
> > That pointer has to have id =3D=3D 0.
>=20
> I haven't looked deep into the case. Currently, skb is non-referenced
> for non-qdisc programs, so skb dynptr won't need to track it.
>=20
> If there is ever a need to track it, we can assign a reserved non-zero
> id to the unmodified pkt pointer. For reg_is_init_pkt_pointer(), it is
> already checking tnum_equals_const(reg->var_off, 0), so maybe it is
> fine to drop the id check (not sure).

Looks like dropping id =3D=3D 0 check in reg_is_init_pkt_pointer() should b=
e fine.
