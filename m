Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410853019D9
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775020907; cv=pass; b=WOa5AdHJrraJCr/BpPm0Xt5WAFlTv8wL6CnwRPlE4JrMUmh2rYut7O140mW7a2o5rVCn5ZCxnv2p09sMN4tIEzcc3k73G2OZ8p+S7VfzHmZ02xF57G+EKy9tzbt4RO27SAXaWUr9LR6HHIAYsa2/wOnJCjHA4TmkkQU37G6oR3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775020907; c=relaxed/simple;
	bh=Q8gu4HoA6PIJdmyGgZ4wmlNSvowuXMSu2+OpNT846hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4mtLtIgb7cIwRgJgtjt4ODpwu95kwwOKE2u10eJgFst4uLZloSfl0n1hhmPUgPAEoLJjF25iiR8KJe6YDcnD0hCSg02cpfDyY4uzahsx+Db24AJ6tx381rr88hMHnbB+p4QGCZkdlwmCOAyXja99yVQ1ZNGACEZ9QpCRyl9gRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cujPW8KV; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cujPW8KV"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a27daa652fso5434509e87.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775020904; cv=none;
        d=google.com; s=arc-20240605;
        b=ALvwCgVZyskpo/L6aY2BQoWtR/2gy1Rg7HUI84CANb3HnwcjrEh1PMg1/Oh/iQJiq2
         Z797bteScwZNFHGZsCPzSOeAqFEz37YQuJxiKJBVvv940QcfMN+aawEimNi6aBPFSsNh
         vmBtioAZ56a8BW3HZYxapzCY15SUQTWdNlLvdLPA2IamHtxyuSTJp5bxReTI1syIKDtr
         qgt2R4l5+T1iVDSg7f4RS9rQHAslYvX7ayrqokIUZWcCGAd7h/tFTL5+DpSu5eOWMcTW
         x+EerUupwfIZp/mk7taXQ7pIoDXvpEl9s8vA5f8GSpBEOiBvk/L566UQuvrGWRd1zqLT
         fGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4ZHMh4PMu6sh1ipSFl4kPb/x3ROsxrV+MfUv1wssDpY=;
        fh=pc/8M4bW3XTM9Ln92F+p7ATeqjbYx3ATQJKM4BRd+rI=;
        b=NoRAAEtIvHn1vgX9lugT4od+7i5ZDe4xCr2xbNBk0q10evhz8q+vDhltbPhNzpW8uH
         6jIicLrWXU+qOyZVMonEIG1dLNCyHBDCvZEPPB89yCCFZWuJbH05vUl1eWFOoLtuvl8p
         +FaT3MgWwuqZiaarLUqrNTcNgFTAqDgLMnJdn+2Us0EeYKteK9iY6hmlbtWt9k8GZ7da
         zE97GrvwTEHTgJ0nWtm7iIepl8Q3H2ebmbkf9Lc32FLZrmXvxgaqH62wPgcK4Jj0pCj+
         1mhjmSEhBZlRIvJsaS62ZxIlZ8mQCseHFHvRQCQ+gmwGk3wk/hD1ZPGr9M4leLlcQ3Tb
         +W0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775020904; x=1775625704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZHMh4PMu6sh1ipSFl4kPb/x3ROsxrV+MfUv1wssDpY=;
        b=cujPW8KV/nJVj0LWRHe7GDP4jIOdeUhIlV4fb5XPgGRhjJ2LEvq1B4DaUJzJyerUJL
         hkDAedXJTr+ykCkW649HWPpZlewYeJ+IdK8EiPQsOLX/xQSFwAPLscERZJ0Lzn3J2pUR
         SZYZpnCoZoZIIjR+HBFRq2tO3LbtzQGDJumN5BCdVJtnt1cPsFNhibd/0B//9/vpLT7h
         eydCBUps0qwXLw7ewhnuevLdhPa0iuaGyhQGuwDa9p3df8GbN28HLzVNR5bUK+GyD9OA
         1sVppmK2iIgcSGNaCRcF6CdTFHQTfdEV4Bu9K0F/U2AhoaGIQRjBzjIzUk03NsbfdoKn
         RXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775020904; x=1775625704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ZHMh4PMu6sh1ipSFl4kPb/x3ROsxrV+MfUv1wssDpY=;
        b=GSiNm+jq4g0brjNkgGWvqjGHNJPKTML08vl//43VK15m+FDuVsMoKgPOE+oDB2gztp
         vkW4RkMiZjtDAGG5epr7z/iK50Dlyh3X81hh070Y9It75W3hRLI6I0ZO/6hVIaFvTI0k
         Uue65HLX3qUEFv23W8Fj9vkJ7Ad4BY/ij1ri9vWxyEcn+tDodIeArFdaZ9kfSsaFNgvD
         4o0rUJyGx62pN9QwTY9mEhTImnoWiPogdCm/7lD7FH7Qr6M1CszXW3xuY5yBkSO5Wdgp
         3wyrFCg4lVlDobK16gQQmbhfCs3SxfSnBaUYojBu2zFh77hN+Cao56h3KHGupwZHNW1m
         aUFQ==
