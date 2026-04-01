Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E122820A9
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775020977; cv=pass; b=pm/gSOqmp2Ctoc2eM/tJUo7KuyCY6pX4ntlJx99MXwxTlAS8FN24xyZMRWU9TNuquGHxin4xuzRrej2xoQCIL4mAG4y1EUAP5Z+ZAj4RjNVJuGqlq3tUZRgygbhXYYZC2gPPGZJpDWH0UX+3lLnGiYivYlGh4tceA0dukF54By8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775020977; c=relaxed/simple;
	bh=EToT+jbi74/I43F5MpaPRz2Ah2alfai5tT1/AmKTR60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heRNQf3QSNg64x5XLQQHmx2zALbUAlz59AJH2+dQL4Ey7n5PkR+mSa78aOkLyVnWViM2jenA56BMvYgUpu9sDfTxMtaTWbqpaKSLrsgMhnmBTmAikUUMlF/CF0Ym9+D8aAsb9Y+ZfdCvTTT5sFJ86jK3panlPApxXTlFr2cL8RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KjtOnyWj; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KjtOnyWj"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so7481917e87.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775020973; cv=none;
        d=google.com; s=arc-20240605;
        b=CHdf8r+UksxrOuUTeid8xQy8AyHfgwWgUk3dGqCrVbHvL8Mi/U1yAgtsXQR+uBw0Ud
         MwdI+NOiHZ9gJAhN+AyR3VPFxi2dcmg0WBu8dwHbYeQe3FkVWm5vfOQxBknMeniWCrca
         ZQfrK7xoKC10fca9STrzgZOARXyBvG7cprxzWRDVCQWxPAN6tMrETugtjv/V7G0cnyzZ
         2wOR++3aBxgv93qoEUVYAHSmzCGfUrmgI+I45dfq02bjDwpRhcDmi/HeQvBnF5sNcbTM
         ES5RV0jBgZj124tiOOHz0xanlezn+cV682JJC6PRTsBdNZbNRgLDO0g6O+GlB+g9zI/u
         9Khg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9nRjIDw2DuYf2VjS3Dnf8WMoxKek5GPsaf/dodkzcEw=;
        fh=pc/8M4bW3XTM9Ln92F+p7ATeqjbYx3ATQJKM4BRd+rI=;
        b=ZOXtT78qrK7ltVPtMu1Q3zq021GsRFghdWf1el9naDV4Co0mGgLNvHGvg7EZ3INbxI
         oJIDirnVqIaoHanjnC17h8M31Paus2ICWnRapf85tBIS0nKxj7UFQQFnh3O0bmRcu0a0
         8Kgbv4t/AZE7TCL5HjnVotwl/891tl0hmVLM40mvctbpEi1Klw91PB8Ke7U/WTRM+XmK
         vBwbllI6osWJu2/Ah60U2uxD9W5PZAEE3OlmZ5aowDuebaIS26Sy+jdgJL17NszB2xrF
         v27p6/kKsRUenN+2nUCCzUGkJP2v3PEN9Th9rTbzz0oli1HmoKlsl5S4NLbseSLSnLJm
         Fhmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775020973; x=1775625773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nRjIDw2DuYf2VjS3Dnf8WMoxKek5GPsaf/dodkzcEw=;
        b=KjtOnyWjZU7AHJBXb1CRw22BCirx2kZwP2OOCv2I/MFCwuasG8TjQvKOqXKu6EdfSC
         zzk9E8aJ9v9Dl/fyvmGmCbi5QV6Tj6HZRfK1EWjucpnLGtcBOLPyUgOG7QrqucRjqMuQ
         NPYQ39z655lVg7PBkXQX1bjMGw88dSGDmxWX9s1Cx2LHWXllpvwrc09e1RbBWWM+ljQw
         Fk6qaqoTLU5QIDKfAQYXzfilW9FEZSzKa5dOno+diekzFAgBak8wpX0XLnXrispE83Qw
         mgZeWGpG5HV00qp6scKhFV6bAgf4iiDfZqoLyHCYdShIAOCGTIQKBgKwt+PZBWfxj49R
         3Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775020973; x=1775625773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9nRjIDw2DuYf2VjS3Dnf8WMoxKek5GPsaf/dodkzcEw=;
        b=aAgUCSE/T/jSv742YzyaTb5zBzgIg/kufOiW2dTOPgBRaYLpqN5Vlu/ZTXVGEav2dY
         YxG9OIot4xy3QjU66EKpLd5YoIDmWt6HuXLzsXUi6NfM0KrG74N45CA2h5HExRZX0yHA
         NkvRzh1q0NbVv2YeseIVGJk46zJOJUrFCvIAQqlPblfKRXmexEFcN62l63t3T3ZSy0ay
         4/SpxRCpPz8I/hXHPx6qWqwyGUjm+Z8PyKKjBEh1DBQEgYqyMHo5rTxIG+DVm59Ra8Qv
         pyUQE7dvlXlFc66uYDhqHdo5IzabThX70qUQ0NfPJZfkjr8dELw1jRGeOiLoXYD13XCV
         rG0g==
