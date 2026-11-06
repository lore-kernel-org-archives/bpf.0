Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794001810;
	b=EFih82nYq3aI2j5e+kn2LOwasOL7JSK2JWpz0AtTaBLIKULMLlY/zqIOqsBM70NR8qCu
	 e+k4oDTocvUXAPq3F92zVjcMC2ELD6vjg3qI1PXpPCs5V33MzCdLZ3k15EFLuB5Im0icJ
	 yM/0khBeHx8Dzf+CaURGDoSg9+HPrVyV7akgX/cv/L25GwSrSpyDfGhr0u+hGttXmuYTC
	 2PHdGbXJzkyJHAdWKLgC575HgljKOrsr1uJJgYvZR6i9e3vsbyz9HzehONqOH0kq74rqn
	 ff1mNjF234XvFgU8zo28zaS5dShFtyWp22ubwOXc6qb/g6TIZa7mZHAmQmPsxT333tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001810;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=OEIOUgJgHHV6uUAH0FBN/4ZE/TGE/hgbL46gynN5elI=;
	b=yApLH7ISKGBxBitC6ibP4GYdGiU15En6o8hqGVs3ExVxPqV707hK+1dcdIptP2nIdAUu
	 +NduCFW8sdA4PAQIgSc7HYokCkKNHPz0U78RQC0nAlEdpobDuDliztcKmu3ucWxcDELp4
	 CE4Z9oF8Rz7mzizhOOCStdYnelTbcl60ijHJFxpJhvjBciJ0yhwixJdFp0tYsmLAFftBG
	 I0AgLfUeJVgN9vsoPLTLyVNCu6H7Kkkz87p+o3a2PYrd048pIvpiQmK2MTtvvSBiMLG3T
	 sc4COFokI/tBLuXsD0oL7M2AQE9+uyzCxCEeWWipd+QYxE6Blq2mgJpsaI2i7mgq0Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECSXNYZN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A44606A330;
	Fri,  6 Nov 2026 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECSXNYZN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09441F008A3;
	Fri,  6 Nov 2026 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794001810;
	bh=OEIOUgJgHHV6uUAH0FBN/4ZE/TGE/hgbL46gynN5elI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ECSXNYZNV5KUmPnYOTiGm32urfXYjslzx/+uVDXqYRwi67ATdnCjfFyS9E6nWBzSe
	 wAbptU7Fd4lGwmgido7PJJhJa24ecVgWhWFotibef5loohFUm7Ra3Yy2l23aa6tEzt
	 deBnYodcJAUyJ5NA2Gtov9+TxkB8olDilsZq7M/35i5etbYwHC/SgioDjjaE/xOP4a
	 oPFiV3kRhgtAUg6OKi2U0ndmAyCHgF7P/LsmZsaBlLrKAJB9KMscEsT/NPen0U0O5/
	 x4e68dhyND24QhoIiezvV0l/XeW6moCRJV7QR2XKjdbAM495L2aHkcJV+gx8GQrX39
	 5Q8cQWBdFQl/w==
Content-Type: multipart/mixed; boundary="===============3583234012145170803=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8b7031053a1e8023c64c8c33203f67f4215142ba84cdbab9d77c89050766c106@mail.kernel.org>
In-Reply-To: <20261106210314.1767267-16-a.s.protopopov@gmail.com>
References: <20261106210314.1767267-16-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v1 bpf-next 16/18] selftests/bpf: Test fmod_ret candidates found by bpf_scan_ir
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,brauner@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sashal@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 21:50:09 +0000 (UTC)

--===============3583234012145170803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test fmod_ret candidates found by bpf_scan_ir

TL;DR: Nits only in the selftests: a fmod_ret test program's name may
misdescribe its target, and some includes in bpf_testmod_retval.c may be
unused.

> diff --git a/tools/testing/selftests/bpf/progs/fmodret_retval.c b/tools/testing/selftests/bpf/progs/fmodret_retval.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fmodret_retval.c

[ ... ]

> +/* Declared targets and the static rules are not restricted */
> +SEC("fmod_ret/bpf_testmod_retval_declared")
> +__success
> +int BPF_PROG(declared_any, int ret)
> +{
> +	return -1;
> +}
> +
> +SEC("fmod_ret/bpf_modify_return_test")
> +__success
> +int BPF_PROG(static_rule_any, int a, int *b, int ret)
> +{
> +	return -1;
> +}

This isn't a bug, but bpf_modify_return_test() is in the
bpf_test_modify_return_ids BTF_FMODRET set, so it looks like a declared
target rather than one allowed by check_attach_modify_return().

Would a name like declared_vmlinux_any fit better, or was this meant to
attach to something the static rules allow?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c

[ ... ]

> +#include <linux/atomic.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/compiler.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/error-injection.h>
> +#include <linux/mutex.h>
> +#include <linux/rcupdate.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>

This isn't a bug, but are linux/mutex.h, linux/rcupdate.h and linux/btf.h
still needed here, or are they left over from earlier fixtures?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42294987431
--===============3583234012145170803==--
