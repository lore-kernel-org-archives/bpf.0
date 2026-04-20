Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA333A7F6F
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695443; cv=none; b=C13AaAhOPy3hRBj5npK0UGV43dY1H2rrD1EZe+Xvc9GZJBg713MT0OJlJ4zRY3K2fRW9DBfbORa02RF7f4iYThSSVA7cD7mVlulLUcfO1ad9FrvwUnBB9roUQnNmfNvQCY4OiHeZlNA6lKRpXIs544x1hBLt17fcj+X8oJN8qdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695443; c=relaxed/simple;
	bh=V83Q8nlBKoJGnJbVuhpG9Pat1GfIfRvBfwFogd5tokU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DBwlG8hrh7UxkXZc7m8hAwSpqcm4r1lypnN9RQiI2vU+fhgogXTxuestHAZ19wv90gY1hLlNRuh29Hzaye+zQa196RBUsQ6XVZQ5J5t0diiaeg/t4F+fhykHXbKx2qGO1PHjpiafaenxTtBM3/tgLgrtQ9niar/sk/aPY+i0KPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQz/UpO6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQz/UpO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916FCC19425;
	Mon, 20 Apr 2026 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776695442;
	bh=V83Q8nlBKoJGnJbVuhpG9Pat1GfIfRvBfwFogd5tokU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IQz/UpO6AZrKHHn3MqjVQDPqd80yeNAkKe2i+x0XMJd4xqqO0sywzWyHqUbCOySqZ
	 Z4gyUWZ6p8m7enfbrjfmpYcjUpT/wkxJIKjcOLywtERmp0Kk3QoEzhG0sCHWQSbyvD
	 BUB9P6oUJJOkKT6lLyigWApFFzN975TU2iPz8KF7XU69RBlgujlDl08sCqEH+sqosj
	 Mav4VYa8R2AymTMdyAdhltzKG6rT3w2qiVHR//Ji3mxPnJ2Ni93L5g0Qu0sKsXtOYR
	 rEDkQAryTFxYFsag4UDt3GTM5Z6SN5EuKW2byuCFW/prZxGrCqihbwroZNysI3tNG0
	 hiEUnRDY6QARw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCE33930001;
	Mon, 20 Apr 2026 14:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix off-by-one in
 bpf_cpumask_populate
 related selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177669540735.1675250.12765294087027123937.git-patchwork-notify@kernel.org>
Date: Mon, 20 Apr 2026 14:30:07 +0000
References: <20260420093734.2400330-1-mattbobrowski@google.com>
In-Reply-To: <20260420093734.2400330-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 20 Apr 2026 09:37:34 +0000 you wrote:
> The test_populate test uses >= instead of > when checking if the
> runtime nr_cpus exceeds the bit capacity of a cpumask_t.
> 
> On a system where the physical CPU core count perfectly matches the
> CONFIG_NR_CPUS upper bound (e.g. nr_cpus = 512 and CONFIG_NR_CPUS =
> 512), the condition nr_cpus >= CPUMASK_TEST_MASKLEN * 8 evaluates to
> true (512 >= 512). This incorrectly causes the test to fail with an
> error value of 3.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix off-by-one in bpf_cpumask_populate related selftest
    https://git.kernel.org/bpf/bpf-next/c/0aa6378695b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


