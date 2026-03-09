Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4D2C0303
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079572; cv=pass; b=X/rAUtCK9NKiixRZ+4qvx9MruAWmrZlM3oYQtDgfZfSByHIg29SeyKjTuzq1YT0o0nR+skznlFUHo/156UQkSUx2udUWY/HYKrI4B5RiOsJGWw1dZWtbSiVcOcBXG/rkkrWsOWldW1ginIXtFMVGCVwAw4Xltg7OgZWdbrbh/NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079572; c=relaxed/simple;
	bh=42c9ZH1wrf48IJ9g6TUsDx3jUDNj6OlA/w9q9LS4OsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nX19plBuE3JrSPFeqIj7o6c8PZYc/6msf+xqNFUiuQrjbc4m5gxElC6WzhDxzk9FBpnJ1nGhQWUwZsoIFvqs52hYfp4kvEgAL2qdHRFezc9YLRbsZHT/yVROtxJ8VP1DYHttuVrkvvDoFIOUQzXS4S3nyEnt1aLQSwDVcgDJiDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3lqW/qjJ; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3lqW/qjJ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae4b40999bso17585ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079570; cv=none;
        d=google.com; s=arc-20240605;
        b=bXTvUaBNk4GlRp1+pBT5+YsV5VcMGGFhn08LRQYnbQZnvovt1N2lbetDqCFDwSeBiR
         JkhufBogt3kHnsFbfVbTAgzj4OQF4pLcRHXtXKY88pyXb14DuV/lRwhdBIjfgcYnYQFN
         JNpnt6kGYWYxFYHuv8p+XEcRwUUTHWVINrfZHZVyJw0H7/I7GdyOFFCltI54ZHX2m6xX
         bFBpkOdw9gkdo0TAYgLHW9z2yNldneajhZX81tr1KBY68NEBPf/yy8HWd6MKtDPcSVZO
         KQsA2dQj3KCqnodIAWo/BWXUHhdGEVn+r4vg/NTi8TERk0MEMWSoN65kubKm6A0PD4OM
         bUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8XdeGKgfNmQ0ihM13m4/+pDXEjwuXh/6MDXE3f2Ssk=;
        fh=tQfPhZ5tuDMSd/7UP8vv06GxM3hmNeLCzSB7oLuOUZE=;
        b=TNjXMceCTG5ZTdyms5IYZ8Z3sZjTv5rMPYw/wRoGP3I7dWFhUcTSM61Z3TGsazXrVx
         8zEzHc4CmW0CqqZFGw+8bFObKbLBZBXTw0OE59Qu2HzF/E09eBorOCHT/8OZypNeLSZI
         ytu1clk5gt6nVOiVgZWZE8fa0WyiwI58LViyYbuG4Cvv1VR3Qy/xWBMdkYUNLOS9lvJY
         cnauoqCRIX8On23tp6VIfHdUkQ/giy+KaOqMPr1fo9XsL61W+evMfSXd2vBqxGnDkWbE
         6W7kLJgTZbevk/A94VR3ltWyL/5NtlgWqFPZQbU4XRTUIDaLtOq3FW9iwRlc/w+iGU3C
         g26g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079570; x=1773684370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8XdeGKgfNmQ0ihM13m4/+pDXEjwuXh/6MDXE3f2Ssk=;
        b=3lqW/qjJ/A40fgCTjx+nk1JEN4FD2Iejutu4MU5MSH7QIu9fUP5EzC6c22S5eiLWoA
         fIPC/+TAB4YVfQl4Ag+xsG9JgbEf4aGTh7cPhdLuL7A+9DRwZuHvTYmYqLcQiujE4VNL
         B0RusBXunN0H6DY5ingObMA09KqUhKP7RwJ65c8SRtBu0xcS9qLIaMew4N0tg5JJQzv6
         MUmRdiIiE1Vng3/5S5vZDO+SEfqoDPqzC0b44j1P1XBWXSlNAbpx/G+U6oS6M28eGFCO
         xYs8cUYQeNcpM4ngkyzKJdIfCIdhU4ZJcuXOkob39fc3P25eREVwoYrVHMKuU9WEwU64
         LXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079570; x=1773684370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a8XdeGKgfNmQ0ihM13m4/+pDXEjwuXh/6MDXE3f2Ssk=;
        b=C/Krep3GFqDAc03DyQ0SzCz4vBWWUETetZ7iygZmetZOSFcnWrrlhhmTb187TThtgk
         W3ttBwR3QN6o36ClS3Bn5wey3E7RSbaXjcFhteHc2wg31Kb9CdqYRZ2GsnCkDH+VPbUn
         I6ACmu33basEFM7dK/ZLESVMGQ5dmcCIF213IOnuAPRnT0ysBWTyQUGIsiLf8LBIzfeB
         wJTdyej+YUIQXhczABa2iVgmboP1MuAN+OBnE9gScM29122yclOouNCHGvlj0gOwKVLt
         /F/Q8Bhxo+BxEPx9jJMDK0SWao5wxk9X2xlSZsN8GApv46PlgvWSZbOasUd/gYU/M4Yj
         yj2g==
