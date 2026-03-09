Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB953ED111
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079035; cv=pass; b=tG8mIEDHXOLuC9DwelzZufjRaBpIX4+fiGFTP3T6kRVYkkUHTGucZxs2qHipQBm9SOq8zaSs7pRFRZ1GMbsRJZ7pJl/qIqQ/yBbmIGDONYzMtmvoL+j7uPaAWS3qZK4SIBgKs9eJ2fgb1XsDZxtTIA76KMY4aCmXbK9b/aIyNRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079035; c=relaxed/simple;
	bh=e7l4SmZBUR6r5igqEW+38ztoAKGAhS0X/5S8zKQD+s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGtUfVN3ZLNTKtG/pFz0g75qTLF9qYOp0yMZCG6GxiKQcNrT/DiCpq/6AtyFmB4nPH3cVVWtSKSG7Yt4Upa3S/R+Fgt4o1sGuHnYpKvAyn9qTyDQC8SrIxxuw4mvutcoC4jiOrfgnt3GkquZO9Asgw/w+c5uuZNfoCztWoeUyh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qReq42Y5; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qReq42Y5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae4b40999bso14325ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079030; cv=none;
        d=google.com; s=arc-20240605;
        b=S1L+CIp9zPV47JbRhkBVW331ZwdKDUaQRQ3jvVhJ7dK2uehvC1BXp44PBCUkxgeF4L
         p5wu6QeIf0uU44bT4BU6QgTFeNXqeri9PXjMekjjR1gJ58hWdVOYah5LuQptuEv8XgjT
         IHOJEXa/WpJb0SeN/HsRjIBEQKo90C4qi64ihgl5S1/5zTZWRVEboeJvXO5OYv8nFayu
         yy9Vgn6TY1mpykWQwoGYdYElt5pOTJZeBIG6Tn8B0lcWkSFKg2FjERSs3H46vvOhb5pf
         augWscT4IT1gmE+/wy9fLbuemOWH3gymQ9BTuoHEdXXEuaOYDvR2UTMmfPupT6nBJ5P4
         /vPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YgaFfLtD6LpB7+GDppuc9zjZm5c30kugkl39n1WKFb8=;
        fh=wZIyUv4efreEkz9iBXx1gbt4olJ3drR+AafF+Ec+YU0=;
        b=C64YRaBLQzp3eX/1jP+6C/wXo0zfZHUf/jEjl9swsZHUCUVQM4gieoIn7caXF1mVxv
         YPsxC2PdYKGD4oXLuJEa+8pxvTPXjjZRpGQkbmqUjhfyO1Xxl2yE9xyJhcA1yjz5q0+w
         4LepBjNXB83gf2NfFqxqbtmiIU2+h3DOcrWTe1nc2CgE7cyLWiicptk21K7x/rrKO+S7
         jK/jLD7CFrsPSNSPFVllXunOT/OkElavhvkjk71PX5yz5PYzaA8MfovX4zNFKCbAUWSl
         ReQ86iZiCfbr31YuzNTTHjENMQlrCvYkLO7ebgkeeRyeZ6pQqUHMRg1Pc6IDdaBkyP96
         wI5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079030; x=1773683830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgaFfLtD6LpB7+GDppuc9zjZm5c30kugkl39n1WKFb8=;
        b=qReq42Y5h850n1T4pu9JaSPZOvumGTlG9M+snrUQMy4qvceeMvQt1XR/1duYQkLd67
         PS+6sAeIb5AALtG/g5vK4RcJMpt3DJJfVd+VGNs8VEyXTP1mNLHu9oRQn4pMslTtkKch
         710FP7KjTkPBe/69R8f+r7yi2wHxnZsl8RcXLM+jnS64TksdIJtI8eNDtAGOmPCHZub0
         BOuQuRHTmJxL6c5iiH9Ep+QMbmLPp3YFovkgzxe4AeqcDguZvY7B+YfhP4L4P5MtCcjN
         nkMGjQLal8DaiAI8mkC2PdB5ZDfVZmPGP7YN/gexLTwLAZecN6wMr85kb+Z5W+hqocY6
         gQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079030; x=1773683830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YgaFfLtD6LpB7+GDppuc9zjZm5c30kugkl39n1WKFb8=;
        b=DIfmdGfiAxVNN5coMd9CGcp2+QFwSnHmUxZip0lEEDZI/t5KEY1S01FIUoSrIcj27U
         MhKhYTzU54wFyQa1z5kR46kgM88zi1f0gvM/e8qQF6ad0vFsnaWjodYPc2HV5S/1R9kl
         FdDkLkmWxne78u485EkV6K6W4vkZMZsBnwJlc+ZksgDGugczwRK23KmW2TBNsx95w5Ji
         LA15uo9LdBhxd/2fXgnvsqzkWh29J5+aXluwAKS2RPwo+Jzwjj9KW8Sax7LXr83+1lyY
         9GcC//sp8Befm/XIvlAjxtsEKVfexpJiVZGzXgirhg1qGds2867ZPnJZf21ow10sTjAb
         zKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb62PRsT/PVlFwwvtDzbYPWYcDoETi0khLFf/LpOTKJLOO8J2KCFM1YKCp2ewQ78BKQJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3sm8t3Fw1UqNr9vIMlyd2/6EXnG75snJ0omdZw20o4NDxSmjh
	HcfL+93y5PLFUHvZ/JOpzw2OBMvpd1i+P2N1pCeCTZuCNGNbxtK8NFNkl/XgJiuFnJd45IDnL5F
	/SHrzdlI+cE5CGyoKPiEetJ4/Ghc3R7Ci2x3r/toz
X-Gm-Gg: ATEYQzymM0cuB3AAA2lFEW8eYS2x7KdWHN61esKVJ67+AwUAnbYoeVzISn8TcML1d/C
	3VmRC1kPTf1GI3D+iV5OKMfcPNHhtZCQswlrT/vbCg2uNGcEImzHdo/oq/fWO7JweP6f8iwDQTu
	7MGaSARsfn33yScIx3cbVq+VYdQ4Z18egTGTssDS7XhbhWATCaZmV0Un5LmaSgXV9k7Y1TvPp3X
	IE+gHt1cnVREaWNP96dKWBOgLoC6m/QyTke6nFN8ZSiaNULHbAjhuyhQF5LT5kcw/d1/8MFbBpx
	62w641No3h/dE8lEv0NqNDABuw+qKccsD/o=
X-Received: by 2002:a17:902:f68c:b0:2a7:6fd3:c11e with SMTP id
 d9443c01a7336-2aea30c63dbmr244475ad.18.1773079029518; Mon, 09 Mar 2026
 10:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-13-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-13-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:56:57 -0700
X-Gm-Features: AaiRm513FrreYhP9xkA-LN0GZhrOTdf4osjECxyH4jBzskTrYRD5OF8a_TvuwzA
Message-ID: <CAP-5=fWkVHaa417c=1kzq7s=qrsHHDyKn9K1G+BbX7TrzaXZLw@mail.gmail.com>
Subject: Re: [PATCH v3 13/30] tools: dma: Append extra cflags
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

On Sun, Mar 8, 2026 at 9:48=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/dma/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
> index e4abf37bf020ca613b6dca340299198cb887126a..bdca05c69a8a12a4f9419eed8=
c1df71adac4f26d 100644
> --- a/tools/dma/Makefile
> +++ b/tools/dma/Makefile
> @@ -16,6 +16,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS +=3D -r
>
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  ALL_TARGETS :=3D dma_map_benchmark
>
> --
> 2.34.1
>
