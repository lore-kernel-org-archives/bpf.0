Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B53326A0A7
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275400; cv=pass; b=NtHFF0GeTKlXE90RAOxhbd2APxDkDU6A+FaDwASHhFp4MQYlVWB2BKwATWK+y9UIzLhTTsOJSaI+WaUIDCH/Ws8IfZQeVIOc9k7Ouc/qEVAh0u5vdAhODnCqtkp1f4Q40ldSgn/vgH3WhoO+UBr6ddeueExCTpAzCSORyiZRzVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275400; c=relaxed/simple;
	bh=YcypzZhNU7pNSG3Co3XkiZS4WRLodx1GYdn6Od+L76g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIhSpS1ax2mUyCNixKCTSx1lehuUPPlr1G69PtqO6c+apyy5PJUbSgqNsUEVU6hS6PPdX7tr052Ma5x8BpoOmJCloG5H4KwaOK9RUuGp7tEnQOl3Z5Msxt/MvHR5TYEFOfGH5DT2TDUaIWN0Q6HxmH37BYcbXNcCBRBTptRsoug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVjbBdP7; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVjbBdP7"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aea4ebb048so24875ad.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 17:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773275396; cv=none;
        d=google.com; s=arc-20240605;
        b=M73X+nhgf1Se5eGtnD+aAh/E+jJGEUDuSjLbETraqqevoOUi+MEA5yiYPN52Gqe/Uk
         2U1wZtE/JzziMkZzAQdwXDAEXbKv5WzYpYorN8vZohgqel9ZVg0PHrZBPj/9OHCX4st8
         mRlwwkW4Zxd7crPvbqYngyMkTeFsRCweVdu0YxpXpAZl0xxBieltPyGVa+Sblwwm7fL5
         yaFEIThdkvYCsS8Cip9Pns/2Lll+u5ZL4Kq6AT2bWNl4YyuUH0DEuqUQmPdQnhpYNpK7
         JHyyhN72KM2zV5N2WIq8loZNoMW3i5iwKdzJRUmt9QeBiAxsPgX8G9geKJGmNm3uqt1N
         yjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1PC+/wr2syCqvxGBoZe6+L+D9Kxcq5YGZvRoBAu0gk4=;
        fh=JQN+nqSQI/yQhnjC+9EIR7ag0aXZEjUhfN8msapSM8c=;
        b=ZuSw1R0o9DIfCAH1DFe7kHpgiNJcBzz4GgkDenIxi5FO2txTzRPnadZSdzFPFiJawI
         U7k0joplekEL0g3qhi8oGg7f7WI+56ACiGfYKjCecUoMhs6QXWirA51DZvjpNmSEfCfu
         SFbvjJhtJuYmKoNb1U7hzLhQ223m54GglvasL3JOB+NbsKjTZ7ck4Q2uFQd0yD2De9lK
         IOMH67H18x3z4ymTsxgqhXKiZzV8XtxwUv+N6fL6pofg/lMRDFc8E5FoFEmmlxKyLdVk
         DuV0+fe4Qmfs0jt06jGxllxeLy4R1xWTz0j294rxcnB36Rilmx+oIsEDEfNp8YI2Ihw3
         zRyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773275396; x=1773880196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PC+/wr2syCqvxGBoZe6+L+D9Kxcq5YGZvRoBAu0gk4=;
        b=XVjbBdP7BywbdQHnDO4m7R6dIcnBKfdSjjyxAOsnRIfeAtI8OB7DcQrXFTffvDlv9v
         aOc3Kk2i1WHPrsFzZR1wOLt2OiDAqCWMWZnFQmZxNxmRHzvz5U481DdTnFQQQlbZahF6
         eS8S4j8vM0tiaa9tIW9ko3rW6KKGUA6gjHKPfBE2oltaZgTS+BLlSqye8cH4VPR8mIQl
         xNjycZD18On3+wcyBr/hfDx/XIedPP0P4bCQ+4VKExJ+Z2LBU+Svnqkg7KNl5RZDAGAE
         8kaND5KiiKt0uLIv1dM8/2rAvj0Cn77WaY5SnliPXDfXUJ/e/Qe6bmwQnWIOykz4J2TH
         02iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773275396; x=1773880196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PC+/wr2syCqvxGBoZe6+L+D9Kxcq5YGZvRoBAu0gk4=;
        b=HDakGT3zQ6ElqEnmK1o/nhIMpmiDhydpbpGKsbV/OtdCnQlxJUH/GGmsQT9C09KNSB
         t+e2A4mL4CGMUBiE2FhBc2Zni9t0spzU7ilSfEzJBqOXnJxqQc7TNp6HVhzncUZV1hl4
         ucP4WDO55GQiAAYGE7L1WvS2MqnArmr02Xb9gOfAm8EXdOubGqLxl6AjQIq8K7a6iUrK
         Book6elrZjqaXrJdlhXSaK2v9ZYZ6Ore83pqoVlrNzSHRI2/MVp9ys/PyP+AyKL7n301
         AyFMdIUNQdT+ljTFkYQ75oqHupxcbQ+iash+zrlWgM04LPdBj9IYX+gTWJc4AHfzKfuo
         xYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqXZNcUj2q/+IWCP11rsuVX+KNP2nqhMdRij1eoBmRmlYp80W47wcKRoI44zLSlSXBbf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWaCyrzfy0MDLYK1jixYW/v8KCBdPeY/WEJrIpVKyMFV5bZ7Mz
	sgLBHlqgQb9pw+LR0H5hRIudh/nIM/3euLOe1LYY69btG7e64/jejw5TsOA6QZReEMKszT4a++u
	2EeFX15CVM2KcqAruiFjHR0mpQ2JquwD33H9zAELD
