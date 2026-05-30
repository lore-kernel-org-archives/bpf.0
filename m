Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CD9377EBC
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780180787; cv=pass; b=NAXBlOZsoMo6SCk5H4v508y76Eh5hcm7/rpmfu1dHhRKWZRkf+2R/Wx5kamusnjPXg2eP87DZ1aGTrBlCoNqU/OCaNmSnLEDotltQ71X1kZdW2Z7v9qlZms9E5QjufRbf0WSPrnu0o2B8EkSCsfJYSKhTjXgbeQfXgASDmx6/K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780180787; c=relaxed/simple;
	bh=JyTD6qVb1qHAE7E2hdTdrF12cQhdrJuQ6qG8m0wPhGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZzuSe7+hervxL/zKXK/p5MtxK9tP7T/ejkttF+ULseNCj1PpBYK0UIOwOyQnq6eGsoReBjafPFJ5TONEl6sTOa4KB+OBU4XolyxEf0S2t6Lb0CDJpyBx1bpsp0UM5kM6OQTDvZvevHAI6XuZQwRW5oaYEeywPJQ0zQQ3znyvPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRr4ZeRx; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRr4ZeRx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf22c18ad3so115ad.0
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 15:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780180785; cv=none;
        d=google.com; s=arc-20240605;
        b=KY1qAnQzU8Uc+oAgR46DKAxubxSBzRR7CTfJ/MKhvkDaibHEYQ1xvr6veToFJwJjBi
         +A033kuMajtIQX4X6+jxkqnhf3+yISU/wOrZIwux3ggmwwU5B9eJ/QepLkixecr7SHxu
         fO8kx/UB1CAPjYoe6zaiQNZI2VS7vkGslsAZrWcjzFKsw/s6E5hNmzA2rd14YroYSZv7
         4gIUMlfW1RQvt9ImqqnM723xUhsAC2oA/ZUHFhLQGEUNeCc2/nqSy23FxBiaEm1UEVXs
         rv65LhT3e98/x1cdPo2pNX8Q1gsf2AOhqJ89Exy4NRX0ddSTEkS3v8uhcSJ9CLzuGexX
         x3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GOyk9c5aDgUM0zKDCnJp8ZCtO1C/2o2wSI27Hd6Y+dk=;
        fh=YkY0iEbMru4LcH1Amlh+GHSzEpituvRJNZxsrKGINkY=;
        b=fwB4ryhI9HRapTRRIDMHPCpfMe7qNIajtYIeDs87Q5Ujf3Hm+vOLWbYzBhbye9SQAu
         yd1kHr+uyqPxxxeqdx+/6RmnQnw19XiheVqdmsES/SzQJaj1ih0wzuCgP8TnzbLyvTpX
         rwZjb02CbSH2kBGzoa75bTBs0kvoBsYuXei7jHqyP30u3cLv2MkHwFPgPU0OxvFp6dCR
         bn5aMQnp9zpxeFg/gnU+1peODWXJ15Ywipb93elwUQLhRZ8oDa8bkZAyVbH5O9FBXsKR
         ltTY4dd9cuiDYJwyrA9KnfZB9Ja2Q+nZZR9xk8RPS+MxsbyPEmW3InGqL9Smkf6cg78i
         208Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780180785; x=1780785585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOyk9c5aDgUM0zKDCnJp8ZCtO1C/2o2wSI27Hd6Y+dk=;
        b=IRr4ZeRxsn59vI8XNEBZBZNIPqFAdHkzkLf37jrHtRP6hGaXZ61YO+ATHzUuVmZr5q
         +C5ECTNgfdRvlqbltybDfMGRckQ18uRyVRL8Ego19Ic08eHAjQcBmv/V8G/y1eGmaTwF
         4igbwGKKyQAho35oFruwW8+HpK8KfhWM8TBS9DSJ9oNUMms7hOZhSC/0STQNytY3woYO
         vVQR5+zdHtrFBMpgtaUcPd5s16f5i7jvL6vmPG6w1IG3jX3ENQSLHaxlVL8E4MhXKyzk
         vw7rwWSEhdcnt9OOM83hFsdrpPO6lKj7enN6YBwuY8ctNTOmDd6ohL6qnLZ3LQCpJLLT
         0yKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780180785; x=1780785585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOyk9c5aDgUM0zKDCnJp8ZCtO1C/2o2wSI27Hd6Y+dk=;
        b=byJwI0kFzN1Vo8UXBbsJEOFn5v6CDuoDuHxOeC1qcPCC7ncLtd2AlKPr1Tn4SZnlxL
         +4tFpNDbnhBBC56QrtNmgywWCtXmRBxIHDHM5c7UKxbXdOJLb9KJWgo1MYzoK1zXnc77
         3zbff15n16lf0zqdU5vUA3ZWOdhs8POBKl625p/PHfYVa0h+sNSNu95OgMnC1JREmtPr
         zefDfwr9KdK2ADpzposet+ikmNzZ2ngEmu3D/c8tcN07ds9DSAjIVkP2U8goKSnmFPZX
         xJQ0NvVzmtEVJXSAaH2b8adrYgtRzxJB8l4MtWUETtmhCyioBk2bGkmZlpL7/XXctnIK
         e8Ow==
