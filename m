Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5A5326BF;
	Tue, 22 Sep 2026 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121089; cv=none; b=kwzrYCnMYNHwSAgPaaU35A5eRqc5GYjSlt+C1TDFxmkpwv5lfumYnJ/UJjSfh431luTu5Krk0Eew4M67/PVi/Tzsj1ruDrPxgx+6Yu/xgkaF9ki6N8JkjwGKdIyNt/vMjYUW++8zV5thk+tJkZl5/o19bzjP45w6hTVsNF8xEDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121089; c=relaxed/simple;
	bh=LlGSkpwbyugjR99XkQu+pVMzwhYEmclRlaK9SvNY+HU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V9ggjuJ0bOvbZVhd/T2oh8EbprDBH+Q8giiOePJdRsfbTDpvnbR9Ht/lJGw6rFzcYF3AmDV4bTcnOuCSuh3UuDxKEUc2xxtcjYeu8KXxWDaw8tglPoSt366hbJwGTFxHos3KhDubHqZT4FnBcPjYEnCCWBHC9kPx70zMi87hCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6qIyUxy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6qIyUxy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61D61F00893;
	Tue, 22 Sep 2026 23:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790121087;
	bh=7BMGuvL3UFn1iVFtpzaUOONIrPrX87iLGVn/0q1dW7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n6qIyUxyDVppZj+Kl2dA/gqy83mkEVUncNHJOEdEzt0uH8r/mKiZ2zdg0pqZC4lZc
	 wJNf9UW1V/BCDD2Lgsuo1E5++vAV81HgUJU7+rhzAjiv+q3M3q+JgdpmXGhSgTn0Z4
	 x5jNmCaq0dN63ePbmj7o0826HySwgF8nVIyO4u2kzqfdwoVm3jRXPfMk7xyooE190h
	 cJcbjPAyA6IofSvNYx1ZO13cL4IpEQD8kRe2KQzF+kPINijiVSHAirrehHs5FcKW0U
	 lvUlHCA/jz4QWhRuKPJnvSDWJoEFnvXbt0/DowxY5eDbMpEGVrhhzwlUZg9fS8qQ8W
	 5dN3yV5vTDMMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A483822D65;
	Tue, 22 Sep 2026 23:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf,
 mips: Add BPF_MOVSX support to the JITs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012101814.134796.2287786050720557901.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 23:50:18 +0000
References: <20260912041220.444715-1-main.kalliope@gmail.com>
In-Reply-To: <20260912041220.444715-1-main.kalliope@gmail.com>
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, johan.almbladh@anyfinetworks.com,
 paulburton@kernel.org, tsbogend@alpha.franken.de, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, bpf@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 12 Sep 2026 00:12:18 -0400 you wrote:
> Add the five MOVSX forms to the MIPS32 and MIPS64 JITs, which currently
> emit them as ordinary moves. Patch 1 factors register moves into helpers;
> patch 2 adds sign extension.
> 
> Use seb/seh on MIPS32 R2+ and doubleword shift pairs on MIPS64, where
> normalizing the source for seb/seh would eliminate the instruction saving.
> The MIPS64 sequence also matches GCC's generic lowering [1].
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf, mips: Factor register moves into helpers
    https://git.kernel.org/bpf/bpf-next/c/86187bd3cd5a
  - [bpf-next,v3,2/2] bpf, mips: Add support for BPF_MOVSX in the JITs
    https://git.kernel.org/bpf/bpf-next/c/07ebb8c386d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


