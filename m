Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB292E8B98
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079603; cv=pass; b=uCzGCH0uADethNn1kUIX91lExVyTVtnJuwF1ApjS+oC2Fzn3+Kn3h/SIAWbeSLdOOGDzj8NoCEXcxkTu03ZJEfXUS7NhlBnxrwpO/JmOIJ/QFkxf8FY9uQEwvpvtchUJ18UC5Rwp0aowmbJkF8yLWocl4QCWzRPrBSdzLMz7HQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079603; c=relaxed/simple;
	bh=5BCddBznHBMpCnfR4x7BgUbDIxp1InoJ/1cNZt92Udo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/XJi9I03Cq0Vt98RdlpDTYOb0Yw6Xh9bR/Jg1NkV0U9RPipzuUt2iKTcDGjgs34IM4ZU3wLIaLGzdK2Pz1vLb7bpjpbPQtxeSoJ5Yin2Ve3h1IxVz8ZAH8xF+WypKCW/2QocYBiSTEKcVPp6/a7lmFci9gbMQQf2dcwRJ3Nst4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNmsrxK3; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNmsrxK3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae3f822163so14725ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079600; cv=none;
        d=google.com; s=arc-20240605;
        b=bgE7SX9UXe16OdQ1niac6Ey1gYm/NgWeH42gTLU3EQpCtR/wa6fMLHRqnSSnFAngzQ
         yrGv+IJw0Y71lRl7Jp3bswL1AAxWqQb37APBIPFsH0brDpkdmDHQIIj9D3IMNzObRNq6
         PELEuQDLcVhq6pevGDl32ABKTXT7wkdaxZGOUN9rE2HYRBhwxkBBt1Rh/0185Ch/0HnW
         f20YG+AaDPL3HHS22mmcqSVCu3V3eVsmZYWs8vBHlEco2faOV5b1GXPPSgX/fP3ecSmq
         DbP/epObh0kHaZtrrXyVdy4gDHBryFdjV0YoLqy1S1pbXbd3iv4D+iBoKrG8B0aJ1CYY
         NxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AmKGpbY3mrkMMiWs2SN3h57jVWc6a6COL/PKyMDU0SA=;
        fh=0aCAa9ya+nQqpYHbFowPyJYLpKe5Bs1vkyTcESxW0II=;
        b=EDetDumkk163mBz2HOyTK1sYBskuhSG3yBdGgbL0ifUGWorjgnky0zAXIxOpgXX+k+
         HI5CrPcN6WsknQjin3JnMPAC/RJB3S6EEV+ddFY7apfhyVIrhfJnllT5y/6AUQ9u+Wr4
         eiKv8+0jn0sJzXUV1NLSC3AhUtpHWfriAiraLBXp2Jb22aWf9vqtxCx6jWjDGwhC0ry3
         q+LyJ1Ugw7jjhqaHysOT3Hd8N2gf93uvOPTJMSEqZbmyIOSNhzwAgEcrVkPjLoZJJwd0
         rb4yeFyi5YSr7hFXWEXmWiylxp+6HQaTX4ngjwDXZTzEpp1TaTUlV7GqL7897cWHpb5y
         8VZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079600; x=1773684400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmKGpbY3mrkMMiWs2SN3h57jVWc6a6COL/PKyMDU0SA=;
        b=mNmsrxK3yTC2djju/gid5Fyhgsxm3nY4UFdIqA5vnoGMHel2t4CGNVRHrdSeEydgGH
         uSx04u9NV7tyby4lVdWGOegUL2uCq0Stk8/kvyRULe+HdUFa0AHAkD5ShNPotXY2qJoh
         PKEPCjztm5FRUS4eMCyA+0cVtp70Rm6QFRsq6RxIBW3bUn5pZG4vfRpu8xffmAtmJDMP
         s7WIXi5eqiSlW4MEY4Neya06647nstYxpp/dpGVy37Dz0HdZgo7ba00Fje08ThLiLMTi
         o3Tz6ekaBFVdpz82URUqzhGF7AITvg5uPb6dFm1hHJCF4KOmU33IVHkvY76xZBzjMM8a
         3h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079600; x=1773684400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmKGpbY3mrkMMiWs2SN3h57jVWc6a6COL/PKyMDU0SA=;
        b=ila9JQwJy+qKTkbUFn2sUB5FWglkK/FejmDtaURxoDKiJR/wiaSuVpelRRuNP9Dsza
         JfLP2kDLk0c5Q7aS7xDf82oWhIjWE0FkmHeZPSeUvI2PaeW7PxgQk9PqjfLR7x1GF6u0
         1khVUiZ0VP4Um9YmOBdBsr62F2HLI11eZPCTIBJwkH/wYPU5YTA2n+V0PsRGVynQbgOU
         3tClJFJyZr361nXH2HmRff7nDYDhcYyO0pbmnCwHofbxKOURbMrh7UgCydb+lrKsOrZG
         6OoftCfuVhiMxiVsw9tfB26Jyp4zo5go9gRqXVgagds6RGOKt2WVNb5mK2kshLAAiDJU
         aMtA==
