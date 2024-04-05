Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265E16132B
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338320; cv=none; b=X39jh0+eL+ZEG0gVjO/D1Nqj9SSQWkbkFlqE77AzJVoRnTOGY8oll1Vdf4BM9EV6RpnIIoDedYdVTrhDQRByc4v6NLVN6ODeXMdf+ARdcPlZsKuTyDBoZTMSBHWWuKykldihKhXg1Y92j8TLSz7z/xzNUHRTpZ50OmXG3eNhB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338320; c=relaxed/simple;
	bh=pE13hyDBFU04tIPOusfd4GE28q/rqXK5MAqGgkLXmBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI0VbBja2OBsGUV52COOmNLb0BvYudIWV4bRp5OujVpuMxUcH3GojVf/A03Oqx3azXvvg389T9Z+s1XewEcTtxPzPSvqqSNaR/G8XGkijIA4FyIXrE6xWpzJJymZxZOUMeb8DGG672SRxeBre7WqawIHTrWJZHgo18Xbmce152A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7jzD7WZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7jzD7WZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so8726745ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712338318; x=1712943118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InjN0EynOGU7NuIYsjCLIEqwQe4PioEziabcsuIg3BE=;
        b=S7jzD7WZIyhiCQse/wes+l6K/MonMW/YkY2wPANj43wsHBj2dnyfhMrtrey1LGwoXM
         gCCSxiw4lbOXcqUZLPsYD4FLHnW4S5HUeJHr2cHsICmHspuC/BhJU2xmEsRYipcXV1QL
         EBkRJb3wuRmLsLa5uw8+YTbc1z8RlubM1BUlnMI3BDxgKrAes71ifyjuDmtS7s9IQSie
         csuN48HO/nIYdbemLNVIJ5jqcehkEeQjXjKVik1e9o/+nToPrvon6u4zY175dMWPOWMU
         ++KabomxtgmcwlqI9TZxPQzPAU/LJ9t1aUEZh/M5STtcFu1juzYvXjduRxfMdjVbLjlI
         jYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712338318; x=1712943118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InjN0EynOGU7NuIYsjCLIEqwQe4PioEziabcsuIg3BE=;
        b=PtYr0rRDGx0vitv98QypvBMXQxFRb+Oqh7KPhwk5FNPGPdSxPN3roDR6TCdMIm3aOS
         3HHwf4Ynj8xgVEpBIaQB7VAlaJSGH3zWXQdhQvOT7eE6gpUQeQeoFt80lygwTZFFgu3U
         kmQ4kwqbWRroAMDDNHPysUAkciNr+jL3SRiHZivptVVwLycTaIPnZUrZqTBKFxA8/gkc
         Ncr6lo2iz40/NoKtlXmLCU5/Gpbi5jSui+zDGbRpL7pEdI3bzoN5553O0LoxA0/m3qBB
         1Nb7+LjDAebiY8IYnKcVuNAHvL+tX3fuwUh/XXpPMGZstDgOWVgWQNxK2FGAJUA/zEV/
         3VGg==
X-Forwarded-Encrypted: i=1; AJvYcCV6c4+jprJW03kqjgNdUjifeNUQtNOQakYg+zZM8WIzONE80+JqVOjqRyWpDOQ2F30QE9w+5xm1baX6UL1uB8ejZsF+
X-Gm-Message-State: AOJu0YwbGJPJHu8xbtTF+bsifJButwf/l5dd870RfwfSjX+YKnyTx5Rp
	bCXbi2K7EQ4mhhPF6neKhm1Vjb0fmOsZ8jpBwb3Ms/qZC67NrPWpzd1de1h2dymXvDi9vBgKrlY
	CwEiWB7Cb3khs3hamrmdj6+OqD9Q=
X-Google-Smtp-Source: AGHT+IEazYTYitUMQTVxg4vpaIVt5W7gYQeNjeIfJbbDryqxwuWlbS9f2aShAzDFS3UOQxve9oSSZzW4KioqjaTdvNE=
X-Received: by 2002:a17:90a:1347:b0:2a2:f9d:f600 with SMTP id
 y7-20020a17090a134700b002a20f9df600mr1954727pjf.22.1712338318400; Fri, 05 Apr
 2024 10:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404100901.7d6bc10f@hermes.local> <3ae7e58f-e62f-4d53-8b39-6e3fe1810014@linux.dev>
 <20240404112710.25d4e99d@hermes.local> <CAEf4BzbHbXHixPAEJccnrgt5xtV+d1iyvQYdC8Dpzs3cWdCRcQ@mail.gmail.com>
 <20240404175258.363f441c@hermes.local>
