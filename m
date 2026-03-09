Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0B3090D5
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079412; cv=pass; b=DEhOvbXagz0kmM/b2z/4RQnWPGJYIcDHT+CNzniGy4XziP0jf8Df/drdv7mBe11byhf9PVcranchVX6jhCZM/veBp5VK7L2rzXf5V+kxrCacH2a5LekvYNkqinJ4mm9ow7trX3Y59WeuMly3RFD5De4QE2i1VvLEa+2opARc5K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079412; c=relaxed/simple;
	bh=Jmh6F1HA1/DHwO4+8wWz0TgE1rMuRLMuCBybYeE2lhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpEu9VDEngzHWpJJ44K+8kWAw5CZv3MvjttHbbEtBc8KeR3jjoa8mTYaLxgOhike3Tl7imODV4PQDzO9NkKzSznaQ1uh9ydA/ZT6JdEGEUJ5aXvbMtQRfRR3bEG3TW6UUTRKMBQEnIzScr30hiQO6Qgb2GklKnY2YEWqjW9rZew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RUjjNeD2; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RUjjNeD2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae523d54d2so15505ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079411; cv=none;
        d=google.com; s=arc-20240605;
        b=NGFKV5BXQ1hAi2IPYu0DpKaG/OOud5WGFEk6GxL+FD6+CNDVn8YgUp/Q552CgzJnot
         0ZwFVVEXQ8EhMHQmqKDibuSAvOoe/Ee5TWM1ZqdNjqEnzCQFkkrmaQV8ml+OIM1eyRP1
         ys4eEUG8c69llIblrW4MO85U90kgztIVpguZ8pEmSKDxCjLpUuDu/r4hgbQQmLNdV9K6
         VekbJlySAenqPVMjk0tMu24KLKzFOH6GHZUSm7gE6zv1euiv9gTauC+5GqFriThcxDq6
         s8pVodEase8+lFvPHm/hqv+eScO4KNe6G4ihjeIX7v7Al4Xz0x8r3519oMhpCpG2WmMK
         mEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/2Fq8jDmUYvdwrz/G2ys/Pt5cbewWsQscS8yZEetyac=;
        fh=N7NBwAbBC1AtdXXIfUKizJP3Fwmcm21Q4PKZxHR1+dQ=;
        b=ek0LxH9WL0/yX7Dz2vu+vX0bB6gt8jWG/wVSVmwn6ozSwKORq1i9xsrnojaWkud2vK
         +WNTcpyBTDuydLvzk6XGuqH+bihx97jC55+/KB8C58ddM27QmO//cct2wQPiucHHqhER
         F2E7Ekxbq8TlRUexlBE/QVaNmn3JesKUuh+mWrEsPRLrhjU9MHnfWKaEpu9jgpfcT81s
         VVFedSbgxn+bTjttBBOF7cD8Qxvu2DavfduIQAttYLOeVycnKVqyvQBXZR12VYYRJuup
         qPEMwkjnNELZaYANVajgSfhZ26S59J4cHrbzvOY4gRmk7CTDR09JxbuQ173qqqBpCKdh
         qFhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079411; x=1773684211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2Fq8jDmUYvdwrz/G2ys/Pt5cbewWsQscS8yZEetyac=;
        b=RUjjNeD2SpN/Wi/gR3CMXFebTmihJt693tZdqo3VxVkdHF/Rb4xG1sEICozrGFwQJR
         5nQE3VTVUX4i7K+i9qBeEgtO03I+LUEYQyhmHXn65F9RSC3luYlr4TI4c9NSdID+a5Cm
         YZUIPrKHvrJ4rkzWdNbDT5++N4CQYwBOpIbbvNHlQ8JRyrdn7eLv7a73BD44xlr2LPYl
         +WNFKaCs243gGIPM2ZweNXs2McugQ06ufUdrFsMnQpYwsypJ/GLW5aKW21l5BFzM1uZR
         WAaetNV0Fa55fEvnMSQ3CE6tf07+fZN8CM7TYlu1Ki8VNjLW7EC3CC7pL4V/gcKpftw2
         dp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079411; x=1773684211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2Fq8jDmUYvdwrz/G2ys/Pt5cbewWsQscS8yZEetyac=;
        b=NdEH9gKYdzySR4sJRkGGJAvLkHmsmFtip5t7gbUdSH2neDCn0RKAbPwaATNZkoCL0J
         5zsRrodjAx8iO0v1XInLvxVPNoJV3H/nNKvtr0HX7MxB4KAtSAQhk84sRv+4aaL29uv8
         fk5XaWE67iM5af35QKxMHOWgGW172Kw6x5UtWDw49Ncfz0Ha/PONlFaFQQSiA4C4aLuC
         6wobuQDM6jEgO15Gn0Jxy0cUz0X5JD76Kn2ECYP0cGWAWCHuXljUB4YmaNFujJCUZO+f
         d8Pjrbdjw6a6P8siLar8XXUGJZfV4TYnwKIbG6xkmhHFEZib2ny+blvCCbOmmsTnGwhJ
         83jA==
