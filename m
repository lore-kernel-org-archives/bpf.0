Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5883D3DA7E6
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076649; cv=pass; b=D/Oe6xCQdDVOLbFs7Pd83USgbt/YQAGpFHjXddTtR/bF7m4fMBz9cQfBSq5f0SE8O1oKDDElGOjKI3EBVd2JFB0y03qdMuE+7GjofvXSJA9t797F5DDiiwrTXMRw29YqIonn1Tc3eJyaCDlcm5o8gqbse/6dnXajXDfhSFLmS+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076649; c=relaxed/simple;
	bh=KlVS4uimnGg2P9OAHjWKxIKUvpjpakW2vhNGGc1Iif4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7vlzn+nVWRFR8nZ1W2y+AtUv3AXof5jVPd6ylvqWICzVxtvdVPnphSiqgr43Xi1Uy4lQw4IQfGRcr7aBk3Eg9FzbUG4OVJggl3tqhKaQwyNgMNnyEOTVElSgThr0h7KLLRIA7IJh3o5ePRLMgYnubH99ylxS9tJ3vtoHDoVVRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DtyLz6Xk; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtyLz6Xk"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae49120e97so10405ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773076647; cv=none;
        d=google.com; s=arc-20240605;
        b=XmfCKUFmcdcKEGAjJ3Hp/BvsWB/sN7wr0visVIOVylojgrLo5wDvHckzlfnTjz0tTU
         WyNPgKGizdk/Md4f9KdvXFRulDhso4sWAB/v8S2P5sQh7ddFklpcL8ppc9tVDAW+JP+a
         7qTjGagn4EQIzlbj0LaLt3Ba9uMT89pfkLh/UXPOHWxU0FdaYziJAMlJHQQEvc3M+UMB
         VHE5dL5tfcA7MV+FgUsuiBrBHDtIi/oSqIfCMOHwjN1eKunIA+W8Lc0Lb7i/vfPJdT19
         zn9LSiwyrVe8LLQdFkJbJOv+aQpp7untO/bBg45VM6GY/aiKaj8+oMT780DiEQivFivI
         GZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w45p66NfPrqrjiogvGBWv0oHv9O2Jx2o1hhM+o6/k7c=;
        fh=hX6XYltK8sJOc7c2iN2Zf/smoHs+KDcUzVibYeJ3WGM=;
        b=E8G/1rKrFsZhQKujcTWfBB1BXr5ixl+iyCrbdQkhRN8HLv2JoOF63u5nhR9Y4pr3T2
         HvzazhPQ8mg+KogbXY9PGBoEeifspr0LnRgyg/Rs+EYxEinCE2toD/N9B44sf14YQoYN
         ttMRc+xXcfOvI7iECOABYeh4us+m1ILLgdbLo1DUZFGvQBaEc94uSola4zwD20vzK4nU
         qvGy4iYoK29sdiBfVV2gubZKrg3SIoDbDpnw9rTQv1BAIqFIKulJq6uOhvo6UndMhx7g
         nVt/RyjleoHYSyxKvreh9TNeqRwQ7+BY9obU4U+sf/v8yAoMYeSsCeXu/7imW1B/4pv0
         9Rkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773076647; x=1773681447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w45p66NfPrqrjiogvGBWv0oHv9O2Jx2o1hhM+o6/k7c=;
        b=DtyLz6XkzIZX72KCcwdnzd0cgJZN8c3WRVxl7zo8S+uvNHsUyYLY80oZHy9ZMdhMOm
         dWwieRIJKSYesLiAN8AUZmKeXJvVsUBmx1EZRRQwHr5P8d+dSfsQbOCPiSIcEHe4prAS
         9H1aWRTCUgumLGy5hhUKgzVwptje4ptmK6y+ECi8Mz9l37WHLOjZs2Us/j58tJKzl+hf
         xzwysuIEcUjtYnqlv2pvRWjA3kDlnWgZsg6RZUMdhZyZ7UNhpjLo8x3sJapuwtZNx6X6
         q2D52zpfTLE+iCcL1vXlIyyp2WAJU+eJzXNkTB+jV4t6ICYoeIBTEkEvD2Edvi5gnVdF
         avMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076647; x=1773681447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w45p66NfPrqrjiogvGBWv0oHv9O2Jx2o1hhM+o6/k7c=;
        b=taGnrwzReDU73jJyiSp3qQKLus9oH4c0ne+2+GLlKiVXD8QQxJkTaVgS63Lxwv6W2w
         4ZZcfwz+98/Y+YyL+Kq807Dn13lYGHE45wkbcR4DrDZjODUaYuVrwDJpNGpbN7kdNHV2
         AfJwA5rSBAFzeRiRdHA14X5eZN8W55NeZM6N9NsrwQHbY7xvvM6A1nKgqv6gKC+V7u2E
         b8px4rLyfp06ka5CyIbGrMkfZlZwvcJE10JQn6gq302JaPp6SqT+skGpLE1gALICyfMI
         DplQP7UuTMKxZWR8tLz/ns7PlCUeT2IBMbZaVx6AWZ9rMaMEHtaYMYJsVrlbMlcJS6tD
         qgWg==
