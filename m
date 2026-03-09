Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E143ED12D
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079337; cv=pass; b=eQ98T8L3rexzHQSiolcrpltXA5XNakl7e/VygRhalhQxpi1WkFW0Uy3Dy/w+Hg50Y625E3TsGp1dCvWan5WFI/frNDjBVF+2AS5fHwNfhQn8Hj/f+B9TIWCBx5AFRcjZ2dK1aCM/vkRMBRY2j0zH+FcNzS7ejKAnOnKibMqq8YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079337; c=relaxed/simple;
	bh=sXd2n3r58atsTHalU8kH+eYu9sbWGdifgWknmudkZ24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JW2JsuMG0RuKL3u+ts35wF/UhU4F+TDCzEvN4ceGljTNpSl/VGOcmoeGpbVAKkc4tMg2T389i2rq4upeJjsrIP0U/ayrCdksKIVBCIQmXLs4Etjz5gubbtj0uT9/ihr1d2ZGSVc8mewCopR3/yx/GFVJjmTnm4aKroC0VhkSOnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1pYvwzqb; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1pYvwzqb"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae523d54d2so14895ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079335; cv=none;
        d=google.com; s=arc-20240605;
        b=QGR/Yj4NJviHu0ToSd1FXdS3KfkwTYyQhdc5zlPKd81FqjusqxI2IcfyBVn5U6ntJe
         Fg8x2Pmf577tyyXtI7ZGVWzFGW+zB6yP/FKhgGMop86PNVKZVsZBdxvrawq7eZXJBlRR
         Z5AIikGgTBiOfWffpaVFP3wQmSprL3o8qi1/xHVERn9ymNNhG/q8pcf6jbaIVyn3j4n5
         c54Cov48Qi+n/PDcIbMYUDZiApUa1pu7Hyur1yeIiTBzQl3pyX9zZxsfmabwCAWQ2k5Z
         PJk8ViqVFDtzxNWh9fSqJo4Debf1EK9+0yXN+pDvmUCCgz9e7piMaIXFIoZGuFgFlFBa
         ueXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3LJscPu/LCmEc0GMnCIHYIEIVJSUttXk0NscrVDqh4U=;
        fh=/2LczD2Gel7thP7GRzV7ElHZ8duDUKbWI4ZOgWKb/r4=;
        b=KMwKmkg173OgMUEHckQ+CuDSkI1bVNIiojbBh5nzRJqIrX+KmI9YrowkUTxC6bvP6t
         X7Bn6gfC3/dNKJSTRbklolsLblPrutnL9gaVzTk0EwN+oUiNicd/75DJ0Qipm8NtrCeZ
         kd/ASbPapj3rA8NnCTS1Zgx8iUB1ThHCbnXbePRLP5dtL/vexK5/3dEZxuNmz88TlcE3
         fVx14mvVh2Ze9eq6XCGMPg6sGwoLgEoI8Kq5jRxOYBJlXSH53oIWqtsTmOPZ/f0FXjYY
         mnmcOs5kI6UJwOhEHqP0eeub+i8VHmfEigJBjjODujqmUnKWN3sop9yYZko5g+QAuYS8
         2QoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079335; x=1773684135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LJscPu/LCmEc0GMnCIHYIEIVJSUttXk0NscrVDqh4U=;
        b=1pYvwzqbxIsi4b1//rsj9ww80cW6ue8Q37z//Oqr4FMhbVJGhrBTf99Q+wQobzmcAK
         r7M1xwYl69ABFuN28riLdTtC4zjCZegKehewPua7S0TY1b7pwrqR8FyrVfmc5tv22ngJ
         VyFQV40sjhwUAe96xBXBv+W2OszKkCFSY0NJg7DXpyZo7KqeFBJr89i3/XZNfNHDB7l9
         9TXJu0og9fUzELT89y4lBH2KCBu05HdKFB5QvrwuXBcRqNK2UTwqlPRudj7+IHQhrQwm
         EE+/8b4tTzOKSSyzz45Kll1dzxYtmu5wpvQAzkRhNbkylQ0lvuyO2gV5MZxKi481jm1j
         vx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079335; x=1773684135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LJscPu/LCmEc0GMnCIHYIEIVJSUttXk0NscrVDqh4U=;
        b=agENopnP9XsZCFg3SE/oq2nE5BjQhjFTsLNvJ00ep7t1ra/V35gsBGpfNxKRoDIyaY
         b5/UVfk6ZsUpyZV//gATdF/K/Onyeow6JShZKAs0nBMU6JcFTtc+Eu+kolgSA5BuW7hA
         hkiNTe3oWmmWEh9pv9AuM/gZ+IUmuGRUZY/7gzaECu9YKW8mv4jwmfet55qdjoD6h1YX
         4f9vvQlXkUAUDEWUgW68VLW9DAlAW496U9+Uo3oIjvrPPAsXbzSh8/R2OgUHUmCQBTks
         90LPgTqRnS9yilZbaVWvQz+Q54oJDTMC/P0IISYBoy4Zs3KkqwSE9P28Cy3Pt3/xs/Bp
         9D6w==
