Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529983EFFB3;
	Mon, 17 Aug 2026 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959685; cv=none; b=SD8E34Pdb2zu52Xqg+wE5FFEhCZHqpXpXxtibcqMiQF6lAIIN9VrbnsS6TUidAgdPF50/u0GVWYIDVZagkdF44ZRr8oD0rASPO+rHi8fmau2+KeIOsarJqYgsVs8hZWhnsD7CsoTEfae7MF0NhAEH15vyoe6acC0IhN9UO7kzXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959685; c=relaxed/simple;
	bh=G56Hhu/L4R/VwZ6onjMVwcDSGV9K8Z0kYhdLuYz5qg8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rK1apD0cb5yrbokK1lJ6EgJqWgoNabQKcR9v2FFi/4O0jcP7oTlwgKODNrTy+BkrgFllto7oe713WRBafH+S1oTjNU7PQAwtLo9q3EVvyzd9IRzImaRcxs2dcXZGK6ctw0HRBbCMFZbZvcw8nBVP0CkwMFLeCATRsvUGQqUeB8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l83+olI5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l83+olI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F2D1F000E9;
	Mon, 17 Aug 2026 09:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786959681;
	bh=XUKXoWBe9+C7bjMCNiFre3laQv8r0ndSh+qydjYVf48=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l83+olI5uy5eHyAznb0f2zldqMgzdU6j+hZN+X/f+iQplrI0CvWzh0cgpPPfShLlx
	 B+164PkRJRlZfk77jUM1sEkahARQQx1JIOZk7La45qqaw2Apb0nGywxDmx3ZERDNnG
	 fHNdcm35zDeBilMF2dh5/9P3NmwRWeBoTI/7jUDEGF/m72ECQkwF7Ze/fpEfomBQvM
	 ruZ8gIYN/1NWZoczU05ButbiM50Xd5166KuacGgKVV3ZWIL/uYV6idLAbzhMKkG5wj
	 2TvrdrwqLm1pFvFI7fzvtQS1PsO3gXQmQohFj2lboE+t0vX3RjecNag1APS4IGVh5d
	 AdJZzg2LJUSwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A1339253C4;
	Mon, 17 Aug 2026 09:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/6] bpf: decap flags and GSO state updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178695963358.1043070.9614982598218291426.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 09:40:33 +0000
References: <20260812083115.73100-1-nhudson@akamai.com>
In-Reply-To: <20260812083115.73100-1-nhudson@akamai.com>
To: Hudson@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Nick <nhudson@akamai.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, willemb@google.com,
 martin.lau@linux.dev, mtottenh@akamai.com, aglasgal@akamai.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 12 Aug 2026 09:31:09 +0100 you wrote:
> This series extends bpf_skb_adjust_room() with decapsulation-specific
> flags and tunnel GSO state updates for decap use cases.
> 
> Motivation
> ----------
> 
> When BPF decapsulates tunneled packets, skb GSO state needs to be
> updated to match the removed tunnel layer. This includes clearing the
> corresponding tunnel GSO type bits and resetting encapsulation state
> once no tunnel GSO flags remain.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/6] bpf: name the enum for BPF_FUNC_skb_adjust_room flags
    https://git.kernel.org/bpf/bpf-next/c/5e4bcad6171d
  - [bpf-next,v7,2/6] bpf: refactor masks for ADJ_ROOM flags and encap validation
    https://git.kernel.org/bpf/bpf-next/c/7b2ea1151e04
  - [bpf-next,v7,3/6] bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation
    https://git.kernel.org/bpf/bpf-next/c/da199070bc62
  - [bpf-next,v7,4/6] bpf: allow new DECAP flags and add guard rails
    https://git.kernel.org/bpf/bpf-next/c/3a39c214fd2c
  - [bpf-next,v7,5/6] bpf: clear decap state on skb_adjust_room shrink path
    https://git.kernel.org/bpf/bpf-next/c/ec20dee2f2c4
  - [bpf-next,v7,6/6] selftests/bpf: tc_tunnel - validate decap GSO and encapsulation state
    https://git.kernel.org/bpf/bpf-next/c/adb771973026

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