X-Forwarded-Encrypted: i=1; AJvYcCUh4EfmpTFvC6WvMmEReSvEEd1U8kBAqAh6qvunRKmqmxwRBO2jr8mEQwfGScWzBid5Ibc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Ra/XEr8YeH59ESW/QxHMRRKUaGLk3mxf/ZSsUuUYz+HBXCDm
	1O1vH8PZz+xZVS6PdgYaAQuUcvg3ApOydODmslghHqoxp3yqth651+KwqyWfiewpaYhAz9n508g
	ZK6erosGmftsanGSFshpLYJICtC5hb9FA/tS/xap3
X-Gm-Gg: ATEYQzz04iWKMMwrP4x+PcdkT/33JVg+c+NUbd67Xrqopj6H+AuvumtDydhkqLmluxU
	PO4jlS9I28NgAsOAwwTJhdUi2ISToJulHw+QvTp95L31tAYe0B/lFRBC8Uiz6qyRRCtMg8uVVbW
	UffAwFn5uHzD+tColQjRBKAWCe5R8GDvgmepyl9b8ZC35Pk6gxMhgy5kSpkJDKeDo6/NdZ1ZW1H
	IzNHAko51SZSErSEKEdV5bjy4HmggzOuo40mlaC6Goxws7If5jpbriOW+4anxkddLJoZL5le++6
	akv4ibHtV5vMXoekDxZ9wD6roV4I+fnxVsKu6y7F63EjPw==
X-Received: by 2002:a17:902:d508:b0:2ae:4453:3674 with SMTP id
 d9443c01a7336-2aea301e6d4mr356985ad.4.1773079599358; Mon, 09 Mar 2026
 11:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-28-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-28-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:06:28 -0700
X-Gm-Features: AaiRm50VcNaU0-sQ6heYDrcoPU8N1ix0gE-QK1YHwS_OqKqojBYetu5zksjNqTE
Message-ID: <CAP-5=fWqju3_+d=w73DkvdS4cnrfhnd48H2ZLqsSRkKxjh=dRA@mail.gmail.com>
Subject: Re: [PATCH v3 28/30] selftests/hid: Append extra cflags
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
>  tools/testing/selftests/hid/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftes=
ts/hid/Makefile
> index 50ec9e0406abaf316fba232c5da1967e27d0fa9b..d0dfa411af9b56ea3458184b8=
a81ef61bd44b1fe 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -24,6 +24,7 @@ CXX ?=3D $(CROSS_COMPILE)g++
>
>  HOSTPKG_CONFIG :=3D pkg-config
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
>  CFLAGS +=3D -I$(OUTPUT)/tools/include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>
> --
> 2.34.1
>
