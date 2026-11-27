Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795822808;
	b=CGyjhd6VGjOYpdjZo0G8AwHhN4niwTJ7IP+WOTlBVR3wUH9j3U8jZ7Nj3S38XNVzDRZC
	 bq4Xeb2VDv15Ckk6rKbKrr2Wm98w2BYN2nmrl+oWUkfK0LlqVxDaYDoZz43i67btdJbcm
	 KrTnxM+nO91TYlVnGHPYREO70xGiy5f7rIj/u5bfUq+MoWHSuElGTfIo4qymhxusI1Ych
	 bsfMuQTqw8UDyHt9OUWc8aKnsNsOi/dyJh/AIlZt/gXgrsimC15VHzYUTgjoVTw3nKjar
	 bud2m8+HkVI0Tb18DTBs947LJ0lsdslx3Fvdiz/oaEhwcXktKK05/nJfpFVo+Utgakw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795822808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Fo12o+uIQqF1uYYvqYc1dxJIvtGt4oQoEvFL3ArBouM=;
	b=1oR7fUfP+woVdiIHSDMA4GgwZi9PS/vpLwR/F3w5/6CmQLnetd7TQj8Dnmo+ZiKXOdpV
	 tyo1ceuW1+7UXZDMT1QTdDA8Iw6h5hejA58iNQG/BoIDRNf1O4okDVUdDlDiILKaamcEs
	 FrmK5N2eD/jBxtvXx8YoeohHu6G/azi0Mh7UP10ydrwC840ENaHkxwMf//PmP3F2Q3b9+
	 /4wAoZnxM9GNMtLbDULaPXEi4Fs8aqmoKtQIyAWVcvAbyBigIsp9boiEvsmPMgmslNVqo
	 eb5OhHE/UajgtF8yH1IsdnmjWVViM5Tmelp1qXoxuNCM8WSg6oG8pbUu+A8+yEfFnUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4QPhqrD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1735D606A31C;
	Fri, 27 Nov 2026 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4QPhqrD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5441F00897;
	Fri, 27 Nov 2026 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795822807;
	bh=Fo12o+uIQqF1uYYvqYc1dxJIvtGt4oQoEvFL3ArBouM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S4QPhqrDhQt+2s51pN3bsdyfTxJiZounSsIcqCBTw2SZJrUUaiF8F0o9mXgCQacRC
	 UvxfU1MI33/jVyKvNv3QFcRe0tjcC4nNGFpmSQSjnSXHNIpzCeJ9Je9ZXR7StemSwy
	 Lolf7Incm27oVr2YozZghwxWpPK9IafphGruigqZ/SfopXY8fC51N6H3eJNKJf6SyJ
	 eAxt0/Kny2O+OoaNQnjVWKyQMqNnExOPOSx6gEcVG1AlDEWedK4QliBpvokMGHAYIl
	 k/pUH/BauaVcWLdEgX4aUdSO5GqL9H5dz6V7eZHtzLfIX1/EWS5UiX6eBKml4uBVIE
	 Mn/XUa0KbnALw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2120F3927068;
	Fri, 27 Nov 2026 23:40:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Fix 8-byte alignment of map values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179582280600.1728472.1333720099674873788.git-patchwork-notify@kernel.org>
Date: Fri, 27 Nov 2026 23:40:06 +0000
References: <20261126194347.42466-1-tphilipp@gmail.com>
In-Reply-To: <20261126194347.42466-1-tphilipp@gmail.com>
To: Tobias Philipp <tphilipp@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, hawk@kernel.org, davem@davemloft.net,
 kuba@kernel.org, shuah@kernel.org, nbd@nbd.name, hacks@slashdirt.org,
 stijn@linux-ipv6.be, daniel@zonque.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 26 Nov 2026 20:43:43 +0100 you wrote:
> The verifier checks the alignment of BPF_DW atomics and 64-bit
> load-acquire/store-release on PTR_TO_MAP_VALUE only against the offset
> within the value. It assumes that the value itself is 8-byte aligned.
> That does not hold for all map types. Address of the value mod 8, as
> measured on bpf-next (see Testing below):
> 
>                                     64-bit    32-bit
>   lpm_trie, key_size 8 (IPv4)          4         0 (by accident)
>   lpm_trie, key_size 20 (IPv6)         0         4
>   hash, rhash (BPF_F_NO_PREALLOC)      0         4
>   devmap, devmap_hash                  4         4 (harmless, see patch 3)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] bpf: Fix alignment of memory allocator objects on 32-bit archs
    https://git.kernel.org/bpf/bpf-next/c/41fb3a63e447
  - [bpf-next,v3,2/4] bpf: Align lpm_trie map values to 8 bytes
    https://git.kernel.org/bpf/bpf-next/c/6856b42055e0
  - [bpf-next,v3,3/4] bpf: Align devmap values to 8 bytes
    https://git.kernel.org/bpf/bpf-next/c/7846bd82a424
  - [bpf-next,v3,4/4] selftests/bpf: Check that map values are 8-byte aligned
    https://git.kernel.org/bpf/bpf-next/c/63c1713b2a00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


