Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE3271464
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104882; cv=none; b=De+nEBhKZxxbQRuC9sG3x1OCIbXNuPaHDU72AAO23xbzoef58MCLsWFAlLO2d43+KrK12t+5ehjZ6hoQjzAXnHyBP9vn1ldBsJx6hIWCbV4NAyhPsO4Io4T0wOQtHq3NTxpio+bfpdVQ3+P/3cM8Ebe1LgC/IPwAIheaN/2Npkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104882; c=relaxed/simple;
	bh=XjO6KCM5NJRI0CItuEEx7yEXmD/R3EHUD0o2TDCfEVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xu+To+kadjpvGmWgJVR82Zx6sUDlmlRoOCac6WE8ofCNftpSzfk2XwwHc6KQY3sO0xuEyH0WLluwumulonCEjPDPLXwBLU6ev8eUqlSXshheulHiMI82rAvsjkZ/P8rj0rPV9HfQx/8dPpPsXe68yFsxybtSWh8e5lMksytbxc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzHSU0UM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzHSU0UM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3474B1F000FF;
	Tue, 22 Sep 2026 19:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790104881;
	bh=SlR1ru487EEvdx4aq3i89Dsujf5iuDuO2FyrxGu1yik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MzHSU0UMMPtHLfjK4uTtwSyV7c3g/Tg7H5A4gkU5Pxdm3coMqY/Taa10hYJv4k6AI
	 vNAOriI/av2Jd7pOtV+7dbu7b5hfi61McnNdf8Sjb8lMj3QqmRUI2XnN30SY5eu0wq
	 0HTOsUaG2i27YURjAEMQkV1BvCY1iIFwN3Vxu/Ven6/2VgUYEbfCfqZXDHDasexDEH
	 k6T4Zkam9VzVHkX6do+KT8xB6t3ooBE/1u4mXpdFJdPeKw6ypPbMYkNi7zcGP98cuP
	 bfJ6HO6cOMcgVTy/02W3RnFM+NZ5KVfV6lbkx7K66Yrk98caHX5PBYqPvzP1LeMyMA
	 kvgzIINsU3Wzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BF73811A60;
	Tue, 22 Sep 2026 19:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: Speed up htab lookups for u32/u64 keys
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179010481220.48438.10259992249871053986.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 19:20:12 +0000
References: <20260922-hashtab_fast_hashfn-v3-1-b7b0e9bc33ac@meta.com>
In-Reply-To: <20260922-hashtab_fast_hashfn-v3-1-b7b0e9bc33ac@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com, yatsenko@meta.com, a.s.protopopov@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 22 Sep 2026 10:58:02 -0700 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Four- and eight-byte keys are common enough to warrant specialized htab
> lookups. Use jhash_1word() and jhash_2words() for these key sizes instead
> of the generic jhash2() path.
> 
> For JITed BPF_MAP_TYPE_HASH lookups, htab_map_gen_lookup() also knows the
> map's fixed key size. Select u32- and u64-specific lookup entry points so
> the compiler can specialize both hashing and key comparison. Other key
> sizes continue to use the generic lookup entry point.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: Speed up htab lookups for u32/u64 keys
    https://git.kernel.org/bpf/bpf-next/c/63b13537e6b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


