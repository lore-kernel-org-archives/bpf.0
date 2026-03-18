Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE5B3FB070
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851939; cv=pass; b=uDoW+DKojsH+51cVKgl46prmtouXbbadz4Z1SDvxf7is8FaJJ2boOBtu7RGO4FYDRDuv8T7FrtjbJ8jbP9/ofIQ39WjN4wLTEsx2VcwcfjbRU+AN4yGeh4aaB9sC4m1YDcikIDHE4tihfIsEjMW5WOEx4CerJe9BAIYTKYhGjDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851939; c=relaxed/simple;
	bh=pQRo/AIDHbWYmQiKbzY1fu0YoqvFJr3p4qbPZJOQBWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVz5TO6f06SXxztC+M/86hibzEsDhAVvx/cO6Wk1887iLZz2NmVSL2WfEuCiJ4dZgbTDxBMiV3eylSBc47ayaubumEt6Lc+qo7VqYZsPGZYxMPuepRi1uIDkeyxzRA+GmsoU2k9+sfWH3U5fzgeZ7+FhBDqulrmiWxwf14bXICU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sXoQMXd5; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXoQMXd5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b052ec7176so94935ad.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 09:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773851936; cv=none;
        d=google.com; s=arc-20240605;
        b=R/vpFZcdb61mJvjwO68qA+Io8sBBgfy9Pt608aPLU7oWvnLLM50GO+iI2m0nOwHxXV
         5upFPJxNCUBOWKo9zn6eotlt4BSz3Af+U8uTyvuO8Oce3niDyIIZ9wC53hhO9NzfWHV6
         +ZgSvaM6uRukzJmcWsHMjkoJe/hyLXnzmwhHePbs20PAHkoQBL95jBd3u8cGvZUt9hnl
         6Gv/nJqXjZawQz8bGhUsp0QJVjdESNYoSUhLuN0hqE12UakO8+pkz5/xRInyqlJ68vpw
         ZmcRCbjm9N7Dkn7G1QgPWc5dKd6O+l4AxNJMPF6nYQV957Du+W8bo0Nxo/TTZCQypo2h
         pqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hcjCxyCQZIThfXRlEgtWrMDq+8GZ2+bJDcg2rHRM0J0=;
        fh=6+HA8yj5kUs9vquQM5JClwTCm1HBC5FkxEKC6yh7JbM=;
        b=VwmIg6o33095kUDZnSrw81GaHJOUi2+Ajjmc8frtzlQ+ZI7mhNLHj0N1Zj6bOFWQYI
         qGw3kRVgYHFGlRdcNz2Gl/XZLwsL3GGt8Uvf8w6LQ2ZRD6ERMm2dj84sLr7ixhMjwQAK
         8OvynI2iY0ak4jHQbr248W9vpP7RdwdpxlQCLmnj0XUfLWgAwXGaKmkOAA5YrPK6Itu2
         OD5wW+3elwhlpL5hfh8OL2oUrFsUj177s9BDmpjNvFS+De7qfoL4jx2HqzwBcy85THAA
         gzMhYFca0DO0bUtbqRR0CulmcNBxrE8T6Wo1qVxrzSoXH9kEFlEm23mUqmmg/5ojVF5R
         ZkLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773851936; x=1774456736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcjCxyCQZIThfXRlEgtWrMDq+8GZ2+bJDcg2rHRM0J0=;
        b=sXoQMXd5ZK4ltkomyXip5wfycxB848TA6ndxmvZnfnfoLg0w56TKga3hCE+XmdIpZh
         FiBQln4YgfTJQv+KbxpSj5SGwcJVU9hyK6Vc5HGZeCnYkGu2bBJ9E57e/lB4Au5xXkvs
         knPpw6PcA0xCJ5lJ5wD7EhV57f6HNmz6+Dhyb6C2EieysCmF5ymXG3n/sldNGEzmXn4g
         9SyqPr7w6c3+sxEDBH4+HtJXfk/eQ7hIRNc8Y44m1TZw1Uj+JcekXy139NwDrKYvkrJi
         l9jrm45RauBkDS+4gFQwLJ6BcNOUfpHo6zY4m1llx7bwPK4Za3xxdKr76Qc8S9xntF/q
         LwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851936; x=1774456736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hcjCxyCQZIThfXRlEgtWrMDq+8GZ2+bJDcg2rHRM0J0=;
        b=D0X/UjDx7zaZjbtJvkIysg04IItEYpkpYUpJQNvkeoC03aPZrPgdRqsOkjf4bdqVDd
         dH+oUelb3YSDxguS/9Awco2MZPbhONAoX8hqzw5L1/2JoR1r+9MWkltXnsS5Un2bv81R
         Y1PpUz+UfNxxPT/ysHrh9bgvGDk+e4lucfyookO6cO2LF34PaJM0OkWQ9iA/hZhBijGm
         r1ygc2wnZSaIDmBxJN8gJn4Ay1vUJILPpkgn+ZzCLOtfzBRvBTVrcupu26+VW+otP0/X
         CQhbo9oBa+Rg1b5ruK8wZXk4pWJzRGa/XO8oy7sWmQvjfKNZ91NlxAIjLCsDSlNHHIsq
         rAhA==
