Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913A346A11
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955263; cv=none; b=QuRUe6nnzvkf+BKtz9GZJIAxzOvapjaZ2IU898Yx8tdaXLb6VduagKq34rKHHAcXJ/rNVJ1QSSvXNAzCG/fchIWFHivuIco+p16RCFn47B1dUMProlhu5QrXtI5WFvGJyi2d3TktFNtK0W3oIxPw7RiOFbZvuVifs2w+/A5sayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955263; c=relaxed/simple;
	bh=H3iV9QCTsSyKK7d36fGVxDbmXus+VB42FNXqWfgiOJ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HOC/Xnc9Ax3Zx+q63Dd1KN9OFqigsecq40DrnzV1sTC2HXUfJcBwm2ffRF3i0mSLOtRiQ9XhKBaZ/ujVNboQ+PyLbVaQ4JIkDE+Az3rHmABucT6a66c5Za189D8UE5bcZ6OCwc85B9/c5aPVpoLBmXJleLrfzigz8Q8m78EuuTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3SiJibm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3SiJibm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2C31F000E9;
	Wed,  5 Aug 2026 18:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785955261;
	bh=I3F69YN7CqYnniEnwHAzrAz7P456HlmMKg10+MO54ow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U3SiJibmGBoDRrv6koI0o13oVRaQvFjhHdYtBzAgaVcBl5KHPsImKKFwMNfkAL7fG
	 Tq4E+3QFIIBuxpwwGRGnwMhg1NzgyDSoTykPeHL4MZ0pEumO50S/uIv3ixdRXxvoNi
	 Af5WO9as2oBzL3INd91GwmkBFFj61y5+pyTU2KLJFCVo5Iwh94ISeNWGVUBiykjBU1
	 S3J2FdS+Rxpvgd232UCQAuKVn60rF4nuPeRu3YsbOJT+0Cj5b9vTqlEquNzp9i7yrR
	 DjdQJQ+yfTnW9rsQm8gp++lq/Eqbdv3RE+mtVIUHEhSRENd5h1Pjh7OUTs2mXK8vdW
	 yGXO/+6U/TB7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A36392FFC3;
	Wed,  5 Aug 2026 18:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 bpf-next 00/12] bpf: Disable preemption in stack map
 code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178595522164.482099.4352769835591488217.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 18:40:21 +0000
References: <20260805092843.516315-1-jolsa@kernel.org>
In-Reply-To: <20260805092843.516315-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 songliubraving@fb.com, yhs@fb.com, qmo@kernel.org, chen.dylane@linux.dev,
 info@starlabs.sg, contact@arnaud-lcm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  5 Aug 2026 11:28:31 +0200 you wrote:
> hi,
> we need to disable preemption for get_perf_callchain and keep it disabled
> as long as we are accessing its returned trace entries buffer.
> 
> This patchset refactors both bpf_get_stack and bpf_get_stackid helpers as
> suggested by Andrii [1] before applying the actual preemption fix.
> 
> [...]

Here is the summary with links:
  - [PATCHv4,bpf-next,01/12] bpf: Factor stackid_init function from __bpf_get_stackid
    https://git.kernel.org/bpf/bpf-next/c/15b837759a97
  - [PATCHv4,bpf-next,02/12] bpf: Factor stackid_fastpath function from __bpf_get_stackid
    https://git.kernel.org/bpf/bpf-next/c/0ca56befcffe
  - [PATCHv4,bpf-next,03/12] bpf: Factor stackid_new_bucket from __bpf_get_stackid
    https://git.kernel.org/bpf/bpf-next/c/bb4e6f4e1b68
  - [PATCHv4,bpf-next,04/12] bpf: Use stack id functions instead of __bpf_get_stackid
    https://git.kernel.org/bpf/bpf-next/c/09b3fd6caa0b
  - [PATCHv4,bpf-next,05/12] bpf: Disable preemption in bpf_get_stackid
    https://git.kernel.org/bpf/bpf-next/c/15f1bd857466
  - [PATCHv4,bpf-next,06/12] bpf: Factor callchain_store function from __bpf_get_stack
    https://git.kernel.org/bpf/bpf-next/c/cbb99938e793
  - [PATCHv4,bpf-next,07/12] bpf: Factor callchain_finalize function from __bpf_get_stack
    https://git.kernel.org/bpf/bpf-next/c/014fbe5902dc
  - [PATCHv4,bpf-next,08/12] bpf: Remove trace_in argument from __bpf_get_stack
    (no matching commit)
  - [PATCHv4,bpf-next,09/12] bpf: Clear buf on error in __bpf_get_task_stack
    https://git.kernel.org/bpf/bpf-next/c/f5d242825ca4
  - [PATCHv4,bpf-next,10/12] bpf: Disable preemption in __bpf_get_stack
    (no matching commit)
  - [PATCHv4,bpf-next,11/12] bpf: Avoid changing callchain in bpf_get_stack_pe
    (no matching commit)
  - [PATCHv4,bpf-next,12/12] bpf: Avoid changing callchain in bpf_get_stackid_pe
    https://git.kernel.org/bpf/bpf-next/c/a74594607a0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


