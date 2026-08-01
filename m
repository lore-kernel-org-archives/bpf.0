Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C51DFFD
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 01:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548002; cv=none; b=HQB8IB1OnwsbjLsJGkYhE81Kul82YD0SJd0tX3DScw0NIILNBOo1NoE6Quy75Ye3M5RNzK65VzPqCqEc8rpms90I0QGf+qXJvHvXb8x/buw+OOD7BOIsp6izv1JZHYBSLrnSaF1e7cYm9gCOyKhmPY2OqQzV0W7vh4/zZXVhV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548002; c=relaxed/simple;
	bh=8evT8uslq+X3gKy+Wo9GCQoh3rkY/MOMd5y7ztLsykc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jmqLbDAJ5P+OTEUg1O//Qu5uF5FA9N4Q6XLZge2AabIjrL8fqlvrM3YVgFn6wDjfO6Hsz3VFaK+TOOe6mZRuuv1l3IPRmFvfzv6cdSjkFsVonhnRDsAj8vRV7CqKrJFBgyizGiQDHf4zwLRqb6qcQ2lY3alxnwvSxllmqfxFD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjVBdq6K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjVBdq6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABC51F00AC4;
	Sat,  1 Aug 2026 01:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548001;
	bh=WNn/P84kPCyCz4pd6vR4BWpkcXQIJJm8rucZwFeLCLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TjVBdq6KUtPFcuiBRa1snQLuXCfzhy6UedbTsmKT3TjgHMAmFsHql883JF9xptQ7E
	 2ADna+pcircU8K3YBHyB0wmV5pzcBagd520vDHomT2LPjJKSqk4KbDGrkl/9sCQpId
	 hME6rt2g1sxl70u7e0ZwMKlaoSHEtqv1V/HeZ1z0UBYJvq9VSNU5B3mPI0Ow0mJjEs
	 wkES7VZuNgZw4nuKPLZyyNVuvikVxcyAesFyjdSXnUysTbo8xVPOuv9PBw9iaWu4XG
	 jH787oDwOXY6dESrOoCN0uAdN7RPYV+aV76tGxCDukRRZW072UMCPVolGiYYWdRq7C
	 z7Pp9JGZN13NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: verify zext_dst
 annotations for various instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731-static-zext-v2-5-da4aa161e8c5@gmail.com>
References: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
 <20260731-static-zext-v2-5-da4aa161e8c5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 01:33:20 +0000
Message-Id: <20260801013321.6ABC51F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing bpf_testmod dependency check in test_verifier_zext, caus=
ing spurious test failures when the module is not loaded.
--

--- Patch [5]: [PATCH bpf-next v2 5/5] selftests/bpf: verify zext_dst annot=
ations for various instructions ---
commit 9e656f5e6b04a69526327df6f70d8c362d02d3d4
Author: Eduard Zingerman <eddyz87@gmail.com>

selftests/bpf: verify zext_dst annotations for various instructions

This commit adds a suite of selftests to verify the verifier's zero extensi=
on
behavior across various instructions and state pruning scenarios. It covers
cases like 32-bit and 64-bit operations, atomic instructions, kfunc paramet=
ers,
and CFG edge cases.

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index be97f6887f0e7..fba562c819691 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
[ ... ]
> @@ -277,6 +278,7 @@ void test_irq(void)			      { RUN(irq); }
>  void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
>  void test_verifier_jit_inline(void)               { RUN(verifier_jit_inl=
ine); }
>  void test_verifier_ctx_ptr_param(void)       { RUN(verifier_ctx_ptr_para=
m); }
> +void test_verifier_zext(void)                 { RUN_TESTS(verifier_zext)=
; }

[Severity: Medium]
Since verifier_zext.c calls bpf_kfunc_call_test4 (an extern kfunc from
bpf_testmod), will this test fail spuriously if bpf_testmod is not loaded?

Should this check env.has_testmod and call test__skip() before RUN_TESTS
to gracefully skip the test when the module is unavailable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-static-zex=
t-v2-0-da4aa161e8c5@gmail.com?part=3D5
