Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9DE31AABC
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786941742; cv=none; b=Ha/RRpUtdbW1VySOkZairKSQhD14s6sZY2yLGPyOw06swSD8vEFoz2+/M83LN+Tu/E5C+KC+W1oLNCr18yrJ4HFcSqxHf7fPfNx+kwMsusL74pXT67CP+Xzb33Pena4x8bNJE1uRQ5vHqRVcizKPcJVob1xYeSnbXdxYB8mNkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786941742; c=relaxed/simple;
	bh=7B3yoABiPB5ruEvyYHTbdmPMIkIOakI6JOV+mZ2uz6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NVB671HLCs6yRh1KQJYLk1EUnHAmtwDrD7eNz0GjbpTJy+30FrG44a8uhR5x298dTWFRzZYmpiTlB9U7cuziT1vXcZAazU3RX5w5pXeJZd4cZZHnHWwkGOThxPaxM2Wtkx19CkxMJBB4myUdktjS3gNjJPxITIgIKzBUjOKGCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7/H++vX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7/H++vX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152F31F00A3A;
	Mon, 17 Aug 2026 04:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786941741;
	bh=rpA241MOQkUnX3zzS7U3R/Wde3p9e96Is6UTdI80MZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C7/H++vXrEMmioJ2xiifI+K3QZvUK0k/Zpi8S/MVd26jUsjxJJq/e2lOKBabsBPKI
	 1CNKHIYPo0XgBtIKRo1zSQW+d+7uurbJVr1PyakGYNYtIif3pG4oUdGtgFb7ics8ba
	 BjSD1VUT1jfWrY0wPTc1dqqv+D45dG65+9X1tt9LPUTbMMPq9fPzHqm3hXn5XrE3Jm
	 oI6n5aPPBFDsA+0qhqRJ1OS3YnicWEddl0F1qWTdK4ip4rIDjMJUlyruQ0bcAEX8Gr
	 7RctEsJJYWdq6pLcCmaj4YCzlB50sujatb7D+ZF7bjldpe8pLn/sP2igoQxPp6LQYy
	 aJ45b5XJQsWow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 09/10] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817042227.2296079-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
 <20260817042227.2296079-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 04:42:20 +0000
Message-Id: <20260817044221.152F31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test `aggregate_ret_kfunc_too_big_fail` is incorrectly restr=
icted to only run on x86_64 and arm64 architectures.
--

--- Patch [9]: [PATCH bpf-next v6 09/10] selftests/bpf: Add inline-asm and =
subprog tests for R0:R2 returns ---
commit b44fbeb59afa99f6be0f33037220d124e0fb4e12
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns

This commit adds BPF inline-assembly tests to cover BPF-to-BPF returns, kfu=
nc
calls, backtracking, and liveness for functions returning values in the R0:=
R2
register pair. It also includes an extension test to ensure a function retu=
rning
R0:R2 cannot be replaced.

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/to=
ols/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
> new file mode 100644
> index 0000000000000..c23b4beb1773c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c

[ ... ]

> +/*
> + * A return value larger than 16 bytes does not fit in R0:R2 and is reje=
cted by
> + * btf_distill_func_proto(), before the KF_FASTCALL and JIT-capability c=
hecks,
> + * so this behaves the same on every architecture.
> + */
> +SEC("tc")
> +__arch_x86_64 __arch_arm64

[Severity: Medium]
Are these architecture restriction tags intended here?

The comment right above mentions that this test behaves the same on every
architecture, but the __arch_x86_64 and __arch_arm64 tags artificially limit
aggregate_ret_kfunc_too_big_fail() to only run on those two architectures,
which prevents the test from running on others.

> +__failure __msg("The function bpf_kfunc_call_test_ret_big return type ST=
RUCT is unsupported")
> +__naked int aggregate_ret_kfunc_too_big_fail(void)
> +{
> +	asm volatile (
> +	"call %[bpf_kfunc_call_test_ret_big];"
> +	"r0 =3D 0;"
> +	"exit;"
> +	:
> +	: __imm(bpf_kfunc_call_test_ret_big)
> +	: __clobber_all);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817042141.2286=
086-1-yonghong.song@linux.dev?part=3D9
