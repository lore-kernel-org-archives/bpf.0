Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794635410;
	b=LXF9/2cuUWFQ5YpWJkji18lOhOEIYjAYfC2dRZ6SQtH45/YpFO8Cq8LOA2uLe88xPkUh
	 5+N5D3v3Aa4nhxTR+Lv1Zv41clShKBGsdmg6SOPfT7as4f/Koh9XEZMF+Gl1fN3bbFlHX
	 GZn6WZ5jWQm6KysYr+Hj5p5FQSVIY2DQqe2M80LV3xU3YI1MRkbJ32jjxukWm1g27+7QY
	 OfQJaU1jEAVkwkqjaP6sulCNG7VEsa8N64LWZPbk0yRJF94lq9DPh3kDE11nkR+7ONv4o
	 82CR21OqXaIX1TOoBydBs/SfAw0My6A2sxxDelpSHOYhn349i1DJ2hV3CGbGACMg2GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794635410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=XWVgwGQzf8wAAGmnZ/PVxGVaSsUR0vszwwFa0wQiZ+g=;
	b=O31UI0xNk70X2W1Yc1tXI9+kE0d47SG0F4lTf13wcJ9IRu2uGs2dakdJxwRY+StNP48j
	 1eslznkrAt15PNrsAgyaFygQNRr6wYwhl+jaJV3kymQneSerkHqwy8KT1RI4w4rA5Psoc
	 xo2ZkiNi264QWTUFg80p0dlzkyDHsfl1FU5VKpJnUr5nTjmkrRjskDjPy+H2qQNkD1RKV
	 9nM7E7tLthKF8HX9iJWnZHhFMVLbOlF7imWNPqE4H7xAXgtcJaGhlNmLpRmtEnMQnqQiS
	 RQ6VZ2Blu3N0vTWkkdbZFaLATWQS8I/J//KU3Gf32FhJqb4DZ0STb6TpL4tkfTdC7EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0TturfJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9BE606A329;
	Sat, 14 Nov 2026 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0TturfJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3231F000C4;
	Sat, 14 Nov 2026 05:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794635409;
	bh=XWVgwGQzf8wAAGmnZ/PVxGVaSsUR0vszwwFa0wQiZ+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M0TturfJhUM1XWILl3PQghf8tKiVDKe3u8mymLBpcqS15Ct7GhEFTXzytWXN001iT
	 wtmVJmDu7TD1OUR2YPxAoLx6XjMs0weSWZk1Uv+PW4i1iLXc1WtnOCBulEEpTq/t+l
	 hB6j5wrRdD70GcEizw28t+UsYJD7GdAvBm0HBs8yEYUL2vtRjuaNZtoTvp+0lJrql/
	 3CH1+Cp4idoAquMg/jBLDZQuZuzmNfG9kwa9wEZD5FyLuwYHrS/KALpiLEaDERvXFM
	 7wLCrOOpK/LLWYIO7eqdLgQopwlkS/X30N6Wx0kKp4zQL5K8UlLBYNtcF9ICD40a0s
	 p6zHDEoaUPq5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4461380821F;
	Sat, 14 Nov 2026 05:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/6] bpf: Scope callback arguments to their
 frame
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179463540853.2020591.2042038015508230998.git-patchwork-notify@kernel.org>
Date: Sat, 14 Nov 2026 05:50:08 +0000
References: <20261113213921.1646681-1-ihor.solodrai@linux.dev>
In-Reply-To: <20261113213921.1646681-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, ameryhung@gmail.com,
 emil@etsalapatis.com, npc@anthropic.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 13 Nov 2026 14:39:15 -0700 you wrote:
> A callback-calling helper can pass its callback a pointer that is only
> valid for the callback invocation, and the verifier has no way to
> express that lifetime.
> 
> Two helpers need fixing:
> 
>   * bpf_user_ringbuf_drain() passes a CONST_PTR_TO_DYNPTR over a
>     sample it releases as soon as the callback returns. Saving this
>     pointer in callback_ctx leaves it pointing into reused kernel
>     stack and allows arbitrary kernel read and write since v7.3.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/6] bpf: Share map-backed callback register setup
    https://git.kernel.org/bpf/bpf-next/c/acd250fab540
  - [bpf-next,v4,2/6] bpf: Rely on callback frame initialization defaults
    https://git.kernel.org/bpf/bpf-next/c/9c8582c81b7a
  - [bpf-next,v4,3/6] bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
    https://git.kernel.org/bpf/bpf-next/c/e559d46c34cd
  - [bpf-next,v4,4/6] selftests/bpf: Cover the user ringbuf callback dynptr lifetime
    https://git.kernel.org/bpf/bpf-next/c/f4e3977ba0f7
  - [bpf-next,v4,5/6] bpf: Scope the bpf_for_each_map_elem() array key to the callback frame
    https://git.kernel.org/bpf/bpf-next/c/3be66bbbaa7d
  - [bpf-next,v4,6/6] selftests/bpf: Cover callback-frame map key lifetime
    https://git.kernel.org/bpf/bpf-next/c/9f2c5a659f0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


