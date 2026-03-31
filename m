Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3D192B75
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922520; cv=pass; b=lTDaFqK4meGybFbSqP/skhB7Rm+nuBSaGDsx/YLxd1e9MqVxRVYoArXWmbKvxo9HSAwaokOQUplDuJ6BG3M19ZjEhaIRwThwB70d2VJALmH3WQlU2zR1EnOV0QXtNuf7OZL4F+LwQ3/t4S7AdwllZXp/rT42d2hOWcbPxNVwaXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922520; c=relaxed/simple;
	bh=5BtMxuKQ9DexShkvI2pZkLDVdrz52htk8/hMj2EaJF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeHGWICg//v6ynwqWfVL2yIjba3g+LwGYb1X9YBw0jxhXvsAByo2Q5951V+X60h+bocWsHBuK4heLBfVEQOq9u6Ti8CtZ7ZtJJk5VWq/1cdLoVleWqNhDD2893K7keE6ZDBubSFOrG1XKj3VbeMDb+GLd40FDHhGZz2Rcb0WILA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WnPj/HCf; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WnPj/HCf"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a2a70bb66aso5072835e87.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 19:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774922517; cv=none;
        d=google.com; s=arc-20240605;
        b=IISfnTTWp8SlOuFoHqah8wWJ8iCsSda8R9lw3f+ieYzyhCnhZHRqXeHc5PviR4vxNz
         nMJreOETAmyyaAcXph4dooRchRDZD2Qz2KI3LKeHjGtP2Ffeu+hGEroMc1/Hbv9YxnJk
         TWfDxvaql6cKPR1y8l5iVuHxkCMxJoC05mKOY4kLLlfOgHbmtU+CPhr3rcOqqr6Ub3Zn
         GxSr2uHn5DYa3bSwe9mtCQ4HwB2iZQyl6jXOyqxMkslM7Op4rgidQZ5mG6azXRNW+eAa
         oZjSY15m438tRb/kXjflfbrj1P947NPFrUMTwAe9DxwwlkyXOSE+mMzkWbutwLTM1LjJ
         AvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/Ig/DGLQgf1ppLMDpJjT+8F/4O/vfBiYS4W92t7hC8=;
        fh=Jv6LPkFCwewIfdV+duzJSG1bLq6ywnOshIwf61r9ypA=;
        b=XQeyDJXt7cdqcIVZCRyblitIX0wRwWb/nCclu1JYIVqNQVGCFNUehKVezJNEfq6SXG
         oOkrXan7G1l0l2zyIP4XNRiXRz0cnsdwQDwFwlYE7RMMZw3rzGc+Ly/wi0trKx3fiRth
         wxgpjvFcOcgtS+2uIAzG+CGia5jtXviYamWpLRFiblWjhzXsFt//KLG095O89ozPaiAD
         Xy/oUytI4UNMwYUjVOIVNi7efxg2SuF3wCUa8e2hMLVBVFjJ4rg97ItOKyTdO3Kmpka5
         XIokigxlIxlGyuBxNqeYXmohOOMwRoTZ7zCX44AQ3jCgUcOMBMRUAHCPfy7joe/R1lhp
         zm8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774922517; x=1775527317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/Ig/DGLQgf1ppLMDpJjT+8F/4O/vfBiYS4W92t7hC8=;
        b=WnPj/HCf0JP3WHw84ngdasnCEqMuZYeHl4loM3mXS66j0we/ueaFADSGnMp+4fLOSN
         +O5pVzr45JstBseRKlB7igrA1DArnMEIPHdMGFYtWxpeQRqeosxYJk97uurbr/eOHXXg
         qQixvQM9yV2UnHlVw2YJaBEF/Js9ebq+jKmu1qAC92EDtt0FSh/PdSLgbY7Oxm7KVipU
         J8HyoH5w1hRQEki6iRXAOPTNT0TuiVRLTYkKNEHKPePXI/PRacntvjLbJ77+KJBTwOrS
         QUb4M5WfVHXKl5TgSfX+5kZAUXk/PNkSGm4/M6eIARxIEHrMY1OFbJITE4WR94tClvDw
         iGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774922517; x=1775527317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/Ig/DGLQgf1ppLMDpJjT+8F/4O/vfBiYS4W92t7hC8=;
        b=UwAkhVS82PrGwFYIKPdbHvMM6QfPoLReFyjRSYJXGtRpF2EK1eIFXMRpuxDAfCTF78
         o2VlSbvEA6vQLIRN0NDz/zaIDg7jIDdgbtCNz7fAEXT/ISHecwbzHmfQJEju8VM0ux8m
         kTQPurXbni4K1OWWrtGLjOiu7656LNnPBc6q6TaBcV0udh81kTN5esy/F9vVoOYvqCci
         X89xA++wbQkwqVkQhmq68AH5SpAQAdedXWHXM+msY9+OPUyz3swf+X06pUAsiYj4ezWh
         cf2ob6MjLJUDTt1FDC37MceocwKoEPhTBdcEu2g45kl6mRCPVEts5gUStrNQIWKeAiiD
         GaTg==
X-Gm-Message-State: AOJu0YycQ5eV3VUBJuFTcsJY0ZRgCGpleOCfMQin7JdWzVcBKFc6T+oB
	B53TXvtWOFILJDOHjT+gqhn+u552VdkRS1YrW1WL24Hhmtr1VQ+BGpA16EKgkOdOuXw+qvL1INk
	y9rUP9iJXy970uPCe0++46gRI35uqyisIcWWiHduvfIxng49WsXn8PSUmlA==
