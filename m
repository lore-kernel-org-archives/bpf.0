Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17432353A8F
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121679; cv=none; b=N+cE1sqIOS4pJtvBBTIJZmFM2WxglGsMH/0vUhSOacpYtt1gzuOrt7qjE5SF3t03hPEuaSdVNllu5X4Hkl4DF4h1skEpzyr1ubkrfL1eSj82wE0ISD2ifqetESW+4VbW3oBxDgd8x8of74xdSFM8yFA4oTaMKJgRzunayNkkFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121679; c=relaxed/simple;
	bh=wvTCO/PsnxWEkthbHeVOzB4yjCEE12St66A7FqD+BTM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=duHxjVA/xe34k2+YdcLNoIYY1MnwzNLzakBCj1AW5BkufgcuAIWeZL6xvIrJj/zDrpOwGSej5cOpjZkwk7mPvGL8jmgrW9HSxc3PnoVi/8h0mgysbYhD4PMNDg6p6iNCWALoI8W7jA9x1VH04VZHQ6tpAnnP/ZcXnW4Jx8XNlA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWuXgNzT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWuXgNzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66C21F000FF;
	Wed, 23 Sep 2026 00:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790121677;
	bh=nW27B3q26ZTroErUBMTAKif1PxKA72eLFeQNicMj4/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LWuXgNzTg3sE5P6fzH4d0nPyZnL7G7UtMYlkRSoBe4BKrIYBXzjQQwHWUQwUGVpeg
	 E2egcXEzsUBFdYwZsoFHWJqHMK6dcUycamvnmSlsq5fbqMoPfUHd88h2t4XzArstZC
	 f4OeJC1fkqqA3RZH0qZRRkMPDH7LUk4CZlnJ6rm7so6Ged7saO4d+YCyiTTvwootZz
	 z1VjRXCH6TtZT3F830HhA4NGjOlIIBC74khgLm9LqkONDnTcF8VrZlnDp3DXSVMviv
	 szeOVNwRl/dq4rhC/vZOTNT8QoilXlJDXuxhLB3ndEVWK9MWItiws+lTyHVW2Q6Jeu
	 c5jiDT5O6JWJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B193822D65;
	Wed, 23 Sep 2026 00:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Fix csum_partial() dropping
 trailing byte on odd length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012160815.137376.8756296580760668709.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 00:00:08 +0000
References: <20260920085549.867099-1-madhav.khoslaa@gmail.com>
In-Reply-To: <20260920085549.867099-1-madhav.khoslaa@gmail.com>
To: Madhav Khosla <madhav.khoslaa@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 sdf@fomichev.me, alexis.lothore@bootlin.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 20 Sep 2026 14:25:49 +0530 you wrote:
> csum_partial() computes num_u16 = len >> 1 and only sums that many
> 16-bit words, so the last byte of an odd-length buffer never gets
> added to the checksum. RFC 1071 says it should be padded with a zero
> byte and summed as one more word, not dropped.
> 
> This backs build_ip_csum(), build_udp_v4_csum() and
> build_udp_v6_csum(), used by flow_dissector_classification.c and
> xdp_metadata.c to hand-build packets. No current caller builds an
> odd-length payload, so nothing fails today, but a future one would
> get a silently wrong checksum.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Fix csum_partial() dropping trailing byte on odd length
    https://git.kernel.org/bpf/bpf-next/c/ddaa827dcea4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


