Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517211;
	b=VqdTa2ACGHDI0bTmo90RqTNhLIzUuBoOtclx8CicqnLIdfvuSoJuth1eGMXkUDwkeoB0
	 NdzDqX+dksgMXWdEcPNdhewxSfs0cNw9QVSkpl8Qe3frEWMNkSWK5O9rETnfnE4tcFWz9
	 x/LeXOQHB40b6VP0MhL/qP+fImhTizvRiG2bM21rz2Zq5Nn9uKC0dDsVu9aRoHZI07BgN
	 fFxQpNsJpawWcrkUQj5jBZg7UU/gMEXt6L231YquapVdKIjJb6DCYMSU+HtTUmrS0EPWp
	 XeqQ/7E7ZBymM0h3J3X6ZnrmMyTD8G8Ux043oikLawN5NJYVaJpYGYwy3ZJT0S9iNgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517211;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=sklrXrgy4gzzslly6MkyHKIAYJC/dU4s74MrPp1N/Bw=;
	b=373QRRb8SAERM+k15z/GgJ5/8J0e1JBLw7RshEadIV1Q16SrYqt/zirw3YFr4OuE3wI6
	 jW7OvOeW1OblWN58IGVmiuLVJxmXwSCiu4Yx2qfqWLJmupYPAulPE00dNWjdqQi+IfsZN
	 4XcBDTQwuXLk5AdOvvlgkdz/rYsCDAEC0asVMfLdld+1dLBbErTwUdQGR8Q+59rFe53cE
	 RkTA9G9SbeJsCBwYfV6i1lvpNN1nwptlw6/+aMZU+BstGMsr32vFvrFjxGeNucHlJX+i7
	 PDX++Znz6kCabYZFG12Mtmdm/w1VKElHAwD6LJcX53AsHPyXj+QeouRFl63h/zLDKfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqlYmNBZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2AF606A31C;
	Thu, 12 Nov 2026 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqlYmNBZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08AB1F000C5;
	Thu, 12 Nov 2026 21:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794517210;
	bh=sklrXrgy4gzzslly6MkyHKIAYJC/dU4s74MrPp1N/Bw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hqlYmNBZIyhp8gIkoi2TAvA+RHDWR9sM8QIOXhJFnTdhRVyJCYm9tbS5Mvly8r8mS
	 wLP2XnVLN1yfO2KUjqQ4AKNkp/AzPMpgYe3rYWHKnQq19lWxHIZqKQqswx5xHvBNTN
	 upn9HuAKo5iua9cxNm5KjjKnLbf4NQY+cCLM3gwGXdvTVZtSdR85DpKfa5lOWphJWg
	 TpqGI5IQH1uhDjIXMsQHeTkB6L7eYuxSVMtYSvr1oqDtR+5cnhfKh+VJO3FR283XrB
	 gReojERWOUe5z7LoxWRkSNfAhCKaNekIA7H9gjMO9W7D7NYxhMwDyNnbrrvulJY2TR
	 L/oOP4yRbxjVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43C03926266;
	Thu, 12 Nov 2026 21:00:10 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v5 0/3] Normalize enum values in libbpf and
 bpftool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451720953.643214.15898220992181188429.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 21:00:09 +0000
References: <20261108025632.10799-1-dennylin0707@gmail.com>
In-Reply-To: <20261108025632.10799-1-dennylin0707@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, andrii@kernel.org, qmo@kernel.org,
 daniel@iogearbox.net, yonghong.song@linux.dev, eddyz87@gmail.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  8 Nov 2026 02:56:29 +0000 you wrote:
> This series fixes enum signedness in libbpf and bpftool data dumps
> using the shared btf_enum_value() helper suggested by Alexei. It also
> uses the helper for enum-backed map fields, where sign extension can
> change the requested map_extra value.
> 
> Ordinary enums are interpreted according to kflag. When kflag is
> clear, values are treated as unsigned, including BTF from producers
> that did not record signedness.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] libbpf: Normalize enum values according to signedness
    https://git.kernel.org/bpf/bpf-next/c/89e7a42e3030
  - [bpf-next,v5,2/3] bpftool: Preserve unsigned enum values in data dumps
    https://git.kernel.org/bpf/bpf-next/c/0296813e0c59
  - [bpf-next,v5,3/3] selftests/bpf: Cover enum signedness in data dumps and map fields
    https://git.kernel.org/bpf/bpf-next/c/881dbe78cc98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


