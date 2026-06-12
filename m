Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8070B3546E8;
	Fri, 12 Jun 2026 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308216; cv=none; b=FD0yKj0t7mDfk+gOcyvebunBxE6uuBTgHfjcV12F/16Z+UBHMkXOuIJm0fygfSdVhYHOyoaUtTGAN30CyUAqHllCuDxpBR3kSSe+/FJM7AnmRVZE4thMXYghA1nCBOr3ph3IwwU/ASPkEyz+dHzJV/qaTlE5IsOOvJsPiqKFpsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308216; c=relaxed/simple;
	bh=4j8HnP7rDNK4QGg7B7GKrNRwpXoVrbMfpTMJ0Vvd2ow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rLYADsJ8NLtdPG4ToUwytJnmeYTEBN8cnJvgBDA9eWgS6/PLvhibvXiEiokweGukBlhjtBNXOKjQ6rRBgN5Gcm1PXw64RIlrjnitxd77K9WPFavzx/zD/DcjOx5RZxJvRSCLB+ePcK08BC/R49QWlUlkhw/JAremdSJ2C1+zJbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYoD/P5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYoD/P5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408141F000E9;
	Fri, 12 Jun 2026 23:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781308215;
	bh=aaZ+4PABV+T/iXUfkYWgt6xGpyJ508C8HavaF5zsDyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NYoD/P5zL8VnyxziOoashuNMYOIRQDqROApC9ge0Q3+a4m9/k9zThotBLxI4HBUdV
	 6bEgQuKwCa3VbAArvCvi9acG8W9kEAfa+/gr18BVNjzrF9zY4ajTpRn63tyWahBf88
	 tbS96e9GIUb7+yxWvo5gE7+Hwn71Jw4j64hIxk9Q3hmX0dYfjlF+kSfBTfsvvjDtDI
	 u3wzF4nGYj5bNk45oFopTplwg2v6shRMesCz1AD6VkLHLIVKznSxTY0fr1b9CgpVHu
	 Ubjts1hYL08GVp12IpUJ//VNRHjNRMn4wHc8DtiYW80ZFf/HcN7YZMMKPJKUVSU3Ac
	 G5uJ9Z2I2Zkqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1980A39E9602;
	Fri, 12 Jun 2026 23:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] tcp: clear sock_ops cb flags before force-closing
 a
 child socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130821163.1294761.4991260743602842712.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:50:11 +0000
References: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, horms@kernel.org,
 brakmo@fb.com, ast@kernel.org, jiayuan.chen@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 09:29:18 +0000 you wrote:
> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
> without it.
> 
> If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state()
> calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me():
> 
> [...]

Here is the summary with links:
  - [net,v3] tcp: clear sock_ops cb flags before force-closing a child socket
    https://git.kernel.org/netdev/net/c/990348e5bb45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


