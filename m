Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955419D074
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921679; cv=pass; b=UYoI5GRhwBTdZlzOcTSfMp+6u0CPJRlnOzgibzBUfczHDJtBUzDc4TDRbX6nzoGfVGLB/0LJxyqMBngg7eP2IlzUOKPva/dIgfskN+Jv5gLWMht1NKgF39hF2efMrDOSyXJEKs+5wM+KdrVpUhfNkXZbYaspBrmiQkyGSTiqmgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921679; c=relaxed/simple;
	bh=uOwufVDMxYCsZYUk9KcPLNbgRBhNOcycbb+P2ZuFK40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tY0eeRZTO06vzpMbkmI6n3p9VdMxJt8AEMOhpzKckTW1RGC4g8VwwOTud+zxr61CCmTGqyd5BqNWTBNGmMY0EUdGQYxS3wZnFykVsnHtwvdWch6xSDsH7d8ePxGRxbc6hUKxmclvA+ag7aAc0J5UGvwR6d8l91uVOXuXLIziH0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a4bQtYA/; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a4bQtYA/"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a133b686f7so5973402e87.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774921677; cv=none;
        d=google.com; s=arc-20240605;
        b=YaB+ncy+0EDmJA2wx4DSMmaB8dNruzY6A0z5pcdRgQ/Vjk+cPU4Akwz4Iccdt3QU1q
         5T0lbgXR6jre8HvTGxxw2Eb3gCGqAJrg0QISsVMIMX9myFlhbYc/+Q/N3rj6IG5aO+ee
         P240XCzSQWwVNeo8QQHJy/Cm093NHvcibL8/H0vj/boCYCX/IXT3Yb5Xtgn4Nb63cKzf
         Y455J7+wVbIbaUY7H/RffBi6U6jjvAMboDrW+gwtcB1G2OM0mb5+B2+pVz8ZEkdh+CE9
         KS7THaExDr7XIwB+6knVBOeADUthSc6RSgv/SGPSXC9kLn0IRUbitfMpHHeqTHpz9LwC
         ZJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=21ttnbUgN39YeO+81bfZoJgf8ewTVFP1OWSVQFAPReE=;
        fh=Jv6LPkFCwewIfdV+duzJSG1bLq6ywnOshIwf61r9ypA=;
        b=kWthECT4PZtyfPkc8isZfVY9RUgn/h5z75kZfVjtm7ZPHqb4/mM9+3s8L9HFpK8rv3
         hWeRUsiWUqWYxAHSFkE5CiNNitStff+dsIQ56cP/rLmaZGKHE92Kl/rNpGa9TqkfY/k8
         aorwLvA+ynYUUpKL1nocghC+i9mgsRq4zDWk1BEAdZJ/KpFFjoY5T1WuvunTrkg/fLJ8
         WetAd9XVg5/lvGQNMBzJxQQ+yq7z5QVFPZWwYle+k+S159zu0m4AhBgZv23tyBFxn6Ro
         Mi91OKqPx3N7Xa4hjPoz8Xk1IX5oEuCPWq5VurZEstlxEQjwB94Q5gKUsuBrJDkuLbHX
         TNQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774921676; x=1775526476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21ttnbUgN39YeO+81bfZoJgf8ewTVFP1OWSVQFAPReE=;
        b=a4bQtYA/XsOYuxaYoj6CLEmGO5LycdosIJV24HlqhJVsaWMdxL+ls2mXFl2ob+QtaH
         gpcLWzC5Ed2fsrufoXbJIigz4W38EB2SxVzH0j4VmPtJ0NGwmQEeLEQ3H8JUmUG/2FUu
         XixHyeLVajISsGIKMsDNpEN2j90l+XYIdJmR6jLxE0o4aRZM39oie5UZ+2MDeruANwCx
         eyR3XLkseQX2IUWWccaCBfTyQKQBBbUD+58Z6G+cp2NH6wVVRhW7FNAdi8Iz2JUu7dpk
         DxRErX91lbK48BQL663dThxOCQdGA8lwJjasXuFBKDoLbcYXt1leAR/Vn8xcnTgoqbwq
         hR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774921676; x=1775526476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=21ttnbUgN39YeO+81bfZoJgf8ewTVFP1OWSVQFAPReE=;
        b=oYTproo12fRYEBUPcXoYK8XCNyMS93Ykz3QSDgnyxXuseJLopQKYv8A3xMyG4ddh1H
         MDQJ5beDwUpJOUoLUCNSc7K/hES6W0X0mGGCyYTSTmQW3I0rqJ/fdhB0gmO2iRsjSf6B
         Pmf/sq4MWmPhZ62k6gRHN3QhaMrqLXOMPhFLyMsW1UXxk0/aZnd6oDqS1TdRIIsYQnlZ
         QeyYWbcK9fgJMwSu80XOi//w9jllLb1Rsqbty3Fo1QWKZudchvF4ibZYRLK9hg1j7nyG
         D5nRWBIQWhqDW48XTiTAlun9WA+Fltz1xz4Sy1lMtlkG3OkVg/ViX3mXaGBJrbyeLbyl
         cWbQ==
