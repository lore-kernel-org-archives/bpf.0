Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED192236F0
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470961; cv=none; b=ad+b7yiX9zrySoy5KiDsPYjdGzO90ya3tuncIvO+Z70emwzNcqnXBmherRf9GBS2mcjJyrG6ZkAWCw49+THNcXd/2+Exd5q98uFjqr6rIAW8TxKnpCpAZX0hZftcEwcGNPKz0u4r4d2q2SdJ2yX1ZQklZiQkfyITdUwdmtLI754=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470961; c=relaxed/simple;
	bh=nzTT/zPbpE015MhY1+eRyLx0RCHx52y5D3bcO044M/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oqqrhZUmefB6rvZD+NoaTTSF7WssLWv18XQzrpSAbs8t4+kZkRu2k5Xkm0lqnEThFOq8YMhxc4/Dn9xSkvd+wSJ/08K1V5dXdL+k0bQeMeYNcaK0QgoazFJHEe2QWwbWtw7reFy3tD/FCWhuFBkj2SHxoaGGrOCw/r/Rw3ZNoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0S/IZnj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0S/IZnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE751F000E9;
	Sun, 14 Jun 2026 21:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781470959;
	bh=bUDfgt9reArlBOzvL5F1vOz6N6MC7UeXPSxahC3HZj0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l0S/IZnjTozuOtzPB4GwD9nOkQjenj6+ICqAJTe53yWEO9LKUdONEmqCmWwW9e6iv
	 OfJuwU6btskLeFuU04E3v1PwW0xZoq/i00UDGr36Tfsyx4s8UfjxlGOYxGCALH/r1x
	 yXgw/UDXKDGJWdROgBq35mCmI8ZEKGM7kL2r72WWACGebk57zed7VkbC7J6sDxISU5
	 2zsuHzzfAid4stobuTHcdALV8WwHWeFGDQ+VQoNnznVHNBfOvlPYjr/pJ7RdsuK3ve
	 KSz+zpHyWO4OnBuR5NZZLhldzeELJuDU3jWU5frlQMZTerMMk2E3YPO43q4VoeSMd1
	 JMwqBPhM3JJSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93ADD3A566CB;
	Sun, 14 Jun 2026 21:02:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Raise maximum call chain depth to 16 frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178147095515.2314706.12113655592695890468.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jun 2026 21:02:35 +0000
References: <20260613180755.29671-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260613180755.29671-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 memxor@gmail.com, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 13 Jun 2026 11:07:55 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Bump MAX_CALL_FRAMES from 8 to 16 to allow deeper call chains
> that Rust-BPF requires and update selftests.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Raise maximum call chain depth to 16 frames
    https://git.kernel.org/bpf/bpf-next/c/2148794eeaf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


