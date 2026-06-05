Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889BB3D566F;
	Fri,  5 Jun 2026 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694425; cv=none; b=o3B2ne+cvmfZMsK5+XfkVmyyypemhZenspwdT0uNcbKw4Qqz4ZtGSRm1VhpKQVS/oV/SNWqT+XkivDYfrfGU6f4KeDO63HeUbnrHOjFYKHXr1nQOqXZ3CQ1KV9Ro+jmNQNqi+x2lf5NuwjjawAoYhMMxGZjTy0zpgJe2v2sU1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694425; c=relaxed/simple;
	bh=zl32nW8YjwsAITNMz8jHAkI8/nCtWiP80qs+wYVthZ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DGWzWos70Wy2kpwCnaoK2lTDPonPG3CRsfNrOI/UCSMFU0vXjUI3uDT3Cm1Ow4ptR0/X5xh/yEQyaERTwPh6HB3SqZk0RgUh8xlhjW8K43lXy3rrIQZ8o9LWyv7Z/0hit/5NFJqxu/2H0B5/gMsWDcfGISeKAWGBTppBs21VddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHcCJ1DV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHcCJ1DV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4FD1F00893;
	Fri,  5 Jun 2026 21:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780694424;
	bh=Wfo1qw7Lc+3W3IMAZqiEHHZpKDggcd2sOaR2mkFNisg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oHcCJ1DV/TYLqg3eT2J+/ZvVdUDsaMNBEaBJ7H0wpDu1hcvDsj49pg4c3rzpZcUrP
	 xf1VZcQSpTe5Nd7KWpo+0AHpqAY0TMj1KbfUKHOqUqfur7FVxgGONaBhm/J5HY2RJu
	 r5lxzSNxJ/t6M697dofEipPWFqYhuHSZU2HZa9A9kMT3IX1jswJSSDUnuDCY3R2Ceh
	 1DqJpWAE9qUsTOw2BKNzAZIshj/ByJEmSQENIM/9ta01yvfi2/MrIfVG0OiB3rm7S4
	 WBIqGiNUGKOUepdQgzU/7KjgyuLASNf0/763K0vrCdY8utS1hw12VrVsQ6fzY+1gyJ
	 IOBG4Y9n5vrOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A323930BB9;
	Fri,  5 Jun 2026 21:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Clear rb node linkage when freeing
 bpf_rb_root
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178069442439.3922226.12707395919255185751.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 21:20:24 +0000
References: <20260605094143.5509-1-kaitao.cheng@linux.dev>
In-Reply-To: <20260605094143.5509-1-kaitao.cheng@linux.dev>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, davemarchevsky@fb.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, chengkaitao@kylinos.cn

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Jun 2026 17:41:43 +0800 you wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> bpf_rb_root_free() detaches the root by copying the current rb_root_cached
> and then replacing the live root with RB_ROOT_CACHED. It then walks the
> copied root and drops each object contained in the tree.
> 
> This leaves the rb node state intact while dropping the object. If the
> object is refcounted and survives the drop, its bpf_rb_node_kern still
> contains an owner pointer to the freed root and stale rb tree linkage. If
> a later bpf_rb_root allocation reuses the same address, bpf_rbtree_remove()
> can incorrectly pass the owner check and call rb_erase_cached() on a node
> whose rb pointers belong to the old tree.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Clear rb node linkage when freeing bpf_rb_root
    https://git.kernel.org/bpf/bpf-next/c/4a7910ee060d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


