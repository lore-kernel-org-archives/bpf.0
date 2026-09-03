Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC9772618
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394380; cv=pass; b=WHv0SMGFxZuBjGac/t41evwQeQuxV2VoHjiMT3J0QZPhsXjjd7DFW7D7dVy6eaOqNodkNL6D611erjZQClHPLMslBJWJNOFIYkxfkV0XQa9hMEXNusdeeB2xqA8lxWZZCzKxQa6FJHDHkaYe1Q3Z7t3S7tsh04pfmTVx4BKUpwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394380; c=relaxed/simple;
	bh=aGFraPUJE5OYBuCFSogJVu0FWoduGczQM7Z8Zh35VLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbkyuAyY3AAu1ZJdN/EAvrH2+65vq7k2Z2HGF0VjBphBzdkZpjE2HLyF1qSztcGX1vGPQbwXLlyRlqpRtKvfJxuUESwnvQyKkj5wnLWG+Go+azrds09LG2exRa4in6TDupnL6L/9g04KkwsEWsEelLeqM9Ty5lh1x+bGQ3Bf0sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAxEUjp0; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAxEUjp0"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8485b358552so1544705b3a.2
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 17:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788394378; cv=none;
        d=google.com; s=arc-20260327;
        b=lfyW28+KRUoFGmhvkGOrqFsqAmoyg89rwt3W0PfV6oce63oq5H8OqEPcpkNdimDRHo
         QiDExViAQyBnD0i/CT11ki4UaM1OvIR/WN44dKYgeSFl+xCkJDJGDkVidZCG9yTyJBT7
         NTxsNaIfCuPOmSuYwxxU8epVgv3dvj6cwMddDbva9wJevH7mnzxT0swAVt4kSYYIjyee
         HIWxMelns6T81571QdXfhLw+ma69bd6hnE5iIIfSUQdZlEefA3FlqpcUcHS347oOFzFs
         y1sA8VbpruhUJGnFumk6IyAMwA5bboZh/OVB0soOtYPNPytfUU7r8478LY+FL2572iI6
         bzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GT7O9LPIu7WQDBO5+ZEFha64lBovL8sPNnDlbrHuRwU=;
        fh=+3uXqjFiym8QWrBcH5365weH5VjWoesqAzojnmSsjIo=;
        b=TjNykQZk4dBBzZsYDM6JK42eYHBxI6Zr78E22k3uJ6ARrKof605JGkgT1dNmR25tpP
         3hqYn/KKW/js01XBWMPD6Rve1hsWUHZmNrywYVwdDHV+Ss2O4KxmaDZ5XuCarJ1A5T0C
         Yks9ldROM0QM7tcUQUzd/lhRfWDymJbOYxXDtYEru4Y67LzrHkBwLuebfj2Kh/NjN33V
         iubp+GPJ6fmH0O/JiqDQw1W3GXpxqz45HmAJkjWiLsjVL4RqxUzL6a4HgY4nydRFVJ+m
         yByVTHi+JUHoDhKq0XlatN9si4Sdbi8WWvMGXOs21hEL6/NvBZJkPhWPqyLej+RmTFI3
         9JNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788394378; x=1788999178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GT7O9LPIu7WQDBO5+ZEFha64lBovL8sPNnDlbrHuRwU=;
        b=DAxEUjp0FsBRTC/jUpICDnsNqIqbC/sN2/PTWn8t19kQYOURYxKClP0IPBjQgjlKBA
         hp1eQXjRWkHh6m70Py9a+2Gz9sIErvpdbKIDNyLNGgZ6yI9Lld0r6kO02wxonRXuhejP
         iYPCaDUl4OJHrEHHrDUSIhMKQKENwOuXve3UdBGWVR4kKbRA5od9Tezl30pVoGf0FtO9
         G/BA/yZUdPDCOaI9BerSB27NoErJ6am2miTGYzkH0K0i7CqYX6Rtnf4f0HV0nsneq3jW
         7QGTa6tN197+FeS+VkDTts3xPpO8EZHSylPd0jhRXcjE+lZeOy6le0JXyZrD6AElAphX
         hI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394378; x=1788999178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GT7O9LPIu7WQDBO5+ZEFha64lBovL8sPNnDlbrHuRwU=;
        b=It57+HXtytx6dGKBR1tYw0DPWxk/TEj6bcQtGRUpjlViFMj8L2WMTB73KYl+ME7+7Z
         ekhs3t5FxdILF4OriiuVtZ1tiXl/5l1eDmD+5gDigQWmWzS6GXr/iHscgx4eBwGbYkiN
         DlOItg1hmkyI02/aX33rWdsk58E9H6kAEA2oaWCymN+H+rouV5XipJFGRv6bkKqst31A
         oNnZFHKmfLdSuQN+2AH/KPI4zvNKONowLWH094yEuPb8vqgpyRDur1mubv/qNX6KiaIL
         7v6Aux7E4AIKefUZ2gEWn6tt+2VFtAUybXquZTzC88iiYYB5glz0EB+Yhgxu+D1XXDjt
         VvJg==
