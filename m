Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB92D0602
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079654; cv=pass; b=jgDaF8Xb/hmmae3CbMGdgz6HJJOr3IgXjy9s+2LUPdeHex8T+gRDQaOvcrJx949E1uodfnwNj53MpWujhPh2FvK/vVvqtsK+pOqqpWh0eZsvpFBaJLoVKTa3FnmYF0N9sYr/V8pxf7p2aRNOOFSwPJo+//eLYR/Qr1fKp9biDJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079654; c=relaxed/simple;
	bh=QIMNB5EyqX39o2tFyg9pOLQaPD6ckffxKJvkpme5m9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZBBlD+SoV4ENE/mYOMLSbE3+ozywIPnxLgHqLnypafsNfA9f9Cizo7Q6fQY5ZBoJOIRPLMNUvUZmkoPQ2AYlZxfpXTfwiI8bsr2x9rpwn9Z+Rv6OmQC7WVh5xxfBBD3iLudGO+5SPpjlOc9Wxk8+hILz/p7EN+ptHltmQi6PW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dITMcj+I; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dITMcj+I"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae49120e97so18815ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079653; cv=none;
        d=google.com; s=arc-20240605;
        b=DOdCog2GRWlcgoa+Py2mmvoagTAogsChaQTYWhVysVypjE58mnXucgMet512ML7vXK
         I164GYPcQVTaD8paCWIbwUF14T0djV8mSUPHmFWMziyUS6NHQiWMUF6MFjz0vwoTgN27
         9mwyi/3bA+XMf6oLp7mYItfJHpKXcdvJNgToflUcxnO/WBzREWMO9r1fYUABAWhvQgt1
         UEP3hAf4L+lrRLKZ3tUIOme4Wwnkcd+OvseO55N8GEMUQgQUtQPue1+TBPrK4l0fIv2S
         n5ckf6i0mm/NzK7eOLBPlAGMVaLfm9EfsqDJauhFyy9YTItvIBry9hY8BOUG7vQWFr3c
         dzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8TSrNRaJmO51nmlmw1NUXrIFdMrsiQHCiZF8RZbGZ8o=;
        fh=4OpjJqXOocGPiJz1jD8/DxfENDerbSmIV37XB6w4HmQ=;
        b=lZpA3gvEyDgDYjIlPSb3jttnoSWNedPUFEVa/WApu4QdSiJTGEnEzqNjtUoIAOeytI
         H45b74Y6tBwSckMxWjzHhcl9DfhmFnCTZ8IkGsE+1V+IfUb7bqBbCLa76jozvQwk8sUH
         KHE090IkQYyUuU4+jBRcT+3p2Ow8L15zELToe8fGw382gVVd+KSBNZ0Rs0c++D2U2W6w
         YxcucpjC9E7RjIGG/czvmwFBVGZEerwbrFZ7tI2xaGeA7ziNEcsCArqGZ0IfNw8FoRRn
         GSaQfeB7+rtMARp8lfrCb9KZjQ4/FOpv3ccju5hLlJ5HUA4SzIZxRFv/74r6ldOVZp5D
         K2hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079653; x=1773684453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TSrNRaJmO51nmlmw1NUXrIFdMrsiQHCiZF8RZbGZ8o=;
        b=dITMcj+IP+X1pNDLQlzbO/2Br9TEhFRT6fvRvGnSdpfo8105ue3D5YuFUzfORKIUR2
         8exPwII8caUYFpgVnBptMqd/gNbrLduG8jLq8oKnWCkanuKHfPsCmRK7CA2w8wuZSS+w
         sGqOYYxPQtJElPE6D9nNWXQ7Uz8nfTicxQlRAT++ftptEd9ozJOjZ/xxSwjkQt9/nPcC
         QxNZ4bj65X+XCvTm8tv9s6UJivX4A9uroRHHgaLVlUfI1w6YuArFopcF2d/T5QU4gJ3d
         GIUGYVOUkl/wLfgA5BUCiavv9Wy/BP6W5KABBryaUDzIRRgPFYa3gCzFGP4ilbvzTAAo
         o0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079653; x=1773684453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8TSrNRaJmO51nmlmw1NUXrIFdMrsiQHCiZF8RZbGZ8o=;
        b=mixo845RO6uaKB0rgRo4dAiQgAxWkgvfV+n0NV0eey9Gg4rTbMUquie0uT4gVOk2pK
         o3rrvuQ1S7OQ3l8ze4tb0FaT1g/LWtQ6aJAHznWx93bnq2V3BE2gOYLNRxxZg6qHXObS
         8okTTVbOGCUZLpONz4gn5asIxrH1VMhmyRqF12etNNfhrGtQZWsVDRlL/EWgwMfJTnc2
         KBKh1Sw4og7zyOyLhGJVThlev3GUSEgwOQpvwCzuYdGGTcbAHu2mrJc49ONrzSo5ziGa
         8Z0nUYluCh0vNk8UQcHSZk3a6vVGG2NUAQ9DxtL91R1w49fCwsCzCjp5ClZjnLr/BMxy
         fPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0BCQblNY68NTsOnqlm5jBD/cuhlh7wZ85P3YXu7a8Hd4lO/Q46fOOJY9/6l1Ioi9hf88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpsIjWlO1U4NH3cOxFEsHCOAxiLjfh12R7r8sJdDASajoDSnmA
	yq7ysrzbeVpMsDTQqlZs8kw5mqWC8SIjLJiS+1D9ZoOLthEjPGtpqSy88BLZswV9zXICZKzp6wy
	VWK1wY9q+Oia1uahSxxR+S14DXxQWwxPnS54Mz/6t
