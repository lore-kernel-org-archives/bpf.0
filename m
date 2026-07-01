Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E582E762C;
	Wed,  1 Jul 2026 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864029; cv=none; b=EFkYvgDyaXxGwtiHQk/cl6Ebm7XW++xjfvVYFL3XlGgtpa5EQofYCpmZf6xbcIbwKcU0PMBP/k3hPomGazPSOEH4EHQ6yZK2l6alR2RHDxVuDoaXk0vBMwRJiWO97dJPuRgYJ4LLDhGVrH5JkS9RO0PlFWkH2TUk0wBh+9XXba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864029; c=relaxed/simple;
	bh=k32ehnz4IuXU6wPQSqwRpQPB9rqHt1M/h5JJM/2w0CE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SGqNFdISK0alMBIubeaVBeLaPjzHaeJeJZoqSfYBtJ2ktpVJKeq4Ooa2H1rDP3aBccM48uOt4wXF+Me8OSqRYYWBjloQuyRE9Pa0V8G/Zg+qMSbpIh4f9b+Cv1UYGvDIJUt3YIgN03RWDlhNxSw34f+EB0gwDukghLBt/UrnguI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddur2im8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddur2im8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FF01F000E9;
	Wed,  1 Jul 2026 00:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782864028;
	bh=gRzYk816UJfDAJRIIcceXJ6zh52SBooRr0jxl3yODms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ddur2im8Fok2dWxq3wl1S7oT7NPHPtg/NYxVA1DmzbFBVpRad3N1yUSnh5YqHjNOL
	 lhEUUP5kozRstYx5TyfaGQHeM2w7YWnG/lUelj9E2V9fG1W8agdcZsi+j6XSeGEysd
	 LYJ69p6uLyduLjtjCb1KmDswym7/mOnrLfcjqSHCe+hZlcJ0nVfSZg4AvYeG350mUq
	 LFy7TyyH8/1rG9mbEk8Q6kUSJrqyFY5jOru31CMBTR5hu4CksJy/tIRAMQJrd5WbJP
	 BTdEs1VSrKyIREgKJ1YxHVPqQrMiFZuTU4nX9GRAPrv3YEMTMQchPGGTjc1rbBbs//
	 mij2gOfnBqvRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198D4393A963;
	Wed,  1 Jul 2026 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] selftests/xsk: Preserve UMEM view in
 BIDIRECTIONAL test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178286401163.341356.4009907939641685478.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 00:00:11 +0000
References: <20260629191221.2700-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260629191221.2700-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 21:12:21 +0200 you wrote:
> The UMEM state refactor made __send_pkts() use xsk->umem for Tx
> address generation. At the same time, the shared-UMEM Tx setup copies the
> Rx UMEM state into a Tx-local state object and resets base_addr and
> next_buffer before configuring the Tx socket.
> 
> Passing that Tx-local object to xsk_configure() makes xsk->umem point to
> the zero-based Tx allocator state. This breaks the BIDIRECTIONAL test once
> the roles are switched: the same socket is then used for Rx validation, but
> received descriptors from the other logical UMEM half are checked against
> base_addr == 0. With the new UMEM bounds check, a valid address such as
> base_addr + XDP_PACKET_HEADROOM is rejected as being outside the UMEM
> window.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] selftests/xsk: Preserve UMEM view in BIDIRECTIONAL test
    https://git.kernel.org/netdev/net-next/c/333289d1690d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


