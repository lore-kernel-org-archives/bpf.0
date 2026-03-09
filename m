Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408AB286D4D
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079376; cv=pass; b=jBBHWPRNOm8xSZJTVpnYwolf9C+fRM4v+qDvXrW02wACAGwI/qzjiJgITGy8+aDCWBz+4RGWbsDQl5pkAY8vK6glyN/D9zzE9hXuRI/Uybc+ypRhnPRZg8IMgUWbmGbclz3OPvdQ+oBxJpB+HdRPKM908uX7ZXdaSrHF1e/yP6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079376; c=relaxed/simple;
	bh=enJJBtiy6q9G9zGlhNtJO7VBcncRme179U9y2TQsR+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGlhJPY8ZOyRGWkjyyk+2Ts7wOVZ8gB/bsE3Eb/WUrRytu0/WXD7rpRPB4BBjApfP6gGsg8pj4BeOMHZf8mJrG7Q6/VUbrTSoba5Ae/oHpYA1FSKECc2bK2IXSDcuYQNwBZwPV1ddB36toNwOS75aiy8J2YDMIuwoAXoBUw1j8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0DUiDaRL; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0DUiDaRL"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae3f822163so13885ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079375; cv=none;
        d=google.com; s=arc-20240605;
        b=TrNU6acxiWG2hk6nIMrnHATQfb+Tm4xuBBs3xnLTfgGRJRC0AD2W6RZ6n8IuiyngvT
         dUOhy/hNru29Zf2II66YM6uK1igb4f303KqaIT8fVx0ipxZsKZw5tIMPicLgAG8XKcl9
         yf7fwMlZ2+Woe7o8qbUhG+YSDkXjOZ/1sC5pXPtXCLfbmXBRPHwsvrIoFskCwf2o9eci
         bxcYNg5ik5qrGlsWElMjyd8g7x2N8mmP++YxovbONe6CznAKVnd9mbC6tFnRDWxYYDGP
         iGPXpiwWdsHV32cmSsoxMrnkPg+EjSx3tjv+TIOdTqcRU72OhX17v3nm5lwdDJ5mWkX2
         6VrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0DTQx0tSE71UMF6lY+qr4IIE8EQg8d4wRW0tM3/p9E4=;
        fh=Ih4jhs3WsPJKEP+ecYBc2YxNqPt3IQsvE7Ys+BubrM0=;
        b=Z8PiidyTRswr6lGhy+TlQiMc6Rwnu3HlubhZSvXdars6+hjwqiKZgyv+hTZMoBiyJG
         9nUg5CSf6rfeXQBEP9QXNcaQTDTPfUc3PkHFpP115waXHsENhFLgmtPdzyjbrrftQxDo
         HgG+I7wp+nDSkabkVFjjQTUvMPjY1imSM+l1Bz22UaK3p1aunSrk5OW6aIuT3jML2U8K
         KcIN/zqK/m/R3B0mD0fDQ4+N7YKvvf9xQ6F35NOm2EasTxqS8dNiE+fvdC/0kU/XCF6O
         7g7R9p7MG59H9uQKMvOFc6WXD/K+3D7owKJtqDW27KkSXP3LqxHvo1t4GjB8g6qfT+nh
         +mCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079375; x=1773684175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DTQx0tSE71UMF6lY+qr4IIE8EQg8d4wRW0tM3/p9E4=;
        b=0DUiDaRL3bxMRTyUwQ+T4IGsTQrc99q2+LHBjEjAUPnDoGyCwJQjIuk6h9/cfPEtg+
         tzPCyZ5UcDK1dHhyAn67IxLpdctClhpYzP5vFBkWlnMK8T5V5mDJw8hONtWjX1q4poPP
         66UYCgjd8GaVgm52Jcd3Z+oCITavUjh08HRSfVX/R0glyWx3rKYkGb3QnIv8+5zrF8SO
         fmdlor3V9asiDn9hI2XsfirnON4ZDTUQhgkXXbKHjFoPg5mWULd/H7Ea+lWCSlLVDkeZ
         WmApiK5OPzVY/guqpJDeXLBKvneFxn8V82yLtceHg6Kb1isLtsr+UAPzTQjfmcaR4Ei/
         d32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079375; x=1773684175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0DTQx0tSE71UMF6lY+qr4IIE8EQg8d4wRW0tM3/p9E4=;
        b=otRk1hrDCDkDEJSD+Cc+DQkZi6aQcqN3MiWCwgiZZMnCwCXXMNL274P9rrazbAXu7Y
         iDouUlQq+YPiERwwqw3yV/r93QftTLN9iHOsITNaadfOxIWbpZSRj0ILG360v0deWEFx
         WPetqpIoKRm6+aRkTeG4noDfEMEy1EKrvJK0aLfWCIAI34h3ArJZeLkgFftc8uM5h2nk
         mE6tFUHRbyi57tdKZn2UIbHitdhJGlBoNTImOypoB3m9wDgtVz71stZAuASD0pdDrSPB
         RtaOzdCTgNiFoVAv0YjjRDzFK60TwCCMUyU4b1QZSHkktqc/QfLbGRmu7ULf845Oh4Jj
         B1og==
