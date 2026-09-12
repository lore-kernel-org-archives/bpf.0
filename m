Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B583921EC
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183287; cv=none; b=DLtVLG74Jb8oXptsRO99LD87wSZ9ftvjgkR9gGE2eTRGWbJon9GS4YDJtw4C7UsKJxZzq2bEmXKTCRqaMVdtiw3ZSGIyu6mlqxeYMqx2DCsNdGj+DJiuHKaLa3KGMyIVcOcfv1qhg4FWtM6ztvU7zHUVX+fY542naPPiGZQMpUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183287; c=relaxed/simple;
	bh=wcWSw0fh8dK/mwCMEJ5cMeiRf75RADu8wufQ+3G2Fkc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jMN/ryscmHJyj9noh1e2zLbT7Rxkh/ablCEreX/PSqVvwuxzGCK743EZ/N7qOigIKzw/ym/FbYHf78+RJb6F1nggVGMo4dmFe9V3Vbg/C9zlIAEK41r/muPm4kk20Ard5WwnIYS/59HLvM4bHAJe2DlI3k7BqyOSL1wG454nyiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIJhlPVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIJhlPVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B471F000FF;
	Sat, 12 Sep 2026 03:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183284;
	bh=i3O65EIVt1WfnAQ0D61e48oIvpC5BI3vQab33Eq3e9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AIJhlPVeK6MYwDp4SLJUWEokGRaD+ZVkMsi1+CbQ0fyvaQ/V8k9qgglr3yl799tyF
	 YYOnfdT4SD+307XrG/9Q71fJk/XizeXpCmX6jA4B2CflKodNwzvsF4tEpEiixTnT19
	 cDg4N8Dkbq5mhoZvSxkvW/gDJNcBCeB8C89PygHsFJJPJhFRhrFPaYXK/+4H0je8fr
	 lFhrHGfePsfeSdyv2sOqarOcwzQ+6rFf+KHf+IKSx9rJQJHe936eHBKfCfDGDCd7Vn
	 fpRe8cQyQrnf7e6IE9BphGyGSUrTR64mapxdWpOpQRxO82jmbGHXfLPiZGHfqGiUUW
	 R1oleXMHCdxdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5699D392445E;
	Sat, 12 Sep 2026 03:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 00/22] bpf: Unify helper and kfunc argument
 checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178918322113.3208623.7651069330846979270.git-patchwork-notify@kernel.org>
Date: Sat, 12 Sep 2026 03:20:21 +0000
References: <20260905220117.922028-1-ameryhung@gmail.com>
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  5 Sep 2026 15:00:55 -0700 you wrote:
> Hi,
> 
> This is the 3rd and final patchset unifying helepr and kfunc checks.
> 
> Helper and kfunc calls currently validate arguments through separate
> loops despite enforcing many of the same contracts. This duplicates
> type admission, nullability, memory, BTF, packet-access, and resource
> ownership handling.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,01/22] bpf: Pass call metadata through shared argument checks
    (no matching commit)
  - [bpf-next,v1,02/22] bpf: Address check_func_arg() arguments by argno
    (no matching commit)
  - [bpf-next,v1,03/22] bpf: Only compare func_id against BPF_FUNC_* for helper calls
    https://git.kernel.org/bpf/bpf-next/c/d18bcf4537e0
  - [bpf-next,v1,04/22] bpf: Only compare func_id against kfunc BTF IDs for kfunc calls
    https://git.kernel.org/bpf/bpf-next/c/0bddc59e33a4
  - [bpf-next,v1,05/22] bpf: Rename ambiguous function argument types
    (no matching commit)
  - [bpf-next,v1,06/22] bpf: Unify kfunc argument kinds with enum bpf_arg_type
    (no matching commit)
  - [bpf-next,v1,07/22] bpf: Align helper and kfunc ARG_PTR_TO_PROG_AUX handling
    (no matching commit)
  - [bpf-next,v1,08/22] bpf: Classify kfunc arguments the verifier ignores
    (no matching commit)
  - [bpf-next,v1,09/22] bpf: Set OBJ_RELEASE when generating kfunc argument types
    https://git.kernel.org/bpf/bpf-next/c/57e181cde7e6
  - [bpf-next,v1,10/22] bpf: Set MEM_UNINIT and dynptr subtypes when generating kfunc arg types
    https://git.kernel.org/bpf/bpf-next/c/78811eac7ae6
  - [bpf-next,v1,11/22] bpf: Set MEM_RCU when generating kfunc argument types
    (no matching commit)
  - [bpf-next,v1,12/22] bpf: Resolve BTF ID of ARG_PTR_TO_BTF_ID in kfunc bpf_func_proto
    (no matching commit)
  - [bpf-next,v1,13/22] bpf: Resolve ARG_PTR_TO_MEM | MEM_FIXED_SIZE size in kfunc bpf_func_proto
    https://git.kernel.org/bpf/bpf-next/c/6ca151e7cc32
  - [bpf-next,v1,14/22] bpf: Consolidate runtime argument type resolution
    (no matching commit)
  - [bpf-next,v1,15/22] bpf: Consolidate nullable argument validation
    (no matching commit)
  - [bpf-next,v1,16/22] bpf: Drop redundant BTF pointer helper write rejection
    (no matching commit)
  - [bpf-next,v1,17/22] bpf: Consolidate helper and kfunc PTR_TO_BTF_ID argument matching
    (no matching commit)
  - [bpf-next,v1,18/22] bpf: Admit kfunc argument registers through check_reg_type()
    (no matching commit)
  - [bpf-next,v1,19/22] selftests/bpf: Test kfunc packet memory direct writes
    (no matching commit)
  - [bpf-next,v1,20/22] bpf: Consolidate function call pkt_access validation
    https://git.kernel.org/bpf/bpf-next/c/8fe994c80af2
  - [bpf-next,v1,21/22] bpf: Consolidate release argument validation
    (no matching commit)
  - [bpf-next,v1,22/22] bpf: Check helper and kfunc arguments in one path
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


