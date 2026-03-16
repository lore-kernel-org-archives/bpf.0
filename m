Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8031C8634
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670645; cv=pass; b=aAyyjmKjyEiTA26J+aRAVr9FXXtc4OJ/qwgKBLvmSLPdzCBhTflXmlwKSzX5iZz4C7Z+abN/fyXxvyzuRj6Ad4FKECBOJRNXjr+SSUBzlNO8cHyt8skEhGDqmlcaOB6oSeJW9W3aQFs+S8mfcNA6xRAnezJW1SqlksiQYP3Bwck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670645; c=relaxed/simple;
	bh=5ExJGKQqqkgOKiYAl01vajNqrVmhutAhhk5RAfQPwdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uakVjaa8wjyMi/szr/VlL+FMVUl2Ntfr44Kn3LQ78XuIqBAfjnxcNMiEyom5f0bwVwBf1VjEeGn1C5AXmZgyllNUkA6ozndQs9Hs3QazVqR07EaMCWcaq/kQseEGKeTulifqAJgrJfCWWX4i1v+dxHqbKrSHLV0j51/QrgDNQLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUc/i+b4; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUc/i+b4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-485345e1013so40487795e9.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 07:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773670640; cv=none;
        d=google.com; s=arc-20240605;
        b=LnOaJQWGKg8Y8GBS0jnJ38YEBslmGMdxWC6bRLgreTizONxyvNLY3pitJDk26rSItT
         qAbprCuSLltSvv1PBJsJ1dS2NAZvTN3WnOKITkXPcD23UqQjNmENaKJqtobgKkwnZ5fJ
         87ph78giCV7nDl3RL5z7NDOwNPKeYggtbD87R2/Fr8tlHocK75+cntiIOCs9KpAOJ3QG
         M4PLDZMCepwbsbx/kttXNG5afVPaBPKgJybhEHxdfGUgb1Xdg7QsQhrbi+WqUY1AA6b5
         B5KLOsvKdMeXXZIDJtNjrE6Hnrv/pL08iqeyBEUBMr1eHrmkXS5iZj2EVUWPC8Tjt/8R
         1X6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lmBn1aXsKzUNTVIGoWkY2AXVOYef5Jy5uJj2KWu6G54=;
        fh=A+Nmk0fbWuOl7D3aP1ypDVjf1uSFBYYAzEnl7B+8X64=;
        b=luT8gKR45gQvYpUJ56qPm9S94+76BoEec7QEIDaHNj465E1CvB5mXYUpPfXqBN6KOd
         pujHnKTafZufo4SYctQp6c9uD/Lz9pqUGnTDlJA0qye4fjpSGx9gp2pK1tkQf1dPwzHG
         cC5Oof8MSQ4BQOElonhBkO/0uNyfHuFaPc4GKyOFQT4dcLHAo4+2g9y5iWO/6sgLggof
         6QDwiV1ud9idNv5zgNlzXlXwj9SMIstwk6FrSQnSheba8V7ZedU6F9MgtG5FAVZFPBkw
         clQslEb4g79dAyjpygI3s+8fDtkFym2tEywc92FLyWwl64ESKArTQBT+vrxqcm9/oej6
         xIOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773670640; x=1774275440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmBn1aXsKzUNTVIGoWkY2AXVOYef5Jy5uJj2KWu6G54=;
        b=MUc/i+b4a82D4pWwB1wRLJI9NT/+CBuN+DxuLbm8D2Nob5nPTApzb3pf61dWc29JAW
         clnvek8WcoUN7z2tvHsy6Wwb/dlApRwjGbn8b+FsXL+PUqpJ176ibsodV+7pDysEShQF
         WBLTfNfZ93H3Lhzexb2Q58oC7eBKJ4JvYAvtgRbifdqwDPzcXddYBZ/0yQJELwGMVCTS
         ZVBnmOER8xL3lMlqkWBypwyFbeaZXqjX27qoOxIWs8YluIc9f1yByJ+izVCIcItO9tCD
         FBuKeqv83UWA5Qd9Bl1bpodbdZh2MSuQ38vqIqFJR0H0Mvuj0OgA+tV/wcuFUhQvn8+Q
         2Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773670640; x=1774275440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lmBn1aXsKzUNTVIGoWkY2AXVOYef5Jy5uJj2KWu6G54=;
        b=fG3aeTNOrHV/yvnbMlO0nITIkrfQzM9kiu/y7Z/tD2ugWYpxERT+P2+hIQUHio1fLs
         4LA2FjaYBqgp4I3FdpJXG2/HS65o/pHutYUldRvAzJRz2by0GKveX19Oo/GUa1yb4MNn
         fCydvGjjb9bQlpnt2CHBfkMpBysR1oG9ya06JIj+ZP+BfZ2bbrxw/8LLZwQycrkbDVnM
         o2N6lmEMe4HqtM1wbXSscluuaQnIzDORlrq8Uzuj8JXXrKGv+ylIlTS9N2lEPNEciUQc
         4eZRn+PKpiPGm+gTHoNPtKKQ/w43i0o2jxuAgHIzD360YTDajDBHx6SVkr4mHTrlGdvF
         d6gA==
