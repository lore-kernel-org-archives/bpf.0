Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFF930274D
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078717; cv=pass; b=du7sMSHcGVN5xxuXyaknEZFficGdANynsIORjMRuuKwMtlpt9sXHaljcvy8hnFJZ+wzlfIHjR4ll0PpL3cmoK9xURYSjgLJWwS209j3jKjzCzqshpxdARl/pHOmdMWwFgNm16OKveRN8O91zVoVXdZ3OW7NAKALwylzUfXihvC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078717; c=relaxed/simple;
	bh=kkqzTEyvh/URTQ9I+cvN17shvFcTkWcWq4aF5dQy6Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXAkbMm924T+TooYqwcOD+XRX12ZVPh9XJO7a9wG/Ghv90Zp11c3Kn/mfqDLHksvaRl0cF3pRKbkn/uq68C6x6rfBIdY9eVd9LhdTLQwc8MblnsZhJCD+5pZfwDPVgiB5zylAcDbJA3BtsfjAaWFhGk6vorAytqW/SxZqh6VzOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yGTboS3P; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yGTboS3P"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae523d54d2so12785ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773078716; cv=none;
        d=google.com; s=arc-20240605;
        b=R/Mc4XP1fVRWDWSLFjhw/vE5NnaDGmPyUkvALkHviBw8fn8jTgykaIqT2Ko91+UqSB
         PQsJbFkbtV3QVVSg6JjgBf/TEveZcyLUV4tEuSoasAFz4f8S1JO77UlfqqZY8GRbIDSt
         sUNzRrmSFjPqKVcATz5PaNH8m/cACfOWo+jRrkDNVH/iCmdNlxQNJkJEe0yJXNPGdzi+
         n7aZaiFlLUsqPpSMXnYtzfwE0W/FEi0fb4q+mrPru/sqfZDcogjBE1c+WGmFr4C3UzSJ
         sb05L41eX7WxcvCK+gjw8HVQMeeR98GDkilEJnPSSylWB11g1AXIAops2Ant5fDchUno
         y5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9FO2/vMdvpebNXVSiHoLYLTKLNZ/3KtLOm8TqnQ8k3Y=;
        fh=CE2msUICTS55MNAXYebfkmqglw4zOgIAXAiEcPsTF3I=;
        b=LoTRs6lJ7nIk26m+ZM4XX/bd7jIcBAIAWyg5vSY/YhrvuMVYtXvH2u0It/h+hBmmj/
         PIRXkUKUjlmandSIkmZxb1jAGyFnK6gndQnqqrNKAsdivgIBka738bqvAC6yyrDNKWAz
         hhaIY37GPQUP6nKINAWJ4zsImxLzSr47xuTmHG1jfGEcus3gNHZgTGGR4adVPm3Kv0C5
         o8EKNAHFIsIBQBQvR9PRAA5KpwfknHu8ApOkLDV+b1xKm8oV1n1nRUcYDY/KNh+ZYXlw
         at92cqi2ssZy8BLSdvU4WQC31r8b9PTCeKsmGB7mpPmxGr3MHkuQohu4BoXBVPNGP+up
         NCww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773078716; x=1773683516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FO2/vMdvpebNXVSiHoLYLTKLNZ/3KtLOm8TqnQ8k3Y=;
        b=yGTboS3Py1ByT60HznWSS8zoNtHLxhO5ZEtTNy/x/hydjlBX+jr4Xd7BUgroD32Jjy
         UJD8URz/25FWMhwBo1Yq+PTDujMXZsP0IdVNgEh+Wl6SjmhA2O6jae5WpqOtvU7MK4TU
         m4mZffGol1hAVDjUaxw9ECHjoySuU40tR5Rsn7OWNGuKMsawhMsklhEySHDemdO1Nx2g
         qdF4BbVJLM97IpH9gEbV5LcQvZl28X/mtif7sbbCHEhfLuko7L9vtwRxDak6/fCnGiyi
         wn+lBpa8keILLkEqyN2EY5l6TxCwyuzvjSmsHOfKSuhjSb8gmitCW8OO+P+u6mH4ySWt
         aTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078716; x=1773683516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9FO2/vMdvpebNXVSiHoLYLTKLNZ/3KtLOm8TqnQ8k3Y=;
        b=MMJeeeBleHR6uzqBoMqoPqTEeAw/d7j/9mIIe/Y/uyZg+7GmJAaOFm0ADOYu1ZdK8a
         gTxtC9bDXEcKWS99ruGOIKxnjoCdcACGCkZCF/PjO1yvODme+Aw4XuJwNcE4ZOJe8ZAZ
         xvONepkCFm4py32MZWEZtmyQS+Vd+HdAQULUEIDkxcWKPqrAWCwUWSZMG2vBwwHSKf4+
         j4ri5XQsxY0HyHQ0N+1vRN3dc4aP0ZSZJHCyL6yY0RT/NKABtvY/FEkjQcFhl7p/hqCQ
         Y7Q662e/zROVtUAHu07Q7k4PwzCq1ZVxJjranWvW/hFiVoGOEsS0t3X60D0QnPMbqXwR
         T8vg==
