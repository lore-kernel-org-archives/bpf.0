Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35434207A
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774205165; cv=none; b=oBrsqEZ41Mj3rc07CEiUIBiTRosl5QTClDGYvC9G1LMZGMpt7YIuMriC6EHFPy6c8YYy52Qh/4SZWIjs/7LuCbXhEuZ/dRzL1drq/natvSRevsGchJhomRcp46WJTSqG+EcGhEMOTw6Hk8/ICIJVsTbaD4uoer09bBZEsPQuocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774205165; c=relaxed/simple;
	bh=80WEElyNS7mH6S58ezykoa5Bwa/F+qcRmNm6qrCXZ9o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hCN35hyPCEGcG0o7oN/4kKzhM/yu341W5U/f07EvVXCI8rbRk7xV1CXa3CahH+YsuAZQ1oUhLxGjhQE9IdJhxHuLAELky3TpEA5wZl/aohts1L1tYAXyrYPfXIcKC2xwRwfQRPO6cNKJujK4zRsWHF5oSttiinEh/tQZZGo0tUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GePn1+q7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GePn1+q7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86706C19424;
	Sun, 22 Mar 2026 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774205164;
	bh=80WEElyNS7mH6S58ezykoa5Bwa/F+qcRmNm6qrCXZ9o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GePn1+q7U7zDz4lyGOqD1C2NgLu3UdqNpKHyRCpsx2aeDRL9vx1bho7y7t2WH2VTq
	 y+peZWhtcHbwQK7OtTv4VsuDg06BLAGPcmvCr+igoRWbG2AnseDI/qTeaqqsXnTj+4
	 /e1kSTT6+w2rRXL1AFkFc+YyX/iBVn+wemGfwowFg+YUdZjC+GnqLHAp+jB++MdMU3
	 1XvRZHupc0lgRFQZCXkj1ipXNb5Du7DONmwRDQvAyQzXor+zJeC+H2Nm/ULsM0hZF3
	 rAgzyDASWm0WaKKCjALzd+4iPx1H4I6HDzstg9PyOUUaqKBgOTQnNbtfbjtNNXeLt/
	 8EYJ5yvEIlpWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0D43808200;
	Sun, 22 Mar 2026 18:45:54 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260322164633.4165-1-alexei.starovoitov@gmail.com>
References: <20260322164633.4165-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260322164633.4165-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 4a04d13576fd69149b91672b5f1dc62eca272fa5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5273fd3ca0bf0b59fff49fb59237440998fbec8
Message-Id: <177420515330.3169233.9856818893552748204.pr-tracker-bot@kernel.org>
Date: Sun, 22 Mar 2026 18:45:53 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 22 Mar 2026 09:46:33 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5273fd3ca0bf0b59fff49fb59237440998fbec8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
