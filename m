Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C008342CB6
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335954; cv=pass; b=WQLiGGaDWze0ygdHQVhHgOIygzmqw/JDnDILKegsHU1IaRlK3KfoixX+w4a1hNW8hmgyLe5RVVPkm54O5cLNuuCmT7BohI0c4Qsmwqw2N5d48IeL4hUN8v+DGpZC9NxhKI8asYwfgaeK5NIOAOeEGN4ZJNasaRXH/g7zViUHNRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335954; c=relaxed/simple;
	bh=FcuzOrt8CzOV4rxc+ZCEf+asw9BvAvJuhmnBpc7COdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKuuwyQLzYBGbn5qft9Ox9aZGEoWpCzEkiKABcb7KjO/Lc9oBv1QkkXHS54GeZA+zmrPCmiZu/ukGLcHqNv5HM68thQl3ojF/trf/UV9QwzMOnQEn8uS/2vBhJcyzrZt2Yn97On60wPwtgVH4XW+PAnYHE46nW/ElZxOBuYOrRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TeEOCKhG; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TeEOCKhG"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae49120e97so6095ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 10:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773335953; cv=none;
        d=google.com; s=arc-20240605;
        b=LUwG6N+cXChA91dmN+YOgEv5Tjis5dpvmpuWgmtJ7ub8YKriFyzFh7r6fcVkGKCATv
         fYP+tBrFR/nHx6ltrmXfxDDbZaudu+IoNDP2rCrV4PfKlvZeeCyBxA+Eht5K9XjXqkJ9
         O3Gkivuuq0KIVYooJ32f3UbgAhYgaGHKMt7dnBhXnJssLLtNK0tAHtL+tJ5I8UAp3S9Y
         JvonvNd8mjwadNqEoocX/mBnM8CrmIfdEyJF/NP2YZrrgVmil+x8zGPf+5G2B7RwVTsf
         S150KhBByuM7tCTzLb5TwZy+/GcFM4LyjzR9Aj79MlLnrjek0GrORYQY1D5ycGm9DNyG
         znoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tyrqMT1RraqOR3ZZK0z9ezdihjR5JsMGsGUwXou17EU=;
        fh=QOXS2bzzJIm1vlkf/NPrD/XAm2H4QVkGA0/BvDO0sC4=;
        b=j/BlWEX/o5nun7+atwcfQuRtT1/0IqAiZN4iHuSkgG8+ODgq8H6M9ZDqPQleqU1/DU
         D4hrgMkU65rogG9nRiO6FZ42wHkT1JCAEyRtVzBu0WMrzsJg9ZCRjkrM6pYEu9eROOJI
         95aD6AHMi8wlxuKThHaBSoez8ITOw77JipZh9g8u3JUOfWv5cGc5IzzAbNfpYxtninXc
         GPAZQamVrDOIJPZV0q/JPoTfsuDWIJnr841+AnnAkeWYri3nybiTPChiikrucgDAW9j9
         tlmqiUXLmJn6pD7l2IHOXGVH1kZgtDQN5aIrPGpC8rjNtulbhQP+VIKRPpJz/+v1h55b
         4A7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773335953; x=1773940753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyrqMT1RraqOR3ZZK0z9ezdihjR5JsMGsGUwXou17EU=;
        b=TeEOCKhGt63Ay+IiScS+u0phzkgda5ovVrP5FPsTXJtCtUv02MtQY0WKcZTAS3yaWP
         vnn784VqT7e6O4cuZAtsRxMNks48CxpFBrD5YmTlRTdY9F4VaId6HiZZuoovqb0ASixZ
         AGs0G53XEHY5lhDxzpripJ8U0STdlPExPhSiOz4zKmpJwArT1WLb5zdgg1TVerTif1T+
         FyMV5IJ6qKfA5VF6iHcGVWE3Xwccamnjr9klbZvpeQ4pm+n/siVDQxPREgvId9rU+/W+
         mLHzb/D9yZJAjFz0x/huGxGQtGJkRc4dfMIqNA1/WGWXCF8+jd/rX2owEGaAXJiEEGIj
         6vQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335953; x=1773940753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tyrqMT1RraqOR3ZZK0z9ezdihjR5JsMGsGUwXou17EU=;
        b=EUNu5skeHUTU3VMQb+/+oVBxmQDcYswLVkPTiN3bfEZKm7HYovOxDAPJ798EURlu1n
         FPhI85Ia+c7p3Z1ftnEXb4ZMvuEdAe7S2Ks+rEXD/mLIK+eah/GWn7mWzXAIBCC6PbvN
         RR+k4L/k2kMG1CkBE/Ixrp9foS27mOBwCGzHpKus7UXM9acSsYrIw5pfL0uYoVA52HcJ
         1QUlgtCUkx6Yd5jmke/jO8z/h22k+jJlfNOdtKhTLlWkYgoLwVgb10Q4s39aqmVmaOnA
         4cb7kWM81VlSkJaClHjGRvUqFnVHMBmHF73zpnYyN41GefPlm8bnTs6fm0gne2sfGMRz
         w/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWqBvdGZWxU8v8L8rak4A0PdWinNwzEe3rxH1aOLMml0cAX7hbYR5PYGlXo/YSkuoT7j3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2SsO/PkNpxKobvXYR5mA7k1I4ijlZxJJW0bWXg7kSOz8Er6r5
	KULTIlVDnelOm0GC0tpEjNXddZL5mk8Jn+pLJA34nOlrdaCLq9atLet3//xld9uIRoKWlFu0U8g
	ulwtaeYJxCnkRf325uCOC5tEeSs5G/0Qy3+JiGqv7
