Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33243D7D97
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069029; cv=pass; b=DxfX2SmwRSQ+80L1qEJyi0iDlH747j4tYgid1tbS8r8wWlFT69N28W3eOxo1ZzKxyzVFHY785/CFp43H/tytrricUk3QZg5Prrl6seu8pnNzr5Dsx5I6zwTeYh6tfC0S2eIOq2w22om2ba08GdzdP7aDWl6ktIjwX3E5/cointw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069029; c=relaxed/simple;
	bh=5i8qPmQzszVgv/IzZW6/JLkFuKhxnzZQEpxh8nw5jy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHir7+51Icor7V1p6ftTYIYX+q7uFbLpQTUuD3MFHoKJCmDlJSUai2Apaz02QvkKNYCELngf4MEELhiQeQUqYJMPPfV0M8Xy4fXVMJwH+Hr2d987DI57OFbGvY2J+93PNJrSfpk30pQO2EzmarAf2aMqb0mnXhEIXWrECHCsFnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v4xaBXqp; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4xaBXqp"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae3f822163so149235ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 08:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773069025; cv=none;
        d=google.com; s=arc-20240605;
        b=G6cHwsvAv3KZi/K9KgeU5f9V9XpFOqKAnYFOuS93uY/3v0Grr4+CdOS58DOuxWhvkE
         pyylWEo+lioboMBB28VaXQdw5+Jdzb8iOEJePMVEhYdvIMCYQflJIVGu9lKNK13Buytv
         ujHMrsqJgB0uLUao4RXQiw7c4l3AWYbHnlM6zIWv79lZfV3Fp3QIw8uqvuFFGLH0tAXt
         abC0MuMktY1eaqyWh2GSGJrqwpLWWetiv2KPQk1FcbUbYEP5iQGzq7WJ3BDxHj0sDqwQ
         9rrHkJOqYyz+1IgHFhmWDvpdRCcUnTFhklxjgCxzy8g63C4W1koKzMXpkgQMHOhHXUzi
         JNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6FbR4+wo96W1dWPj028FNCvwM/SPgWjQY/Nh61K7Dcw=;
        fh=XC+kl10271RZQlyUT6x+luMOByzPrzwLc8L+b7G0T4Q=;
        b=dfBFGmfjnifD2GlN7SvmmL3rqTM/58Wcpb21HJ9Ry9Ip39oGlL7iyiI0a2cPyIQIa9
         PGuVY5Yn5rJS2PkVOVw8/y55ak8r81Sw6Ish/HGgnPhXnxujspcv4dXX9VyX+GMxUvQk
         HuWY0J5v7ml+W9nNceRnhMHh4D51sn3IoNqZb+0LCqeVd/H370QJLh4Ne1xaOZwcZEGp
         oeW0FwE8ptdoV+eieG1AMzu8q3c6MwMR6h2XzxjMjQet1XldhZJnoSSwG2bcpp4YY/RY
         u/CwHLNjitvHM79ffrVXhXbdhW0cL6/r4nwAyNJVMPzz61k9jSwfL2f+ExZ9Ag0nQ7Xx
         sUpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773069025; x=1773673825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FbR4+wo96W1dWPj028FNCvwM/SPgWjQY/Nh61K7Dcw=;
        b=v4xaBXqpIuT0bcg9isx0DX3xggBhIWuO0XIcHogy6/uqvk8alDDzE93ExeqxdD3Sfw
         LCsZzFCDhtusjba0bkIhwHbSNGnhQUO6vu3DNZh87taQZRfn9+D+Elpv+Ynf2hYyADuz
         VDxp+QEGAuKbb1r5F172LIHP5d2NAt2N3iblcYpHCIlv1eElakEj/77cV9F2s1FaMMzG
         Xz6mCsiAU8By3/xu9Aslk2tRWeI2Su3wnNde9NrXGaY5wBmyNF+gq6vH5G2+UBxbbxAh
         kuhAtfvIecAhpClqOUsl6E+B7CyePTnCR/uGfYsdWerlfkA7OygbIp5yFuPn9eLdjs+j
         wRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069025; x=1773673825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6FbR4+wo96W1dWPj028FNCvwM/SPgWjQY/Nh61K7Dcw=;
        b=H2XMYhQti9AD/zKa4M5WwB94Na6zSNTftyZ0mpdqwqZpRpVm7AwDaqurpol/5IpvHW
         Z7ervEpqR4IZmO6gcjQsxCbwlfqQwVfhS4MeX+JY3JlW+3HW1qxa3IGPAw0Oiv17+TnA
         H8N/ZJkugsVo3uOp6dnRj7gJdWDTeq8Oxq72lm/tqz6fwVcQhzW8oJuud1jM+3IBWscQ
         5X0hcVxkxxjb5+MFWQSUUsvKmSlIrEBt9FV24jQFAL7btDw81vlVlfrS89G7ojk28OnB
         ZAKCCcQozaGx8kpmL3s8A9aSCyJmRTk0MqGai3duYrK4CwvhumoDRHRNmh3BWy6V23j7
         wzwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX92UuZLGxbx/xB8Rh5TUUP9GI2fwX+0IZ+etFEFWLPT6dwBRuLNN7u6uxMXK3Wp3ebAu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU85H9Hkr1HvlcCL1g7gJzyE8/JkDIKLgzkhBzR0I1NcCqoY4w
	leyU4JgBEHXfeWT+23dZ3dGM3IMBEpMcJcn5X5KY65jfE9JIU883HO9JUbtkf4ibcEDzFHoUSfk
	RZY+EKzEtxJPwcA4l/fRNhC+elVhB5DKQmQxkyEFZ
