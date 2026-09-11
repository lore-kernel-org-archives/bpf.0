Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CA3382CB;
	Fri, 11 Sep 2026 00:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084874; cv=none; b=SGR7mGS+MUcrMMxvY23dEBsKxQNmng0NwK8rf/ILUZ/xeNJtENHPOy4e5W2ZbURkeDAZ6kjnkWYEzO45+CVAoKzY/S7vRmjCiM9FYAmaXbY4Fwk3TnBzLG2LEsfFsu+jMRuekSie6OzUa0d/yD3/hnBAWwyRvscpSX8WlkjHxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084874; c=relaxed/simple;
	bh=eFLAmPlcGgKPyjz9uvFDSIaHO1xs7IwtXR+2PHfMW0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uoqYfwV1ouqDuoMpv/y5VFUR54rvEQp2bSePSIzh3cIgp2baMi4Z4+YZ4BgcyMeYN8F+TTh/xMlF5HGUb1zCQ1llPz/VXBAAx3s4t7PMeWtY9JwUKiZHS09Q/f5aX94eKK9At2tvjIB0iIjp35Vm4SGtTzPq+me57n1iScrexQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5DEqvez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5DEqvez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7A71F00893;
	Fri, 11 Sep 2026 00:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084872;
	bh=AF1XfCZiT+Uy9WDz3B7HuGsf5wj8U3H0iIdpVu5EoqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O5DEqvezqU2AeVDQmvgkY/VwHuTySMIK3dpDUkJiQfANA4ZkK68p5NfAVzOzSUckL
	 50c8RGBAxeXXXGc6DrdYj1L7HS/C2LzV8zB0GmuZP0ll4jaZeyDfCsrw8acMCN6bZr
	 7iBbvR2KPssdKdHQK5nuzioFlEw5fWUK9ywVl4abc4ICp7OcpsR/y5HyCO1KyOdJkP
	 Uu6d+QxFAEL/w+DALddDH00SnnHXL5tNHnUKDdjr7jKwghxf8XlulFB0VTTeKmkKlO
	 tGj45vk3PZcG6K01c1+cvKfdaKDiwPA12UjSj+a1FJ3lIwKhkt21ycpqnR5kvtV8PW
	 sYPqHMNrQtbtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A4E3810901;
	Fri, 11 Sep 2026 00:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Fix divide-by-zero in btf_struct_walk()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178908480962.2150752.388092598358086228.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 00:00:09 +0000
References: <20260910122316.186384-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260910122316.186384-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 ameryhung@gmail.com, tj@kernel.org, mattbobrowski@google.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Sep 2026 20:22:55 +0800 you wrote:
> When an access goes past the struct and the last member is a flexible
> array, btf_struct_walk() folds the offset back into a single element with
> (off - moff) % t->size, but never checks that the element type has a size.
> 
> BTF takes an empty struct, so this in program BTF
> 
> 	/* event could be empty */
> 	struct event {
>  #ifdef HAVE_TIMESTAMP
> 		__u64 ts;
>  #endif
> 	};
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Fix divide-by-zero in btf_struct_walk()
    https://git.kernel.org/bpf/bpf/c/b0b3dc665296
  - [bpf,2/2] selftests/bpf: Test BTF walk into a flexible array of zero-sized elements
    https://git.kernel.org/bpf/bpf/c/f77d21245710

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


