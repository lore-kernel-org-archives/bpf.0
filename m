Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B19151C07D;
	Mon, 21 Sep 2026 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028683; cv=none; b=Vg+2ckZ6VhP41gAZm0StHt/i7omuALzg0I3/etS+bAiHCv9AsY1AWzY7QG7GQEDEihqAYk8GUHwipXRcpTtquKXJ6aOBL0TgjQeaK5GQLQjdCbBRSkFkVY5TEPA0HhidDmVHohzpcha8KiFPS8nLpqyMGNJpSv0reAuuU1PPyns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028683; c=relaxed/simple;
	bh=6lhlyJn8oQpEnxmX3jciDhM9pdNTThDxE+1/Cw1jDH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CZi/Ydd0+aqnfzSuk9q9WYm7QyFlftSl99dsU6aGZ5pE97HhI1McumbkH/Ypx1oAyBWmMqZyGgCq/oIzUTzvbihHywrYoGQJxOMV3ck72d8jVNQ1koNM5SzOVKeBDIHuxBibxSLB4SCYScEzGVieBRG/xPHLVdlsk8xyYjz2Arw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBDDq9GS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBDDq9GS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EF21F00893;
	Mon, 21 Sep 2026 22:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790028678;
	bh=yG5TCU9PfQvLIJl49fkCrlqqKvRN3q8c9KhlLegIGzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VBDDq9GSFhiOOv5eDB0HLqw3tnRUmMosxrkwUV8tkvs/goxNPvuEEidClX055S9x6
	 vWp3WN+WgcWGt2Yl+Fnno2bZZmyocfHUaKQtkSnTZ7jNDSVgD7YPVncf4ji4P5FoZE
	 gZbxvdOvnocU01XQIdusq9Bje16wVUEj0/d5XAzG+wYLOdMVDhqarqLUXuendyjJrS
	 d8ZjPmoyReE0xuCpEZl7VKWQSDQeL/1J8WrLYZGz3/hcbd++dx1UMJqu7sQoYKwFf0
	 P3PUaYdROjpuAkyEpCccrWM+htR6RqKwGwMk3xj87fJyUnARboKmzclS0VxdqqUMJt
	 BmYtbSSMebb/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567AC393020B;
	Mon, 21 Sep 2026 22:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] bpftool: Consume ring buffer maps with
 event_pipe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179002860988.3260819.17611054585243336997.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 22:10:09 +0000
References: <20260921073556.99421-1-hi@tychen.cc>
In-Reply-To: <20260921073556.99421-1-hi@tychen.cc>
To: Tianyi Chen <hi@tychen.cc>
Cc: bpf@vger.kernel.org, qmo@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 ihor.solodrai@linux.dev, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 21 Sep 2026 16:35:54 +0900 you wrote:
> Extend map event_pipe to consume BPF ring buffer records, with plain and
> JSON output and focused tests for records, shutdown and invalid arguments.
> 
> Changes in v5:
> - Suppress cpu/index completion after selecting a ring buffer map by id,
>   name or pinned path, using _bpftool_map_guess_map_type(). Keep the
>   existing suggestions for perf event arrays and unresolved map types.
> - Rebase onto current bpf-next. No other changes from v4.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpftool: Read ring buffer maps with event_pipe
    https://git.kernel.org/bpf/bpf-next/c/b5dc1b184f32
  - [bpf-next,v5,2/2] selftests/bpf: Cover bpftool ring buffer event_pipe
    https://git.kernel.org/bpf/bpf-next/c/b09784655ecc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


