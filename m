Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE42C08D4
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921753; cv=pass; b=PePTNLd9CxhRVAtb7wvsA7YQtWoa/U1sDclqZKAAJXEt7N3DDGHq2w0bXkFNMtRDQJHTcHyz8EOFaEZojN6osHh6mV09mwi/i2poA6ThrTHKxke3+zzhD1haIedO5DTCZmNPFyc37cRdpXgBIXSHByBMa76FEX+IWtotC2R5qRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921753; c=relaxed/simple;
	bh=7mR/FEIdKpPoOSaAjFMxtsc2cy77evN8pkvL1lLQ1Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrSMOV6QMZaXIWIss8vUKHs4GJyHZdI6yVdcavVEpWY91Vihd7CZvupcgk8McHd5v7aWfqGSgjraFfO0Dh+dSI/RMuOyzFNTLBmSn+I13QlOr9AYGSOD1x3hGjpWtLnhVT68JXURpiItE8pz+pGKSMYVU2EvL4EPFgzutUe2n6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DfPphiYZ; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DfPphiYZ"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a279ce9475so5570979e87.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774921750; cv=none;
        d=google.com; s=arc-20240605;
        b=I36V13Lh9nRuuPgbwMWwhkJoyz8EmTOlymxYdh4KqNabSjJiXFmU+Nywtm9/n79OD+
         2FGSvJ/wdRqsAX6p08rvrP8lqoHuGfrCuP97CIHrT8ynS4FefoGL2ep58WZNxrsT1wrX
         emwbaPCcZ/xar9lnvYvAcNObUvHruo3dj2JwyKAv2rqoYhOaw13S+UxdcgHh88ZwRGhE
         mJtaVQZ+6I4TkoTAMLeigihIIpypjmNVe4hvNy0vvbP7TwlpDqFtb8znWAauHYCUUefP
         1YRO0075HymbW5n3hjcXyikvNR/qA3RP0txR1JimNVMF0sBwRLX6+GqiUPKBWY2VfQgc
         DJ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AUGtOhZOkkF5yLpH0AKa3aJ1gvm9fmOUPIXTqcmi7t8=;
        fh=pc/8M4bW3XTM9Ln92F+p7ATeqjbYx3ATQJKM4BRd+rI=;
        b=fHrf1FL+bjzbxSs5ZGYy5DLW9It1pBOFUvzod6iXdrijH2hrPNF8tJ3dnVqaX3Ut8N
         WgG1h6d1p85hoDjo6UwkkK3iVqcDKll3/eCpxD558tympugzT/mjGTowbJg//RSx8P7P
         IB9AIfSRhzO5xvyUXdFu4jtv133x3gVms7ujRnCRX0UbAXe3jw/sAsc9sz4fzUW3ze/y
         7ojvWFfe11pkrWbfRMwRj/CLvdeSv4WY2nd/B0Df5B4KPfTtf75ohWgJbSdkf+r+UZfx
         nhKYdhCu04XwNtORMWajScsxT12sgsEWVKlvOAjVS7eEx1eseyXpq4w2KTWILSL+G3E6
         802A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774921750; x=1775526550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUGtOhZOkkF5yLpH0AKa3aJ1gvm9fmOUPIXTqcmi7t8=;
        b=DfPphiYZb/JwEcGivLxq3r1DPsB8Nlxp/PygkywQHzhGSxeU0dRdNyx5b90kpReTPI
         lIbCo+j0yQcPu3dv+/NZW5AzrY7JLPakmd2555HxFA6UuyiOiRNREtwqPg+855ZRFGYe
         NKoRFhsPj6PH3cPup9FnEeA7yJR6+LnZOJLGK10tbE+v0BZQ58IoxUurw04yt5+5chSV
         t7HHnLadzctnTkIYBdQ9DjR6E3UWfoZu/Z5WQTvdGgKS49DGAvMup9tVp0g4sNSZqU9X
         3UtAUVbszkyXlvHSdfBBulTR42GJO7E++qZM5uGYzL09U5fGjxHGWndKa+wiz7nQYnmR
         Z46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774921750; x=1775526550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AUGtOhZOkkF5yLpH0AKa3aJ1gvm9fmOUPIXTqcmi7t8=;
        b=Hc7tM7vA9HqwMyxuwjo1nOjVzKWCyh5Wya81Dl1oCu88xOI87RAj5qSaQCeEIvgQwq
         z0AHXti4a9f/sts8E0IMZB1PbvrbHgbHyYdYInN2MgFhyGMJJuxj1OMFuj+bV7KtzWOQ
         1yrM/bWLNE0kYSiwtJ3xoy3UwCTo2fml2Z1MUcsvpzTzYvwbLTApNaenVAeuOKwIkEhr
         8MWQfPaKGHCySt3X+yZOZy4SKVbq4bSTIK/pbK/ORQRpJgXquGGwOa4czlQ1UX5l3fCo
         YR2jI5j9yPmMOaLH2ObkZ2L5Ql5l62V7cTS08fNbJOfRWpxUH61Xeqpa4tJegp96y34B
         iycQ==
