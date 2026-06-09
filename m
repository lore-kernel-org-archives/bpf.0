Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47281320CAD
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048573; cv=none; b=Lgn7MMOVVuiXcgGODbD3g02RJ48ATHRuVaiwd0VYDiU75NWtqjuV5EmpMNfdvfTX4Dhpgqb6sclgb5nGsYx6je/od3nVVbAqRZDc77PX6gKqpBhE7RGGDTR7c2pvyY3jUnHFBfjlEO4nM6IqB3g0fQR1vDUx7uHz2JLGyw/qavc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048573; c=relaxed/simple;
	bh=75iCoFqsz2ZMH4aQfVo66vDU2KbO4ay1vcsSx6U4lZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SpjUMTgaFoC2fFuplCf+77COMXJTADi+j337n4CqGZ6uGQ4YS/jiIiHaSSknyRdCzdeZYf2EAntC8g9HEju2S346ldx8+UkmUiYd1bRsy7o30Aa1W+AwOJ4ivgd3bZu6TWZUHLtIzaXcHNMYHFhLu82bCd2vq86TML/PpLvL4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp3YQQYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp3YQQYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A6F1F00893;
	Tue,  9 Jun 2026 23:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781048571;
	bh=XnboPxtmcqhsqI/124STDHm0pmsMqob/SlHVyNpjBbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lp3YQQYMTAHNIgqHIjPDAod8J8CXQurrTS5Ij42vbS8LKaGEWZuFZIv8Wrzb95532
	 RHTx4uHKjkC5JLO1tSDrzdY6v6RT+tXVuX9lfwkWBqqKSlpYPSGa3+c+1nkyASHSkv
	 QniiBDyIo4CVglikDl6pY9zDu9pUOHMdC96bngsCKAmTCB89xikcCHwYaJ8LKWTtA7
	 /ylbysMrmsquUCW92QxZEcMUSTWZJ1AZoajfSQW6dpGSXK0BAGy3VAo4fW/3ynH728
	 k7qFeNhbrA7h1HUoLKKaMyivEA4IvosTbBUrurVCVkbiIrLVyjbuWNfWs5ih4l9yMw
	 RaUKyISNIUJ3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Keep int return type for
 tailcall subprogs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609233407.2711577-1-yonghong.song@linux.dev>
References: <20260609233407.2711577-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 23:42:51 +0000
Message-Id: <20260609234251.C1A6F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete application of compiler optimization mitigation in `c=
lassifier_0`.
--

commit 230de7228ec64290b0e30a90f68ca96dd2ee6dd0
Author: Yonghong Song <yonghong.song@linux.dev>
selftests/bpf: Keep int return type for tailcall subprogs

This commit updates tailcall subprograms to prevent LLVM 23 from optimizing
their return types from 'int' to 'void', which would cause verifier failure=
s.
It uses barrier_var() and __sink() to ensure the compiler retains the int
return type.

> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy=
2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
> index ae94c9c70ab7d..6fde0ab921486 100644
> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
[ ... ]
> @@ -41,16 +44,22 @@ int classifier_0(struct __sk_buff *skb)
>  static __noinline
>  int subprog_tail1(struct __sk_buff *skb)
>  {
> +	int ret =3D 0;
> +
>  	bpf_tail_call_static(skb, &jmp_table, 1);
> -	return 0;
> +	barrier_var(ret);
> +	return ret;
>  }
> =20
>  __auxiliary
>  SEC("tc")
>  int classifier_1(struct __sk_buff *skb)
>  {
> +	int ret;
> +
>  	count1++;
> -	subprog_tail1(skb);
> +	ret =3D subprog_tail1(skb);
> +	__sink(ret);
>  	return 0;
>  }

[Severity: Medium]
In classifier_1() here, the return value of subprog_tail1() is captured and
sunk using __sink() to prevent optimization. Should classifier_0() also be
updated symmetrically to capture and sink the return value of subprog_tail0=
()?

Looking at classifier_0() in the same file:

__auxiliary
SEC("tc")
int classifier_0(struct __sk_buff *skb)
{
	count0++;
	subprog_tail0(skb);
	return 0;
}

While the return value of subprog_tail0() is currently sunk elsewhere in
tailcall_bpf2bpf_hierarchy_2(), leaving this callsite unsunk could
potentially leave the code fragile to LLVM optimizations that might create a
void-returning clone of subprog_tail0() specifically for classifier_0().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609233402.2711=
071-1-yonghong.song@linux.dev?part=3D1
