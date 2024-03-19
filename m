Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7ACFBED
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 01:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710811337; cv=none; b=gAxJIY10Hm0iTurvKtGrJ69HG5jpQMpvJv1hlfnKvIjZHkGSY77y2KEg2O5dghbZtPhmkDT6hDpB4GZwucT75JzPr64IdrLFSHO9f/kvEDHBbqSN2j0dsvYUadCzYV2PZ4Zr81k1Gc8DnBJltTEErCfVSfjsWCqRaBYdjmJythY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710811337; c=relaxed/simple;
	bh=QgusPD7+H6lTkAx7XOfhZiWPQ5wZBhrrZwkYApeut14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkDZy0jgi0iCo0Jv78INkwYT+sdw4eQT/5mYPWp7EywxFK55jTc0oeRhMG3U2/6+PQlBQ+lSYIwO6EluIpJZXOqnwWQRq4jLJa5Slll544T8AY/fGEjNZPQ8n9/99GGrj/ivdgKRx6d3JfQ9TtEfnyRiG32CbdzAjyRVIZZxNJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3Kz//kj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3Kz//kj"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e034607879so9012485ad.0
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 18:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710811335; x=1711416135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAalt7WWJ4l9RN8A8EOYEY4RLROXN9RMJn1FCaPh0Ak=;
        b=T3Kz//kjuXRW8TRQM/WB8wN8jcMfWcOtjCLiRJSo23+Pf/osUqrofUbs8rmAKWzRpZ
         oLm4/R9NLWOB4Cv04JeXvcFRhp6YmrOK+Ra0Aig0RUvV6z76eTGHwKXcfWkoYSbRQqt9
         SXViFWt92Ru3h0XPZhr+UyUL81LrTcjznLARTOLrLdJ2X6jnUG3hiEJdXEtD0bi3MlqK
         DgBCk8HC4R0s0yT7EOUXomTo0bUTBYmTdPfq9hM7plDWJSmHVq534Dh5PMxeIYR/0gQ2
         QhVqin/XjNwyvxagEpu6q7C4Z+3Q1taDk25WsZMTxyyU5nwxdJGQCSlxJLSQ7q+pUn1b
         R1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710811335; x=1711416135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAalt7WWJ4l9RN8A8EOYEY4RLROXN9RMJn1FCaPh0Ak=;
        b=THgZfyB7MDWtmliSRKZtOlerhqTqMw5uZhR9LATy/1aDpYB2xrGGU98ot+zC4ym0mN
         EYcSQDf6kYFxOh0VhSK8xiF1m8hyKyIiY2sv+xKjmn7D5TCCWc4g/uHCkdgtNX6f9VEK
         03ThcISfD4fmaaPHTcwXdqzalB/O+rquHFhxF/RzNQ4lTJoUgzM2/6dW7sb9A8jJywvN
         guj9/5fVEqud0b3V3riqzRpRCYRYsxg6griVsBuGtD5v8aFcR0p8yXlO67HPunrObFdr
         M/cHNgl3YQDmAehzimYOi7GIeKE/wAXC9IhWfz/XRY1ngrSpR+41y6jOtX5r6EGOo1BF
         +Liw==
X-Forwarded-Encrypted: i=1; AJvYcCUbCqT2GIvaoegUTF0p1O27ilmy4Coi2ShaPZtvGdl+zvcwEZztFSQXQh+Yw/+x1za4vaWpNYrEMYfcgA7ujYaoc30d
X-Gm-Message-State: AOJu0Ywimv9tgmSEGN0Ddl0L8tDtHD7BRzVsf9ZM4oX67amcEV/H9PPk
	f9t+3ox4vl6qEk/wdllsJRjVHT5ndhHZVxqxIz7SmCmlexUJYJFh97kddoPAADzc5SPG0JGNlRg
	jATZfVdRpcPPi5MJPelsfLdCubQpjJrNOSt4=
X-Google-Smtp-Source: AGHT+IEIOaJ9BQgn20smGKowtpDYvRRJqih5wLv0rkPVcPoNJ5N6zcePwnX4fMt3eO20RtJ2nJjKE/r0o22LIlu7s2M=
X-Received: by 2002:a17:902:b216:b0:1dc:8f19:8344 with SMTP id
 t22-20020a170902b21600b001dc8f198344mr1389230plr.27.1710811335427; Mon, 18
 Mar 2024 18:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318093139.293497-1-jolsa@kernel.org> <20240318093139.293497-4-jolsa@kernel.org>
In-Reply-To: <20240318093139.293497-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Mar 2024 18:22:02 -0700
Message-ID: <CAEf4BzZxjRuLES-zu6x1FaBp-ujnqMyVa9g_+BpEWVg9sMFAww@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/3] selftests/bpf: Mark uprobe trigger
 functions with nocf_check attribute
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 2:32=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Some distros seem to enable the -fcf-protection=3Dbranch by default,
> which breaks our setup on first instruction of uprobe trigger
> functions and place there endbr64 instruction.
>
> Marking them with nocf_check attribute to skip that.
>
> Adding -Wno-attributes for bench objects, becase nocf_check can
> be used only when -fcf-protection=3Dbranch is enabled, otherwise
> we get a warning and break compilation.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/include/linux/compiler.h                     | 4 ++++
>  tools/testing/selftests/bpf/Makefile               | 2 +-
>  tools/testing/selftests/bpf/benchs/bench_trigger.c | 6 +++---
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compile=
r.h
> index 7b65566f3e42..14038ce04ca4 100644
> --- a/tools/include/linux/compiler.h
> +++ b/tools/include/linux/compiler.h
> @@ -58,6 +58,10 @@
>  #define noinline
>  #endif
>
> +#ifndef __nocfcheck
> +#define __nocfcheck __attribute__((nocf_check))
> +#endif

Let's preserve spelling of the attribut, __nocf_check ?

BTW, just FYI, seems like kernel is defining it as:

#define __noendbr    __attribute__((nocf_check))

Thought somewhere deep in x86-specific code, so probably not a good
idea to use it here?

> +
>  /* Are two types/vars the same type (ignoring qualifiers)? */
>  #ifndef __same_type
>  # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeo=
f(b))
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index e425a946276b..506d3d592093 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -726,7 +726,7 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_=
extern.skel.h $(BPFOBJ)
>  # Benchmark runner
>  $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
>         $(call msg,CC,,$@)
> -       $(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@
> +       $(Q)$(CC) $(CFLAGS) -O2 -Wno-attributes -c $(filter %.c,$^) $(LDL=
IBS) -o $@

let's better use `#pragma warning disable` in relevant .c files,
instead of this global flag?

>  $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
>  $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
>  $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \

[...]
