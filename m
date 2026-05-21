Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6425340A62;
	Thu, 21 May 2026 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357608; cv=none; b=OlaXV6WKiUENkI1hZpxhetR0PdpaydiqhreC9EVfLo61J7JlQw3VrjcJ4Gbo7SOup9nLo1lLd/UYiLee2/tj/oAOlsiKKQR7HcmxqHgd3MXNuz5D4J2TN3QOaHN6GgEi6gRtCSawyN7OsvyOubWKY4kiPgGPkXXh1PpXr7doaBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357608; c=relaxed/simple;
	bh=jdY9hs85Twhae/3vlnByBxA+RRCbVKD6yusjjOcEM1k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SXzN5ehucGPgcrRqq4x6E5jj+spt+Vc5w+WWQHyNtZ4IKolOitQ6MwsXLFXuckMF6q8MzVBx273uK7whAuQmoDmOgohu53AwkszTT1yFrPxULK/sgO7lWTpvd6mCYLn/u+VqysEbJOtgNqvErwB0EjYC3Zk/Hlq7CtHBac9mvkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzDxdjYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzDxdjYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604721F000E9;
	Thu, 21 May 2026 10:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779357607;
	bh=EYCTLIm2++uhi2F9BBgSIQc+tlzAzzrgP0ECrTYgJQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jzDxdjYWPqbUrRXYT2TuhXROt13p+lP3+YTyKEJzxdxu2Ira4qmbq+KacOFWjbIeu
	 yQUZn0pFrCwUIqzgVfcIbmULLX+VGVncJCckevSCetqyasqx8ryUWXCTHOS7jMlR8y
	 5HnUghIcVkqll0lnsRjMaHoQg8XFWFsq1u0cRNlW3QofWkH30SY2umnfXfiFb5J+jp
	 hcQBvqjaaUFbqH7vrkjDMQNPo59LJvekMiXAnvoU35A57nGj+C9MVZ1rcJiiKoX7eM
	 12/z2RMISlrXaXV0oQxqtm5NCTVsflRDG0ctgIfDXRIn1CVBUxjwHtbb0meTKwkMGa
	 jWLVlkFeqJLeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939213930D21;
	Thu, 21 May 2026 10:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v11 0/8] bpf: Extend the bpf_list family of APIs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177935761713.4009125.10546736561517078452.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 10:00:17 +0000
References: <20260521032306.97118-1-kaitao.cheng@linux.dev>
In-Reply-To: <20260521032306.97118-1-kaitao.cheng@linux.dev>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: ast@kernel.org, corbet@lwn.net, martin.lau@linux.dev,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, skhan@linuxfoundation.org, memxor@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 vmalik@redhat.com, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 21 May 2026 11:22:58 +0800 you wrote:
> In BPF, a list can only be used to implement a stack structure.
> Due to an incomplete API set, only FIFO or LIFO operations are
> supported. The patches enhance the BPF list API, making it more
> list-like.
> 
> Five new kfuncs have been added:
> bpf_list_del: remove a node from the list
> bpf_list_add_impl: insert a node after a given list node
> bpf_list_is_first: check if a node is the first in the list
> bpf_list_is_last: check if a node is the last in the list
> bpf_list_empty: check if the list is empty
> 
> [...]

Here is the summary with links:
  - [bpf-next,v11,1/8] bpf: refactor __bpf_list_del to take list node pointer
    https://git.kernel.org/bpf/bpf-next/c/cb339ac61d72
  - [bpf-next,v11,2/8] bpf: clear list node owner and unlink before drop
    https://git.kernel.org/bpf/bpf-next/c/cfa6afa4b931
  - [bpf-next,v11,3/8] bpf: allow non-owning list-node args via __nonown_allowed
    https://git.kernel.org/bpf/bpf-next/c/7c8c71591b76
  - [bpf-next,v11,4/8] bpf: Introduce the bpf_list_del kfunc.
    https://git.kernel.org/bpf/bpf-next/c/187baa10963a
  - [bpf-next,v11,5/8] bpf: refactor __bpf_list_add to take insertion point via **prev_ptr
    https://git.kernel.org/bpf/bpf-next/c/e6919ff67c1e
  - [bpf-next,v11,6/8] bpf: Add bpf_list_add to insert node after a given list node
    https://git.kernel.org/bpf/bpf-next/c/a3493ca504f1
  - [bpf-next,v11,7/8] bpf: add bpf_list_is_first/last/empty kfuncs
    https://git.kernel.org/bpf/bpf-next/c/745515d386eb
  - [bpf-next,v11,8/8] selftests/bpf: Add test cases for bpf_list_del/add/is_first/is_last/empty
    https://git.kernel.org/bpf/bpf-next/c/ba3dc064f406

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


