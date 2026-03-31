Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CFD35F5E1
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923351; cv=pass; b=YYyuzbEUUysMIuFldSQTYA3bdJ4ZPTd91EOjRdb2iMrbKwUJ6RZMeCSKoO6n1hlJ03BcCRUEPoqyHV+54s2YmUQifEoyNHlsTPyW2aTye7rGdJCaMeyVbUEh8LvKOCXyJfgdHKeU3t5zC525uy4K7FlrGi27ST13AJNWgStx2SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923351; c=relaxed/simple;
	bh=e0taOFPk9pRrZOMXMg5pNgX6/KZMkL5Kiz5hCRQwDlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXF+lS51ElCJoTzh0v0WWpWj9L3EcY8LlvK1tpmSlwi1VrvzZtBZB2l2s0/pChj7c7OUxBzMaRocSA2uqmoO4d5FBKy1sIB3qgEwvCI7WIBcV9WDGnQgG3gKKn2OcBQseShhlhGVUC3OZ1Z7jjkW/KbBfdT9ih1g5pu4IEGX9Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8Qv4mpM; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8Qv4mpM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so948195e9.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 19:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774923348; cv=none;
        d=google.com; s=arc-20240605;
        b=bl7ArtfysQe4LfiRSHf05EHK4KyjiD4j+5iLymAobXwadOClqcLVfChdC2f0NAcbiD
         CIT9Sh+IkotWdnpbHNaSR4n+HFO9hx4GoyzdVLDbm5VBrC45ZO1NUYNVIxOp1v2ebUiK
         7Z3l7T06OAG0EwpCCrEsF1WOOLqgsOZs60XwlnkyXkbXGh/7l3uWltTpxaUCdCXp6ILA
         GCaRLvp1bL7QYlRzOP1AH4v5Yyzuxy8LbE4JvfLaJc0iM6mgC0Jn0a/COyCthHRxt8Hs
         xxGlOrtv9T5l+s28hqZEu/6zaqO6pJhaqnfZ1nAm4Ur5UJPBXrDT8MV03nQbllnym41x
         tHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NGbcj7/O32XC9B0n0P8wfIZz2fpYJ0S+OYxZ8TZMqEk=;
        fh=sbK6Fga1mVxXAdEzzjjK4TG1HJFElGRMUvpklYchVWo=;
        b=Gmiw3mrKYcLw6B1UQ0XMPmWaVfU4hSifRbZGGzrIA7kJQYl14JAQOKb3v6S6oCGEMA
         VwpLTA2Ib8KdK/UAdLQu8V5Sk1bR18kbOSDSkv42DPPNkIF/nDyBvGqruxwxZjH1GAJn
         ZZ0NnHY3OpoUzN5Jk2IPJRvjAMIyAkS7C+Z4BbxVbDBGBEBjdIS1556WIeKwtpxAK/Fv
         3Ze7DRgxXDKRIf9rb0Q+cBqnJI5B9ZVo6CS2yADeh+R0O92Ily8QxF70yrxmS89qek9j
         WUA1N/HN/SETJ3/FiwoCqqaRWvjfeSnRIL2iUSXZWFjZuV5t+BhpIOIr/+YoFs6gcAAk
         Erww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774923348; x=1775528148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGbcj7/O32XC9B0n0P8wfIZz2fpYJ0S+OYxZ8TZMqEk=;
        b=P8Qv4mpM3dPhZtDP1AMVJVXUOxTgiTiFpTgjr773e9+Qc4jbGBKPHirXmaokZJRNNA
         HklSvmE+A6D76M7vTlISqfRxt4onFNBdKyETvC5KoEhGSKX603KKO4QlZEnh+acThrIw
         xu8zOWGlywVUap+WUklULc5yQNHt5XFa8pmCN9Qr2qP7MNuyIIm2UWzxA0UcYWa3w1Aw
         XCahaIZf0xC69IfitHGatN1Dyr6w4BAzVzQsHcnCZZYm9LABKU59+SxmA/NndYb2YuFk
         8S7g5boyS6CB6tFgEUjTEk0ie7GCVr8guMWXuRiMrC0O0c1MJdp3vFwa165e8SzD4ce+
         81NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774923348; x=1775528148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NGbcj7/O32XC9B0n0P8wfIZz2fpYJ0S+OYxZ8TZMqEk=;
        b=CcP+stJQY1sUxFiReCjAcSlkFdwvQf+8QoXo2Z2N/Amdt8drnrlUGr+cDOi7HzsLZe
         5aO/9bakpA/HeYXdD1qWKeTvFlWwIGmbdoQVj2Z+JKvUDatMy7ATEDc/u0HtH06Kc6RS
         MX3KUFsS1mZeHI/6vhoqcqVkO+XH+iwUJX9kCyRgKYUq9jzGzxZAFCSAIr4D1KSaDqQZ
         ztmNVz24Bmt/ibUgC4Q2uS1rcQ0Y5ojZMj4nLOn9zTA7fbEeHy80u+PqXdLylssjHm/E
         qk989nEt6ZVpE0g8IYrpxQw6Et7BnBnpmFEH73T2Ej2YtyZ1GUnPoz4+VmkyV9S4ZXJb
         vtvA==