X-Gm-Message-State: AFuF++k0aOqeF9KBF2BgBXv2sgkM6hlHJuf5LloJLn13WbclbazdMHe0
	1VX6vcBygqPz3uBKI8Bdtfi65ZL5YycYtxJ6ZQsARvVe0fdSm0dHQL/jvTHgKVjqAkMPKyTnv0o
	HXJok+qbQM0PC5hoQUtXECIAgl6IjzIs=
X-Gm-Gg: AYBFou172xl5Hy5j6Niaj3CVApBfj6zmNSOtVGEzZz9IbIdnq9qicDIbHDb4abKjS9Z
	8jTBIPLqRLypTAMP0w3CleyQxES4oQnnC/w8it90nGdjssTa9zXZfBEXXDrfKzPm/6VyrGK10kB
	QJRe1Pr9EVJL5kOl3GFhLP+oQuo7off5StvCWgQ5c9rPWmLQKc3G4YtKjK8Jma4Jm7JV6nfQQ6B
	wxQmXtoWmVq72Nv8kZvku/XYVjQPOWn8F6DaAnO4+7cIJMEj3qWKexOtlSsBSC3TMU41Welk06K
	W6rVS5zWskpDuqD29SPqyihLsLLxvf5MZXmr7pVcVqa30uRBQhN2rZ0FC1Lf7eYmuCLIqa/AET6
	KgE6s6uI5pJMXrWfOfjS5sq/MvQ==
X-Received: by 2002:a05:6a00:a25c:b0:855:1590:ba2b with SMTP id
 d2e1a72fcca58-85ed1d076bamr13847122b3a.5.1788394378249; Wed, 02 Sep 2026
 17:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831133809.1161-1-zhaofuyu@vivo.com> <20260831133809.1161-3-zhaofuyu@vivo.com>
