Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5744E3E5ED4
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079147; cv=pass; b=kJOyyN2o1DlwkhDHwTreOlBt4IqWtt5Sso2l6kHtg6iTH3KAZYHp+KXLUoLDgE8UtQj0x3Dy37uEforKwRqLi2oRkP9gRdCSfUewTozgmYV5zg1mKpWJR/oDjvpwdkxLFP51ldofQZZK0sgDBqgFjQH791uXmGfyyACaBTBDrYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079147; c=relaxed/simple;
	bh=K9KvPWrinhMHT35zdp7wWeOdqTqba23yLvkTaWHsvhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrrchTOoPUccoEaXIG4gy2Fxp6d/Deo9+sRaPOaxoYTjhUHlpwH6bz0/dLfasiI9YVtlrl0zk55eVlc8WhqOCn8ige0NieNZU4FnAKfr1uUgPVzjCgETvLmnbIypbK1fu3LrYOUtzrHXImb2n1xdxSYu/iSEOgUMaN52vLWOiI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLPto5eA; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLPto5eA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae4b40999bso15315ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079146; cv=none;
        d=google.com; s=arc-20240605;
        b=Hx604LDXiIY5irH/z88/MXwC4q+cdo9bEzuJdfagt+4JuA/lIHfEiV82UwFg7JDo00
         2l4XpATSvjXZ7sxxCdW+BrFbSa/amjHMFDJhbYVV63XXwOImv0EZFyO0s+rzkULzlI26
         OrR+4zOrhnu39J3HQn8HwUbZzNVan8POzODsp3ZOKRq0pnnRpYypadioKzuOWo6sYhNi
         jSfsSslabfFnruKmwdIV9NPt0ea6TU8acMOYyNbLBcgRtNl+u2wmdZNS7WkmMQBR71Mm
         YBH/fq6QQXiWBL9uo+Ply0iMnmc8shAMlt9kjXYWyvW44rwGnF8gmDHs/FUZ429TBXWo
         T+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aDreSjYEwoLVTucpTragxMff4MtZhsK4TyZGpsfQmdA=;
        fh=lAeVg+WXB6xTKObREbtDoNEw4oY30e2QBChK0yXF8VQ=;
        b=JTN7nRD/tARDG7imdpjFes+fdv1XOiu3zQAeGBF/vebW4EIRkJV4X+7AY3u7yi13uE
         juAnonR9SOGvvDBDrTIfmNTjRgkkWfL/FF9D2lut9EzAS1q3ZjY5x1O9qkuTGdPTgMzP
         yP1V91+Wa8BL3euQ0sSyNllTNYvbrUYRa8OtNAf9pvUC/w5rbhFvIcurT6EbXQowN2m9
         p7PQSXne0kxojTuBoc/Hmn3e2yuT5hkETMgMClAh0WqPUYW0SWejMa8qwVJGw73th/9s
         InjYchx4VBEFU/4ExVf6M8O6UF1nd0eTAUiAT53mAVvk6XaUVqo/b/NlWgkwgy7YqZ5X
         eY6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079146; x=1773683946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDreSjYEwoLVTucpTragxMff4MtZhsK4TyZGpsfQmdA=;
        b=iLPto5eAVQ4xDuOQ3Ea/TRulhek9tQjac3+/mAVd27LapRjdVWuVFmd4MvgDs/giw1
         6IgcCXPT1CSk0a1mCqR7kBFpvmvZBA4tWQyOsw+TRQUHy5YY5VIVWXK6PM/wJtBcyNbD
         3n9iXcdjyG6/M07YpTW3x1oka2tCGdrC4hXR27hW/Qubxical79E0IFQDt2QdJztM+TV
         1nROYHgl2I8eDdbnbA4L3mpOTo/h4ILEg8sZChH3QbP+asn0stC6qd7gZuTVoxICjYYB
         EztY9QLx4tzeTm2Gc5sBUG2aZhArerO8R0fK1d55KV9uU5hiM4Zj1ol87U4OLTxiw1Vs
         q0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079146; x=1773683946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDreSjYEwoLVTucpTragxMff4MtZhsK4TyZGpsfQmdA=;
        b=oT0/RGqSsG7TP9/92Zy+EMwu48XOCQ1meo9os+WAL4Qjq9Le8BMtn38g+Q4eNu9EJE
         dqQ3xvWf+Y1awzq9emhczVhkff6XtFelxtSoTkFKEnYePT+wGRko4w4+dRxGh83PK+J6
         3eNB9NAqBFsCdPC3jX6tGoX5BJ9+AybNRTM1KzroxgVGfNoP3lv/Ui7QYlXxcixE7T8r
         8BRQGS9/lhai7sdIENaai2XrFkZrvQkjxQgJftcQXlcK1zTTzRr5n5rpiCY5g62wK4TN
         eBLeOoe5oiFTbzvGcT8mvs3DaQaoU4UubzcUjBzx5nZVeKewrJz5XW4YqnANC0dhcG/c
         AL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKH9oD/NfRvoL1EZhZ7l/J7QBDweA3EBYnwIOLeM7wbZbhT9uzMe5l78mLgIekPio9yVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoX7YmVSabs1hKzi9cJjPWHUeZVBTeSkhVgy93Gt4rzeFfdFib
	rWOjI01zP6POj2BIrhVSzVflq3/NjOQdSi5wDrESZvbXPrNKyVgw835hQco30/YqaTzrysu4ObM
	b4RKyLkNR2SDQhrSWwYwNSwcpKBazDwNXjUFL6rB0
X-Gm-Gg: ATEYQzyx/EgeADuoLO40YRvDisHaOXxbcgP+fUtWGzBjKJ3gyHJkoBtsYfqtB8+G6m6
	vaEYLDJnqXSZxIRzA87y4MMlfij2kg76z/M9gflm7u2nOrdTA/R2q+ivqwZpPCZFNCoa4dnfsci
	3Md0aY/gbDi07PvWmsAtoM0shRKNTlUcngPxjPbiZdp0Dcn/Nbhs2md2WDlJ4aH8tSJk8eYzxn2
	8R8IJbAHFcdL+OGfQuXyCWbQZxUitK9WivOlcheed4iHusjdWgpVt588AFTx9LkQE3+vP+42yqu
	a2m+gpAf2x6H457pjr7m0N/zyGZDSkHH8ps=
X-Received: by 2002:a17:902:d4d0:b0:2ae:80a3:cd11 with SMTP id
 d9443c01a7336-2aea311f196mr241605ad.7.1773079145133; Mon, 09 Mar 2026
 10:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-16-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-16-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:58:53 -0700
X-Gm-Features: AaiRm52uvKkGWQKOUhlbyvaGeNyxJc-w_yEiNj_NYeHVrpEtOTjr68aBFV5Bu78
Message-ID: <CAP-5=fXSK7fFp-=W7MavSMKbqpxffFSXKEmd=jt=7xhzvYt+vQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/30] tools: iio: Append extra cflags
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
>  tools/iio/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index 3bcce0b7d10f42208765be83dac047faa2e0ceb1..c189af6286751d141348957e4=
d63d33b87410381 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -12,6 +12,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS +=3D -r
>
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  ALL_TARGETS :=3D iio_event_monitor lsiio iio_generic_buffer
>
> --
> 2.34.1
>
