Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA33932F1
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685650; cv=none; b=GnQZTYoP++Hfi3+AL7wR4qPOw7Pi0IpSYh8aio0NckGo4NR96LvwHlH3nXlKb1zf9F75+Mgrsjkqy/zc5LJcM1U1st8/N+QIj/qZkYJvSAVLhxrMl4rRS0MPFbml2zoZBlm4NxItNhUh+spkc1/o4Yjc1xOTJU2KdpP9hZJ0wKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685650; c=relaxed/simple;
	bh=mwjzVkSblYE8l1QyU/EEwU/3lErrFKq22q4Wx41fBQw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o1GjZ4hTae+h+EVf20TKooKV8N7Gy0U0zPzvkrZl3wNCp+O3AvFWjI1IS86xlE9ZaKePt8CCfSS4t4FbVzji9a5dfsL5dDhg1VScioBeUst0JfkPfB+qaYoz+row5NDvy2of41PwPW5Sd12cIXrbmB2WTws2iK9OcggCUkFKlnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LV7fhjSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV7fhjSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D8D1F00ADF;
	Wed, 17 Jun 2026 08:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781685649;
	bh=fwXTkPd3Ps/uYbMaFgatZ05jviC45P92jXWeWoIcip8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=LV7fhjSHolDbEX6o035UCO6hORzL7R+rETOBWMtFnvdGEvCXY5XZ4LtzawlbfDvqU
	 7PO12j2lxuH3hGY3hSZxxwi98lJ6biS4rdOHe2u0nJ8gP8cjLzCfEp2cVLAZHVxk0G
	 AcSNXkorSoSGHolohhz2YKnjJSFgoTATQ4TUrFlsf8MHew7w7o4EvYYuonN4KEbI9e
	 Wl8+/5ATJXldat7Q3jMxBDGZOhOgNFHXI/l/PDX3+9GxNdUahzQH5suAaWSWggyDWw
	 nPIZWD1HqG0J1tiSeJ8XON/MLorE8bdB+Eo22fYSjflDz+tIorzAaADpnk2i3x0r5V
	 u14kZ2Zqt6XqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939593930DCA;
	Wed, 17 Jun 2026 08:40:44 +0000 (UTC)
Subject: Re: [GIT PULL] BPF changes for 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260615180858.15938-1-alexei.starovoitov@gmail.com>
References: <20260615180858.15938-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260615180858.15938-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.2
X-PR-Tracked-Commit-Id: e4287bf34f97a88c7d9322f5bde828724c073a6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c87e61e3c5797277407ba5eae4eac8a52be3fa3
Message-Id: <178168564330.1433416.773238221226545902.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 08:40:43 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 11:08:57 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c87e61e3c5797277407ba5eae4eac8a52be3fa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
