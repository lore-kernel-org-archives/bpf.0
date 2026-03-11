Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03B2DC76B
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773191409; cv=none; b=hz88nJsscZZjtwX4pbYtipD8jZmDiBitDmlbYFGa9GlvBfrii/HZV32xP9VOvaU3+KuRXxLfgV4drnpJ5l1tjdlJt/S88FMyyfxopixwhHLeXJw/ROT/mCc9pzgPUTdvEOEtUTMg3idYxMP1sJYjaEuNuMfB5FyMxYx3D3D6zpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773191409; c=relaxed/simple;
	bh=Z7pVThHdrF3p9B0MT8vLIG5Vb2xuxSywiOYbXX+QTYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fTZppalZS629iwnnFuqOOsqjGeKUemXJF9KKoOy5nGooNPMi1IJhiM9UwE0X2kZ8/WyQ3xBzP/Zl6p9NAN7nI1FA88qJfh4HQM1Tgra4CnmS8D0Qm9vLrEjiQ+RRlI6IIy/alZggCmb540toZKavUVgZihkL2S53gWa1yDBO4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XShlKCto; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XShlKCto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F0DC19423;
	Wed, 11 Mar 2026 01:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773191408;
	bh=Z7pVThHdrF3p9B0MT8vLIG5Vb2xuxSywiOYbXX+QTYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XShlKCto/Cm/eERwXNvazlEOZbj/W9d+/JrF2WEqT9AtKrAlQYypQQOgPg2mR8FSi
	 XkCBoxaAEwKR0INYT7lzfNIuSV9qSxk0dLEIzHrqUDGsDslJ+iyK9CHlnQfn0xo0EV
	 3vt0yiUVUS+CkekYkue2sIutOvO+fIayQOt/0SW/JBsCTmU1XvvQHPRXokvDhGzbFq
	 1ykQjKQbhwk9fCwqWRtyVOmk+gF4CeE+MOcFF1PGDKByIvcZZlt9ZsJMQZ43la3kXO
	 cddRN6klvXx+nrBIB8O03r319CErNem+rIcgBAqMj0fFUPf7I0oThlDVLEZ5303t1a
	 gaoxgJiygf9fQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FFC53808200;
	Wed, 11 Mar 2026 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Handle !CONFIG_SMC in bpf_smc.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319140506.2988692.3314682785785857337.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 01:10:05 +0000
References: <20260310111330.601765-1-alan.maguire@oracle.com>
In-Reply-To: <20260310111330.601765-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 alibuda@linux.alibaba.com, yanjun.zhu@linux.dev, bpf@vger.kernel.org,
 colm.harrington@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 10 Mar 2026 11:13:29 +0000 you wrote:
> Currently BPF selftests will fail to compile if CONFIG_SMC
> is not set.
> 
> Use BPF CO-RE to work around the case where CONFIG_SMC is
> not set; use ___local variants of relevant structures and
> utilize bpf_core_field_exists() for net->smc.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Handle !CONFIG_SMC in bpf_smc.c
    https://git.kernel.org/bpf/bpf-next/c/e95e85b8914b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


