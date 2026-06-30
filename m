Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A573DEAFB
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843044; cv=none; b=j0uqbF1uuEMcUYlg60zyvt+t5+4pmbVrB7RB4LwHiEPwto+0P33FU522zmm6fngp8wTixOa7bdbZdVPgCTjJMgVE0VD1kP8qfXk8nXf42csGLafriMNSQdgrfuDYxr+WzBAW6jXphVT3LldcZwRROfjy67oM1knr4uWAXbsrFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843044; c=relaxed/simple;
	bh=0taPItc/ZhqwjMLwUT+K3EuCxI1p/7WtY50pAXfBKVs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=nzgFYGszWZKIeo5rEdoO+Eml9H04dACZeSBQu78GwOluAPTDMZ3HjrTns1eogAOHTS4GH0AzSoDqFBo24qt6QCvvnDa9z9b28ohF5YKt/67t4gXFpXV0hoAorjjUL3m4tPKZofv77YQ94gVJRZnqejOcKGR3bluPJIiHQinnaSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5XaWGFT; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5XaWGFT"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so730582a34.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843043; x=1783447843; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0taPItc/ZhqwjMLwUT+K3EuCxI1p/7WtY50pAXfBKVs=;
        b=A5XaWGFT418NF/Zh3H2IGTV9BuuS8WlOp9JIHqcbKT03PcrIOUMNCTzKq0ap/kqGfB
         Zt/JiZgdWBzD52J2BcodO6h9Z/d3ltCo5LpUJ+L8qo40YxaIDk9JsfgNd5sGxIj8oMUS
         37MA5u/a9BS1lNlf9UdeTLOJejap6aC/STkn85180r5zcIHXgF2fW3vhxJJsFQNHEM1n
         6Va5zsamYYgLXuBVv7EfEXvjYXXM92eqd8/Hi8B2GLh3BSbmMeOEEnLULYwQUaNmUlI1
         JG8Q0WkkURk2u+svLagSoM5dVeArAGTbQzGWYgVt1INxcvUuM7yLF0kiQewW8be7AwrU
         Vd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843043; x=1783447843;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0taPItc/ZhqwjMLwUT+K3EuCxI1p/7WtY50pAXfBKVs=;
        b=TPafd1FsxY0+33b60qS8VTGUqavJT+YAgTqnTaEiKWGmrELHCVMaR9k4HM5ksEBp0g
         CmL/Ku74NGPUIdkyCYrCSh5m8VLMeFUQ5xj2y5o1FCGqjetyu4LeAqkrzc+3tWCGdZbN
         Mp/EDeLNgMMrNfo19Kq8XH30bCmcWhdlhD8nDHapDZAVhrW084RVmMq7GbAmkbYpBtx6
         oYe/32z5F5IFyocXoiqbz/rYnuwQYacx2QhQkDEN1+6Jx81LJu65w7TrFbSo+HswGi7+
         ZQQ1ou8BERIIj2FcQ3wyA9Og6hxVbF8/YDNZTdzdpi3MO2DBx5AMHFkW0mGyUhMknYA5
         G46A==
X-Forwarded-Encrypted: i=1; AFNElJ9bcPm+DUEW9YqlvoKcvtst7i4e5uGIGyM4IUULj8BGDxv2HhuXCxIomNYdxci0z1qLN3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZhjp6mNU9dndQ2XxHjsuEYgJ5lElY9lbZYhytvcHuFxLIXXm
	q9gP9LkKZXLsf2Dwi7Zo70MS2jjGYTzeXd0ftNJfgGZUldi/Al//l8sH
X-Gm-Gg: AfdE7ckgJvFOMQlyW7ImnGYKyAQPULNujfyIwvO1aTevejyg4D1Moa8j3VMyZZ6V5Se
	X3tKwGOY+lqEVKTsZnjj+CNjGBc/EVvpKgbfwSjbVwrdvZ09Kg1MLIYoqhYPf0ffrvQQzx5h2hJ
	K4YsME708L5jnF23HmnRv3pX1OM7Aj9HjRBgwLvIlUEXg5n4ZQjybFq5SFHVgH/0Q9lVk4hYmwl
	ege3A2JqMqprym1rrofqWFiVTyeaxI9GrhsNgDUWqpuOb5WiIsRgzPNqJQJn1ldlnmvZVaiD+zq
	wlRNzA+dsTABRaVRfTD2QAqz54ZvvJ8Et+KSIk4+/3gaJCGfyl7qt3USzK9A2c58/2Z+hkLuEem
	cHs/w9Q0RbjP80aoMYmr432y5DaZF1jwwilhmyFkKbMipykqLzjjcniRSd/waBG2htuEA7cGGgH
	vabyT7eemO3CUEjEm5aFBjNQHUAIViGsWJi2c/2qzaK3jgL32fTfNez3I19yH0vZsNsB7MLCdHI
	+cAfwQ=
X-Received: by 2002:a05:6808:1913:b0:495:e48c:4e42 with SMTP id 5614622812f47-495eb006eeemr4169487b6e.40.1782843042753;
        Tue, 30 Jun 2026 11:10:42 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4935536690esm8853280b6e.13.2026.06.30.11.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 11:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 11:10:41 -0700
Message-Id: <DJML42EC3DYK.16C7NCKGKW6WB@gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add benchmark for tail call
 performance
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>
Cc: <loongarch@lists.linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc
References: <20260630022306.10017-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260630022306.10017-1-yangtiezhu@loongson.cn>

On Mon Jun 29, 2026 at 7:23 PM PDT, Tiezhu Yang wrote:
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_tailcall.sh
> @@ -0,0 +1,18 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# 1. Load the official common benchmark utilities
> +source ./benchs/run_common.sh
> +
> +# 2. Strict error handling configurations
> +set -eufo pipefail
> +
> +# 3. Use default bench binary path if not exported by the framework
> +BENCH_BIN=3D${BENCH:-./bench}
> +
> +# 4. Run with strict core affinity and isolation for reliable profiling
> +RUN_BENCH=3D"numactl --physcpubind=3D0,2 --membind=3D0 nice -n -20 $BENC=
H_BIN -w5 -d20 -a"
> +
> +# 5. Capture the output string and pass it straight into summarize_ops
> +# This satisfies the framework's internal parameter bounds without trigg=
ering set -u.

Too much LLM smell here.

In general, I don't think we need a bench for tail calls.
tail calls are more or less deprecated and often in the way of implementing
new features (like 6+ arguments). There is no need to work on
improving their performance.

pw-bot: cr
