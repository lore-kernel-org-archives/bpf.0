Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C8F3A4F30;
	Sat, 10 Oct 2026 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645008; cv=none; b=i4qUgv8CtOXkv5HhPiOQU+9pFXIjbFkF3RFv4y8IAo52hoJFT8vt5e4VUVFxJiDDocLwZHaS6zkbnlp6nDelYLU4e0qX9au/rE6sQ6YNCBswIuRPbJVNyxub3lCyHW0egyOHQdgYeBsO4znN/u6589teC2ZPIrOhQnrlBdqgylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645008; c=relaxed/simple;
	bh=7TzmRUknXQSJrq9WJMQRYRamiQx4i6DwhPve3C9Gzi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Few3P7A8GH/u8nl/ey7V2eIPsGqBme1g6cvLDyNQsVr8u+azmFevLcxysv3A3ejeEGDBHh/hSLf1E6OMRup6nGBgi73dD3zJKtJpQ/vKsAKL0Pm/XDhC6rDrD6Pcl0yGhJCK955z2ELt2FFEvLbVZD5OzRmLTgTVTLv19KHeIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgRvk6hy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgRvk6hy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B7B1F000FF;
	Sat, 10 Oct 2026 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791645007;
	bh=jdRqn0CteQ8ui9tg7Wb1RJhtBeZiOr+dZgR8ULZBbjc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XgRvk6hyb7XLEne/8laQzOCK2H32X7IGWq2ONyNb3O5aZ2/Ol1LlhNf9+kzwcM9jO
	 rMFwa+02/jltfu4hVpsnyzxFb2WnXzAitKGKdza8BJLXMI68yC81agWI4wJvihx5wR
	 neYxkSgVHVyPSRVkn4PkJM6Ig4ApVXLCNTA0hNHNMg82L5P3s8FXzuzELKF7+rJ4He
	 7JbwQcP9NT+eZ+abMS8B/9GcVHGdNDoTliSIuhyXqO7vfyTqrmSydZmkuRrbChFKlF
	 a8wH5Fh3mu5Ibk3Yb8lj+CCdGpHlmFUZ+Ero08agROQfhmgqFhaevfpISJ78ZCf6IR
	 00i5jLpMHhQAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F140B380DBDA;
	Sat, 10 Oct 2026 15:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] bpf: test_run: Fix false -EBADMSG with
 BPF_F_TEST_SKB_CHECKSUM_COMPLETE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179164500577.1749710.5161743070579518895.git-patchwork-notify@kernel.org>
Date: Sat, 10 Oct 2026 15:10:05 +0000
References: <20261009174755.22026-1-skokovmaksimevg@gmail.com>
In-Reply-To: <20261009174755.22026-1-skokovmaksimevg@gmail.com>
To: Maxim Skokov <skokovmaksimevg@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  9 Oct 2026 20:47:46 +0300 you wrote:
> BPF_PROG_TEST_RUN with BPF_F_TEST_SKB_CHECKSUM_COMPLETE returns -EBADMSG
> for correct tc programs that call bpf_skb_change_tail(). The helper
> moves the skb to CHECKSUM_NONE and leaves skb->csum stale, but the
> post-run check added by commit a3cfe84cca28 ("bpf: Add CHECKSUM_COMPLETE
> to bpf test progs") still compares against it.
> 
> Patch 1 only does the check while the skb is still CHECKSUM_COMPLETE.
> Patch 2 adds selftests for a trim, a grow followed by a write, and a
> negative case that keeps the skb CHECKSUM_COMPLETE with a stale
> skb->csum.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: test_run: Fix false -EBADMSG after skb leaves CHECKSUM_COMPLETE
    https://git.kernel.org/bpf/bpf-next/c/36edb1c7738d
  - [bpf,v2,2/2] selftests/bpf: Cover test_run csum validation after bpf_skb_change_tail()
    https://git.kernel.org/bpf/bpf-next/c/2e6be13e8ca4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


