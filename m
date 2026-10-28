Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161807;
	b=B4D63y3nc00jj9uZQTlkwPr2XavZ4eifrwf1KtT9oU9qYsilgZ/JHzeVq83SIioyWUbi
	 KUneNIDS9C/AeYABWEcYByAm1vxwMB8BzUsLVNPA/qsWPKz0JDVGHVhjq6GEsRdNz0o+W
	 ua8LaUgJoKeAVNII17QeSRCJpM3pDOixIkCqTS5utlSJ6NIREV8TPnKYJyPmbnYXFXSSW
	 hdwo+gYK8sbwr3+UTmveGUILR/B97/l6cFCqZSsWznLLvjUyF2waRQLZvg/fiu7EYkQBt
	 5BHc5Xp/9Up9FkuTeRPcraSWymW7HKVz85SqiBX7wMuKGbCr++UxD84Gw16YT2J59NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=x4+9SEi4g2f1jxK7x2ASn6ZxlMVc5S/VUwdXjtokzww=;
	b=O2h/+qibZjxZPO95ZQ5uYABt8WWRqg9y+O/FMohwot3I1CaMSnmN3hJr+Zz7ojvwIhsz
	 F5mrCPzekITUXtuTDtJ2U5zXj6wvWKB1zCcoH+YM3al+PJehlQThix257Yba8iGfdJnO9
	 0MNp6P1foEQJlcZ+vHJaL0xNhvUbbdZyR6jSMj7/jWcPhaAH6uVsoiit/BMW00g6WUtgK
	 JtYhgzytjtgF0nHT0jguUgzVQKdpllMhgminuBMI5c3t1c39T83VIU4LodYVKNdbY40Yw
	 oB6P+3q0hpIoCgyfIFVwwC4Veq1Zp43KtGIaVjDIpnkEQrzg2BSp+DmgzrupU6dWlug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvNtIKhB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C0606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 04:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvNtIKhB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF021F01825;
	Wed, 28 Oct 2026 04:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793161806;
	bh=x4+9SEi4g2f1jxK7x2ASn6ZxlMVc5S/VUwdXjtokzww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HvNtIKhBW7f8Ma9RirhVbJ173+uPxiuRJN9rHUPQRrKJGg927kTdFDVWKbZc/mA3F
	 4kAMBeVbvs/9ZP+3B3V75khpe+4s20DlNW71J7jeHpuI5GtNgZCpScF03R8HvwekJl
	 Hgdv5L7R64DmhrNW3W2IOHstYlL2RfUZW+eNVW0L5OUheAFH47zTRzYTQ9RVt1STT0
	 kzNt1XkiCHWDUDUrpPw87fykRfAsJkOvkmiXJTKFGmgRjDLVSOTx50cEr6IUqBEn6U
	 W+eto8p1Uqyg7CAWy7VYfmWZKcuP2jtjKfSkTu4KpO7IFxCj/hY76grACoz+QpwrPB
	 sWpb6OZL/aRpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 444D23AA9F69;
	Wed, 28 Oct 2026 04:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Don't re-sort subprog_info[] for every new
 subprogram
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179316180508.495258.18435116916955776675.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 04:30:05 +0000
References: <20261023150302.4097865-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261023150302.4097865-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 23 Oct 2026 15:03:02 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> add_subprog() appends new subprog to env->subprog_info[] and calls sort()
> on the whole array, though only the last entry can be out of order.
> Move subprogs that start after the new one up by one entry instead.
> 'start' is unique, so the order of the array doesn't change. The new entry
> can land in a used slot, so initialize all of it.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Don't re-sort subprog_info[] for every new subprogram
    https://git.kernel.org/bpf/bpf/c/c8a8a68d3ab4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


