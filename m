Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866592DB7BB;
	Fri, 16 Oct 2026 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792111210; cv=none; b=UpXG9hPZMrg+wauXO7JfMnyi7PWdj05BLWvmHee348omXa3YfmxH9OL2sG07jmwInPkgynSpasTfcnfDo998X74t0bXjwgMFThR41//GKtZijcaqpNoRTntQevDjTUYHHPaBeT4hPnSM1lUV6ytH+AOskZfaqm1jOdf24MQZrc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792111210; c=relaxed/simple;
	bh=317xq36M0NZzQZURiVTKsWT0zYrem9wMMe6xzjFa6IY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TraXKM/LFA+FRqVklsfiChigS3HXvsOIWgfeFOT4eKJvLhr2qbR9GbI3Vm/B8iKadTIXpORLPtpEV3aA+l4xMv3G3rXkhI/lBmXhddydVbF6Y0KJe6jCck4Euq9Q23vyae5MX34IDLHfvDwUEWEPLrbM8uLSQ0lOSEfENuiwD5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM9jC+mA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM9jC+mA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C951F000C4;
	Fri, 16 Oct 2026 00:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792111209;
	bh=mtGc3mWRXqB1/kcNQuKMQfPSE5qTv2v09XRTbpvoJto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YM9jC+mAdZwByGWhg10V3tjxGIN2DH0oPeGtg4qQqasztXyE4jeM66VViQyWHNq8x
	 Fb70vVIAXrVbXrT2tj2ru6Ui6/6ApkmAe1nFzAHN/nhNZNtBOnE2tX5fAhzOG7mUMG
	 cTF+OXYCmSbEILee56rdO6G25EEP4YaMMFMVvHUNAbNvDW2c4cQNy5OIS4bLeO5ViW
	 IHkt6bwLPPkU591ldqqAG4OuVI81MEm+E/64zgZUt3NfH3UujUFQsgh0M92N5lMzgs
	 vn9Hyy5+pvOw4Nv6xJYPtdixekc2dCqKwyn8vLltPCOw85bsZFRZO9zl1fMsWYorK/
	 i492ZrjCtROoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14463808209;
	Fri, 16 Oct 2026 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/7] selftests/bpf: Fix selftests failures
 with
 LLVM 23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211120751.4176565.4973025143783418812.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 00:40:07 +0000
References: <20261014113043.640435-1-kafai.wan@linux.dev>
In-Reply-To: <20261014113043.640435-1-kafai.wan@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, donggeunyoo.kernel@gmail.com, leon.hwang@linux.dev,
 menglong8.dong@gmail.com, yatsenko@meta.com, jiangfeng@kylinos.cn,
 bjorn@kernel.org, puranjay@kernel.org, vineet.gupta@linux.dev,
 mykolal@fb.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 14 Oct 2026 19:30:36 +0800 you wrote:
> Building with clang/LLVM 23 breaks several selftests. Patches #1 to #4 fix
> those failures.
> 
> The following self-tests also fail under specific invocations of
> test_progs:
> 
> - ./test_progs -t prog_tests_framework/test_fail -v
>  test_prog_tests_framework:FAIL:skip_cnt_check
>  unexpected skip_cnt_check: actual 0 != expected 2
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/7] bpf: Determine freplace staticness from BTF linkage
    (no matching commit)
  - [bpf-next,v2,2/7] selftests/bpf: Fix stack_arg precision backtracking log expectation
    (no matching commit)
  - [bpf-next,v2,3/7] selftests/bpf: Fix stack arg pruning test JOIN log expectation
    (no matching commit)
  - [bpf-next,v2,4/7] selftests/bpf: Use _exit() in uprobe_multi_test clone-ed child
    (no matching commit)
  - [bpf-next,v2,5/7] selftests/bpf: Fix prog_tests framework subtest count checks
    https://git.kernel.org/bpf/bpf-next/c/c87652656a55
  - [bpf-next,v2,6/7] selftests/bpf: Skip expected_msgs subtests when stdout is not saved
    https://git.kernel.org/bpf/bpf-next/c/cc4b1c161d92
  - [bpf-next,v2,7/7] selftests/bpf: Skip compare_text subtest when stdout is not saved
    https://git.kernel.org/bpf/bpf-next/c/7ebf808caa76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