X-Gm-Gg: ATEYQzwgQJQvCQ/aHT9yfZCJyA1YRV2zxH7PCDSkYUTC27NzhLfr64NTfHb6LrvwvYp
	90NQajPHj/BsTBvGdIyek51yNZj0unDzpxPLCyJ+BCYh3pThiXsWBlQ3PrTJQEZQnDrE0KmnlCe
	dJc3q+NLaWRPXreMbGF0B7Hl5tAkk63+KprhAthPLNXUkYFt+UE3WsUWcJc4n/Kn66K/6MC2KYE
	kzL2ykOJqK1lCZM7hKax9HsSKmJqT8Onfg6pTExfHdw4/DHPgtYslQKeIHdNl1jbKA07YdPqZUF
	G/VGmFLO+NlzZhI7KC7s116h8xoSLybu32M=
X-Received: by 2002:a17:902:da91:b0:2ad:ab68:f2c3 with SMTP id
 d9443c01a7336-2aea32679e7mr214325ad.13.1773079652084; Mon, 09 Mar 2026
 11:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-22-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-22-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:07:20 -0700
X-Gm-Features: AaiRm51tQNQ2inpIlTxQfShRsJQdMzHGmNgW_x5TCtZwRMueLBJEPIayhaU2J5E
Message-ID: <CAP-5=fVp5LEezSpRaTZTH17KjkFBvnDLqonMDa5Lm7O7wHD_Bg@mail.gmail.com>
Subject: Re: [PATCH v3 22/30] tools: sched_ext: Append extra cflags
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
>  tools/sched_ext/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
> index 21554f0896923fa9c2e5b98c85d65d964152e592..7b97af037ae55981bc84d4a91=
40766fdf4c62a6c 100644
> --- a/tools/sched_ext/Makefile
> +++ b/tools/sched_ext/Makefile
> @@ -89,6 +89,7 @@ ifneq ($(wildcard $(GENHDR)),)
>    GENFLAGS :=3D -DHAVE_GENHDR
>  endif
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)         =
         \
>           -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)                       =
       \
>           -I$(TOOLSINCDIR) -I$(APIDIR) -I$(CURDIR)/include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

> --
> 2.34.1
>
