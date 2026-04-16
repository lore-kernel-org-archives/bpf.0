Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A773C65F2
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353278; cv=none; b=DJ6w7lECMqjNEWOnu3I9uW6dt89pV9YH5VKykxlfvbX31sYHSJyVSrq0lRATPNz/7ilJgVcIyytn8+v/XAxhjyKBR5IILmsAX0td5sZ24Dhj9wtbFpfIjL+Ffa7Arpab03nzWSc0cofeemiCI1ae7ihOjaNHuXdV56Qq8ceJWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353278; c=relaxed/simple;
	bh=BVmjIMfHcVF65RsNVTz+a8n6kXj3JAokPZ7sgZ3xTrQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=s59g4DOk1+t1XBWbqlSnVuoBjNz0SZCxnr/oKgrDoI4/12fcYHPCjaS08/zyhQYYmOQiH4vC19FIRqP4NPZmQXywmhLJpiGNnM0q2zcY5PC8rXP1cMqxTLBWv4rDfDNcudRclfykvWGeA50eWXf8YLkFw2nqIzIBiYO0eF/NP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTyMEQfT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTyMEQfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2671FC2BCAF;
	Thu, 16 Apr 2026 15:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776353278;
	bh=BVmjIMfHcVF65RsNVTz+a8n6kXj3JAokPZ7sgZ3xTrQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pTyMEQfTg8P/BFj6T2pjUon1Uxf/Ke3XNTRrdrHxDhumSLw+1G5nwdb3/9Htjhf0A
	 Ip2q88Xb1rzUxDLrS+majt1X93SAmw6vdp9wU7Qjmo7utlu+fHiqP6HY9SI9+iKVlo
	 VWWap5uXA5cQ+Ynj1Lnny12PBDP5FOhBy6npKIcY1uyraqHXaw+8r3+/SZ3w51fVh4
	 oGcCTi5QEQ9EbVtXP02O3OkFHgHh6+Og1z+i42lw9ZNO+ZeK1ESKJUju50uDMvNFWR
	 2GlP2+7HZh+SCyH/uaFYin61TJGyFB0xTA0lbc5yv3/87Xh4C48VdweVgM8D+BI7bk
	 1qA84+P515jpw==
Content-Type: multipart/mixed; boundary="===============1039291910134732484=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fe90165d5cfe442a4af9b5e75818f1b18cebf63d1ac52c6d7112bcec755c3e0c@mail.kernel.org>
In-Reply-To: <20260416143904.1220662-6-alan.maguire@oracle.com>
References: <20260416143904.1220662-6-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 5/8] selftests/bpf: Test BTF sanitization rejection for invalid vlen
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,qmo@kernel.org,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 16 Apr 2026 15:27:58 +0000 (UTC)

--===============1039291910134732484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
> index 652b51efafc2..1349fc7b34e9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c

[ ... ]

> +static void test_btf_sanitize_extended(void)
> +{

[ ... ]

> +	if (!ASSERT_OK(kernel_supports(skel->obj, FEAT_BTF_VLEN_KIND_EXTENDED),
> +		       "vlen_kind_extended_supported"))
> +		goto out;

Should this be ASSERT_TRUE instead of ASSERT_OK?  kernel_supports()
returns bool, and ASSERT_OK checks that its argument equals zero:

    #define ASSERT_OK(res, name) ({
        long long ___res = (res);
        bool ___ok = ___res == 0;
        ...
    })

When the kernel supports extended vlen, kernel_supports() returns
true (1), so ASSERT_OK sees a nonzero value and fails the assertion.
This causes the test to skip on kernels that do support the feature,
which is exactly where it needs to run.

The later assertions in the same function use the correct macros:

> +	if (!ASSERT_FALSE(kernel_supports(skel->obj, FEAT_BTF_VLEN_KIND_EXTENDED),
> +			  "vlen_kind_extended_feature_missing"))
> +		goto out;
> +	if (!ASSERT_TRUE(kernel_supports(skel->obj, FEAT_BTF_FUNC), "other_feature_allowed"))
> +		goto out;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24517220149
--===============1039291910134732484==--
