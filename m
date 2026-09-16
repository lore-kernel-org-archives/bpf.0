Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C84D7D39
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580407; cv=none; b=aGG78n/hVSGPs6QdttMHY/cZZ5xH51A/mcGflcMur5xuc8e7wZ0WqpreAAN754lUFNh5mOxZJr2rkpj2cD5hVOYH+9rTSEeL+GIKWlzS8GXYcc9CWhqnTT0143qZBCTtIWywPnetRFg+/5kWNbv75di4bwMs2u7NCYiwUOp38X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580407; c=relaxed/simple;
	bh=5r5rzNesy1RynHdGNmoY74vLXmHUja1C89Oqm4mszyw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iwTWFFx2qhpfaTUTbAUNJ1IO8Db+lF5nervIhmdzyuMjOuQnzuScDltIhSlMf/ykJ+gpV7WHdafjcmEbFHlMC/puOmHhuqtaprXjmfoxfPOV55vHIvH8C+4kBF3l1DUd19GlCj4zNEMxZMbQiBHCUoSUKIIJFXxWPDrSQig/lko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdQtNVMo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdQtNVMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D3A1F0089C;
	Wed, 16 Sep 2026 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580393;
	bh=Ydml3+7mjEaQx4zvW7EXKuWMQdkCeLRtU8tEFa4CulQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MdQtNVMoxoVtWZgqf0HzhAT9VXTKeLQB8cOgU5jV2IgozuoVyfwATQixFm5tB1s2Q
	 qCqQJoHJ19wcopYVUI55DjYp7KdmXAYQ7vrj8cbTA4Qzdjp35UBocXDBQAME7dC+A1
	 8eGVWr9c0o/2W+So2xY3dwDOrCsJZ5akBZmZicE1gJE/Ru1uQ2aQb5gCpckdzawcsZ
	 Mn5SKvLb9/uYdHij0AXectxcqa9MUhSoANE/YOkKVvkum/4klXoxXT2LcY8zGfIw7w
	 vfikyt5cmc3BgMuLpuEL3uklA6hFqVGXlaPZApsDN7q7H7X24G3qbRxlJ7WUawDOrZ
	 4GTpv1g5+N/6A==
Content-Type: multipart/mixed; boundary="===============1902048744976539848=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a4cbab6c592ee86851dd3d0b3e7e28ecb6a2cf5a7e97992b99225d28c81f73a@mail.kernel.org>
In-Reply-To: <20260916160821.3157543-5-memxor@gmail.com>
References: <20260916160821.3157543-5-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpf: Support multiple __uninit kfunc output arguments
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,ameryhung@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 16 Sep 2026 17:39:52 +0000 (UTC)

--===============1902048744976539848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> A single output descriptor cannot retain the initialization ranges of two
> __uninit memory arguments. Track raw-mode eligibility and the definite
> output size separately for each argument slot, so a variable-size output
> also leaves independent constant-size outputs intact.
>
> Normalize helper register numbers and kfunc argument numbers through one
> slot conversion helper. After checking every argument, initialize each
> recorded output. Skip empty entries before looking up register state: an
> unused slot need not have an allocated stack-argument record. Helpers keep
> their existing single-output restriction.
>
> Use the resolved BTF parameter when looking up __uninit for stack liveness.
> A preceding by-value parameter can consume multiple ABI slots, so its slot
> number cannot index the BTF parameter array. Keep this argument-slot handling
> with the extension rather than the minimal single-output regression fix.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This looks like a bug fix for multiple __uninit kfunc output arguments.
Should this include:

  Fixes: ae6abae582b7 ("bpf: Recognize by-value struct and __int128 kfunc arguments")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35122594381
--===============1902048744976539848==--
