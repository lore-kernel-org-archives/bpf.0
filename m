Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42152E8B64
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078810; cv=pass; b=VI0rD5/O6FuVaTxzZPULDaDYCGg3Tff9a6X2R90vdft+aYsEQOqNYDxJEvHyAYuxuOMvKTEgvhUXcFj21HcfBocVCHTKE8AmY6EPIKq88Az415TBQnOpwaoP3OUBZAaqobqA6mMabhOF35bq8nagz+QBNgiZKj9h5yOlYRRXAbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078810; c=relaxed/simple;
	bh=SeWt//XSlE7FH97wAOv/MRdhXb4yjQFM3ji/K8xaQqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGY9yc9nqD/gR8lNqoY+aZq5z8xxSydjR7m/qyBlZ7CND7MflVNrMemcD1ebO9v52T5+JTAIcGlrYIagWXPMqmSb35MI3tvanah31G0cLjvw89x+A1CiP19oe6CpQp2m6QgxFm50T2oNmTSWf89OzUMeEST+klT/TRfMtPPfosk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y/fO9i+E; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/fO9i+E"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae49120e97so15665ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773078805; cv=none;
        d=google.com; s=arc-20240605;
        b=jmutcBat2jQ38rA/B3RtY4hdidl0pZYcb0WTEAIleLGe5UcrV5fzS7mUiGVQOeLbKc
         hK8C0J/STb5JgwyOpguqXUo+12labC1GuwkcOQOF5yCwDoHUz4MyvLvz8GviEzjcZx8T
         tgLi+FDU+IK3yxcVQjHFJazay3vMgh5HFAWX5cLY2MegBjFFQyoYYP/SwxH+pS2ZIEoe
         YTNDyPVUyNAtK+WINRBR1wnL53c9nZZkKlMgDbSHOkO3bqrxOGj/OZouU7SGyRUDqliy
         RZt0A3gV3dks952P9nwkQWhaXaMdXC4O55TIrhKjcAJfb27EcwHhpBbpIM6dpdcMR6EJ
         jTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZPvt17sBw48Uy9b6qgDNm1YzVe8WydV5Zk9wwY2Hrr0=;
        fh=4xLTSDYn+PduwzrfJuorclGqaOCSZvSfNl64IRqD5kQ=;
        b=ARMxby1z9vaFGv4FK60sJblimRYZnLAnc1w+yiW7ZyqA/OhHJOAC20FoWsPqSJAtZJ
         DsHfM7oEaX7oYv0/fJP840pUuZez6mE1cotzamSXnumqJ93oqTOk2guNNOuOyBs4FCGz
         gBr7gmvFKXxKWEyVVPMjKnjHwCB5eA5CYubRUDd1nqrqEQnKT3PuoBPKRNXOwPM0NMfR
         AqfhPZHLJmEicDSV4GYFITBup3OxtgbGsruVSsygQ7UzoMFOcSsPQv1lQJnK93QKmOEk
         86QGTcSvMGDgJEUnGZhBN5ufSPl77q01DqsKpWuUx3nAKufRWnAHu+Ta3a/elsM20Laj
         uLIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773078805; x=1773683605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPvt17sBw48Uy9b6qgDNm1YzVe8WydV5Zk9wwY2Hrr0=;
        b=Y/fO9i+EVobtRUdlgy12NnwkYs07I3cNqZngk7kvG97Pl1b7nN1wezhs1qvbQqE7sT
         L0bxgyrgsfbRgROFZZzZfUTWwEA68BsPXAA5lspoOfhNiNNzBhRGh/0cUPEfqZj5TNIn
         GZWsReZH4o9W6qFuZUD4Z+t5Rd4bSR1sG++UKRqdRZ+L/VQKwpbeHnw8ih9q4SNcr76Q
         3SPDBFWELMERQMNsXSAlWsv04sLE1C9tWGdz1bcbphex84NmSaYEn68W78p1kC8SPz6/
         G/QJ/FnCdfk9ePA17+IHT78XC3iC56as2tLtNMDT/r6qSpWNpf/d+w1+a0MdIIzvP8/6
         6LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078805; x=1773683605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZPvt17sBw48Uy9b6qgDNm1YzVe8WydV5Zk9wwY2Hrr0=;
        b=cjkNj0jH/FLBuvSojoKZaQTyphtycNmAzo3DiXqYNU5ys01//+BjxWiNTW0AuQgQPU
         nr2/oj4LwAIgtlmC2Q8RoTOlu0K6vmIJH+QUtDSZPbh4GhJ9d4cwCGJ+umGd8UWRv9tZ
         b2toIU5OYNhqvc9vtsXBMuYkWUaX0d2I03mJ+UP8FkAaJL6gHOoV5IZlYZebcu96uKTi
         OFIuGN2LacE0NGNgdMq9TJV84Dw1UxM9ej914X6PzlZ2gjwdHxeG27V7v8mNJOENPY7C
         k6d1S25MMJh7v8MIS3mq4TKjvPaum47/MFlNw/rCqu+lnlSdemDxjM1FBlCrSvEY5Q+y
         TETQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSPvkjEOUtainuQDCZ+eYp2EAtdd7T52md3Q8pwu7t1nq0UQg4g57wiBPPBM4o76SGkls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZoYOCEC+mFnRlRqrQzukDNpocrdEed3/uroETRJzxd8RokTn
	k7XXdje/4S/ADBhi8Nf83tR3+EDVi9Gz/1+LiGijIYhpj53BHVu0jsutgni7dSL0RiOlmexFVm6
	S7QlHdDJnmfmJfDI0GR2zth2+zRPT6A6CgzJYR9eJ
