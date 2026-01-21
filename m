Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8D369228
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017815; cv=none; b=TMBP6q6xNgMsn23A8GrfkwxyvxDMtIrsU1XcVjlLLHb3QodBp6dGZCbWnZsrKAD91CWWLdaw0YjpXLIG7N/EZ7JzqmIWfNey8SqsgSDKt8eOjZJ4ZqJDOOfUDxgw5IZIxKCDOM+uoHy2rA7ORRkJ6piPf96OvnvdJOhgQJoCqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017815; c=relaxed/simple;
	bh=0KWAWmh05PAblOCKxKez8sOa6DfdHDK2uasGy5/Qp7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lBdQqK8Z87L5fg2yhcP6AoKgOEFfh0Xuvi/4tbBvALE8RfPbFoLNXo7YJva2kZdlUDWZMC4JqiEfU7OVQEtVFLFkZptfM+fo90HiZXUbblkXaRDEYrmjXVn/t79zAK68JAbkegdINpP3HzT4xAHXmVc6wzhKuLJxpeXPJexc9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAm2q7fX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAm2q7fX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9082CC4CEF1;
	Wed, 21 Jan 2026 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769017814;
	bh=0KWAWmh05PAblOCKxKez8sOa6DfdHDK2uasGy5/Qp7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vAm2q7fXHjheDd7MiYeh/cGbF9mnTyW9o8efy374cp1xGxjzosE9/33UqJrqRZ1Fb
	 zX4nDmY7o0TUrtnovxDK4ly2ucH3I3yMircGFjdQ6rwko4bQTqYCXrPg+uRgTCdilC
	 dBx+Hn8zhqBAz5rYLiUmPYS+C+tKffEljkjS9hovQTupxBFpUEgyvF3mswAqu8EBLZ
	 wdNFkqHbWWjr+8H2d30Ivw7QYuFS6kZ3I8k3cXwpK/mGAHRnZtO3cRjIpyxldD+Zlz
	 yyXFAzmgvgScBSiH3his8qopXYXPQEI/0o57usQgR3s1oTsyJw/TfrHcQdRKt6jFyU
	 gwMU+c+U0aXKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D813808200;
	Wed, 21 Jan 2026 17:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] bpf: Add kfunc bpf_strncasecmp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176901781134.1390629.9577843919789689169.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 17:50:11 +0000
References: <20260121033328.1850010-1-ishiyama@hpc.is.uec.ac.jp>
In-Reply-To: <20260121033328.1850010-1-ishiyama@hpc.is.uec.ac.jp>
To: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Cc: bpf@vger.kernel.org, mykyta.yatsenko5@gmail.com, vmalik@redhat.com,
 andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 21 Jan 2026 12:33:26 +0900 you wrote:
> This patchset introduces bpf_strncasecmp to allow case-insensitive and
> limited-length string comparison. This is useful for parsing protocol
> headers like HTTP.
> 
> ---
> 
> Changes in v5:
> - Fixed the test function numbering
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: add bpf_strncasecmp kfunc
    https://git.kernel.org/bpf/bpf-next/c/1dc669646762
  - [bpf-next,v5,2/2] selftests/bpf: Test kfunc bpf_strncasecmp
    https://git.kernel.org/bpf/bpf-next/c/f4924ad0b13f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


