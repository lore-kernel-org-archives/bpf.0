Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFCB21ABC9
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 02:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489078; cv=none; b=iHGodwEZ7iOedL444IeOblkH/48nZtCcF36d3DlupnKA6/NRrFUllOPH431gopfUVjfMwNt3E9tMFfpnJVMDLUQ3cjPEvpwD/ZOeAwlmF3Ik2Tvr1NrQ67QaZN/ntAPjrTvxjx/9WVfASCTpVc+ta0EZ5wDOZ9QL4HgtOqBcYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489078; c=relaxed/simple;
	bh=ITPq0yrGhCefYQ2/0h/VFvH7SGgVmpMHCLbg53wPr44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OlcAm712Ux/MlrAdbdSZryShKj4DyGs3Je9nu9wwiDCUfnvd8yrm+nVG3Y9WzbfB9BSnUAIp7n817A399hc2v/zCm0Qmgc9quq6q/PBoXv3fvzvbWBlJfVifqNr8BicHuej5fDpUkj0ILtsEv5i6pe0ztzU6ioDDAFVGNp7Z2PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYmtvv61; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYmtvv61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298161F000E9;
	Fri,  4 Sep 2026 02:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788489077;
	bh=SOBAf61/UUNxSueDbDkFNXctrYk6m43qQsJXHI5DOrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dYmtvv61h8jMDHrDRyCC6sLhFbp8Xothet/kRSgoKyvbIjFWsMgGNwUsCZrcGxqcS
	 mL73ru6WOR2tQ4UIHKOvbkeiIOxBhK0pfgR2U6d3c8ov4O2rb3HlqD1PW8dq8IcxiV
	 bNuGCE123mCWeE+rOU7zNrfIEEj4igxNQTt3zS/l59L0Eadg8oVUH8J16bFNI6KDah
	 oufgMvzFY9Pzagy6aN38aYy/vL7kGUpWvp8mgKk/mMWIjwmtzbXmo4zVbqPSS+a0Z6
	 dT2jPf6GE2Am/J+MlbYAaRzmfbcWpLHU/87xL00OSRDpctKcs+ydBZuYXh59+QpsOP
	 Z5uR1nr6AjUMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7629A38119E3;
	Fri,  4 Sep 2026 02:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 0/8] Misc bug fixes - part 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848901839.4125265.13415073169348668882.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 02:30:18 +0000
References: <20260903214758.2727663-1-memxor@gmail.com>
In-Reply-To: <20260903214758.2727663-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 npc@anthropic.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  3 Sep 2026 23:47:46 +0200 you wrote:
> A set of miscellaneous fixes for bugs reported by Nicholas, plus some
> new findings by GPT-5.6-Sol and Sashiko. See commit logs for details.
> 
> Kumar Kartikeya Dwivedi (8):
>   bpf: Check ancestor frames for rbtree callbacks
>   selftests/bpf: Check rbtree callback restrictions in subprogs
>   bpf: Mark bpf_btf_find_by_name_kind() as sleepable
>   selftests/bpf: Test btf lookup helper sleepability
>   bpf: Mark faultable stack helpers as sleepable
>   selftests/bpf: Check faultable stack helper contexts
>   bpf: Reject legacy packet loads from callbacks
>   selftests/bpf: Reject legacy packet loads from callbacks
> 
> [...]

Here is the summary with links:
  - [bpf,v1,1/8] bpf: Check ancestor frames for rbtree callbacks
    https://git.kernel.org/bpf/bpf/c/369f4ce73457
  - [bpf,v1,2/8] selftests/bpf: Check rbtree callback restrictions in subprogs
    https://git.kernel.org/bpf/bpf/c/22ab49afe1c9
  - [bpf,v1,3/8] bpf: Mark bpf_btf_find_by_name_kind() as sleepable
    https://git.kernel.org/bpf/bpf/c/620614bf7672
  - [bpf,v1,4/8] selftests/bpf: Test btf lookup helper sleepability
    https://git.kernel.org/bpf/bpf/c/687b2729ce4c
  - [bpf,v1,5/8] bpf: Mark faultable stack helpers as sleepable
    https://git.kernel.org/bpf/bpf/c/9d02927fdf4e
  - [bpf,v1,6/8] selftests/bpf: Check faultable stack helper contexts
    https://git.kernel.org/bpf/bpf/c/1ba0d0d8b675
  - [bpf,v1,7/8] bpf: Reject legacy packet loads from callbacks
    https://git.kernel.org/bpf/bpf/c/e7d28823c662
  - [bpf,v1,8/8] selftests/bpf: Reject legacy packet loads from callbacks
    https://git.kernel.org/bpf/bpf/c/23724e009f65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


