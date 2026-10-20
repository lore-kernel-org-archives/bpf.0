Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455614;
	b=XKFHmI2sarSpdp4XHRDOPQT3je5ZDKST/jbpIBcOtV0esLGNRSsvj+ALNEXhIB0a3Wiu
	 5rEVwXf9ayvgntjF+8wcwRoduwtb8+vZtANh8Z8glTmgtzafeXJ6QXz5pIGKsYKxPXgFa
	 gOqatn2SpyVkWOll+a5A626m3fW5zE0tgS+i1tVSA03kZGUon/ngbH7IoosWwRyYyVfhK
	 fC+NAnVtTSW453c1zZHhQq3Z0RM/5NATiRxVq6yRPnZv/r4XTWCrYPcZ8GjMBqmqpiRUy
	 73dv3b2LlE+fDJt/0oOGvK956afs4Mw6ag7rJlgcLuBUrJ7mXSvhqKrOZz1VlDqgN9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455614;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ONb7M4Z1krQDJYrEDFDCGMsIbX7sVKAOosBEwY/fgdM=;
	b=rWsnnz9QlkyI99xYB46yvEY8SHw+K0NrW3fCj73LRGKd2lKBhgDf2I72lbyBSMBAH9NH
	 kXNiKpf5OfMvzDjiJMd5tGRi4IKMzByUksIzzID8VmdtFOoBT7bXJKNjoZ2mt8uQABJ70
	 IdvvDlbFFpbjHvRy5D7Doa9mCG5AvgPEwjTVcm3GcyA/pEweTSD85kAfSplvFIapeu2Bi
	 37rybUnNIDNBN+vQ9qs84rg8JP7GKEeati+pRaR9mPYXxyo1ifJ6ndD7DPoSMneNMFoK9
	 Fxlt3H9XCbZLX6YLldZXGeHSydCZQbPlr1f7kW5F/dC8FRF4vMoCsW812j6B0zcMjdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGAYNWE5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885CF606A31E
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGAYNWE5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E471F000C7;
	Tue, 20 Oct 2026 00:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792455614;
	bh=ONb7M4Z1krQDJYrEDFDCGMsIbX7sVKAOosBEwY/fgdM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EGAYNWE548ncDNIzgYZ9WVhXQgm84Ygl0mskkmDcGyeT9CHl0+LTYtkPuhc28PbGT
	 NGHANT613QlQksni/jpuJbMrEblxumrrjnknzYqnILVP3WBq/zP2qGMCASa1ooqlMJ
	 5dFi2f/fIiunO6LnoKkeVMtvTEoreKSkyi8PCkgJBAY0AbUef1xtfepwM3DcJQn7cM
	 Dz8tIMv528YZsRyolkrLZbOHI2+aq5WR3tfGS189fx3PvU2sYAiGt82mwjKmkxDz73
	 gcXlIjHuKPZiOPhD9sfNegkpJ2yNPNM0RahztA6iisjzA2w45I37F2A/jVe+ZRY25h
	 T+h5M2kGpgc6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A27E3924A6F;
	Tue, 20 Oct 2026 00:20:14 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v1 0/2] Refuse CO-RE relocations for a signed
 program
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179245561288.3398635.2450235758617290792.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 00:20:12 +0000
References: <20261019144851.4052056-1-memxor@gmail.com>
In-Reply-To: <20261019144851.4052056-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 19 Oct 2026 16:48:48 +0200 you wrote:
> The signature of a BPF program is checked over the insns as submitted,
> but the loader may also hand in CO-RE relocation records, which the
> kernel applies to those insns afterwards with values the loader picks
> through its BTF. Whoever holds a signed program can so change its
> constants once the signature has passed. Refuse relocations on a signed
> load, before the signature is examined, and test it.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: Refuse CO-RE relocations for a signed program
    https://git.kernel.org/bpf/bpf-next/c/19a17b5b2b01
  - [bpf-next,v1,2/2] selftests/bpf: Test that a signed program with CO-RE relocations is refused
    https://git.kernel.org/bpf/bpf-next/c/25a2e54999b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


