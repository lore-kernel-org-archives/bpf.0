Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992433B967
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079487; cv=pass; b=uFZj0I4m+EHQjQt2ryugYAGWypi2C4JUEXquS2iTvoGUlipEzcKMj35aES1DQ1T2l1XxoIfT2Oozbr8SHvPKmwF1pVG97eweM4hxAzlSo+qGXGPCHzS4POPobREHrXeOUpamexSzE+n0Rjb1/wXksncoJXYrCOl8nQ86xYmZEoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079487; c=relaxed/simple;
	bh=npXWJ1Ogp4AocCs7RB8Gmks+wTJjIc4kyHvjbnfQFFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJNlT2CULDxwxNjRGbk5DMQtObJsUN+kfsFOCP5QCITxnqWnWq80nayEXDQgYM8aoFGHhwQ9dV3ojry/5tKvqwxRHcmudz5kAggbxYsoEOYTQhtKSnW/j//+jlPMZEPaAIK9J5/ljjZxVh7K+Ww+br+1r0UPPdFqDkKCBsu94pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CCQexuhY; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CCQexuhY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae3f822163so14065ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079486; cv=none;
        d=google.com; s=arc-20240605;
        b=ctW51GvBcKiohEZ+EYHZrOs8RMwP5/UvLXW2WJwCAy8B/t9aUbPo8vETywdo+Ldom8
         U3vTrXNaAIUgdp9HmFX7PBKyF4cd4MTnsZi1U9wgzbk/ASZXSqdEoKfDj+lSRkfFva7w
         1HURTqkbrfq+5k4DeUKSFA0VvdtyQc1jXY3HKK8GvnWHUUZqEEZs4xCS5d+krPLRZLP4
         mPebnXX9L+a96C/97vQzpOQW5Dst4UM5QYo6p0/INgxcGrfciezZGvFuEv/fRplhq5jR
         Lj6cc/VbGDOs/VqB/dR8/sa6cny8F5AptnelYq+m0T1bShT9umyFkvguQQylIhOTt3yB
         WYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DBqxxD+S7Du6uUzPbzqvi9ezyRX+g2oywK0VLlpuaLI=;
        fh=vPP3Cqf/PtQ7VqwlbJSISR07UoYqhUGECJz9tnOOliE=;
        b=ak8CMPUxId95u1fLn3Nwq6w3KodscRLcPD/KZvc7D3SXiYkT+/XxDxDsYNl4+WSYEQ
         0UOL4Qb0BsqVEv79ovpAEzIQlzch4gr/s0fzVyMsfUsfRyvx6OKb1yz9GzyDonHD9hzR
         8TD8BL7hxTeClpFxFeXuRTkST7MBgmevQZD4n/wdvGvX4PAbmC1tkP7LJ1GSifV0Ywqn
         HD5Ni+d/tGwYrdO0LStUGydu8KDKCWFmeFblh3USW81CWs5I2kLmc31YswnphEJPcdqR
         WXceEotiSvH4Sdyy+ztjQmVyN0HxKcVdOirZguHCg4kgQIKfLejjnmW5AwyoFEib7tBe
         lsyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079486; x=1773684286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBqxxD+S7Du6uUzPbzqvi9ezyRX+g2oywK0VLlpuaLI=;
        b=CCQexuhY4mc0JNj/a+moQm6hEV4Wx3OgS2MBtGCSp414fB7iumYRo3723/Ern8tROb
         N3XwEYgq4zCaoQOm+9JkoZQATuuWNrVXeU2a+i1rdoBCeD4rdav13LVyRmm7fal1kjQ3
         pLw422X7Th5P81JlLXQL3LI7yFatTG7RX4YIGJICZ3J5gJAhvqGb2lO3ht+fYIz2tTS/
         DQIUVmOKoNQNZYHGFxJb1HgwG12jjx2jiCjjRfkHgULgtExj0b4IpClbgAHEM1+lYbrq
         7hYdgVOvDZKCJTqRUlupKGLdIHwJrv5XslxWDtY87pzhFyFDMUFUk2JyS2x39flw9z7T
         actQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079486; x=1773684286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBqxxD+S7Du6uUzPbzqvi9ezyRX+g2oywK0VLlpuaLI=;
        b=VNbiGAqxbCsASL1V3GmEDlNNwIcPuoeemYal84nrQsjRVlBUoEa4KzX/+YIb2FxAVx
         WO0GikpP0pxqATPtjOs327tSu2m4swn93EqWiI3p6V56WkZdHYc/aOux75oKTBpy7oE4
         7Kd/5a8woQ4bUbnhtCt+Ddp4EBPA0P/I/Ubw7byQE3YaM7YKCZRx2iG85kxvKpYHkRac
         2N7s7e5DUSMh1Cb2JWn9DQlGyDS2wGQr1DS+EX2QY8+yTBm+fQqiJOtOU1eLjTXKwfq3
         EVZsFea8ZKIvTFAy6bNms6E6i9V+PZw97qdpJOBeh9yQzlsVRakbH4XQLW9kdkot72nl
         Sy8A==
