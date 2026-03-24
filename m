Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47D93FADE9;
	Tue, 24 Mar 2026 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369464; cv=none; b=f5GQ+Zbmvkxrf/FrH6OrtiATUP7IFqdsQYh5RCavXvVvMtNX0km1OISkGD34TGI8Nyu0K37oy/woj966+YUOcPHN8rMlRmD0EH/HyAqq6xcOi7IGK4/yG0FYoNYx0jtuLpl+nsVj5lImvdZV0Ckb9bAvgf5BjRTHqU6nYGN7P1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369464; c=relaxed/simple;
	bh=i7OWwHhg74lt0e7mmpAKwio17waJ0DM1n4gTNxA3bPU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=STiLcc5yq1Xpu5+prRGOG/MZME3gfO/KKOW/oypxEzvh122owS3aY596ORvk8/OcQAI7onrmAUEqAgkTagZvI19iEqQJQICmyRMJlUDOBLharZCR5krWkERrsdM03Ncpc2rRx2KF/decEDlw2sXKIMtPSwU4oMnRZgh+/+G+PqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df1QiY/Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df1QiY/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F70C2BCB2;
	Tue, 24 Mar 2026 16:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774369464;
	bh=i7OWwHhg74lt0e7mmpAKwio17waJ0DM1n4gTNxA3bPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=df1QiY/YOSej7F1H2Wa/rIGqH5fVXGvhN8zY/BdBzFrb6rp4v/Ckb2CX0wkBsI6Qi
	 kGjTpO37u06aoUGXxiTOUVmTtGSlgGuWpdi15bqQ8h4TVsFRnajM+z0hWXtMrx/qD+
	 7CncF14ElmKwxwCVGI7Jbc8wmppQCuwsvQcKQAmo7VEjdLP13fO3fpbysvp/CB0n53
	 ybD8R4Ez+FNMAQYxkoLU4sMBaPNL41nUPBfPLJkpJDPjIuphlpeJr2QE/9YGGeb6ce
	 eKmZXsQ1KKoZvlBhXXpbCUPkS1iddVfdoXfrXhrWPo5PntxG3dhxqQT2GHxYwUJJix
	 sI9nc0y/gK5jA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF543808203;
	Tue, 24 Mar 2026 16:24:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add test for struct_ops __ref
 argument in any position
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177436945215.1152246.16259735367369554128.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 16:24:12 +0000
References: <20260321214038.80479-1-varunrmallya@gmail.com>
In-Reply-To: <20260321214038.80479-1-varunrmallya@gmail.com>
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: keisuke.nishimura@inria.fr, ameryhung@gmail.com, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 22 Mar 2026 03:10:38 +0530 you wrote:
> Add a selftest to verify that the verifier correctly identifies refcounted
> arguments in struct_ops programs, even when they are not the first
> argument. This ensures that the restriction on tail calls for programs
> with __ref arguments is properly enforced regardless of which argument
> they appear in.
> 
> This test verifies the fix for check_struct_ops_btf_id() proposed by
> Keisuke Nishimura [0], which corrected a bug where only the first
> argument was checked for the refcounted flag.
> The test includes:
> - An update to bpf_testmod to add 'test_refcounted_multi', an operator with
>   three arguments where the third is tagged with "__ref".
> - A BPF program 'test_refcounted_multi' that attempts a tail call.
> - A test runner that asserts the verifier rejects the program with
>   "program with __ref argument cannot tail call".
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add test for struct_ops __ref argument in any position
    https://git.kernel.org/bpf/bpf-next/c/b43d574c0032

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


