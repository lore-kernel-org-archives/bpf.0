Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6609225403
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183343; cv=pass; b=bg8un7lSR2u1OjykDpUdyOHB1Zrp32zX7x/NLVy4cZla9xoZ+iRdUnuDc8qCUXoNPZNfG/WwupZZeYS9RvL2eb4osk1AZk5q54EiGAuG0jnQjxGhXI8R5G1kxXTQN+F6bn6vAA3RkSlLfwTMS1siOLnO592P7MCnZr8xydsAxEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183343; c=relaxed/simple;
	bh=wbxl0bgF1sSxaA2JQJtQrTW7Ze0Vfjq5SyE1CLbRIXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbGvOToJfEHyL9iyMS+BEID2NwC0lXrAtY8fGUjITicd89YcgSsskrt5lemySJApx/DpvPdujv8NsYWwlG3Ya9T6hcS1gFToLesWyBmuC2ZnZaoS0QV3I+dqNqh+U4kXNUw3/021CDxYQQjcBK7T5mthJsuGd/WTcTsQ6P/g1xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZRDqslZ; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZRDqslZ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cfbd17589so1143901f8f.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775183340; cv=none;
        d=google.com; s=arc-20240605;
        b=eQ27kiXIxE9EpQd5pBILpLyOutzLWoIyFuEOmUJNjjHNlU1PhilK2Lns42Djrx4oKl
         4rxg2bKQ8SrmphUcQqw8VBv8zIlorlloE4bVZPiW2dMnmR5sA/G0Q4ZgfmC1p1me4O/Y
         p/g3y+L3r6qaX3NIkelVOUKRCX3nf0kXs+JuE6tRPX+LLU52OpXf6mCECWHmkO33/ChD
         Mn7UDcRxFOMao6pYr22900cJ3BCPkHcWEi6bFC7RVPNDQmtereT4PL5Fjqghtp7ZPIuX
         apbtjz80kLmTy3ZVmX+K3XVtc9dd3sBsQ1S6lIpiA5gYlxmrpBKi2+wB7Ua5poA0Yjjf
         IECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GPo02vtzKLrikTiZ3UqTtFPklOMnKJ4QvLimJKLlyBY=;
        fh=yTtoZfGK0Zw6nrxMYJZe/ar7QhySQYru2hpeJMeJCR0=;
        b=JrKSrpmt10ntTqEDHb0ZIFj/AbpzjTfDVfqwSD+zxODFoxJ1oEB99AK6EyCFecS9Dm
         UaBhZpK7qUDJe8o9lziuflCV/oymLjVBaMg7rHb9MIGmI/Mw39WQWzmYVFJdUa/fG1ZW
         uOZWIiliY/7UMEiDC6J5BNNFopiqKY+0X6op8wWeOzb1s6AP4kys1zOV+oZvBSqmcP/V
         W6twE1G5YqfIpA8FIqLT5OZxaKYXSSTjQ4l8eAC6Yrd/wVaO3/n9VyHCAqg/USf/6bah
         peT9ss+jq2Y3JY2rnRZ5WfugsEsBpt9Ntq2C+xTTWh0jziadZbgyAIy0RmrXurPlS22Y
         vf8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775183340; x=1775788140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPo02vtzKLrikTiZ3UqTtFPklOMnKJ4QvLimJKLlyBY=;
        b=WZRDqslZRZtNePbb/OlBU80U3ESJ9veZOdOuXvMWdkQQMLRuQL8tIcPi5SNkvRgbOU
         g8VSBQmFXdK18t238l1O9vFkIMYHDjKKyZ5hVh4yDmpDi+8HVM8lyGFQZrdYjqi+F1dU
         eA3qaUA+J9nZJ/qz0pcT6O8uT62pTI3qX924UmUzwFf+Vb0hFyaxwq1Y4zOkLaAkiunc
         TOUz9efYXwhQA/rnPc+0IkZTNsEijJmRR9+XPzytlcm55/dHXruVZLfxZfTZL/2/WD3v
         oHLTfr61DRR/+whuUV1c1sJGstdBPIuSwEzNwr+bgQDhICxsHiGlHaLiSDyXJ2jlueAW
         JDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775183340; x=1775788140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GPo02vtzKLrikTiZ3UqTtFPklOMnKJ4QvLimJKLlyBY=;
        b=kER34R8vTb0bD4lbEIWRVKJKcy27Jj/lmaUYYSxHbTJa0HCdNZLt5XjNVvYyWI7xOi
         hyiNNibJx+tqX38Fc9njJexwgQSYykurz/+iQ+L0bFB/+Ym+dAuHnPBZmv2MveZ4HChh
         i7WpEd30tDivVNoy2PmqSEGlqZItoyM6v/0j0X+RfqOy4frAqilY56EY7fl18IKBR9aI
         bq/f6dOGBfRXFrxslDq7PmJDIrfK4AXSnKF1PXkXqtgFVLKMYTlu2fm6kSTcpTWSgwi9
         91QVXzGGb2NP0GWCXiHBl91/Jo3KAtllKZV5Mk20fCwM7JMLTGuE6nFo47K9vsyF7fYf
         5ugw==
