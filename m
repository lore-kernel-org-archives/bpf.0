Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDFF38734D;
	Wed,  3 Jun 2026 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526405; cv=none; b=H5HaaTHStgifptsJUKrGdo2CkXLrH4+WnUscmjiMZmZFvwaZbfRUQWAnSopPXywk3rsw3Ex6+Q66ToC+qeR0jjps+invhUxqOQo4iZt1XvHrHtKWSbF1kqgOxtBs/TUvjdVv6KfFG5eOcJ0B2X++bALy53zbvbbFwGAvQGicNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526405; c=relaxed/simple;
	bh=nFU9EhmNQ8PaOD9cBPNinJjobmGCvJFdR+gJXpAuGsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CAZoYT48xNIOAUxgeAH33w9cnV/9oYx8yEHcyKRGSmFBo+lNeRw29HJiRWDN1ipoWGrRotAbVTPxneXkTH/Hl3hcIwloX57qvkt6ngP4sA4yo+Diu4Fsb9RtvXjGTLun2/gCDECYzwWr6LjwKUEBOxX/JFEgspgYkrbYc076JWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iq6j6R02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq6j6R02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB3B1F00898;
	Wed,  3 Jun 2026 22:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780526404;
	bh=Myoc8QcvzlQe6lJFo+QWEPMjs9WZUygm9BGlI9+LJo8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iq6j6R02YCERblWQvwQRU01twKTUSKm8L2sDZPDuedmaelhFNnhd4tC8bglRORUQN
	 Ig4tQxbzcOhN4ICe7XUuYSYk9IovLb7N4DE8elqnOEtTmJxuAY4ibH0pkjhiiDDYGA
	 0JblkaUloGiqrGRpiOue+WUUkJyUSJpA7WgiQIfNpOGXgTR0fNTT9CGSwdy+87fgmi
	 SpjwUIZBYDHbsgm0jQw8yHnjlVHvRleTnfuVun0Xj1nGxhw/U8QRXuopBPxhKAMqcn
	 hDAxDh5tfFWaZB8qbtwV51sKR0oTU0PpdNn0RjgigOmM+NvEKMxN8XRuxsuYWu/ons
	 JMN/29c729ESw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BF99B39308DD;
	Wed,  3 Jun 2026 22:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpftool: Use libbpf error code for flow dissector
 query
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178052640576.2032852.14873699170740166631.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jun 2026 22:40:05 +0000
References: <20260603003339.33791-1-random6.xyz@gmail.com>
In-Reply-To: <20260603003339.33791-1-random6.xyz@gmail.com>
To: Woojin Ji <random6.xyz@gmail.com>
Cc: yonghong.song@linux.dev, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 jolsa@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, memxor@gmail.com, qmo@kernel.org, sdf@fomichev.me,
 song@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  3 Jun 2026 09:33:39 +0900 you wrote:
> bpf_prog_query() returns a negative errno on failure.
> query_flow_dissector() currently closes the namespace fd and then reads
> errno to decide whether -EINVAL means that the running kernel does not
> support flow dissector queries.
> 
> That errno check controls behavior, not just diagnostics: -EINVAL is
> handled as a non-fatal old-kernel case, while any other error makes bpftool
> net fail.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpftool: Use libbpf error code for flow dissector query
    https://git.kernel.org/bpf/bpf-next/c/8a7f2bff2165

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


