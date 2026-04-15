Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3029827E
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220886; cv=none; b=Hh+Fh2E8F6pcvXyHhUue5O/GbgmdxQZzJxtzePH+WrD40t7jx0hEcaDZuMP31B3mNE6QvMB3n9Vnp/ysQEiiDyg3Qrt6CEPRpnWc6iAs1Ps+93Nwp0RTOvlyx76Co96iyxcQdqDdNE4KxK9WQUSpAKkz1l4UTTkgq40Kl3JivK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220886; c=relaxed/simple;
	bh=IjLXYZcesRIKQ5ClcdfzeR5Z5ztLOXoaw5dk3kLSlUc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pPi8hnPRbDAdFVknrSfdeeOG3QSC00gerRIaOBAr96oOS2/xO1u8Rn9Z+qESDbhVq5CoazjhSS5s3egEKqwKlShevcvICuiQ0yp7Zhj7Fs0Py5mCfXTx57J3xTic8agLvqYfnhh+YaNPxlVVAmElCSmFAc+YT95uRv9zVInu4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0V6CGeL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0V6CGeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6577DC2BCB3;
	Wed, 15 Apr 2026 02:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776220886;
	bh=IjLXYZcesRIKQ5ClcdfzeR5Z5ztLOXoaw5dk3kLSlUc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n0V6CGeL5B87R1C8kYJsIqFzywyY77QTkhjFHmRrbXyH24kQf2fIvXQ5n/rLzVRfG
	 LF/R3VeOyUauzcz3cSw9/pNHt41SdF/m/XxSR9PKSeqS/+pTtEIE+t8Ho7uVmgE0Fn
	 oDXez4HUAK6bO9wZaDP879l1xMEPtPXKNjLg3wsZoit7YZJ8sW/eVUd6s/tBmsUCK+
	 abujA/kj41bvG4m4QmSjTlSXN2u7nPJFz0kVc+lhz+aAoRqZgOJ4F2PBpn12AYC2w3
	 5CmS0v+GO9IrIXp2Tk57nDGaRogn8+sVRY1ADaDCQKUbI3+Kd7f39sNfO5QF2SCkfC
	 BNpBo6kRzkZCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D733809A33;
	Wed, 15 Apr 2026 02:40:57 +0000 (UTC)
Subject: Re: [GIT PULL] BPF changes for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260413174732.87983-1-alexei.starovoitov@gmail.com>
References: <20260413174732.87983-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260413174732.87983-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.1
X-PR-Tracked-Commit-Id: 71b500afd2f7336f5b6c6026f2af546fc079be26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5ad4101009e7f5f5984ffea6923d4fcd470932a
Message-Id: <177622085650.1583446.11516707676429196945.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 02:40:56 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 Apr 2026 10:47:31 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5ad4101009e7f5f5984ffea6923d4fcd470932a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
