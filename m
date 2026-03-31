Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108A22C15BB
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998398; cv=pass; b=L/wYwtEVb9i1L/J2UQfN2fJYTTXNUDrFxjm2QafWBUsw8AczdasV4duMhXYeiI4EgZEpamPTAlOWt+sBJ2/sdm6fXhZqP0PBF5ZcT+LUONL9yAypxnTZNDKKDTACklCV7aEr4oVin/zOfiE0z64mnDHTAMLiU1SK0Kg09lU7/EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998398; c=relaxed/simple;
	bh=Ovm2d23tcLoijUc2I03Z4EbUwa7mw/0GhnKY4/laYtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/jZ1d1D5W73XEoq+t7tHoveA8S6154+nfedEbH/cczzBxsISAqkd5OPmTvsGi8MVO5hqZ4YQR67QMGW/oc5Wq5aoZa3xtS79vu1cn5NtdXVx4Ke22tC3u4M8eYcBXWe00plPUCL38Q3coM6rZvtjt1AEce8+s7EwEaX04H38B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdEjDxHX; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdEjDxHX"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c742d4df00cso166235a12.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 16:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774998395; cv=none;
        d=google.com; s=arc-20240605;
        b=kex+mEf3UIhygHjUWKgE4ktX4IeZ4o5f1NdprCUqk7tgsHlODKwvafgiBmJ1u8hbFe
         teIUFKsDMx7dZh5YeMCVRd+ETeYW7lMDh5QClNYcEiT2snl6xFZoZ9U1JS6EEfCP8ypJ
         N/2BgZ7dbykCG7aV27Eu1FGkW09rX/CsT/0vLL0HSRj6Qq+/1SYa92Sv2c1Z1chr34jF
         5+USbuJvuZCjBHCNOjmG2GyhLZoI4HfFkHlV43/JPR5SdF4nd1IWyJdUNOsUD3wf2HtY
         gWw1BBoANmtTD+UJ7e5ZBzaw1oFko7IUV7O2gninDURz3DIYYXScuSdr60G3n/W+WEI/
         UAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cPgBgxBe1VDDRfBqQ4vQGSHlG2SlYNP0ipxuIgVazNs=;
        fh=POP0ydDNFUne3HyOYVevlhtaIL75qTZjfSeEOeP+aa0=;
        b=JDomsAb1vQkWx/vViwPBo0S0Zwz+Igjde1DiCSdsCqVdwrEmt3V41lpNR1buvZ89yJ
         l7Akp/yO6pw1PlubHf5zAU1/KlFUr9M7tEQpeX5LT6ix1jYCtyI+L+gH2qOYT2XEwR8f
         ftTM2FGRS/0tSsRdSDDok4APFBm0/IDYpTcr+7IEFyhMDlkB2OaKjrKEvqZvPHmhcAxk
         xvGGSg4s2vW0E7+bpum6j6W7PSH4LIOYbAgwX04VVUDpeIbOD7anVLiEAHSZPJ+BHo6m
         VODtd5M0XayQRXhvAtG9US3hgLNickmiK4h+o4plA0T0OxSQbrBu+BCcNsAlzjvH9Nk2
         +E2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998395; x=1775603195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPgBgxBe1VDDRfBqQ4vQGSHlG2SlYNP0ipxuIgVazNs=;
        b=CdEjDxHXM0RI7HjnxtsdF0RJFqssu5/W75XNXBdIj0iTxcSkaG9hQ8KmzNWyLTt588
         0PxyFB57R8RrNcYzXTz0c61Dy+c42EM+lVv5BU9VpCtorK+QhKqWb481a+jn5tYPTKio
         /u2ISsSrvTbXaYF1B1JFCvjdjfTn6dFq8U+aB8jYfTixy2VSPkx2/ltLYHU9oSDcY3dm
         LR3ciTW0c9eNV7LeBl7jFOyXvTGp86Y2qVcFUSLaxo52kkWWrzmoyxokmCnuxxcKk8Rs
         2+K4bdaBljGRAofhhE8i+ORHoKoIqZsG6hH5GGG4i0krX+K5lXyIyQWHdyIdoWHzh/Pl
         UQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998395; x=1775603195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPgBgxBe1VDDRfBqQ4vQGSHlG2SlYNP0ipxuIgVazNs=;
        b=lhffbq4InM5waA/4YZphnwVpMqGvFDIv1/ZbrTsjWqhxhV4p52gEwpJgmd4Hg0+pFO
         r2li2F/uVIUUpphrt30PRJ/Nb3OFQVGfSIpy6ZLHY0LhIeoed5LAcD1uuAUCxG/pmDnB
         FUQvRyHHhQIjQXCFap7rYTQxvqNJcxGQsKVtA1D8TH/9VGU56g00QZcnb8dm1PzGzxQ2
         72oCfUBJCwKg4kEj1lPVQufOCDbao4/VSVtouU7yW845IhiPtjfvpvEz3MzQ31cspy6y
         617bjl2/V+QDU4ZvopEc3cPdVQU4LVhIx3R1eXqS0yGzR/+GLl0qIgz5dvGi0O6UkPsD
         3ydg==
