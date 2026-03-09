Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26212FFDDE
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079115; cv=pass; b=INSkUyrmcP6j3kSCZk1VMlAlDnEXF2NKWquur0EEL0aWFcW1ujRONV3Jp+ywj+VF6ML4/onKWb4xvb++EY66eQsSidRq7gBtgRuKGkGvywK1eh604Ybyy8DnFXbI7vZYAXPPBd/KHgJItkAJ78oGHUixiiAGi11QugJT6I91XJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079115; c=relaxed/simple;
	bh=1xHBM1npckFnBQ/QU7s8rXIaGuuzzkPI1ggicrM5qec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7IcLUAE8d4aXqxfjI3mrsjGZfqjHdXILKYCCeWMUrVryE96QfbQBU7v3q76syG/891vE/FgE8/Rs2CiPwUTtYXySrvWrlPGdy4bE0/WQPghuhJBh3jKad1whAz1fuftbY3gY7GFnEijFvMDzNCD5I/+GKOkVdB23iqwsdR9AI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Xmc5G3e; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Xmc5G3e"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae523d54d2so13935ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079113; cv=none;
        d=google.com; s=arc-20240605;
        b=Ys59OpjeGBJOBOa7pofIAY8RZ3AVabwlGJsw7QcGQ/2dd3WDzIxLj5bT419WtCwmim
         mlxVslHIdlggynOe/w+txbFgoIWJyHY6n8TG5JUHI3BZV13SvZ5G4Gat289Cj2Ajkzp5
         81flipXkGU8pClajo/LawINOfBUznOcLxbR+GOSEi78TO4HPWgYPIp5Y8aoQRkLh6oqZ
         MUxT7Y5dNZ/SvMQ7UpwEfgD78176ilFm2aHMdcOr47Ej1AmldhqHQE0+ZbTdUkzXR9Nr
         +6o/Kk9BmvUfAZKq8qSyRbCmo/1ngcl+nrKNYlsEvFazAw2g9BH7zJsjuog/7CM/ZgIL
         QWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=slXFRZSUuUHYd9aE4MbVYMvGfHoCqJ3GVsU6T8shJBI=;
        fh=lbUj3BcyzzXr6nDvICVqjvX/84y/VRt5G2iEDzqcEx0=;
        b=DI1j5RQmjchyAhY1hEzOjBTuMPLlQQjBntBVoLDoEeOWJmzaYp66rRHg8YwOOMt0sT
         IkSSLAcGOdVj4H77ocfswuDk/1OZFzjedOfCNtnXO8vzO0ToRu9Cbrm+MoeSWrdYTZ4h
         JJPvcBoTgY/CRHhpdayngSLBvFl7i2mjLDvlK8FmOCASDVait/WVdKgrMVChzmGWheYK
         kXoJG7a6gtEejL3fPpRPFy8Tx4o1H058/5mdkclJijtAg+jXGbCWC1QZQFx1jLzVQxPO
         xp1dqKJAOi4v4glDGZqWfzgMFB9KErRnzTBpj++YWnObqcq/mrvfjKOUOWYKhAfRLsqV
         fywg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079113; x=1773683913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slXFRZSUuUHYd9aE4MbVYMvGfHoCqJ3GVsU6T8shJBI=;
        b=3Xmc5G3e7zPvXB4gofrkRvflwDClDpHO4wEIDB8a8vEZdSirLahrd4h2BZza9zr2rr
         nRO+5+qwiSx6iKEX3762ZAnEJNQHaOUfJcVZ0oEiqgGaPI5OfoX4ovmvFQQ/DT/CSXGS
         8oYoXxNMur1TvkQ1ne/dHAhusXqaDqE6scSdGUA+C3Z6IESRFy2I0HZQF0cwjl6UV19G
         Go911vA2T+CtNqBkAVp+rhyKYLB5aWLcg+y9SsbB+dccvAeLcTLFEw78ov8hdrEkD+yl
         pdR+MA9c2XxBi9JjnaJK5tmQr8aASMar+uRkMenFkLqwnZl7XUAwO4o2x6HLzPYBFOEI
         RQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079113; x=1773683913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slXFRZSUuUHYd9aE4MbVYMvGfHoCqJ3GVsU6T8shJBI=;
        b=EMUlNwr/WXTB0MLSyk5+xtC4mBF1GAqEsyu93scWJEbYNt+vp2EJGNpNW7QRss9SYH
         ji0Cg9kXUgoF8rWx9pR0X6Ez3R18uVI62hTPiM5JE7t3GGhVF/URRelsYcocuFIvKR+G
         c3y5F4GIsGE1FfzDsPM0NNzE5IxkSKauSkH+p6hX3/oBY0JmELtnl5JJzw0up0MnibQc
         /VZmraRGkLK1ULZRKM0VnngVJ9GztLTpgtVW6WaJ9bMOxnK86MxY3oM3TeGyDW3VsVY7
         e4wSHC332jqmvc58xr8WRD4y2D2Z8BhpACm9uhl0eKKY7LuYHNgsE+P7e0z2xVRFWb9l
         /Yww==
X-Forwarded-Encrypted: i=1; AJvYcCU/2SvkMMpOqFo7F1CP8KFbsV0ULz3G3NHstTmgXsN8xSGBGHS9rk7RXIPJbB9HQ7uHBjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6oE0Zes+mJSFWOm2YYTem8h2f/IwGDz6owU6xddHKzr3d1k/
	1Nnh6Lpt9wrA0+mwI8MFvJQ7fNAIpS7FOrk3h3X2X7nD7TrM0Q0qc1jAATIW5/lyKzkJuiuupXO
	7x1BwcmRrSQyWbAh+cnQ5x85y/O0CuWShqiML5atr
X-Gm-Gg: ATEYQzy3bzRQf2tSt88ZNmd8LRsKbtP+pSlxqMSTQcPEI8gNHELDEuaXchdIzJNNbF3
	0PByRZsxyLZKgtb/LoblwIv1S3Q0i1FqHohq0JmgHQmmls85RN4FJSrYO86OpgFv4UyKgeI70nu
	1/Dy22YsQI6Q6Ufj97Rcesb06/HrItIlJn8d4CCZcXdqSk+pPSOy6x8BpcjFKdeKsDjHjjX24Zl
	OzzAXoraBd3wCk0gfHJR3kAHqok+g4CTa+zkKZGk8pPDuLZHpNUXEM+X/4ZzAa3Agxouqu5WByp
	IV0Mu5tx95a6JRlkqDQdKeWXG9MCEGX/u3pYXmheAWD9Zw==
X-Received: by 2002:a17:902:f70f:b0:2a7:5652:50b2 with SMTP id
 d9443c01a7336-2aea324799emr181285ad.9.1773079112595; Mon, 09 Mar 2026
 10:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-15-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-15-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:58:20 -0700
X-Gm-Features: AaiRm51s4uFr6B2kmJ1teMsm_yMIkBYdnRBaZ4VTor_pU0VbgMb5xyzkSrea21g
Message-ID: <CAP-5=fW1CXWUg=LS4V_+988LsukYuBuKX15qY0-vTqar_Lz5qQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/30] tools: hv: Append extra cflags
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
>  tools/hv/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index 34ffcec264ab0fdf7075d25456ef012cb866796b..e39c16325b451ee7c2ddc581c=
c4d168915472ed6 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -16,6 +16,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS +=3D -r
>
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
>  override CFLAGS +=3D -Wno-address-of-packed-member

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>
> --
> 2.34.1
>
