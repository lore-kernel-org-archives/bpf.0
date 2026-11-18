Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965408;
	b=nfXx0ScmLEOiI6bK14HyYwWqgfxq2czJg8kMmY3yyXW1ODos3Ugnu7qi5IC7tEMac2zf
	 X6sknGQl05Xc21K0001RfEqKGa1eDPgWtz3BRJE3/G6W3wDwbSsBJdHbkG85nBFoeNfPl
	 BvPfjYBN3fpcgihdP8zWyZ5ANDkboUBBcGDsoR4sDUj0oHTi2qRpvBNsBJbK82DOUfgMJ
	 THSvOZ5tXM5MmZDGv5WPmCJEENsWyqVuXkQH+8GJwDrW95QmxY9XXsffoi/X2AEEDxhHU
	 vOqInbzx0Ba39g9liAuFg/2J/l3lPetw6MqGB6hwDc5f6MKuLh8+2IncHkpPeJMZHHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=FXBNCEdh8oP3KsSYkzuyoSivUBB5RpWTN268XzgGT6E=;
	b=OCHhGxw3/OuAYmDWS8qDyF2SeSdVHc58rZn0oO5Woi7faahUR8I/pTy/Ot0cjm5Sy2Pa
	 jzHf2m+G65Ek19DZ6USAMvx+xz9pFoWMaWNAOPyaOLv0qCZrqMcDazrxxAHmf1Nx7juKf
	 qnpIKPkYgEWomhRqwzCgiGDmg6SiljMIZQ7JcqCd6ifHth9A3Lzs+LOcQre2tiS6kl+pp
	 GdecTdJCD/Xi2XfTq/AH4zmdZuoXg/EFH7FbyuPcBaa6bDLydAzEtBKOz7306tyALwk7/
	 lca9Sqh2lTDCpSU1k70XrNf3Qb2/LALqHVWyzo8JUVSLbQHP2Fdz1lNMv3bkdvru6TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObW3WkPo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB97606A332;
	Wed, 18 Nov 2026 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObW3WkPo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0971F000C4;
	Wed, 18 Nov 2026 01:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794965407;
	bh=FXBNCEdh8oP3KsSYkzuyoSivUBB5RpWTN268XzgGT6E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ObW3WkPobwaM2leAsoVd4h9sHQuZRrw9ECELXZ7whvjHgeVr/SeMksSew7/8JMFqc
	 rRO94yJ08bWXRaeA+mUXFeyjfkLC85Kgl9Qxcauydo5XMD5CoYtXrgJ27r3bqOnEBv
	 +56siO91h48An9hOevEDr2p589+iAEetOKHdfDhKshCBqmq/xDBXjlj7i8sRk2v922
	 FtPDTyBWGvEL6QEPLCluAxUvjQ2SNbtW6Ck2kW2IKuREkMI12zF+/c6zQD+hobVRJn
	 O88VTx7kdjRlXHKBF4YvWK6iirBz6Xcae285ks1HuHR+oHHMNqBSQofvZtQw4KQ/xW
	 zhrL3FWnv+lgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B448E392E98A;
	Wed, 18 Nov 2026 01:30:07 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net/sched: act_api: fold
 tcf_idr_create_from_flags()
 into tcf_idr_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179496540629.1393228.2281753335944848846.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 01:30:06 +0000
References: <20261115201824.3680803-1-acassen@corp.free.fr>
In-Reply-To: <20261115201824.3680803-1-acassen@corp.free.fr>
To: Alexandre Cassen <acassen@corp.free.fr>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vladimir.oltean@nxp.com, idosch@nvidia.com, daniel@iogearbox.net,
 martin.lau@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, netdev@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Nov 2026 21:18:22 +0100 you wrote:
> All actions but act_simple pick their per CPU stats from the action
> flags through tcf_idr_create_from_flags(). Merge it into
> tcf_idr_create(), which now allocates per CPU stats unless
> TCA_ACT_FLAGS_NO_PERCPU_STATS is set.
> 
> act_simple prints the packet count of its plain stats. It now passes
> TCA_ACT_FLAGS_NO_PERCPU_STATS. Its only visible change is the no_percpu
> flag that tc actions ls now shows:
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: act_api: fold tcf_idr_create_from_flags() into tcf_idr_create()
    https://git.kernel.org/netdev/net-next/c/38c6ccbde38e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