X-Gm-Gg: ATEYQzz6BUrnJ8K9t593ZUph5MeIMsP4Mg8Pe2zv8qiGtxl/UEiCdZRnf8g3BFkuHGq
	MGpwOutl/C9CIxpOtz4Qx3TcehZlJKkDrWisJDIvtvWYSbOX93fvB4mUFU1XFDbN0+1kvpc7H+T
	uZe4IwDwgIW7tMhG8lyMi1nIguCkLTD5DCitGAPJGyFY7aHpHFku2ADJlZT1WUkZqIOm73dduao
	atF/xRe8/YdeLlYbm4C+eOmLl/VpEinnFUc1ZIdpAPpkt2M7YzFT3TbRJLSyGnniCpCLHMHaAlV
	FRwc3U8JV8mChKTR9bo3Y1Ia7Wc+B4VVJmHwxg==
X-Received: by 2002:a17:903:1a23:b0:2a7:6c4e:5914 with SMTP id
 d9443c01a7336-2ae8ad1c62emr4122395ad.6.1773069024342; Mon, 09 Mar 2026
 08:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-3-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-3-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 08:10:13 -0700
X-Gm-Features: AaiRm53Q6tq8LuPIrmfsSi3or0ZsIgIF5Wzq_daN-fddH5XU6fwZ-9Q1_o7c91A
Message-ID: <CAP-5=fUjJ1QONNLNyJL7Ugc3=44sJ2i10wpQNoGtM7Fnd5wJ0g@mail.gmail.com>
Subject: Re: [PATCH v3 03/30] tools: lib: thermal: Initialize CFLAGS before
 including Makefile.include
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

On Sun, Mar 8, 2026 at 9:46=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Initialize CFLAGS to the default value before including
> tools/scripts/Makefile.include.
>
> Defer appending EXTRA_CFLAGS to CFLAGS until after including
> Makefile.include, as it may extend EXTRA_CFLAGS in the future.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/lib/thermal/Makefile | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
> index 41aa7a324ff4d76351b89d7d7cf382df3fc14052..50efa97163fc089455161d6b8=
1db13aa0ae41af6 100644
> --- a/tools/lib/thermal/Makefile
> +++ b/tools/lib/thermal/Makefile
> @@ -23,6 +23,14 @@ INSTALL =3D install
>  DESTDIR ?=3D
>  DESTDIR_SQ =3D '$(subst ','\'',$(DESTDIR))'
>
> +# Defer assigning EXTRA_CFLAGS to CFLAGS until after including
> +# tools/scripts/Makefile.include, as it may add flags to EXTRA_CFLAGS.
> +ifdef EXTRA_CFLAGS
> +  CFLAGS :=3D
> +else
> +  CFLAGS :=3D -g -Wall
> +endif
> +
>  include $(srctree)/tools/scripts/Makefile.include
>  include $(srctree)/tools/scripts/Makefile.arch
>
> @@ -39,13 +47,6 @@ libdir =3D $(prefix)/$(libdir_relative)
>  libdir_SQ =3D $(subst ','\'',$(libdir))
>  libdir_relative_SQ =3D $(subst ','\'',$(libdir_relative))
>
> -# Set compile option CFLAGS
> -ifdef EXTRA_CFLAGS
> -  CFLAGS :=3D $(EXTRA_CFLAGS)
> -else
> -  CFLAGS :=3D -g -Wall
> -endif
> -
>  NL3_CFLAGS =3D $(shell pkg-config --cflags libnl-3.0 2>/dev/null)
>  ifeq ($(NL3_CFLAGS),)
>  NL3_CFLAGS =3D -I/usr/include/libnl3
> @@ -60,6 +61,7 @@ INCLUDES =3D \
>  -I$(srctree)/tools/include/uapi
>
>  # Append required CFLAGS
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D $(EXTRA_WARNINGS)
>  override CFLAGS +=3D -Werror -Wall
>  override CFLAGS +=3D -fPIC

The change lgtm. Running this patch through an AI review showed that
what looks like a typo, CFLAGS becoming CFGLAS, is located below:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/lib/thermal/Makefile#n62
```
# Append required CFLAGS
override CFLAGS +=3D $(EXTRA_WARNINGS)
override CFLAGS +=3D -Werror -Wall
override CFLAGS +=3D -fPIC
override CFLAGS +=3D $(NL3_CFLAGS)
override CFLAGS +=3D $(INCLUDES)
override CFLAGS +=3D -fvisibility=3Dhidden
override CFGLAS +=3D -Wl,-L.
override CFGLAS +=3D -Wl,-lthermal
```

Thanks,
Ian

> --
> 2.34.1
>
