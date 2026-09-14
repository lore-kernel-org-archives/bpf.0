Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E303254BB;
	Mon, 14 Sep 2026 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354270; cv=none; b=lnK0+dN8N9wjWxLerBZ2GwaqdJSJVRPN0hipu6ma0Plr5Rm9C7TEJYF/vPvOQabFZTvchM1uRzkYoVbd8DP0lI+HQ/gcrU9uXYkEdVWtNTvHpOIWz09ZPpDmzSjN8mAL4oBT+VUVzQUu2/qFv94qO28xFioaLHKVaMzYWwysDD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354270; c=relaxed/simple;
	bh=F7bzAvNuEnq+mNogxT+pOEVSngo2y3Q2RChGfOJjGCw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GQoG6RrWiDSbNMzndFdVsCH6Td/G7QjEsfnqzByD9Asfy6+eeL1eP/chO1yzT43K9iTUS49o4Bt5jMwRpk0P6EAmsKVbx6FfHN6iQclshSqm/QppOltNF+CotodfqCpz0KDaBnDvl5yDqHsuqdIrwC0e1AIoWR8kCIh0Fw1ULNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSTmj0rN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSTmj0rN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35351F00893;
	Mon, 14 Sep 2026 02:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789354268;
	bh=uK8/GXlAFFEYJ1WQxW0GijkAOpsBCGEo6eS6wrXLV7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SSTmj0rNUNc5jcO8DfgzqMc+mdf4Mw2fFeThaPlbxasbzksn3sX8LJ2xlsNYAMNZk
	 wsD8EX5sWsamX43uzs9NClUzIYac0x7/z7fp9zu2G106fJjjb88pI4hx3+MAdhtMys
	 UpF7Qb7okV9q3epEJB44nB1uGqA20lMUFb6X3kHvFdUulfWgBocSjSw9F80+hMyNTA
	 BAWebVVgs/zL1sAdxuLIcRja8650VRiv9Yg6RLd3R+g8ZM9lH3232SGjCseTpyAhvj
	 UrWLn3FZty4D+kBzVUn3hJoVXtpRMLMXIa9/4ULE8ykGd+nm+gq3Bzoy0rUQCVhjDo
	 i8JBmhzof/y8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568C8380AA4D;
	Mon, 14 Sep 2026 02:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4] bpf: Fix UAF due to concurrent consumption of
 ttrace
 lists in alloc_bulk
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178935420415.291206.2678079383143049504.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 02:50:04 +0000
References: <20260905021139.4116529-1-pulehui@huaweicloud.com>
In-Reply-To: <20260905021139.4116529-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 houtao@huaweicloud.com, leon.hwang@linux.dev, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 yonghong.song@linux.dev, song@kernel.org, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  5 Sep 2026 02:11:39 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Syzkaller repeatedly triggered UAF splats related to nodes in
> waiting_for_gp_ttrace within the bpf memalloc:
> 
> BUG: KASAN: slab-use-after-free in llist_del_first+0x85/0x110 lib/llist.c:61
> Read of size 8 at addr ffff8881572cd080 by task syz.4.470/5112
>  ...
>  llist_del_first+0x85/0x110 lib/llist.c:61
>  alloc_bulk+0x193/0x460 kernel/bpf/memalloc.c:229
>  bpf_mem_refill+0x386/0x560 kernel/bpf/memalloc.c:436
> 
> [...]

Here is the summary with links:
  - [bpf,v4] bpf: Fix UAF due to concurrent consumption of ttrace lists in alloc_bulk
    https://git.kernel.org/bpf/bpf/c/1c21452d02ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


