Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892A3F54AC;
	Fri, 26 Jun 2026 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476889; cv=none; b=ixL9JbGqH1o9n5Pc+9eXvHZUeFPfoArHDKmD8nyep6XDRoeojHG9/wyEbYHhMJHrdW4idzFH9BDAcAivf9iZsn5Bav6cVPJwMqSwUeCDbivUhM6zL26gjlHzcH5Sx4VL0npH9n/ZvO02Xj4hXRctWjLso4m2EToXsNubTHKku0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476889; c=relaxed/simple;
	bh=koirBBT/qK2A9zaDXwaGZPBcn7D9UGYI9QUQHY8zqtg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o/SiE6jiRVGq5mGkRE247mvPzsOhhc9GjXnt24wtMEBx+pwW4PcBnMwEfbnQxf/IevC5IxUqeK7iJbHBRDE1qmNAo8xXId78N6f9jzLi0J7NCq2Vg5SzGckucrh3+HsUOYb4c+av2VrlE1qQe/38/mruSDWzapxcPl2rdV8Io6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llGw7a99; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llGw7a99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CDC1F000E9;
	Fri, 26 Jun 2026 12:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782476887;
	bh=1JoY8aAZ1FpJcQAZiSMr5c9UvyVZ2LMJPzXpbzCvMYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=llGw7a99nz3mOvWfrA5TTxzCM5nSwx/FZycLp88XIyIXSTm2fmXWQohxIbTlo4M8L
	 rJXlZe8et+Bx9pKXBt8a2r8629IXcnRNt/8ortATwO6655UfXkAR3iu5Re7udBSjlJ
	 NMIRu9bThLW8rQ1l1wSGno8WpUvpS+KiSJz2M35XnG2LArtT+cp+YkfhgPpFjePjKV
	 pC4H44dp4VAQ55EzfxtblGLoZpccSG664uX5CHIOqywDdH5F8TSiGwlak1UvPonvNO
	 h7+zdb9JBaQI38Ge7yaqN1kObEszXNLSz9wB/by5dGVRBkpU8/J4l7QzkCeH2yH+YN
	 vrAy9SrWe/rfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD839389F8;
	Fri, 26 Jun 2026 12:27:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] bpf,
 sockmap: reject a packet-modifying SK_SKB stream parser
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178247687401.457674.14278516857626852476.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 12:27:54 +0000
References: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 john.fastabend@gmail.com, jakub@cloudflare.com, eddyz87@gmail.com,
 edumazet@google.com, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com, horms@kernel.org, shuah@kernel.org,
 jiayuan.chen@linux.dev, bobby.eshleman@bytedance.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 20 Jun 2026 02:44:15 +0000 you wrote:
> A BPF_PROG_TYPE_SK_SKB stream parser runs on strparser's message head,
> which can chain skbs through frag_list. A parser that resizes the skb
> frees the frag_list segments that strparser still tracks through
> skb_nextp, leading to a use-after-free.
> 
> A stream parser is only meant to measure the next message, not to modify
> the packet, so reject a packet-modifying parser at attach time.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] selftests/bpf: don't modify the skb in the strparser parser prog
    https://git.kernel.org/bpf/bpf/c/22a0cc10dacb
  - [bpf-next,v5,2/3] bpf, sockmap: reject a packet-modifying SK_SKB stream parser
    https://git.kernel.org/bpf/bpf/c/31e2f36d3821
  - [bpf-next,v5,3/3] selftests/bpf: test rejection of a packet-modifying SK_SKB stream parser
    https://git.kernel.org/bpf/bpf/c/05fb34384d20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