X-Forwarded-Encrypted: i=1; AJvYcCUWQMLG2DED4rActcxMojscp6dfen6WJJ7RM6OCeDOF7AvoYncEzbPXLPggeG0+d1I/yfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtR67qw2fM8b6Sztz7uF4201sgH0Bg9rhT8Z8td2361SbY3fV1
	OVYwKgp+mgWjEqepk1OmctVKIu5ICsWHs1yhtslQDANTY1Eb8XkRiXvUXnxY0ruxG20Zc7EuuE/
	PjLKEF7G7sdz1wOd769akaPRIfc7NPnkIBOyJnzzZ
X-Gm-Gg: ATEYQzx2aYrhDeDsPLp73ygcxzv2xmKyZLuOvdA3lHxqX4YbgfNPQXHBBSZlZvqT/p+
	98zc9hWpR7Rbr/Z9iWbKovf8XuVyvTgKoLsdBoEoKFNwHYHij5WLDmBy6BNcm46clVxmuKA202x
	mstrAyG2ptU2lwgNfen6yT87pa1zcSvnvqwR/YodGDB1YW/9Zi21r3lDkEs+kEFxKzzhy9k9Y2A
	wk1qP6/LHmAmIGfmTdViBxFb17dsytB1LX/3B2DPqt0vyDsIF38PenA2en9EfmN/PfF+qjkgUli
	ZA7hMLIwpVr6rnQ4Y+Fe5NEQ9yox+QUa0tAYkZAoD2p+UQ==
X-Received: by 2002:a17:902:ecc4:b0:2a7:d266:d84a with SMTP id
 d9443c01a7336-2aea325870fmr266715ad.17.1773079373978; Mon, 09 Mar 2026
 11:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-30-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-30-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:02:40 -0700
X-Gm-Features: AaiRm53fepCChw8O6Lh_i9zc0Lx_aXs0tJ85eByc_82LQ2DVnvOinKgsctHPHWQ
Message-ID: <CAP-5=fW+8BXLMXKyZ6GLUq2it1VTVpCg61qCqpfSMDjHeOJfXw@mail.gmail.com>
Subject: Re: [PATCH v3 30/30] selftests/sched_ext: Append extra cflags
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
>  tools/testing/selftests/sched_ext/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/s=
elftests/sched_ext/Makefile
> index 006300ac6dff88a48104977398d8517753e7e385..81d8f4a184245d8c330cf45b7=
5bd868b2a7aa7dc 100644
> --- a/tools/testing/selftests/sched_ext/Makefile
> +++ b/tools/testing/selftests/sched_ext/Makefile
> @@ -53,6 +53,7 @@ ifneq ($(wildcard $(GENHDR)),)
>    GENFLAGS :=3D -DHAVE_GENHDR
>  endif
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)         =
         \
>           -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)                       =
       \
>           -I$(TOOLSINCDIR) -I$(APIDIR) -I$(CURDIR)/include -I$(SCXTOOLSIN=
CDIR)

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

> --
> 2.34.1
>
