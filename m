Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682210;
	b=ojTmQ47c/z1zflaMIuSjdlEgXpLjt0NJSLHW+54RrbNxmFahz+YF7iT2TK/YnPBW65Da
	 uF9t+FScXreAT3420gtWPRN5ZWu2HDjGzIlJy5/linIijH25FUmz0H8mY+DVYlLeh6LaI
	 KhMwFBWPwnBYmXEBRL8flF/HLEOhNvq4/fuy+c3ekukziXk0FaMUDp6iAUXfAP1EIHkpx
	 S34LQ5mVsPQtQsqCLTD3/rgqzHny0uHqH8ewM2AyDptAC+LxJA+iEK7PxagDeKQby4O5R
	 /FCHw/knymGQvWAAgghBN/ZaSsG1tuRzrnYTQVzaV4VQjTlAkEUAvpw7dCN7ix5nkEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=5I4qyEYssU3zNRO/FO8xvGNwCTadYFMngnpQRP9R7jI=;
	b=iAnL3FALPYOWffkVmzNPsFylWPJOHEWLCW27UqeKeKtdPWHI7Ek7fE4U5tdvf7k3lWTo
	 9ST/aaQUCRNUs8KO2UurzTnyD6miZ2YQX5m8o02EnuFS/RLw0EpoWYJysI7+XNceLh+mt
	 bpyjrv5Ek+5NAdm8q7j0kXa6fspvQBJhB2Ob4Uhkq80J6iuD5Ita+nUZTkVOLcbYqCjN4
	 H1C1WTEPJClhD/0aYfUrLtR2F/bDe0riJmFL81j0iSuNCZ19Sa5uJxR/5qU+U1uzfgiv6
	 UIKYE7s9xKohy1TOAZxXJd2GRK01ONiTreTJAm+uUinLY45rBxybbhkCrup1rm3fwRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HdNmeGhB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF4606A32D;
	Sat, 14 Nov 2026 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HdNmeGhB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D3A1F000C4;
	Sat, 14 Nov 2026 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682210;
	bh=5I4qyEYssU3zNRO/FO8xvGNwCTadYFMngnpQRP9R7jI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HdNmeGhBo75ENZCUXLxr5D9wCVO/ni6dZ69ycK+kUU0JqX+1tUgJDUr5FdoKYkdjS
	 8qX18L8s5rFGX/csebiZwqJV3GBsmuoT6f7yUerm7d3r9lucWnAPQmv0klBBKw1Mib
	 7rlLSrZiaxZlLpdx50EH3LAcX+awD31Y+TRgcLvxe161tEOkKNzt+kO6onMSDiN+qa
	 K4h2LHaD+YNDHnG7kUtRdYAiPD4CDozZZWFu4sChYnSRvhqiZUBvyWGVKc9ILvJhYf
	 mdLDkN7FA2YNS9+PV7qSQ3DScG3kCAL7u9iE2rmu/txnOB/bMDhk8IRjbJrDKy3jgq
	 4oAc7Adu4rmew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3A4380821F;
	Sat, 14 Nov 2026 18:50:10 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v3 0/8] bpf, sockmap: Restrict iter-context
 sockmap updates to sockmap iterators
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179468220878.2337414.13541371504623047471.git-patchwork-notify@kernel.org>
Date: Sat, 14 Nov 2026 18:50:08 +0000
References: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
In-Reply-To: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, john.fastabend@gmail.com,
 edumazet@kernel.org, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 davem@davemloft.net, kuba@kernel.org, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, sdf@fomichev.me,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, sashiko-bot@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 07 Nov 2026 18:58:22 +0100 you wrote:
> Follow-up to Sashiko's report [1] and the decision to restrict which
> iterator may perform sockmap updates [2]. Series started short: remove
> about-to-be-stale test, restrict updates, add a negative test. Then it
> expanded: mark bpf_iter__sockmap::sk as PTR_TRUSTED, restrict
> bpf_sock_destroy() callers to iter/{tcp,udp}, few little tweaks.
> 
> [1]: https://msgid.link/20260626205814.BAC3C1F000E9@smtp.kernel.org
> [2]: https://msgid.link/87echn2fhd.fsf@cloudflare.com
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/8] selftests/bpf: Remove sockmap update from bpf_iter_unix
    https://git.kernel.org/bpf/bpf/c/271e7fdce958
  - [bpf-next,v3,2/8] bpf, sockmap: Restrict iter-context sockmap updates to iter/sockmap
    https://git.kernel.org/bpf/bpf/c/18f6c47d1097
  - [bpf-next,v3,3/8] selftests/bpf: Add negative test for sockmap update from non-sockmap iter
    https://git.kernel.org/bpf/bpf/c/e16c83fa764f
  - [bpf-next,v3,4/8] bpf, docs: Document BPF_ITER_NOSLEEP
    https://git.kernel.org/bpf/bpf/c/c8d1abec6472
  - [bpf-next,v3,5/8] bpf: Restrict bpf_sock_destroy() to iter/{tcp,udp}
    https://git.kernel.org/bpf/bpf/c/3164b25576aa
  - [bpf-next,v3,6/8] bpf: Mark bpf_iter__sockmap::sk as PTR_TRUSTED
    https://git.kernel.org/bpf/bpf/c/dd6e63efc2be
  - [bpf-next,v3,7/8] selftests/bpf: Add iter/sockmap bpf_sock_destroy() negative test
    https://git.kernel.org/bpf/bpf/c/b7f6028a7bc3
  - [bpf-next,v3,8/8] bpf: Fix "unresolved symbol tcp_request_sock" build error
    https://git.kernel.org/bpf/bpf/c/22bc1ef8ac82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


