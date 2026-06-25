Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA45823BD06
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424832; cv=none; b=BU6Gt/hGHdJNyXyy1NLboNqTs0m9ZDgZIB2R1Ba5IeCv5ezqwq9cgGbwjEN3hyLfsxq0jUbT8muhEVqVmtvWSbejAoUYfgv/erWs64gZFqt5CNVr76s9WZRvQSVzOEYxbgVh6wpCAR/yWDM1izmGvDGv1hK9uEAnsDnhF6ltn6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424832; c=relaxed/simple;
	bh=jzie1bvO33li8TjYESL9cRn97fESiCT5Zy4/Rb+gD2k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pJsY7OpCCPjz+v2cbpFsZyvyHO04/OQ1C72+0ZwPV9P//rlI8Brvd8NmU8lkaStF3myLjlNuUcIjj2pmg8k3/L0YBdUnnB3p1jymZ149DAX384Z57ZFLlqP5Xe73s3CTJxRjzhmmiVKyGRt8gYpglFyxXGfqyeEh3lrIr+3pad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdD/2Nij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdD/2Nij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602D91F000E9;
	Thu, 25 Jun 2026 22:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782424831;
	bh=5bk87c+bAHqpaJMa+0IwfrSZNpxakaH53MkndEQc2cE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=XdD/2Nij1xZCvgOQTHzHABAm4io9Vn4ghvKA3Xchc1ecCCSNBFS2A2L9X0LNI/cSU
	 62aGQEP6MP44CN4D7wHCyt9tzCFrfUnJBYOQrQ4VuswT3hUdDwCD9WxaYxyo72Z80U
	 dRx0nHIvCBZfHW+3vUp6Qx53br07SeFy7SpOAA6V3XnJhd2Alsz5CxeDWzzJLFKpwd
	 wJ9flIbNGWzIa+GIcaUsBgdUPM7Kcj2f2V+1e2hwENYCh4b7Iu1qMQluKBovjKJX0n
	 urZYMDCzRfCKm1/yXS/4tdyF9DMARSmaxyO2hlf7PCr1fJypC0lRqLLufqv0W5DWPO
	 JD69BH1GmBrMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D37A23930AA1;
	Thu, 25 Jun 2026 22:00:19 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260625201934.54233-1-alexei.starovoitov@gmail.com>
References: <20260625201934.54233-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260625201934.54233-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 12091470c6b4c1c14b2de12dcbae2ada6cb6d20b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4edcdefd4083ae04b1a5656f4be6cd83ae919ef4
Message-Id: <178242481838.180402.15127841741743043419.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jun 2026 22:00:18 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jun 2026 13:19:32 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4edcdefd4083ae04b1a5656f4be6cd83ae919ef4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
