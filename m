Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B379281369;
	Fri,  7 Aug 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115944; cv=none; b=mMsX9ZC0nnl0FuMS+s+QtCkb1GMNYQUvLxtyF08JATyoUxMDTKVnEHFUJbAzWz0RrxYFFI3mMPY2DnRa3zp0dpkhNMUypA2kDJ8I5H0RuWt3zrHL8qduEr2AKX9VJGLmIBXlNrtFCrCrBsleC0yW9D+d5OyCRJ7bieW1sPv+py4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115944; c=relaxed/simple;
	bh=w4plJhtjaRBem5bRlNZuLfQmWeX7Ep5sCygPEYqSpP8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J9ZrkRNsqj6yDCunfteasmkUblmmJ0YV8aMg/eIilnb2b8d7VRhbana/8bbTciIEzem1KKg/Pe/F7eOggXEB/bClIwGN81JZlroXfU2/XmiGrBVrbPTl4Ws+cfGiMa5B2j1u7ZiLWImX6dIZisEVb4XItbUU8xFcYSaLkbuHKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi0Na8pf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi0Na8pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78271F00A3A;
	Fri,  7 Aug 2026 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115942;
	bh=tGTMEDrLopvX1y/DVQK/Az5jndYfBIjwKHcNYgWdgGs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=oi0Na8pfngA+VeAx1g98TpeHuVTBVR1Q2Xsa2ke6CAJ2gdOxnY/Ug0Q23jjEg64Ip
	 0ZG/WtwEGYVHenD9CnoCZLgaKcgR2Kl1A2xC0GVZgG+291t0GMYoIubCxl8OckRHKS
	 xTOX43NwTtoPjCZ9fGKAlQHjkUt6nYIG3Q/qj93LwMFCliRqF6AW+6XCt+gK6lRD+c
	 90FYRpI2U+Lu/PZKyu7DGp7EZiUoEQCM3vPDfqR33Znhc2GdHFc5VlR6tmLbuTh4oj
	 1453qinCASN+rKozowTzZ53LCd6HAzgRfmaCvjhyORDsxCQ/Hzhdy0jLEfmZ7cfRpq
	 L1aCCGw9O9e/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C55380CED6;
	Fri,  7 Aug 2026 15:18:22 +0000 (UTC)
Subject: Re: [GIT PULL] bpf for v7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260807140255.351483-1-daniel@iogearbox.net>
References: <20260807140255.351483-1-daniel@iogearbox.net>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260807140255.351483-1-daniel@iogearbox.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 7a3c0289c3c8eb4607dff448ae9ff9f902c813af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a13307e97d5c54b65720bb71fa379960ded1e51a
Message-Id: <178611590142.1849205.15103642226618831458.pr-tracker-bot@kernel.org>
Date: Fri, 07 Aug 2026 15:18:21 +0000
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, eddyz87@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  7 Aug 2026 16:02:55 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a13307e97d5c54b65720bb71fa379960ded1e51a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