X-Gm-Gg: ATEYQzzXqNmfUfwZlofFGxAE3Cy4vKGAXn5aIJCyoZu4Xx5sbrCEroT/l1Ui7X5JsB1
	lQ5EbiHpXyr8VbFlNd8HbTsML3DyRwj0NwyOcgCBhDoZGzj8UwaKygVH/UURxPGwt97PdPJJkck
	oez2C1a3WLYgoof27nNEEG37gbGju5DlKoj6mpmhpIk65OlCNwVx4YJh+P1J3Zc0xfQHV4FOD9v
	lp3uMG90xd9NaWFa87P4/vw8GO4g4npnpZ3V1ZuChHaVjeQrHuXeJGef3zgdfLcWLvngQ4Znf6/
	XiAe0srpPa/F4ig0l/Z7MpooYucJoIXN+b01+yYf2g==
X-Received: by 2002:a05:6512:10d1:b0:5a2:a5f6:dfce with SMTP id
 2adb3069b0e04-5a2ab7ea285mr5096157e87.11.1774922517043; Mon, 30 Mar 2026
 19:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329124429.689912-1-hoyeon.lee@suse.com> <20260329124429.689912-3-hoyeon.lee@suse.com>
 <acpLlFg_UUmzp80f@krava>
In-Reply-To: <acpLlFg_UUmzp80f@krava>
From: Hoyeon Lee <hoyeon.lee@suse.com>
Date: Tue, 31 Mar 2026 11:01:41 +0900
X-Gm-Features: AQROBzDg0qcd_MUjXbT6jLQeGM7P_6EVEMeqa7ZA9em-EgNqL92HBMqjpED8Yxk
Message-ID: <CAK7-dKY+_wxF4X9pg8isQh_7+_T3vCX=BwgdJhP9wd9vMntZHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add test for address-based
 single kprobe attach
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
> On Sun, Mar 29, 2026 at 09:43:39PM +0900, Hoyeon Lee wrote:
> > Currently, attach_probe covers manual single-kprobe attaches by
> > func_name, but not by raw address. This commit adds address-based
> > single-kprobe attach subtests for the two underlying attach paths,
> > legacy tracefs/debugfs and PMU-based non-legacy. The new subtests
> > resolve SYS_NANOSLEEP_KPROBE_NAME through kallsyms, pass the result
> > through bpf_kprobe_opts.addr, and verify that kprobe and kretprobe are
> > still triggered.
> >
> > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > ---
> >  .../selftests/bpf/prog_tests/attach_probe.c   | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/to=
ols/testing/selftests/bpf/prog_tests/attach_probe.c
> > index 9e77e5da7097..64f2ed75779d 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > @@ -123,6 +123,51 @@ static void test_attach_probe_manual(enum probe_at=
tach_mode attach_mode)
> >       test_attach_probe_manual__destroy(skel);
> >  }
> >
> > +/* manual attach address-based kprobe/kretprobe testings */
> > +static void test_attach_kprobe_by_addr(enum probe_attach_mode attach_m=
ode)
> > +{
> > +     DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
> > +     struct bpf_link *kprobe_link, *kretprobe_link;
> > +     struct test_attach_probe_manual *skel;
> > +     unsigned long func_addr;
> > +
> > +     if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
> > +             return;
> > +
> > +     func_addr =3D ksym_get_addr(SYS_NANOSLEEP_KPROBE_NAME);
> > +     if (!ASSERT_NEQ(func_addr, 0UL, "func_addr"))
> > +             return;
> > +
> > +     skel =3D test_attach_probe_manual__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
> > +             return;
> > +
> > +     kprobe_opts.attach_mode =3D attach_mode;
> > +     kprobe_opts.retprobe =3D false;
> > +     kprobe_opts.addr =3D func_addr;
> > +     kprobe_link =3D bpf_program__attach_kprobe_opts(skel->progs.handl=
e_kprobe,
> > +                                                   NULL, &kprobe_opts)=
;
> > +     if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_by_addr"))
> > +             goto cleanup;
> > +     skel->links.handle_kprobe =3D kprobe_link;
>
> we usually use skel->links.handle_kprobe directly, no need to use
> kprobe_link or kretprobe_link
>

Thanks for the review! I'll change that in v3 and assign directly to
skel->links.handle_kprobe and skel->links.handle_kretprobe.

> > +
> > +     kprobe_opts.retprobe =3D true;
> > +     kretprobe_link =3D bpf_program__attach_kprobe_opts(skel->progs.ha=
ndle_kretprobe,
> > +                                                      NULL, &kprobe_op=
ts);
> > +     if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe_by_addr"))
> > +             goto cleanup;
> > +     skel->links.handle_kretprobe =3D kretprobe_link;
> > +
> > +     /* trigger & validate kprobe && kretprobe */
> > +     usleep(1);
> > +
> > +     ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
> > +     ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
> > +
> > +cleanup:
> > +     test_attach_probe_manual__destroy(skel);
> > +}
> > +
> >  /* attach uprobe/uretprobe long event name testings */
> >  static void test_attach_uprobe_long_event_name(void)
> >  {
> > @@ -416,6 +461,10 @@ void test_attach_probe(void)
> >               test_attach_probe_manual(PROBE_ATTACH_MODE_PERF);
> >       if (test__start_subtest("manual-link"))
> >               test_attach_probe_manual(PROBE_ATTACH_MODE_LINK);
> > +     if (test__start_subtest("kprobe-legacy-by-addr"))
> > +             test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_LEGACY);
> > +     if (test__start_subtest("kprobe-perf-by-addr"))
> > +             test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_PERF);
>
> should we test PROBE_ATTACH_MODE_LINK mode as well?
>

I covered only LEGACY and PERF here, because they test the two
underlying single-kprobe attach paths, legacy tracefs/debugfs and
PMU-based non-legacy.

I treated LINK as duplicate coverage here. If you think explicit LINK
coverage is still worth having, I can add it in v3.

> jirka
>
