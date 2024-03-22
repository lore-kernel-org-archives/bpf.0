Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0405D47A
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126118; cv=none; b=DT5ea8zKr5M9N2xJIFtCX0OAtZOpALuyAFcK/zCzaf9/acZCfiL2kjVBqaRcEvOcX/ZsvFSvqeRhkFzio5tuyFnvuUTUgsL2hBu0n5HD63LhBsoPMnIV5vzRZov0SivhE6q5cccpMo5gy3nGoce5wnjA51aNUsL1a5uZAKqTK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126118; c=relaxed/simple;
	bh=/Ih6yVL9ehHDID3woCvNF7Q9BSqu2ycgvyoGzQrLjCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euvvw4W7/QuwHnhgDS3aYd+by3KVGpatC5G9KsDNSNjqDdCIgxUe0NDmroJrs3ALF7nSUnhYuMUEGvON07bwH06UH+z4Bbc2dcIWBusfzmSUg2zgs4rTNNtyD6uwizf4olWDit1ArnW3fHjy2YWO/+WtCAO+DLnSLpZ7Ph5KXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klezkiUO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klezkiUO"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29a8911d11cso1404323a91.1
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126116; x=1711730916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFv1ywsJD7mju6Dq1Uo8ptwyWuUry6U+nzXNSZW6ayE=;
        b=klezkiUOnZQqpkV1K6gW5/+ManCRGqjs2i4hal30zJ5D9oL5fUZGh08pwgdA/42ctR
         kqymcVUY9Co90Bjs+iKqyVnNjEoCbzMJ0owZ6eGBorTKMikSC17lE0ttKE5Id4+inqD3
         JQmSFjVA33qK/cgP8YljHW1hTGSUOxYe5Yf8ktx0fSpih0csm0FootpRl7XqxRuM9jAh
         +gNcQfRNw0d6G/PtdZYnIA6II6/CdoYcOLiYpEDVWpVHSFb1pgGVlSUUwdKNaMdHR2UN
         5UFFQeiNB7a9vu9n2ux2gKY/zDa5xZtI9U84RErhWh1zWCZeanJWSzGcFUlwGY0xuEon
         0I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126116; x=1711730916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFv1ywsJD7mju6Dq1Uo8ptwyWuUry6U+nzXNSZW6ayE=;
        b=iT0s7xOGODHR3jRsMHWBVMisRPMTkdL9W+OSpllfdN+r9C45ZA8zahYcmKuHzYIEAq
         kWNtqQqifaBcoRlRf5tgqpxfzvB5sopfqpdedJYAujUfcN+eGDMmTxUfncgboql0VE82
         WTCttEfmcYfA3/nlOUD6HrsFzkPTEu0xc121cvUseWUHjgp5Ns2KQx+W8tK0WhdrNDOY
         fmot50CNyYz0G8BreF33HBEkB1Fmkok1qNdmZABka/XWUuRCZL9u3eJfiOjEJa5pkLuG
         oCOG+40lN68vgp0s5MxaVE0K57jaF6U/d2sk8vdLYCSS3ClL1F2NGRNMvk/E3zhBodeR
         9+0g==
X-Gm-Message-State: AOJu0YxVvW1p01BptF0yDWcAUcxihCv1Tdw/z3EJ15AEbiED/u59rxhT
	2mgjxTIcddgUZaRF6ITffVdQ/uTqrnrDd/bz3LBhR8/xrJbAQVM7Q2SnNBEkPVzZKnVFHJAhIj4
	Getj52//GjVp/C3H9y8zt2kgGZF0=
X-Google-Smtp-Source: AGHT+IHkmOIjP4r/cBjJ+9VY/sqqH2r4Yxd8IY/8Vbb1x5xiu9yV5xlrbx7pkpqtVyOT7o+9aQmcWBDI2zlX6+KoFMo=
X-Received: by 2002:a17:90a:8046:b0:29c:289b:1eb3 with SMTP id
 e6-20020a17090a804600b0029c289b1eb3mr224627pjw.6.1711126116306; Fri, 22 Mar
 2024 09:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200103.2218888-1-yonghong.song@linux.dev> <CAEf4BzZnaWjyUBonL=YBFS+9z7E_FBcJAwEaYuDGGrA-Z6zZ0Q@mail.gmail.com>
 <b5d76a69-0ca3-4900-980f-2c9c32988f8e@linux.dev>
