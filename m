Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF339DBCA
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650398; cv=none; b=aBXZlAcEfAoKtFaKwjNGVi1btr1CTUhEAZdgx2c4vZKOKU/NCvQttItIrTk0ZVuKr/LDaHWMNH/YKgptviczq/f4NLZXyQsgOxo2KLjw5kFevDs9ykD7tmSRmnPwPn+R0IpeoTtmSo4Q4XlTyCwMXXSsPRifi5Nm5Rb1c1Tx+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650398; c=relaxed/simple;
	bh=Enryows0PoiXWng43tI6/1zSpEfeZ3lFCkydnIJEq/w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ErPPSUsPYTNAysaEXHvkapq5Aiu3zUzOt2lJV4xS0u29T1TCC3tcfyAoVVV9rtu1ScgcZp5k/5+wu2FY+KVkbJCw1HdsqDmb5LjCc5dLsDzNUjuSwV9phcERLUTY9YU8i5XmObSLGjVZDjSK76Hw+dK5d6EHJPiaBdwa+rEijb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBkvWPG5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBkvWPG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106B2C2BCC9;
	Wed, 13 May 2026 05:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778650398;
	bh=Enryows0PoiXWng43tI6/1zSpEfeZ3lFCkydnIJEq/w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=DBkvWPG5f8QQ/G3NP4vlsqQjheDFYwHt4fFnpbwZ8qTwovjiIdrGTxXBwxl9ZmWKf
	 MRoymBeO2k1QD8q8xgetMdn8Rc2CJGqzKMHZxCmCYHgf500sM+PYRKteK+cUM8+Cb8
	 8xp0juySWOTYDMv/80ajleiCWsFOciEfo+1WBDZg115+I09vXGJ3ojJeIHYeCsG/Y5
	 ibFN37bZTIIsj1xJCfp3KJ3AQ5GO/BFSqE4mn3MEzbIeFEQ5dYVK2DXBxiA1+l661q
	 URM/HtmCdKNUO/TNFWx7YbLnIc9IIhqebHXoT4ejmlO6wndn2E9C3qzRogrISD5YD+
	 rqmYvIMXep38w==
Content-Type: multipart/mixed; boundary="===============5983253498017469537=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d49b79469bc228351fc108bab237a35fa99400b80afa88a20f97fc194970e594@mail.kernel.org>
In-Reply-To: <20260513045114.2392291-1-yonghong.song@linux.dev>
References: <20260513045114.2392291-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 16/25] bpf: Disable private stack for x86_64 if stack arguments used
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 13 May 2026 05:33:18 +0000 (UTC)

--===============5983253498017469537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 86c79df525268be6b8e148743cb68e4d7a0a2956
> Author: Yonghong Song <yonghong.song@linux.dev>
> Date:   Tue May 12 21:51:14 2026 -0700
>
>     bpf: Disable private stack for x86_64 if stack arguments used
>
>     Other architectures like arm64, riscv, etc. have enough register
>     and for them private stack can be used together with
>     stack arguments.
>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for stack argument support. Should this include:

  Fixes: cc06010ca1b8 ("bpf: Support stack arguments for bpf functions")

The issue appears to have been introduced when stack arguments support was
added, but did not account for the x86_64 specific register conflict where
R9 is used for both the private stack frame pointer and arg6.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25779371388
--===============5983253498017469537==--
