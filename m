Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8F149C6F;
	Thu, 23 Apr 2026 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962454; cv=none; b=Ra7Cea8oONmFRZ9As9nLkb6Sy18ror5vm5xJlYgfV6ZAAOuuXkn/PJq1WQbJY1iwLYKf53cta78vio7px4ytQgJxJTIbjMo/N/NjtkLU/3f4a8oj/mUOCuKerXGaHfW+aLVma6vDJ6Q2skng81y0w22s/HQ5QVJMlQXVCZhXAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962454; c=relaxed/simple;
	bh=qtMqP2CIxPQrxZ1QJN0QPE2krKJvUp54gRPuBJevL2E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=uyrMxMj7t9/YvG4tZox1Sq4SZxKtTunHMxIJQRZCbTJbOLDZohXCdwv/X//vjantYa/IJOLwrjS1OOyBCGkGuUzMtfRSqx3KlVuJfZ6cdL4DSZaAgp+4J/+CkAMjUVay/E589QH4aPpw9vcSzveQIjXusMxnQ+5xixM6l+T1fQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4wTiW+Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4wTiW+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A98C2BCB3;
	Thu, 23 Apr 2026 16:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776962454;
	bh=qtMqP2CIxPQrxZ1QJN0QPE2krKJvUp54gRPuBJevL2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P4wTiW+Q1bHA4mYeSdKWxjx7dnHRfgWVNoU7Ry5UvSTnG9bQx+3m1aAshmyKVHGBY
	 6rJSRJn1Wg+ZylcNpRM8/dKZs4Z+1zSqMQwZgCz2pIaZ8UY5SGGxLJvR9MGRqf1egK
	 zl1FXDPR4jOdCbftkaJhKCXXpbHH6TVNHB8cHMk/cGbRGr563iphi14zraO94o4P1e
	 CMIRyesgjT+M+EeunlDSDkhWoRTc3Df5XV/4ZR2PTtWzYP3OLKwu35RJmTyabNXjI1
	 vgh56siKIk0Z5WJduNWDXR1Np05dJTz2pDpf/p8qitMg6VrqMTjC1F0SSz8MAeRu8y
	 QhSIf+M7vzSuA==
Date: Thu, 23 Apr 2026 06:40:53 -1000
Message-ID: <052cebe617ad5120619de62e3fbf180e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 Zhao Mengmeng <zhaomengmeng@kylinos.cn>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] selftests/sched_ext: Include common.bpf.h to avoid build failure
In-Reply-To: <20260423-b4-selftest-fix-v1-1-8c72287bde3d@kylinos.cn>
References: <20260423-b4-selftest-fix-v1-1-8c72287bde3d@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

On Thu, Apr 23, 2026 at 06:42:35PM +0800, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>
> In scx-cid patchsets, sched_ext selftest failed to build with following
> error:
...
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> Tested-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Applied to sched_ext/for-7.2.

Thanks.

--
tejun
