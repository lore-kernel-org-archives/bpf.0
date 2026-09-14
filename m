Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EDF36F42D;
	Mon, 14 Sep 2026 05:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789362072; cv=none; b=H+w0yuZH9mDbQKN68ML9IgJTTMNGXII2yLHc8EqaXg50XlY4q3F+7ITRN9hJpOTCjY0mJ+zJdWXZR1ThCWPSXuOEG1PxPth4rei12Ax3iufKDOw7J4ENH5tQo9okrC6wxIHLuroG6AT17piX5sAQl7ZxfxqdKOA0R56cLYEVf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789362072; c=relaxed/simple;
	bh=rl1Taj6AjWu6rTiKiDblKEGYsSPMRPXyhM1T3hd2MfE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SWBBpS7mmM9xBYw0tFXIRygEbhR+V5bTMDE3oSgtOe9KENyJjScFbhzL/qes1jzHIBM7VscZNN7Vbl9gS6ngi+UECVUZMRdFihrv0KUz8DklK5XpGuYURO3pRgvpdBLy7MOFHB5T4tlWvPXmcHeiPZN+7N6M8ecr25AR2TX9PvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzfrEe12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzfrEe12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FE51F00893;
	Mon, 14 Sep 2026 05:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789362071;
	bh=awjZKh7j/ZRrPK+GXT6udEHhIXB9OMAIaNBEONO6aO4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MzfrEe12hYSqbGVTplWa4njgyWOrfqH7Bu4RHAp6yEb8dnGCFMV/sLgfs+a4N7Q0Y
	 m7vjGW1XU4foQpTw48Fu9PGF2fB8rTymKQ7nYTu4GaCSLCliipPxN2LfnWwx8KcU4E
	 qjm5eaBQ7KNqlAz3C+j6Xs7ayTFFvaUBnxOqJIWqKtclQ+TkFgxTfqK21IfCYDyqML
	 tqUG5ItUIvt7xZw1Ab931fdECl0ewhSrYP9aprus88AJ6wPOyYGAgiIAv03t6M0T8t
	 ohwjI7O5RKPARbcZhh2tBsiUSx0P8SJmo8UHeoOK9yo8PQytXTXMMJFOZZ5akMgH9t
	 KBzPGYVW+KP+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AB9380AA63;
	Mon, 14 Sep 2026 05:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf,
 arm64: fix the exception callback's frame pointer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178936200639.325205.5759223935386282492.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 05:00:06 +0000
References: <20260907130624.611942-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260907130624.611942-1-donggeunyoo.kernel@gmail.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, catalin.marinas@arm.com,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, jolsa@kernel.org, memxor@gmail.com,
 mark.rutland@arm.com, martin.lau@linux.dev, puranjay@kernel.org,
 shuah@kernel.org, song@kernel.org, will@kernel.org, xukuohai@huaweicloud.com,
 yonghong.song@linux.dev, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  7 Sep 2026 22:06:22 +0900 you wrote:
> The arm64 JIT does not set BPF_REG_FP in the prologue of an exception
> callback, so the callback runs with whatever x25 held when bpf_throw()
> was called. A callback that materializes the register, for instance to
> pass the address of a local variable to a helper, then works on the
> frame of the subprogram that threw.
> 
> Patch 1 sets ctx->fp_used on that path, the same fix commit b114fcee766d
> ("bpf, arm64: Fix fp initialization for exception boundary") made for
> the exception boundary. Patch 2 adds a selftest that reaches the case.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf, arm64: set up the frame pointer for the exception callback
    https://git.kernel.org/bpf/bpf/c/ef1fb82f1218
  - [bpf,v3,2/2] selftests/bpf: cover the exception callback using its own BPF stack
    https://git.kernel.org/bpf/bpf/c/26a43a5f8c31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


