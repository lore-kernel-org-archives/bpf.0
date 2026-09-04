Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2230B49DB88
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788550281; cv=none; b=MdC+S+djoHwAKXRt3wEY0W95kE5hgnKSJETOXwRI4q4HhtqhmtGO9RErO19CR5zEe/fir409DH98N+gYNoYvHk1OfAn/sZaCwMpiJY73STimRbkK+TbgkjUovA32djFv9RgP+SDrEAFMac/g6VFQI8LWiLcnYIMYUWwMgA5GBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788550281; c=relaxed/simple;
	bh=x16i8YpX7YEnYQfNECuqfGezjyndZio7dyPFxOjLKHQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HunqI4h/pTfIk04RcakjcP5ZCaPZvkRqf4OGihllfHBdasEQ2Hk7ChX3PF12Zat0KUbAHtH2O47Oh6TS6x6j5uvLcd2O/Yk+e95FEnFPtP0MdW9BM+VwcWF1PCMAEjZ6ubCfV8Bp0pLPxR3nkx9Bk38fnun2zne+Uhv+g+W/nvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFJbxYZq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFJbxYZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58661F00A3D;
	Fri,  4 Sep 2026 19:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788550278;
	bh=lCyRJZN1l5CO1beS8IkurHiBWsozHZU53GxruUndvas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BFJbxYZq/cDnBk8SMLrPiVuVoCZinUm+52LsEI8e3PyAdG9wylzceCq1UWVDMD0SG
	 gS0Jlps7oYvP+FViL6SQwKGufm/+jDd+YRRfGQbniO3x9d+lz0p2jLqojBnJ1ymdaL
	 Y7fI+AaKPl2iyko3Q92gDAT/rDJxKqtBEX4KP0o5EFV+eycfxLRquRZ2WQuaceYYCL
	 BWsrfFSOXUaA2jTfo409xLg9zqp0D+Y7XZ8TmAbiDMk4Wm8k0nJmxNwjoURKopldAj
	 OHWuWcJ0EH6B9ETirZLiECIyD1Uax4SrmaUoqOpfwCP9UQggICANxBiiH9yy0eXDBN
	 Caj12TKV8GOlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C273924A6A;
	Fri,  4 Sep 2026 19:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 0/8] Misc bug fixes - part 4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178855021942.496513.15736796371494518998.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 19:30:19 +0000
References: <20260904104203.345917-1-memxor@gmail.com>
In-Reply-To: <20260904104203.345917-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 npc@anthropic.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  4 Sep 2026 12:41:51 +0200 you wrote:
> A set of miscellaneous fixes for bugs reported by Nicholas, and GPT-5.6
> when analyzing those fixes, batched together again. See commit logs for
> details. Related rhtab fixes from Yuan Chen and Nuoqi Gui have been
> folded into the series.
> 
> Kumar Kartikeya Dwivedi (5):
>   selftests/bpf: Test timer field on recycled rhtab element
>   bpf: Mark NULL kptr stores precise
>   selftests/bpf: Test imprecise scalar kptr stores
>   bpf: Preserve inner map identity in callback frames
>   selftests/bpf: Test inner map identities in callbacks
> 
> [...]

Here is the summary with links:
  - [bpf,v1,1/8] bpf: Preserve special fields in recycled rhtab elements
    https://git.kernel.org/bpf/bpf/c/5df46ddcb7b3
  - [bpf,v1,2/8] selftests/bpf: Test timer field on recycled rhtab element
    https://git.kernel.org/bpf/bpf/c/dbf6806dc815
  - [bpf,v1,3/8] bpf: Cancel special fields when recycling rhtab elements
    https://git.kernel.org/bpf/bpf/c/65cc95eba9e8
  - [bpf,v1,4/8] selftests/bpf: Test rhtab kptr cancellation semantics
    https://git.kernel.org/bpf/bpf/c/2b97956af608
  - [bpf,v1,5/8] bpf: Mark NULL kptr stores precise
    https://git.kernel.org/bpf/bpf/c/ecdc5043794c
  - [bpf,v1,6/8] selftests/bpf: Test imprecise scalar kptr stores
    https://git.kernel.org/bpf/bpf/c/9dcddf30ac1a
  - [bpf,v1,7/8] bpf: Preserve inner map identity in callback frames
    https://git.kernel.org/bpf/bpf/c/b90c5d770dad
  - [bpf,v1,8/8] selftests/bpf: Test inner map identities in callbacks
    https://git.kernel.org/bpf/bpf/c/e615b9fd4d9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


