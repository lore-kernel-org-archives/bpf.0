Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08CB3BE63F;
	Sat, 17 Oct 2026 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258207; cv=none; b=WnTjbrauFcpoTzeqcjX3Mfwb1aSw2YmBRTmpsueeWsaxG6QFPsk1UQlpZvVTpB76mPAwiUw2jc1WYODEqR+c64OmWP7jYFSjPjZ8IoQ3Y5i7ep3ree4lc8f5ML9qK02x4Ct5bJY01lmdCqqfDC7qdkzCwJFIYGdbWwSxmDsXEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258207; c=relaxed/simple;
	bh=xKayjomk9GQDppaUoDEm+lh88KqoWYQ9vzQprrfDZvs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SSJmRhIezMqCzviCEMICdN9rpPga2nuryyhR9Wpb494v8Rcf0sK6LjTzm5JhiI++dVxH1RyMRH+GZDwIvFplsGbNKe7m+ggecLDCB8RXzpC9OZnxEz6BmPcAxQhSXkFxk1mRemhRecexFd/3O7/kVGZJtZkMLZ58Mu0bl9P5bcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGEHWOkb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGEHWOkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816281F000C4;
	Sat, 17 Oct 2026 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792258206;
	bh=Kl9ugjikto1ArJJxBUqnsPnROHNwYNXVHIDItV2Ceec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mGEHWOkbo0VC7g7wQRnHs2eE0ulQ7gb+niBq/5+xlEKa3Exv2a/iVyA2NrYn45VRr
	 Cbxs/4q1XlpBZgOUH/3o9DmaAuoTPO1R/OUbtGXwPVrmj0CQavMK9vUrbIt9cOKPWm
	 YlWaE9FauFkh0kNTeDPr0oHx5I7cgDn23amBjrKkRgGiSVnfGitZb6TnnalxQtb23z
	 LDokpH+nUaV+AINljoUTknjrx4M8F88YUk7anzvilu103gabRS2sgWHh4m6O6T1Uaj
	 GLQjUnO2g61x03AIyrN4lxFnQoZIPY9eYp26Gl7CVL4CxcDg5hgjy6Tm6UH//Z9K+N
	 nK3WqtjH1sMmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772B5380DBD7;
	Sat, 17 Oct 2026 17:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix verifier WARN on narrow read of
 bpf_tcp_sock u64 fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179225820531.1342507.15548197169352983692.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 17:30:05 +0000
References: <20261017143819.209510-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261017143819.209510-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, M202472210@hust.edu.cn, dddddd@hust.edu.cn,
 dzm91@hust.edu.cn, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 ameryhung@gmail.com, martin.teichmann@xfel.eu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 17 Oct 2026 22:38:12 +0800 you wrote:
> A BPF program can read the middle of a u64 field in struct bpf_tcp_sock:
> 
> 	tp = bpf_tcp_sock(listener);
> 	/* +0x54 is in the middle of the u64 bytes_received */
> 	unsigned hi = *(unsigned *)((char *)tp + 0x54);
> 
> bpf_tcp_sock_is_valid_access() allows this 4-byte read (the default case
> only checks size == 4), but bpf_tcp_sock_convert_ctx_access() only knows
> the field starts and has no idea how to handle such an offset. It emits
> no instruction, cnt stays 0 and the fixup pass trips verifier_bug():
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Fix verifier WARN on narrow read of bpf_tcp_sock u64 fields
    https://git.kernel.org/bpf/bpf-next/c/af873495cbcb
  - [bpf,v2,2/2] selftests/bpf: Test narrow read of bpf_tcp_sock u64 fields
    https://git.kernel.org/bpf/bpf-next/c/5256161e3573

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