X-Forwarded-Encrypted: i=1; AJvYcCXpppM5ORNMrKhdToodr2XAJSUa45H4fuEtvqMWVjtL/EuIfggu6Zboa90S4kwZhIRcyGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8f14nEG1zsb+QXOLVNfPi8euBonrL0kC5fnf94qfsVFv9mlV/
	P1kiEF4HnfupdbpIkh+RF/5ZYsxtnjtaV0xPgK5wlfydAnfpNvOJYbYj6mddEoNBRy2s67xLkN4
	1/epBx5yh45n3xcFpks8VZwxXLlNk8bzsxW7byYvq
X-Gm-Gg: ATEYQzwDbAmUP8CNF1SJEn3uTp5NkvHl3OTXZGIHD26MWHNrquAvsERzbB590TT4X4u
	36QedOdU9dWDUr1+5KakdyuZawMgc66xmolL0HMEIpsQUvQKVbOMVqqAGzFVy5NSHjRAQlsYEQn
	GsaQze47i03yo++G1nbzVmx9+DE9kihYXT0zZ/qgtTscp62l/N0+MSwXN3zIkCip4TZaj+pk8bd
	oRrX37jxiAEvksUPvQ1kq/yCMaNfg9824rz4GemC6pbX30kIYS807zmpiqKWxNC+1iWFee17Vyo
	ft7cOEUoEr77Pqloy2w6OUzTaUFGW9lXJy8=
X-Received: by 2002:a17:902:ebd2:b0:2ae:45bb:bc4e with SMTP id
 d9443c01a7336-2aea30ebe48mr266065ad.24.1773079485553; Mon, 09 Mar 2026
 11:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-25-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-25-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:04:34 -0700
X-Gm-Features: AaiRm50lc2gBLiSfkJ4Z4DE1wl9NNkgaEba7Sk-TcENnQ4sOXRAHypkvAN4AJdA
Message-ID: <CAP-5=fVxSoN0EoWMG3BXAxrBxyaRaSOcgONcz-TCjn4=CTh0zg@mail.gmail.com>
Subject: Re: [PATCH v3 25/30] tools: usb: Append extra cflags
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
>  tools/usb/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/usb/Makefile b/tools/usb/Makefile
> index c6235667dd46223b646bbab5c82c810221750182..db2ff5b8e5ab7b76e424df32e=
d5a9458daa5d516 100644
> --- a/tools/usb/Makefile
> +++ b/tools/usb/Makefile
> @@ -13,6 +13,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS +=3D -r
>
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -O2 -Wall -Wextra -g -D_GNU_SOURCE -I$(OUTPUT)inclu=
de -I$(srctree)/tools/include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  override LDFLAGS +=3D -lpthread
>
>
> --
> 2.34.1
>
