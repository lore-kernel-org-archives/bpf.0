Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5331E5B68
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769916628; cv=pass; b=oy9qF7C9TciX/mWFu8nn7crM14h8N7OJtUGn46RxY2saniN1mdNkjlaWgAoCu9QHRzPsSuR8xAgH0mmT44h5FjKFCU/eH68pe4dqiKAvMRAelmoLXQatXJIqqWy4R83NPMPJzU4NkFVVhEoyU+UkVvMbyprqjfOdrQ3ocd7J4j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769916628; c=relaxed/simple;
	bh=SL2yCQN+vM4PVE/92h5myxBkpBuCCzoODB/wCXjCjmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxjr0cqVTcnX1qVpkD1CXA4n15SAnz3i2qFxnlAevlG9x9NwpxjhMJeg+s582HkSf0Pst/yvaCdH0kKQqidGqe3IaJKnht2/0KPF8AeYHR/NRcGRUhSmQyw8oi7ymp39H/4P50hNzyQURZAEd0uKU5BbGZK01IXDsaH9osloGqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgJ6M41Q; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgJ6M41Q"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432da746749so1925008f8f.0
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 19:30:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769916625; cv=none;
        d=google.com; s=arc-20240605;
        b=PLarrkpcK7uII5r1Bg+u+yorDwa/C9YMFMarldMo9RCh8OO7QS7kJcAuLOLeNz9+qa
         wUVWYewBxz7FwzHfcrw3d5HwelIB6IstD1HVD3Gb2ayCsjTsnUtHbM3VZtVsdS2r2UXu
         ywOFqzcVmwk4787MXaqebWx6I0/TioxnTAtcBDM74HUKh3AEFiQDJjCINEWb2ehNq/JO
         dtkeFJMHKxn1scZNvE7SEqbEv5pR5aScbQP23I6Du3RtcZQk3aOYfcJKYon5yRU4lUQW
         7D7TgeTX6l7w07V1/lk206E1MlmXnuzNpP0FvBTVXCKBnqFkSiNHI/O7htAqALLC1sL1
         R0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KqR0D9fy82z/wmcKu4V9BvJmO6maTzoZAbEY7ZhL/t8=;
        fh=phXJFsAQnAsJh3goG/II5JAes/Rt6SpDAQb2V03GVVM=;
        b=M/Vc1wUbiC2gcT+viFIIi1z4E6jKTpGLndXB/UxqIeHcznXvFJOdorGEEO8Xw6sAOi
         8NAP+cL6bqlkIEG3xIITUeQzh+gJhGFCnLgTk23w8ij/TN5eQh76U+sb0HXiyDOhZ5V3
         6DvbRI+9hUKhNMuTM6QRL4EVx3Rk/JA9CKOe+IL5d2zmF2zhuHyfHlKBo+4DFG/vhlhF
         Fm+PeNYuyXdh7ov3myJDhD1hrJvObM6da72LacXGnum7TB/LuBFHAH7lpn5cqtRUP/k3
         79OTE+q2dMXUyUhRmKzdtjXEXhH8b2Isq/TpYMzbNWPlM17BUlZVmafagcgL4KQIn75P
         eZJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769916625; x=1770521425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqR0D9fy82z/wmcKu4V9BvJmO6maTzoZAbEY7ZhL/t8=;
        b=JgJ6M41Qj38N1XIZ+PWkXu/wkbcQ0fW3G+7AwPxy+DR8Yhx45ZjYoFhsRq0RRmugv2
         6m/QODwn8axoQwlVQ5P+eRORvS/ZO9HznoMd5OD8p5l5ao875RhwT7alV9o+SCfNleyZ
         ClZFAXXMP6A++eBv+EZwy/3dHXQT1wYE3G4n4DeR9SC0fr9qu+Hctn53D+4Na80/0xCK
         cHHaSqfdStMYwE0gpaZfLP+JJc7lVCtpGLXGch7NR3Bs0zRLeMZGUjLM/uznH5ODoIFB
         navCvJl4yI3wOcWJxtLT85nfrNMeH8ySLlhiY2Uer0J+VpunrHzqvitHZB4GfBngm9lV
         jPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769916625; x=1770521425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KqR0D9fy82z/wmcKu4V9BvJmO6maTzoZAbEY7ZhL/t8=;
        b=Su0lwGiCqhEz/csFx+ZsXI9GbTCMOOhbq9d12+QW7DlptCM/Gjc21lP8CZRY1WoPo9
         JzVsdh6RfzZB1YAr/wfrLM2s/t7vFcXqaA4i53b/vf/ExboJfPuErKDZfJuh8r2SUdFG
         PGFjWq3LPZXSTw3qkkED8jzK4gtSh659/tfQQLafm9oDfTLd5dQ9Wm9XJbQ/zOca0LZt
         w+sVXGvlpeM7qXt8BD7X8V2UyghXkmvfDCDDLVPp+MDeTBGO9UpMwJ0KPXvT2lY/bmCh
         lKcpXZlTppcXL1eaiu4ntN7Jh6JrRmlbPFTLP59t5ZZuCTgAyG0w+M8YQJLj1gXhfm9s
         s/8A==
