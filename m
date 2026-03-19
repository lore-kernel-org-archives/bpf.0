Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49738F24D
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773947415; cv=none; b=eQUTzMIj2W5zRREd7lYPZOiejCyXZlMnaezE/sb9nvuaV87jiK1TQpBAThzqK6cuYUwf2jxmowglz2aC6rP7vHdiJawwsQ/5s+2tlbmtLaiiW+m2UHTGs28g1t7vq6N7TkCNr7dA/vPZbtGwuXVFRnF8XqZv7OvW0x2kOchCsfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773947415; c=relaxed/simple;
	bh=MqWfU3Tmbt/ruf7zCUsFkNefLnv08Zd3X9KKNt75D5E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iu6O4S6uDD/OPPK2gQrkF2S7lU22T+bFV8AYEotWW7+3v7lIbfdAkSy2sBcJGAhlC+962iOk/z57T9fN1Xicvju4Ai9R12mrUhi1SqSYoJnGPTj3j46JFN67EakEZxsePHtVlhdZCdXMYfkwzysMaApMU3HpjiapSHEWvJct0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGce47vk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGce47vk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2E0C19424;
	Thu, 19 Mar 2026 19:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773947415;
	bh=MqWfU3Tmbt/ruf7zCUsFkNefLnv08Zd3X9KKNt75D5E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XGce47vkgJRuWb4AUD3yInY7iZxlTZqF/qckY9ej2agp/k6+SnC8uYgoryWcQbmzy
	 dy1Zz648FkAs+Qy4ayfoF7A45d9XQ2P72KJX2hAjXd+2aP63lu8PLOszXgzO0JTrnD
	 WN3v+qgN72JLzy2JMuWZdGiDBDl9UcOkVp0hGzkqGnWBcjCbXXSJOKutjodhffpSU8
	 qE5Aohw02qB89U1KBuWpirhn+x8fU+iwynoa6yRJCDuVAOuebWT9JlvZXyx+Ed3N+1
	 WfOqfchmlJpGb47oXs/O8UqIJszl6qXNZxq7N57ZZsWaORU++6GrNmZ8pHml1Zh7SF
	 vNxJ0/7plMi9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDB339302F6;
	Thu, 19 Mar 2026 19:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Do not allow deleting local storage
 in
 NMI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177394740604.1768581.14896493417337361938.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 19:10:06 +0000
References: <20260319025716.2361065-1-ameryhung@gmail.com>
In-Reply-To: <20260319025716.2361065-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 18 Mar 2026 19:57:16 -0700 you wrote:
> Currently, local storage may deadlock when deferring freeing selem or
> local storage through kfree_rcu(), call_rcu() or call_rcu_tasks_trace()
> in NMI or reentrant. Since deleting selem in NMI is an unlikely use
> case, partially mitigate it by returning error when calling from
> bpf_xxx_storage_delete() helpers in NMI. Note that, it is still possible
> to deadlock through reentrant. A full mitigation requires returning
> error when irqs_disabled() is true, which, however is too heavy-handed
> for bpf_xxx_storage_delete().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/1] bpf: Do not allow deleting local storage in NMI
    https://git.kernel.org/bpf/bpf-next/c/350de5b8a9be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


