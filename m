Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4E39D6E8;
	Thu, 15 Oct 2026 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081822; cv=none; b=LOcVD7tyBeALFqmivXa0JEEQmZvt3gkgFxSaRoTVFoc0QuOZK1ztviabv52t5leKci1hzZi/jjrE57cFbm11uxAuAbg1ON3tMD7OI2CprU/hdzks4woPvi691f88RIU9fxeWURYKkCGfciI80AwKV6rNVbfYsaqsu8xkakOr70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081822; c=relaxed/simple;
	bh=30LOp6+RkMnIpHqFhw/C5WaWI63DnOKBuwntLWD1ans=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o4ee+SwBvXVBlJqTv8rD+CtYgVtvFG2Y0mgouRZ3DUNO8k4eZ9C+/RlOpXdlJceQZzkpSrO4e8+C2mOn9qGdJ4h3tjpysnWb7zbP+ccXFVV6r1YhKB61HvmWut9wUOIBPk+Zdyo7HDJlNmMpMLsc0qPCy4F2pWgNYjbWLtYffGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEftDSuV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEftDSuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FCE1F000C4;
	Thu, 15 Oct 2026 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792081808;
	bh=tKlnATWw1JtYNKUNRhgkvJfuLsg0XuHGYw4citc5VGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YEftDSuVoVhegPYzStE3Rt+8wghhRkt2dWbIdLMnU6P20tgBlWHHPYlmUREoUiSNM
	 23C+qIv/CUHcKPI7XWr+mCB2KAY3qWyHEXOOaNOKOaN+pbvPQpJAX1WXm/+qlYbBb+
	 qU3WSUPWqKfunOOWbd+UIrL3BFfmL3Rlc//yZRh92PncWBqbHlA3Ic46Me8pmIwvp/
	 B80IRnboHpe/VMDc7jfZ0GjvnM9L/bCrjrrY1emoux52O9e8qFueLgTebOXtg6tCuX
	 pEHOEWuXbYeYJTeV5ZDbmrTY8KtTLiIbj2ZRPiDPDfl1IiluUhmkPFZpJ+PlFssn7z
	 iOnVQTNowjBsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F158B3808209;
	Thu, 15 Oct 2026 16:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Create the vxlan devices of
 test_tunnel with their MAC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179208180656.3995356.3658263432138680681.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 16:30:06 +0000
References: 
 <20261009-selftests-bpf-tunnel-vxlan-mac-v1-1-624dd769c334@gmail.com>
In-Reply-To: 
 <20261009-selftests-bpf-tunnel-vxlan-mac-v1-1-624dd769c334@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, fankaixi.li@bytedance.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 09 Oct 2026 09:48:44 +0800 you wrote:
> The vxlan tests of test_tunnel create a tunnel device in the initial
> netns with "ip link add", and then give it the MAC address that the
> static neighbor entry at the other end points to with "ip link set".
> 
> systemd-udevd assigns new devices of the initial netns a MAC address of
> its own, following its MACAddressPolicy, when it handles their uevent.
> When it gets to that after the test set the address, the replies sent
> to the configured MAC are dropped as meant for another host, and the
> ping of vxlan_tunnel fails after 10 seconds.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Create the vxlan devices of test_tunnel with their MAC
    https://git.kernel.org/bpf/bpf-next/c/33cbc5c2cadf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


