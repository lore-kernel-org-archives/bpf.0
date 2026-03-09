Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677A347BC6
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079290; cv=pass; b=YmFFgM4gtjwCpIINzLGoBWRIGGBl8Ayw9Wu79OXqxWuDpXhX9sews+FMCSHEXZafa0SUaOSEjooqk+Bmz2p6K3FF8u5TSnIpL5bB6FsLjW/6M/Eqm3EimRC2pJ8lV8wTJtLchn+j0ZTF9yTpKnvegku8C6KdB43nIm2VtC83hJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079290; c=relaxed/simple;
	bh=PoafOCA89v7UXLaSorz9ixnmscwPr1Rj7wAcGvs6co8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRii2KdT1csysGv7uEIyA1kkJc4jv2ROh3u6xDOK6jX1I1zVCMTZdYv8S9ONXXSV6ius+v4lqs7eTvWLGoIthG3Aytr30HNYw+zIxFK3t8iqVT5zUWn08POI+mjePg7rsTC3JGcPOf1PrFG2f1pgiFssu82TfNQ0R0cqOym1WCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0sXvS3e; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0sXvS3e"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae523d54d2so14285ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079288; cv=none;
        d=google.com; s=arc-20240605;
        b=Xsutu5wAGAtVWoNE0d3gAdHI58mA6dzaWZy+VHPTagFGrp6ofH3g9O0cq/JCm0Ce5s
         157vzDjf8sINVSySrlHSQrILiwQKekKM6CSAWXHTmpputZIEUdvrTH0W/y0dzT0ZSy+P
         k7ELDTVV5F0GM5JXkinZqohrnl/f8Zfq+NIq/3wOX7sowsbaU1ZD4F16YgA9SHz9uDkN
         NlQnxDaVz5v2/gulT1YC6/MXYaiggxAX6QA16LLR6PQvYE1Q/x2lgdi0iSo+m68WPkOj
         jdhoF+DCqiWy+JYiK6spbDv8f6dJmAzb0a/Wd6dJbx3N8GNlZzjouC6eRDhqD+TESXgs
         XGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r26udjS1htgyNVho4B7xDT7S+9gsz+aLoULdjRjLynY=;
        fh=PkK2iO2vq1+kKrS5Pp3vRFZ1p7yqMWm2q9rzP0oeJPo=;
        b=CxkhKooj1oeghqdr/ANf/KzEqs3bSJkwqAjMmf5arTpM2v05h3cJjpAg+JHhJKmHKP
         Yx5Dx9wejGFDGvZ4vWs1ThsyZFxhKYQq1rpuGBEh9iDWjQb8HV8n9sxvQtBfpzytJNwD
         M652QBu0gZUEtDFT5onQ+bsqVc2hg790CFxu0zDj3WwSHJSjwBs47frgoD4/+TMfeANY
         oWRM8O4NO8wDv8fnvpci6C+Rz9Eexih4uSFoy4EDlzcVKRHT/dOqtvG3B+5ZXbIWqmWV
         j/0o8yzD7chJz55A1LvOdHMp2a8rAgXgMwOYzuPxXl2lhYt34TPCqiIYS5rCEHcR1Ny8
         VS1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079288; x=1773684088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r26udjS1htgyNVho4B7xDT7S+9gsz+aLoULdjRjLynY=;
        b=R0sXvS3e/I5akTTuTeCu4/jJIptiWFofAK4uX7F8xV9Q0aix4obyy0OxIWao6C82Dp
         TVw5Vnv7o/aS/xY+tHuyyOtYK3vxD/wn0dV0UHAyKkuRBBll/mPH7objExp5OOyV+dtr
         S2aLBFUha5vpP7DLrIxrHwRQiudeH5DHy4qrQSqSocIVfqeahA+v1tjfUv2gy2DbGwoY
         s/l/1G7RFVPLpQ9cGuKurU830XU5NpNBgS8eaQ3nmN/vl6v2SmNk/zx4CiJse4MYO2a4
         ko0uk2ZmcdrPehXMhEboiNJ1IiaV7n+LsaEb+lRFSfoJ4zi5PjL1SOgRUXqveZnBZxw2
         J6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079288; x=1773684088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r26udjS1htgyNVho4B7xDT7S+9gsz+aLoULdjRjLynY=;
        b=vEpMNcd+fnb+JlpeFkcYayKc0ksncX315bam78//HZEMhkHZake1wl2D/UbJM7QvVa
         aERrJVCHAD1h1TMj9TFME8Qc4uAMkpWpPqTsOE2Ik5sPAOsiKU0Av8CMh5+1Mdh36cyD
         VDMfx3wBooYsnmKptMcIPPdSsvc+QVjp9at2Agt6rnP0E/pP7Z+10YD6kNAmSGlwu7To
         Tye774TarG+a+M2+K4hNrgVyZxlMwkX9HDrULdrZLHzG8OpOA/wgDtiUD1isA3UxJGhs
         ubLaKjmoe09yvy43qiv4lQDf9hJ4BQj/nyq/eIX+7ABfGlYEK0VVqPFRECuJZIRPYDwt
         x8pA==
