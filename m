Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760406;
	b=1FXrNt7kIn3QhDhX9dSUheAGd3rzIHJB38s56SIia+oqiMs5GkpK1DXk2FyO8dqF3R6+
	 IL2c9MusiB031IXvh/PCNP9W0TPXXjT0MMhL0VwlagmVDmrnaPrOoFJxtLZI1FohI1o7B
	 7eRPSSF4Yo4LPCc7AdRmMVCkM1PfsSyi40p4AA19PiY0XyCDD0rhYUNjsgUloQMo0xBDU
	 /SilQ0VL82ktpW/uF1GK2L16qa2YZ2nAIegef+bMKhkthUdDCpN1+hFCqQKc1eiOnvNfl
	 rBOBZlYH/6UP0TLddnI836slqr26p0oG5o6XPhhzKuwA66yK3Pko5eYl+bJMJ7pwDrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=5XcuTyDwg/MEDvXo1mNORYpYATakPkZce3MDDEj6eNg=;
	b=Q6YWZXlxjfjPObHicY95I/PvYLAq92MLZzALq+Szw34fVvgbKCDZ1QfI5V+E8+HYC2w7
	 T13f1/QmRlb3WUUEkWO5nsYWyZWrVGkqLw7s0Sa4tqqG/6ILNICJVXaosl00CloiHyXl8
	 I2XH0GLVxMXksunxlpjr4bOgcFEot9MKV2UHXrizd4Ji6/g+Ym40gew1mctX6RHPYjC2d
	 LvSbHJzePiNYFby9RBhH4aHpqSAoTRQD1tkUg43XH9jsuX6OWfmt/5YB8cVcjyI6tRf0k
	 x9nTCbo1Yo5PTR4SbLquIJy6Pf7x3DURF2u8TYFgY6+832xsXZfj+vB5ttSDSv0XE/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h/JcxjDu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AAC606A31C
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/JcxjDu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019AF1F00898;
	Fri, 27 Nov 2026 06:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795760406;
	bh=5XcuTyDwg/MEDvXo1mNORYpYATakPkZce3MDDEj6eNg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h/JcxjDu45mAacvrgali8EQNc6rzXI73KV1OoJSZaqOMvMlEsXs12PEgNO2ZcbozH
	 uUJs1+TnfVz9hyT36lFszfw46oAx0N6q6WSobK8SSVv4sexai1o0WLd9rnr8iYYstm
	 7z4DM9krKJ3hhW6qE3OSAufVLugbCAfSGici7cX4pRUTw4zJ8/4izeMese7ZeZry+l
	 D2JhhNMZ+Knl/jDdSAGmEsmBCJm4ISDHyn4Dy6x3nePny4aKfvGmHia6XBlIj9EiuZ
	 sl+P0SNjqp3wewPTXkfV8bsn8dhhjnuTmXUSAqTajU53BKE0y4m1YyCV79lz5aawnv
	 pCQULTSUivsxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8813803232;
	Fri, 27 Nov 2026 06:20:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf] bpf: Set the run context for async callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179576040475.781390.18065692189241483869.git-patchwork-notify@kernel.org>
Date: Fri, 27 Nov 2026 06:20:04 +0000
References: <20261126033114.4111944-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261126033114.4111944-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 26 Nov 2026 03:31:14 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> bpf_get_retval(), bpf_set_retval() and bpf_get_local_storage() use
> current->bpf_ctx, which the hook sets. bpf_getsockopt() and
> bpf_setsockopt() count on the hook to hold the socket lock.
> bpf_sys_bpf(), bpf_sys_close(), bpf_btf_find_by_name_kind() and
> bpf_kallsyms_lookup_name() use the credentials and the files of
> current. An async callback runs in a timer, in a kworker, in an RCU
> callback or in a task that the program has picked.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Set the run context for async callbacks
    https://git.kernel.org/bpf/bpf/c/02d3452bdd80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