X-Gm-Message-State: AOJu0Yxyr8W3ELZwJeWwZd3RtVL46wDWtFrJ52Cb+k+Lhcn0uglMqfgD
	KRHDPxsZLBnxD2wSM90ImBvtlLl7ECbezb9EnY3B/OGOvF3XMsqVKXOe7fGogCDGGiB8a70QasB
	LPaI8CeENPpbxLSDST/J3fYa2RNdvUKxlP0q0DWxRsQ==
X-Gm-Gg: ATEYQzyzkFlobTjEK3Ry4QEQ7saGOy5hyTOtk4zi550jR8tZdcsgacLVRiKhwk6mSNA
	KCzeLo1uwvtiec4R650IocP+dRGQfs3o7v0eMV3TBtx5+JkRY7bdmfGhqR1FNaIAPMQZv/0nRkD
	ZwJOFbZst0Wu34vjYodDu7yIfRq24NRldkKf9ACtbc/yM/4/kqj0sjnjbSmoMKYpEJnHhz5uvAp
	YSb6THoBJMTYF9DD/bp/irOjtu026htH6z8ZF5Txcz3Y5YjQFS2jq1aBqAn9NXqyN3z6CqjdXbt
	lhaHCDb5d5ZxvOzOqxm8nhMmJEB40QxoLXjh2IRq7w==
X-Received: by 2002:a05:6512:1108:b0:5a1:1e44:8682 with SMTP id
 2adb3069b0e04-5a2ab9294a9mr4352365e87.34.1774921676487; Mon, 30 Mar 2026
 18:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329124429.689912-1-hoyeon.lee@suse.com> <20260329124429.689912-2-hoyeon.lee@suse.com>
 <acpLiCDwAtn8xLjs@krava>
In-Reply-To: <acpLiCDwAtn8xLjs@krava>
From: Hoyeon Lee <hoyeon.lee@suse.com>
Date: Tue, 31 Mar 2026 10:47:40 +0900
X-Gm-Features: AQROBzAeGQUXighGkOirYDW9eQNKDx11DdyYoeCc-y1CtUFPhi-4ktpsLwrcXa8
Message-ID: <CAK7-dKabFLTs1tTeynHMnp8MzM_cg6QMH6Lg6oj_7e9_bhNsRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: allow address-based single kprobe attach
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Feng Yang <yangfeng@kylinos.cn>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 7:08=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, Mar 29, 2026 at 09:43:38PM +0900, Hoyeon Lee wrote:
> > bpf_program__attach_kprobe_opts() currently attaches a single kprobe on=
ly
> > by func_name, with an optional offset. This covers only the symbol-
> > based form, not the raw-address form that the kernel already supports
> > for both kprobe PMU events and legacy tracefs/debugfs kprobes. Callers
> > that already have a target IP still have to drop down to
> > perf_event_open() or direct tracefs writes.
> >
> > libbpf already exposes address-based attach for kprobe_multi through
> > bpf_kprobe_multi_opts.addrs. This commit adds bpf_kprobe_opts.addr so
> > that single kprobes can be attached either by func_name + offset or by
> > raw address.
>
> curious, is this change just for the api to be complete or you do have
> a usecase where you can't use kprobe_multi and need to attach kprobe
> by address?
>