X-Forwarded-Encrypted: i=1; AJvYcCWK0j/ienS7nX+8EJN51zipoCuCxIEhVO98AEhG3sl7BdIke4JH1fuCKB7LL+8AvDqjNaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDaKskGqyulc9BgVPnCrGdZYe1o4m8xR9Zfl4TCn+F7MJ4GMXv
	6aqk3moYTUV6wVTQe0p2MJ6XGB3a4bviyrab4fpEpRnqWVIi3rgZPvvZyW964wrHIgTj0uQfogX
	2gAf5AwsrLV0qyBm/k+S4f2JXpi4AKJfGVtgq6yDM
X-Gm-Gg: ATEYQzwkiVH84FyR6oEKLSvs0fAOtCEJ1eujP9EsGMzv7aWyBvpjTRzD06UfZYA1EMz
	Doox0t8lSh697i0ZSdVFzQESnVFzcdF98+Cq/2/yG38POsC/JYMfAobA+DXodWi8kXXqt9XF4St
	GCKXU8v+8Rnt/keXVt4PidAaUq+7nhJ2jBIdBFJnD9nlZANydvl3/M/azp6zT6HyHfhGT4QqacS
	lqEqHKO6ZN+gLBwvgrU3/i/fvlqzk/7oRKinHIWA38IXobZQAOlv6/9d6AHbuhkuPVI1pEZa7Ct
	RU/bqDgpf0as65FEe1CMvOoB+1Rgj1DPhks=
X-Received: by 2002:a17:902:f546:b0:2ae:575f:3755 with SMTP id
 d9443c01a7336-2aea30d24bamr264685ad.20.1773079410195; Mon, 09 Mar 2026
 11:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-23-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-23-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:03:18 -0700
X-Gm-Features: AaiRm51m4nYl0m8tFtQlOB_PU4q1W2JI6UKS4mgMHQi7Hrouc_6G7mzkDrAVHLM
Message-ID: <CAP-5=fWzFtZbXK4DrUOCFBtD9e2_e3BG3Em8O84C=Zhfjyf5nA@mail.gmail.com>
Subject: Re: [PATCH v3 23/30] tools: spi: Append extra cflags
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

On Sun, Mar 8, 2026 at 9:49=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/spi/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/spi/Makefile b/tools/spi/Makefile
> index 7fccd245a53515ab019529c8e5e91a044eaaa68b..1e3b3f91634cc2561c434c02f=
812942fa881685f 100644
> --- a/tools/spi/Makefile
> +++ b/tools/spi/Makefile
> @@ -12,6 +12,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS +=3D -r
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  ALL_TARGETS :=3D spidev_test spidev_fdx
>
> --
> 2.34.1
>
