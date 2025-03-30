Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC3520E6;
	Sun, 30 Mar 2025 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743373242; cv=none; b=YcLHOvZzklNWKWFMJmGnGsUXwbT8S6QWa54ykoIHj64BbO9op/471VgjkAAW8czImxtLwk6JlukeswkqkH6CabTF18UWOQGV67SVz0UIn3q+ffX4sorb26E2suZhsCzemEhYn9ZuuEynqey51Cm9NizzT9feY213HNf5nNtLmm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743373242; c=relaxed/simple;
	bh=qr1SU/+V0tubEcV2EGOD9x+yIPR/uH9AFnLW8DbU3wU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WqMndbeID2jWdraCd/Rvsxo6vidzAxIqXykN4x4y72uuM582n1sM8f0lzADqbQ9hn98mCW7lq2GDzBL9i3BPTKUKy6r5RqWQ98rkFvcBdpqctqgTrzP//4+fiy5JgYw3ZJDjKNiqLjrTpmCgLfBxH67Bqyrqqel7Iu+mB5RO17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeHhTT0N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeHhTT0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F83C4CEDD;
	Sun, 30 Mar 2025 22:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743373241;
	bh=qr1SU/+V0tubEcV2EGOD9x+yIPR/uH9AFnLW8DbU3wU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jeHhTT0NWFM8xN5zHiAtZ0xDWpGs/R/+7goE/slo/ho/zgUMnVnpFoY4G90WpJ/bF
	 9008hCx1eZ+5LvFVOWp0cJZeJA7+C2GlpKpkDuUzGlwUR9dAQKtA0czJJU95ob0qT7
	 byCLJNJ4Fu+SyDBCMlXhcyXIarxDwrpzEjyzxF8iTWtVbx5kBBR5jw4UVDSYgP9xiX
	 /UYKWP6FPnlcx2Dt4hy5kcmUj3fJaGMTxY8r+RvyOx/93jN0CsEj8vzKaT2nzm3O0v
	 5XWNOGPb7HKRdiEzpz8SduaKyB2ud+SkOB28hKV1aBbPMppkKjF3MlcnlY3b/m+hIm
	 1YpvT1CRgu20w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE37C380AA7A;
	Sun, 30 Mar 2025 22:21:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools/build: Use SYSTEM_BPFTOOL for system bpftool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174337327853.3560732.7620775881771969379.git-patchwork-notify@kernel.org>
Date: Sun, 30 Mar 2025 22:21:18 +0000
References: <20250326004018.248357-1-tglozar@redhat.com>
In-Reply-To: <20250326004018.248357-1-tglozar@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, jkacur@redhat.com,
 lgoncalv@redhat.com, venkat88@linux.ibm.com, qmo@qmon.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Steven Rostedt (Google) <rostedt@goodmis.org>:

On Wed, 26 Mar 2025 01:40:18 +0100 you wrote:
> The feature test for system bpftool uses BPFTOOL as the variable to set
> its path, defaulting to just "bpftool" if not set by the user.
> 
> This conflicts with selftests and a few other utilities, which expect
> BPFTOOL to be set to the in-tree bpftool path by default. For example,
> bpftool selftests fail to build:
> 
> [...]

Here is the summary with links:
  - tools/build: Use SYSTEM_BPFTOOL for system bpftool
    https://git.kernel.org/bpf/bpf-next/c/814d051ebed4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