X-Forwarded-Encrypted: i=1; AJvYcCV/wnutXsX2Z+zbMNQiVf0LSel85uMMJJcbuVpLzzvJ3no7rRSYWg72PQVkAh/UKeyAqlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAqwUZKxT+Ln/C5iuVSSCdbtq0odJt4srpQ9lsdZ11ApaAC3fK
	E1i4PKGT4rTWtLLyTwm2jJXT+vzvpFZLZBQjEv+WDuOoXT0RGNkOWQpS5PGqKBXuqCAVxmKwfzf
	GBnr0FChlZWOpIna5XmAvI6Pp1qy2jWKjfOJk1EEG
X-Gm-Gg: ATEYQzwUI/xFNxXoF2gvmrwYz9Kb5+f9H0GQWOzWNn/bobucgIBEcLCkRxksdXCZqZU
	MJnEficpgEcJhDqe1LUoALpyNFG2ZvedBBlY1gw1mQF6c2Fe0y1hJpKH2EIbjQKHWfS4gv8yC0X
	mbP1Si9WUvFttsCDW2NcfcKD857OUWLl6KzOwMpwpebRxKgpZVlI/4coGUl8K9mTLtMzOjPCFht
	syZAyEl6GXbjvA4aU8x29J8GMNDi7cmwLnAICMFHUB7+pNNmrVeyeJIA8C5ykIpUAGNQBMFKkJx
	NrlUAaOsCESWrhoQyTElVJyuoACYZF9VJO4=
X-Received: by 2002:a17:902:da83:b0:2ae:6432:8f77 with SMTP id
 d9443c01a7336-2aea3292d58mr119575ad.17.1773078715506; Mon, 09 Mar 2026
 10:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-10-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-10-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:51:43 -0700
X-Gm-Features: AaiRm50nzx4ov1KA5iy_Znwdr5CiIhbGHwfapJ-T0G5dtQyH0BIhXI3ZAH4nLI8
Message-ID: <CAP-5=fW83wsZfWpa9777ze-RNSFhAB9PnBa3xkVMu0LN64CThg@mail.gmail.com>
Subject: Re: [PATCH v3 10/30] tools build: Append extra cflags for feature
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

On Sun, Mar 8, 2026 at 9:47=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the feature build.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/build/feature/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 1fbcb3ce74d2173072748a417fc63bd9a5b13888..103d8b71e7a4e8d0979242cfc=
95c1c0b946222b5 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -1,6 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  include ../../scripts/Makefile.include
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
> +

Is this necessary? In Makefile.feature:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/build/Makefile.feature#n11
The build invocation does "CFLAGS=3D"$(EXTRA_CFLAGS)" and so the locally
set CFLAGS appear to be ignored.

Thanks,
Ian

>  FILES=3D                                          \
>           test-all.bin                           \
>           test-backtrace.bin                     \
>
> --
> 2.34.1
>
