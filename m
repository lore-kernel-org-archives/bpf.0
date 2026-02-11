Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749201514F8
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770772810; cv=none; b=M8ULJ16slSZnkDs4r73Vz/FR1wRM/gUAoLyOihZUf1v977bDscaVjpm1AySC9azBkYCZc/bM+PTgqimpPvXXJinO0j6Aepx6Oe8GvqUTsdwRM6wLc/d53f5iXIQbRbC9C6oGPyPcP3C5T+O5g1JXB+KLC6/dn5cv6tpfjLr/NuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770772810; c=relaxed/simple;
	bh=2+kOBv14T4+MJxF5An/0izFpaACfILg63WHmlWE6RFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pkLr+J9KQ+EfrEOgBEIlmPLlROIUmoGDg9IJHBhWRkW3v45xKKMxHZqyo32goE+AtqN7GCMJZH0i1K4ml5kClsLeNIYnN6OFJyP4wkCOGl0n3i4BqXh+aqD46HUh6HNmhQqz0h0tNYogSnh+UlYTDsSp/0zLg5PbgOXLrbdSWbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcqR34BB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcqR34BB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E96C116C6;
	Wed, 11 Feb 2026 01:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770772810;
	bh=2+kOBv14T4+MJxF5An/0izFpaACfILg63WHmlWE6RFE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GcqR34BB7wwd73iv6fk6+RS/XPzCBOZE09DGMbqo4NCyPaNdhc6wNmzwFaeMIUzCl
	 A7Hi/YcJcrVL7eLapfzqkWu/eIK5GJ/gs7JVUGFRIuFh1nuwzpfT/C3nxZYocTxxPZ
	 e0vfF/Dqq3JymP1whtDncmDQODfQWCzPrh0mJHbgKKb1Fn9pIsFVdLsuPbU+JV3Y3T
	 w+p6Tj2wFrzfPyGkZOFxU4okKW4GTjHfjbFVSFOEXCVsJW5RIcSK0IwIk1RHqJXqMl
	 zPx/+4qVY1vjI1XZ5VDWFVmCUpDxWJZ5Dt4bqYY1+IPt8z9dGqHb4GPyo5wEB7v6uB
	 ERzWWXL9CGVQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4806039E3B79;
	Wed, 11 Feb 2026 01:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] bpf: Fix a potential use-after-free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177077280509.4144399.16811384962218556577.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 01:20:05 +0000
References: <20260209132904.63908-1-a.s.protopopov@gmail.com>
In-Reply-To: <20260209132904.63908-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, aspsk@isovalent.com,
 syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  9 Feb 2026 13:29:04 +0000 you wrote:
> Refcounting in the check_pseudo_btf_id() function is incorrect:
> the __check_pseudo_btf_id() function might get called with a zero
> refcounted btf. Fix this, and patch related code accordingly.
> 
> v3: rephrase a comment (AI)
> v2: fix a refcount leak introduced in v1 (AI)
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] bpf: Fix a potential use-after-free
    https://git.kernel.org/bpf/bpf/c/c81e4322acf0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


