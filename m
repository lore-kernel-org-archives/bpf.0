Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C240FD84
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078972; cv=pass; b=KZtAsfcUTpPIiMQNm0fNpVTm1rdzFOhPwrp9zmm5DCdvsVivq87sDbPuFLDMHgeI/NdoOJpDw0hD1erytWQX8ZNy/L6PLLExuGEGkJ1mZaz6j/59dUdMB0i5tTc08kNfhuNb3X+1RgPIbZ0JjPRj1Gb1ZH3D/daqVtAq8NjKJiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078972; c=relaxed/simple;
	bh=h+/4DZvdFjdZvTikaC3AlhbGhNWEZcA48r6UYxyTE/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRr4ct04ReZRoTzDvIIM+cW0tOWYjhlfoCevFa97Q/C78St+pNBLn8VK+C+qfH51QHzKVgA9D/KCFMCD/FTUcWm4THdGCNSm8IqcYE1bf6b23eLU+4VyY1KKCUcVlZYY/P78+SafrUuwnU9KZVRoCBIt+7ZZ3Zi6JlhZmb2Tnfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U11uiaOy; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U11uiaOy"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae49120e97so16505ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773078968; cv=none;
        d=google.com; s=arc-20240605;
        b=BW9+fHXi2Pc3ZsYCqvi4keGWfmxeJ+FQcP8vhSX3hQrz48Gzwzn4FLRb0kREBNDMZn
         /tDZKL8LFCp69qfJDXHaxAo1gMH2Mv41ODJWkWWa/XDLYbsYDGhVyv/OpO3GSDHDmrA0
         szeyVoHS4uVPFSEKzSFd3JS+62vSz5JBhAf1oYY1RE9iMwK5V+zEbUBDCz3dELXNuc18
         ToISAXBPunjDIssi4YsOS5ZYyTw3t6/stJMNZVxz5JGFfDQdQD7QCyetimT/1COCjiC6
         RwoFwPbAmXKCnL09HNNf3zZvheetiyhPoQjiITKi6NTilXkFLOJgXAxwiliuGiAFfWb+
         RaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sEzDXhUVFO4MvSKwYYet5FlMfGg8jYj3MEwBCZj/ctI=;
        fh=JOAgN0hAhdhJTnqLvIkk25NbbfJRTlwjgFghZsZxhpk=;
        b=Eo2sENwdvCF+aXR9yWp3HwnUv4I1mWJmD2R+P8ZKdSUbvdVB2tuPS18medAM24IqpM
         xmTQ2ldsKYwEWE9iSUz9vbZsFu7tnGdP/2bSJY2o5P/9Zsq1UHNXUyfTK+8swP/myaF6
         fz5JOtpq75NGunkqncui4pfph1v1bgwggLwnRe7/Qbx0szkEIVYUc+gDwWD9NeoxPgHj
         HKIidG+f51x0KU4e/0gH8oZ24P3yxcrRU3Ud/SWf0aPEKu8PWGG/g7sHa+NQFMG1ctcq
         incOszpbxzDyrNN4hjiPya4LvYGjYnDZMUFe29e1U1j7yRJ+pXNSGKEAbRpEDGlyG9XE
         9ncQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773078968; x=1773683768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEzDXhUVFO4MvSKwYYet5FlMfGg8jYj3MEwBCZj/ctI=;
        b=U11uiaOy/jBHE//aNF4E6kzY4MDJjBnaRpkoB7CCpgQ/0iyDEpsr5a1GWNDeVO+d/b
         jwU2txSbFsSlUnpe4P9zQfSMnjyyRA0jqucMrG/wq/N+9u9PKpH15QuFhRjE0FkYy5LQ
         4kCk5XZy7yKebPFSSXyLwsxh2KCFNxi4tqj6yYRWPzv2h8qoM7GKNunt05pHMVIDzoOR
         Ej4SwuTGIecayImrmWIAWqZWpA42WOCw006hMKOrONeZaRGKuHrHM1HnxEB4KDUAQfM8
         lgfXqi5CNtLOlMo6sdzq8gYqcOSORZyBCkEAOUM8z/vV3tK61VdtNhsXIaZCYn2pBR+d
         WptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078968; x=1773683768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sEzDXhUVFO4MvSKwYYet5FlMfGg8jYj3MEwBCZj/ctI=;
        b=FB9K5CQ/Ms0QLU0rbDrekWSmcHU1QM3enP87I60uCgdqi9FFEwPkmiiAVIGbhTISGc
         XZEptUNBuRSIOS3C4eNFlK+qLR/V3m3D6lUXIiaHs8l52GKgdvPslEDg9r/BuBUd3B+X
         GLF99LPVhj0tyqlsROBCBFwA/wh6/hCs+s1kiHEkuKp1rhRnnovyuSyIyofcJnf2J6Ca
         7TjJuGztTe02PWBMVUkSOBzNcrOOgsghEO2VxoGmCXdmywNdjoeNgug+bJohT6UoasrV
         ycKBZioGc2K9YsYQrhyNmUlbX8jkgIHrx25+CBnjhENoa7gJ4lLeKvAORW8lrvnYG5de
         mJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXH1MWBjM4XE1GVEULPLDkmPUiLa4EFWJu3rxbBO87UtaoOLUsssN5cq8xa8WNTtwYB1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBI7ErOTAWCt3bcXgzzovcfcHh0pHRdPfWLPkaKfkmnwrcKFD
	Fh1+9ZLEi0MHK+grpugXvaxFJI/QjtpuM8CIb+KBJ7rfqkEjkDNdXoauvNBZAr3ssGOLe8h1xLJ
	j12D0O7W8d2vXkx5tKww2dDRST3WFyGkXfdhXBEE8