The main motivation was to fill the single-kprobe API gap, not to
replace kprobe_multi. There is also a case where kprobe_multi is not a
drop-in replacement. bpf_task_fd_query() operates on perf event fds and
does not support generic link fds, while kprobe_multi returns a link fd.
That link fd can be queried through bpf_link_get_info_by_fd(), but it
still cannot be used as a drop-in replacement here.

For PMU-based non-legacy attach, Andrii is right that func_name =3D NULL
with opts.offset =3D <raw-address> already works today. However, this does
not work for legacy tracefs/debugfs kprobes, because the tracefs event
string formatting still expects symbol-based input.

So I think the better direction for v3 is to avoid adding a new field to
bpf_kprobe_opts(), document that offset is treated as an absolute
address when func_name =3D NULL, and make the legacy path support the
same raw-address form as well.

> SNIP
>
> >  static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
> > -                                     const char *name, size_t offset)
> > +                                     const char *name,
> > +                                     uint64_t offset_or_addr)
> >  {
> >       static int index =3D 0;
> >       int i;
> >
> > -     snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
> > -              __sync_fetch_and_add(&index, 1), name, offset);
> > +     snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%" PRIx64, getpid(),
> > +              __sync_fetch_and_add(&index, 1), name ?: "addr",
> > +              offset_or_addr);
> >
> >       /* sanitize name in the probe name */
> >       for (i =3D 0; buf[i]; i++) {
> > @@ -11648,13 +11651,28 @@ static void gen_probe_legacy_event_name(char =
*buf, size_t buf_sz,
> >       }
> >  }
> >
> > +static void gen_kprobe_target(char *buf, size_t buf_sz, const char *na=
me,
> > +                           uint64_t offset_or_addr)
> > +{
> > +     if (name)
> > +             snprintf(buf, buf_sz, "%s+0x%" PRIx64, name, offset_or_ad=
dr);
> > +     else
> > +             snprintf(buf, buf_sz, "0x%" PRIx64, offset_or_addr);
> > +}
> > +
> >  static int add_kprobe_event_legacy(const char *probe_name, bool retpro=
be,
> > -                                const char *kfunc_name, size_t offset)
> > +                                const char *kfunc_name,
> > +                                uint64_t offset_or_addr)
> >  {
> > -     return append_to_file(tracefs_kprobe_events(), "%c:%s/%s %s+0x%zx=
",
> > +     char probe_target[128];
> > +
> > +     gen_kprobe_target(probe_target, sizeof(probe_target), kfunc_name,
> > +                       offset_or_addr);
> > +
>
> it seems like it'd be easier to get probe_target (via gen_kprobe_target)
> in bpf_program__attach_kprobe_opts and pass it down instead of generating
> it over and over again
>

Good point. I'll simplify this in v3 and build probe_target once in
bpf_program__attach_kprobe_opts(), then pass it down.

> > +     return append_to_file(tracefs_kprobe_events(), "%c:%s/%s %s",
> >                             retprobe ? 'r' : 'p',
> >                             retprobe ? "kretprobes" : "kprobes",
> > -                           probe_name, kfunc_name, offset);
> > +                           probe_name, probe_target);
> >  }
> >
> >  static int remove_kprobe_event_legacy(const char *probe_name, bool ret=
probe)
> > @@ -11674,25 +11692,29 @@ static int determine_kprobe_perf_type_legacy(=
const char *probe_name, bool retpro
> >  }
> >
> >  static int perf_event_kprobe_open_legacy(const char *probe_name, bool =
retprobe,
> > -                                      const char *kfunc_name, size_t o=
ffset, int pid)
> > +                                      const char *kfunc_name,
> > +                                      uint64_t offset_or_addr, int pid=
)
> >  {
> >       const size_t attr_sz =3D sizeof(struct perf_event_attr);
> >       struct perf_event_attr attr;
> >       int type, pfd, err;
> > +     char probe_target[128];
>
> we need bigger buffer as explained by sashiko [1]
>

Thanks for the pointer! I'll switch this to a larger buffer in v3.


> [1] https://sashiko.dev/#/patchset/20260329124429.689912-1-hoyeon.lee%40s=
use.com
>
> jirka
>
> SNIP
