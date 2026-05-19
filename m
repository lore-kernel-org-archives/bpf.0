Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA0B22257E;
	Tue, 19 May 2026 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156000; cv=none; b=aa9tey61sMUp6pwf4G60Jce2AgzCzfO4mtCyLTHtHrd7yzZ0rAFQ6JwDM4KBC+HfcmFr1R0ftenNRWzNnnt1mMByQ4zwXe7yQg3VPcsbEHtef3Xt5peYC0q3IJeLDdbD6SSGEPXP1kTngnC+zcc6PZ0gZWDBBMG4hhspOzKlAZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156000; c=relaxed/simple;
	bh=phleI6/ka1+FjNCWKTzcypNBqM4Qg2k6zm+Z3vu73i0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JC9XQFQWEiexTYRZEf+SGTUuTGyamvcopHIx+/bytWwvPJIicJ5Kx9OVMjpj7xN3OQyzSrH4QbYKNHV4NOrXrCGknTKbtWy8k+J+NUS5Ixkz7wMjEbjZkUJ/RuyvOOstS8DcGqY35SpsWqm0reJ5QDR3YWTHsChXzrURPzLSg3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxRS3RyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxRS3RyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CB7C2BCB7;
	Tue, 19 May 2026 01:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779155999;
	bh=phleI6/ka1+FjNCWKTzcypNBqM4Qg2k6zm+Z3vu73i0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZxRS3RyYGF/HRmCegR9zRfnn0iNUdztV4CyJIDj2SR97mrnRQNwi3oOO5anPQf+6S
	 oBfMQu394u79pDtBA/lf+y6OCCVny3cJ8gp2RDzytJYfjBlg1s5JblyJw7JjKknTGu
	 V/tuxPYfF5J9Br8BaEoEJ9r3KE/1xkN2vNRLe/WtRR+nmyaXXT3RaVEzleVgwI7ThB
	 U0BMj09dPuGnpvVGWVFY7Ab6syC956ieQuXvMSCkg0a+d5afJOKVv0n3JfpdJYFYS4
	 pPOIk1JVi0e5/31UeusjrPXhdlp5ESAxFN74zgq5G5ZGZQtxJvGQNNqlxCBziMbKj8
	 o7WZP6lXLo5Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198A73930D10;
	Tue, 19 May 2026 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/5] bpf: Follow-up fixes for BPF syscall common
 attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177915601064.2051001.3397704272305322988.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 02:00:10 +0000
References: <20260518145446.6794-1-leon.hwang@linux.dev>
In-Reply-To: <20260518145446.6794-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 18 May 2026 22:54:41 +0800 you wrote:
> Address sashiko reviews for BPF syscall common attributes series.
> 
> 1. The tailing padding bytes in struct bpf_common_attr should be
>    checked. [1]
> 2. There was a concurrent regression in syscall.c::map_create(). [2]
> 3. OPTS_VALID() was missing to validate the nested struct bpf_log_opts
>    in libbpf. [3]
> 4. The token_fd should be -1 to avoid a valid token fd in test. [4]
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/5] bpf: Check tail zero of bpf_common_attr using offsetofend
    https://git.kernel.org/bpf/bpf-next/c/f05ddc6771c4
  - [bpf-next,2/5] bpf: Fix concurrent regression in map_create()
    (no matching commit)
  - [bpf-next,3/5] libbpf: Add OPTS_VALID() for log_opts in bpf_map_create
    https://git.kernel.org/bpf/bpf-next/c/b4844cb6d1ec
  - [bpf-next,4/5] selftests/bpf: Use -1 as token_fd in map create failure test
    https://git.kernel.org/bpf/bpf-next/c/652f0c2c999d
  - [bpf-next,5/5] selftests/bpf: Add test to verify checking padding bytes for BPF syscall common attributes
    https://git.kernel.org/bpf/bpf-next/c/7732ad2412fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


