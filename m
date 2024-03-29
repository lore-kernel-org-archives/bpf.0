Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE36322313
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729831; cv=none; b=Tlu4xyuy6nuJ8TgrcnndmS5Q1txtCja7irMmV103vLJIlRMGb6RIDDuf4iGXICMVOxix5UDUfN0LbxtdubHMoPSOLIqllCrNMkzeZaUz1LyAN3Ad0XJaVQNBXDyhE16xnjSx8rxmIJNuQZOj57Jh1ODt+JmQ52pdacSkPbZIuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729831; c=relaxed/simple;
	bh=SzPqjDREErbSgwmT9WNMuCpfSKapLCcLqCvj3WRrbsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hK2V1+WFm+8yioI/1lMlkZg9yvgk2y6h01Ze1WvNpUAOHNVnkfigHbbT6/WkvH3kWzr/i7J6tdBQwlUtgJFtMQNRFEdU1CCpEdu5J8nJgBHWoOhCOHtHJdtJuhIb8TOK3kZnHJzQgzKchYdZ6j+BNoaFC6gtTVGN8PSW8rZ31rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSHoqr81; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSHoqr81"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F19DC43390;
	Fri, 29 Mar 2024 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711729831;
	bh=SzPqjDREErbSgwmT9WNMuCpfSKapLCcLqCvj3WRrbsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TSHoqr819z7ZdZ+rYlNwjnrh0dztRzhywmTw18+hR57SW0sJ8IuGF5mAhYvuiC99g
	 IxrvUgROiaxT9ixnyk7eOTqPvEyRHAv+1MkZw0dPQrtHONFRTqe023eDxItGBwYNIC
	 RNKuAMn3s1sW4hIK9/hDezobnR8QRkpSnxfhdsNsSdwl43ZNw/y02apHkwCKOxcK7G
	 CyaNrI45+xIujUdzjwX+sqtYG6CIYvbxTv8qu79DUqctEB60rHQFHw1BZOk0EqcFKw
	 PhfrDN4Fn0qsxfmDksKoD5A1OtFfeqjHLHoaZwyJZPcwXXPjqAH3pizn+hvLS9/M0q
	 6fOyClHkZRZZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30AFCD84BAF;
	Fri, 29 Mar 2024 16:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: fix possible file descriptor leaks in
 verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171172983119.8641.2157805159370109680.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 16:30:31 +0000
References: <20240329071106.67968-1-aspsk@isovalent.com>
In-Reply-To: <20240329071106.67968-1-aspsk@isovalent.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
 martin.lau@linux.dev, sdf@google.com, yonghong.song@linux.dev,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 29 Mar 2024 07:11:06 +0000 you wrote:
> The resolve_pseudo_ldimm64() function might have leaked file
> descriptors when BPF_MAP_TYPE_ARENA was used in a program (some
> error paths missed a corresponding fdput). Add missing fdputs.
> 
> v2:
>   remove unrelated changes from the fix
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: fix possible file descriptor leaks in verifier
    https://git.kernel.org/bpf/bpf/c/6dae957c8eef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


