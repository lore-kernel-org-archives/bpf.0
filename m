Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CFF1AADC
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666714; cv=none; b=bYNnR/Nu+7e6Oi8XexZz0Q0PhsnLNZ3c5Ue0aNEgpMZu55aWhGhuXYyPGFSmVG7zelxVO3AmuBXeS8XL/oWDHHkKXyo4j+4QhZ2ElMDmW2ipaWnf/MpP5/LyhkNa3BEcJKFE24bEBddChGMh2EGKWPygNhHeYn5TrAsRoXIueUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666714; c=relaxed/simple;
	bh=93eItdb45/SxvA0bB5zypz5ygnRFiRusWrdKOWBCq7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmoenYLFlCtzZ5Rcv2SUhmQTn5n3cNCOuBPALyQnZjd8n76tRRzx5HNVTo5hLauehN6UHbUL7ajv+J8X2GFQjeEzMkZfNBzEbDsa7m7JP78hjbjrfd8Ostzfkfg2qY21BzV0xYDEqy7eUXz+9cMJgsyK0ks94i2DrfNJ11Jg7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZSy52Ba; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZSy52Ba"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so1626915ad.1
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 11:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709666712; x=1710271512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG9dgg6ASQ9HeaPGGfu0PtF/VXtVrjasMN6Rp7DpYc4=;
        b=nZSy52BaSL7lGQWBtTDrG0aegI+w92ZcTXCv4U0SzadcYHjFHXXW9tzKdpWXNcOmyL
         rH9I7jRIXYRoJMKeN6xK5RyU0sZqPJJzmj4nKYxCpXhPQBX+s9zOYpzNBiWGpc2QgIwA
         ZIPo/s+jI67XsqpYIUUlYv3jnEKokD/BoTI+NNGQMFatXI8+D1K0kN6NXjqQiptuxIDY
         F97b6oRHG31AWx3nz7BweMDPriXKrm/5PpP+lU45a7YvoBpTyX4WHbnBYOCX3PskhxhJ
         hHbh4woN0Uva6FNQio9UcPwd9u3KknSq2Z2/IvgRMOBHrujcwtlsk7LgVJ00yMj8bD6M
         kF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709666712; x=1710271512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cG9dgg6ASQ9HeaPGGfu0PtF/VXtVrjasMN6Rp7DpYc4=;
        b=pCIemWOpDGCltetiOy7DQSx3UUoUYJieYMHxDLJ+UxSPv5LRmPWdtvFWu7O1JZJhoB
         JqW4uZaMI0YPIsN1r7oOanT20uJ8Y3lrSsBnSScgtpR2+xq2S7r0ZVvhoqxf5rOaQ9UP
         DneS49B56fGA9YXgZaCbWF5KCKM2GYjbc9vxx5b9TXjigAfcbKb2II8B1mwzRiTBUcDF
         Jo6VITCIHprMYk39RxBrvzPuHHRVBV1pWXlBEdlIK9BU9ESG5sSYSDQIOxI9/MeVgT+j
         0laSsFohz4BzEEUfSiDhJvxVunTsmozEnu+XCel+I3pZXc1bRFYNuk1FzjwAzwKLRQQb
         GAPA==
X-Gm-Message-State: AOJu0YxqD4HM1AW2DFGWG0ahIX4v/LnnhtsGkJ+zAtmDOZItsLGkbYDg
	YLCIgAjDDZFKZ3Se09LE8axM2ew3eoObqaE0mg5OVYFmSWMhtNk97JYo8aiECGQb1fN3GNAaTmv
	0DY6eEOjH4V5x00u/m4gUbLLxEmU=
X-Google-Smtp-Source: AGHT+IEKY7X9ZnTHY3pGZ6Tr6tr3YEoyYv3ZKlKQtS3aHMZs3vA281KGaPBK5JbIaezDIE8Vkv+xQXTfixeR+tX/SLQ=
X-Received: by 2002:a17:902:c951:b0:1dc:673:1932 with SMTP id
 i17-20020a170902c95100b001dc06731932mr3756419pla.38.1709666712007; Tue, 05
 Mar 2024 11:25:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304225156.24765-1-eddyz87@gmail.com> <20240304225156.24765-6-eddyz87@gmail.com>