X-Forwarded-Encrypted: i=1; AJvYcCVErcxRBJZsX0rhPXRfE/UFb1LmVSBtnOzk3dEmoE9r8jZ9FmYcQKQgAS2m+DNojks2wg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwgjIYdTvc398LVfDd4/PaSFjbZkcC5+foDodRlIh8PMGiokm
	UmdLKhQmgYjnpXtQC35rVOEgcvznhXawo3xo7ZhFp8phmH5aQ+iEyMkd3B4vRz4oCv3T3QYOx2y
	m7nBpFX+uJ1rZ699R8m0n08i5T+E41x4=
X-Gm-Gg: ATEYQzxjjF7DqgW4aTzeDmnkaanOcFP2o2vvT6/XYmGU6ebBpf9isWQSYvOVEWsuafP
	R23X4fO/rTPpMDDT2D5Tu7nh8vZdfEksD48RdnovrZ8ufQ65F3Qa47I56oU+JbpftQRkKEiJzG5
	ijiWVe67IPuJKXDKbBbj+8phhbn+0xlafqXnv0QdII9WUBpVSQs6fYQ2l8Phk9Jwtfb0arwd1Us
	uSzxzdUyxgYBtIdVQgzpNRTF9Hf3q5utifA6LBDnFH4UIqso58GgV+50xCmCNvS4CYuG6aSmDWb
	p2W5XxUb9L+pE8w5vRlv1T2NHBuD4RFTpVRCYkVYlkP6VH1eItTwPqYbZMoI389fvGxCdOGP9Kb
	TJg==
X-Received: by 2002:a05:6000:3109:b0:439:c560:bb78 with SMTP id
 ffacd0b85a97d-439fe1a069dmr30731666f8f.22.1773670639789; Mon, 16 Mar 2026
 07:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
 <20260311-tools_build_fix_zero_init-v4-7-9e35bdb99cb3@arm.com> <20260316101800.GB8048@e132581.arm.com>
In-Reply-To: <20260316101800.GB8048@e132581.arm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 16 Mar 2026 07:17:08 -0700
X-Gm-Features: AaiRm52U4nGYmhrhg5_rJVsmWgv2fI-zySEYrY3v3DyOI4rw9kmBbiG37OT5JGw
Message-ID: <CAADnVQLN6bYHnusnC5QnDoGGUO-A=qnM6fP9bhEVXEHD6_y9EQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/30] libbpf: Initialize CFLAGS before including Makefile.include
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kees Cook <kees@kernel.org>, Quentin Monnet <qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, bpf <bpf@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 3:18=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi BPF maintainers,
>
> On Wed, Mar 11, 2026 at 08:29:32AM +0000, Leo Yan wrote:
> > tools/scripts/Makefile.include may expand EXTRA_CFLAGS in a future
> > change.  This could alter the initialization of CFLAGS, as the default
> > options "-g -O2" would never be set once EXTRA_CFLAGS is expanded.
> >
> > Prepare for this by moving the CFLAGS initialization before including
> > tools/scripts/Makefile.include, so it is not affected by the extended
> > EXTRA_CFLAGS.
> >
> > Append EXTRA_CFLAGS to CFLAGS only after including Makefile.include and
> > place it last so that the extra flags propagate properly and can
> > override the default options.
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
>
> Before sending a new version, I'd check if you have a chance to review
> the libbpf patches.  The libbpf change is crucial for this series.
>
> Another reason for pinging because I received a bpf-ci report about test
> failures for this series [1].  The failures looks to be unrelated, as
> the tests fail starting from the first patch, which is irrelevant to BPF
> code [2].  I tried reaching kernel-ci@meta.com last week but haven't
> received a response yet.
>
> If bpf-ci testing is mandatory for libbpf patches, could you advise me
> on the correct workflow (e.g., whether the patches should be based on a
> specific branch)?

yes. It is mandatory and libbpf patches must go through bpf-next tree,
so pls send them separately.
