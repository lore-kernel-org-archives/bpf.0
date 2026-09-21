Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01181518125;
	Mon, 21 Sep 2026 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028418; cv=none; b=sp1rzszJ2/fcH8qFPD0DNjzhHuGRNunaCTJqPexHzQG9oRG0uydhwA82mKsH2dwegOlSweCw15616u9rLMQ4WfU7LBPtUw/g1+8TNqW0CG3hcbpTiUfA6Qyvdi7JKBm3kG+CndrAO56K19XscVK24dYlfi+CPNILTmDzLKoZ20I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028418; c=relaxed/simple;
	bh=zI1vrnN3CSQaF4DZgFEXrc+wi+SOq+NtAQATjpMeOyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aNxgCW1gxJx00qlfyHRkehyLuo4qwk7C+21Es+nsebJhGi8S4zCYEz7K0sI65Ga58eXg4OzW7rZtzJbdPAh8DibMS3X7whbbN0GwnQZLrzoX70EDNjle8SjL+6zZUWzNiuXK/1oKntLPcQ2oWShZhtIhiZXJ4jHdELL8BOQOftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7KnewJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7KnewJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF00D1F00898;
	Mon, 21 Sep 2026 22:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790028416;
	bh=Z25CwFYjwp770QGzsu5N6PzvULSR9SKzrkog69fab/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=a7KnewJbguPGVj774EEf1Q4AeAULQd63mDxhPqFk20yPYExLbRvH/LrAMkKXYi7EY
	 7TSOQ9KflW8AgCM45c6dJmbqMrJyqIaXc/fnMEnBVKZbmDyOESIQTDSK+VrC1fcNkq
	 +O1TFQygop/3mOBziM9iQ62txTjCQpZBC3u3EzhMymlvpwoZ/f2LpI0hX7UGue52GD
	 CIbbtiC4U3QUrymQ8fP3cfBfLx6U3CFRIEkG7aJiIcZBfpoIttog/qsJLIF8V8juJR
	 NpFklnyRZ3xTdNmf8uuSIYiqyt+9wQlmGHIgNn0yQ7AEWGTp0slsSWfvX6MFNkFe8W
	 vmRRgyt4Jg60w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568E639D237B;
	Mon, 21 Sep 2026 21:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf,
 parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc JITs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179002740489.3252619.2335577267163458285.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 21:50:04 +0000
References: <20260915022905.1535566-1-main.kalliope@gmail.com>
In-Reply-To: <20260915022905.1535566-1-main.kalliope@gmail.com>
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, James.Bottomley@HansenPartnership.com,
 deller@gmx.de, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, visitorckw@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 14 Sep 2026 22:29:03 -0400 you wrote:
> The parisc BPF JITs emit unsigned divide and remainder for signed
> BPF_DIV and BPF_MOD (off == 1), so neither implements signed BPF_SDIV
> and BPF_SMOD. Negative operands therefore produce unsigned results.
> 
> Patch 1 adds signed support to the parisc64 JIT and shared signed
> 64-bit helpers. Patch 2 adds support to the parisc32 JIT, using those
> helpers for ALU64 and the signed millicode routines for ALU32.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc64 JIT
    https://git.kernel.org/bpf/bpf-next/c/32a7b17bc8e7
  - [bpf-next,v2,2/2] bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc32 JIT
    https://git.kernel.org/bpf/bpf-next/c/dbda00ac6f0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


