Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7056934DB46
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591165; cv=pass; b=gVj1xdGEo2lAIjg6IsJSvFTa1PD3gFu004Oznwc27iBF/jJiASyzk9PTROBT9XhDz/QIJ57YL22YqADEp+6b7QpN9OC27o/wkXLzYxos2MQuyxVfu7FciYEzK/NfiyTEJ+dYaEa2BYlcdUGB0F/eML0d1K8yUrGNryUwtXNTeLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591165; c=relaxed/simple;
	bh=rZrOapVhh7bAQfoXj2OXroZMrCCdA2fZ7ZeRVhUp7Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDnXE2jqlS9vMvVXKpfQVvU36HDS7bgyF49q3uw5yd2ANd6arStSsB6TIMP2H1t8tcPV85KuY85WsZUPbL3rhFIP5FeWADECRUyEj4wCGFwaaULqDinG8Y0UeqPRMmMLWNbBM3q17CSkoIc6XBK8QQrtLDE+gxF8eAAkNUcQr70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXUl7smz; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXUl7smz"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45efa80e0afso777246f8f.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 09:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780591163; cv=none;
        d=google.com; s=arc-20240605;
        b=BUOlTzWz6zfGGsir9eA5CS7QGf+v4XroJOK5nkZvcHe1n2Ph2HHCqCqePz3VKTJeDn
         KavXRLxUywHpKYAZucsdfYkEBP59+0yHwqgzGaS5Ki+OCLkdoNzw5/xSHbqrIHLWDmwc
         XuX5vIhjx5HWDFonqn4zzwXPjEQDvg5nkNi6pOKiaPutvFB92P2HHpnLwDO1BLnWbOiX
         uJSoBOyL03v/JVyZrBNO+aSsoPSQTdwGdphxRHghNXQFJACnCnAw0mRyBRv93rmJxVZn
         LTSMbTP26osaJmh/gQwAo55Ww6SZa5K7j7CwZkgv0qxdtR/mP2x91XW9RfddJZfACfTU
         zu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y8LMcduT/17PMqU1lFdgOWZo3/kRhoF2Flu1HFP3MqQ=;
        fh=IT6wHR/s3RkLscxYMiLhXM5oR9AgW43OubDWFkCpsys=;
        b=YVMAkksvqcupWqhNxyNnkcIelUmZ0WT1LaSuJLgbODLKCeum4a0NXQigU5jodn3tCB
         HI97sGBCyNTf4Q3M6+sJMcG8Fe2sn1o6uHgK8jjuRK2+qo+n09kpK29v/n2pmNR7XTfL
         QoCgscG35EXyOrk82lV7eJsPwJdnMWqWHBKwCc5HXj5bdQoYrLBpxfpqQhrtWfhuZ/xH
         AWBALzXa+7m7MoAYZ+UgYJHco3NsQcmpYOw6CosigcTWJMzDhYecJdhhjDU5qn8Y+hlX
         tmoh5RjHA3rTWIbEpzXiZ2rDm/+FBniA+d3xuE+MHtcqJgkowps22cMFYQFY9hPdJWv8
         l/tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780591163; x=1781195963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8LMcduT/17PMqU1lFdgOWZo3/kRhoF2Flu1HFP3MqQ=;
        b=DXUl7smzUJXc+LyZ+byXgEwwBM+PnGwKEhFBjerWx0CZ6yMBCjB8nbHeSrf3bST1LJ
         vGzZxclCqoRZ40RItUHqC1KsApSbTvo01ZnPzdFsVCaUed5tFbI+uSY/FU6J1Nfnd9/p
         90ll8IEu/c0IqSQp7tsVBtwTvt55oHLg6jSgkkJIT9i/fa9aTXB9MjQkB/qAnF6XDrQV
         bvhVhzkc7JSWoIEKphtEM/Q1y7EenZUVIT+XnwmORdqD8dea+ZP23kRafF03Jld9angn
         Ywd/f68FmdED9+ET2x4cZUCBGewDX87bxiBoeMYfsNtOGLrFt5mWuhjTLodQk0BGbDDT
         uc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780591163; x=1781195963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y8LMcduT/17PMqU1lFdgOWZo3/kRhoF2Flu1HFP3MqQ=;
        b=A6HxzkO72Wt3uhsqNWQe68QG0r6EQ7c4hXFzHM40TUSMf26qdskW00Sra1Qv97PLL/
         w9p57rmQWpNuzZe8YiCFPiwPbSjV2od8C34By0zgTMvULNBLfhy81LNhAkEWDwM62CYy
         EhyJ53OZGDEaxioH8uuAtH9jeSkWXoJAnCfL/d1bhH2ZyQI8Wg7e1JyiNosvFiRQ7NXt
         uGXRsxj52JT0G9zxamfFBzuIo2bDSCHcurJ6PynVhkuLpzzgTEFl4wGAwUucfpw8pUlC
         LEFfweEZfHBib+lV1vn+Ys8SxtBLp696y10eNK2qXNz+Gh+7hq6dbSoKJAtqwvvfob2X
         HaOg==
