Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795221615;
	b=tOWSCHkOtrolOOT8B2rPtXiySx8aOHQIcalZHkvcVObRhhbuclIVedrqnimQQW6BV6xS
	 rZFBkRjgClFzKxg09uWMWgoCODVBTDgiuHblKEq5mQYTWi1jZBAoBm9AgvTYNBtQM8KvH
	 6JHLdv83TiXXlEZpBIEd/jumbbVfzvXEKWk9te73Ssi2bR5cpgN9lCjftm7dBSyim32Me
	 q0psYohJJ/hgVvp0NPBTsgTqFF53GdjHZUAJSnukIWZgsl9HMJp3dLpmDy9NhT1wIRsnT
	 d43mbYcQn/UO0PC0wyVahTOu2Xj5A32Ge61nGB8+1pO1JorYQ8gTimOEi5smsH1ks1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795221615;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=VuKVXev8UIxrsWCdEYjjJ6A+0TY169PgQkoqU6UjXEQ=;
	b=Q4DH25iTfvfMPOwL5xEzE0Ef8IazJHL7Za6Ezogkyw9Ga/4pNhc4BNYX/pgLCwpPMOLC
	 EWrDMgLmGoRXub84XbaHCSE5mhThkCPLt5IImdDOljPZLto+kBbubAFAokOHWsttkA5X9
	 W53up7XhBqO/BRrY3s5LwHq8qIPeqDln7xCB/ekSijPcVxFJaBZlJFnNGOzLEuiVG1xux
	 N8FeNHB15Mqv0R65OqO9/YOeepaj/OWDO/QjOyt9yJVkAVrSN/WEqDYwAnOCJHijd7WDr
	 ux0EJBO4LcSMX9ByajM4KrWJXUAzyBokVNffDVUlqXrAmGPtTVfTAoZZik1CL5oJi/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXZ8laQt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF47606A335;
	Sat, 21 Nov 2026 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXZ8laQt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EA21F000D0;
	Sat, 21 Nov 2026 00:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795221614;
	bh=VuKVXev8UIxrsWCdEYjjJ6A+0TY169PgQkoqU6UjXEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YXZ8laQtv6e7vV48kw6IopHEDcFXxaysZ8DpSztti1dOXip2twXkvtE/Zo+gDfwK4
	 V46syXyZgqR/0HTt8QMEVQkdH/RwaaTxbAJKA6Tv3Aug2paHP4UWWXGg5bmS4sJiGh
	 dK6ZZG44KsBm7VgMAapp7+QVgUxF2cuvQsw3K6eAxr2h5HBULVAhSGZafMRtQvcc/+
	 7iDwGd9QV9oyUcVBcGOHHjmjABuYb59GjQMQhgJgimKs/Bh0xXJqxfN9r4Ujsfl57j
	 /x85hJ1sA+bS+BEm+/LqCAoV4mSbQG3fttzip3fdVM/Aab/4ym4BbSvdTjiHONJ7zg
	 +Ij7Kihhtz9WQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773CB380AA4D;
	Sat, 21 Nov 2026 00:40:14 +0000 (UTC)
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
Subject: Re: [PATCH net v2 0/6] seg6: fix skb checksum updates with
 CHECKSUM_COMPLETE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179522161302.860209.8175109356029301481.git-patchwork-notify@kernel.org>
Date: Sat, 21 Nov 2026 00:40:13 +0000
References: <20261118150251.65-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20261118150251.65-1-andrea.mayer@uniroma2.it>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 david.lebrun@uclouvain.be, daniel@iogearbox.net, m.xhonneux@gmail.com,
 dlebrun@google.com, hangbin.liu@linux.dev, justin.iurman@gmail.com,
 stefano.salsano@uniroma2.it, andrea@common-net.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Nov 2026 16:02:45 +0100 you wrote:
> This series fixes the skb->csum updates with CHECKSUM_COMPLETE when the
> SRv6 code processes a received packet. In several places skb->csum is not
> updated correctly:
>  - ipv6_srh_rcv() updates skb->csum with the wrong sign for the new
>    Segments Left and destination address, and not at all for the Hop Limit
>    decrement.
>  - advance_nextseg() and seg6_next_csid_advance_arg() in seg6_local do
>    not update skb->csum.
>  - The End.BPF program and seg6_bpf_has_valid_srh() can change the
>    packet without updating skb->csum.
>  - In L2ENCAP and L2ENCAP_RED mode, the MAC header put back in front of
>    the frame is not added to skb->csum.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/6] seg6: fix skb checksum update helpers
    https://git.kernel.org/netdev/net-next/c/47b2998b644c
  - [net,v2,2/6] seg6: update skb checksum when ipv6_srh_rcv() decrements the Hop Limit
    https://git.kernel.org/netdev/net-next/c/47f89dfc930b
  - [net,v2,3/6] seg6: update skb checksum when SRv6 behaviors advance to the next SID
    https://git.kernel.org/netdev/net-next/c/520989b4d32a
  - [net,v2,4/6] seg6: discard CHECKSUM_COMPLETE after the End.BPF program
    https://git.kernel.org/netdev/net-next/c/53e0a84a417d
  - [net,v2,5/6] seg6: account for the MAC header in skb checksum on L2 encapsulation
    https://git.kernel.org/netdev/net-next/c/e75bae5fcf5a
  - [net,v2,6/6] selftests: seg6: add test for skb checksum with CHECKSUM_COMPLETE
    https://git.kernel.org/netdev/net-next/c/612a37673567

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