X-Forwarded-Encrypted: i=1; AJvYcCVUwGuutIF2unFvT+sVkh/bKvX4VPoxHp/twD6/rUYtpmFnDxgMjtoNI4mfYXdbuVox9qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlgrey4dQ+BWcD2NI0qCAxY6qjirdcCcZy1M68zI9OKx9LlA9i
	Y5NWEdE1Rt+1OKHvgDi9beeuvNAOV84Kt+3ar1w2z24lKNlG54W7l0CiAlw1AXVV1UqwKXlZkFz
	ASoqIcW7w2vxggSbBYGQ8OWlA5JxQxNn1BD3oa2lh
X-Gm-Gg: ATEYQzx7kdDIceVOk8IV560Mynu+YMx9hwImccKqXI3DhqN+qxAJLlch9j3co8krWmg
	yFnErz/3grByPswoCqrI9+oQoKECUJ/XzE6RwV/csOWvIfHsXnTPJ7eK73k+3d33mx3iRwufBWu
	YRWxY2U9L2vd2aRHdHfbteDksfDkWuv8VkpK4NOxvcXOZuZnfaAlgnDTT6TrPxBCmUOrlfoKAap
	H3mm1BjO4rqy5VWnRgbsjMI49VG6DUjyeilVtxSJJhh3oLvbjjzZPBptmBzi7ZBT/gFp0kzT0oK
	zFNQMB4hOoflzUZyP5ZzuzBcUJksw6BfxlL5BSuE5ZB9oA==
X-Received: by 2002:a17:902:aa85:b0:2ae:8039:fcb0 with SMTP id
 d9443c01a7336-2aea3122a7cmr154565ad.5.1773079569456; Mon, 09 Mar 2026
 11:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-27-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-27-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:05:58 -0700
X-Gm-Features: AaiRm538eyfLQGrSYDrM92WeXq5PMuuL8X7tS3nLFN11znCK8k6pxl_hktQ-lc8
Message-ID: <CAP-5=fVR6cTg4HU_DvK8sckgAqWw=HbgSGSdY9-prjb+TiOzbA@mail.gmail.com>
Subject: Re: [PATCH v3 27/30] selftests/bpf: Append extra cflags
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

On Sun, Mar 8, 2026 at 9:50=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 72a9ba41f95ebb825d25799c07ba3f0311243e45..29dfcdbe98c781b53f1e87dce=
becf2027bafcd5d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -49,6 +49,7 @@ srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
>  srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
>  endif
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic -std=3Dgnu11                      =
   \
>           -Wall -Werror -fno-omit-frame-pointer                         \
>           -Wno-unused-but-set-variable                                  \

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

> --
> 2.34.1
>