X-Gm-Message-State: AOJu0YzBJXz57GXOLkJb/O+zQWMC/2rIQmmcPk+d93urhjrgtJUph7ew
	fDoegvG0bODKmuzLHNcqO2WpN1tvuqZ6d98oe6duHfVhMyyPHPoPDK8BHNdhQXU/WGC2WmAr7e9
	Jm6z16dZ89fNUQRRCOmhflGbtSWy/aXE=
X-Gm-Gg: ATEYQzyJRgZy4JnflhgdX+X5E36vQvIrofpytKujBRLRTWRLrabkw5T+B5bbsc0bR6q
	D5RkR8xoFwmVAgjkpCdmjgRSO21l4czFCDig7U9qaaGGVtlb1PfmHlxP9+i0fnyOovTcRj+Y2w4
	9bd+TsB0YNOR0Z2QOo8pN1iGTn9osybmIX0WlWdYZRRRbNevf6mWQt9J82EYmxMKf7UZcy/5eZS
	zpPtQAVccpCjMoa6qRcfqnGIG3SE1eQmVBGrHmli4unOxjmjgDZzgV24bmMtBskP+6wsuDV2Laz
	Fv5Qs/bLkm5cGUmy/5Jbvko=
X-Received: by 2002:a05:6a20:9185:b0:39c:4b:9c4 with SMTP id
 adf61e73a8af0-39ef6c16ebfmr987689637.13.1774998395445; Tue, 31 Mar 2026
 16:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331152509.70468-1-hoyeon.lee@suse.com> <20260331152509.70468-3-hoyeon.lee@suse.com>
In-Reply-To: <20260331152509.70468-3-hoyeon.lee@suse.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Mar 2026 16:06:23 -0700
X-Gm-Features: AQROBzDNtmfoPLKxb_3MKSYulocaKrNxh0JN9s-nc398jOuib6sJUVOj9pcMvZw
Message-ID: <CAEf4BzbFFYuNrgven8ONRs9s3ypdzZ2VvnVDVmnwm7REYTGscQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: add test for raw-address
 single kprobe attach
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 8:25=E2=80=AFAM Hoyeon Lee <hoyeon.lee@suse.com> wr=
ote:
>
> Currently, attach_probe covers manual single-kprobe attaches by
> func_name, but not the raw-address form that the PMU-based
> single-kprobe path can accept.
>
> This commit adds PERF and LINK raw-address subtests by resolving
> SYS_NANOSLEEP_KPROBE_NAME through kallsyms, passing the absolute address
> in bpf_kprobe_opts.offset with func_name =3D NULL, and verifying that
> kprobe and kretprobe are still triggered. It also verifies that LEGACY
> rejects the same form.
>
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---
>  .../selftests/bpf/prog_tests/attach_probe.c   | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tool=
s/testing/selftests/bpf/prog_tests/attach_probe.c
> index 9e77e5da7097..817c4794d54e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -123,6 +123,82 @@ static void test_attach_probe_manual(enum probe_atta=
ch_mode attach_mode)
>         test_attach_probe_manual__destroy(skel);
>  }
>
> +/* manual attach address-based kprobe/kretprobe testings */
> +static void test_attach_kprobe_by_addr(enum probe_attach_mode attach_mod=
e)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);

