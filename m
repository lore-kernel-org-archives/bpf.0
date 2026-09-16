Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F6440A19;
	Wed, 16 Sep 2026 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588885; cv=none; b=NPyVsq9EjtQqXAmAWGCff8HHpLrqTZc7XHcdUXK4SDzo+VUf7AB4PTNt/aAWbx7PgxR36nW0MCQw201bGPs45TFk0KcOx5wexU6rkIWsPpRpB/1tCGBrEunxSjS/sc7ciDmpQxK5Pjw/REro+0n0HNWtmISYwo3bC2Sl1vU5qT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588885; c=relaxed/simple;
	bh=eRDNX+GkCPlzdU4g6GHkRfBzNx9ZK4vjgFu0E32gSpM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lp2+HM58ecAMZxNFV7QhjWz6r5F8hO16uiazSLmbrCbL1WIUqwiQkn7arbfBkgAmdhm0u19l0YM6OeV23MNLyZOIHeMy1kvCLcYVowiy6u/UhwF1NvED0mWI8xoifDcti+uekQxEifOdeeOZkqnrbrPjIKAr9WaMMkt/LmTL9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S04kCdKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S04kCdKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D411E1F000FF;
	Wed, 16 Sep 2026 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789588870;
	bh=AuxZsOonWzq9OMyyHb09Y0eJmpch+14zfap6ZyP4F8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S04kCdKfAn9L8s5A1i2Xn8Tf3ZepWliZfgdcQTot4fTGbFdr5jyjj4LCSnAoUDkWu
	 f1DiH6cRvpa9u1lOdacGhd4l2QZNimLOKhqyA1yr1RRWU8yLJ4VZvAvqKM3/6kKWqR
	 x8EvC2XHE8eopcTxmeZu+Vw5h6lOVOIc+775REC+VhjQWCIyZSOx9H4FKQw194BLW6
	 9ALBJCHgKbUoHgGgboACtit/4NiDSfFolM0rTwN4lTGfVvQNjuHPe7IyXuCkk91NWh
	 AjrvZGpXCeS1zSYmeEdG1h5JYZDdkKRW0EjTSmB9q0BzTV8IRsMDlplK6fwdDPfA74
	 BqPN1XY6bLihA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A4239E8A5C;
	Wed, 16 Sep 2026 20:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: local_storage: avoid redundant IRQ save on bucket
 locks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178958880489.3266611.6236994598638968517.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 20:00:04 +0000
References: <20260916181001.201787-1-usama.arif@linux.dev>
In-Reply-To: <20260916181001.201787-1-usama.arif@linux.dev>
To: Usama Arif <usama.arif@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, jolsa@kernel.org, justinstitt@google.com,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, martin.lau@linux.dev,
 memxor@gmail.com, morbo@google.com, nathan@kernel.org,
 ndesaulniers@google.com, song@kernel.org, yonghong.song@linux.dev,
 yatsenko@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 16 Sep 2026 11:10:01 -0700 you wrote:
> bpf_local_storage_update() takes the map bucket lock while holding
> local_storage->lock. bpf_selem_unlink_map() does the same; its only
> caller holds local_storage->lock. The outer lock is acquired with
> raw_res_spin_lock_irqsave(), so interrupts are already disabled at both
> sites.
> 
> Using raw_res_spin_lock_irqsave() for the nested lock saves the already
> disabled IRQ state and issues another IRQ disable. The matching unlock
> tests that saved state before leaving interrupts disabled. On x86-64,
> this adds a pushfq/popq/cli sequence and a test/branch around an
> unreachable sti to each acquisition.
> 
> [...]

Here is the summary with links:
  - bpf: local_storage: avoid redundant IRQ save on bucket locks
    https://git.kernel.org/bpf/bpf-next/c/10c4f610b215

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


