Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F155449426C
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059648; cv=none; b=swXEjm6NLCHYvsx6wWCiDOmBsVJrgM6YMMSn4s55Gy2DXboJrGq1C+QJnTHYSIfw+lkQOz1WoxSsgRcUBcBCfZ/H7T+1W8WAyyBGRUKA1JYbqEF06GH+bpjClrZACYMeUEKG2fUnqxarg3KUuzRRp1OxaqrbNvacoU/U0LuOL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059648; c=relaxed/simple;
	bh=M/7OLACXAtDverq6ev0slogK8Oy7kUDqfUjAEh8TaxA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sS9yz+23Lau01wrsnkvITOIFsW4+rpO1E01duw3uklytk2SymVLqMZBFTqAl1o2Pmf5DsOMnnZ2Gt+e0gGv1TNl0tGC/RXyUeuYpZNlr4n+awAUAAAWkuFNyG8Gxrszr3HY6OTbBSOlAjphv6rVvbN5YXdw05W6Vl45+xqsiGJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX7UXjQh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX7UXjQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831CD1F000E9;
	Thu,  6 Aug 2026 23:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786059646;
	bh=w1FTTWO5fKIHI+Zg/S1CSKVerUSbLGwp1JE3OWObZVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZX7UXjQhA1ps1oCbKA6r+6KKnhlgcL5jvhnqxQDlipAjvc2Uqazuf0thQw1dqCSNJ
	 gPcnuJDjqIFsIt2+6Cwn0YogkoI8KZbIR8VmRMhECD1eFeFUyzDGDjryCpotcluAs2
	 S/69MojrYW4syI18l1z6vS1EgsNoZdpjDsIDlOyg88oybLnv1vqpaZPZHTkHmmUKWt
	 kqMNw4lVGkapdOs4r46wNSBNb+FuVKZkHvW4OttMgPQQ8hQKDdNUXBicUUOUpSyGis
	 g+28BKiGvEbDoldhq9IDnmAWu+AyE067P7YlcXfR3jwJ+m1dqq6+dazobRXOnBFVRb
	 RTvC9UmNug7ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2C380A950;
	Thu,  6 Aug 2026 23:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] rqspinlock: Reset tail when preserving queue on
 deadlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178605960540.1528751.4736380552781847630.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 23:40:05 +0000
References: <20260802021759.1139457-1-memxor@gmail.com>
In-Reply-To: <20260802021759.1139457-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Sun,  2 Aug 2026 04:17:59 +0200 you wrote:
> Currently, the destruction of the waiter queue is suppressed for
> rqspinlock in cases where a deadlock is detected. Deadlock checks happen
> relatively frequently (on entry for AA, within 1ms for ABBA), and waiter
> threads may not be involved in locking scenarios involving deadlocks.
> Thus, it is useful to not flush the queue and let other waiters take a
> stab at acquiring the lock after we detect a deadlock and exit.
> 
> [...]

Here is the summary with links:
  - [bpf,v1] rqspinlock: Reset tail when preserving queue on deadlock
    https://git.kernel.org/bpf/bpf/c/7a3c0289c3c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