X-Gm-Message-State: AOJu0Yxl2+I7tN0gmYJxaHdWtCFbbv97moWr+/Z+x5+H16br1EPWp9ck
	1uG2EOF8CyN6rCINj1qbE7Q+SyWAH70ty8onviEqfsbSyXzRIlFveRXT5p8gusN/NKmvnNuV2oP
	cum5J7A4U/4WAftpRst0OkfhBDUCXScw=
X-Gm-Gg: AZuq6aKFbUJmnjNzJs0lSOcGUrG8XXamD3JwPd0b4MO0MV8zHRAYtrOvLwIxFC2Flsa
	SMOTcucA30uNKA3CDbvfMzLKzSSeyv0Jy6nLqCthmgcBtja9hQH2PBw0fRoH5NhO1m7eH7PDDhc
	F+oMNxamkSl0+cSMnO31eG4qms4SFU4Iu+MShxbZZ2mKONVXQt7xur+8JljlvE5Dxyi6WkF2uAv
	6gxQi0haXr6kjL8sVhmeeGmvYHwiUj/g9XxdFaWuNqO9IEYDcQxyJ8X7/TflSMZsITIcLXuQ82s
	DJQ9smDV84w+xcvn0KiMmi4f4yo1kXu/TRRJ7qnEBMxX1zMxXWfTX55Na+2d5Mvg2sA/vSjpTza
	gNaf+XhJCiTbjfA==
X-Received: by 2002:a5d:6b8b:0:b0:435:95c9:688f with SMTP id
 ffacd0b85a97d-435f3a7df37mr7408834f8f.2.1769916625144; Sat, 31 Jan 2026
 19:30:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201025403.66625-10-alexei.starovoitov@gmail.com> <5c4d5e47fcb6f3146bcee4590b3227f5d937060535b8e9a7f14a3208100b9c7b@mail.kernel.org>
In-Reply-To: <5c4d5e47fcb6f3146bcee4590b3227f5d937060535b8e9a7f14a3208100b9c7b@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 31 Jan 2026 19:30:14 -0800
X-Gm-Features: AZwV_QjBmIZ3JiFl4o5EU8M0hvFd3sriCX5VwaZgwffFTjnExJ3L7Jl6UZl4kzM
Message-ID: <CAADnVQLkUsbgZ9ibwCNUe=_XKv7cY0X8BCRK=tm5o4JfSLq=qg@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 9/9] selftests/bpf: Add a test to stress
 bpf_timer_start and map_delete race
To: bot+bpf-ci@kernel.org
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 7:15=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/progs/timer_start_delete_race.=
c b/tools/testing/selftests/bpf/progs/timer_start_delete_race.c
> > new file mode 100644
> > index 000000000..2ff6357f3
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/timer_start_delete_race.c
>
> [ ... ]
>
> > +SEC("syscall")
> > +int start_timer(void *ctx)
> > +{
> > +     struct map_value *value;
> > +     int i;
> > +
> > +     for (i =3D 0; i < ITER_CNT; i++) {
> > +             int key =3D 0;
> > +
> > +             value =3D bpf_map_lookup_elem(&timer_map, &key);
> > +             /* hey claude, no if (!value) here. The verifier got smar=
ter */
> > +
> > +             bpf_timer_init(&value->timer, &timer_map, CLOCK_MONOTONIC=
);
>
> Will this program load?  bpf_map_lookup_elem() returns PTR_TO_MAP_VALUE_O=
R_NULL
> (defined in bpf_map_lookup_elem_proto in kernel/bpf/helpers.c), which req=
uires
> a NULL check before dereferencing.
>
> The comment claims "the verifier got smarter", but I don't see any verifi=
er
> changes in this series that would eliminate the NULL check requirement fo=
r
> bpf_map_lookup_elem().  All other timer tests in this series maintain the
> NULL check:
>
>     timer =3D bpf_map_lookup_elem(&race_array, &key);
>     if (!timer)
>         return 0;
>
> Without the NULL check, the verifier should reject this program with an
> error about dereferencing PTR_TO_MAP_VALUE_OR_NULL.

Ohh. Too bad. claude didn't trust the comment :)
It's a good thing that it didn't... of course.
We can tweak review prompts, but ideally we can document this
inside source code somehow.
Ideas?