X-Gm-Gg: ATEYQzxAqhVGU6NhOoh7WD2dsUmzUBJwxXtvJGDZnFt7jIcmXNGD9FYRoi7DOWn/DP1
	FofUgFgtqVQ9q8dP1SMRIMGFUC9n8kK5Sn2fGGDOi9fAmtUdOBYQTRFjzL9hdn8YZWgdW1xqxDP
	4lOL/g/9wIPsnTHFKuI7iCYlncdwoTMrSPvSEkYyb6aEqJ6u2/Jjd/MEPbYuQGUfkTna304e+ht
	7mQs+NSXYunwpYSiJ17PG7+I8e+NWzfBlbYpG1b2EYHEvD7NIfX9Pak17XULj3bfeJtd7JXF9Jd
	jwB4sEhHFVEbxgSXnrnBCGPEcHI8VtsUsy8V
X-Received: by 2002:a17:903:124e:b0:2ae:6432:8f77 with SMTP id
 d9443c01a7336-2aecb880cc3mr9165ad.17.1773335952229; Thu, 12 Mar 2026 10:19:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com> <20260311-tools_build_fix_zero_init-v4-5-9e35bdb99cb3@arm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-5-9e35bdb99cb3@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Mar 2026 10:19:01 -0700
X-Gm-Features: AaiRm50U3ZuNTb9znfrdFL1Z7R9QSzl9qCksbNeUFXxnNuOwB-32dLFYQSGvW9M
Message-ID: <CAP-5=fUOYsnbB4B0khUetRWOFMtHuO6_ESG30b1ZW01n_-gt6g@mail.gmail.com>
Subject: Re: [PATCH v4 05/30] bpftool: Avoid adding EXTRA_CFLAGS to HOST_CFLAGS
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

On Wed, Mar 11, 2026 at 1:30=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Prepare for future changes where EXTRA_CFLAGS may include flags not
> applicable to the host compiler.
>
> Move the HOST_CFLAGS assignment before appending EXTRA_CFLAGS to
> CFLAGS so that HOST_CFLAGS does not inherit flags from EXTRA_CFLAGS.
>
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/bpf/bpftool/Makefile | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 519ea5cb8ab1c0ee31acc67fc5f96b40e21005c2..3e7d8359e1b2a81a29a47544b=
e8539e3b191a0e8 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -81,6 +81,12 @@ CFLAGS +=3D -DPACKAGE=3D'"bpftool"' -D__EXPORTED_HEADE=
RS__ \
>  ifneq ($(BPFTOOL_VERSION),)
>  CFLAGS +=3D -DBPFTOOL_VERSION=3D'"$(BPFTOOL_VERSION)"'
>  endif
> +
> +# This must be done before appending EXTRA_CFLAGS to CFLAGS to avoid
> +# including flags that are not applicable to the host compiler.
> +HOST_CFLAGS :=3D $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUD=
E),\
> +               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
> +
>  ifneq ($(EXTRA_CFLAGS),)
>  CFLAGS +=3D $(EXTRA_CFLAGS)
>  endif
> @@ -88,8 +94,6 @@ ifneq ($(EXTRA_LDFLAGS),)
>  LDFLAGS +=3D $(EXTRA_LDFLAGS)
>  endif
>
> -HOST_CFLAGS :=3D $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUD=
E),\
> -               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
>  HOST_LDFLAGS :=3D $(LDFLAGS)

Should HOST_LDFLAGS be similarly moved? Otherwise, it seems target
flags in EXTRA_LDFLAGS will be added for the host.

Thanks,
Ian

>  INSTALL ?=3D install
>
> --
> 2.34.1
>
