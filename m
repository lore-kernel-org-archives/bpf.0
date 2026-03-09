Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601343ACF17
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074241; cv=pass; b=QLLY/5gkVAjG8Jxbi0JdDnqvsisDok5aTmUNO3AkoqnudOVZOAe7Nlu9G6VINHEtYvnBWNDA4Vek2mB7qyhaWo7Ad377Uay3Pvn57STbPG7b/ejKRw04d/9E2NHy7/IcbuA3VDYI51x/lvn4Fz3fHyy6J/gWo/FiguaO699ZCDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074241; c=relaxed/simple;
	bh=/xVvyD0Lqn/lAfbvI9yNkpJEV7R1uzy3kwW07nfLaKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bS4Iqz9KV7kToS9RaD3rDRhG93U676uJYitW+ITHUXgPZeRjpf8R7Oy/iCAqhWwJbcMZdvBe0UpLfJ1b6Uia3yIXwwx991+llNP+kyF4ezyEGFZjlXvprscPQpOzfnpa8NztDkkscSm2STcXmmUPmQeuOaiAnoMjX521sqjvG3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yr1LTfWL; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yr1LTfWL"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae523d54d2so155275ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 09:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773074240; cv=none;
        d=google.com; s=arc-20240605;
        b=VOq/8HOKmxZv5kXBDsVuF3MZ8uY9ZRWMkCULsQtbjvznrDygv6PlqDB4dVCFgD0M84
         Ji04RRNsUdTH+tyiRRlVj6xAstWhb+6tKYIPH8b43qPYiTksEidJoXFJTDvceCAwbIyw
         tidA8iAeilF23QbwNqrqveBFhpzo2EXjDl+A2mWsTFx7T7ScUWqTamjPfEzzUpaxW5/T
         dXY4zZo6WpB8foY/hyYSvRjF+RZ7QwJjKlJo161sTyhU77s8C8HJUF/biZJJLZdP5Xhp
         O/HN94fxEJrL9Ihz30Xp5R4Bwx7jbGqEzg0sFhhcN7vlU8z6vfp7PYWQv3HKRhz+w+mb
         tODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c8Tx6Ml8LCMcseT9tf2wyQ8mZ0fxne/KMVLw9eyT1gw=;
        fh=JB/oE6kyeCkW2WKd+NtHGNOgDKFYXSuLVdYCm6r50d4=;
        b=eqJarHqwQdkKM+TKkiw/k4koLrZouHSa3UYWuG5YY+QwoBLXbd3k3v/IlQhR/hK2ml
         3gh4B4FSs/BkPlsJNF4LjozSQ4iDBorKho5Ug/wjAEWVkZafNH6BhDe4P94SVcTFaPgS
         WI+uAf4JUN4MKQkig3GCDuoDTPhUMR85qOh5dvkJL0+hhFtJPOdqhZiDyAF2l1fgmBxe
         MZacvmm1nPB7TVdOfEHUY+KPQPfsvVLffZ0zrA1Nv+p+4s5gIspagVTNpzH805LMGfv8
         3EhZGbXXwBDqe79Z4C7RtzuHzBiXB9/z4WT7fKxJXbgUEaQaeiEeTNz+KlFfPPN7gfia
         DKHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773074240; x=1773679040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8Tx6Ml8LCMcseT9tf2wyQ8mZ0fxne/KMVLw9eyT1gw=;
        b=Yr1LTfWLk6ccaQbsjiQW0i0d0CCRFWodupiTvfLJrDQM5BKKyC1JcPik9YZ3XNKs4x
         w1dLJohfjorzxddlDE8D2IZ9PyYW+MQvvWgwq5CEusXSOSgBm7NPt6CcrmhxANc9qRP0
         UMrToZX/bZWJwLyk237DVjkMX5MH5mvRiMb7IagBvFrsdyT7vpx9iBAQjFWYFRhuM1Ps
         OtcnJS+643oP8xu0MHir/DO5fAoADSw8Gdbhx/Xo57CQmn3DQF4g8FmuQEruZcHPOEfB
         xhrQfjeQAWAU3FbHiKi7VT06GdutY1T3BJFRgBWSOFR0MzUtqOupPCWekcGS/MbfS3zS
         OXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074240; x=1773679040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8Tx6Ml8LCMcseT9tf2wyQ8mZ0fxne/KMVLw9eyT1gw=;
        b=Md6nTCylv3TVbw8JIT7Ap5LjmUtCxadl1vLO449knZf6mGSLL6FnkjJuzQkAR/XQ8q
         yFiOvEAHiMhacbkCGFAp8XYP0w7ArFsYxl/8BgexzBbA/EidcJ9m61m9qeIVObzAJtP9
         ZPEdKVnEVFmLvK+0z3UD++bMhavBMZHwOWWL+vDBhRuQ5EatJveUyjOwEhczIcbGUbbH
         i+zl2FAv/2iNLT+2HDg+5HgB7eb1rvhRE3iKyqGuPmTo3QOzcnQgUnqy5LTZpUf2nIKg
         CWcQvXExKomlmaLUEtnCubitUQYeWmnKn8X57u9fHIoL/9WFqdfQwmirrfB0qxs6lbA2
         fZNw==