In-Reply-To: <20240404175258.363f441c@hermes.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 10:31:46 -0700
Message-ID: <CAEf4BzaTNRsFbppS31XQmFv+yjqw1_JASheOdw-7H_bHL=6HGA@mail.gmail.com>
Subject: Re: vmlinux.h overlap/conflict with network protocol definitions
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, Luca Boccassi <bluca@debian.org>, daniel@iogearbox.net, 
	ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 5:53=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 4 Apr 2024 14:45:04 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > > > This is a known issue as currently vmlinux.h does not support macro=
s.
> > > > There are some efforts by Edward Zingerman to support this but this=
 has
> > > > not done yet. At the same time, you could have a trivial header fil=
e
> > > > like
> > > > https://github.com/torvalds/linux/blob/master/tools/testing/selftes=
ts/bpf/progs/bpf_tracing_net.h
> > > > to be used for bpf program and then your bpf program with vmlinux.h=
 can
> > > > have much easier CORE support.
> > >
> > >
> > > That is an example of header surgery which I would rather avoid havin=
g to carry
> > > as long term technical debt baggage.
> > >
> >
> > What's your ultimate goal? As Yonghong said, vmlinux.h is not
> > compatible with other headers. So you have to pick either using
> > vmlinux.h as a base + adding missing #define's (because those are not
> > recorded in types, so can't be put into vmlinux.h), or not use
> > vmlinux.h, use linux UAPI/internal headers and then use explicit CO-RE
> > helpers/attributes to make your application CO-RE-relocatable.
> >
> > It's not clear from your original email why exactly you wanted to
> > switch to vmlinux.h in the first place.
>
> Some backstory. There is not an existing TC filter for this, so the
> original developer had the idea of using BPF to do it.
>
> The program is a small BPF program to implement a TC filter that looks at
> SKB and does mapping to queue based on L3 (or L3/L4) header. So not heavi=
ly dependent
> on kernel data structure, but sk_buff is not necessarily stable; actual l=
ayout
> depends on kernel config.
>

If it's only a few fields from sk_buff that you need, you can define
your own minimal sk_buff definition with
__attribute__((preserve_access_index)) added to it. You don't have to
declare fields in the right order, just make sure that field types
match. E.g., something like:

struct sk_buff {
  unsigned char *head;
  unsigned char *data;
  struct sock *sock;
} __attribute__((preserve_access_index));

You can call it `struct sk_buff___mine` if you already include
sk_buff, to avoid the conflict. Libbpf will still understand that it
should match it to struct sk_buff in the kernel.

Alternatively, you can just use BPF_CORE_READ() macro on types you get
from kernel headers, even if they don't have that
preserve_access_index attribute.

Or, you can just use __builtin_preserve_access_index(&skb->len) to
access sk_buff's fields in CO-RE-relocatable way.

Or, you can have entire block within which all fields accesses will be
CO-RE-relocatable:

int len;

__builtin_preserve_access_index(({
    len =3D skb->len;
    /* other skb accesses here as well */
}));

Many ways to have bolted on CO-RE even without vmlinux.h. vmlinux.h is
convenient (apart from lack of #defines, but that's an orthogonal
problem), but by no means required for BPF CO-RE.


> But the evolution of BPF has made the old code unusable. I am trying to g=
et it working again,
> and cleanup to modern BPF by using BPF skeleton code.
>

That's a good idea independently from vmlinux.h, yep.

> Luca was one who had the suggestion about vmlinux.
>
> > Using bpftool to generate the header at build time is a bit icky,
> > because it will look at sysfs on the build system, which is from the
> > running kernel. But a build system's kernel might be some ancient LTS,
> > and even be a completely different kconfig/build/distro from the actual
> > runtime one.
> >
> > We have ran in the same problem in systemd recently, and the solution
> > is to have distros publish the vmlinux.h together with the kernel
> > image/headers, that way we can rely on the fact that by build-depending
> > on the right kernel package we get exactly the generated vmlinux.h that
> > we want. This has already happened in Centos, Debian, Fedora and Arch,
> > and I am trying to get Ubuntu onboard too.
> >
> > The annoying thing is that every distro packages differently, so the
> > path needs to be configurable with a meson option.
> >
> > Feel free to pilfer the systemd meson glue:
> >
> > https://github.com/systemd/systemd/pull/26826/commits/d917079e7e320aa28=
1fc4ad6f8073b0814b9cb13
> >
> > It's of course file to go to the runtime kernel if no vmlinux.h is
> > specified, as a fallback, which is going to be useful for developers
> > machines.
> >
> > --
> > Kind regards,
> > Luca Boccassi
>
>
>
