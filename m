Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2C37189B;
	Wed, 11 Mar 2026 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247214; cv=none; b=D1CT2SdusnNzXhVVZ/42INOLMfgJhy/ubj4yQxXL6c1dVy4otULUd7U+aImzVFgbwfK/qhDBwrbaz1GwW566lHc5snnTLq3rH+OirrdxWMC9A1r9ZxTQnBeUK+jiN7ovoNuKkQSsGMOt1Cye16DYZ6ZB/NZpv6g2V1W/aFzJtGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247214; c=relaxed/simple;
	bh=+JE5L+xvjhi3Jlb8VJlMA4JbNpsHgjnPtFV9mdr/h64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fK2Xa/lz1XFyVE4Sj6lXFCtpql+EWqxtNiTuP+Ga8r7Tfr3mbPOhvz9vhdIxA5q5wjt9Hs1kZvXTS+1tv6ktTy8V0LPmDR2p2/ExhSkA/36O7HXRkVC3CeNI23bSjnxbakSam4wyS5/ibY9KqcwHtlTsBuirmQls8I4FFGUbuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ddn/o5XZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ddn/o5XZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADF0C4CEF7;
	Wed, 11 Mar 2026 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773247214;
	bh=+JE5L+xvjhi3Jlb8VJlMA4JbNpsHgjnPtFV9mdr/h64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ddn/o5XZ4XvZtUS1H/70hTLllJ8ZWrzwhO0GAz7ANLgG6mDzia4F1U331WrHD0FEP
	 Q21ratCyb58vZD74W7M2BrpgROkdqOjyzODyHGWQjZlR7Z5uLHEBB9CPdDjTOn+t7v
	 qvPGgc5GRIaRKBBkhIubfwK2N/fCvN/zgMgY94OovzvIYY2Og97K1w+Jilm9ozciJP
	 muRmxqzlv6gt0NcXjd6aUoBk5eF7cBZb1yUVWiJ5gh3aEwCMA+80hnVJ/igCQbkGVz
	 0U9brA7wPsWYi7zhVgzHm4jwpa9oyNXv8UduP1v0cwZtQDqhrtdVCy53z6FrD1JzUF
	 mxPJvnYBq8XmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE793808200;
	Wed, 11 Mar 2026 16:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] selftests/bpf: filter by pid to avoid cross-test
 interference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177324720981.3744293.13534304462989539724.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 16:40:09 +0000
References: <20260306083330.518627-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260306083330.518627-1-sun.jian.kdev@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: andrii@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  6 Mar 2026 16:33:29 +0800 you wrote:
> The test installs a kprobe on __sys_connect and checks that
> bpf_probe_write_user() can modify the syscall argument. However, any
> concurrent thread in any other test that calls connect() will also
> trigger the kprobe and have its sockaddr silently overwritten, causing
> flaky failures in unrelated tests.
> 
> Constrain the hook to the current test process by filtering on a PID
> stored as a global variable in .bss. Initialize the .bss value from
> user space before bpf_object__load() using bpf_map__set_initial_value(),
> and validate the bss map value size to catch layout mismatches.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] selftests/bpf: filter by pid to avoid cross-test interference
    https://git.kernel.org/bpf/bpf-next/c/70ce840d5f5b
  - [v3,2/2] selftests/bpf: drop serial restriction
    https://git.kernel.org/bpf/bpf-next/c/aa181c7d642c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


