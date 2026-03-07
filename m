Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B720E30AD00
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916173; cv=none; b=XCVdHhNj+MqsaxLkeChhqHaAkE4nkbC7c7Ca9lPo8Tkv9Ggmn2CufY6khXIwx4tFnD37z6H3sMBR9dnA+ybhzuTB6obw3W/V2aucUFtAQ8973cWrPhdII9cXl4JhRRvKlNwTdwx8o5qUwb2rzh3HKyIDRtMPoM6y8RhatSdXC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916173; c=relaxed/simple;
	bh=obbdlOZ1/XYBLsJDHREK3VAdGbtuPeUeHo0nlX1IomA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZiU6Cj9Tz25XYMV2tjvqK3KiM4pKTWTFM0+IydDAP99aWPXg/hXzK6Vf5pHIUJyzVVPIiUMR11NEObnjYll9KWn4zYzGuQMlWTKxab9As9MlYcIhhUmN9gZ3B0y1XmN4/eoXoXccfnRBhJKEmD0dWvkOomvNn3zSevji3rwzruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1vTZUO0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1vTZUO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730B2C19422;
	Sat,  7 Mar 2026 20:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772916173;
	bh=obbdlOZ1/XYBLsJDHREK3VAdGbtuPeUeHo0nlX1IomA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h1vTZUO0aXcBfnX1e1L/sSDlqTYm/+6tmm5wHBirEw7xUOP2bmTpaUWqVRWD+Bz9P
	 0Fy+S62GynhSndy5ga9MsAm9vx+V3vHDcsiPhzFbEfG1R9K/GJk7sbcnmnlr/GeEG1
	 shXXCLow/juZ+Jv6c7ifWAeEbji1H3IF9Jso+Di0KTwkOn1LkXCwOXiuNCx6x1BO4A
	 53CC8KF2sQYb1bn73HN8e2ERFZuoqcJzGwNgs2/jeaZLIG5/Oy80H6H7WK+SQZ3prp
	 c7GW6KP89S+3bDG7Fx9ULgBQuA77N+PVwTJxAANhoivARpHyevyYY+oAXEhbzCVVki
	 ELp290tADDS0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF5C3808200;
	Sat,  7 Mar 2026 20:42:53 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260307184839.33830-1-alexei.starovoitov@gmail.com>
References: <20260307184839.33830-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260307184839.33830-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: b0dcdcb9ae757c8a8ba2fb24d34f8d147bae707b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b7f4cd3ac300cad4446eeb4c9eb69d02ef52d6c
Message-Id: <177291617170.316744.5796353985378416092.pr-tracker-bot@kernel.org>
Date: Sat, 07 Mar 2026 20:42:51 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  7 Mar 2026 10:48:39 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b7f4cd3ac300cad4446eeb4c9eb69d02ef52d6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