X-Gm-Message-State: AOJu0Yx2jkUUDS6BnU+GgdUB+aAXua7S+KkiihE1LY4eTyUK6IOjb4XS
	KFfwetjR/PGnunZL2FvdPDf1XD5++qh7NbVbdhkZ8/WUT7WHkOIXXVl7akCAqKAkDTfo4w1dmXN
	gtCvbh7MBBawcEmaQEh1jSQO3VeuQ6/LajRYQ1rJOXA==
X-Gm-Gg: ATEYQzwgFgox2cOe54RZbVuULvveK81qCBxnzVmnEYcQCOzSrvtHmOKyfKjvOoBI0M7
	gEfnK0xrHcs8/Oa4bH29o7InPA2szmocJdI2JKySCAN0Wpj2Uh5TfKABDGGqmDzxYeCZd793hPx
	g+qpgnCnC34UQhMKQCktPunbPJ0yshfww7iA7AKfJ426u2Z+qYpJGwyJRfGoQKXgEf6Lbq2OflE
	CC2brLGgnzGsfc0XFiqcG6ZpC+Gky73it8LdZPX2vA2SZEFhS/Tvl8XHd2yPMyCCJ7AGhdQy9fJ
	xWLlLpePs5gfzziUMp0ZQ7dKzLikvM9cuuX84/u11A==
X-Received: by 2002:a05:6512:110d:b0:5a2:a82a:168 with SMTP id
 2adb3069b0e04-5a2c1f070fbmr714924e87.6.1775020904284; Tue, 31 Mar 2026
 22:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331152509.70468-1-hoyeon.lee@suse.com> <20260331152509.70468-2-hoyeon.lee@suse.com>
 <CAEf4BzZGJ5A1t5GcU3kt_gK6uK2-mzqNvtuR9AMzpiyrgEvrUg@mail.gmail.com>
In-Reply-To: <CAEf4BzZGJ5A1t5GcU3kt_gK6uK2-mzqNvtuR9AMzpiyrgEvrUg@mail.gmail.com>
From: Hoyeon Lee <hoyeon.lee@suse.com>
Date: Wed, 1 Apr 2026 14:21:28 +0900
X-Gm-Features: AQROBzChIVpRP6-ERMGUOBLiMNUapMhcuTu5vuycyMvWbPtSLELf-wjCb3enwTg
Message-ID: <CAK7-dKa2_fv78Q52MtKTfoB8hVYUaU4A_PM_ABGUXNNwKO5y8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] libbpf: clarify raw-address single kprobe
 attach behavior
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

On Wed, Apr 1, 2026 at 8:05=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 31, 2026 at 8:25=E2=80=AFAM Hoyeon Lee <hoyeon.lee@suse.com> =
wrote:
> >
> > bpf_program__attach_kprobe_opts() documents single-kprobe attach
> > through func_name, with an optional offset. For the PMU-based
> > non-legacy path, func_name =3D NULL with an absolute address in offset
> > already works as well, but that is not described in the API.
> >
> > This commit clarifies this existing non-legacy behavior. For PMU-based
> > attach, callers can use func_name =3D NULL with an absolute address in
> > offset as the raw-address form. For legacy tracefs/debugfs kprobes,
> > reject this form explicitly.
> >
> > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 21 ++++++++++++---------
> >  tools/lib/bpf/libbpf.h |  3 ++-
> >  2 files changed, 14 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 9ea41f40dc82..9083f542a3b0 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -11523,7 +11523,8 @@ static int determine_uprobe_retprobe_bit(void)
> >  #define PERF_UPROBE_REF_CTR_OFFSET_SHIFT 32
> >
> >  static int perf_event_open_probe(bool uprobe, bool retprobe, const cha=
r *name,
> > -                                uint64_t offset, int pid, size_t ref_c=
tr_off)
> > +                                uint64_t offset_or_addr, int pid,
>
> don't rename it, keep it as "offset"
>

