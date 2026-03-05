Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EC364E8C
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752227; cv=pass; b=CKIykdqf3oFw4xzN3D0gzUhDqtczCfVir8Ym/s8Ikm7q+7rr4+KzXp8VMcoq502AGuqtc9dh+T5J0QjWAp3xd+pLlJt8gHzkTBdhncjlfGNVrPbjZhuiqMHLG/St1Vw6oE2xRNX8a4zA8a9ZQpz/naiGYgWLdWUROQX9qWN+Oq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752227; c=relaxed/simple;
	bh=IvQTQSXkN/lzrsH+20vLWipAyAWK++OMIxCINlKGieE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mjdy+DN1YgGtP5EcTg+IoPw8EmKa9MDf7WO2lv9Ksy5cGKMkAdVSi+w52XHMckPuNUaATum/yLIyzcT/KqgABe4zz+kKDP65vCUoccNTV1c///qjks75u4dr26E1hGYZDEQVxxK4sQpYdBLo2JBr9+CJ2FSguLAsIIl3PZMgv2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD1x4dJS; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD1x4dJS"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso3022830a12.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 15:10:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772752225; cv=none;
        d=google.com; s=arc-20240605;
        b=C+iRJVgNsisJic9qgZvxjOgs7g4nD3J/UVpJ+WePYp35AWwSt0hazTZyyTijZGCuVH
         NtEVF4vJO/P7Ae2JbrF5HKSQ3wHvR0i37RfyFJXg8tXFawMm05BHC85yhv//lt9BO60H
         nQMCzDG3cw6P2E7pyRTLbIu7fpBtO7VJzQih+Smlc+auZTu/jEU9bfNMjKU/HTDvGOZ9
         rCtWKJ5VG5T6xJ2+5Q0RvQNpK3mxFiVMUrCi6IjJxy3AmWV6xCpdy1N/6UVvgDvgL+FZ
         0BGMxetqyV7z0soA09H5huBtvJsC8/VmCkNPs2O1T8nl/VIum6w2vwz92/ROOtehj9e3
         b3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oHYogqidDxqmpzWYl8t1n7jPajQf/LegJQLqZ82v8Fk=;
        fh=11ul8rzbGb8pjDTdrOlBtAMkerZtoZn7p29NQ5Qo0us=;
        b=S/oBFNhA5XzXwZu2J38+WUnB+WdMfAKXxnbeFrkemHvRfq8LlMfbXKWolFlp/J6nox
         +g8+Id9a6v4tkV/c1d2pJNvg639ilD9vUR7M+fsjazPXc4ulKBgZY24qRlnA1QxnvLth
         Xun25jT80jBW6NOE9HMtIqnJsQwgrpwcCPPIOP37/j09NPaq7TkgHCWjwL/AgmZAL/Xv
         DVnZ5Glbrh0iqfXo/bKSGrwERmMMYZYNfjdRE81RnUkYeWwvgT+A1cLw7wvbwpbmY+OP
         6I3r0FrH1c4mts8Qi5pERjma+FswpNjC479fegGBDa1Pf51LM4YJQmGA9ldyGai/Szhj
         IpEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772752225; x=1773357025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHYogqidDxqmpzWYl8t1n7jPajQf/LegJQLqZ82v8Fk=;
        b=JD1x4dJS4Qbmcnswx2cyDf7QNIak7gxnG2Ne1qV1qq3uJ6yeXeaFGuT/blFD7pb5O/
         dVKmmnC/sYK9FAcIIrNTMk7CODK7Mi7lldH1zO0YfOE6JmOHAzUT3NzFbufOUKvGYSfH
         qvX3uaXddurNBATsH/XnVkkGcvQUIgp9JI1Lwv2tfu50XE3sf6rIX8PzxLZWpTKAokgT
         qhn+4DkK6ZojgPCkrLK7iMydUdwXtlH3OduD9PSlqfFxWIQk2EuaZaaNHzXq8yNCCMhy
         /kd7oajPe8wtEOotB/Da5+7jzwdH4bEdJ1w23GDbvkKKYF+o8LD4zRh4fhpK8545sBfn
         RXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772752225; x=1773357025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oHYogqidDxqmpzWYl8t1n7jPajQf/LegJQLqZ82v8Fk=;
        b=vX8+2i5DgUEIfaqIZvyyknFD1TBCPmX0ilysiQbC5q4w+5qVq8S6LxzaWTP9aVLYIS
         uRFi0kNwtwCORJiq3Bryda/eLsmeTxhODanK19OKBegl8nbe93//4vRq9WGYmp4WZ1+I
         hvICD/m82KzMVPXqMDwuWkNLsZr4nwbGliUnkPgdgPj51gPhEzDIPIeNP4qELu9tE3sL
         y+aOFMmTHWfr1uYGQ+1Lt8IVsGK8aszXGjF/ExTzR5IZ2uUgGStEYDGYN1TjzRNaG7SR
         jEi8GbnYaoVPMU4LlXOlvtnYIXibXWL6xxTTbQmZrsTG7ZcFC5sA/o/k/5wffQRIUQ1b
         du5g==
