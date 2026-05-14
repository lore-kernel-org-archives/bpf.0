Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9561E7C2E
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787469; cv=none; b=bVK/lfmIGIanlRbgR/bIncP5GsthiXuTpzmYz5oCkVMf2gR3e7KQjpalKDA4pPAyrU9tyGVgKN/jHFQj3723ukPEbARBdHIlBjk/Hck3qJhItgtRNlZM7FSLmJ3obgmVRRjWtm0BeQeqgGGh2VE52LWc5d4+XCeH/1BEaafA0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787469; c=relaxed/simple;
	bh=nAUdVtypzlz6SKSs6naG6vpIGfheqUKjsVDbwZLePvE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WEu3qy0D87JBMrWuj8ONugC1n+KF+MXHlu2EMPIJTKrF1Q0B8qZMt3MU7kNVwK7Q3rKlortQpSBcINPfYYSsvHl54q7Skvq540dpeQx9N5T8UlCb+k8hIdn/PwhGj3pRGhtN4aLAOdwEF1SQRTzZyHye2MfcF5z6cfOfigaGBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgZYVzVS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgZYVzVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B566C2BCB3;
	Thu, 14 May 2026 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778787468;
	bh=nAUdVtypzlz6SKSs6naG6vpIGfheqUKjsVDbwZLePvE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=qgZYVzVSIJlkpu8SqMrohptCAe/BQRgM1x61ZeZl+rCWg/o2ZN2p9zn9G407bqWvS
	 Th3IekPJp3mbDRm8gaIvpJ5mgMM/ccsMecUz1Bwh09Ev/bZy5bYLICvDXtxrfvo5M4
	 orOGoe/ZnLwOhVtng7PM2EFEjoYWpmlbDfP/83PR+aT6sTusAcquAXge2w8YaaXuM3
	 hEAGwL4hcp5vYM5cX2xS61MGNVM6HQZttt9hVcNji48Z40lg7fwncsp8P2yM30tjGd
	 BcuViklQGoqg8/P/9nRCanOMDDWXmZ+SdPAYLeW1/tsQrIAlX8qCBU89N3FwnTimWu
	 /1ufzpEs6ce/A==
Content-Type: multipart/mixed; boundary="===============8602684434972135634=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b3a04daccb7920ec037fa1e814c82d13b626bf24ceed7e03cf54624f9bf477de@mail.kernel.org>
In-Reply-To: <20260514184827.1619863-1-yonghong.song@linux.dev>
References: <20260514184827.1619863-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: Validate outgoing stack args when btf_prepare_func_args fails
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,martin.lau@kernel.org,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 14 May 2026 19:37:48 +0000 (UTC)

--===============8602684434972135634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 284cf62e75bd5632d61c528e48fe3f738870b269
> Author:     Yonghong Song <yonghong.song@linux.dev>
>
>     bpf: Validate outgoing stack args when btf_prepare_func_args fails
>
>     btf_prepare_func_args() sets sub->arg_cnt before validating arg types.
>     If validation fails (e.g. unsupported pointer type in a static subprog),
>     check_outgoing_stack_args() is skipped because btf_check_func_arg_match()
>     returns early. For static subprogs, check_func_call() ignores non-EFAULT
>     errors and proceeds with the call.
>
>     This causes the callee to read stack arg slots that the caller never
>     stored or not initialized, potentially dereferencing NULL caller->stack_arg_regs
>     or getting no-initialized value.
>
>     To fix the issue, when btf_prepare_func_args() fails and the subprog expects
>     stack args, call check_outgoing_stack_args() to verify the caller initialized
>     the slots. Return -EFAULT on failure so the error is not ignored.
>
>     Reported-by: Sashiko <sashiko-bot@kernel.org>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for stack argument handling. Should this include:

  Fixes: 3ab5bd317ee2 ("bpf: Set sub->arg_cnt earlier in btf_prepare_func_args()")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25879695095
--===============8602684434972135634==--
