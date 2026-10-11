Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235344F565;
	Sun, 11 Oct 2026 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726015; cv=none; b=ZIgUUC6zBnDyLSp3RmjjL6eE8yQ3T+C/QSvdKxz/cNUotPv70SGH4JWVPutcdak42h6MyYQF8v8ZStK9puicAOpUD/PptZ2FYEAUSBqNzvYac7y1UzlA5wnf91qHcCHt5XdaG8MKUBIZADSyexovOlU0gzWIGyesX2unjU2UGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726015; c=relaxed/simple;
	bh=SPk/YHe7zbs6f+VaFjzFq1I21yC7AFP0XMS10MFA+lk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h/LddG8YDD1Qk3eHpTQvjxt0VTdUzAo8wWIgMt+rxzzxTs680Uof8yLCSYAws7uHkuY8cSUGkl9Ji35JIxUYEmL0EzIIICswPkYRcls3Bd2v6QNUI+XyHJpR6EExE3ZI4MuYRQu/9x7Gw3F9rzGPrbvvM6xU/87vyVYvtxUJRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVNxiJVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVNxiJVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0576A1F0089B;
	Sun, 11 Oct 2026 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791726010;
	bh=FHIQ2/ttZvMYlRT/6D0OsTdIGEr5QcIRPG0J3e/7ydw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TVNxiJVFxiZu10UZZKt5BVzgzA1RCMwG+ei5e/IPlQ/Mhonxn7em2yJQLZ+gaJ1LI
	 BLmCYoZjgzug7QV6NcN0c5KKhxgj8LaDrI5dgu/cMhzdi6i1Xg0KV6fO9fTOIxXmDD
	 h2iy+Vv+XnNrgNH7gcBk+PHXaQhCsY/+5/RV3oe2VNrPw4LxSwaNDNZTICDZ747/r5
	 Pazr/GETGutrTqzZtyMUSMpPSqpreKTfZFnR3WMzj+q6yIVffdZA+gJCWJ3JbZ16AW
	 S2Gr7KMI+KjGGaA6sS11Vm1TI1rS9HFENgqX5Tpt9teyuIAxmSSMRMpleE3LxyIDnV
	 PrTJQL6QMqqkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14F33811966;
	Sun, 11 Oct 2026 13:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH bpf-next 0/2] riscv,
 bpf: Support indirect calls to bpf subprogs (callx)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179172600877.2055679.12548960666463019147.git-patchwork-notify@kernel.org>
Date: Sun, 11 Oct 2026 13:40:08 +0000
References: <20260930064928.1909085-1-pulehui@huaweicloud.com>
In-Reply-To: <20260930064928.1909085-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bjorn@kernel.org, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, puranjay@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 30 Sep 2026 06:49:26 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> This series implements support for indirect calls to bpf subprogs on
> riscv64 and enables the corresponding selftests.
> 
> Meanwhile, this series also resolves the test_verifier failures
> previously captured by riscv-bpf-daily due to missing callx support [0].
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next,1/2] riscv, bpf: Support indirect calls to bpf subprogs (callx)
    https://git.kernel.org/bpf/bpf-next/c/1cec0b70fdc6
  - [RESEND,bpf-next,2/2] selftests/bpf: Enable callx related testcases for RV64
    https://git.kernel.org/bpf/bpf-next/c/530dfafc6107

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


