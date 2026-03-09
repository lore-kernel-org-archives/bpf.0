Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30FA3EF0DC
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079071; cv=pass; b=Nu5Dazry2cpTPRHGomp88wy73IpfTrBdJHpvuhOsPnChmyqDykkDSVM/jzTthYexYqgjVkWX9IvqA4x4+UiDhlgOs9gSS0jRTFwoplerIh7xsofGD0tiRYi3NOPyDJX4JIcS4BWEnKyfAV9kvQwHi4NzTsXkTnVYpERZY7bcrZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079071; c=relaxed/simple;
	bh=bi/0kzUFQaV8p3doZRD93rVlwd2uelaWqK+VBjCrW5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tI9dH8DNSMlhCFFRxJbx+qFLuExZ1YL5lX7yAru60l5IYUA3XvgC0/KUZhNeJUD9zLHHJB6UafU/5UVNNw/tk+tN/7yHuec5Eey8jtcCI68Bs+WRsssMryAPAz2Vxv7HauLEdd0gtcO9miPBr2QXRDAzitbcVPBM22LVRQoCYdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gx2DEeRl; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gx2DEeRl"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae3f822163so12615ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:57:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079067; cv=none;
        d=google.com; s=arc-20240605;
        b=PKXG45GKMgaw6bubiTClUZnQUtdHv+iqFYvYFOZ8A4ojp33KoY6EifQgDDHNW3FMOF
         xU9xblIGfvhEOiV8thAtJgbMVZ5Xgzyg/gL4/MUfrcYkG1EcrIpSQYz8LP6h7ExeN8NM
         0q5jhdmjzo2oB24DsNhuWbmgaH3m8bsytppO5P2DrUJKIcNeuQwBl21X06z951SnOGca
         8LNriz5+ZX7GvUTJlJR6TjEd50z1KI8mhpn1V5KDsQ4cjHWUKe/FCi0Ti6INFw+NzcCI
         sZI6SwtagXVPWte0PFGVCmLj6Lq8qES35K3VBKesVbn6Z+rvEKNu9+YfKI1RWlc6/yQC
         xPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vDlEc+C10LHwn7mMynGp+oAsPyPidhsvHXmfLuBSVbU=;
        fh=7fKHJnrkIuJLazG4q2wguj3jJAQx+3B+s5OxqqEkfwM=;
        b=IpqxLUIITxbj0k8OpzWIZe4VsOMS66L68q5PwQWGP7igfVnN9OmdHt49gN6f6xDJsB
         3QpHrj9n13Q1MAkPkxqYRUJDEGa1lwLxkrzgKNzXo/B7avGxMyAlkxeoOWm9rkIW7fBf
         H9PQTy1dWCil+vllDnLAF+P0a/GLHSH/sGPhcm35fjyWVttfeR9YTobHUbnWiDtJSO+o
         RmARshvIPCN5UqcUDP9kBf1NUU2AkX/bUDjLjLjJQoxjkzLatlvwvGVx43fccmnd/+g6
         Em8OOyXzRjDx1ZdNt51xZBP39peYz83Ht8/g4biRZGjhrJ6TVnaQz3ZjCh3BSAYAjDwX
         I2eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079067; x=1773683867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDlEc+C10LHwn7mMynGp+oAsPyPidhsvHXmfLuBSVbU=;
        b=gx2DEeRlRHQNr8/WHpJTel+e0k/DZydgp19ppwvZdahC4wi7nMalsSX9NRv26DZs5u
         e4rNlHY5efFHD6Q3/7C+UBxrtazLRVe+8nWQWVBDZ9+3geBOn38APAv/IZDH+tbi6oTN
         oiBdSB54yjHWjQxza7yPzV3I5esuNxaNZ2k3LfrjdGwOZ3qlfNjvIuuZw0cw+suUJtR8
         kWntTqkfE8SGDRgPwsbh+SaAHCaUNkqAN3mcCECtkjQ4LGeE2Os9cI0vLy6uJpYgiKX5
         wjdF4C9mpIwX7sH1w3otZbDnlQGKO9NOUKDuhkiZropZJwCY32M3cd5uFmP6HnQwAPRv
         RmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079067; x=1773683867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vDlEc+C10LHwn7mMynGp+oAsPyPidhsvHXmfLuBSVbU=;
        b=KEUEQzOpa8H1pNOvWwhHm5wjbRgLCECT2UKr6+qr0Ywb5zwpmhJuo8BeLbAO5KYfBA
         mOhOFI4i/r5Sbn+nPujYXr5423hsmzJYdV/InyuRQcyixNup0r1DenXIyPuaeYv2F+Po
         Lio97a5RyQN9IA8oAJW5VTPW/m8lCUCsvrdub/KQ0miVr8WKEtsmCqkcRvxLfXYQMJSY
         nsDJAEhFW8y5572dsj3z/XyZRWOvsQ5tHSAW94u2DN5+N3APCkR8wxoZLq6bLcksF/Nn
         NyKp/+y6BZGnZt6BT+exi/ihbse3jUe1D56aeL5mkE3LVnRCLjOFOfwitDfyeSOJs8mV
         ujBA==