DECLARE_LIBBPF_OPTS is a legacy backwards-compatibility macro, prefer
using shorter LIBBPF_OPTS

> +       struct test_attach_probe_manual *skel;
> +       unsigned long func_addr;
> +
> +       if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
> +               return;
> +
> +       func_addr =3D ksym_get_addr(SYS_NANOSLEEP_KPROBE_NAME);
> +       if (!ASSERT_NEQ(func_addr, 0UL, "func_addr"))
> +               return;
> +
> +       skel =3D test_attach_probe_manual__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
> +               return;
> +
> +       kprobe_opts.attach_mode =3D attach_mode;
> +       kprobe_opts.retprobe =3D false;
> +       kprobe_opts.offset =3D func_addr;
> +       skel->links.handle_kprobe =3D
> +               bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe=
,
> +                                               NULL, &kprobe_opts);
> +       if (!ASSERT_OK_PTR(skel->links.handle_kprobe, "attach_kprobe_by_a=
ddr"))
> +               goto cleanup;
> +
> +       kprobe_opts.retprobe =3D true;
> +       skel->links.handle_kretprobe =3D
> +               bpf_program__attach_kprobe_opts(skel->progs.handle_kretpr=
obe,
> +                                               NULL, &kprobe_opts);
> +       if (!ASSERT_OK_PTR(skel->links.handle_kretprobe,
> +                          "attach_kretprobe_by_addr"))
> +               goto cleanup;
> +
> +       /* trigger & validate kprobe && kretprobe */
> +       usleep(1);
> +
> +       ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
> +       ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
> +
> +cleanup:
> +       test_attach_probe_manual__destroy(skel);
> +}
> +
> +/* reject legacy address-based kprobe attach */
> +static void test_attach_kprobe_legacy_by_addr_reject(void)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
> +       struct test_attach_probe_manual *skel;
> +       unsigned long func_addr;
> +
> +       if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
> +               return;
> +
> +       func_addr =3D ksym_get_addr(SYS_NANOSLEEP_KPROBE_NAME);
> +       if (!ASSERT_NEQ(func_addr, 0UL, "func_addr"))
> +               return;
> +
> +       skel =3D test_attach_probe_manual__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
> +               return;
> +
> +       kprobe_opts.attach_mode =3D PROBE_ATTACH_MODE_LEGACY;
> +       kprobe_opts.offset =3D func_addr;
> +       skel->links.handle_kprobe =3D
> +               bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe=
,
> +                                               NULL, &kprobe_opts);
> +       if (ASSERT_ERR_PTR(skel->links.handle_kprobe,
> +                          "attach_kprobe_legacy_by_addr"))
> +               ASSERT_EQ(libbpf_get_error(skel->links.handle_kprobe), -E=
NOTSUP,
> +                         "attach_kprobe_legacy_by_addr_err");
> +
> +       test_attach_probe_manual__destroy(skel);
> +}
> +
>  /* attach uprobe/uretprobe long event name testings */
>  static void test_attach_uprobe_long_event_name(void)
>  {
> @@ -416,6 +492,12 @@ void test_attach_probe(void)
>                 test_attach_probe_manual(PROBE_ATTACH_MODE_PERF);
>         if (test__start_subtest("manual-link"))
>                 test_attach_probe_manual(PROBE_ATTACH_MODE_LINK);
> +       if (test__start_subtest("kprobe-perf-by-addr"))
> +               test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_PERF);
> +       if (test__start_subtest("kprobe-link-by-addr"))
> +               test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_LINK);
> +       if (test__start_subtest("kprobe-legacy-by-addr-reject"))
> +               test_attach_kprobe_legacy_by_addr_reject();
>
>         if (test__start_subtest("auto"))
>                 test_attach_probe_auto(skel);
> --
> 2.52.0
>
