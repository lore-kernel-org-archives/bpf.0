Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641006;
	b=2De4KX4O5W7O45C85aq4k6j5fbo5RIBo8O2lJ1S/kxRBSmGLRywmEYiHaJ3eZ0fKKcvS
	 KDgNt/pqwblJmREbIhIc9NtY0Sb56/c6wsBsHP4dQcPokD31ZQpnC1Y7Nx5IrZV/dp3Ob
	 ZiVgIZjCp0lFv7Apmwmy7LwPHMVAYpZCSciW38ZWzHkwyhotvsRmxedw0JmvBs5EcA4rO
	 V+1RzxW46tcEYmoib0tA32MtE5WVEZ+43TGzuqoeFdR6wVxeBHQymNVW09r1HLODrkcVG
	 IWYxyFmgnJQo4mvVSqjYzwfqaxLZULtSsxhJNJKzz+YKkoGU5tG0ID8a0/Z1uSLND0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=0X+rPPzIV5Pr2fJzolLCtfXji43CwXE71dJfT6bgs/0=;
	b=4yfHQ6y3OvuB8t5+OaDKAScNEEoqx2KDklNYWOnFIU770BbcWa+EVmfxmYKUSH8QESsn
	 4bDe2kdlYGohJ0JHRac9LBADEVzODoR3s/Mg6iImeycHdFu3xSIbfv0tFRCx2Tnv3cwsQ
	 c9sJuR8iNdGm7ycc4PCN/26+7sbez3mWOzqdtT9zC6zeMLDRbe+iifXEr6v6zeIGwiDbF
	 SGNASgRnbYKsrOZXpiHykvOpi+T8vD0H8rHNE7CSrrrYHA4e7GMZPUiEXbTKm7KyLTT60
	 lc1AwXvMzws3jE9Sf740PyJ3q3CPDOxL45bOpdRbJHAOucnAMYI7dBuHo68V+qmlj/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FF/YMzfU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BCA606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FF/YMzfU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7E41F000C0;
	Wed, 25 Nov 2026 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795641005;
	bh=0X+rPPzIV5Pr2fJzolLCtfXji43CwXE71dJfT6bgs/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FF/YMzfUwvTSoLWOD6fK2mULsJHNn7EPar6CXQhPho1pyD9uiBQ7NKbTJpOoIs/PC
	 P0WEXSwdmXfclzO1o81buRDmqjWKKzCFD/zFoR28TXZck2OqNLu03x1cLkUU5yHP1g
	 XKyI/qbYBVyYC/PaRHj6+PUCcS871H3gkMYgOF1OArehvKvOKLAcaEnWU+fsklBPRj
	 Hn65rXG2aISKATiPyqcCsuD7Oa8ef9/vWuSNw+/6rcTSu5C5rEw3Z/u2vsIX0jcHUs
	 W5WcBLuDFvDKvx5oD6URMTSFWfy6wSRwjkkxE42Rv4fIHUUgfDgEuI72j/d5YKe7jN
	 ijpWYxa18rolw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43EC3809A13;
	Wed, 25 Nov 2026 21:10:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] libbpf: Fix dumping enum bitfields on big-endian
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179564100453.1335727.1432980211567527079.git-patchwork-notify@kernel.org>
Date: Wed, 25 Nov 2026 21:10:04 +0000
References: <20261125081245.74091-1-dennylin0707@gmail.com>
In-Reply-To: <20261125081245.74091-1-dennylin0707@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 alan.maguire@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 25 Nov 2026 08:12:45 +0000 you wrote:
> btf_dump_dump_type_data() reads an enum bitfield into the __s64
> enum_val and passes &enum_val to btf_dump_enum_data(), where
> btf_dump_get_enum_value() loads t->size bytes from that address. For
> enums smaller than 8 bytes, those are the high-order bytes of enum_val
> on big-endian, so every enum bitfield is dumped with value 0.
> 
> Pass the address of the low-order t->size bytes of enum_val instead,
> so the value is loaded the same way on both byte orders.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Fix dumping enum bitfields on big-endian
    https://git.kernel.org/bpf/bpf-next/c/3cbbebf6819b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