X-Forwarded-Encrypted: i=1; AJvYcCXWifY6Nj9ZuDR2bHuoOYqpE/CVQTzV4qFJwR+SpkBD99CTAOdbG2tz1rsZl3guaH9PIzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKoGRgZ/gtx0mF4TzIFKwW7gDaDSBncHLiqdtAXzvAbmQTBSAE
	JqhM/ZDevtq0Kez1XWTjR11KSwm2Fa1trp6E1UOnmYIGrQZVHizYMrnI5As6QCVChFeak2gCvKK
	q4y/vkr2SKu19dhYNNr++7GOGuQeye5qqI8skjA/C
X-Gm-Gg: ATEYQzzvzOkO+zZy656XLUJPRbnrH23EiUgKJIUVDdkg6d2WT6V/ER/XTDJtcH4NhAh
	GHsFrg2JxytVi37bT5ONUr5SCdYSWWfyQoqlQHYimuqOF8qHwIjlWyisSbFAg5OHhApPVh+Eh/O
	C7GdZLmixpFqcPpao2uMKbL2+Pj3T5+dZlkoD8yh/xKMSv0IpS4nGd7vUn1Ke6Gt94OWWc6BdIc
	a6kMLZPREeeHMQsSrY07YyYyNutBqMHJZaaZYUdVT5EgrnlE8o4yONEkqBu6/EtWirCmMYKDA6E
	BaMxRiEF
X-Received: by 2002:a17:903:22c7:b0:2ae:c566:bd99 with SMTP id
 d9443c01a7336-2b06e88a5f7mr4276635ad.22.1773851935141; Wed, 18 Mar 2026
 09:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-tools_build_fix_zero_init-v5-0-bbeffd8da199@arm.com> <20260318-tools_build_fix_zero_init-v5-6-bbeffd8da199@arm.com>
In-Reply-To: <20260318-tools_build_fix_zero_init-v5-6-bbeffd8da199@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Mar 2026 09:38:43 -0700
X-Gm-Features: AaiRm50hpzLMMjzX6OI5eZpFyBk6BPkQvLc7onrrMNrR4VNp8m3oc-g1ki8itfQ
Message-ID: <CAP-5=fV_ObgCokJ3bKAQBYn-DPrGadGVzqvrzbuy8aEcsfkp8w@mail.gmail.com>
Subject: Re: [PATCH v5 06/26] tools build: Append -fzero-init-padding-bits=all
 to extra cflags
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