X-Forwarded-Encrypted: i=1; AJvYcCUeFt7fPaXoKggdwNWLYQgnJpaziNQN1ZS4kMZVgl+7UyogepBQke/oBDTtdXOCpHiQvLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEtYnYkPcCY34ieGCFHlSIcenYWLroVfIfZ53Nmb31tRUGbrUH
	7XvumAGZhMBI+l+2ru0tgCUZyQlPhaDGi/rAjY+TU8b95dApQeZZAIONvD5pAtxNN6RD/wc8GH7
	/FlPlwKhPA2girjRArKSys3TbQBs0JIjv+rKAowDv
X-Gm-Gg: ATEYQzyKhGsHvNew3X/aY8BH3Tbh2tpkmLWLUWqYFy0FE8J7fTQ/PNNSvhhSxdPPf8K
	fPS7FyS6NgE0sK24KEBAZnimY4kTXJkcE7UOaGd7ivWRA6+lzNVDaLNyyoFo5odiXXUrZWhPbwe
	sgwoPz1DpWwq6ig15TeVw8/pq6vOAdtELIKbMoBJRM3FGwuRb1NeN3wuvbS77etx16+rVGHhpzv
	2s9/jZ+r963aIKvpPIjrOONvWPVcdmWJj4pxsp/3S7OMZqe8m3ut44NyVni4TNVi8Ip0gnxaBRj
	8NVSDLVmuz5dAk9feD8m7usYiIcqHSgZJ1k=
X-Received: by 2002:a17:902:f546:b0:2ae:575f:3755 with SMTP id
 d9443c01a7336-2aea30d24bamr257805ad.20.1773079287603; Mon, 09 Mar 2026
 11:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-20-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-20-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:01:15 -0700
X-Gm-Features: AaiRm53zbBx4vwMw2frKtxn1Vd5dHWsmKAdma7wTK-CrU2Ft3XFe72ThDfNa_1s
Message-ID: <CAP-5=fWX54+J0Sbf4XYfcNeEgiKXE8t7T6FRKp1mOb2gm1Dg+w@mail.gmail.com>
Subject: Re: [PATCH v3 20/30] tools: power: acpi: Append extra cflags
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
>  tools/power/acpi/Makefile.config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile=
.config
> index cd7106876a5f39dfda38e286c54c3a7c268b34a2..4978c06828af7b0f47e533735=
ad82c962b7e0765 100644
> --- a/tools/power/acpi/Makefile.config
> +++ b/tools/power/acpi/Makefile.config
> @@ -67,6 +67,7 @@ WARNINGS +=3D $(call cc-supports,-Wdeclaration-after-st=
atement)
>
>  KERNEL_INCLUDE :=3D $(OUTPUT)include
>  ACPICA_INCLUDE :=3D $(srctree)/../../../drivers/acpi/acpica
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -D_LINUX -I$(KERNEL_INCLUDE) -I$(ACPICA_INCLUDE)
>  CFLAGS +=3D $(WARNINGS)

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  MKDIR =3D mkdir
>
> --
> 2.34.1
>
