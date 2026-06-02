Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB3348C66
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365614; cv=none; b=PgDtuW/WCAA2PH7dq2fEITGwYxbta3bET/vnUiAUawQsmAgkWTBOCUENjFDSW1a9rrbucgqzpbQQ+Vub5OfzyOdeT5yIdBnkYJ70VHJEoOB5C6SegAhw+scmis0b4P42DYWEFJiQrzjrjBtYhqI2BkOIpjSliCCpvL/mKiiAtro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365614; c=relaxed/simple;
	bh=eaCGtQ5MYfPSHPSTSKtTziZ06Z/NcOjlkosfjkeSYn4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dDaGyUO4clC34bSJ0fMzO0vMk7r+oWT8pYreG5513Xk84k70O6qr9SA7SLFYHSVt/ejgaEKTpt8ogD0rHBUpmGqNfWwBaIRoCIexnvYTYAakvUmSdrQ9jn8dR4jEULT8gJ7FKg/F/+AdR9jGqesm3F86cz4Tcamxy8Q10RPhB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3c6Pl5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3c6Pl5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BB81F00893;
	Tue,  2 Jun 2026 02:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365612;
	bh=+ZIsciBFg5YdKwl4GJCZR2dJK6D2I0u+DYYJodjz31E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m3c6Pl5L5APk6MTXdsLHnpvoFZt8ITXNiPiBaGWTx8yaUCosC7XJbDOW/oFhw0FrK
	 S5WLbafUApoXSER+qPB4fFEobGiRsvf9D0ZD2uGwz5zOWkfcs9zyZ2GDBSFo0HmgAn
	 zqGSOtv2Z+MGPHuBVfK651fJqmdULeRdtGcpp3ckhI6s+53GthsYL7AJxgr6MuLAFY
	 2VHOPkwMVjNvECnDobkPIKnTfOMZnsGSQENCHCyq1UHFJv9RWYT8B14BjfX3SDS+Gr
	 XiX9Egt0AHeZ2Fa1WqizMwRk2bwvyDBOuMW9yBIoAt6owrqNqaCPfYEucCSN17wqqf
	 v/xGcoyR4TaHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F438119F9;
	Tue,  2 Jun 2026 02:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/6] Minimize annotations for arena programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036561463.203733.12496936017031738591.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 02:00:14 +0000
References: <20260602004120.17087-1-emil@etsalapatis.com>
In-Reply-To: <20260602004120.17087-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
 mattbobrowski@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  1 Jun 2026 20:41:14 -0400 you wrote:
> BPF programs must currently include code to address two limitations
> of function signatures that include arena types. First, arena arguments
> must be annotated with __arg_arena in the function signature in addition
> to __arena. Second, it is currently not allowed to return an arena pointer
> from a subprog, even though it is safe to do so. These limitations require
> extra annotations and typecasts respectively, and have proven sources of
> confusion to programmers.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/6] selftests/bpf: libarena: Add "arena" BTF type tag to __arena qualifier
    https://git.kernel.org/bpf/bpf-next/c/a0fa68d8ce75
  - [bpf-next,v3,2/6] verifier: parse BTF type tags for function arguments
    https://git.kernel.org/bpf/bpf-next/c/5ab4bc67d818
  - [bpf-next,v3,3/6] bpf: Allow subprogs to return arena pointers
    https://git.kernel.org/bpf/bpf-next/c/3e924e9272c8
  - [bpf-next,v3,4/6] selftests/bpf: Remove __arg_arena from the codebase
    https://git.kernel.org/bpf/bpf-next/c/b9b23fe17611
  - [bpf-next,v3,5/6] selftests/bpf: libarena: Directly return arena pointers from functions
    https://git.kernel.org/bpf/bpf-next/c/367e6e4a8173
  - [bpf-next,v3,6/6] selftests/bpf: Add tests for the new type-tag based __arena identifier
    https://git.kernel.org/bpf/bpf-next/c/9fd5bf96ac4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


