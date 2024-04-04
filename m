Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751046F099
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271643; cv=none; b=NsOBbX6TRfw/FO6FOaKG37Zn1BgDNWOU0TqJS5dQU97lXHJGKaJOpQIEmLazOufMZ9J5JgUZmXnO+SDKJco7+Ba4qy/ObBMmCLqmxcebcQsY55BEH38TtMJuZi2dQAIdCb3YrQST9dCeczN7J2ObPfAmReaO+T4l95tih8rKWWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271643; c=relaxed/simple;
	bh=hKHWKqizuS2TSJUJJbOoFVXVv76kgP0+LLRt+/VHptU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jBKpGfcOcCiFeQcZ0KN8mfoGsqfjecLZLC8yI9hm0/9rPeXCpRJwIVxmYnHXdpurjQcoMLav1/mTwYMiPUILP2Dga9wP+v0qJIIdu+Hp6uC3LnIyBMKqfxn/qLqqWC39vrQG056uy+gpxn3Y5r8H9cLZYB+rU73Ma+Oo3y6u+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxgFHW0o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxgFHW0o"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C714C43390;
	Thu,  4 Apr 2024 23:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712271643;
	bh=hKHWKqizuS2TSJUJJbOoFVXVv76kgP0+LLRt+/VHptU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XxgFHW0ozIqkqOwDp+wWXiPKwFD2sEAw8sSpQmpB2ajBZjvmVaOLjR/MZbvQhZgcE
	 zuVByLrySNAI4HK8sHQ68CffXX7YIzenGRgaE1viPK88UpBkL/sczdIIwtgL9+OwI1
	 44cZ6nCo1jQMqkg9G9PtacF0/FV4wXgqY+vbG44uZFw513vkYyPtLF1kIxeD5ftW2z
	 q1FI2KBo7CojDDXg1e9rum5473cGBQDduxgmxUbqE3DV7/Qq4Cp8Q9nlSQHk84sSpU
	 V5kejGq7kB3Ml1P/WTZ8vsq1tydief/tYgCkEQat/TuG2t6AjK1jwVZExKdF99uRUo
	 rq97yB5VNlaWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AB5DD84BAB;
	Thu,  4 Apr 2024 23:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: pack struct bpf_fib_lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171227164323.30433.13590004188099763511.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 23:00:43 +0000
References: <20240403123303.1452184-1-aspsk@isovalent.com>
In-Reply-To: <20240403123303.1452184-1-aspsk@isovalent.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
 martin.lau@linux.dev, sdf@google.com, bpf@vger.kernel.org,
 aleksander.lobakin@intel.com, arnd@arndb.de, naresh.kamboju@linaro.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  3 Apr 2024 14:33:03 +0200 you wrote:
> The struct bpf_fib_lookup is supposed to be of size 64. A recent commit
> 59b418c7063d ("bpf: Add a check for struct bpf_fib_lookup size") added
> a static assertion to check this property so that future changes to the
> structure will not accidentally break this assumption.
> 
> As it immediately turned out, on some 32-bit arm systems, when AEABI=n,
> the total size of the structure was equal to 68, see [1]. This happened
> because the bpf_fib_lookup structure contains a union of two 16-bit
> fields:
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: pack struct bpf_fib_lookup
    https://git.kernel.org/bpf/bpf-next/c/f91717007217

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


