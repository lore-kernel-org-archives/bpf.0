Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A723A9622
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167409; cv=none; b=IU5TGDUD3mnTLHVrLGcMT4D+ZCLR7jjM9I+T2QNgW6UOBqoYaeSiHX+ZvGojvnAuMRg+JlP7HY9zTKGuKVRSvKXPG/mF9hZ+xsQLLbCgiQrBQUcZU5BIvwF1eNs5eSpzL3UQ7xKEvqDgslIuq/yZJ8oaAkObGuM66jVNpBg0900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167409; c=relaxed/simple;
	bh=Ebxlmj6j7GSJOy1UBMa4tE0updTt+nKNV5kUwdhNN5Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=urAYT99Tifh9lnVYDB3a9xj7dLC8jh3WyKpV+U4AgF38DvoAl4VXCl/eTBYeF3sKAKRFpVR/GBfBNDi/vX+fo1GwGkA4JlnkLd3V+P2j5QN77uRTsoTXhiwFjb+Rrvf1rbBRW9pzo+zOIpWLoZ0+Wutmx7AoSGk4Wg3zpXfvZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFGwFEVL; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFGwFEVL"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so1225580a12.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789167407; x=1789772207; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4Nvv4EvmKrF5T+RCEjfG/aHX98jQreVQxf4uiDCREf8=;
        b=OFGwFEVLJxDXsQZ/4Oy8+mEFYulOzuYONnX5VKLJT1oRFuvnUjbm0TaBLC0Po+yI0P
         BRPNv395j/krqowKlrcvZ6nBAXgNvmBuVGJvCLQNZKK91+RyFTkoHSZn8xak7TqgLg80
         RxgzpP03985kb/7vUbYpBHUkGezUwVEW4QvPrpzVVt9T+uUcq5tP9KvzhjJUSU6jkjWO
         gmIV26amHDNrugBOKmM4uZiHJ7Z/xqUo4hEGiEWGxRtOYTiGWHyWVJjsLuuwGtH4gT/1
         6wKryKRTCfZ9kwqjTK34kD2eAd22SMp4dHUB4g6G5ALhxoUS8WKydppGegCc9tPhlHyq
         qSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789167407; x=1789772207;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Nvv4EvmKrF5T+RCEjfG/aHX98jQreVQxf4uiDCREf8=;
        b=l3MS6lBL2WoLViq3vJP18Qj9ih1kE5PGhTD4eISrlEf7YKAW0E1iPrjyDyUYbPIV3W
         Lcrt3yHc1EKnfd37zwgcs9iebeWmuf+tZ7wPtF+72bS0S6tg/hB99LGtIgXohazb+t3G
         qYEBKo8JPSvvl8bsOrcGUrAyO0K0D/cnbzNHD6UMUrO9mf1QxmQ1YYUngZ28LPB/5+f6
         CO2rRFOsrTiqMEIiDG6QoRZTHKt0SzxLSryTa+eog+WNdRHX19liy0R1gcm0Gi1xDEy+
         ho9dUBHZwh4qD+/07k/31EHBe88ux6hIi1zxBaSslub6bxnRC56paVpFQrLFaQPN3rD5
         hWaA==
X-Forwarded-Encrypted: i=1; AKwUvBxb0Xqlc/BlANFDrJ2Inkw4K5O+qdLIZXxjyVt5YeQjIs/Cxfe9DrgvoF4/koz7/z8x1L4=@vger.kernel.org
X-Gm-Message-State: AFuF++kahLKwo5znC/Hq95LRsoFdpGFRSaA5yoXKhlqZ3/j66xr/M1wK
	Xuh2iUdbrtNxu1D/8XJV5lJ6/BPkED946LNf60cGXJu+fo+xG/ajm0fe
X-Gm-Gg: AYBFou1tITTtRKLQ4lzBLRkjenDGF686quGClrtf1HS5txA/gcMptTnKWd3ZNA3Gn+g
	REBf5G3s1wBYiuRtLdYNDMuRpUtQz+tBTHsLMUackrYdCktDaFto3SzoCyX2nnc7p1WGv5ISY8C
	AdWO8TRr+tLWKvCdMUNe59ihSZAn8NbvPZtSdWl53sc0zQQNQn+9Xh9DQdyo7ntC6KTcnKHdBmL
	AKrLQ04fosxxuWp3BeidVr7QW9dimPnsstzdlZR/75j5bPk+MtF3UfkE8mn8hxeXeHR/MMNhGU9
	znjDw1BpTGpgPd/CRYDho51wCiFPuGHKIAXEJ0IyI61b6wmO18I+TmNk7+D0c7xCOYT9dRWLJ8+
	/A7YUuTRDFo3kzRqXW7PT2/S2iHxhhVSsAIqS5Ge0zdcfcupWnn7jsJXDOQeJ20fV849DIP+ddR
	np7xGoKPI9QsfD7OXPZHDrisyGmNmRNAdH4vJhzkKMwoBsVkJ5x1j92csGLam/OGlC2RMelyZIo
	Ho5UlkSKmrogjuGZ+aYs5vsx+cnvQ3AYaV8I2tRwGhzMBgaHvjAPW1zSPKu3d7HGMMU
