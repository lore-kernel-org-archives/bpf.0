Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F4D4E66C9
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011278; cv=none; b=DNQO7po4VuAiwGrkGWI32Af2fCzOQInZiRRv/SxJobXfLltcV+aQP2JPQ3TEUYFyLoMmj3PxUrouJH+oaeGhClgbGmt3qkr+ZsM4ihHkknO82SlBsltjvGm5Ix7wHaOGh9/PwwrguyfSF+3fmkB9Ti2ULdlkmixWBzW+Ik19IRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011278; c=relaxed/simple;
	bh=mlfoHnj6RhIaalSbN67rYpZSySnizCIH3UbIPvCVvnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S1BGTnFaEduPywW7rUi5Jt/mMsAYC/svgGAwEkvvVoz1hL19spDHRqnlzQQJ4eKpQAH6xgYv2ALyvpp/BdA/f+yRFbjPDplLDuAzC41590YtqGKFTFMjUbiImXP2awNJ0elOx7+BpDCfhAN82YLbE5vFXO+5hzfKvToqlJD29oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBj6EAG2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBj6EAG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077ED1F000FF;
	Mon, 21 Sep 2026 17:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790011277;
	bh=+4gUjEkCrqzU1gwBeh7/uvPwa1uJaxs5lbfp0nv1C+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cBj6EAG2jaQ1ekRgEG6zKp5v5FhXL5K+4vzFtVulYdPVlJz1/MRsjvtYqkH4M+YZs
	 b9Xnu/l6oYBxu9Yf2vKwtE/sEn6zQS/IYzF9njOagvE7BA+ASWDLGVR96n8bPwWi+i
	 b+CZdXk8h/5i8Zes5ZKkbinXraAgLPwX/+lYgkLg5Dl7bTfhOJboht/ntezGeZ5fd7
	 jdP8l4lLjeZdKEP8kydLJfpaN7UVo96Al2U2aKI2JWLk6DscgqCE4iX3w+cIFWiY52
	 0EYcZk0Nn6eUWkXG66BR5z9Vw98hfy4QQ8ivBvzBeWxylc/yq0aeWPPQ5xqP1XnxnA
	 UmQszVTAxnCKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B583927048;
	Mon, 21 Sep 2026 17:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 00/11] Fix generic __uninit kfunc output
 buffers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179001120864.3142019.5279636337497659902.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 17:20:08 +0000
References: <20260921023843.411943-1-memxor@gmail.com>
In-Reply-To: <20260921023843.411943-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, tj@kernel.org,
 ameryhung@gmail.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 21 Sep 2026 04:38:24 +0200 you wrote:
> Generic __uninit kfunc arguments are output buffers. Stack liveness treats
> them as writes, but argument checking still requires readable contents and
> does not record definite initialization after the call. Check these
> arguments as write-only and record privileged output initialization after
> validating all inputs, including inputs that alias an output.
> 
> Following Eduard's rework, helpers and kfuncs record generic outputs in the
> same argument-checking path after type resolution. Generated kfunc
> prototypes now mark generic buffers with MEM_WRITE, so __uninit buffers are
> checked as write-only ahead of the fix while ordinary buffers stay
> read/write.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,01/11] selftests/bpf: Allow privileged preparation for capability tests
    https://git.kernel.org/bpf/bpf-next/c/06046a8a50e8
  - [bpf-next,v5,02/11] bpf: Record raw memory arguments during argument checking
    https://git.kernel.org/bpf/bpf-next/c/e2b4aaa75040
  - [bpf-next,v5,03/11] bpf: Check __uninit kfunc output buffers as write-only
    https://git.kernel.org/bpf/bpf-next/c/fc8dc2be101b
  - [bpf-next,v5,04/11] bpf: Fix generic __uninit kfunc output buffers
    https://git.kernel.org/bpf/bpf-next/c/fc670d4b6c31
  - [bpf-next,v5,05/11] selftests/bpf: Cover generic __uninit output initialization
    https://git.kernel.org/bpf/bpf-next/c/a8bbd9ee1bbc
  - [bpf-next,v5,06/11] bpf: Support multiple __uninit kfunc output arguments
    https://git.kernel.org/bpf/bpf-next/c/bca730ba6df6
  - [bpf-next,v5,07/11] selftests/bpf: Cover __uninit kfunc output argument slots
    https://git.kernel.org/bpf/bpf-next/c/89835699ef4e
  - [bpf-next,v5,08/11] bpf: Preserve stack initialization for generic output buffers
    https://git.kernel.org/bpf/bpf-next/c/5da4a9f26fca
  - [bpf-next,v5,09/11] selftests/bpf: Cover generic output stack initialization
    https://git.kernel.org/bpf/bpf-next/c/a25a61385b04
  - [bpf-next,v5,10/11] bpf: Check read access for helper input/output buffers
    https://git.kernel.org/bpf/bpf-next/c/7a6cef39b760
  - [bpf-next,v5,11/11] selftests/bpf: Cover helper memory access permissions
    https://git.kernel.org/bpf/bpf-next/c/ad36589c3f39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


