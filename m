Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70138F935
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777233505; cv=pass; b=BRNQlAgy00iH59IRq0NC5vvMswY+AUsFXWlD6gwSImIxOpW0L/60lW2bYdDkPk9NC8CgnHBcGaEtdYJb528syHqYuxM7lzarSmQvscpODFIHxRZ0Io3nhoKBgU6F5wvkM009Ufit6+sNu/c0pOmMz7irNFLW1tEieU3FW8WLmnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777233505; c=relaxed/simple;
	bh=trIOiXPC3ZznAjLInheohem9eH7X2h+P2el58b9UVm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEMVYS2xdcdq9zsbwmwj9Pn8T4h2nOhcxsQ9n59TjDo9gJswS8kzcc7/ZMy/Lg5ixuLLRSIj56/JZOENhTJHrQT436Yna5Dl+peQU3QwIuwSgFxKiGDfNineKxmpEyL00EondRVrwwurdFXNsmiogCyC5Nyzz5gd7E++AGWi7Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4MUK57z; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4MUK57z"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48896199cbaso94328985e9.1
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 12:58:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777233502; cv=none;
        d=google.com; s=arc-20240605;
        b=VX3q6YAAOatzhSTYi1xj+mvAuDAGfJl+tbB2Q+LRErOiCkwh0cmYUvetHbJ/vqqZjK
         NIpfh2oWn3XND5B712tlaE0OKvNZnbNLzONqC9OVjTBA0Jty2ntUt4QqpChl2jVn9hXn
         BeOADQGOVfyYRHyQx4sDUWeouBMlTW4nXXGdaBi0gPYGYv8IJ2Fh4pNxVAFe48xLI15x
         R+hxHLl91XidZ64Rbf1MhaMbu0ChL6+UOorJdto2OArzBI85Y0q+V7PHgjq/P0hxK9f5
         Tn8E8wJrPcb2WJYx4OOIwz7ZD89wAicolbyQfjIcBmcVEmOYlthdJPEaUjJLh9YnK1YT
         i8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vZ7wzWQmLh+SZ6Kb2cKv58UWYCYxw7XUgx9m7326nc8=;
        fh=e/qwgPU8A5U6UQRlqmfMZcUEh5e6lmrd+vl3ayBD87E=;
        b=fla+5Og2TGb4N+4LPI8FjF4kdUO96tOa9tRBdIxG4fpXvbz0DFzUN37NKt61mYCJju
         BKkPMLoHLnjL4leNYgJ+Rfkfb7fKvVP5ahQhCjxkPQ8nDqFQSI0vx5DNRpWs+0dlTNh6
         f/ZXlaS5y7ExxPNexo/OCtCJnRujHLOf7iw55Rb2MLgVwxuJMHvF9s6+osZ6AVjN1uKo
         XVfSP8ozlfglvgQA64URvm36eyiOi+8aFM74eRT0DTU1Q0lidcTdTqMJrneOttmukw+5
         h6toy7XY4JPJpZXHmYd+5gN8yBgZyY2dwUxKPUuy5CLkOh86l+jjCGEn4Y7GaBGqcXZV
         Bo4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777233502; x=1777838302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ7wzWQmLh+SZ6Kb2cKv58UWYCYxw7XUgx9m7326nc8=;
        b=d4MUK57z1CZUI4qbwOqkG2ndUunCJyldF1MbrdRLcYL+98z/VCE8KIqCNhqyEa05ii
         HmRnTB3XCBePZHoAfYOR6YqJPwBzz8rd/itK/KSbFHZ/Rv3z/Xd6nO1YtrFfGc/mErNO
         dBUfGvWrYhEnonJUStQDIF6uPPvJHXmGNemz5+K4WRsI9mmn9o3+A2WdR34ZJGPgSFLl
         +Q2C99G3NbwwpQVfVEp6BMGHzbZeX3DTMqoYsF7as2TedEgFs1++OcIS2qNUFrlM/0AJ
         6cCB36MxI3wfC6aZkpAntTCyoWejaLaX7zVU3XU39XMwSsqpiDePugn3mH95fnPvQzoI
         j2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777233502; x=1777838302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vZ7wzWQmLh+SZ6Kb2cKv58UWYCYxw7XUgx9m7326nc8=;
        b=J4lB5Z27j2ptf/icUu6bk4cXIXzUnL5UHUIYaS+5MIX9cw4nZSeuxEZ88tboB6NAvH
         zygvHydec096L50W9KgIRkHiMRJTCMC774HHrGK/spVExkM42dzQZiuyKXA+6Jg17O2v
         e0Mw25iLTM++etxDe5iWh8JFztv5W0SPcfhGuJpPsk+f2K36T9PDHBWMLIy8vmptAep0
         v8rUuih+UWKmVw7D2NgAQqoY58X35uPv94RQarqy5TqzZW0vkk/+8u8uh7wM6Bs3Hab3
         Pu+vLUlhxLaOl5yNmb1dkwMsAbk6DzP4yu5nig1hCn6ZnJgZe9/ifXpzAzadsfb8qHOZ
         tR4w==