X-Forwarded-Encrypted: i=1; AJvYcCWQSE9MIgp+0SJDdIGHKrZK2aSWq5upw/BFSYnbC1p7tPyY7xQQ79f4QczLn0z2OWBTMEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiRY0jrWLkFZmXzCbvdRHa0BPnzbFmRAcamGBWOuMLdZdto5tx
	hzPW83GwqeYsvRfH6HeNsTHjN4wltpg6kSAR+RJFAyzquX4GRmZZvLn9HEZ2+Z5O4ceTpx+NQ25
	0RqA87nSK1JsSt9CilszncrQ6S9I/p3nlzRHLc3Uq
X-Gm-Gg: ATEYQzxXWjH4jyGz6lLC1sTQEc4ohdKcENDSrwwawIDU6KcfjuOL2+Fq2qop1GCm5vR
	SSvS9Jwr7L8R5iT0gu1c3gKvjwZ0Tk7zkjcCUiZed65qPnty8tqidzSL5y46F2ZWnnuLwdU06jv
	7uDeNNh/PnTahoQPC2fg+fc9MyAU6Qt2PyTHeqybJ1xhtublTa/vjvX4GM6d2UluTW4nXHmyPOX
	yy3yF5xuEzKcjCSu2mWV4oLycCbFocx6vJCrGeR8uFIaFJZ0lEgT98YGhQAeS2q9U4y5LCskW7M
	zWepzhc4J7xL1d/3DAUDTbX0fLdSFCCG1Vk=
X-Received: by 2002:a17:902:aa85:b0:2ae:8039:fcb0 with SMTP id
 d9443c01a7336-2aea3122a7cmr131785ad.5.1773079066411; Mon, 09 Mar 2026
 10:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-14-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-14-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:57:35 -0700
X-Gm-Features: AaiRm52StTlx-ugeD48VkaRFXPHj3olO-UKSkeOjK7TIFhirgpNgc7cDU1gN2Ws
Message-ID: <CAP-5=fVTKXfV0qqt_Fj6r6wZ-O2X-gqjM2mkPfbawnDJQj7U-Q@mail.gmail.com>
Subject: Re: [PATCH v3 14/30] tools: gpio: Append extra cflags
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
>  tools/gpio/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
> index 342e056c8c665ac075041ff7c7ca7ba94c691187..206fb6c91a569d64b1e4b906a=
da5ec866323053c 100644
> --- a/tools/gpio/Makefile
> +++ b/tools/gpio/Makefile
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

>  ALL_TARGETS :=3D lsgpio gpio-hammer gpio-event-mon gpio-watch
>
> --
> 2.34.1
>
