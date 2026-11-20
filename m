Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144808;
	b=coxgf9D9EmFrPwrKtfHhU7bVQJiS+3+t3fVIJFcEbn1YGHz5+fuCicbEXgYhBAgwMcKf
	 5F0Vq7UC5RiJZdd+xGoFgYpDPqOfFJwA8feGT0rTVpHwrCQyDriO08Gy7A8RnvRzRd54M
	 K/3/sUtc4Zpw0R8Ra1h/JN4QHXYhLiOJQSIsdw3Mx3lDpkUqU78DliWVDjiBqLP8Vgx74
	 cYCXe4mRnHXxdwPGHo+NiPDrflgIAf4ebIt6H+ICd96/HZoFAHUCccHca8llYX9etTofC
	 JYcDPughnhYTpxT/RrC2V/F4/5+t3ZgFQDC+GCLT0xmZ5k/7WRBYHcfxy+wiNJDDvjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=QAz06P84KVTpSPjKR/E+e7jxJV9J4nr7PghAGZ65rqI=;
	b=jGdXjgO7XfvfaDA5stl96lrdIepOi1lQErrjD2D9ePlrRdFGhUgAC9bHRaHxgB5aQDf3
	 7+7O50yxqq7X++KTw+zDm/iZUUbTNcHALgoKnXOvTSKOEf2mVVZWv8kiKet1vusmenz+a
	 7Nkg848P5YgSufn1NOUK6OoGcjfTN4uSkmuNpnfXXNYg3Vx4MfKAYWbyURLQy0X+A/zCz
	 VsRh6cZ18x0KyFow9QS/9Jm4Im7orBSLNSo1QtMVI5u4ZaV/CJwgpP+3KTuyX/LvJ2Iw3
	 yeGTiHL0wXE6qP4/wH/oYDc9kmD9e6gB6v5KnzQYa1ghBJUOqfRPYwy4AcLfZ2uDKHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hrSfPtRK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62550606A33F;
	Fri, 20 Nov 2026 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hrSfPtRK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BB81F000C6;
	Fri, 20 Nov 2026 03:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795144807;
	bh=QAz06P84KVTpSPjKR/E+e7jxJV9J4nr7PghAGZ65rqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hrSfPtRKgoqBHTj9h3JGB08HVRXbLnSh52xQBNYtMVZumwWMoHUJ+akN32CEMyUcf
	 x7XVYrd6AdACKwpKCuZZT8NgpuaQx7Z3rehy3Fg04NTQpv15DaTphcltfP7xodNx48
	 pLy9UzBQrIygO3ZkyTsVSpJ3sjH0wAG/94Jb1oHO3eEsSZJEvXyzM3dx/52FedNOPL
	 CL8cjhmBp/ho/BoBWDuGzx6ofFcQAM8lygWmG8vjgizmgk9dJUGESzKZf5Tk3ieKvJ
	 hDt9KTFS3xTkyDa4nNxRUgHMYSkjAPhy1rIAZ1BQmVuZyHtGIE3GAoXAHpjJSvC11E
	 IklD3JelTcFAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7749C3808209;
	Fri, 20 Nov 2026 03:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] tcp: initialize missing request_sock fields in
 syncookie path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179514480628.4002121.12235176625160890158.git-patchwork-notify@kernel.org>
Date: Fri, 20 Nov 2026 03:20:06 +0000
References: <20261118210933.2477423-1-thaisonphan@google.com>
In-Reply-To: <20261118210933.2477423-1-thaisonphan@google.com>
To: Thaison Phan <thaisonphan@google.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 matttbe@kernel.org, horms@kernel.org, ij@kernel.org,
 olivier.tilmans@nokia.com, chia-yu.chang@nokia-bell-labs.com,
 stani@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Nov 2026 21:09:31 +0000 you wrote:
> Initialize missing request_sock fields for TCP connections accepted via
> SYN cookies, where cookie_tcp_reqsk_alloc() and
> bpf_sk_assign_tcp_reqsk() allocate without __GFP_ZERO:
> 
> - Patch 1 initializes ireq->ir_rmt_addr and ireq->ir_loc_addr to
>   LOOPBACK4_IPV6 in cookie_v6_check(), matching tcp_v6_init_req().
> - Patch 2 initializes the AccECN request_sock fields in
>   cookie_tcp_reqsk_init() and sets syn_ect_snt in cookie_{v4,v6}_check()
>   for kernel-generated cookies (!req->syncookie), matching
>   tcp_openreq_init() and tcp_{v4,v6}_send_synack().
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] tcp: initialize ir_rmt_addr and ir_loc_addr in cookie_v6_check()
    https://git.kernel.org/netdev/net/c/7411fb192907
  - [net,v4,2/2] tcp: accecn: initialize AccECN fields in syncookie path
    https://git.kernel.org/netdev/net/c/ce28b1a4d137

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