X-Gm-Message-State: AOJu0Ywb4LKR2RryG7PS74ofKLqp/iKTk+84NLpLJobkr7/fJL2SunwM
	VmVK1JWTbQx0lKzon2bszj+qUcoVJxDFX4V8xgTYAM1rUoxRiR/L3vBZpyr6l1tpmos2eol126d
	9FHL4TbCaAM7snh4Qr14JQ/8A3joHML9FxiVxk7BHrQ==
X-Gm-Gg: ATEYQzxWNhYIPZqJiITUZJp1UPzAd+JgyRpgRNodfkui1LoV3SQQUkD4HxNL2PDeLGO
	nPn/ASV5mOm45pPUJoFwTmZqXU+1L+lxd1qvoJyj0jDJlsKM1bEXXJnfPSg1QN5x228NIrKVKRg
	7GrtzOM7IQ9TphY4/eoc8LsTKQgBwf5tQDyycDS+xLWmRbLAtaDSA3BDYXQ5ePNIlhahwWlunTt
	qhpbCfxGk4S5ExN+BBgYUuDHX4cIUTNxLNwvZ/6/xAZ1kOlHQBh5eHJn1LENadyCZt/7Lnc3uaw
	9QK8Q1uOLwCzCTARSnDsFNGruPLgHmeGOO8DsHc0VA==
X-Received: by 2002:a05:6512:3090:b0:5a2:961a:f7c7 with SMTP id
 2adb3069b0e04-5a2c1f20accmr670225e87.21.1775020973157; Tue, 31 Mar 2026
 22:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331152509.70468-1-hoyeon.lee@suse.com> <20260331152509.70468-3-hoyeon.lee@suse.com>
 <CAEf4BzbFFYuNrgven8ONRs9s3ypdzZ2VvnVDVmnwm7REYTGscQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbFFYuNrgven8ONRs9s3ypdzZ2VvnVDVmnwm7REYTGscQ@mail.gmail.com>
From: Hoyeon Lee <hoyeon.lee@suse.com>
Date: Wed, 1 Apr 2026 14:22:37 +0900
X-Gm-Features: AQROBzChoRCK5UAm8V3ba-jaSqzA35xdHS3dBo1XbSSrVl87VsiSv0U84cLcByw
Message-ID: <CAK7-dKYnYWnFNC=Q1DHqczv49N9eXUM=ALFg8qeO=tt_WHjUsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: add test for raw-address
 single kprobe attach
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

