Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C92F49F6
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078169; cv=pass; b=e/fh37d5w63ZUY4oJECsGOeFTIdadx1yn6nz7b7Es53ELaApsueEX1TjBEw/kLEFyoARuoDGVBK72sO40YDu8xnLw7c946Awu/3w0RBmGAISXE9TzrveRQSiFEI0wmzQH3sfRMv5Z4mUGptDz7tdNVZH/p+n8w3U9MiQWjjp8dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078169; c=relaxed/simple;
	bh=t1FsZ8AwRGJsG2F3mctGRLTHPGEfEzdJEwNT+r1oShk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsGj9kRCgVnH1XmItGw5nUST5shaZcU6jzCpBueNnJrtIwxq4nlTPT2vELx0y09ETU9pYLi200KZoJO7DLIBQvhfbYBEdQwnFDwQgF8NZtnnSEaq9MttEElsW88I/TEBBTEhHKGCm2PLzMKyHfNu5wi9JWz9ZBZC6yslCJZxAaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rFOA7vGO; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFOA7vGO"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae4b40999bso12365ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773078167; cv=none;
        d=google.com; s=arc-20240605;
        b=IT01B/NGr5FU2c4evU06cm4tlTC3Cbwtdeo2ov6AXstjN5RoLe8OC/05MtoEnKRwpP
         SoEN48R7os52RH3zX3Yi9JZ8kyEqBa58XK0rDtAIHnHW3GkJTyslmfS1cYaKubl75UUy
         Ohqk8HNnu1WyAHvO9Tr6QIumrP+AbuVRk1KtuKSfu5Qy+7oAzifZLqAiAj7L0jR6N99G
         T4W+BLg8CbGVzOZgviQwNZMIqsoc/QMhIQIwFoGKL1i+5cAVVf1GiDgmt3l9HRUcXsA5
         eBNAyzgUhxR+MkOsPGRKanBhvmR+i3j3Vl4GEeY7FHIX9YJulJKLKkmSowuDHDDSFI9v
         Qcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HeMbooImq7XRfteaXymWNoOOhKFZP8D3AO8LBClHnvM=;
        fh=mza57iGuPTQuZDhJToGeXFSSoL+buG8lR83v/f2HKOw=;
        b=GyTYJpKb1RjOW3WFEIGDJd3ivO1n/lio87mySc1pRjWXNnNoL4off/37bZbEgA5Vpq
         Ujx8+wt5hLAs2B5L7NMp3mC2UgnM0I+XLAK4L5MAtSEWhFAFngQ+wk/Y/HeT/aZIS1YA
         SIanT+1ijC9iKp4AXm1aXv6LNcfxZU75ZroxyuVhlrAS1Y9mnfL2cSGo0NGWIB2C7vXh
         hZ1AlES2baNEPz5KwE2KSEL+rTndPdUu1vuv7P3MvpT6ZmzgosVk7z/C3a7xazTeEldY
         unD7ckbk5imN2Bni9tZxc6HV3vMEAqOGeIW6D/RqMsEGlPtVZzg8qlqIea62S6Tm4Rlu
         K6/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773078167; x=1773682967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeMbooImq7XRfteaXymWNoOOhKFZP8D3AO8LBClHnvM=;
        b=rFOA7vGOUyqH7v8a1dQQTPuQsnZzzkFdGdrfmy3eeEXP3QVH5w+sJtA8LNhtPfWZTr
         sbmfWfp8r0mqrwiXOM/60kp2Zelo4gZpTBt0Tnd1Yh2b8wJA9sJDEjeTeCaLXXr9tuuj
         TC/shVKF15t0+j8D8pv7r7tPHagpTTI1mG2gywUPPVN9WwREFmN05UDTXFc0VbtJGCvt
         vNBW7waEhX/Yu5wgHVWbsEF7iUofy5tC5KgQMwnNsq+ajZ0ijNOuvlTq4yQQIvGYr0Ov
         JrNdpZQ4j4baBXCEQW1nGFg06uhUa7KIiETCvmlm4BGmpqL4L7JBeUk7CfkEYZyOpDj5
         WJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078167; x=1773682967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HeMbooImq7XRfteaXymWNoOOhKFZP8D3AO8LBClHnvM=;
        b=d1Pgp3B9fIvwVZiwlTlFohZOgmlaYm+tIsLFygZrk2odfVYVVSgF95F7dpOFOu5YyN
         dR7exMEdgkTQjXobO5nttOC0QV7HKh4EaelMRX9RJZvmLyyTNqaRA5DPcYWDuDUvlbTj
         xXMFDV6rXyRncx1PPqhu3tYGfb9vq7BQXGuS5uS2fOeRu8rwJR6rU3US3JK547rh9CmX
         dQdpHrDMAyqN2RYQS8aJxWVHAjlw1l6GPs3cmnml1xViySNflbCKq+w2vc3Cvc7EKUsN
         /hJHA97P9NwziIvQGOdfxrEHCHiUJM3mE9aTabHcdMiBeov5IZ9N3ihfkqc38ant7jnU
         9scw==
