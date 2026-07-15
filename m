Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722213EA97E
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106645; cv=none; b=QZAdNt2PxXL71UrFcw9RrrAzIJ3a/vE5jch8Btq8kti7zRmwdsP2jwrXEYsHR3d29PJm8RErlC15aNe+otVOpglXxLNs9Bi6NEBhcgrzgz1FRJ+11NUzDpMPlahFA9JIoHbhvUnqTANlx7q3+xYHXSRUiKSgFkzu6rkrSiQ+zWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106645; c=relaxed/simple;
	bh=S0T7Z8qFAJiHhEL2FF4Lpsaus9qjDqDWqVBnMz01gLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H80BNwio+ire4KhRGhAzFaohbN2L9Ujbtqj3EZR7qAD5MKmMC1uXcfBGlK+6In+nOLBv3XRXLPrtrR/0Ga2c4K3ORYuhM1VQmDl0aPvZA8VgDFwXeCXAOnI0xHQEWS/EqobcIc8HchnO1uWtx/opXctCkfRTIcF86D0TCs7rwUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTOcxPog; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTOcxPog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAD61F000E9;
	Wed, 15 Jul 2026 09:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784106643;
	bh=kRdmM7pQbycxnY/0b1dO0ZOsLqW3npKU9nfYmyK3yHU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lTOcxPogy2JS+cQ0nPR8VjEjJ+/tgwESap86me6lB+VbDWU5qKzS9BbKAM2NsF8Q9
	 7IiaBSTAmBQJNkLfcLdbiAlTeuU1iuLZyySkdZAOHHFkUaKhRBuUDvkrJVgeO04gRa
	 gqGEqj9dirnVnKNdxS/PmQrUde0Rip91qk/4jukHxi9tqTGstFr9zg8uZtaAIabykg
	 j7YnCYWPBOv1JdStfxOnFxt/T6ID3r1TALIvPZdEnE/4wqboO6FIhLdHN6F0FqYPdp
	 q/B+cILdgJST9hsKqStzvkdZPnTFN1vJy8+xfnKEIbPaeizl0H1TLcUIPg3DswO8Df
	 CnSArv4ro0CeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A6A3938E87;
	Wed, 15 Jul 2026 09:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/7] Unify helper and kfunc call_arg_meta
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178410661715.3974991.5935797358989431215.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 09:10:17 +0000
References: <20260715064047.1793790-1-ameryhung@gmail.com>
In-Reply-To: <20260715064047.1793790-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue, 14 Jul 2026 23:40:40 -0700 you wrote:
> Hi all,
> 
> I am working toward unifying helper and kfunc handling in the verifier.
> Historically, kfunc verification was mostly done separately from helper.
> This causes code/logic duplication and may introduce subtle bugs as the
> same checks are implemnented differently.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/7] bpf: Remove dynptr check in check_stack_range_initialized()
    https://git.kernel.org/bpf/bpf-next/c/c28cbef2f898
  - [bpf-next,v2,2/7] bpf: Factor out raw_mode-related fields in bpf_call_arg_meta
    https://git.kernel.org/bpf/bpf-next/c/92ec8b1b6b24
  - [bpf-next,v2,3/7] bpf: Pass argno to callees in check_func_arg() instead of argno_from_reg(regno)
    https://git.kernel.org/bpf/bpf-next/c/77a4974c1749
  - [bpf-next,v2,4/7] bpf: Unify helper and kfunc allocation-size argument handling
    https://git.kernel.org/bpf/bpf-next/c/8faaa93b9f6a
  - [bpf-next,v2,5/7] selftests/bpf: Test kfunc returning zero-sized allocation buffer
    https://git.kernel.org/bpf/bpf-next/c/1e63cd6be055
  - [bpf-next,v2,6/7] bpf: Drop redundant pkt_access from bpf_call_arg_meta
    https://git.kernel.org/bpf/bpf-next/c/d55149ff8c85
  - [bpf-next,v2,7/7] bpf: Unify helper and kfunc call argument meta
    https://git.kernel.org/bpf/bpf-next/c/bf9c1b911f4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


