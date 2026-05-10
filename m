Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5FD3A257F
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778428537; cv=none; b=X9AOfzSfFeFxPgrO7qJd/5Pqn8ruyiRoboBUtKkUrP+tkw+NHc7H1FG326p0P5eHy9bueqZRS2NuZ8itnK054JndRhL+U/Cox/KNU3E3H9ZKZD5mOk3tVU1TXBuf1Zgsw0ShFOZPyORAprPYlpglsgV4oppE0xUXXAcAcmNXGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778428537; c=relaxed/simple;
	bh=JfLsMBHtX8ID8HHVoRXY/8KVKyOUE/BdWWYVO+0IGXo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=m0PVjkCdndkM3AEp1xnOcZ73Z5LA7xkHXJifKCp6kkJIZAEdcStro9ulQRSA8nwd7fbHXcfKK4G0l//QjFNybXzmp/SHI8sw6xbV/ToTcfpqbXq/lfzokl8Ll1WDwbx1p3aCh4r7AmQ9NI8PSoTvEm7v8mp4xojVKwTq2/2Bbb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IY8cRZ+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IY8cRZ+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E949DC2BCB8;
	Sun, 10 May 2026 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778428537;
	bh=JfLsMBHtX8ID8HHVoRXY/8KVKyOUE/BdWWYVO+0IGXo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IY8cRZ+K3B3LNgDMrAe5BgCBcqbf/hMacNCxFRslxwMqo3TyuoeQg0yDtZboDc22e
	 jdF+ZrpNoEI1HiCGlbFk6bpTh5xwsiHmpCDKQoQiejpXbLp0B4HqIKEHJKW/iAMaZk
	 EtvyUjurxjx8oA/iDODcXIhptW+3Fnk9u4DHl+KK6BRWs0dVUJGfp6TWrF9/PO4Kqk
	 bWpOqFZBwYbEdbhCPXvSkZI9DXjJHbm7j41VEPWB4/z0518CTQ/PV+7jWo2LyqNp5W
	 9/DM9qQ/8Ei+X5ZaAIcXDEPX4KRjikhcgeCz4jg75/AHrrKFlPGZxVJs+OefCq9Arp
	 bveQFqcab7BYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEFF393001B;
	Sun, 10 May 2026 15:54:45 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.1-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260509233456.39703-1-alexei.starovoitov@gmail.com>
References: <20260509233456.39703-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260509233456.39703-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 3ac1a467e37683f602221e243fa3c59b0de81165
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 515186b7be488f37c63c2436fc2d1a160ef9bb95
Message-Id: <177842848396.1418180.11668424102395127455.pr-tracker-bot@kernel.org>
Date: Sun, 10 May 2026 15:54:43 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  9 May 2026 16:34:56 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/515186b7be488f37c63c2436fc2d1a160ef9bb95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