X-Forwarded-Encrypted: i=1; AJvYcCUi1APDUQrn4if06TSsOpYdZujWBPtIoo8F9NXPQxmX0fkXIhEiqBwuQZBB+lcUmWBTN10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbF8cDDDuXe7z7B9n599xLwk+SKw1T5a6bWwk9Rxd7WmdTfMf
	E+0/wqpmPIfdNXaiurZrEzdqHSHNKtArntM59Ysj+MA6PloMNDd1Zj33iC1XVrj4LHuh8y43rit
	KiwWJNPrpat+ilMZZNuJh/Yed9rN/hr4=
X-Gm-Gg: ATEYQzz+tsTGFnLQxQvV8uV9ZvWEayZwc7si7w9WZNgA6AnXUvGWJc0U3Qw3oAmdF9i
	gVEwOVzJ4i00CjrL++Wa52pmRWMjDRceNOnpIrX5u93GYZuFPyM/mWfUMGBhDwKBqVdI+0taV/h
	dbm7tgqhSR7+JZOGotECrSrwQuHnPDY4jC20u1HPHTFEn3NtPYkszFay8QZwcxeG6oizwI4LBFn
	glsEPsxc9ONHYJ6p9d+zuEJAeTExSPN7VPTBbVQUQ6xLH2kgMcBpK32HW057FoE81625D6UUWTX
	+1d3PRiS2SXBz3qqgmwNURBwq1mGSMpjiw==
X-Received: by 2002:a17:902:d54f:b0:2a9:e8b:5326 with SMTP id
 d9443c01a7336-2ae823a4d58mr1997775ad.23.1772752225422; Thu, 05 Mar 2026
 15:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226093132.437206-1-sun.jian.kdev@gmail.com> <20260226093132.437206-2-sun.jian.kdev@gmail.com>