X-Forwarded-Encrypted: i=1; AJvYcCW36Iylmb87HniNI7BNmfVG1+0AhJYO0utjuf25hc8AP7cJSVV369epmzO6LXmqiLs4fGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy98DgwZtcAU8q42/bklozlwlQ1RvPhH/SPyYq9AS8bQTfxR6dr
	mnaLIG+tgXwRstxqJmTUg5HIW1jS59H/koXHLvcVPzhQx61jh2/ue96J3AN+fLgCF8uf8G0THLl
	nD4Y1e5UztzO2kdDyOuz8nVEcc0ctpqWalsIi89SP
X-Gm-Gg: ATEYQzwvhlj9KMm5phHsZMIhHvxGYMvzb9ZsKr8IxQmdCsjjU0Bp5L+BZP6BX1qEegQ
	3gC/wrkGPeIG8IQCPF/5jo9qsph0uztVnjlWHxVnl9GdDgpc5lTMOZiG4sDx1uhOxc3FjTyNHbR
	E10Y/IcKxpbvgZAOjvYrwram546ANHmdKx5GlBoRa30sPGn0SgWC5o5wC5NBp1FH/6OApXRDSBs
	icIbviuvph/m2HEiEEHge0UwZXgYwrNUuFQeIRtW6YdVGzXbIwBMBN97KH516+wfFQ+mlCsTVyc
	zHMr1eUaLd4PLTUD82t2pOapwtvlEMAUN2TkIESYmspfLQ==
X-Received: by 2002:a17:903:18d:b0:2a8:fe50:2933 with SMTP id
 d9443c01a7336-2aea2f2bc3amr316945ad.0.1773079334115; Mon, 09 Mar 2026
 11:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-21-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-21-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:02:03 -0700
X-Gm-Features: AaiRm53eNfFq2R6M6Fsx3M04tNIq8R1bV70kYSKB5eTnuoUy08rbJqrR2yINWgQ
Message-ID: <CAP-5=fUkk6vDQQYJoRbGaA2zc9pZds9xHtoFOvQvO8q_D8ahAg@mail.gmail.com>
Subject: Re: [PATCH v3 21/30] tools: power: x86/intel-speed-select: Append
 extra cflags
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
>  tools/power/x86/intel-speed-select/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/power/x86/intel-speed-select/Makefile b/tools/power/x8=
6/intel-speed-select/Makefile
> index 6b299aae2ded89c3a70a3649996e258b98001ee7..61d6e81f3cf1d6427addb4f31=
c1369ac663ba3d6 100644
> --- a/tools/power/x86/intel-speed-select/Makefile
> +++ b/tools/power/x86/intel-speed-select/Makefile
> @@ -19,6 +19,7 @@ ifeq ($(NL3_CFLAGS),)
>  NL3_CFLAGS =3D -I/usr/include/libnl3
>  endif
>
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include $(NL3=
_CFLAGS)

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  override LDFLAGS +=3D -lnl-genl-3 -lnl-3
>
>
> --
> 2.34.1
>
