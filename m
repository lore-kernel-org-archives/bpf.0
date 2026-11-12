Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514208;
	b=4xQ/D2BlEX15xVFCvMKWeUuh58x5Xlc3GW9K+qRmCkD8thVycM1qPq6qaeHm0hkTgJjW
	 yQO/aQrcROVPD/Eo4A9PnMjK40/hyQCKiiMj5qqAfGH4vlXu2aFGauCiZWR37JqAekc8z
	 nMQeQ8leM+WKartPmDT/61BZgrTeRYzz8bcSZwTI/kj2wN961xwXUxknqHASMVtP5ZmKc
	 PqKDL1YR2VD4ygvqkUR11y1cZ0jbB+DRtPnUGt36u56ccmktBw7aJjUOkethg8f7Wuavt
	 pEAjv1d1swNrRYmNjGOT0e/BGhx+qBsx7Zvo6H5Ee7h3zQExLxjBQnB7oW8CFyVKezg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xTtPb0mEE9NlI/iq9raPIkYpxE2ttZ6CJm6ykK0SGT4=;
	b=kmHeRCBD3h1DFBloU+IiiqqhbRYjGTS6jIWtoenBJz7fo7zx3usLuIQiCJg/avFc9+L5
	 c41JTy4DPHpksT4NNpP+AvKmhaqYdWRVfLvQ0UFpLQt0yZFUzqE9DcVv+KEN5JBi82CiJ
	 5eyXBlDdVhQcXeOniEXgqBBdhMEbU8skILRqYx977qgyNUkPYvEfpq4gJNMDoKNv9qWMD
	 675Shw8uyPbzLpaEfSgC8HtYKNRzlJH60vO59RXNyue8OO8zDieGIG323/lZKExDSzrI3
	 oLeApM2M9ow9B4eTQB1TfCktsaAvOv2963uDYX7d7z+GFzvRbPaNNeSKAnrt0i7PXJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L53KIXWV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF2606A321;
	Thu, 12 Nov 2026 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L53KIXWV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826731F000C4;
	Thu, 12 Nov 2026 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514207;
	bh=xTtPb0mEE9NlI/iq9raPIkYpxE2ttZ6CJm6ykK0SGT4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L53KIXWVeFl63wPoKYO2nexZFMi5TbtKMdbxl59FNO0igYjHSQu9Tr/T+cxZsZrOd
	 lfuoIc0Tv3vLEAiUdUcaBkKloAbqFIqmySKZaTEhRttZLWYPcJo9vTULOcDVcLOwcj
	 slN7z/5Q+fREQakUoIn8CPHhfD6zNRUWDurWVB/CyBZaL+3GuTmgFNNy0HZEjUk0OV
	 OtOoRycYNXXXg8HGOSnEpDZcji4DTat1Sr6IknMPtqKeN0n72zdj7xtTEX0RpJPUHu
	 bpEbU/8iUQfp+0EPwdZY5hFpNgHsyZ9ZNj2JfcRzYtGPTLmYevUl6ORtCYAtIdR2Ca
	 SeDhO0cqZbaEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 776EA3926259;
	Thu, 12 Nov 2026 20:10:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf v2 0/2] Reject writable map iterators on read-only
 maps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451420628.625762.2223208572511592827.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 20:10:06 +0000
References: 
 <LO2P302MB0197C0434BCC2A9031E99A18BC702@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
In-Reply-To: 
 <LO2P302MB0197C0434BCC2A9031E99A18BC702@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
To: Adethya Srinivasan <adethyasrinivasan@outlook.com>
Cc: bpf@vger.kernel.org, yonghong.song@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Nov 2026 15:54:05 +0000 you wrote:
> Reject writable map iterators on BPF_F_RDONLY_PROG maps and add an
> attach-rejection selftest using the existing array-map iterator.
> 
> Testing on x86_64 under QEMU:
> - Kernel and test_progs builds passed.
> - Six selected bpf_iter subtests passed, including bpf_array_map_rdonly.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Reject writable map iterators on read-only maps
    https://git.kernel.org/bpf/bpf/c/e536074468a2
  - [bpf,v2,2/2] selftests/bpf: Check writable iterator attach to a read-only array
    https://git.kernel.org/bpf/bpf/c/e1224c9a9053

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


