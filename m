Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDFA39EF1E
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776686413; cv=none; b=Gv8Qaaf4KDWneGWlgDEI8iOPz+MXyqOo5oPmma2sebu4lpGgAft+9UaBc2tPlV38XP44o6pmWeph6zkxVG7oqiB7thiOzkGGU3q+SlGH0ghkEIHn6W+DsgP8aEfO2w/jhynDEL7CLJNbqB1BrOPD9cmvbWp4rBPHGXeO3jBIoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776686413; c=relaxed/simple;
	bh=+eg5UddaGtosJjuCqzibvTasZCTvNo2vCYqNA9tjkPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OURs/ecfVhsdT8YP5bT+5M8iimWLthNVkXdQPm0qcfoigAqkmatxgS0HTBMFRfPOpgUBPsV3ndqxeihPTBttRuKO5a7JYgR3aU+ZD+3iKmHSUATYvGyICMJdkB8/tqH+bTLdMkHWIIlpuLIuc6tYbSd08dwubsXzhjGVUWGhS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKzci69B; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKzci69B"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48374014a77so38460805e9.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776686410; x=1777291210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCv1LkcE6CU6CE2JF6EE5Led+R09HQ8zug1XouZPZGQ=;
        b=mKzci69BNVYaFB0F7D56XivYpeJ9D+uJ3dfX992po6R5VBxzmMeGPMfUTO0GZ2qdV6
         RVo+Mb3qPR6+QaAjpLpMWp558+cYTMN/cy8E6bJYY8QAFz78zCuv0DjXmU+XJ2gFozjP
         s//I4/6rPvOi7cplJi2m7BVN+74wGaj0V3Ro8CZ7uRd+im85kHeOfJ2qlAwRsXRmBsaa
         mvyk7RoQ4zFT4NKLcLXDkgiUW58VJAAPVmFKifBTiNkxZ01WLDsm7Ycb5mkiIr57MZAd
         2Zp65IEh6JRl1KKOEKV/su6bJYow7+r4rl5pcou6q04OF1vqFJKiDOau4Gk9UGlGAaXE
         WUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776686410; x=1777291210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCv1LkcE6CU6CE2JF6EE5Led+R09HQ8zug1XouZPZGQ=;
        b=oX3xlkz/K9ZCEbtpoiT5Qd6AJzKuVSq5G+Gz+LD96xNhJpMOPpmvf3WkguwhvggZv/
         +lRctJC2hzJujwXYXgYBFMkw0Ufkdjv+ekJNuTe8pBbrBYt9KmG38scyN/hbjdvWjC8D
         ytepXauMd49HbUr5PxlCdxN90xkBOK5OsGoRMrub7omQ4JHv0BY111bSrS6pBQZrMz3z
         CZXru2n8bse0tCuds/QfKs2CacBAj8nPmS4nFsMDVP8S2ZLPu6pLe9aeV9ZOnLahxqPP
         ahyL2E84EKGFgvXCuYY8/NpTj9ISqCZnCpaI6jMYmNSOKOlinowiVgweXwzf1HVFjU43
         XebQ==
X-Gm-Message-State: AOJu0Yzgd75FBGjKsr6C2j8KS/1MT6k97Ohr1Ctt8XU5CBglxwfM2hAW
	Fr2I/uLf9b+DgK41AUbFVDthBh4xooYoowZ9lrh7agaQcf3420Xed7KD
X-Gm-Gg: AeBDievsmmHzTcImludwERK0kyps8J0JQxLjvhvrF577uDQO3VjWf/mOojhz3xrwD5t
	9ZfOKNsiZ+xhbDs8wDAsXAoxX9xJL4qrkaT/WHPNKCdtsRTKGCXKA4/o+9H0/pZPunWNn26nFIm
	HHeBMelF3PWF72jtHOrftb8d/Ig+NVYbrJo71KpC40gdzMTQMlr1jSR5KEtBGJDHegFAgKDO0Tf
	D5wGVen3fUJ1m3t7mEG8mOH+3u4ww+6aAY5M1XCZqX4MlyjaCPoEURPdBNdNpL+Khj78lA95Glt
	wh/b+lndAxxLs/BPbRZ4AXlz3Ga2RK5wlLycSdZLzVco5a4JaWQda291MTmOnFJXCW+SYETqgR7
	R9To2Y8ha2OhUfdE/f3cQgocwG206Qxx2Dwdveo8pbXZTaB4UJ4OW2ZijUIk0riIePpH+LiX7AT
	3kjnv22DzOyraPc79Tr/6BylNqQZMYn+JJ7/UKWcWngcXkTw8B7+Bx/QuMMJiY8Ch67qWMUJs0t
	1lOAu3XpkB7wUUrF6CEsdRZp/HXFFWvgE/ecUkNyYoHgXoJuuzTgIaDGRypxI+hNyHBNiZam5lu
	E5nkKJAjBZmov/m+hN9xmPVbXP2iuggfKantkdDYHKovjBglNMXJ
X-Received: by 2002:a05:600d:1b:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-488fb771438mr160839395e9.19.1776686407395;
        Mon, 20 Apr 2026 05:00:07 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0007a7f49aabdf4292.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7a7:f49a:abdf:4292])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891bb3d121sm135776405e9.14.2026.04.20.05.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:00:06 -0700 (PDT)
Date: Mon, 20 Apr 2026 14:00:04 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix off-by-one in
 bpf_cpumask_populate related selftest
Message-ID: <aeYVRJhCs3lSLJAS@mail.gmail.com>
References: <20260420093734.2400330-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420093734.2400330-1-mattbobrowski@google.com>

On Mon, Apr 20, 2026 at 09:37:34AM +0000, Matt Bobrowski wrote:
> The test_populate test uses >= instead of > when checking if the
> runtime nr_cpus exceeds the bit capacity of a cpumask_t.
> 
> On a system where the physical CPU core count perfectly matches the
> CONFIG_NR_CPUS upper bound (e.g. nr_cpus = 512 and CONFIG_NR_CPUS =
> 512), the condition nr_cpus >= CPUMASK_TEST_MASKLEN * 8 evaluates to
> true (512 >= 512). This incorrectly causes the test to fail with an
> error value of 3.
> 
> A 512-bit cpumask_t provides enough bits (indices 0 through 511) to
> represent 512 CPUs. The subsequent bpf_for(i, 0, nr_cpus) loop
> iterates up to nr_cpus - 1 (511), which perfectly aligns with the
> maximum valid index of the bitmask.
> 
> Change the condition to nr_cpus > CPUMASK_TEST_MASKLEN * 8 to fix the
> false positive failure on these systems.
> 
> Fixes: 918ba2636d4e ("selftests: bpf: add bpf_cpumask_populate selftests")
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

> ---
>  tools/testing/selftests/bpf/progs/cpumask_success.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
> index 0e04c31b91c0..774706e7b058 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_success.c
> +++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
> @@ -866,7 +866,7 @@ int BPF_PROG(test_populate, struct task_struct *task, u64 clone_flags)
>  	 * access NR_CPUS, the upper bound for nr_cpus, so we infer
>  	 * it from the size of cpumask_t.
>  	 */
> -	if (nr_cpus < 0 || nr_cpus >= CPUMASK_TEST_MASKLEN * 8) {
> +	if (nr_cpus < 0 || nr_cpus > CPUMASK_TEST_MASKLEN * 8) {
>  		err = 3;
>  		goto out;
>  	}
> -- 
> 2.54.0.rc1.513.gad8abe7a5a-goog
> 
> 