In-Reply-To: <20260226093132.437206-2-sun.jian.kdev@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Mar 2026 15:10:12 -0800
X-Gm-Features: AaiRm50Poi9eBlaCh0RKyEPdsL-FSf0gcFHcAZ2CKsbcpppBDOcAC4mBr8B4WFE
Message-ID: <CAEf4BzZ1B54Dsu_X4dyu6OH-4heM=NvWy6S6E6ayz2eWpwO3qQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selftests/bpf: probe_user: filter by pid to avoid
 cross-test interference
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 1:31=E2=80=AFAM Sun Jian <sun.jian.kdev@gmail.com> =
wrote:
>
> The test installs a kprobe on __sys_connect and checks that
> bpf_probe_write_user() can modify the syscall argument. However, any
> concurrent thread in any other test that calls connect() will also
> trigger the kprobe and have its sockaddr silently overwritten, causing
> flaky failures in unrelated tests.
>
> Constrain the hook to the current test process by filtering on a PID
> stored as a global variable in .bss. Initialize the .bss value from
> user space before bpf_object__load() using bpf_map__set_initial_value(),
> and validate the bss map value size to catch layout mismatches.
>
> No new map is introduced and the test keeps the existing non-skeleton
> flow.
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/probe_user.c     | 27 ++++++++++++++++++-
>  .../selftests/bpf/progs/test_probe_user.c     | 13 +++++++--
>  2 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/=
testing/selftests/bpf/prog_tests/probe_user.c
> index 8721671321de..280dcdb5ddef 100644
> --- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
> +++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
> @@ -20,6 +20,11 @@ void serial_test_probe_user(void)
>         struct bpf_program *kprobe_progs[prog_count];
>         struct bpf_object *obj;
>         static const int zero =3D 0;
> +       struct test_pro_bss {
> +               struct sockaddr_in old;
> +               __u32 test_pid;
> +       };
> +       struct test_pro_bss results =3D {};
>         size_t i;
>
>         obj =3D bpf_object__open_file(obj_file, &opts);
> @@ -34,6 +39,24 @@ void serial_test_probe_user(void)
>                         goto cleanup;
>         }
>
> +       {
> +               struct bpf_map *bss_map;
> +               struct test_pro_bss bss_init =3D {};
> +
> +               bss_init.test_pid =3D getpid();
> +               bss_map =3D bpf_object__find_map_by_name(obj, "test_pro.b=
ss");
> +               if (CHECK(!bss_map, "find_bss_map", "no bss map\n"))
> +                       goto cleanup;
> +               if (CHECK(bpf_map__value_size(bss_map) !=3D sizeof(bss_in=
it),
> +                         "bss_size", "bss value_size %u !=3D %zu\n",
> +                         bpf_map__value_size(bss_map), sizeof(bss_init))=
)
> +                       goto cleanup;
> +               err =3D bpf_map__set_initial_value(bss_map, &bss_init,
> +                                                sizeof(bss_init));
> +               if (CHECK(err, "set_bss_init", "err %d\n", err))
> +                       goto cleanup;

don't use CHECK() macro, use sproper ASSERT_xxx()


and for email subject, stick to "selftest/bpf:" without extra
"something: " after this

pw-bot: cr


> +       }
> +
>         err =3D bpf_object__load(obj);
>         if (CHECK(err, "obj_load", "err %d\n", err))
>                 goto cleanup;
> @@ -62,11 +85,13 @@ void serial_test_probe_user(void)
>         connect(sock_fd, &curr, sizeof(curr));
>         close(sock_fd);
>
> -       err =3D bpf_map_lookup_elem(results_map_fd, &zero, &tmp);
> +       err =3D bpf_map_lookup_elem(results_map_fd, &zero, &results);
>         if (CHECK(err, "get_kprobe_res",
>                   "failed to get kprobe res: %d\n", err))
>                 goto cleanup;
>
> +       memcpy(&tmp, &results.old, sizeof(tmp));
> +
>         in =3D (struct sockaddr_in *)&tmp;
>         if (CHECK(memcmp(&tmp, &orig, sizeof(orig)), "check_kprobe_res",
>                   "wrong kprobe res from probe read: %s:%u\n",
> diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/=
testing/selftests/bpf/progs/test_probe_user.c
> index a8e501af9604..4bc86c7654b1 100644
> --- a/tools/testing/selftests/bpf/progs/test_probe_user.c
> +++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
> @@ -5,13 +5,22 @@
>  #include <bpf/bpf_core_read.h>
>  #include "bpf_misc.h"
>
> -static struct sockaddr_in old;
> +struct test_pro_bss {
> +       struct sockaddr_in old;
> +       __u32 test_pid;
> +};
> +
> +struct test_pro_bss bss;
>
>  static int handle_sys_connect_common(struct sockaddr_in *uservaddr)
>  {
>         struct sockaddr_in new;
> +       __u32 cur =3D bpf_get_current_pid_tgid() >> 32;
> +
> +       if (bss.test_pid && cur !=3D bss.test_pid)
> +               return 0;
>
> -       bpf_probe_read_user(&old, sizeof(old), uservaddr);
> +       bpf_probe_read_user(&bss.old, sizeof(bss.old), uservaddr);
>         __builtin_memset(&new, 0xab, sizeof(new));
>         bpf_probe_write_user(uservaddr, &new, sizeof(new));
>
> --
> 2.43.0
>
