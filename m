Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BCB407CF1;
	Mon,  5 Oct 2026 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791243615; cv=none; b=WxPmDcvF5j/jB2rtTDpQ8X9KVJpEc/ArsK6CJqb+nlrmTSMGSEh54NvqAt90kq/91u+Seq2YCsNNOlagJD4FCiNP8Zsqgu2B6ziaOEc1HjyZQswjsDnlCmupC2tBz/yIL4p54eim4q/ig9pYc3QTIMl5d1jq8CXz3JD5kKecJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791243615; c=relaxed/simple;
	bh=AbcvKULNONvuc+S43VLsDin5gF5ZUyDCXAIyZ9/90Hs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h6GYHumZ+FHoILaKY+SEGUxz5FZlPMggdva5UB+6aDJyPIs3kBdpRnmk3wsxV7cMxd83xfH87J+V5W1kOLrWRYEWVfiMaFdyFEf+BsP8EOKTpVU53pwgrPb2W1H25GWV0LnPTejQdgWhLGurUY4wMRx4qh5/ufZ2nb+riTgUsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mznSyvN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mznSyvN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2F91F000FF;
	Mon,  5 Oct 2026 23:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791243613;
	bh=uy9SnCApjJ7biyLuvnHLy3sJnW5JMrQVnkIiOTWAsVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mznSyvN2Ck/Dj2CPK38qOTrUpoJfkVPgMlZ/UTd2qM/ZJnka74+O2AxKK+zAwYxyQ
	 ii1xK2MjqwwB9HWX4eV7i9szMRGw1jEdbb2Oaw2gfObcRswv7NKWDQjk0yXGpLetXQ
	 2R+0+WD19R36pf6K3T/8kDtMj45RzYRI9OxZsICKRyw/baOGQtFzBdTu3PKW7rjVfM
	 P8sp9yOf4gpSrB7Xw0/0CUuwjFnftKs4PGlowoxdIgvy5qAfSe1jpq20yOjtWPb3rX
	 SaphTGayDi9UWKdSzLBw+1p+7P1U6JTszQEY4iuP7WHIW/j6e6hhv5L+fr3auGevoG
	 RzxiRU95EmiDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43B2392667F;
	Mon,  5 Oct 2026 23:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 00/12] gve: AdminQ mode related refactors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124361227.1939764.8129284780606998603.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 23:40:12 +0000
References: <20260930190428.1130007-1-hramamurthy@google.com>
In-Reply-To: <20260930190428.1130007-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, nktgrg@google.com, maolson@google.com,
 thostet@google.com, jacob.e.keller@intel.com, debarghyak@google.com,
 kees@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 19:04:16 +0000 you wrote:
> This series is preparing the driver for the addition of a new control
> plane mode(MailboxQ) by commonizing and reusing as much code as possible.
> MailboxQ is a new control plane infrastructure which uses mailbox queues.
> This is a new control plane to communicate with the device when the driver
> is running on bare-metal instances as well as newer versions of the device.
> 
> This series contains 2 main changes to the gve driver's existing control
> plane(AdminQ):
> 1) refactor some initialization/teardown path methods to make it work for
>    both control planes.
> 2) add gve_ctrl_ops structure to the driver for various control plane
>    operations
> 
> [...]

Here is the summary with links:
  - [net-next,v9,01/12] gve: add struct gve_device_info to hold device properties
    https://git.kernel.org/netdev/net-next/c/130634764549
  - [net-next,v9,02/12] gve: introduce control plane operations structure
    https://git.kernel.org/netdev/net-next/c/d6194e4eaff9
  - [net-next,v9,03/12] gve: introduce ctrl ops to set vectors and Qs
    https://git.kernel.org/netdev/net-next/c/d320436137b7
  - [net-next,v9,04/12] gve: introduce gve_adminq_get_device_properties()
    https://git.kernel.org/netdev/net-next/c/a01cb6b77e9a
  - [net-next,v9,05/12] gve: refactor gve_init_priv for reset path
    https://git.kernel.org/netdev/net-next/c/fd1e72e09661
  - [net-next,v9,06/12] gve: simplify reset logic
    https://git.kernel.org/netdev/net-next/c/23b3b49d204b
  - [net-next,v9,07/12] gve: add gve_ctrl_ops for gve initialization/teardown sequences
    https://git.kernel.org/netdev/net-next/c/5914443d971b
  - [net-next,v9,08/12] gve: split up notify block allocation and setup paths
    https://git.kernel.org/netdev/net-next/c/fed9970a6550
  - [net-next,v9,09/12] gve: introduce new methods to handle IRQ doorbells
    https://git.kernel.org/netdev/net-next/c/5bc0c9796787
  - [net-next,v9,10/12] gve: setup and teardown management interrupts
    https://git.kernel.org/netdev/net-next/c/5e86cf5e2f24
  - [net-next,v9,11/12] gve: add ctrl ops for queue operations
    https://git.kernel.org/netdev/net-next/c/71f905f14b83
  - [net-next,v9,12/12] gve: add link status/speed ctrl ops
    https://git.kernel.org/netdev/net-next/c/bbe522b0f237

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