X-Gm-Gg: ATEYQzwNvz0m1YiY1QIIIPzlHgWt1UtPw1QK1Zkdn+iA428wqmlSbQM/O4vyuQJw+1O
	haDGfab1nTrVisNX3P0dFb5TbVcdCfxkIC4n3c7CZStVWExhP8QLythWrgp2gH03csc1o9J7Zkp
	9MncsExyAzox/5YcYPQaEejQbC6TXdvteoFucxO5KUU38UlwRGSeOUPvvjgqYYUK9ACmpVMZOKL
	BpLBrmGTU3qIxLY4/4wVXFd559sRETIA96xgNW/7fBnwKOCQMs9Gt74AARh+0z1WGJXpgNAmdqC
	fWHdHs0rFCwaEOlytFrTgh9HE5NC7SM85OY=
X-Received: by 2002:a17:903:37cc:b0:2ae:46c6:e4e1 with SMTP id
 d9443c01a7336-2aea30cfc85mr220315ad.18.1773078804518; Mon, 09 Mar 2026
 10:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-11-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-11-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:53:12 -0700
X-Gm-Features: AaiRm51jJv0K2rf94QzPgrcYebl4loRMt-0YaQXZssGW2-L2HjxaFLVTS-jTCdg
Message-ID: <CAP-5=fWHe0JaJ0FPm7jKfL4YMb8y+o0YcnOfSs=DCgHyNsyYyw@mail.gmail.com>
Subject: Re: [PATCH v3 11/30] tools: bootconfig: Append extra cflags
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
>  tools/bootconfig/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
> index 90eb47c9d8de67b0ccc74a8de0af3a7e0b97feeb..6bbf4dfdb5b56fcb2a43ccda1=
8b59a270778267b 100644
> --- a/tools/bootconfig/Makefile
> +++ b/tools/bootconfig/Makefile
> @@ -10,6 +10,7 @@ srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
>  endif
>
>  LIBSRC =3D $(srctree)/lib/bootconfig.c $(srctree)/include/linux/bootconf=
ig.h
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -Wall -g -I$(CURDIR)/include

Should the EXTRA_CFLAGS be appended last so that the user can override
the default CFLAGS (e.g. switching off warnings) ?

Thanks,
Ian

>  ALL_TARGETS :=3D bootconfig
>
> --
> 2.34.1
>
