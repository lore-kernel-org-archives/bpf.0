Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832002737E3
	for <bpf@vger.kernel.org>; Sun,  1 Mar 2026 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772337860; cv=none; b=ortn3R9Ab2DDHjkwvIOGAWoEWu1dqWmDy4IwVtedymn6iJdaZX0x/luCqBqhN4VDQiSxEY9oFKfOYiFQu4SpT5uo1+sQIOLGSOHEE8pkaDUbGUg2iawryb4i4jOz4jwf0ZpELWir07bMjXkogIPQ29PGiosolvW3L2RWg04Gc50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772337860; c=relaxed/simple;
	bh=3Vb6EK1BGWT9h8EcOCzGl2y7sjnvWaQSZG0u/sH7jwE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b3ZUZLxA7KmoVf4lgG9r4tna47pKoJ5xtdyIM4DZ6OJ6hJlX9K3FFTWYUAIA2gMERkotawN/ZUngeySIa5L5YDShDSiTm7YixdKoVCx9/e8cRGQCr9MxSYTF1WVSce5hoxI8QhbJmCn0CXe0K8S6+cti+BkDJ6btLNCndlc70Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tH8+C3fk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tH8+C3fk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1D5C116C6;
	Sun,  1 Mar 2026 04:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772337860;
	bh=3Vb6EK1BGWT9h8EcOCzGl2y7sjnvWaQSZG0u/sH7jwE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tH8+C3fkemZhG6wJ0/AEnFyJezB1UGTRine2lT6Ki/M1hUgxgEDp+BS0NsrwR+v3T
	 jJLH8Ww6KsO3KVpMBzP2Bfk9H1fa+Niz5UiGPaVUwBPDQcnzy3ha0x2hGx9xqvk846
	 IlSpDT6sT8/6Q5QykywXa1STpP7+Ng5j43wuh15/8IeMc5D+coL4Y61ESqgtR1m2Uw
	 ECPk+nJNWVNJyLU19fb36FQEEjWS1NIk7vlHMAo3drTDxdPx6x2rjA3O5tTUAs58Wa
	 x5WNL2DUbwfVDBOTZiKCczpf8d8SzRYUsU0B/tpDO+rw5XOMxGyHoCcRON+4vixjr9
	 YtVWlQaZV0D/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D14439F202E;
	Sun,  1 Mar 2026 04:04:24 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.0-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260301014538.39958-1-alexei.starovoitov@gmail.com>
References: <20260301014538.39958-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260301014538.39958-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: b9c0a5c48396aea4cde25fc701027ebbc5d78de1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb71ab2bf72260054677e348498ba995a057c463
Message-Id: <177233786312.3243406.15164652559322964445.pr-tracker-bot@kernel.org>
Date: Sun, 01 Mar 2026 04:04:23 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 28 Feb 2026 17:45:38 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb71ab2bf72260054677e348498ba995a057c463

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
