Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD03F23BF
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336302; cv=pass; b=QyBNGo2Tf0r3TI5AJQSKXu39U4ZVqPud8UyIV/023JUJVR4hZKhxgT6Hngc5X7ZvJTTLXg/tk3wUNrM0sv+C6qpUmnG/QqgW25PfqOw4GJYstYxWI6g8b9h26V9jL2+3uBeVJxBWhPgvZQK3vbktQhJUAi73TqxAlJLFpzQaeAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336302; c=relaxed/simple;
	bh=EUnbf8s9gG6GzSdAsBxHv68nHvfQl+MlAZdHKrNHid0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uhf5xjusaDcrUJnZ1Y/Lu8hHUZDiHDg0fm1QI5wTEajTBRYLj3AJfiChR4x2/N63XJQ7nEPwDjAi4N/b0zPTWbJqJg9/LWXGD5c5Bm0O2QFdYKHUPvBB9LNmRWWaj6F9Sb7Q9vb2PmZr2pVieze/YNjQ90fR/QTj5nFvN63nmio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bELKPogI; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bELKPogI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aea4ebb048so6435ad.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 10:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773336301; cv=none;
        d=google.com; s=arc-20240605;
        b=M8SeJbLSyVKwBQ/keY9HE/L4qcMEg/P9dw72tG8Tal7as/P6hi6NfRK5So8tBFNqfM
         XXC/z5j/SVZTworFYKI6jDC0L0OXmovZE/eUedWmvWD7+99Tov5BTAweEYCdxEzn/TWP
         DWxQJU+CgtXwA1miEB3viVCGgQ1krc9lKBI0+1Vpy4cyRZqkE5GjWuM2GL/qUDIHZnoY
         y6j7Dyej975CtUgOaJnyYGLJQBtKE/Zo4xfCcEkbkyOlz7fJE8frI1aM8afxiPQkruZd
         w9HKXbOjwiiTdiSm8ZquP+l3Sz/EluHkKBSceDHSgm0mWXAFuwahMIBnLhVWNJ3bw0Nb
         CXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wt8HMORomTHlz2fasa3fWuq19mlRWO2w6YTeCuKKCWs=;
        fh=x58SdNTgEsm7i1OVccadJo6YRdJBM4FVaIsPqetdae0=;
        b=CJ1/ZjJh3tjrfrMuc2I/jOPjeGBnoJ0CdH39gzTZKINpzmbvMtVK3dafu65tEde/VP
         /Z1bSD3VjhuhEDrNkSSyJ+NRLnKLCLvr/3dDRIIugLv9hg/47hzAadmClfhzSirtI2CV
         Yu12QtZUzrOpu15nOwQr7zYqmrwLITQ5fXNpKQSqvHD2e7OjIn3P2/IFAHHF7hRDrgCY
         Cv7cg1gci7uoVl6GyX8Xwc2b4GeyVCAt23Q3urMPvDtKTaq6CCp1Sh4hiT8ApUvNeaJN
         KB7aZCZOBsgyrhyZBzX5jP1W7izTni81CzSiWNelF5cfDD7mkWVBQz3iDQ0RSZ7R7LpQ
         k5+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773336301; x=1773941101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wt8HMORomTHlz2fasa3fWuq19mlRWO2w6YTeCuKKCWs=;
        b=bELKPogI1VbJZeOVCHgatH1LwHeOPW6HEc0KJBcuTUSyJ7xNcVflABOATxzwqT9itg
         sCxkES2nQ/ZjKyhE57cSsqMRHeLfjJFp9x65OiMB1NYQpYeU11heHmGi7llW6ZJ4N6v/
         EfzZeTtSz788v9OLoazsWb2SkgGspVUXAtcqlsw2fVwhyGW9UArrcmafCa5F04sHuWhw
         RELdlUA6JLL6Qe5pqCnUylrYt61qrrkcIVjMa2iQsVcrP1D67vfqGvui/kK++q+iOzt+
         8B2/bTEK49kQTOcWfy/QKPqbEuHSB4+0cQeAL3O+lrl1osuKRpEebJBUm7Ne+u5vMJji
         CIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773336301; x=1773941101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wt8HMORomTHlz2fasa3fWuq19mlRWO2w6YTeCuKKCWs=;
        b=d5NMxTLcV45rzpQ2OBtgtz9HpWh2834IV3KKAwgKvBc0ySpjnEizbQargHdvM03Qn7
         3EI1Yp4hIZIeXlzByI/SdMgj3OzoNI4RgzKXazBl6Y/drUIG0kXxwU+QOCOILLYG84V8
         SPjkYTkTVQe0lpoJhR75hl70IoFv1mw41JR3g/GHKYCREuORIdKZYmbTwFBTeLr1/SON
         N8KG/feB/rnqqjN5X8cxSUT44J+KrBYLbOYtfisGQZtnxy7SdU8AsRKgQ2Kr8ccIi5Js
         5pAggFe0DSSvX9G+Ei89IAvnwcHLp9sJyU7TImoMFrDLzJIUqFlrjYrowEc/xO43iczk
         wa0w==
