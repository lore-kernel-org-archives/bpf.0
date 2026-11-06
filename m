Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005411;
	b=yL+hcBTnTYaK20+TWR2ruDSJ74MTgS19C0cuUfn+TH4z3ucac6uAbsdbkvpfDdG9UoK+
	 fHvnRTu0p7+EvHux+p07EqP4VEMoXHmtHOXBUvXznZHnQZNhZZbVzjbmZtEDXK1FVOznb
	 CXHSL9DTRvu3a2TJFSECAAWvwxT1WooSV4G5IpdhN/FkNSIZzLa9GZk5Ym2L3Cl99rxJg
	 +ylhJjIAH/BLw+8Sa+KoiAqKeiKbqv33P+LoeU06tz7IhkXp6cR/Ti4Jo+Eiaq0XllWWN
	 XG9FFd2F7nFhaz8Us5wDtPVhF9t7oz8YjqNv/LZkloEZd/BKxvVdzhYANlwJpNctykw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=yjIkLHTE6zm8xxbw2Bckbdu3f+EsG+gHBYzTg0WRdpY=;
	b=ts6xj+WrpE4M5MSHdmMIKVc0lo4ar7YyRKbX39jh0yB5iBmoq5ZXPnvlD+azrncnv9LX
	 MHzSXigxTapF2HLklMHbePXkgTcFEgDPvEgKIAe8kQC9J7ikO7Aq6O/uiYPGbGhyhRVu3
	 9NGB+TI6hffekhYxr5mk14nCGwaDk4LvYiH0zr1qsvCsArJslLKj543wxc3k3KhTtr5to
	 q0rtqkINmaITSlfo8VDKpVcZkqs/FMNB2BW2M3+Cu51EXn9qV1x1eXav3ZYzVp7S7XzxX
	 x3VO5/qJGFfvbj34hJx8LR5wVbNMN+MJyjK9QELAakDaj2CzDUq9gx6BeIpFAClNgoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnnZKtOZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A6606D808;
	Fri,  6 Nov 2026 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnnZKtOZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5081F008A3;
	Fri,  6 Nov 2026 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794005411;
	bh=yjIkLHTE6zm8xxbw2Bckbdu3f+EsG+gHBYzTg0WRdpY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JnnZKtOZa3/cfMh3iYVX2tVx7OSygnq/Nhp2l+r+pWabLmQa2Y/or1MT3oJVSC4Ro
	 shWimEUReWgSm0dOQhUgYd13ajHakbdMV47aYDArGgLjwhkTqGc+hcxNxGEul5EPMT
	 D33xC6SpuWjLZdeJ/hQ8GKisZLWpdxs7pj4LleHSXAOnxv16tBCz3LGskmcJTgrdhL
	 kIA0KwSI6/aKJm6W00iyOUsg3WPXFsCY3Q5qpnPZ0SS3zejLasxuPpDWMnvr+Xdb1G
	 1zaCUZTg11IHUgn1HyYhE6g+HdYktNj5eFUCp9cm3yqHX4IxGNQkHAVzcRuLoID+3O
	 +sGF866hkRxrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2100C3A55EC2;
	Fri,  6 Nov 2026 22:50:11 +0000 (UTC)
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
Subject: Re: [PATCH net] ipv6: Check the Home Address option again before its
 address is used
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179400540967.914342.6623391724463766435.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 22:50:09 +0000
References: <20261102064922.2636027-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102064922.2636027-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Nov 2026 06:49:22 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> ipv6_dest_hao() checks the Home Address option and sets IP6CB(skb)->dsthao
> to the offset of the destination options header. Later mip6_addr_swap() and
> mip6_destopt_reject() call ipv6_find_tlv() with that offset and use the 16
> address bytes. They assume that the same header is still there.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: Check the Home Address option again before its address is used
    https://git.kernel.org/netdev/net/c/30c71476d842

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