X-Forwarded-Encrypted: i=1; AFNElJ8IkebvlcI7OTb4UKgkvZWyWYGzIYjgK4pQSPL7tksezvPrsmfcjUl0XbgiNJ8fN6Zppkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHBq41x+toCEAirjUauMOLIDY8CK76132VPUC5pMIyxsHHBfmQ
	W3LWcvkFu5pwvmW8h8on9BvW816KlgNalYbUFDKc/MGTVaHU3YrlQN/UnQZVDF2kpESEFKTotOz
	OlGZoXqVSYGG+/sXgZcG4SpFvscdnp3U=
X-Gm-Gg: AeBDietOzXV0+YXG2N2gPbypc28ocSknyREGskaWXC/To7Li2THVTWhCUydVYoaeeE4
	oRV4TpH1Oa5OQd1wz273nwNNcbf9uY9/szOsCSXyIGo/F25QyHfXsOkZ6gxuZ07ttrcKfi9W4MQ
	zKmz8+3UuGYcpRb8HQufiy3sWKmIcI7bSb8JT4SZpCpVzP2wTAlwc9BYtPOMdUHHrBtOqjB9ogU
	3BcOXFYBpPTCv1OAC8cOg+qPBfh+p2iBNt8XmKlNlbYfYhMUTRgO2WJQZOxILG9w194Tv+iw9nG
	hLqZIqt3A7Jbv8wzPNj5rrNEzQ4kdtge91Omj7ZA1I37hSPv0Z0jTuuQyemPo2WltUx+67W5fUo
	VNJrO4XBJY0tf1jJ5zlK5UWTPYs2VXAgMP2Hw
X-Received: by 2002:a05:600c:a416:b0:488:e7e4:8425 with SMTP id
 5b1f17b1804b1-488fb787674mr456008145e9.23.1777233501582; Sun, 26 Apr 2026
 12:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426172505.1947915-1-graypanda.inzag@gmail.com>
 <20260426181736.794BCC2BCAF@smtp.kernel.org> <DI3BT9LJCI1D.2TRRBC1BVKIP2@etsalapatis.com>
In-Reply-To: <DI3BT9LJCI1D.2TRRBC1BVKIP2@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 26 Apr 2026 12:58:09 -0700
X-Gm-Features: AVHnY4KJ55lxN1RRoJMGc4pt8ZhF2zS5ST9s1upiCmj3EpzYMk1gFXRtaU6ML7E
Message-ID: <CAADnVQJGCr9_iBH3wtCZy2rHYCQJ0Ca4Xz_y0tnF0+E7An9BXQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix off-by-one boundary validation in arena
 direct-value access
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: sashiko@lists.linux.dev, Junyoung Jang <graypanda.inzag@gmail.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 12:16=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> On Sun Apr 26, 2026 at 2:17 PM EDT, sashiko-bot wrote:
> > Sashiko AI review found 1 potential issue(s):
> > - [Medium] Data race and bounds check bypass in arena_map_direct_value_=
addr() due to lockless reads
> > --
> >
> > commit a9b5d3016475abf10be02a320dc627c95b306d92
> > Author: Junyoung Jang <graypanda.inzag@gmail.com>
> >
> > bpf: Fix off-by-one boundary validation in arena direct-value access
> >
> > This commit fixes an off-by-one error in the arena map boundary check
> > where offsets exactly at the end of the mapping were incorrectly accept=
ed.
> >
> >> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> >> index 802656c6fd3c..49a8f7b1beef 100644
> >> --- a/kernel/bpf/arena.c
> >> +++ b/kernel/bpf/arena.c
> >> @@ -511,7 +511,7 @@ static int arena_map_direct_value_addr(const struc=
t bpf_map *map, u64 *imm, u32
> >>  {
> >>      struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
> >>
> >> -    if ((u64)off > arena->user_vm_end - arena->user_vm_start)
> >> +    if ((u64)off >=3D arena->user_vm_end - arena->user_vm_start)
> >
> > Could this evaluation be vulnerable to a data race?
> >
> > This function reads arena->user_vm_end and arena->user_vm_start without
> > holding arena->lock or using READ_ONCE().
> >
> > Concurrently, a user-space process calling mmap() on the arena map FD
> > can invoke arena_map_mmap(), which updates these fields under arena->lo=
ck.
> > Because user_vm_start is updated first, a concurrent reader here might
> > observe the new user_vm_start (a high address) and the old user_vm_end
> > (which might be 0).
> >
> > In that scenario, arena->user_vm_end - arena->user_vm_start would
> > underflow to a large 64-bit value, which would allow arbitrary offsets
> > to bypass this bounds check.
>
> This seems like a valid concern, though it is unrelated to the fix here
> which seems correct. Can you sent a followup patch using an arena lock
> guard in map_direct_value_addr? I don't see any issues with taking the
> lock since the method is only used at verification time.

No. sashk is wrong here.
In general I suggest to ignore sashk's medium and low suggestions.
'critical' are often correct.
'high' should be considered, but acting on them needs thought.
