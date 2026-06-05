Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82383E4C65;
	Fri,  5 Jun 2026 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673409; cv=none; b=KGCPLu8GYJUJge/SXmtcLQMTqJt/jD4aQZWAKBlXJcb0pMbGoOGZHZsJCNQuhljxZVZHaata36le4K8EbvPi3HvGKo73D5maoNfanyP7JgRwdd8zS8wcrX/2N5jRuVKzHglE5n3XGAJojEk0HQp6OX3nbcGvnBsp8P1Pb2OYHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673409; c=relaxed/simple;
	bh=C1xtfUG0N5An2pmcMOU3sBP+r3o1WVlAapOlrsAjkgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K6aB5IzPLHbjNMBEflyPD+wAhC+rOxIKvto764wTdLdIlCQvQK51B8kfcBUSWJk7uwneCtPixShMa/UAipOhwUI44HW8CkelnbGn6BqU2xBL8P9GJYbR4KoX7P9n+9o9h1a175mzfaS0PFua33kfwAkgH3OL00VuHJc9QaeOuf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGTEaJWB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGTEaJWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FCA1F00898;
	Fri,  5 Jun 2026 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780673408;
	bh=htU68yBnR6ThA/0S5lSqWG9Jdr22od7ZJqdXDvMAz+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GGTEaJWBmhmoFNdtSnabN4ffLhxoZ3IDy06FpCysYQZOjc76TlFx0WEDSuzpGQSWB
	 8VYqEh0eVKit7uHu9bVyHxnz5hBrPLpujo9uzjTKrQ+himWZXCus2rNiThi6gK3cyu
	 8KkO21KiFytirc3WbAxJSS0MQfxMx47w2ISHPflwhfveq7Z2iVn4F3oKfv07fUJU0s
	 E16/lCCSlq07o4zoZutEqAVuOsHNQZTzPRypLkyWJ/3mgj58/uaorWH2UawFOCVLcV
	 KszQlTkieQZWB95qtexKsow8wMlRLS5rxeCzyI8dS4Or9GTzs4bYJghi42up979NMr
	 bjnyq6dDzvRDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A833930BA5;
	Fri,  5 Jun 2026 15:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: devmap: reject fragmented frames in
 clone-based
 broadcasts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178067340889.3804693.6720254457883948615.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 15:30:08 +0000
References: 
 <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
In-Reply-To: 
 <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, toke@redhat.com,
 liuhangbin@gmail.com, yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, zzhan461@ucr.edu

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  2 Jun 2026 16:43:33 +0800 you wrote:
> From: Zhao Zhang <zzhan461@ucr.edu>
> 
> Devmap broadcast redirects clone the packet for all but the last
> destination.
> 
> For native XDP, that clone path copies only the linear xdp_frame data,
> while fragmented frames keep skb_shared_info in tailroom outside the
> linear area. Cloning such a frame leaves XDP_FLAGS_HAS_FRAGS set but
> without valid frag metadata, and the later free path can interpret
> uninitialized tail data as skb_shared_info, leading to an out-of-bounds
> access during frame return.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: devmap: reject fragmented frames in clone-based broadcasts
    https://git.kernel.org/bpf/bpf-next/c/aa496720618f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


