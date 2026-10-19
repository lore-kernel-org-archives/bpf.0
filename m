Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9E447811;
	Mon, 19 Oct 2026 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380009; cv=none; b=cyUHyAj24u0atLJ3MebJYgx5KDDeNz015AVfCd9rg0+htAfUSHa5sZopzKrSbyf2rIx+QJ9PhIjLN627PZtcQC/J2RlzbeKEkUSWzWyaLPUvfozQsj2knWCqRvv9CXwfOyzybOf1IUUEEg7aRa8E0dyoLZewVLpAo6nppJHc67Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380009; c=relaxed/simple;
	bh=9D/tTq4orHUatReRSC0s/yYSLUXAjs0NGHI8nfR6iU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hPN4MSXc3vf0BZc9Gg+OiUDBeCBK4p3bYmH/bXAsUEoRYFWgMgLfRt4g7XQ8r92h3NImGDwyetxXBXY/H9fUkj304tJsl/TQ+P3ym16SJsBGpRvn+rZR/2mV9Nh5CYZkKMp4s9bkyYhUwCYoH5Qqtb1Grk324d+/GqFNarz83BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXsJ9G4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXsJ9G4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073791F000C4;
	Mon, 19 Oct 2026 03:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792380008;
	bh=CNKDQtmKSS3+n5QZzQjFbPVGBPOyM0GNuPUPPITwubQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MXsJ9G4R+GN9olJb4nktvleN20dsr+1EWMDqzwK0NfiCiIyFVEEjjYnf2KPb9UIGb
	 V9r491TixLohKL7eZ5bfw0zYzfY65/rqp4M3X7JcKbPkbw0XnGe6zdLatOGEwZCvuF
	 yQc8XBJuSIRI8IobnRf2ygljDKMeZxAzWJbJyGWz7G/BJK/IePn+pPDRkJAB0oFr+w
	 4AOoA9R18qfrSg4wMpmYihylGSn/eAaSjt6W76ELzpmcVpkeZSKpfFj2YTXYq3Kr95
	 4DRvAr4idxrstYec55LysTNHAZ6B6v+dctC44I/HPkK3L9wUcS9L2sIro8u5KxHGmV
	 l23cUB0sxBueQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F143938119C5;
	Mon, 19 Oct 2026 03:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Run the cpumask map insert tests
 only for the test task
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179238000660.2381645.14989315546275364536.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 03:20:06 +0000
References: 
 <20261009-selftests-bpf-cpumask-insert-filter-v1-1-3249218594d7@gmail.com>
In-Reply-To: 
 <20261009-selftests-bpf-cpumask-insert-filter-v1-1-3249218594d7@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, void@manifault.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Fri, 09 Oct 2026 09:49:32 +0800 you wrote:
> verify_success() attaches each cpumask test program to task_newtask,
> forks a single child, and expects err to be 0 afterwards. Most programs
> return right away for other tasks than the test one.
> 
> test_insert_leave and test_insert_remove_release don't, and insert a
> cpumask into the single entry of __cpumask_map for every task created
> in the system while they are attached. test_insert_leave leaves its
> cpumask in the map, so a second task created, for instance by a test
> running in parallel, fails to insert one and sets err to 3. Two tasks
> created at the same time can do the same to test_insert_remove_release.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Run the cpumask map insert tests only for the test task
    https://git.kernel.org/bpf/bpf-next/c/e2c978ad415c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