X-Forwarded-Encrypted: i=1; AJvYcCUvnSJ981W5AR63PA55NEdZDaPetMcqdtHiespruqVc7EA5nyGh+LNnl9HYfrqRmkUCNu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49G2/b74VN2Qk7RMy1RT2DwvVfBU1BHken138G6oDJZz1afJf
	dPvGZ4P8s1SUQ6lrrk/RvknSlms2rsCdxwNJnUp3U2Ff8cpZm8ryacR4hYxPFhvXIm3jLaFPtG9
	+MuYRQHModAlFc2oe7dqPfdUNFDyJU+w=
X-Gm-Gg: ATEYQzxVEPU4+PBT6GiVNRj9jnQD6cszPdNcu4k8Yav3QYNKxP5Q2YqEg46ZTz+1/g1
	OAAGVv+fqCj4nNu57cvy3+XS+zTgcmEG49l1jCC/pM6AlWfgSEMO3ce++KdvNf0zE63uegQQWtl
	klGfwhTdK68XEuaNAbJzjZbVHlS3jsc2Ucj+iSAFtOJpnNCg4cc8e6JQ51sJM+aBbe3DK8H2OxF
	kEfXhNp6A8MhjLiJNgVonZxOniBiRFptDFBJAZYnuEkg345Q8znf/EQb+dTCIwY/Bg4ILViQHrZ
	9NOWHNcFMSodEkxmZWXQd/cfahXLRB7WjFpESr6PGwPLE9vsJFVReGmDTtZauQ3wninhiwqHNyc
	zDMvaVyXon7bN+EYvtV7tj7IdNA==
X-Received: by 2002:a05:600c:45ce:b0:486:fbc4:8fe2 with SMTP id
 5b1f17b1804b1-488783d259bmr24422685e9.15.1774923347961; Mon, 30 Mar 2026
 19:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329124429.689912-1-hoyeon.lee@suse.com> <20260329124429.689912-2-hoyeon.lee@suse.com>
 <CAEf4BzbA=drhPq9tsD1Dj1wt_P0q4LNtuNSM96CWVuAVBrKrvg@mail.gmail.com> <CAK7-dKZMjW0t=CSkRYuUudnAY--BviwVBJCGH11g6csTKBwRNw@mail.gmail.com>
In-Reply-To: <CAK7-dKZMjW0t=CSkRYuUudnAY--BviwVBJCGH11g6csTKBwRNw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Mar 2026 19:15:36 -0700
X-Gm-Features: AQROBzBItDozKecjsmVbqQiv5J8kLw0iEL8T8k3hPxJs3zMBJYDlbcgxGILNxoM
Message-ID: <CAADnVQLN4mNZWMsf0+1999JuzRgjAV19CoC0Wd638v+qhPUy0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: allow address-based single kprobe attach
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 6:49=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse.com> wr=
ote:
>
> On Tue, Mar 31, 2026 at 9:33=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Mar 29, 2026 at 5:44=E2=80=AFAM Hoyeon Lee <hoyeon.lee@suse.com=
> wrote:
> > >
> > > bpf_program__attach_kprobe_opts() currently attaches a single kprobe =
only
> > > by func_name, with an optional offset. This covers only the symbol-
> >
> > have you tried passing NULL for func_name and specifying absolute
> > address in opts.offset? Looking at the code I don't see why that won't
> > work, we don't enforce func_name to be non-NULL
> >
> > This NULL will turn into config1 =3D 0, and offset will be config 2,
> > which I think is what you want to attach by address, according to
> > perf_event_open documentation
> >
> >                union {
> >                    __u64 bp_addr;          /* breakpoint address */
> >                    __u64 kprobe_func;      /* for perf_kprobe */
> >                    __u64 uprobe_path;      /* for perf_uprobe */
> >                    __u64 config1;          /* extension of config */
> >                };
> >
> >                union {
> >                    __u64 bp_len;           /* breakpoint size */
> >                    __u64 kprobe_addr;      /* with kprobe_func =3D=3D N=
ULL */
> >                    __u64 probe_offset;     /* for perf_[k,u]probe */
> >                    __u64 config2;          /* extension of config1 */
> >                };
> >
> > This is the same approach as with uprobes, btw.
> >
> >
>
> I tested this after your comment, and you are right. For PMU-based
> non-legacy attach, func_name =3D NULL with opts.offset =3D <raw-address>
> already works today.
>
> However, this does not work for legacy tracefs/debugfs kprobes, because
> the tracefs event string formatting still expects symbol-based input.
>
> So for v3, instead of adding new field to bpf_kprobe_opts(), I'll documen=
t
> that offset can be treated as an absolute address when func_name =3D NULL=
,

This is fine.

> and make legacy path support the same raw-address form as well.

but not this. libbpf doesn't need to support legacy interfaces.