In-Reply-To: <b5d76a69-0ca3-4900-980f-2c9c32988f8e@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Mar 2024 09:48:24 -0700
Message-ID: <CAEf4Bza_geEAGWC1huvT37OcWs18K_pDf+mKDjY=gkrdNuFqHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] selftests/bpf: Replace CHECK with ASSERT
 macros for ksyms test
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:41=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 3/22/24 9:13 AM, Andrii Nakryiko wrote:
> > On Thu, Mar 21, 2024 at 1:01=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> I am going to modify ksyms test later so take this opportunity
> >> to replace old CHECK macros with new ASSERT macros.
> >> No functionality change.
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   .../testing/selftests/bpf/prog_tests/ksyms.c  | 30 ++++++-----------=
--
> >>   1 file changed, 9 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/te=
sting/selftests/bpf/prog_tests/ksyms.c
> >> index b295969b263b..6a86d1f07800 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> >> @@ -5,8 +5,6 @@
> >>   #include "test_ksyms.skel.h"
> >>   #include <sys/stat.h>
> >>
> >> -static int duration;
> >> -
> >>   void test_ksyms(void)
> >>   {
> >>          const char *btf_path =3D "/sys/kernel/btf/vmlinux";
> >> @@ -18,43 +16,33 @@ void test_ksyms(void)
> >>          int err;
> >>
> >>          err =3D kallsyms_find("bpf_link_fops", &link_fops_addr);
> >> -       if (CHECK(err =3D=3D -EINVAL, "kallsyms_fopen", "failed to ope=
n: %d\n", errno))
> >> -               return;
> >> -       if (CHECK(err =3D=3D -ENOENT, "ksym_find", "symbol 'bpf_link_f=
ops' not found\n"))
> >> +       if (!ASSERT_TRUE(err !=3D -EINVAL && err !=3D -ENOENT, "bpf_li=
nk_fops"))
> >>                  return;
> > it's best to keep each individual equality test as ASSERT_EQ(), that
> > way we get more specific and detailed error (with expected vs actual
> > value), which here we'll just get "wanted true but got false", and
> > then we'd have to debug some more which of the conditions it is. So
> > please keep the original granularity of checks everywhere.
>
> Do you mean
>
>          if (ASSERT_EQ(err, -EINVAL, "..."))
>                  return;
>          if (ASSERT_EQ(err, -ENOENT, "..."))
>                  return;
>
> This does not really work, for example if err =3D 0, it will declare test
> failure.


if (!ASSERT_NEQ(err, -EINVAL, "..."))
    return;
if (!ASSERT_NEQ(err, -NOENT, "..."))
    return;

It's mirroring original logic. We had two independent checks there? In
this case the condition is "not equal" (ASSERT_NEQ).

>
>
> >
> >>          err =3D kallsyms_find("__per_cpu_start", &per_cpu_start_addr)=
;
> >> -       if (CHECK(err =3D=3D -EINVAL, "kallsyms_fopen", "failed to ope=
n: %d\n", errno))
> >> -               return;
> >> -       if (CHECK(err =3D=3D -ENOENT, "ksym_find", "symbol 'per_cpu_st=
art' not found\n"))
> >> +       if (!ASSERT_TRUE(err !=3D -EINVAL && err !=3D -ENOENT, "__per_=
cpu_start"))
> >>                  return;
> >>
> >> -       if (CHECK(stat(btf_path, &st), "stat_btf", "err %d\n", errno))
> >> +       if (!ASSERT_OK(stat(btf_path, &st), "stat_btf"))
> >>                  return;
> >>          btf_size =3D st.st_size;
> >>
> >>          skel =3D test_ksyms__open_and_load();
> >> -       if (CHECK(!skel, "skel_open", "failed to open and load skeleto=
n\n"))
> >> +       if (!ASSERT_OK_PTR(skel, "test_ksyms__open_and_load"))
> >>                  return;
> >>
> >>          err =3D test_ksyms__attach(skel);
> >> -       if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", =
err))
> >> +       if (!ASSERT_OK(err, "test_ksyms__attach"))
> >>                  goto cleanup;
> >>
> >>          /* trigger tracepoint */
> >>          usleep(1);
> >>
> >>          data =3D skel->data;
> >> -       CHECK(data->out__bpf_link_fops !=3D link_fops_addr, "bpf_link_=
fops",
> >> -             "got 0x%llx, exp 0x%llx\n",
> >> -             data->out__bpf_link_fops, link_fops_addr);
> >> -       CHECK(data->out__bpf_link_fops1 !=3D 0, "bpf_link_fops1",
> >> -             "got %llu, exp %llu\n", data->out__bpf_link_fops1, (__u6=
4)0);
> >> -       CHECK(data->out__btf_size !=3D btf_size, "btf_size",
> >> -             "got %llu, exp %llu\n", data->out__btf_size, btf_size);
> >> -       CHECK(data->out__per_cpu_start !=3D per_cpu_start_addr, "__per=
_cpu_start",
> >> -             "got %llu, exp %llu\n", data->out__per_cpu_start,
> >> -             per_cpu_start_addr);
> >> +       ASSERT_EQ(data->out__bpf_link_fops, link_fops_addr, "bpf_link_=
fops");
> >> +       ASSERT_EQ(data->out__bpf_link_fops1, 0, "bpf_link_fops1");
> >> +       ASSERT_EQ(data->out__btf_size, btf_size, "btf_size");
> >> +       ASSERT_EQ(data->out__per_cpu_start, per_cpu_start_addr, "__per=
_cpu_start");
> >>
> >>   cleanup:
> >>          test_ksyms__destroy(skel);
> >> --
> >> 2.43.0
> >>