Got it, I'll drop it in v5.

> > +                                size_t ref_ctr_off)
> >  {
> >         const size_t attr_sz =3D sizeof(struct perf_event_attr);
> >         struct perf_event_attr attr;
> > @@ -11558,7 +11559,7 @@ static int perf_event_open_probe(bool uprobe, b=
ool retprobe, const char *name,
> >         attr.type =3D type;
> >         attr.config |=3D (__u64)ref_ctr_off << PERF_UPROBE_REF_CTR_OFFS=
ET_SHIFT;
> >         attr.config1 =3D ptr_to_u64(name); /* kprobe_func or uprobe_pat=
h */
> > -       attr.config2 =3D offset;           /* kprobe_addr or probe_offs=
et */
> > +       attr.config2 =3D offset_or_addr;   /* kprobe_addr or probe_offs=
et */
> >
> >         /* pid filter is meaningful only for uprobes */
> >         pfd =3D syscall(__NR_perf_event_open, &attr,
> > @@ -11816,6 +11817,8 @@ bpf_program__attach_kprobe_opts(const struct bp=
f_program *prog,
> >         default:
> >                 return libbpf_err_ptr(-EINVAL);
> >         }
> > +       if (!func_name && legacy)
> > +               return libbpf_err_ptr(-ENOTSUP);
>
> -EOPNOTSUPP
>
> pw-bot: cr
>
> >
> >         if (!legacy) {
> >                 pfd =3D perf_event_open_probe(false /* uprobe */, retpr=
obe,
> > @@ -11835,21 +11838,21 @@ bpf_program__attach_kprobe_opts(const struct =
bpf_program *prog,
> >                                                     offset, -1 /* pid *=
/);
> >         }
> >         if (pfd < 0) {
> > -               err =3D -errno;
> > -               pr_warn("prog '%s': failed to create %s '%s+0x%zx' perf=
 event: %s\n",
> > +               err =3D pfd;
> > +               pr_warn("prog '%s': failed to create %s '%s%s0x%zx' per=
f event: %s\n",
> >                         prog->name, retprobe ? "kretprobe" : "kprobe",
> > -                       func_name, offset,
> > -                       errstr(err));
> > +                       func_name ?: "", func_name ? "+" : "",
> > +                       offset, errstr(err));
> >                 goto err_out;
> >         }
> >         link =3D bpf_program__attach_perf_event_opts(prog, pfd, &pe_opt=
s);
> >         err =3D libbpf_get_error(link);
> >         if (err) {
> >                 close(pfd);
> > -               pr_warn("prog '%s': failed to attach to %s '%s+0x%zx': =
%s\n",
> > +               pr_warn("prog '%s': failed to attach to %s '%s%s0x%zx':=
 %s\n",
> >                         prog->name, retprobe ? "kretprobe" : "kprobe",
> > -                       func_name, offset,
> > -                       errstr(err));
> > +                       func_name ?: "", func_name ? "+" : "",
> > +                       offset, errstr(err));
> >                 goto err_clean_legacy;
> >         }
> >         if (legacy) {
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 0be34852350f..f75f3ab0f20c 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -557,7 +557,7 @@ struct bpf_kprobe_opts {
> >         size_t sz;
> >         /* custom user-provided value fetchable through bpf_get_attach_=
cookie() */
> >         __u64 bpf_cookie;
> > -       /* function's offset to install kprobe to */
> > +       /* function offset, or raw address if func_name =3D=3D NULL (no=
n-legacy) */
>
> legacy mode will be useful on very-very old kernels only, let's not
> distract with constant mentions for "non-legacy", please remove
> "(non-legacy)" here and other legacy mentions above
>
>
> but also, while you are at it, let's add a proper doc comment to
> bpf_program__attach_kprobe and bpf_program__attach_kprobe_opts APIs?
> That seems like a more obvious place to explain name+offset and offset
> as absolute address behavior, IMO
>

Right. I'll drop the "(non-legacy)" wording and add proper API
documentation to bpf_program__attach_kprobe() and
bpf_program__attach_kprobe_opts() in v5.

> >         size_t offset;
> >         /* kprobe is return probe */
> >         bool retprobe;
> > @@ -565,6 +565,7 @@ struct bpf_kprobe_opts {
> >         enum probe_attach_mode attach_mode;
> >         size_t :0;
> >  };
> > +
> >  #define bpf_kprobe_opts__last_field attach_mode
> >
> >  LIBBPF_API struct bpf_link *
> > --
> > 2.52.0
> >
