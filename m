Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFCE42A7B5
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567909; cv=none; b=NvXxix40MojWrXEZgtzu0+jadWe4BPKoQX8v3qRH5DDUG6jWwWfxvGyEj7BVfUR0N3Zv+j3cuohB/LuSrGZBrLBZPKfWiMr0uRRxHzHMdBXnrAGAcWIJk9UzL9koivMSyE7oRak8NxjItSSWugJprwx8cKhc2/sItqsLTJT528g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567909; c=relaxed/simple;
	bh=J/9mAzxq/x64a9MmvZNMoVxvXmCzPr6XZTrSZChSmvA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YOnDQQOEDKb20k4T+6bmat5HRMhjURU8shUMAlMKPwBFuZGuOWCHj2qLPpAQ7zPMT8LnxIoJC1Kk6ntCYRvuHktIfMC3tpvND+cN+uA5R3mCBsqO3kmLqTRqGKb+kry44kAihw/DZ1iwzElkOKe25c9wqIasleOaWkqBvgkMazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vmz3mMmY; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vmz3mMmY"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38511175ad3so8517808a91.2
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784567905; x=1785172705; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Utao4Hvq5bT+gyJsbMuAG0Oh4DBF5Bnual8IlLo6Qic=;
        b=Vmz3mMmYcsmA8MCKGG8TOxCCbu+B6N20rDggKC1rG4XDj+m/soKKkJcXQfCov5CjpU
         dtnRocRbkV9gh7ASoBvXseEw8aRNFk6dxnLexOWONSTfJzPxixiHJvFj4nYxeDos9VCZ
         aFn0eOFb0uf5uXPnUf315uhqUahNg3NDk7Dz9+xVXle935ZstukrnTzrrIBY+4aBQatM
         cQCYmSm+CE6G0dEk79R4fGGyGA3iUFFJse4EusOGM6+1ld7JpmQ1rGxDlb1FBcl2jOvY
         EPAoO4UlT++FXjpX1X78jmT2FHr3obv+lY1l2lZCcMRV20dZuT366ZBn8qC6jxlDGmzy
         kkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784567905; x=1785172705;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Utao4Hvq5bT+gyJsbMuAG0Oh4DBF5Bnual8IlLo6Qic=;
        b=sRO7U0ej1NtE13JOBctNaDrgt6fHw9nRNBOm9Qrwa2PRLr83qkp+SVbzinkrHq38Bc
         cwLVEqR2dy8tOJmJ2ggxCc2kEg6tkmielK33c/HLjoZbsmXVfxkCR5ic/6T5Tp7fJmXD
         tgFXaNLP3NGCXzH0zulXz6RLYnMzO6tT1uQOAeS3uNhEcOZQ8SF2EwoakZC9fKMbcKHU
         4j0F8HJPZC9U7MpZM7LNFSRxtlz0r1uGh1j7dPa4sPl6J+vLiQ8d8g6wJeu9gt9GeAzF
         d7KmT4MKW6dgnw3wStDb/qw2Cxwp/DSdEVB11EdXnDuCxvL3euBuhuA7ZCaiyRUb2/XX
         Z2Yg==
X-Forwarded-Encrypted: i=1; AHgh+RohHKeYAxIcE1Jv9y9lkP/piLxoDi3gYahOyBAbhtF9ust1GP565MPa6pZiiwabDhqQ3HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdGrqJcJfnMHHC50dXeRs+6iiQPXQHufpEguGgBIRRoy1UqoM
	LgRGEi5Ep47HKB4ox+X9R7eReb7KBu7VZdZTAuxCoQ+qWqHIMpSCh55c
X-Gm-Gg: AR+sD11vcDaeb0uWYYehSnY20fOsksyhhTzWSL7pUgMVebMDFKmhMHExqrrRRV/DA0i
	/vTvYQJzsmarM1IZdzEfOpT6ngiphhLDX02boeGJNRYI7IiL6UKRY1BU0i24mbztTuV6zR6PEE8
	2pCy+TJTxk952FH7pu/Gj9j4EJQfQpSFURDolp878SG1M/vacSqMcdhVBt3KH3cdj8UEcI7/kG9
	UY430AFJHSw2CmpQ3XTLKYwIuNUifLEoPqFcZjjCoz8NUQ2vEOlrA+s1xVvKx4QiVt7iqscyxO9
	2G4lqM/qYPDYXe89D3ErC7XQy2SgV7TTPN7yruJkLPc1Msc7H/r7tFtKcRtXWXJRrd1YnNjElDW
	dZd36ljv0Gnrq7q5beyxm9FltdGUIIdAdD2tGcufWytD3yPuLLPFuTg3Tr1vY9qETpmUb5FRoZI
	rXfQ100WMAuyrBp6L+KcvkOfXsEIkYRYha66exiEkc
X-Received: by 2002:a17:90b:1f8d:b0:38d:c0f9:30be with SMTP id 98e67ed59e1d1-38e4b578797mr15140965a91.38.1784567904969;
        Mon, 20 Jul 2026 10:18:24 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e92169cebsm98875a91.11.2026.07.20.10.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:18:24 -0700 (PDT)
Message-ID: <69deb2a02562e0ee9380adc0154888c03193fe30.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover stack frame number
 after scalar plus fp
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan	
 <shuah@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 bpf@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 20 Jul 2026 10:18:19 -0700
In-Reply-To: <f081c0dc908da30006f5c72f0654a723c171d0ca.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
	 <f081c0dc908da30006f5c72f0654a723c171d0ca.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-20 at 16:37 +0000, Yiyang Chen wrote:

...

> +++ b/tools/testing/selftests/bpf/prog_tests/verifier_basic_stack.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <test_progs.h>
> +
> +#include "cap_helpers.h"
> +#include "verifier_basic_stack.skel.h"
> +
> +void test_verifier_basic_stack(void)
> +{
> +	struct test_loader tester =3D {};
> +	__u64 old_caps;
> +	int err;
> +
> +	/* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here=
 */
> +	err =3D cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
> +	if (err) {
> +		PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(-er=
r));

Why is this necessary? It should be possible to prepare a test case
demonstrating the bug w/o this change.

> +		return;
> +	}
> +
> +	test_loader__run_subtests(&tester, "verifier_basic_stack",
> +				=C2=A0 verifier_basic_stack__elf_bytes);
> +	test_loader_fini(&tester);
> +
> +	err =3D cap_enable_effective(old_caps, NULL);
> +	if (err)
> +		PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(=
-err));
> +}

...
