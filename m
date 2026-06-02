Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEF43195EF
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780364433; cv=none; b=fSiq8b9qjPUqWRbrfsQe8TY2NM7x/nz985B+T+GXmuFW46EtXduXBBDhHCuHztD7ANmkhnroK1h/WdiW9spnytl2fWG+vFvTLwY+8t719a4ac/Sjo/XzkLG4wCExnX0nCN/xf0breRd7q+xa7PDjCMF85YuxLDCZiMZ1YosLvdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780364433; c=relaxed/simple;
	bh=GgAYn2AecRQDQCbLRgVXtxD4+XgilkDbUZD19i1aztM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M3YDxPNNqa31UNdTwlH1Pz3BI15063cR4XUM1pudJUjFjOFyumAjdbuaZCyY6rgAP3j5v0jIubsvAGSe+HPtpMqaj3fzYjXfI0AZ4qX0dg26sfKHkRB5E3X367uuV/B72+SwYLyF8YIGUr7aOSB1cNN31l2gly9KUZCg4mDAJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsSFhhke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsSFhhke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1821F00893;
	Tue,  2 Jun 2026 01:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780364432;
	bh=CjZIHAqJYwOS5QMCoi1BMho7dLJL5weilzExPWfA7cw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PsSFhhkeTtnmF8b6GFyLoYocqosYIcBgdvmpZy+gW1ob/VUYfvvvcQPNUf/repv52
	 4cgBwbr6lsiShIHcMmoMMlBSIixCNBXwsTYmGHOgIPAikZGRcKbUaybGfVfxzFSwiA
	 MVpHXYij7+nFwPgk+FZ5QgvQ0J8kCnJj22i8O7qy28CXL/W0KIvQYI//QqXYCnu+He
	 AGuoutAK7nvfENNhPGwS/WXO5vvLO5rdbBCua1sqCPvqKkDmKzUEHfnw/Yiju/HGTw
	 VMN7PjlXdb1kMsD99KRK4JyqVcyTZGN99d3RmgtOvx2kEO5FXtolDigS6/T9Sk08bE
	 VzH3wjEZkitaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1972E38119F9;
	Tue,  2 Jun 2026 01:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/7] More gen_loader fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036443465.197970.13300413424629935914.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 01:40:34 +0000
References: <20260601150248.394863-1-daniel@iogearbox.net>
In-Reply-To: <20260601150248.394863-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org, kpsingh@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  1 Jun 2026 17:02:41 +0200 you wrote:
> Follow-up fixes for the signed loader, includes also the recent
> sashiko findings.
> 
> v1->v2:
>   - Fixed up verifier_map_ptr selftest
>   - Added patch 1/2/6/7 with a new map-in-map fix and a
>     redundant hash_buf memcpy cleanup as well as selftests
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/7] bpf: Reject exclusive maps as inner maps in map-in-map
    https://git.kernel.org/bpf/bpf-next/c/9a3c3c49c333
  - [bpf-next,v2,2/7] bpf: Drop redundant hash_buf from map_get_hash operation
    https://git.kernel.org/bpf/bpf-next/c/c48c3a7e7d5b
  - [bpf-next,v2,3/7] libbpf: Reject non-exclusive metadata maps in the signed loader
    https://git.kernel.org/bpf/bpf-next/c/0fb6c9ed6493
  - [bpf-next,v2,4/7] libbpf: Skip initial_value override on signed loaders
    https://git.kernel.org/bpf/bpf-next/c/61e084152328
  - [bpf-next,v2,5/7] libbpf: Skip max_entries override on signed loaders
    https://git.kernel.org/bpf/bpf-next/c/60214435b365
  - [bpf-next,v2,6/7] selftests/bpf: Adjust verifier_map_ptr for the map's excl field
    https://git.kernel.org/bpf/bpf-next/c/38498c0ebacd
  - [bpf-next,v2,7/7] selftests/bpf: Test that exclusive maps are rejected in map-in-map
    https://git.kernel.org/bpf/bpf-next/c/32f725458a1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