On Wed, Mar 18, 2026 at 2:18=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> GCC-15 release claims [1]:
>
>   {0} initializer in C or C++ for unions no longer guarantees clearing
>   of the whole union (except for static storage duration initialization),
>   it just initializes the first union member to zero. If initialization
>   of the whole union including padding bits is desirable, use {} (valid
>   in C23 or C++) or use -fzero-init-padding-bits=3Dunions option to
>   restore old GCC behavior.
>
> As a result, this new behaviour might cause unexpected data when we
> initialize a union with using the '{ 0 }' initializer.
>
> Since commit dce4aab8441d ("kbuild: Use -fzero-init-padding-bits=3Dall"),
> the kernel has enabled -fzero-init-padding-bits=3Dall to zero padding bit=
s
> in unions and structures.  This commit applies the same option for tools
> building.
>
> The option is not supported by any version older than GCC 15, nor is it
> supported by LLVM.  This patch adds the cc-option and host-cc-option
> functions to dynamically detect compiler option and append it to the
> EXTRA_CFLAGS and HOST_EXTRACFLAGS respectively.
>
> [1] https://gcc.gnu.org/gcc-15/changes.html
>
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/scripts/Makefile.include | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index b5ecf137febcae59f506e107a7f2e2ad72f4bef4..a2397ceae512c1bc54adb15cb=
1a111ff34e28e43 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -137,6 +137,36 @@ else
>  EXTRA_WARNINGS +=3D -Wshadow
>  endif
>
> +# output directory for tests below
> +TMPOUT =3D .tmp_$$$$
> +
> +# try-run
> +# Usage: option =3D $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwi=
se)
> +# Exit code chooses option. "$$TMP" serves as a temporary file and is
> +# automatically cleaned up.
> +try-run =3D $(shell set -e;              \
> +       TMP=3D$(TMPOUT)/tmp;              \
> +       trap "rm -rf $(TMPOUT)" EXIT;   \
> +       mkdir -p $(TMPOUT);             \
> +       if ($(1)) >/dev/null 2>&1;      \
> +       then echo "$(2)";               \
> +       else echo "$(3)";               \
> +       fi)
> +
> +# cc-option
> +# Usage: CFLAGS +=3D $(call cc-option,-march=3Dwinchip-c6,-march=3Di586)
> +cc-option =3D $(call try-run, \
> +       $(CC) -Werror $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
> +
> +host-cc-option =3D $(call try-run, \
> +       $(HOSTCC) -Werror $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
> +
> +# Explicitly clear padding bits with the initializer '{ 0 }'
> +FLAG_ZERO_INIT :=3D $(call cc-option,-fzero-init-padding-bits=3Dall)
> +override EXTRA_CFLAGS +=3D $(FLAG_ZERO_INIT)

Sashiko [1] noted a possibly unintended consequence of this change for libb=
pf:

Does this override unintentionally drop the default compiler flags for libb=
pf?

Looking at tools/lib/bpf/Makefile, the default compiler flags like -g and -=
O2
are only applied if EXTRA_CFLAGS is undefined:

tools/lib/bpf/Makefile:
ifndef EXTRA_CFLAGS
EXTRA_CFLAGS :=3D -g -O2
endif

Since tools/scripts/Makefile.include unconditionally appends to EXTRA_CFLAG=
S
here, the variable will be defined before tools/lib/bpf/Makefile evaluates =
it.

This causes libbpf to silently drop the default -g and -O2 flags.

While later commits in this series fix this exact issue for
tools/lib/thermal/Makefile, it appears tools/lib/bpf/Makefile was missed.

Thanks,
Ian

[1] https://sashiko.dev/#/patchset/20260318-tools_build_fix_zero_init-v5-0-=
bbeffd8da199%40arm.com

> +HOST_FLAG_ZERO_INIT :=3D $(call host-cc-option,-fzero-init-padding-bits=
=3Dall)
> +override HOST_EXTRACFLAGS +=3D $(HOST_FLAG_ZERO_INIT)
> +
>  ifneq ($(findstring $(MAKEFLAGS), w),w)
>  PRINT_DIR =3D --no-print-directory
>  else
>
> --
> 2.34.1
>