X-Forwarded-Encrypted: i=1; AJvYcCWLbBs4TTNr+YXPuAXPze6LEM7vk2nmAjmn7WUG1d9V71srRMiKi0ZBkjEHSomrwmN9G5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyupHtzv7l6qHD0btrG4RBistOz3bi0dokURWCx100b3zwD0nlW
	CE1A7J555KPTDz0FeDK0PUW0myXlEffDcemVnMFx5zQbucXdkL6SzIeEA7FFbeCdyF1MhCYVnVG
	Hyv+xAHr4eXIW1h0wGdwg0eJDYyUBOvw=
X-Gm-Gg: AeBDietIwc6z6D0TQP26pibnq5dfMR/MYYMPIDNzT+18F3iCCK7Ch1fcSxZGiMpSgBT
	JGeyyMl3/yjbUPNC3YaJHcHa3UXZXMOgIiJy+OsdOvmAdxX02+aT1Wt+iUmtCLF8RwUFfVszLcU
	NO12r2EAGn/LgbGQ0TewrmgBqsRfiXPqtDqhAzqTcn3klPX+M1IhHqRfNcFiiAKhDSlHTknV693
	CFVbVmCwN6qjRCWJtkK+Fytujk+eXhl4JtTIEbyyFHKbG5ptOQWKe+3b56B1BKnfAYXoRYMGY1w
	enPvVDP899cTrlFInWNB5e4J/5WHTU0M+xRCQQY1t3KKN+OArGzefM26uCianEnbmtN/k+ohyv0
	e70Z1HWivO3ZlyDCGN/25DM0pKw==
X-Received: by 2002:a05:6000:24c9:b0:43b:4273:a6ce with SMTP id
 ffacd0b85a97d-43d2927f4a9mr1961246f8f.3.1775183339911; Thu, 02 Apr 2026
 19:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7653EEEC2BAB17DF+20260402073948.2185396-1-xulang@uniontech.com>
 <420FEEDDC768A4BE+20260402074236.2187154-1-xulang@uniontech.com>
 <CAADnVQJawYEk53kS9-w5EXU0GnUYWWW7AF_n02bUs-GPJ+4Raw@mail.gmail.com>
 <ac6ejZrcnfQfaTZS@devbig1721.ftw5.facebook.com> <CAADnVQLSUU8Yo1Wmym4B05jam6qqUPEXUDJpBH+00kjqkrYigw@mail.gmail.com>
 <ac7Afa6_HDzyAxSt@devbig1721.ftw5.facebook.com> <CAADnVQJv5qNL+ssShZ043DVobO7ecfMuZxa-t-CGiGL-XyK=PA@mail.gmail.com>
 <ac8ODClxZ83KZf-V@devbig1721.ftw5.facebook.com> <CAADnVQJAYE9_KoNrWQhTz0UOX5dwmqKL-m6H0S_o2ZmdScVPfQ@mail.gmail.com>
 <ac8jGJvsEHhwuMqI@devbig1721.ftw5.facebook.com>