X-Forwarded-Encrypted: i=1; AJvYcCVRLJuVTubVl9X7Zvh95GaNIsfghQSvo3GbrdLxaS5wGqZfx1sQHYu7H6OuZrXuUrV9eqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSqHRy2x4tRFvPSVB07i01TK1afC4S8qKxlHZXInvtI3LPCBFg
	17TQaunC2mFaM8tzCqg4FVfXhG8mSqJQBK4d6KO180GRaa7je8IZ23IjVYrvZdk34tAmF4Pjt+e
	hMeWVNlNPM48H1aRussgLtT02DNV063Y29H+n9/e4
X-Gm-Gg: ATEYQzwr/SToCJc/MeJDjoM28PxqnTTEBpqxXwtKKf20UVAZ0WvIZWLYq8SMWo/w989
	nr8MS8S8zTnWiQXdZr4o9RM53rxp5I1tqsq0tFeAXDyDuGv+3HvzQDM7lrKu4yrVDUx61qtf9fp
	SRGrQswM7jtxyM0tDHBnSYVwC+UGSnQj8KoxmnfrbVpfInIiXSzN83kkUSos3wtyCG1ACRY3VHb
	e4TVykCrbzh8WH+Zp9JBfB3+TZOhW6cFARMytxxKK1A4TeOKJfxn47X2bgeSfhu+6cg+GajK9Ne
	wJ0bRKKb4V/UE8n7Vw4xrJFfTRQONvwlMwMiWOoJpm3/lw==
X-Received: by 2002:a17:903:2345:b0:2ae:4e8e:954e with SMTP id
 d9443c01a7336-2aea3247986mr23025ad.5.1773076645917; Mon, 09 Mar 2026 10:17:25
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-5-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-5-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:17:13 -0700
X-Gm-Features: AaiRm50U-PXwLYjmiDwgX5D5-bqDn4azdaS0klGDRU3-QqWA5WlM1eBYcGFDKIM
Message-ID: <CAP-5=fV5jFCyyywddBmijiedcVLKz+LReU=NPkUOcanjJ5oAsg@mail.gmail.com>
Subject: Re: [PATCH v3 05/30] tools build: Append -fzero-init-padding-bits=all
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

On Sun, Mar 8, 2026 at 9:47=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
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
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/scripts/Makefile.include | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index b5ecf137febcae59f506e107a7f2e2ad72f4bef4..bab3174565f0d1e40ec574a36=
0a0fddcee641f7e 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -137,6 +137,34 @@ else
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
> +override EXTRA_CFLAGS +=3D $(call cc-option,-fzero-init-padding-bits=3Da=
ll)
> +override HOST_EXTRACFLAGS +=3D $(call host-cc-option,-fzero-init-padding=
-bits=3Dall)

Could this slow down builds, as each reference to EXTRA_CFLAGS and
HOST_EXTRACFLAGS will invoke cc-option, which shells out and runs cc?
Perhaps you could evaluate the values once then reference them
something like:
```makefile
FLAG_ZERO_INIT :=3D $(call cc-option,-fzero-init-padding-bits=3Dall)
override EXTRA_CFLAGS +=3D $(FLAG_ZERO_INIT)
HOST_FLAG_ZERO_INIT :=3D $(call host-cc-option,-fzero-init-padding-bits=3Da=
ll)
override HOST_EXTRACFLAGS +=3D $(HOST_FLAG_ZERO_INIT)
```

Thanks,
Ian

> +
>  ifneq ($(findstring $(MAKEFLAGS), w),w)
>  PRINT_DIR =3D --no-print-directory
>  else
>
> --
> 2.34.1
>