X-Gm-Gg: ATEYQzyw99OyAIHa6JqhLjzg04/QnEbcVZsFgHsdMm39JoQJ0dy9RY5LDsUXdM9JJDZ
	tqDTX1mENOqGJ0U9iJDvITR2xHjZm71A0Erv/ZksJS4OjoGTWFvojgqkaOWmjRrA1kvxlxzwsFk
	sXvHc5URS9/cpYG3a8w8xJJOWxx7vDYJeDyIh9/Jo5rpX4p5Q437mrwiOp19sX6aCnFDbgZHARF
	qOLXleWXIkQHgcFf1WIYfvdKwrfPvOLoVibybANUUx1/wNvmW+z6eBx1OuJAnW4uOrDclHomS5h
	4cOxVm+Fl2XEHyCa/ogljpxtQlxF1o+/BL/gIr+KI1H8H4M=
X-Received: by 2002:a17:903:3c67:b0:2ae:80a3:98a9 with SMTP id
 d9443c01a7336-2aebd197d2bmr962485ad.11.1773275395866; Wed, 11 Mar 2026
 17:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com> <20260311-tools_build_fix_zero_init-v4-12-9e35bdb99cb3@arm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-12-9e35bdb99cb3@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Mar 2026 17:29:44 -0700
X-Gm-Features: AaiRm51j9bOAiNXwV4INuHof8fl1AJbNKlxnNgZFr0pcoAP2BOsfzP0vifju5JA
Message-ID: <CAP-5=fUsOzjCAOEyJF1cwDbfjSHi=TKjWd1kL6tWWvLu19CFkA@mail.gmail.com>
Subject: Re: [PATCH v4 12/30] tools build: Append extra host cflags
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	William Breathitt Gray <wbg@kernel.org>, Barry Song <baohua@kernel.org>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kent Gibson <warthog618@gmail.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 1:31=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append HOST_EXTRACFLAGS to HOSTCFLAGS so that additional flags can be
> applied to the host compiler.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/build/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index 3a5a3808ab2a1dedd40f35ea322913e8a0788130..a86ce3d99e2bb1c005942d9c3=
2191e6eaa55cf50 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -40,14 +40,16 @@ endif
>  FIXDEP         :=3D $(OUTPUT)fixdep
>  FIXDEP_IN      :=3D $(OUTPUT)fixdep-in.o
>
> +HOSTCFLAGS     :=3D $(HOST_EXTRACFLAGS) $(KBUILD_HOSTCFLAGS)


Hi Leo, should HOST_EXTRACFLAGS appear after KBUILD_HOSTCFLAGS here?
This allows the extra flags to override the build system's flags.

Thanks,
Ian

>
> +
>  # To track fixdep's dependencies properly, fixdep needs to run on itself=
.
>  # Build it twice the first time.
>  $(FIXDEP_IN): FORCE
>         $(Q)if [ ! -f $(FIXDEP) ]; then                                  =
       \
> -               $(MAKE) $(build)=3Dfixdep HOSTCFLAGS=3D"$(KBUILD_HOSTCFLA=
GS)";      \
> +               $(MAKE) $(build)=3Dfixdep HOSTCFLAGS=3D"$(HOSTCFLAGS)";  =
           \
>                 rm -f $(FIXDEP).o;                                       =
       \
>         fi
> -       $(Q)$(MAKE) $(build)=3Dfixdep HOSTCFLAGS=3D"$(KBUILD_HOSTCFLAGS)"
> +       $(Q)$(MAKE) $(build)=3Dfixdep HOSTCFLAGS=3D"$(HOSTCFLAGS)"
>
>
>  $(FIXDEP): $(FIXDEP_IN)
>
> --
> 2.34.1
>
