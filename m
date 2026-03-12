Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF83036C9E3
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348049; cv=pass; b=ZOxUyGNkChebY+iCaCOlKBYnJ8ukAoy02e0xtrWteG5v6dFjswcA96kIaoeji+q+e8f/dJC8rJhzydRxXT2b2/JLnOjb869z6xM37nWwjw1tSg1njHl66gMizMv2wd2Rnd5t5Nm5uA2rGNxEoG2/GMCFByYbPbgRwhuWbuklsFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348049; c=relaxed/simple;
	bh=jNNzfNj0kzqKkzmJMAE2Km8gS3EcvmO8lyG6whragns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/Wnfgk4ExjpgsM0gOZl4bbVbkcCKqiEOrH9K9dX+VtGJsvsuzahXiN/UQTjHRcI3flZ7Yy6npmOJzb1m3gsGMaRmilZPbx2B3q0rg7NVW90LZafNv6x6CRBoiXve6IT4l2ikqKhsFJKRpj5EZ8wXGGWoA9yXqJKqYxHDQ/tDrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6lOSc74; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6lOSc74"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c73bbdc01b7so555477a12.2
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 13:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773348048; cv=none;
        d=google.com; s=arc-20240605;
        b=ErR5YhpwGpro4PzLmB5Uxu+ok/11ava7y/uu7VeemdvV3pScqB1CrCgtisNlaIXYeF
         U9K1l3j+lBC5HWNkUUXfraG+ZBXf1QNZc9LK/YOToo1XKlLKcArvwVG1ZJmv77LjK6/f
         ZGu4PRNqAsl1eyOeQ3VUKutR+oirJOt7L0gF+vre3pLdSy243bLZsP2CCeh13kjMHAx8
         nIb2gutdak/M7ZGvv82EH2E1aR7saD9ykUc6Znn2AJiny78NJoioujpqoJC11DqXgVTd
         4eyOCUgwVuCI3QRwH4mC1Oms0+xyfB594HVAf7kOGINFQyrCQwhvRZe59LrmqgIBN4oJ
         0vJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TVRU7lPCos05gvdNcrN1pur+meZrE13anrW0auAA+OY=;
        fh=JBaJ8HSYyCi6rM+2aem4u6810OQJ/FBi8UsZKqUIyV4=;
        b=U7C+nWlOd47cWuH3aI66xUP16ePYhHs/pvjcxCgtxKL9Q+6Pk2EGESDD0CBd4w36Lc
         88ZRzzugjW1xXW5Una1bgsI4vNVm4mHiEFuq26NxKsFWetyFuO1H7hGLs6qObqav9En7
         2TRMCCM9PCRf0j1b/Nyr25ycnVXjWTplq/LHJpRjpppaeMB9WaZkhvZwbEOf0RBG4E4Z
         a4/QPlUYnhC9W16qYoUZYLSnvPmkgB83l5iCBq0TUxLHpDRAaUcC5Y+1L5wPZOrGWRqq
         VG4L000dM7RPkMg4fKrSDGvEwxSGtEQYGYwcqg0tFWPmFAElQF6kkjrtlYRuBcPOlFDN
         l+mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773348048; x=1773952848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVRU7lPCos05gvdNcrN1pur+meZrE13anrW0auAA+OY=;
        b=D6lOSc74G5UuNoN9twcQMy2/P5mlC/RxG61tLfi7AWLm9no911WSaugA213slKuXJS
         Kj4lJxtm2QEHxHMiuI7hsy43J+rYGdEaCSYcm4aQcDcezg9FJLfXxOEgopt6VG7dNuSC
         WKBnpbDxq53OeQj8gOHh2SF54JL/dD7hNNuLm7LV94g6ffRWR4uzpPfpEux8xEj3ZKdT
         M6JB2YDh4mHwJ5h2l/CaQEpOxJac2RDUkir+1XB88q2RR6MT+6n2e9S7VCtmIQp9rLF6
         so3guKY9KaRV5QYDHgx77nDAXcMU2gFN9O77LG4pF1BIZRa3cuGr0/GDEt8DmbDaM+Wd
         BR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773348048; x=1773952848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TVRU7lPCos05gvdNcrN1pur+meZrE13anrW0auAA+OY=;
        b=WRCwkiHqcnvtwqODuNySAbeljztW2Nv1orU6dCDi4JFmXGIyW73gtvEW/U6wfuKUVc
         H0EQMeCsIt9tJabxafKwImUg19b+Lz5jEAPo+xDCeIVKOJ+aEmmfF0pSx3Ii4up84m70
         yxmJYo6f3/x1ho9fwzIYfRvNZAH6cXVrtMNQvyvpVsND34jErX6ommpknBpNjJ+mRS8H
         /u8VFFU9gHytdqaxecjZTInb9ZF/Bca2398gdSf55mjS/og01Jka/Ql9eLhR6Yl8afoq
         aBAMz/c0RMYZhXPt012BFSM2kLuONrBR/YKqYgnWFTo8V8tddcd9tgZ4Gd0yTE585Ida
         QbQw==
X-Forwarded-Encrypted: i=1; AJvYcCWpQPz17c17Qx8wE+bDgxWxMmOtQ/hhsovYus+d4PSh8TuVanhTRbbtNVhcwWd1TqPfuVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGA/SSl3jbZ1Oq+kGc6kK4IqmYuc5D1yBkcQgAtj2Iza0Jv4R5
	4WZQXeNFExEtm8pP8O2Rry8wdgq9TTj2cqroz0XnpNdKo0VCg/OdJkyFvMHao3WfPKbtfqjaQG6
	3YUFLJn4GZNuMi+skQRc8qaZXYI1qQ24=
