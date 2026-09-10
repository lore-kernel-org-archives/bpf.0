Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047C35616C3;
	Thu, 10 Sep 2026 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062740; cv=none; b=m3PcTT1vhd8jSSnhvyGDiH8CAFxfnav81MN5n6Bo6G2JcMj+RaE2mN+phD2QUvHcJWS21Dgd3cmkZbpPBQMxjXHlSxOwUgkT3NQgaH5NbgEUGRdjTjLbDyuqaZKUS+3PNLQoG4ApHICM0TDVk6xCgzCiYlcvxmx1M48u6vn01dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062740; c=relaxed/simple;
	bh=1l9MKvLje7G6Wwag53dqheoEnlWi+kpE1QV5wsx4Jl0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AHAYoO55qCikDM7LtFf1WmeEMG29eW4b0Az0jSwvpHmAbfe40bX/NrpfPdrBMIKHlVg0COoZn3K4S0uVYD/2xyXTO3SO8xpLPCV3q0U8giT6uuBfFfUgVtcEwIvPdmVm3l1j3qRtVjhIt7FQDaAJ2mr60QiclfolhqScYtQIv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/TiHMx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/TiHMx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9218D1F00893;
	Thu, 10 Sep 2026 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789062732;
	bh=SAe1Afn0WX/BhtJe9o/mAJhxxXBq/BfMIl6/mouBZzY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=D/TiHMx0cx6lC56Bxf8FeAkeBCPF974agbY2hcd8S9WagtWqeeKtXlnYPY4rStLQg
	 daABA90Koi43vx1FFw2vxdE3HQppeN1x4PA7LrsSH9sFpDjR0f4HRKoWNbZCCjoZCj
	 hEnRK8aim9mfFp6bMI7O/l5vjVeOGKo2fbVWZx+G55rdswqWM+D1A9Lyy/7Qo+8Iew
	 fSPIgomdURQFAGwCek0PGrooqzeNx6wEvU4ZTspsDF6dQOlivlkFVzzXhzNplcfEnn
	 TH884Js5EE8JpltLk7DgbTEkiNSE96jS2lGt/UFxvYFIIKm6VAvaezS+uilmcW1+QI
	 9Dp3IMbwrT4QQ==
Content-Type: multipart/mixed; boundary="===============3359032784248855412=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c3e4124ce20a8c5b435ae68e4facd38b0dab5b9f643e74d014287dc9172076e@mail.kernel.org>
In-Reply-To: <20260910164635.459558-9-vineet.gupta@linux.dev>
References: <20260910164635.459558-9-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v2 08/13] selftests/bpf: cover the low-32 link for sign-extending movs
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 10 Sep 2026 17:52:11 +0000 (UTC)

--===============3359032784248855412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: cover the low-32 link for sign-extending movs
>
> Five programs, mirroring the zero-extending set:
>
>  - sext_mov_wide_src: narrowing the source reaches the destination, and
>    the value that arrives is sign-extended rather than zero-extended
>  - sext_self_mov_keeps_link: r0 = (s32)r0 on an already-linked register
>    stays in its set, the shape a sign-extended int return takes
>  - sext_self_mov_no_link: the same mov on an unlinked register mints no id
>  - sext_no_sync_when_base_has_delta: a delta on the base stops propagation
>  - sext_no_sync_from_subreg_base: narrowing the link does not run
>    backwards into the rest of the set
>  - sext_kinds_reach_different_values: the same low half reaches -1 through
>    a sign extension and 0xffffffff through a zero extension
>
> Each guards a div by zero that is only unreachable if the propagation
> happened, so losing the link is a verification failure rather than a test
> that quietly stops checking anything.

This isn't a bug, but should the count read "six programs", and could the
closing sentence be scoped to the two __success programs, since
sext_self_mov_no_link has no div and the __failure ones expect it to be
reachable?

> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index eb88d9ce6c34..45bfa02a5338 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -269,6 +269,14 @@
>  #define CAN_USE_BPF_ST
>  #endif
>
> +#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
> +     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||		\
> +     defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) ||	\
> +     defined(__TARGET_ARCH_loongarch)) &&				\
> +	(__clang_major__ >= 18 || defined(__BPF_FEATURE_MOVSX))
> +#define CAN_USE_MOVSX
> +#endif
> +

This isn't a bug, but now that the gate lives in bpf_misc.h, would it be
worth switching verifier_movsx.c's inline #if over to #ifdef CAN_USE_MOVSX
so the arch/feature list exists in one place?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> index 65cb0efd268f..9d060d8b0c1f 100644

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34506184282
--===============3359032784248855412==--
