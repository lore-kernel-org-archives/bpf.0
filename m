Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22633FFFA2
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672229; cv=none; b=qz6fjHmam7MNmy6Dwx7w8B4mG1Q7eEBk8d9oL1WAwvklftUydFEncthrdyIGjIvtJEQmZsq12tIQyFBU2DyprPI8u3SnjVkGQlTqZwMR1WGxnACYdS+9K6/cQvzDQvedAFJcVYlDpCWEB10woTPK4iBp8Bf3TTmoDUSi/93wVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672229; c=relaxed/simple;
	bh=t5apRlKwYwy5LDUJCzVcFrX4GpXANUlwblI/hgOeLbI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I3J/dkG5bt5H9s4MazX72RjNDj8Y1Ao5Y/WdbzBwq+2MklfvWQa/6SllXC4RJ3Kmov8wFFBCsMmFnufomIxPLy9pxMGek22yvinssv8XZDBlhg63vy+7VWa4r7YJnWaqwEWrPvbAGSFHiiMD15O0PuA29TOn1LAAja3afl3d7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpXKkHVG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpXKkHVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79ECB1F00893;
	Fri,  5 Jun 2026 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780672228;
	bh=cCRGDHoWcLKeKQGu65CJtoO37pGsyY1HRvuXKlaRFf8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jpXKkHVGO23x4Z6w2tjJpni9BBH45ifPs/ag5oiVS9HWQS6l/nJqkVQ8Ck8U+8azw
	 Iha/dAmBnmfZzQzaM2756Z3TCmB/AfXte23cCLcD6O35C92uOi7AhX1XCFn54roQHZ
	 WlUcMiNux9bnTkYMbDYfCuGHOIQjIiiRnYZe2le+NZvl/k60Sotou72oTmiPIRNiTV
	 gXbkkzt+ivj0XCbbfHiZA3ENny3/Gjut63u94Ay/DRHv1utiYIRaMvvx52npRg89CU
	 E6JIgGqq4Ol+8e0nIOnU+Sb9EFVD2Bxw5qHSpfz9jJdB78ylbcT51jcUG3PgFBcSpT
	 c3NWoB+zCyTBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197A63930BA1;
	Fri,  5 Jun 2026 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] MAINTAINERS: BPF: Add self as reviewer and run
 parse_maintainers.pl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178067222864.3794367.12121686699991914359.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 15:10:28 +0000
References: <20260604184252.9917-1-emil@etsalapatis.com>
In-Reply-To: <20260604184252.9917-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  4 Jun 2026 14:42:52 -0400 you wrote:
> Add myself as a reviewer for the BPF subsystem. While at it, run
> ./scripts/parse_maintainers.pl --order and reorder the BPF-related
> entries in the file accordingly.
> 
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  MAINTAINERS | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [bpf-next] MAINTAINERS: BPF: Add self as reviewer and run parse_maintainers.pl
    https://git.kernel.org/bpf/bpf-next/c/390dc36ccfa1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