X-Gm-Gg: ATEYQzyJ6/mIyf5HmzluKh0G2OF1T8Eu7+f/dVe5AIb5w7m9ScpjvmyDhGHPtXKKrc8
	7Gc2jWB4Z2G8h0HjGxfZXK2BtVHoIoEtLJWwKa/LnKmsAuAE60RwobbgfGq/dagFs6I1JJCO0AM
	DkwZtcyBrVEIQCufYxHO3mwOjnuOBFHTcmq6KGme11UcEHajhJFWxiATn2F6sZJ3sbGblcpzGE+
	+cifY2zUKJ8gC0CcztidVWzFK5E8Ohpupd4kXi/1TkKCgoAILuQhwSSD0+0/AhwOh7KmQnNm38H
	Cr5z8MyUZ0LiMuwC5wk/u7MKNS0rzfQfZug=
X-Received: by 2002:a17:903:22ca:b0:2ad:6f9b:3b2e with SMTP id
 d9443c01a7336-2aea32bfe3fmr148395ad.23.1773078967464; Mon, 09 Mar 2026
 10:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-12-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-12-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:55:56 -0700
X-Gm-Features: AaiRm51Xb31ugKo9S_MPmrA2EHDpcWCZuqysgwYrJ9m0CLzFNaO2kRL95jSSXGo
Message-ID: <CAP-5=fXyH=AZO9XEhXG_X0D+ikAyBmHBUXvDB8ivoJVF2ccjBA@mail.gmail.com>
Subject: Re: [PATCH v3 12/30] tools: counter: Append extra cflags
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
>  tools/counter/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/counter/Makefile b/tools/counter/Makefile
> index d82d35a520f610260abb43f6ae28e56d73268231..c0628677af3807bdc331ce2db=
a92b4e5f1a25b68 100644
> --- a/tools/counter/Makefile
> +++ b/tools/counter/Makefile
> @@ -12,6 +12,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS +=3D -r
>
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include \
>          -I$(srctree)/tools/include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>
> --
> 2.34.1
>