X-Forwarded-Encrypted: i=1; AJvYcCWYfomF4TeFY2YLemSfiIEBA9n+UNfjGJnQAg2xhwD0brfX/hmmr+NIRFL677h1f4NKm+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9/blObCL2quJw/Z4YbhBf1If+gCAH/KWC9aGdWvx1H2sJc3j
	FzhMcvk1H1H380jo/BW5enU9u7n9tTQ5BuE9hyZMQXfVr508HsZXQYtPDVtwzPbxLT3hukoFses
	b9+7h+JSoEt+T1xIKzF7KPc0uj9tNhPi/+b50T/ox
X-Gm-Gg: ATEYQzx8MHo1Lx2eiXm2VkRBbbzpXKd2TJdfX9DP1L/9RCWq5KjiZWsSYBAQ3jFSyis
	oTQv8OpoCEdMo5QIFNCmjaW+tgx8y/c8xipb7dU5xGBL2kp2ZEm+Oregl3Kw7h9oSDnsPZxMVgq
	B0LwARjsM3xHSB6IAs/cBijRwIwxgyeKuQmEOuSyH45igvXTOE0ncMAAvYa74Bkzac7PyJ32bXO
	KqpdoU7psJxlJMNWrHFbWzoMR5ghSiWCdYI8NrkUNTPTNcPS942QwG9My7ecm7HLKdYxC4j4YqF
	62eki7vB1m2zMujZp5q7fYcG93xJZqvRfo8=
X-Received: by 2002:a17:903:228e:b0:2ae:6755:a24f with SMTP id
 d9443c01a7336-2aea2f240e0mr278945ad.0.1773078166229; Mon, 09 Mar 2026
 10:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-8-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-8-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:42:33 -0700
X-Gm-Features: AaiRm51Zpc7AIVlXdWIwZwXjPhYHvP-DlYD-PFQxAE3VNul7LnsUe2Ks9NfP7FA
Message-ID: <CAP-5=fUUvztUFJUwBYcaeEuc03-S=JpasCmws6aoz2i8LZTRFQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/30] tools/bpf: build: Append extra cflags
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
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/bpf/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
> index fd2585af1252669c59228af3a77320e449e1a1ab..f7d7978b4e2c1e592f980c2b8=
153608b9d821d89 100644
> --- a/tools/bpf/Makefile
> +++ b/tools/bpf/Makefile
> @@ -8,6 +8,7 @@ YACC =3D bison
>  MAKE =3D make
>  INSTALL ?=3D install
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -Wall -O2
>  CFLAGS +=3D -D__EXPORTED_HEADERS__ -I$(srctree)/tools/include/uapi \
>           -I$(srctree)/tools/include

Should appending to CFLAGS happen last so that the user can override
the default CFLAGS values?

Thanks,
Ian

> --
> 2.34.1
>
