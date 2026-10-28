Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161206;
	b=H7rUn+2D/jhY78Wsuc3K0cC2VQBAR+7KNWaocI3xz1b/5443Lw3qjaCiqPzEBcxNmGIp
	 VqjvYABQvqZfCO8t3qJiyXMf4PwXCSetQ4//ePnw86FP3ImrJQlE5azQszjW2dI+1ee/S
	 F59br+6grq02YIMGR3i7W+T7xxvNkdqgQoBzXSsnIntTPtN2GnTU7JUsv6aPcdfq5R4r8
	 YJbZHlcxNXyFvmbXNR+a6L1y9rhCEKnEQccRgRTjEsPcGr3Nuefxh/r+u//6dkfeqzi36
	 wu1S8vDWq5zB5VliUaieJrZIIi43WuFtclnpSi6dBAH0mf9o0MQ0+v0y85BNyW0hZOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=wdKgPsfLA04BUS/6f97Cbi9qRaXsMUvNAiHGuCj5FI0=;
	b=5JdGgLuKwnEDvOYJ48QPCy+8V95LH23CMsyaXxmHiqOFuokYwBvhuqtbZekMhYrPNQYh
	 azCfHCvagBpNsMovN4iWqeMYT3ff96i9Bzo+VD07YvBlPaQOWnIYR5+TQidehi7+j5K5N
	 EgldQP4kzsd8wWDHIJsJhgdSNKYPQByiXaw+mtrXhjYsAguSMqioA+fVQ8HrQUBFjjbMf
	 Lfqv5c5DHrF1V3IWVRUDqy/M2Jie3eeC4yJuxrZolTElggNVjxDo+w7uiw34mQHHXUMp+
	 R7GQrXNMbtKt7KFffDY8RCyWJOaL0syL+T2oxM6kh9BOecKNTyKfk+cwuBD+67T2q+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qrm40DyC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60FC606A31D;
	Wed, 28 Oct 2026 04:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qrm40DyC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC521F01825;
	Wed, 28 Oct 2026 04:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793161205;
	bh=wdKgPsfLA04BUS/6f97Cbi9qRaXsMUvNAiHGuCj5FI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Qrm40DyCkmj4Wg76+Kee1SsT85Ok0z68WIfNSVdziwBMutfIuHn7RJq9+TLkeQHMq
	 cvXSwW3f+D56lqxGLDiwiJmq7uQ0GYe5ZFbckgwnG/eKqfyQnd604oqN5ryKmyd/5y
	 n1dUPJtVBDzT3FGDz1eU9pKBbFOEKXjX02hC40FHbiT24e11HIYmk5wcxLtIT1m2qD
	 T8k60KyQXvRD+V75q1IRoExQ2mMROZSTX1RLNw9ebto0CvlJHr07ZBFWLqBR1vuS/Z
	 jDxlePufSL8TGT5Q39eFvgDLFZkz4zU3UCh/iW+XP1fD1FXDAjVIcFdCfPfcVeKnY9
	 oXuXXuDLCikzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 444D53AA9F69;
	Wed, 28 Oct 2026 04:20:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf v3] bpf: Fix out-of-bounds btf->types write for split
 BTF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179316120408.492302.2700817371467142410.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 04:20:04 +0000
References: <20261028031933.277550-1-yangfeng59949@163.com>
In-Reply-To: <20261028031933.277550-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 28 Oct 2026 11:19:33 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> btf_add_type() stores the types of a BTF in btf->types[], which can hold at
> most BTF_MAX_TYPE entries.  The types of a split BTF get IDs start_id ..
> start_id + nr_types - 1, so only BTF_MAX_TYPE - start_id of them fit, but
> neither the limit check nor the size used to grow the array accounts for
> start_id: the check is an equality test against BTF_MAX_TYPE
> ('start_id + btf->types_size == BTF_MAX_TYPE') and the new size is clamped
> to BTF_MAX_TYPE.
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf: Fix out-of-bounds btf->types write for split BTF
    https://git.kernel.org/bpf/bpf/c/6c476d2b7305

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


