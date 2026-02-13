Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ADE318BAE
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026658; cv=none; b=BJKzFcrCfed/6SSVVsQ4o9Oi72tlU45mMBnybAOj05Oh+HDz8obHiujkx+kCv20EbPRfIFhgOzTWNcAdj3+KRv/t96xxp7yoNNt3yRj370gQogSr/DCiwOSnynjW+i4ZqrlWer5xdnfVULv13EN2ZgkJO3bkTGDMrWkNwTdy1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026658; c=relaxed/simple;
	bh=iSTi4rtMNukCwZeg7pjmk62i3QdJyATB9LwVSlJzojE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rfBYxC8t06xxhlFSLUdTBCUf9YyTkssX4lliQMxtFF9mcCXx6IptDrNQMWoJvQ+GnXWLIzIxcy+UHP6sjlNe+J4hk3R1c6DllpMMxo3SIieOzl2Nhl7pCJfa3OkrxVf6PgNCUO/cL+EV/Z85fzJrqTxrrXbKzs39Dp0UkoO6JSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGO2ogeQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGO2ogeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD620C116C6;
	Fri, 13 Feb 2026 23:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771026657;
	bh=iSTi4rtMNukCwZeg7pjmk62i3QdJyATB9LwVSlJzojE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uGO2ogeQSmiWyIQ9/8SOcwzi0uMacltuGmIDWykzwzYjYlFuQs3cuE2cIkaJ3xXqP
	 j2FM/fV8g3sdA/q6hHf7qDM5vwWoJQvH0wA2nTejvYqsI5l3/gds6AYgMNotYWyA05
	 LF1xUic8TOX/t16SwAqOSnvx/UHpPzhUOeylJHLZ+0ddRclW6RJ5/T7yexGt0ZxsWL
	 GjkgBZJYuwBukQcuHsBHSai2Whm/H9OHpUl909EQS75Q3Nag/wDJpo/NKs8j+ueb1d
	 5hzWI9JDGQcvTvb0FeT5sI0ZGYCnj8NCidNg1QFqg0BnL7sDv89d8mZ2whI6Lu1O8b
	 +bI6D56roRnyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C23243811A44;
	Fri, 13 Feb 2026 23:50:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] bpf: consolidate pointer offset tracking
 in
 var_off
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177102665132.2575868.15031753627430693514.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 23:50:51 +0000
References: <20260212-ptrs-off-migration-v2-0-00820e4d3438@gmail.com>
In-Reply-To: <20260212-ptrs-off-migration-v2-0-00820e4d3438@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, kuba@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Feb 2026 13:34:20 -0800 you wrote:
> Consolidate static and varying pointer offset tracking logic in the
> BPF verifier. All pointer offsets are now represented solely using
> `reg->var_off` and min/max fields, simplifying pointer tracking code
> and making it easier to widen pointer registers for loop convergence
> checks.
> 
> Patch 1 is a preparatory refactoring of check_reg_sane_offset().
> Patch 2 is the main change, moving pointer offsets from `reg->off`
>   to `reg->var_off`.
> Patch 3 removes references to `reg->off` in netronome code.
> Patch 4 renames the now-repurposed `reg->off` field to `reg->delta`,
>   reflecting its remaining role as a constant delta between linked
>   scalar registers.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] bpf: split check_reg_sane_offset() in two parts
    https://git.kernel.org/bpf/bpf-next/c/ed20a14309e0
  - [bpf-next,v2,2/4] bpf: use reg->var_off instead of reg->off for pointers
    https://git.kernel.org/bpf/bpf-next/c/022ac0750883
  - [bpf-next,v2,3/4] nfp: bpf: remove references to bpf_reg_state->off for pointers
    https://git.kernel.org/bpf/bpf-next/c/6363fc17c9f5
  - [bpf-next,v2,4/4] bpf: rename bpf_reg_state->off to bpf_reg_state->delta
    https://git.kernel.org/bpf/bpf-next/c/3d91c618aca4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