X-Received: by 2002:a05:6a21:7e0b:b0:3da:f32e:b3bf with SMTP id adf61e73a8af0-3daf32eb452mr8259081637.17.1789167407384;
        Fri, 11 Sep 2026 15:56:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c52f:3686:673c:704a? ([2620:10d:c090:500::4:b9a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fa50efsm10280580eec.28.2026.09.11.15.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:56:47 -0700 (PDT)
Message-ID: <917a177ed71802d933c03fa154662b50f5fffd14.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/7] bpf: Make post-verification instruction
 rewrites killable
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Fri, 11 Sep 2026 15:56:45 -0700
In-Reply-To: <20260905083418.3723623-2-memxor@gmail.com>
References: <20260905083418.3723623-1-memxor@gmail.com>
	 <20260905083418.3723623-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-05 at 10:34 +0200, Kumar Kartikeya Dwivedi wrote:
> After do_check() returns, the verifier runs several instruction rewrite
> passes. Some of them patch or remove one instruction at a time. Each
> operation moves the remaining instruction and auxiliary-data arrays and
> adjusts all branch offsets, making the overall work quadratic in the
> program length.
>=20
> A privileged loader can submit 131072 unconditional jumps by zero followe=
d
> by a valid return. Verification finishes quickly, but bpf_opt_remove_nops=
()
> then spends a long time removing each jump separately. Since this
> post-verification work neither checks for signals nor reschedules, a pend=
ing
> SIGKILL cannot terminate the task until the rewrite finishes.
>=20
> Make bpf_patch_insn_data() and verifier_remove_insns() common cancellatio=
n
> and rescheduling points. These helpers run from BPF_PROG_LOAD process
> context, and bpf_patch_insn_data() can already sleep while reallocating
> auxiliary data. Most callers propagate patching failures directly. JIT
> constant blinding can instead fall back to the interpreter, so recheck fo=
r
> a pending fatal signal after bpf_fixup_call_args() and after runtime
> selection to keep cancellation from being consumed by that fallback.
>=20
> This does not reduce the quadratic cost of the rewrite passes, but it mak=
es
> the work preemptible and allows a killed loader to be torn down promptly.
>=20
> Fixes: 52875a04f4b2 ("bpf: verifier: remove dead code")
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

In general, I think we should stop hiding our heads and finally
address this properly, by changed bpf_patch_insn_data()
implementation. Multiple solutions were discussed:
- converting instructions to a linked list before rewrites
- accumulation of patches in a loop and application in a single pass
  [I'll give this one a try as it seem most self-contained]

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1c3039f3fc32..9c797cc3df40 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19,6 +19,7 @@
>  #include <linux/bsearch.h>
>  #include <linux/sort.h>
>  #include <linux/perf_event.h>
> +#include <linux/sched/signal.h>
>  #include <linux/ctype.h>
>  #include <linux/error-injection.h>
>  #include <linux/bpf_lsm.h>
> @@ -21367,6 +21368,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
> =20
>  	if (ret =3D=3D 0)
>  		ret =3D bpf_fixup_call_args(env);
> +	/*
> +	 * JIT constant blinding treats instruction patching failures as a
> +	 * request to fall back to the interpreter. Do not let such fallback
> +	 * consume a fatal-signal cancellation from bpf_patch_insn_data().
> +	 */
> +	if (ret =3D=3D 0 && fatal_signal_pending(current))
> +		ret =3D -EINTR;
> =20
>  	env->verification_time =3D ktime_get_ns() - start_time;
>  	print_verification_stats(env);
> @@ -21425,6 +21433,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
>  		env->prog->expected_attach_type =3D 0;
> =20
>  	env->prog =3D __bpf_prog_select_runtime(env, env->prog, &ret);
> +	if (ret =3D=3D 0 && fatal_signal_pending(current))
> +		ret =3D -EINTR;
> =20
>  err_release_maps:
>  	if (ret)

Would it be possible to move these checks to constants blinding path?