On Wed, Apr 1, 2026 at 8:06=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 31, 2026 at 8:25=E2=80=AFAM Hoyeon Lee <hoyeon.lee@suse.com> =
wrote:
> >
> > Currently, attach_probe covers manual single-kprobe attaches by
> > func_name, but not the raw-address form that the PMU-based
> > single-kprobe path can accept.
> >
> > This commit adds PERF and LINK raw-address subtests by resolving
> > SYS_NANOSLEEP_KPROBE_NAME through kallsyms, passing the absolute addres=
s
> > in bpf_kprobe_opts.offset with func_name =3D NULL, and verifying that
> > kprobe and kretprobe are still triggered. It also verifies that LEGACY
> > rejects the same form.
> >
> > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > ---
> >  .../selftests/bpf/prog_tests/attach_probe.c   | 82 +++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/to=
ols/testing/selftests/bpf/prog_tests/attach_probe.c
> > index 9e77e5da7097..817c4794d54e 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > @@ -123,6 +123,82 @@ static void test_attach_probe_manual(enum probe_at=
tach_mode attach_mode)
> >         test_attach_probe_manual__destroy(skel);
> >  }
> >
> > +/* manual attach address-based kprobe/kretprobe testings */
> > +static void test_attach_kprobe_by_addr(enum probe_attach_mode attach_m=
ode)
> > +{
> > +       DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
>
> DECLARE_LIBBPF_OPTS is a legacy backwards-compatibility macro, prefer
> using shorter LIBBPF_OPTS
>

Got it, I'll switch to LIBBPF_OPTS and updated the reject
expectation to -EOPNOTSUPP in v5.

> > +       struct test_attach_probe_manual *skel;
> > +       unsigned long func_addr;
> > +
> > +       if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
> > +               return;
> > +
> > +       func_addr =3D ksym_get_addr(SYS_NANOSLEEP_KPROBE_NAME);
> > +       if (!ASSERT_NEQ(func_addr, 0UL, "func_addr"))
> > +               return;
> > +
> > +       skel =3D test_attach_probe_manual__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
> > +               return;
> > +
> > +       kprobe_opts.attach_mode =3D attach_mode;
> > +       kprobe_opts.retprobe =3D false;
> > +       kprobe_opts.offset =3D func_addr;
> > +       skel->links.handle_kprobe =3D
> > +               bpf_program__attach_kprobe_opts(skel->progs.handle_kpro=
be,
> > +                                               NULL, &kprobe_opts);
> > +       if (!ASSERT_OK_PTR(skel->links.handle_kprobe, "attach_kprobe_by=
_addr"))
> > +               goto cleanup;
> > +
> > +       kprobe_opts.retprobe =3D true;
> > +       skel->links.handle_kretprobe =3D
> > +               bpf_program__attach_kprobe_opts(skel->progs.handle_kret=
probe,
> > +                                               NULL, &kprobe_opts);
> > +       if (!ASSERT_OK_PTR(skel->links.handle_kretprobe,
> > +                          "attach_kretprobe_by_addr"))
> > +               goto cleanup;
> > +
> > +       /* trigger & validate kprobe && kretprobe */
> > +       usleep(1);
> > +
> > +       ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
> > +       ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
> > +
> > +cleanup:
> > +       test_attach_probe_manual__destroy(skel);
> > +}
> > +
> > +/* reject legacy address-based kprobe attach */
> > +static void test_attach_kprobe_legacy_by_addr_reject(void)
> > +{
> > +       DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
> > +       struct test_attach_probe_manual *skel;
> > +       unsigned long func_addr;
> > +
> > +       if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
> > +               return;
> > +
> > +       func_addr =3D ksym_get_addr(SYS_NANOSLEEP_KPROBE_NAME);
> > +       if (!ASSERT_NEQ(func_addr, 0UL, "func_addr"))
> > +               return;
> > +
> > +       skel =3D test_attach_probe_manual__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
> > +               return;
> > +
> > +       kprobe_opts.attach_mode =3D PROBE_ATTACH_MODE_LEGACY;
> > +       kprobe_opts.offset =3D func_addr;
> > +       skel->links.handle_kprobe =3D
> > +               bpf_program__attach_kprobe_opts(skel->progs.handle_kpro=
be,
> > +                                               NULL, &kprobe_opts);
> > +       if (ASSERT_ERR_PTR(skel->links.handle_kprobe,
> > +                          "attach_kprobe_legacy_by_addr"))
> > +               ASSERT_EQ(libbpf_get_error(skel->links.handle_kprobe), =
-ENOTSUP,
> > +                         "attach_kprobe_legacy_by_addr_err");
> > +
> > +       test_attach_probe_manual__destroy(skel);
> > +}
> > +
> >  /* attach uprobe/uretprobe long event name testings */
> >  static void test_attach_uprobe_long_event_name(void)
> >  {
> > @@ -416,6 +492,12 @@ void test_attach_probe(void)
> >                 test_attach_probe_manual(PROBE_ATTACH_MODE_PERF);
> >         if (test__start_subtest("manual-link"))
> >                 test_attach_probe_manual(PROBE_ATTACH_MODE_LINK);
> > +       if (test__start_subtest("kprobe-perf-by-addr"))
> > +               test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_PERF);
> > +       if (test__start_subtest("kprobe-link-by-addr"))
> > +               test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_LINK);
> > +       if (test__start_subtest("kprobe-legacy-by-addr-reject"))
> > +               test_attach_kprobe_legacy_by_addr_reject();
> >
> >         if (test__start_subtest("auto"))
> >                 test_attach_probe_auto(skel);
> > --
> > 2.52.0
> >
