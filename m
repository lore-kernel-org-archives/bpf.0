Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831B347BA9;
	Tue,  7 Apr 2026 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574029; cv=none; b=apjUkpFS03uOvKzOf+ZvQhoUzAPw+xDbjhGJT+sXX08Efpw6PROgeapQZP8BCDQp9QH97n8mYEoQbelsPcIa6xrCeUA/RAu10GRXdzl/lYWHmbfIQnXhXGJ/MY0gDhmu5J1zOCVglgUPByAIoy24lH/ug4cjNNs8K616/DB/8dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574029; c=relaxed/simple;
	bh=3UBEH7urcXf3sL9DrPFQzzhBgO8+5570mkKBeKeaibU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l0nNNzIPqM7DglVsdKagczPobKlggH6K1LWSv94l8qol7yEePgPD1WJY88Z2CJ3XKoB352PPlLGB1fYmxlxvSWvcZG7wtsEpdT1K2gDqtggwMBhBUblGWIJ0mMZKd9hOUFp5XQfJINx1t5sQsQrBme2jHDQuthSUCK0HasDk+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRhcbNLV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRhcbNLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B30C116C6;
	Tue,  7 Apr 2026 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775574028;
	bh=3UBEH7urcXf3sL9DrPFQzzhBgO8+5570mkKBeKeaibU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bRhcbNLVouDRGANNDhdKXptY3+fuFeYqVpr390hGmeSpIA3XVeXGoPPoWb4LW/HDh
	 EBKy4/JHvT9sYHzQQAX7MBR5hVqAiCWll/B89rQW5g6XFwcbeUn7Vlgq32Quf21QFe
	 3KEUBhiHGqD+4n5KQ5ACzirN5jXUFkYt0dNampLTnt5naYqFpd8msbhRHdM8sD838M
	 OPCr8HvH35rAyPoXr8k2sU4hSoSJo6X7jno9Oy5DnzgzdorOSpjFbMwJx1HR/reKzP
	 t3LK8kEF1AnCVZmQSbqc+ydyHfcNxP0YwYc1AZCLjbDfJ6zof0Z7jwdJwR604UDVMY
	 agFGxovjJF0uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F013809A2A;
	Tue,  7 Apr 2026 15:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Drop task_to_inode and inet_conn_established
 from
 lsm sleepable hooks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177557400630.4024708.9635186393779985602.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 15:00:06 +0000
References: <20260407122334.344072-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260407122334.344072-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, 2022090917019@std.uestc.edu.cn, dddddd@hust.edu.cn,
 M202472210@hust.edu.cn, dzm91@hust.edu.cn, kpsingh@kernel.org,
 mattbobrowski@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  7 Apr 2026 20:23:33 +0800 you wrote:
> bpf_lsm_task_to_inode() is called under rcu_read_lock() and
> bpf_lsm_inet_conn_established() is called from softirq context, so
> neither hook can be used by sleepable LSM programs.
> 
> Fixes: 423f16108c9d8 ("bpf: Augment the set of sleepable LSM hooks")
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/3ab69731-24d1-431a-a351-452aafaaf2a5@std.uestc.edu.cn/T/#u
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Drop task_to_inode and inet_conn_established from lsm sleepable hooks
    https://git.kernel.org/bpf/bpf-next/c/beaf0e96b1da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