In-Reply-To: <20240304225156.24765-6-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 11:24:59 -0800
Message-ID: <CAEf4BzaxJ3w0-rpShqd5qAMMyHmfhYCOCqAUNKEO15sd0QCStw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 05/15] selftests/bpf: utility functions to
 capture libbpf log in test_progs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Several test_progs tests already capture libbpf log in order to check
> for some expected output, e.g bpf_tcp_ca.c, kfunc_dynptr_param.c,
> log_buf.c and a few others.
>
> This commit provides a, hopefully, simple API to capture libbpf log
> w/o necessity to define new print callback in each test:
>
>     /* Creates a global memstream capturing all output passed to
>      * libbpf_print_fn.
>      * Returns 0 on success, negative value on failure.
>      * On failure the description is printed using PRINT_FAIL and
>      * current test case is marked as fail.
>      */
>     int start_libbpf_log_capture(void)
>
>     /* Destroys global memstream created by start_libbpf_log_capture().
>      * Returns a pointer to captured data which has to be freed.
>      * Returned buffer is null terminated.
>      */
>     char *stop_libbpf_log_capture(void)
>
> The intended usage is as follows:
>
>     if (start_libbpf_log_capture())
>             return;
>     use_libbpf();
>     char *log =3D stop_libbpf_log_capture();
>     ASSERT_HAS_SUBSTR(log, "... expected ...", "expected some message");
>     free(log);
>
> As a safety measure, free(start_libbpf_log_capture()) is invoked in the
> epilogue of the test_progs.c:run_one_test().
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 57 ++++++++++++++++++++++++
>  tools/testing/selftests/bpf/test_progs.h |  3 ++
>  2 files changed, 60 insertions(+)
>

[...]

> +/* Destroys global memstream created by start_libbpf_log_capture().
> + * Returns a pointer to captured data which has to be freed.
> + * Returned buffer is null terminated.
> + */
> +char *stop_libbpf_log_capture(void)
> +{
> +       char *buf;
> +
> +       if (!libbpf_capture_stream)
> +               return NULL;
> +
> +       fputc(0, libbpf_capture_stream);
> +       fclose(libbpf_capture_stream);
> +       libbpf_capture_stream =3D NULL;
> +       /* get 'buf' after fclose(), see open_memstream() documentation *=
/
> +       buf =3D libbpf_output_capture.buf;
> +       bzero(&libbpf_output_capture, sizeof(libbpf_output_capture));

please use memset():

$ rg -w memset | wc -l
355
$ rg -w bzero | wc -l
12


> +       return buf;
> +}
> +
>  static int libbpf_print_fn(enum libbpf_print_level level,
>                            const char *format, va_list args)
>  {
> +       if (libbpf_capture_stream) {
> +               va_list args2;
> +
> +               va_copy(args2, args);
> +               vfprintf(libbpf_capture_stream, format, args2);
> +       }

should we take into account verbosity settings? capturing LIBBPF_DEBUG
logs probably isn't very useful (but will make debugging harder,
probably)

> +
>         if (env.verbosity < VERBOSE_VERY && level =3D=3D LIBBPF_DEBUG)
>                 return 0;
>         vfprintf(stdout, format, args);
> @@ -1081,6 +1137,7 @@ static void run_one_test(int test_num)
>                 cleanup_cgroup_environment();
>
>         stdio_restore();
> +       free(stop_libbpf_log_capture());
>
>         dump_test_log(test, state, false, false, NULL);
>  }
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
> index 80df51244886..0ba5a20b19ba 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -397,6 +397,9 @@ int test__join_cgroup(const char *path);
>                 system(cmd);                                            \
>         })
>
> +int start_libbpf_log_capture(void);
> +char *stop_libbpf_log_capture(void);
> +
>  static inline __u64 ptr_to_u64(const void *ptr)
>  {
>         return (__u64) (unsigned long) ptr;
> --
> 2.43.0
>
