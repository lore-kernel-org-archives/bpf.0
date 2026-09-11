Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856BE3EE1C3;
	Fri, 11 Sep 2026 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148482; cv=none; b=BVUKfCuBSp+CvjtitMg5mX4o8rimvekK4R9KUt9i6fN2K3xtiEI3BXALWcRWFHXwqmIH7LhFWFoRwzo5e4rMa0S5nfeZeViojb4LK/Qf1VnZPXPsXoWDphOvl61JfZp7mZyLER83YTfjUC2z9v0W9nJf/YFrQnzv6RmOtW19YPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148482; c=relaxed/simple;
	bh=uk+8Of8ZJucT2MmLymMERi1Ne3IXLm9PmpTLZ5otGCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jTvzoh9hdtVs2LQgdOjbZUT5wrytl6lHOlLtPGUNI19naiylMgG5ANRa2ymT8ufEZelPJPS6JalWA59q8O4RIHtk1T0WTrdeLjkG9dwTgNfxTypWtaVPB9rNxlVjdZCtRMDoM9vTyQM5pQ7MGF/vlpOwHbSHuxp/AiwwHE9oOeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3LBWXR9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3LBWXR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E53A1F00898;
	Fri, 11 Sep 2026 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789148471;
	bh=CbziGdpuzNrpHwdj7C2Nbe2pzYe7KUndWx2cjVKsu2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i3LBWXR9l6BiSMUx14zeI6cX+3eqm8AsDz+yoH/Q1J2EJHIYHfXutGdNw1tcLVCpm
	 4gnANlwdF8Zm4vKsuTagTNdNczeFnz5RrcxNNH4CXhn/D1BORizQ+v3J1i5830yuEN
	 qrap/td9RWOH06wboe1AJEj91xMMs97f5oL/wPomCg2ULmFIAaAByk1OiDnPd82Z7h
	 WUkjz0CMGvZhNAfYn6n04tA/jHVZCCuMYn2Pn0zF143WWcH+2oT10+HobL4emlOclV
	 8G13u43dun2/hiBTzIWwjOs3w8RlLN0/tidSexkSjcz3BE0EpKlla0Fv3wJZZfH8e9
	 tgfDFT6RfHf2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569393924450;
	Fri, 11 Sep 2026 17:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix program BTF use-after-free in sleepable
 programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178914840791.3026440.12925611853880836148.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 17:40:07 +0000
References: <20260901014829.3504342-2-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260901014829.3504342-2-sanghyun.park.cnu@gmail.com>
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  1 Sep 2026 10:48:29 +0900 you wrote:
> Object kfunc calls embed metadata owned by the program BTF. A sleepable
> program can remain active under Tasks Trace RCU after its last reference is
> dropped, while program teardown releases the BTF through ordinary RCU. The
> invocation can then dereference freed metadata in bpf_obj_new().
> 
> Move btf_put() into __bpf_prog_put_rcu(), the callback that frees the
> program. When teardown is deferred, that callback runs after the program's
> own grace period (Tasks Trace RCU for sleepable programs and ordinary RCU
> otherwise), so the BTF outlives every active invocation. The non-deferred
> path invokes the callback synchronously, so load-error cleanup stays direct.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix program BTF use-after-free in sleepable programs
    https://git.kernel.org/bpf/bpf-next/c/88c9c6d0a766

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