In-Reply-To: <20260831133809.1161-3-zhaofuyu@vivo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Sep 2026 17:12:45 -0700
X-Gm-Features: AcwNN1Xh0ZBM8qa9H6dmpY3f5IHeM7XO8aDWYCpQL1SZlbp3qzCTFdwJl0PB8pM
Message-ID: <CAEf4BzY_MJa-Eyd2iaE65B_jPVx07PU+ctCrQtLtHQK+PEzsXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: add tests for selective
 module BTF loading
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 6:38=E2=80=AFAM Fuyu Zhao <zhaofuyu@vivo.com> wrote=
:
>
> Add selftests covering selective kernel module BTF loading through
> bpf_object_open_opts.
>
> The tests verify that:
> - the existing behavior is preserved when btf_module_names is not
>   specified, and loading succeeds when the required module BTF is
>   specified;
> - a required module BTF is skipped when the module is not specified in
>   btf_module_names;
> - an empty btf_module_names list skips loading all module BTFs;
> - invalid module BTF name lists are rejected.
>
> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
> ---
>  .../bpf/prog_tests/btf_module_names.c         | 162 ++++++++++++++++++
>  .../selftests/bpf/progs/btf_module_names.c    |  13 ++
>  2 files changed, 175 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_nam=
es.c
>  create mode 100644 tools/testing/selftests/bpf/progs/btf_module_names.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_names.c b/=
tools/testing/selftests/bpf/prog_tests/btf_module_names.c
> new file mode 100644
> index 000000000000..68f4a8d73560
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "btf_module_names.skel.h"
> +
> +static void btf_module_names_load(void)
> +{
> +       struct btf_module_names *skel =3D NULL;
> +       int ret;
> +       const char *mod_names[] =3D { "bpf_testmod" };
> +
> +       LIBBPF_OPTS(bpf_object_open_opts, opts,
> +               .btf_module_names =3D mod_names,
> +               .nr_btf_module_names =3D 1,
> +       );
> +
> +       /* Verify backward compatibility. */
> +       skel =3D btf_module_names__open_opts(NULL);
> +       if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts default"))
> +               goto out;
> +
> +       ret =3D btf_module_names__load(skel);
> +       ASSERT_OK(ret, "btf_module_names__load default");
> +
> +       btf_module_names__destroy(skel);
> +       skel =3D NULL;
> +
> +       skel =3D btf_module_names__open_opts(&opts);
> +       if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts"))
> +               goto out;
> +
> +       ret =3D btf_module_names__load(skel);
> +       ASSERT_OK(ret, "btf_module_names__load");
> +out:
> +       btf_module_names__destroy(skel);
> +}
> +
> +/*
> + * Verify that an unrequested module BTF is skipped. The BPF program
> + * requires the BTF of bpf_testmod, but bpf_testmod is not specified in
> + * btf_module_names, so its BTF is skipped and the BPF program fails to =
load.
> + */
> +static void btf_module_names_skip(void)
> +{
> +       struct btf_module_names *skel =3D NULL;
> +       int ret;
> +       const char *mod_names[] =3D { "module_nonexist" };
> +
> +       LIBBPF_OPTS(bpf_object_open_opts, opts,
> +               .btf_module_names =3D mod_names,
> +               .nr_btf_module_names =3D 1,
> +       );
> +
> +       skel =3D btf_module_names__open_opts(&opts);
> +       if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts"))
> +               goto out;
> +
> +       ret =3D btf_module_names__load(skel);
> +       ASSERT_EQ(ret, -ESRCH, "btf_module_names__load");
> +
> +out:
> +       btf_module_names__destroy(skel);
> +}
> +
> +/*
> + * Verify that an empty filter skips loading all module BTFs. The BPF
> + * program requires bpf_testmod BTF, so it fails to load.
> + */
> +static void btf_module_names_empty(void)
> +{
> +       struct btf_module_names *skel =3D NULL;
> +       int ret;
> +       const char *mod_names[] =3D { NULL };
> +
> +       LIBBPF_OPTS(bpf_object_open_opts, opts,
> +               /* Non-NULL pointer with zero entries represents an empty=
 list. */
> +               .btf_module_names =3D mod_names,
> +               .nr_btf_module_names =3D 0,
> +       );
> +
> +       skel =3D btf_module_names__open_opts(&opts);
> +       if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts empty"))
> +               goto out;
> +
> +       ret =3D btf_module_names__load(skel);
> +       ASSERT_EQ(ret, -ESRCH, "btf_module_names__load empty");
> +
> +out:
> +       btf_module_names__destroy(skel);
> +}
> +
> +static void btf_module_names_invalid(void)
> +{
> +       struct btf_module_names *skel =3D NULL;
> +       const char *names[] =3D { NULL };
> +       const char *empty_names[] =3D { "" };
> +       const char *duplicate_names[] =3D {
> +               "bpf_testmod", "bpf_testmod",
> +       };
> +       LIBBPF_OPTS(bpf_object_open_opts, opts,
> +               .btf_module_names =3D names,
> +               .nr_btf_module_names =3D 1,
> +       );
> +
> +       skel =3D btf_module_names__open_opts(&opts);
> +       ASSERT_EQ(libbpf_get_error(skel), -EINVAL,
> +                 "btf_module_names__open_opts null");
> +       btf_module_names__destroy(skel);
> +
> +       opts.btf_module_names =3D empty_names;
> +       skel =3D btf_module_names__open_opts(&opts);
> +       ASSERT_EQ(libbpf_get_error(skel), -EINVAL,

please don't use libbpf_get_error(), this is legacy and is
discouraged. check that skell is null and then look at errno


> +                 "btf_module_names__open_opts empty");
> +       btf_module_names__destroy(skel);
> +
> +       opts.btf_module_names =3D duplicate_names;
> +       opts.nr_btf_module_names =3D 2;
> +       skel =3D btf_module_names__open_opts(&opts);
> +       ASSERT_EQ(libbpf_get_error(skel), -EINVAL,
> +                 "btf_module_names__open_opts duplicate name");
> +       btf_module_names__destroy(skel);
> +}
> +
> +void test_btf_module_names(void)
> +{
> +       struct btf *vmlinux_btf =3D NULL;
> +       struct btf *module_btf =3D NULL;
> +
> +       if (!env.has_testmod) {
> +               test__skip();
> +               return;
> +       }
> +
> +       vmlinux_btf =3D btf__load_vmlinux_btf();
> +       if (libbpf_get_error(vmlinux_btf)) {
> +               test__skip();
> +               return;
> +       }
> +
> +       /* Ensure bpf_testmod BTF is available. */
> +       module_btf =3D btf__load_module_btf("bpf_testmod", vmlinux_btf);
> +       if (libbpf_get_error(module_btf)) {
> +               btf__free(vmlinux_btf);
> +               test__skip();
> +               return;
> +       }
> +
> +       btf__free(module_btf);
> +       btf__free(vmlinux_btf);
> +
> +       if (test__start_subtest("btf_module_names_load"))
> +               btf_module_names_load();
> +
> +       if (test__start_subtest("btf_module_names_skip"))
> +               btf_module_names_skip();
> +
> +       if (test__start_subtest("btf_module_names_empty"))
> +               btf_module_names_empty();
> +
> +       if (test__start_subtest("btf_module_names_invalid"))
> +               btf_module_names_invalid();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/btf_module_names.c b/tools=
/testing/selftests/bpf/progs/btf_module_names.c
> new file mode 100644
> index 000000000000..232adc0f33f6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/btf_module_names.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +SEC("fentry/bpf_testmod_loop_test")
> +int BPF_PROG(test_btf_module_names)
> +{
> +       return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.34.1
>