X-Forwarded-Encrypted: i=1; AJvYcCWq58ld6zEpVedX/RDP6iArEanaOABe1VirgdnFWrWtmXOH6ZQPMFR3oTd2nbmfrwGX3V8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/lnsIGnpAqpEGp/UXL4cfBHFeKUpOesY+qdtkrEgyeo2O16cx
	UUpzFAqTcepJo2v12ny6od0jR5o6pTF9/9TWCkzZ/Jr3PRbLAvrN6GuUe/ItfAXGT+14wUlrBS5
	Llw/sNjFDaneF28n2eCt0gdXzRnypZSHvq9E3go9O
X-Gm-Gg: ATEYQzw0yoP6LnIvhnT08D5PF7t2hLpPNjC6eFKkjkyoxjvif/FKCwMPIy/fLSyPwV7
	zwiIyOaZ0o/hqxbzsuFTjTTpN9iFkSygt+eO9+kJlByNHzd0XMC9jMGaEgxtGYKJqlF9WfpfNYr
	VFJ4c9jluWBs/YZmyYcteEkAai6TpB3QfaIaAdjK2rZ+Q/FC3+dDGC1cAaV52LbHOB877Pj1WDU
	1HKtMEYfqV4/xD0+fnQYrtitzUT19rOGqI1z9Q5p5YbYzO53kIxrXNuvTR8OO9JezuNSIa6q1CN
	f9Sog5SpbruRGNGAHLgJmw/mgKKktYkZSWSP
X-Received: by 2002:a17:903:94d:b0:2ae:ca87:b1c2 with SMTP id
 d9443c01a7336-2aecb4968d3mr115665ad.8.1773336299917; Thu, 12 Mar 2026
 10:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com> <20260311-tools_build_fix_zero_init-v4-27-9e35bdb99cb3@arm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-27-9e35bdb99cb3@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Mar 2026 10:24:48 -0700
X-Gm-Features: AaiRm52hQTw51elOXRvyPkEpjj1HAq438fXBgq5QDvtll0HOsb4gHaSDYi-74S0
Message-ID: <CAP-5=fXjd15e5YpCM9KMjEhpjLxvxc6qUk0g7BprCfkzcRZ5_g@mail.gmail.com>
Subject: Re: [PATCH v4 27/30] selftests/bpf: Append extra cflags
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

On Wed, Mar 11, 2026 at 1:33=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>
> urandom_read is built with clang.  Introduce URANDOM_READ_CFLAGS to copy
> the compiler flags without appending EXTRA_CFLAGS, which may contain
> incompatible options with clang.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 72a9ba41f95ebb825d25799c07ba3f0311243e45..27112f08c9a5b6cabc4190220=
7d00897070b41b4 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -71,6 +71,12 @@ ifneq ($(LLVM),)
>  CFLAGS +=3D -Wno-unused-command-line-argument
>  endif
>
> +# urandom_read is built with clang. Copy $(CFLAGS) before EXTRA_CFLAGS a=
re
> +# appended so that it does not inherit potentially incompatible options.
> +URANDOM_READ_CFLAGS :=3D $(CFLAGS)

Later in the Makefile, include ../lib.mk is executed and it appends
CFLAGS like -D_GNU_SOURCE=3D which will be missing from
URANDOM_READ_CFLAGS here. Perhaps move these assignments below the
include?

Thanks,
Ian

> +
> +CFLAGS +=3D $(EXTRA_CFLAGS)
> +
>  # Check whether bpf cpu=3Dv4 is supported or not by clang
>  ifneq ($(shell $(CLANG) --target=3Dbpf -mcpu=3Dhelp 2>&1 | grep 'v4'),)
>  CLANG_CPUV4 :=3D 1
> @@ -255,7 +261,7 @@ endif
>  $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c li=
burandom_read.map
>         $(call msg,LIB,,$@)
>         $(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
> -                    $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
> +                    $(filter-out -static,$(URANDOM_READ_CFLAGS) $(LDFLAG=
S)) \
>                      $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
>                      -Wno-unused-command-line-argument \
>                      -fuse-ld=3D$(LLD) -Wl,-znoseparate-code -Wl,--build-=
id=3Dsha1 \
> @@ -265,7 +271,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c ura=
ndom_read_lib2.c liburandom
>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/libu=
random_read.so
>         $(call msg,BINARY,,$@)
>         $(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
> -                    $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter =
%.c,$^) \
> +                    $(filter-out -static,$(URANDOM_READ_CFLAGS) $(LDFLAG=
S)) $(filter %.c,$^) \
>                      -Wno-unused-command-line-argument \
>                      -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(O=
UTPUT) \
>                      -fuse-ld=3D$(LLD) -Wl,-znoseparate-code -Wl,--build-=
id=3Dsha1 \
>
> --
> 2.34.1
>