X-Gm-Gg: ATEYQzyCKcnCL+pW0aYpe5+qwKQJMjpK9Fx1ztA0omXXYsJwXUbQf24x9zij9CE1f8c
	C/p6YQxddDvlIch7YVaZ87Unt28mrVMH11e7eWudjNVetNbSqaUumqY3ihcz3qM+rT4aIRvSWil
	nn+CYGn1jbKc1GAMDIFgXWaXw/Dvqh5+kmMSB3/vu86Evfn6ulzIHCkpP12vHkPTiSC8LwprXqt
	2z5DdaV8/nTLX5ssJObB4NtEbkRzS381i0eGuM6ARFGj0f+89Vdq/cpCRuINwqR/ZyPrtXj20W4
	Ze3ZEO271MkRnFbDppltv4TWChj5l8gHng==
X-Received: by 2002:a05:6a00:2e94:b0:824:ad1e:3b6e with SMTP id
 d2e1a72fcca58-82a19911ee0mr620449b3a.49.1773348048046; Thu, 12 Mar 2026
 13:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312195017.210430-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260312195017.210430-1-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 13:40:35 -0700
X-Gm-Features: AaiRm53CXKiALYK57Vg0ziiTnLQXs8qz8uEXfEkisEOWi3bCEsMZ7o-Uv_qzjew
Message-ID: <CAEf4Bza-cEaCg1s9pppdRAS1idx71wjZ4+7g-gkM_JXzD1xSyg@mail.gmail.com>
Subject: Re: [PATCH bpf v1] selftests/bpf: Bump path and command buffer sizes
 in bpftool_helpers.c
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	=?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 12:50=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> The path length of 64 is way too low in some envirnoments, which leads
> to subtle failures due to truncation [1].
>
> Replace BPFTOOL_PATH_MAX_LEN with PATH_MAX, and set
> BPFTOOL_FULL_CMD_MAX_LEN to double of PATH_MAX.
>
> [1] https://github.com/libbpf/libbpf/actions/runs/22980753016/job/6671980=
0527
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/testing/selftests/bpf/bpftool_helpers.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testin=
g/selftests/bpf/bpftool_helpers.c
> index 929fc257f431..6a5e99b5e542 100644
> --- a/tools/testing/selftests/bpf/bpftool_helpers.c
> +++ b/tools/testing/selftests/bpf/bpftool_helpers.c
> @@ -2,18 +2,18 @@
>  #include <unistd.h>
>  #include <string.h>
>  #include <stdbool.h>
> +#include <limits.h>
>
>  #include "bpf_util.h"
>  #include "bpftool_helpers.h"
>
> -#define BPFTOOL_PATH_MAX_LEN           64
> -#define BPFTOOL_FULL_CMD_MAX_LEN       512
> +#define BPFTOOL_FULL_CMD_MAX_LEN       (PATH_MAX * 2)
>
>  #define BPFTOOL_DEFAULT_PATH           "tools/sbin/bpftool"
>
>  static int detect_bpftool_path(char *buffer, size_t size)
>  {
> -       char tmp[BPFTOOL_PATH_MAX_LEN];
> +       char tmp[PATH_MAX];
>         const char *env_path;
>
>         /* First, check if BPFTOOL environment variable is set */
> @@ -29,7 +29,7 @@ static int detect_bpftool_path(char *buffer, size_t siz=
e)
>         /* Check default bpftool location (will work if we are running th=
e
>          * default flavor of test_progs)
>          */
> -       snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "./%s", BPFTOOL_DEFAULT_PATH)=
;
> +       snprintf(tmp, PATH_MAX, "./%s", BPFTOOL_DEFAULT_PATH);

nit, but why not s/PATH_MAX/sizeof(tmp)/?

>         if (access(tmp, X_OK) =3D=3D 0) {
>                 strscpy(buffer, tmp, size);
>                 return 0;
> @@ -38,7 +38,7 @@ static int detect_bpftool_path(char *buffer, size_t siz=
e)
>         /* Check alternate bpftool location (will work if we are running =
a
>          * specific flavor of test_progs, e.g. cpuv4 or no_alu32)
>          */
> -       snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "../%s", BPFTOOL_DEFAULT_PATH=
);
> +       snprintf(tmp, PATH_MAX, "../%s", BPFTOOL_DEFAULT_PATH);
>         if (access(tmp, X_OK) =3D=3D 0) {
>                 strscpy(buffer, tmp, size);
>                 return 0;
> @@ -50,7 +50,7 @@ static int detect_bpftool_path(char *buffer, size_t siz=
e)
>
>  static int run_command(char *args, char *output_buf, size_t output_max_l=
en)
>  {
> -       static char bpftool_path[BPFTOOL_PATH_MAX_LEN] =3D {0};
> +       static char bpftool_path[PATH_MAX] =3D {0};

this doesn't matter in practical terms, but I'm not sure all people
realize that this initializes entire buffer with zeroes, not just
first byte. `=3D {0}` is super misleading, it's better to use `=3D {}` in
cases like this

>         bool suppress_output =3D !(output_buf && output_max_len);
>         char command[BPFTOOL_FULL_CMD_MAX_LEN];
>         FILE *f;
> @@ -84,4 +84,3 @@ int get_bpftool_command_output(char *args, char *output=
_buf, size_t output_max_l
>  {
>         return run_command(args, output_buf, output_max_len);
>  }
> -
> --
> 2.53.0
>