X-Gm-Message-State: AOJu0YxS6s/OwGDq6BmPzEQR7c7GjiHGeN2uchdbig0B/m3bQQ49vokA
	NklOtu4bqKo9f+UF0Yo6DPuZS/YuXTHFlfd56OFCpGaGNhjivwR8NmYDmJOgjr/2geJgoTf0Nf6
	U7UwAjkeUZyUEkz54FMuxMq728pRSjl0cYCpkZJnQDp8YTNMuPaUMels=
X-Gm-Gg: ATEYQzz6oi/dCtv8LO5BFn5v4ua32QfDzd4adjG96QBfq3EgJU8NeK1bqnDTPRec/Wj
	LyUCOFKcfipXQZ9ttY8Urb7dQL4baMR72/K7eLMVnc2j1+4u2nCYPRr2AUb8NB0TovM7xQINly0
	nm6a7oPLlPoq4IsrH6LbVUyQ9cTeNERgI+TWaVJ9xJOJ4+m+QmOHZQaVbBC9rFqZCRcksUGMdM7
	mv7EoO+gcYDoG3WIj/c18D8ZUPF9OGPsbwGEGHjwakzeMzL8Y0DBcVc3LxPcJ+NE7o+AVurGXdS
	Mm4qjriGNZVlYsaMCG+WbXx4uaMTGKy2NYYsRJhvfg==
X-Received: by 2002:a05:6512:39c3:b0:5a1:3308:2a16 with SMTP id
 2adb3069b0e04-5a2baacc22dmr568745e87.1.1774921750496; Mon, 30 Mar 2026
 18:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329124429.689912-1-hoyeon.lee@suse.com> <20260329124429.689912-2-hoyeon.lee@suse.com>
 <CAEf4BzbA=drhPq9tsD1Dj1wt_P0q4LNtuNSM96CWVuAVBrKrvg@mail.gmail.com>
In-Reply-To: <CAEf4BzbA=drhPq9tsD1Dj1wt_P0q4LNtuNSM96CWVuAVBrKrvg@mail.gmail.com>
From: Hoyeon Lee <hoyeon.lee@suse.com>
Date: Tue, 31 Mar 2026 10:48:54 +0900
X-Gm-Features: AQROBzDigsL7IRQLglmAi0nGJYVWiLB_I2NXsLdUS9C4uuHL8iG0rgEEhOuBIgA
Message-ID: <CAK7-dKZMjW0t=CSkRYuUudnAY--BviwVBJCGH11g6csTKBwRNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: allow address-based single kprobe attach
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 9:33=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Mar 29, 2026 at 5:44=E2=80=AFAM Hoyeon Lee <hoyeon.lee@suse.com> =
wrote:
> >
> > bpf_program__attach_kprobe_opts() currently attaches a single kprobe on=
ly
> > by func_name, with an optional offset. This covers only the symbol-
>
> have you tried passing NULL for func_name and specifying absolute
> address in opts.offset? Looking at the code I don't see why that won't
> work, we don't enforce func_name to be non-NULL
>
> This NULL will turn into config1 =3D 0, and offset will be config 2,
> which I think is what you want to attach by address, according to
> perf_event_open documentation
>
>                union {
>                    __u64 bp_addr;          /* breakpoint address */
>                    __u64 kprobe_func;      /* for perf_kprobe */
>                    __u64 uprobe_path;      /* for perf_uprobe */
>                    __u64 config1;          /* extension of config */
>                };
>
>                union {
>                    __u64 bp_len;           /* breakpoint size */
>                    __u64 kprobe_addr;      /* with kprobe_func =3D=3D NUL=
L */
>                    __u64 probe_offset;     /* for perf_[k,u]probe */
>                    __u64 config2;          /* extension of config1 */
>                };
>
> This is the same approach as with uprobes, btw.
>
>

I tested this after your comment, and you are right. For PMU-based
non-legacy attach, func_name =3D NULL with opts.offset =3D <raw-address>
already works today.

However, this does not work for legacy tracefs/debugfs kprobes, because
the tracefs event string formatting still expects symbol-based input.

So for v3, instead of adding new field to bpf_kprobe_opts(), I'll document
that offset can be treated as an absolute address when func_name =3D NULL,
and make legacy path support the same raw-address form as well.

> > based form, not the raw-address form that the kernel already supports
> > for both kprobe PMU events and legacy tracefs/debugfs kprobes. Callers
> > that already have a target IP still have to drop down to
> > perf_event_open() or direct tracefs writes.
> >
> > libbpf already exposes address-based attach for kprobe_multi through
> > bpf_kprobe_multi_opts.addrs. This commit adds bpf_kprobe_opts.addr so
> > that single kprobes can be attached either by func_name + offset or by
> > raw address.
> >
> > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 88 +++++++++++++++++++++++++++++-------------
> >  tools/lib/bpf/libbpf.h |  5 ++-
> >  2 files changed, 65 insertions(+), 28 deletions(-)
> >
>
> [...]