X-Forwarded-Encrypted: i=1; AJvYcCW5tZC2SvW+3NmpG97dK8tRtSRZRzxThKPZBEU7zHjhSb+NUFlVncREwE3S0CotTQppqyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1RYZ+BxKWXodfgVqfDQz6mFhYNfAeCKI2MZaz90WM09Mjbsd
	pbIaTFx5nIWsLbbtbh2VuCuM7RMUPDwVBcNnAUlWG6I3WCZi4XTCCYd2UX5Za1VesAWVzz8zgb9
	tqWZts60i8IuK9tM6jW5Xn4PCp/hP2rmbB81ANFgy
X-Gm-Gg: ATEYQzwlNzOzVQBzvqKPwW19HbCI4B5qKO8n6T+KHh9KGZcULouneIm7iTpgqXmDnWL
	aZ0z8oFSVReeWyAtCrxaU5mfLqps2pA7iRcGFguAMhCphhu/F3GXmI0niZF2ImIThpNa4LNVpUr
	3Db6qcZjZ9lMIeQ+2XB97ud3owi8CRuW6Z0D66JW/48HSxdaMce13q4l0VUf7GJUJ3ypdSdlJrh
	UvEN5SJujqRlTt0gnr5oxryTgvqFB49tHpV9IaOX7If+9JLGLCFh1hOUioLMyfO3FOscGIMQqja
	YwECEOG6iKc+6YVh70GiwyAUjUNVf19jYnk=
X-Received: by 2002:a17:902:cf4a:b0:2ae:4e8e:954e with SMTP id
 d9443c01a7336-2ae8b99a09fmr3540605ad.5.1773074239351; Mon, 09 Mar 2026
 09:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
 <20260308-tools_build_fix_zero_init-v3-24-6477808123b7@arm.com> <20260309114413.09e05127@gandalf.local.home>
In-Reply-To: <20260309114413.09e05127@gandalf.local.home>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 09:37:07 -0700
X-Gm-Features: AaiRm51Y_hOVZDhnwqzBMfs_foRdCHZgFLdwNP1ZXf1eU_ewkridlTQIwkfdNsE
Message-ID: <CAP-5=fU4JF6=aocKhgyZqyqm0NOKpAKEmruFj2mgBHfkqbN2yw@mail.gmail.com>
Subject: Re: [PATCH v3 24/30] tools: tracing: Append extra cflags
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
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
	Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:44=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Sun, 08 Mar 2026 16:46:29 +0000
> Leo Yan <leo.yan@arm.com> wrote:
>
> > Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied t=
o
> > the compiler.
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Not a problem with the change but running this patch through an AI
agent brought up:

  Should CFLAGS be initialized with default optimization and warning flags
  (e.g., -g -O2 -Wall)?

  Currently, latency-collector is built without these standard compilation
  flags because they are missing from the Makefile. In other commits in thi=
s
  series (like for libbpf and thermal), CFLAGS was explicitly initialized t=
o
 -g -O2 or -g -Wall when EXTRA_CFLAGS is not set.

  Additionally, should EXTRA_WARNINGS (provided by
  tools/scripts/Makefile.include) be appended to CFLAGS here, similar to
  how it is done for other tools?

Thanks,
Ian
