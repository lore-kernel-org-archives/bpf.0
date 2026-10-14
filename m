Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D944AC161
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015807; cv=none; b=qQOa2KhRT27b3Wr15S7zm0EjHQ0UxfUEVBXiAkGlDiCC//CAKPh1sfFJrzfdULdqUllIuhpSsDN/4ViSK09SBkWElUlNohW5XrC1f6P3tvVQMCixzX+q1o+Vi7uUSTaja15HBRPjbR3Fv2B9jvgllkokrH4eLPAUPxZXjEmim8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015807; c=relaxed/simple;
	bh=bLHnQSfkgy+jejOuas+QeWYLZ5Fm9Ds+4Bqs2h9VYX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m3uHvwg9WGzwEl1CL7xKe8ia9FFx+ljyh9tVOwDsWTogfZRloEVRT7s9OcYrkmw3lDZo/1UDk5sJ8J8ooIMhh8pnOvZLMM0OG75/+Mbdu8/9SjajzHaXSy83lYKQI3LK0d3NOAIGujxIULlY6wlqpAUeZY2b20xjTiWiJkBaJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R88Xgm8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R88Xgm8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448F21F000C4;
	Wed, 14 Oct 2026 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792015805;
	bh=QOhnhPjyYJBPpZn9elVDkm7u7EAMzFKdM3yfybmvY6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R88Xgm8cvrrD3aaTSGKKow3rwW0hSLNJuLJ3sr+octr3KRYVfI855b5zpOPoUJNRf
	 YGGyHi/zzpFVsX5YDH+/LdQ1r5/Z10FQJ62sKlS25tJzK4BnMPd545MX0Zw6Q7KkLh
	 X08FaprBWaRD0VNXCr2+LnRozkSYA546vgSv6kI+hzU6sGAQCIfKBFswhDg8bavMS0
	 dht4GXIjaVjOpkwcQJZF7EKpp55fGTXWPY6wHx7GSOyHwBLQsRw0OjCREWrG3vsnqu
	 yAaLj9zIXBisv1KA+7Vdn6DX/7H9hckGKZm9PIOlxG41z9NgwMrfYhB4UXd3fcqqvK
	 ujC25TkhwiJbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3683803318;
	Wed, 14 Oct 2026 22:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Start v1.9 development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179201580405.3058183.7142907018128772058.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 22:10:04 +0000
References: <20261005183511.201045-1-ihor.solodrai@linux.dev>
In-Reply-To: <20261005183511.201045-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  5 Oct 2026 11:35:11 -0700 you wrote:
> libbpf 1.8.0 has been released [1].
> 
> Update libbpf.map and libbpf_version.h to start v1.9 development cycle.
> 
> [1] https://github.com/libbpf/libbpf/releases/tag/v1.8.0
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Start v1.9 development cycle
    https://git.kernel.org/bpf/bpf-next/c/3ead4ead078f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


