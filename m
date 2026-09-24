Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1033472783;
	Thu, 24 Sep 2026 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248281; cv=none; b=DSPJ3o0UKF9bs2LGPbNZDp5whDzTD3QM4SgnaUTTACcos5Juor7gncKWMgCTenlmCmaBXsfZe66iEZI4V2jYM/lYaYBrBfKJsG1QepaIuAOOJwISVe4ZqK8eZskljt8dQ3PbEevnYpL3EIiYboHyfQAAh9cVFJUbPO5NXT8w1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248281; c=relaxed/simple;
	bh=EXaNMocxdJn3mF+C0k1oAU4v6nW8AVms+aHaJQxxYDk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VVixzPKTk45zBGufrWc6dx8xskU6Kd/Q0DRmydARBUgWZjzJaTqYadOzolKq8xPdidZ7dda5j3eS2pV4lNKwgHvYldO8DJZIoADu74nlCzcPofpl39WOAJ2D7CdANTPoORbjyLjf9HE2utmP868Hy1tdlfrH7DjN9w2ZQZnGyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtIHfNTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtIHfNTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6785D1F000FF;
	Thu, 24 Sep 2026 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790248279;
	bh=CMhFcLzV26M5BvYG1wSSBTgf7OIOdw1DOYwdtjxadas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OtIHfNTWI0bDRLoO9b933D3Z1UWQHZCmOL6BvO7EBl3FHj0/LrDGv5ujlWXl3VfzQ
	 e2nDwJB6GIghDoRdbCOBJS233zIaqhdtOBpxw8fyUr7MpCTsoUWPYptjpHPdaUFNlU
	 nD2njvRKxWUhmLvwLSemKqRVUZZ4YGsjjY4JL3vrQdKgXGKM6/eNClI1ym6YK4USEO
	 Yfy1VeNRS+FceZrp3U+TDYvWUFnp2ppoFdmEpkfKp3+ubsvgj/t/IYfwMivT+EmnCT
	 umnGSv5HWUKKOfaDFt7oHMlyX4kGbRxyY0yEIUALlnZ3mQXwzOCf5ien/rhyZsrYcc
	 upxaYLJtYYCjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D091C39EB075;
	Thu, 24 Sep 2026 11:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: fbnic: put back netmem reference
 xdp_buff_add_frag() fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179024820851.1482887.2143457542729538087.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 11:10:08 +0000
References: <20260922-fbnic-refcount-fix-v1-1-31e5862c9893@gmail.com>
In-Reply-To: <20260922-fbnic-refcount-fix-v1-1-31e5862c9893@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 22 Sep 2026 12:53:28 -0700 you wrote:
> fbnic_add_rx_frag() takes a page_pool reference out of the buffer's
> pagecnt_bias before handing the fragment to xdp_buff_add_frag(). If that
> call fails it has not taken ownership of the netmem: the fragment is not
> recorded in the shared info, and fbnic_put_pkt_buff() will not put the
> reference back.
> 
> Put the netmem reference back on the failure path.
> 
> [...]

Here is the summary with links:
  - [net-next] eth: fbnic: put back netmem reference xdp_buff_add_frag() fails
    https://git.kernel.org/netdev/net-next/c/1c85ea5df86b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


