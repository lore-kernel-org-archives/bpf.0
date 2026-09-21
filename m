Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5CA5218A3;
	Mon, 21 Sep 2026 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030220; cv=none; b=ftBzmKWUOHBEameCV0d8OxlUrl8e5o+I1TkBNnJGnurd4bmmWH6qYgTT4x5aNq59WmgIePJkqFPYJZWFpLoYxp1JOt3wG5CcGlwYbKpHm0su8oFt9zaOmTh/rC+6se4eBzAoMNXQZtMjQNNcc7P29FNi+BCBXQMIEJMI7NTJ9do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030220; c=relaxed/simple;
	bh=uvWdK8NfQN7p9IOprPpFwqlWaTuJKOV5OuP7m5H1fmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D0EwQmctH7rsG6jExJrGdtZQW0T7RxrvRqrgPg+YX3RuCTTB4UotzOaUyBmh7vfbqAzpmTpvID8g7EcIwPdr7zfL6wFwZWK9Firvd106/Lt6rZsWDzxyqNONZxebF5Ydg0hGgfmeywbfnY/SETX5tSJIcuawCwEjPI+Z/cW3IqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfPkYh0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfPkYh0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E221F00898;
	Mon, 21 Sep 2026 22:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790030216;
	bh=zNg04sqksHPmSdtRgNN4hiYfNLV1OdWfT8Tgixz7/RU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hfPkYh0UxDSaGakSKQwurqo+Z7F5p5yb1NUe0TCBMn5iHyoZvHfj0BARyXafoeIPp
	 Qf7ZsYmEHObcNUsfkLc36cx4blhSvaZKcN2Bubb/kaTbXShhGKU04abu19uRzb6lXf
	 IJ7l1Xpi3Ym6WhR0MsslkDtCjxg139oQHheDXuZWiM5E+C0E064EsDPm+NxND4HRL9
	 vcNyT6sH+q8w3r1ntVkv010u8bVxAzDApQzwolwP2M35NqxNyIBzzh44nHaY6djT4q
	 cPcY065vYkt/d8WOYUifFVMxzhTP+A9OR5AthtkGvJu7ZuT8It9DMhgkWty3r7MxDf
	 qXpYTJHXl8g/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A333927206;
	Mon, 21 Sep 2026 21:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpftool: Compute map size of light skeletons
 at
 runtime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179002560916.3241479.13976100510316448696.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 21:20:09 +0000
References: <20260915161450.96249-1-leon.hwang@linux.dev>
In-Reply-To: <20260915161450.96249-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 16 Sep 2026 00:14:50 +0800 you wrote:
> bpftool rounds memory-mapped data map sizes to the host page size when
> generating a light skeleton. The generated code therefore uses a 64K
> mapping size when bpftool runs on a 64K-page host, even if the skeleton
> runs on a 4K-page target. The target rejects the oversized map mmap(),
> causing failure of loading the light skeleton.
> 
> When try to run 64K-page selftests on 4K-page VM, the error message does
> not provide the reason about page size.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpftool: Compute map size of light skeletons at runtime
    https://git.kernel.org/bpf/bpf-next/c/a885470df10b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