X-Forwarded-Encrypted: i=1; AFNElJ/aPUO+77OBcG/lDUdkSPd0ZEoylxSEP5dPJ7UwkPZVekFitnrL+lNLLHChpouKbFp99vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKd4/OED/4pmYpuYWaUeLmxLJcjNlKxztt3AMJ7581TP3uL/tj
	tdsomPArG6hUVxePF2NiHohbaiFUx6I4eolSpv+DzsH43eoYJdNTLBJNzaD6ASTkLmj7cPhjM2H
	JbIrSCzHM9RXb34NPO8NMGqk/D7NuXzEoX6JX4wnW
X-Gm-Gg: Acq92OFpbbZl1jz4a9oiuk+iECl99K0na/ItE/mJWMnrFKZDZO8DkUP1Oa8ohJw4NeH
	4gt22X2/ogUz/G3mU29crm/PVtnsw8S5xfZeECr54OyjTHVRTQWFrW5ojB4w6wC83VPWC1MR3XT
	z30GR1m5Og9acWfrXNL1ZV8DPdn6OOWt42CpsXk6Cz38DD1eCBg5eOk/TLnrygdfLjpDg+UyN5j
	KqFAJYzED6+jl9PISKJtIYsegk+nzkhOIJB1vBCrto72CNwTZxxYf8UjHsmoZdajLf0RtMLeuz4
	VbGpUbe5Rm4G8ouZGQw=
X-Received: by 2002:a17:902:e84d:b0:2bf:749:551 with SMTP id
 d9443c01a7336-2bf975a82f1mr3314295ad.22.1780180784107; Sat, 30 May 2026
 15:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530195511.71452-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20260530195511.71452-1-suchitkarunakaran@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 30 May 2026 15:39:32 -0700
X-Gm-Features: AVHnY4Ly4g9eRSx8JX_CEpFmAYme7-7E7FRmCShWruHLL9feKzvGDxM6PMJLXeI
Message-ID: <CAP-5=fVZ0zOG4yEPjn2Lk2H4zteoHKjmdKdNdMeeTTMCFvZLgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf build: compile BPF skeletons with -mcpu=v3
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 12:55=E2=80=AFPM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> The lock_contention BPF program uses __sync_val_compare_and_swap()
> to atomically update the max_time and min_time fields in
> contention_data. This builtin lowers to the BPF_CMPXCHG instruction,
> which is only available in BPF ISA v3. Without an explicit -mcpu flag,
> Clang targets BPF v1/v2 by default on older toolchains (Clang < 18),
> causing build errors when v3 instructions are emitted.
>
> Add -mcpu=3Dv3 to CLANG_OPTIONS, which is used exclusively in the BPF
> skeleton compilation rule.
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Changes since v1:
> - Moved the -mcpu=3Dv3 addition from tools/perf/Makefile.perf to
>   tools/perf/bpf_skel.mak, following the refactoring of BPF skeleton
>   build logic into that file.
> ---
>  tools/perf/bpf_skel.mak | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
> index 7704e7e635d8..f2559de39f96 100644
> --- a/tools/perf/bpf_skel.mak
> +++ b/tools/perf/bpf_skel.mak
> @@ -29,7 +29,7 @@ ifneq ($(CROSS_COMPILE),)
>  CLANG_TARGET_ARCH =3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
>  endif
>
> -CLANG_OPTIONS =3D -Wall
> +CLANG_OPTIONS =3D -Wall -mcpu=3Dv3
>  CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_A=
RCH))
>  LIBBPF_INCLUDE :=3D $(abspath $(or $(OUTPUT),.))/libbpf/include
>  BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(SKEL_TOOL_OUT) -I$(LIBBPF_INCL=
UDE) $(CLANG_SYS_INCLUDES)
> --
> 2.54.0
>