X-Forwarded-Encrypted: i=1; AFNElJ9w3O6l5MRICZePJPkzxCXIuxX3V9G7EommqhuO4aI7Tb4W5U5c1tWh10I//8orAFsnEYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpVzWLcEPvHp/Qrt6rUZA0B4/pggEIyGRiiL0f5cxybp5pi7KV
	uLNGMfmYtW7v8g/+R/7eQLplZGs1n3xJwnopeksIy2Qa6sX7I44r4a6+HKSotjOmnN7Gqk4vvsE
	qAwcRCUrQhtuG9sxBfGTnw8oAcjS5ryw=
X-Gm-Gg: Acq92OHpprPrLHHFGrkrGYUqXBwWnrcpsdyQQX8kYOPz6DyiQuPVAjkcRLbZPOUCD1U
	9qzpm1l41AZ37xX0W9FRdqxnCte/pG9+srLR/x+8KuJidm4cGyBM3ymZ5pS5ffmJe9wZLDHlw/Z
	1fnl7jCAcuak1lPgCFf/oSrx7OitnsLUEG34999AYCnZtB4ZRnvmiFOY9iiSrkG15+dxQm0G8qZ
	i7GR/AUVXbeBfunhqkXrQogglaH3d5u3cRwQbu5QBocgTEL8uAPfDBMRxla/tLvqjdPliUvBM41
	AvUYOdUykjgK7MUSCqazbYSeT5qwl/9KIhKV7DDb07b5+OA2qs0IBL4T6Ukstb02cBhlNxep3sx
	AZZvAKTXIEIq+xOdG6uFTiBLtSpcyhxLo8g==
X-Received: by 2002:a05:6000:e51:b0:44f:da08:18f2 with SMTP id
 ffacd0b85a97d-460216d7f47mr9949704f8f.12.1780591162684; Thu, 04 Jun 2026
 09:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604150505.99129-2-leon.hwang@linux.dev> <3e8f405c266d6f15cc2ffeb3ffbe3674b19633c43048c1942e9a33db86c4c811@mail.kernel.org>
In-Reply-To: <3e8f405c266d6f15cc2ffeb3ffbe3674b19633c43048c1942e9a33db86c4c811@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jun 2026 09:39:11 -0700
X-Gm-Features: AVVi8CeenQuWNrFsEls0PJ0cpVkjHQwRByowXv2QXRwXwDAMZKQvQDuBYwWHtB8
Message-ID: <CAADnVQJHCwcFQG5FiejiyTHEFBRGrKqaGAfwVZJXANWuP9rJww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Check tail zero of bpf_map_info
To: bot+bpf-ci@kernel.org
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Yuyang Huang <yuyanghuang@google.com>, KP Singh <kpsingh@kernel.org>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com, 
	Mykyta Yatsenko <yatsenko@meta.com>, Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 8:45=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 625a4366fe6d..1007fb7c87e9 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -5400,10 +5400,11 @@ static int bpf_map_get_info_by_fd(struct file *=
file,
> >  {
> >       struct bpf_map_info __user *uinfo =3D u64_to_user_ptr(attr->info.=
info);
> >       struct bpf_map_info info;
> > -     u32 info_len =3D attr->info.info_len;
> > +     u32 info_len =3D attr->info.info_len, len;
> >       int err;
> >
> > -     err =3D bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info)=
, info_len);
> > +     len =3D offsetofend(struct bpf_map_info, hash_size);
> > +     err =3D bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), len, info_le=
n);
>
> Does this change break the ABI for existing deployed binaries? Previously=
,
> expected_size was 104 (sizeof(info)). If an existing binary passes info_l=
en
> =3D 104 with uninitialized stack garbage in the 4-byte padding,
> bpf_check_uarg_tail_zero() would see actual_size <=3D expected_size (104 =
<=3D
> 104) and immediately return 0.
>
> By reducing expected_size to 100, actual_size > expected_size (104 > 100)=
,
> so bpf_check_uarg_tail_zero() will actively check the 4 padding bytes and
> return -E2BIG if they contain garbage. This rejects previously working
> applications.
>
> Additionally, does this actually protect against the stated future issue?
> If a future kernel adds a new 4-byte field, the struct size stays 104, an=
d
> the new kernel's expected_size will be 104. At that point, those old bugg=
y
> binaries passing info_len =3D 104 will once again hit the fast path
> (actual_size <=3D expected_size), skipping the check and allowing the
> uninitialized padding to be consumed as the new field.

bot's concerns are valid.
Let's add __u32 :32 to bpf_map_info at the same time.

pw-bot: cr
