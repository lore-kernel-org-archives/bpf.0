Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AE493D30
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873439; cv=none; b=GUNHRILzdMCa6ZvQoTwCK7qMj+zqvMbzUjU9J0HBvOCpRBpii6nG39E3jTu5+kj6l7iVRdL/JYSufC8+nEdpmiowiifbssTYfUD3S8v0Bes1fbZFbFYsKiAsgEXifIxgSdGFX8vPJwgq8uTJxZEZjAz7G7cuPS7vjdcMolvv1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873439; c=relaxed/simple;
	bh=STrP67fCTM6Fn0OaDUEN/aMEHCedSFumJ1p0QbAovYw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AOK4jHxR1XCML+na+WAH6VOMvRJqbCDvgEC72pcA97hcV8iTuVXCPTnt7dMUe0Z2T4tkoMLLNrrDUsGKkBQzkd1WjUO3ZjYRlo/eqxMUiVRtFyec+yAqwaDcOTQT3z+D3ZkKJPfWRiws9JzDTCrLQlVyH3O3fNQ+4TyE2Cdqf5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anXOzyl3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anXOzyl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EDF1F00898;
	Thu,  1 Oct 2026 16:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790873434;
	bh=e0NHIY1OLnmuiaBslgL6TBs32jE3bMsVjQwUXWoIrbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=anXOzyl3DRmdoIQHqpUEqmzCFnStA73lwf5DhHDERzdBwsyNJhGQRHCzNMsUZWs9l
	 5/d34VYwJ9WDLx0lr61z+EY8EzUT3e2u1iMGr5DyqjkHbwLk6g2Qi49vigXS4GDYDs
	 uqQVN/0lVeflsUWkr+BHc1KTjCJcitgRtvpTLq23UgBuJj3IdC4e5igI+lpgh4qr+g
	 +c94qjlo76WNI1wiphFE/We9nXFV7JJjaZKsLvSgtYmR+7gUNf6hoMcxR1oNWE00Hh
	 vhLMMaUrZb5K9Us4olNxlo6Jq8NO1ibOvZrl3aZmIdEMVkwryG7c9kM1KmhzSu9+/C
	 OgdEkPUe/3x2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2BE3811960;
	Thu,  1 Oct 2026 16:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Fix packet range of pointers sharing an id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179087343276.3011010.2529405625402472129.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 16:50:32 +0000
References: <20261001145255.855630-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261001145255.855630-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu,  1 Oct 2026 14:52:54 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Since commit 022ac0750883 ("bpf: use reg->var_off instead of reg->off
> for pointers"), find_good_pkt_pointers() sets the range of all packet
> pointers sharing an id from the umax of the compared pointer, and
> check_packet_access() requires umax + off + size <= range.  That assumes
> the umax of two such pointers differ by exactly their constant distance.
> reg_bounds_sync() breaks it when var_off tightens one umax and not the
> other:
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Fix packet range of pointers sharing an id
    https://git.kernel.org/bpf/bpf/c/b88822d2584f
  - [bpf,2/2] selftests/bpf: Test packet range of pointers sharing an id
    https://git.kernel.org/bpf/bpf/c/33a154a96e71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


