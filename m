Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4E3F8ED9;
	Fri,  5 Jun 2026 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780700418; cv=none; b=X84SU4NrG7aa0IsTDD7qdnWN7AMKG9kAdwzmNu8gpVoQpbEFbKPwz6qmKkbAZihLGIOkoXBSAuXsUONYOiZeh7euKkvI+muWjRZ8GPN+Onyg/OUG5nxaC32m0TiIqb1BnxckDZ/5Qkz2i89dxN/cKwlG0v/t+Pjavsuy+lr2qB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780700418; c=relaxed/simple;
	bh=QLYfXsmNCstj3XIEyZ+Fht5orVC47MuJZnldFIkA24U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hPVoIZJP9vA1ihVusTiBkCFUCyHJ2qcpMYvNBFdnaGTU1nU8jjBR6R26d7eiGGV0tvHRSAYYg0nV4Gn+qksGkvjTFnqg9mC0MbKtPAeKwg4Ww2jHj/EHqoUzXh+IVaFrJc5wHKPjjeY3hxLD6yLslID8c/VQLl79Lg7yvkuKwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha/GyXdh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha/GyXdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59151F00893;
	Fri,  5 Jun 2026 23:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780700416;
	bh=DXAdv1fmQNXGBei06xrbhWf7wxGPq6Utlm+kuyECDPk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ha/GyXdhQAjBNiIDO9dCqBC9cucqsr6CVyznbBdCoa3Tz18Cm2tcAzAVMcbKEzhDz
	 8ViIq2UkxE/q0/oFdIiEtmoHeQjUl1qBupzoYHDiCWr9Bq8ScJXit7iEucbpiaB3oK
	 PojAXP9FXRpVm/3vUxkHoHlZwcuX0z6pcEjgAVqPISPvcYM/lmp0/o6uyzOEH1Onsv
	 ctbhcIbI8/ncSB+6qLZ4o6FrN9z3/xfQ/NV2tsIXwGOKGujPrMQzEN+kSXe/eIMfru
	 qHEp3wyO95tijP3RhMXsYxTcekmiAYNmMuwJ+kgsCg1g3DiltM1z1xk1jjjtxk7gg/
	 IuVR+oOsTxDnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A463930C04;
	Fri,  5 Jun 2026 23:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] Add validation for bpf_set_retval helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178070041689.3950549.14630927515894773480.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 23:00:16 +0000
References: <20260605140243.664590-1-xukuohai@huaweicloud.com>
In-Reply-To: <20260605140243.664590-1-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, yonghong.song@linux.dev,
 sdf@fomichev.me, zhuyifei@google.com, mattbobrowski@google.com,
 2022090917019@std.uestc.edu.cn

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Jun 2026 14:02:40 +0000 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> The bpf_set_retval() helper is used by cgroup BPF programs to set the
> return value of the kernel hook. The argument type for this helper is
> ARG_ANYTHING. This allows setting a positive value, which no cgroup
> hook expects and can cause issues, such as the kernel panic reported
> in [1].
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] selftests/bpf: Restrict bpf_set_retval argument in sk_bypass_prot_mem
    https://git.kernel.org/bpf/bpf-next/c/6fa2839893e3
  - [bpf-next,v5,2/3] bpf: Add validation for bpf_set_retval argument
    https://git.kernel.org/bpf/bpf-next/c/b1f7f67b74c2
  - [bpf-next,v5,3/3] selftests/bpf: Add tests for bpf_set_retval validation
    https://git.kernel.org/bpf/bpf-next/c/7913cdb54ee3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