In-Reply-To: <ac8jGJvsEHhwuMqI@devbig1721.ftw5.facebook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 19:28:47 -0700
X-Gm-Features: AQROBzCXoPHQD5w2Ry5H-LGT-J9owuecrje8DaHC43GoPtpspKrNq03v3YmAPhY
Message-ID: <CAADnVQ+RHa6JF2sp3ZsUzN0zM59L=deR2+k4k9ugLo27nJWKGA@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix OOB in pcpu_init_value
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: xulang <xulang@uniontech.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dongliang Mu <dzm91@hust.edu.cn>, Eduard <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>, kernel@uniontech.com, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 7:24=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On Thu, Apr 02, 2026 at 07:09:03PM -0700, Alexei Starovoitov wrote:
> > On Thu, Apr 2, 2026 at 7:00=E2=80=AFPM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> > >
> > > On Thu, Apr 02, 2026 at 05:05:14PM -0700, Alexei Starovoitov wrote:
> > > > On Thu, Apr 2, 2026 at 12:59=E2=80=AFPM Martin KaFai Lau <martin.la=
u@linux.dev> wrote:
> > > > >
> > > > > On Thu, Apr 02, 2026 at 11:36:04AM -0700, Alexei Starovoitov wrot=
e:
> > > > > > On Thu, Apr 2, 2026 at 10:01=E2=80=AFAM Martin KaFai Lau <marti=
n.lau@linux.dev> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 02, 2026 at 07:17:17AM -0700, Alexei Starovoitov =
wrote:
> > > > > > > > On Thu, Apr 2, 2026 at 12:43=E2=80=AFAM xulang <xulang@unio=
ntech.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Lang Xu <xulang@uniontech.com>
> > > > > > > > >
> > > > > > > > > An out-of-bounds read occurs when copying element from a
> > > > > > > > > BPF_MAP_TYPE_CGROUP_STORAGE map to another pcpu map with =
the
> > > > > > > > > same value_size that is not rounded up to 8 bytes.
> > > > > > > > >
> > > > > > > > > The issue happens when:
> > > > > > > > > 1. A CGROUP_STORAGE map is created with value_size not al=
igned to
> > > > > > > > >    8 bytes (e.g., 4 bytes)
> > > > > > > > > 2. A pcpu map is created with the same value_size (e.g., =
4 bytes)
> > > > > > > > > 3. Update element in 2 with data in 1
> > > > > > > > >
> > > > > > > > > pcpu_init_value assumes that all sources are rounded up t=
o 8 bytes,
> > > > > > > > > and invokes copy_map_value_long to make a data copy, Howe=
ver, the
> > > > > > > > > assumption doesn't stand since there are some cases where=
 the source
> > > > > > > > > may not be rounded up to 8 bytes, e.g., CGROUP_STORAGE,
> > > > > > > >
> > > > > > > > why? Just round it up there instead of penalizing perf ever=
ywhere.
> > > > > > > >
> > > > > > > > > skb->data.
> > > > > > > >
> > > > > > > > what that means?
> > > > > > > >
> > > > > > > > pcpu_init_value() can access skb->data ?
> > > > > > >
> > > > > > > After bound check, the skb->data can be used in
> > > > > > > bpf_map_update_elem(&percpu_lru_map, &key, skb_data, BPF_NOEX=
IST)
> > > > > > > which will call pcpu_init_value().
> > > > > >
> > > > > > I see, but if we round up on cgroup storage size the problem is=
 gone,
> > > > > > right?
> > > > >
> > > > > Right, it will fix the problem tested in patch 2 which
> > > > > passes cgroup_storage_value as the source to
> > > > > pcpu_init_value(). The bug should only manifest with BPF_NOEXIST.
> > > > > For BPF_EXIST, pcpu_copy_value() will be used and it
> > > > > currently uses copy_map_value() instead of copy_map_value_long().
> > > > >
> > > > > > Doesn't matter what the source of the copy is.
> > > > >
> > > > > I think the source (PTR_TO_*) matters here because the bug is abo=
ut
> > > > > reading beyond the boundary of the source. A few other map types
> > > > > were audited when their values were used as the source.
> > > > >
> > > > > For skb->data, using skb->data to reproduce is practically
> > > > > not possible because there should be at least shinfo beyond data_=
end,
> > > > > so some of shinfo may get copied to the pcpu map in the extreme c=
ase.
> > > >
> > > > Yes, but also the verifier checks that ptr + value_size is accessib=
le
> > > > in that source. In this case, that the value_size bytes are availab=
le in skb.
> > > > So if we round up early at cgroup storage creation time there is no=
 overrun.
> > >
> > > The verifier checks that src_ptr + value_size is accessible but the
> > > percpu's map->value_size is not rounded up to 8 bytes. If the percpu_=
map
> > > is created with 4 bytes value_size, the percpu_map->value_size will s=
tay at 4
> > > and verifier only checks that src + 4 is accessible.
> >
> > I meant that we can do:
> > map->value_size =3D round_up(map->value_size, 8);
> >
> > there is no promise that value_size at creation time is equal to
> > the one that the verifier uses and what is reported back to user space.
> > We could do that for hashmap too. I think...
>
> hmm... would it break the existing bpf programs? For example, my earlier
> data/data_end example will be rejected now because the verifier is
> expecting 8 bytes instead of 4 bytes from src.

Yes, but that is a broken bpf prog that accesses out of bounds.
It just happens to "work" today.
