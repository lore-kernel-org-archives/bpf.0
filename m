Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE902233937
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498420; cv=none; b=J1wb+4Eo5BgvUeoWkpqANebHmPDddPanyXqNK7P+/b0mcOj5+bGDF1LJUOgAg0VPJt83NdmzBQrcbQjFVUfVp1qSsqYdu9n1weZVf4TZAzZyRGOo8q3fyyiXmn0Ia/qsJCY3pKTSuR8GtpRaPeUJkWQhk8hUEIEuh51f3FNSxqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498420; c=relaxed/simple;
	bh=Pm6WYlwSPoEmR1olUS77BbzRebJzSG4Eeb6pUG0Tb20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JpbeEvn9r0PPChH/HcUXrYyRLJ0wuteOika5cjjIuFDZjrSkRw26uE6jjnC+62ygorF+jKqf1ve69TFESb/m5Yk/ZmHNojrvvFi58ALA/AoK4ae7sxIZ2lIxUaORvU60AxJi8HmPxJIUkrwO40dT+LY74p21l0qrH9fzvgfDSTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch7Gw7iE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch7Gw7iE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2DF1F000E9;
	Mon, 15 Jun 2026 04:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781498419;
	bh=tT4ThXy0ovTMawgnIXx9F4iQe79FFAbw0eIy0ykOrZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ch7Gw7iElPN9qgVFM+//n5SA7xGeedWAAhxUPOCasV/Up7nTw+EYpI24vMkuNri/t
	 Gf8hvYZ2OI7ojExlCKpxE/SO7NduwG1hCda3TWeeM7G1OdGXSYSx/CUQs1NdLu06IV
	 l0cAf0semy3Xc4NXs4s2NWvcrTGDVI666XXhgIBw4mpiKbJ81CRJknHu2J0VTsO1Zn
	 eZxP30l7oxh0XlMRilEe9WHPhcmSf0Mr5iWOpGvjrHqTLeLd7ULjtaV5vZDW6sA9/+
	 iKr+kzIPX+yE0SKwVJkUJJsxjtNPC0Adpys6hJUPxvwsrcGjmGklo71vJhECi6Sbh+
	 b7syALsmuIb+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197CC3A566E0;
	Mon, 15 Jun 2026 04:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/6] bpf, skmsg: some fixes for skmsg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178149841464.2427889.2279258322725016008.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 04:40:14 +0000
References: <20260615021959.140010-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260615021959.140010-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 15 Jun 2026 10:19:53 +0800 you wrote:
> All fixes are from previous patches sent by Weiming Shi, Zhang Cen,
> Kuniyuki and Sechang Lim, which have already been reviewed by me and John and Jakub.
> 
> https://lore.kernel.org/bpf/20260610081218.506709-2-rhkrqnwk98@gmail.com/
> https://lore.kernel.org/bpf/20260520102715.3033936-1-rollkingzzc@gmail.com/
> https://lore.kernel.org/bpf/20260424191602.1522411-3-bestswngs@gmail.com/
> https://lore.kernel.org/bpf/20260423155807.1245644-2-bestswngs@gmail.com/
> https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/6] bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()
    https://git.kernel.org/bpf/bpf-next/c/0c0a8ed85349
  - [bpf-next,v4,2/6] bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
    https://git.kernel.org/bpf/bpf-next/c/f3f34ca45b96
  - [bpf-next,v4,3/6] bpf, sockmap: keep sk_msg copy state in sync
    https://git.kernel.org/bpf/bpf-next/c/2ccbc9a38746
  - [bpf-next,v4,4/6] sockmap: Fix use-after-free in udp_bpf_recvmsg()
    https://git.kernel.org/bpf/bpf-next/c/c010995b29c8
  - [bpf-next,v4,5/6] bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
    https://git.kernel.org/bpf/bpf-next/c/a48802fb2cd2
  - [bpf-next,v4,6/6] selftests/bpf: add test for bpf_msg_pop_data() overflow
    https://git.kernel.org/bpf/bpf-next/c/70b139d0483c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


