Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB61A275
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781050028; cv=none; b=ruf4qW9/abtSQ/DOMQ5Gbqkg75ZIL1KpYr6Xjys6JvCtSzeeVHet+6nO1QsunhXT6/+VdttpJ4FOLUE9G6d6swxy6oQeNLUT4M2NucmBhzxShQd+NTWLogU40N5ukxeV/3lWBH/A7rEWm0u9/syDMTunNXCGgC0giJv438RBGyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781050028; c=relaxed/simple;
	bh=1ZWz07cz0BzgLnvkrAeAARtFeS++4RbYwZoFD9TbwLE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EOvCF1v+lF7HkyKUQOTMG4otp1kJj6e5ResY0hanQT6Zgsg2NeXgtjXkFesP6bPIc8YN9FgsBCwtuBl18bEH7NtlYn9Loq7sAwM9tJzkavyASpXvGBl00etQ/qzUFfFXLI9hzQR3grdJELf489PdHICrdcK2KXhdRShfyuyVJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USOJsU//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USOJsU//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4631F00893;
	Wed, 10 Jun 2026 00:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781050026;
	bh=yJCNpcl/baHy2mAVqANL2l73x/kk7nalnp1n4eC6QLE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=USOJsU//c+7SJKyHFkvN6yqqfKP4fMmgFZv2Pn2I2HHoKkVVgnHD7/fJMandnhlTy
	 hTrIbwv3C2zpift5mNqMEUjHmrpzBohjig82bOx3+/bmVArIdg2LuHiHgXPsq3ILDZ
	 YIAVAAvjmn6fr1FQPen5W/mRnB555ZOKASx5kZZVVrZCV0l3LeGdP9vlGnJGZa4Jlt
	 IdRHtTmS03bSaFQGIPzVFYhgPHyP0wgtGnGRvddLdTAY5n2V18flmxjls8Mao5fKWv
	 HBt2K/YfCI82+r3h1hvjiU5GeoB5ijmmQ18pol4+G7ArDLSzlWt4ogTHBrYIrh9shy
	 ecZ+iO++OOTpA==
Content-Type: multipart/mixed; boundary="===============1840102539472080966=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5ece679164a4c99cbba93f55c2f9609be6e315d4813737a15b083c9f7dffa17f@mail.kernel.org>
In-Reply-To: <20260609233407.2711577-1-yonghong.song@linux.dev>
References: <20260609233407.2711577-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Keep int return type for tailcall subprogs
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Jun 2026 00:07:06 +0000 (UTC)

--===============1840102539472080966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c
> index ce97d141daee..c4fadee5aadc 100644
> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
> index ae94c9c70ab7..6fde0ab92148 100644
> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
> @@ -25,8 +25,11 @@ int count1 = 0;
>  static __noinline
>  int subprog_tail0(struct __sk_buff *skb)
>  {
> +	int ret = 0;
> +
>  	bpf_tail_call_static(skb, &jmp_table, 0);
> -	return 0;
> +	barrier_var(ret);
> +	return ret;
>  }
>
>  __auxiliary
>  SEC("tc")
>  int classifier_0(struct __sk_buff *skb)
>  {
>  	count0++;
>  	subprog_tail0(skb);
>  	return 0;
>  }

The patch adds barrier_var() to subprog_tail0() to prevent the compiler
from optimizing its return type from int to void. However, is the
approach sufficient for classifier_0()?

Looking at how the patch handles other callers like classifier_1():

> @@ -41,16 +44,22 @@ int classifier_0(struct __sk_buff *skb)
>  static __noinline
>  int subprog_tail1(struct __sk_buff *skb)
>  {
> +	int ret = 0;
> +
>  	bpf_tail_call_static(skb, &jmp_table, 1);
> -	return 0;
> +	barrier_var(ret);
> +	return ret;
>  }
>
>  __auxiliary
>  SEC("tc")
>  int classifier_1(struct __sk_buff *skb)
>  {
> +	int ret;
> +
>  	count1++;
> -	subprog_tail1(skb);
> +	ret = subprog_tail1(skb);
> +	__sink(ret);
>  	return 0;
>  }

In classifier_1(), the return value is captured and passed to __sink().
This creates a use at the callsite that forces the compiler to preserve
the int return type.

Without capturing and sinking the return value in classifier_0(), could
LLVM still create a void-returning clone of subprog_tail0() for this
specific callsite? While subprog_tail0() is also called from
tailcall_bpf2bpf_hierarchy_2() where its return value is properly sunk,
the compiler might still specialize the function differently for the two
callsites.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27243286945
--===============1840102539472080966==--
