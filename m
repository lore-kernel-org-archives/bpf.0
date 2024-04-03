Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8215099B
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167445; cv=none; b=ow09zosFBq0wIdU970Hpfhu+qzGKxfpwueULXxdOjWFPD/vy3q6S4Ov8h1M67JUnkVcybzJQuB0Iyid5dmWnM41ufYZYGxN0P++Ur/q4Xi/keh+HCqV0WzODGgD54WhWJGwAkssTgPLzo88OijfAASTxB7clDU/sLJGG3XiOIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167445; c=relaxed/simple;
	bh=1IMF6BGwB7yvJiD+vJxWuyk49Lrim3u/u8H5ncSsgKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGg40iLipo9MZv0DaarVdWgLH0T9K96Sa+uE1eU0YTyjwIM3+YwMuSqx4VaBQui17SIwXLplNYouq+yv4Mp72Dwz+FAF4aeSdg3szikUZGtM3CQMfiIRsi+mP3PxjsAADiNNXtLN70uxcgrgnbZgN4ex4OTbXzM35NmXsljBpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqoMCnvp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqoMCnvp"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so133673a12.1
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712167443; x=1712772243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6E0op5atVf282kzfZdwclN03sqG79t2wDVepZU5o94=;
        b=fqoMCnvpAVqkWpDFVnv6nPxPjJRM3KlZwa8/jE8WkygQtMD+9tNCCYQ2LBUQuLIpD+
         mWaqSZU9PMInBiL91CqWipCouAQvNjLoeSZMIIPdlqv7mGywm83PTM+q/+n4r/kHB9Ak
         HIus5eKpfZXjyUlHvO8c4/9USj5b/2SAkwEdsl7qsQixa6gvqrD4psNfFVeOKdrbw0fE
         fx2W1XZAlZz3N9eAxthMdOshCTPXQZQyzyxrne3MqKk2VK0YQPpmMPVpjJLkmuboYfpO
         Er88Uu++D1lvTaz+Ud2MuxN4RoTlG5US7AH19DTYaeoVdAqC0FzS+/JCVb/+qhJbvfFS
         wMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712167443; x=1712772243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6E0op5atVf282kzfZdwclN03sqG79t2wDVepZU5o94=;
        b=IC7+hxjy6rOz0ukW4BhjDN7ZeTxEHz/jbwg07fISiyH+JE30lt/H2jElKuARtfMU6f
         yfkZyyGJekQPjuwhAo68/F/EWR9rqfCcmHp9qWTtc+i1rRNhE/DMUp10F/h3TFETRdX0
         4brSCEMMImA0yr9oo7G/R7kl5loheiXSOgwWVkR80zEo/UBJ4vuv8S6WBz1Gaqv1FLGi
         RS3Jjfpawi5XQWAjhNMAgZFrN42OtqvpF45YJpRslEkE2vORDRbWJ0KzTT+G44w8gyFn
         nVd13DdL+Wma9r53D5t/4G5H3TAp6sBI5xntCkdkLmIXcAkr5MyWqbPA/ilmRLqIQ+f7
         Btrg==
X-Forwarded-Encrypted: i=1; AJvYcCXW2u5xxXfUfM98ddwvfgKrLIyQ+LxoPYKNsjBKm2xg426PQgZGMai9eOsvhRAI7/JM+sWeC+4IohkSCgEZozOIwIdZ
X-Gm-Message-State: AOJu0YxcrbK6zXybwY3XkoKc/ekaOMnXsSsqkozeFqhvpGcQGN5mMxTG
	TLF5dbey7XeMEgLWPIzZe3zmseJnPifn1GtMDsWZrSw1iWp4rVQpp/mX911712jQbziWrDcSHqB
	Ep+/qTdjvYoTt+vefZHmmHDUXKp8=
X-Google-Smtp-Source: AGHT+IGxIqVigwW8HoshQ462+/BE55Nla5G15a2FVpbjqPjv2+p+OHMXF/uU2RuO25cdggRtIOvZ4s2Fg4/+Dz5SR9o=
X-Received: by 2002:a17:90a:f283:b0:2a2:b32c:dc5b with SMTP id
 fs3-20020a17090af28300b002a2b32cdc5bmr284125pjb.10.1712167443324; Wed, 03 Apr
 2024 11:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402021307.1012571-1-andrii@kernel.org> <CAADnVQLDBhypHuyS4UXnsMYGP7xCLWGBB9jdXuiqG+ddoX95Mw@mail.gmail.com>
In-Reply-To: <CAADnVQLDBhypHuyS4UXnsMYGP7xCLWGBB9jdXuiqG+ddoX95Mw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 11:03:51 -0700
Message-ID: <CAEf4BzZdJnR+crpz2QWODPOxi3VHazyBAY7EH-EyL_fQgNXA1g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 10:41=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 1, 2024 at 7:13=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > Add a new BPF instruction for resolving per-CPU memory addresses.
> >
> > New instruction is a special form of BPF_ALU64 | BPF_MOV | BPF_DW, with
> > insns->off set to BPF_ADDR_PERCPU (=3D=3D -1). It resolves provided per=
-CPU offset
> > to an absolute address where per-CPU data resides for "this" CPU.
>
> Fixed the typo s/BPF_DW/BPF_X/ while applying.

Oops, thanks!

>
> I'm still a bit worried that there is no BUILD_BUG_ON

BUILD_BUG_ON is problematic, because those gen_lookup callbacks are
compiled on 32-bit arches just fine (just not used). I'm totally fine
adding extra checks as a follow up. Let's just agree on some
consistent approach her?

See [0] for the verifier check I mentioned. I can

a) add #ifdef guards around all current gen_lookup callbacks to only
build them on 64-bit arches

or

b) add runtime checks inside get_lookup to return -EOPNOTSUPP if
architecture isn't 64-bit.

I don't particularly care which one, I care that it's done for all
callbacks if we are doing this. Please let me know your preference.

  [0] https://github.com/torvalds/linux/blob/master/kernel/bpf/verifier.c#L=
19942-L19946

> for 32-bit archs while both array and htab perpu gen_lookup
> assume sizeof(void*) =3D=3D 8 in few places:
> htab:
>         *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
>
> array:
>         *insn++ =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
>         *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
> Worth following up or I'm overthinking this?

I don't know, maybe? :) See above.
