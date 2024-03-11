Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A154B56B95
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198629; cv=none; b=GwNY5GGp4f3xhdLkPICnulpHQpC/GX7MxwS+cUaPUIQvaR3xQzLxqCifexP72IGY/7/FeeL1990qPSVpOgjVqorBpQFCJlXic8lQKnyYIfleLFETAOApTzRbFUcVIVbnHnz0GAwiHSvv4HXruF5gZ5CZuPaQm7p2UNBC3tLaHtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198629; c=relaxed/simple;
	bh=QC4sngiQy8ydkJxGEDKdnKvkDvkX+kULKMmbi3i5c1w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qYWgGghMh4PWekSE4rkQCsnoTpieT1pNGucOXemU+JRR0ZElYK407e0hqRXBSULGS39TJxWxe0dBipHk0iyTXqlga97NHhwgvwQEbqfdkBlka9/0cAkgxmFMsLt31T31+eN6fS4X5kD6mKj0EKzSQGi1tjw5+QzXo/6lBV/Rrp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir5+wiHZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir5+wiHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D775C43390;
	Mon, 11 Mar 2024 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710198629;
	bh=QC4sngiQy8ydkJxGEDKdnKvkDvkX+kULKMmbi3i5c1w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ir5+wiHZxdDwwgDj5b3d3ITAGJizaa8pWcz82GeGDjdkOzBpSV7xHreTG3qwbmoow
	 K7htZyPE9QgYihDixbCrZLa38wYXVrmm5SPc5N2cdtWpIt4aE8kaP72TfedytJyG2J
	 liuExJOuYwxvK82vwIgxWg1wDghZUTBrU/0jGANJNkvomdVqOdQtKbmtILFFkC0ovN
	 006EBXOHCop9LMc6bbuahqt7yzdCSCC1KQ6T/SL8Vf1aUmnQCY0i6DROai/EwE2ViI
	 HCPRMlnonUxvEvrGky7KHMtK8rmKoZPjagV58JM9YzCrfj9L1q2BdQjnMiXJdZyiJu
	 IA942q6So1+1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02EF2C395F1;
	Mon, 11 Mar 2024 23:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add kprobe multi triggering
 benchmarks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019862900.20497.6383121847372727253.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 23:10:29 +0000
References: <20240311211023.590321-1-jolsa@kernel.org>
In-Reply-To: <20240311211023.590321-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com, mhiramat@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 11 Mar 2024 22:10:23 +0100 you wrote:
> Adding kprobe multi triggering benchmarks. It's useful now to bench
> new fprobe implementation and might be useful later as well.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/bench.c           |  4 +++
>  .../selftests/bpf/benchs/bench_trigger.c      | 32 +++++++++++++++++++
>  .../selftests/bpf/progs/trigger_bench.c       | 14 ++++++++
>  3 files changed, 50 insertions(+)

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add kprobe multi triggering benchmarks
    https://git.kernel.org/bpf/bpf-next/c/379b97bbf02f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


