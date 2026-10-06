Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA53025B0BD;
	Tue,  6 Oct 2026 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791317474; cv=none; b=KrTUUaBrXBaBWI/oiR61L7egDkdpnXET3av+20b7p3P/BwO4SKrlcfm27oc4YU/9GWxLuM7J1Oy96+ttcdjwaOTOAjRH0u1VBJxn3MAO7vBOSg2seNuO2yFTWtV7tvdiS9zSBAW+ZQUYDEONJPOzMQn0GGtajut0B5psvx8/I6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791317474; c=relaxed/simple;
	bh=KEYHCtRqzTlT4CZxuhEBoHbFSPrFYsSAHLugLDMTOOM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NyHmMWMEtMQRtBMDNbfuKosG3UkjC0FiznhbtwCujEfYPW5g/BCg1QhbLH0IQIliOfw05i3r7kt8DUJWRydmChgsmTJ3hkMsKb4PudIDZkD+B5ZXsg+zJPfi6uSoqqSJcVWe4uC+HQZAP2tSYKnXjTdnW9Bl7FyIARCoh3711wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0ly/oFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0ly/oFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3876F1F0089B;
	Tue,  6 Oct 2026 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791317473;
	bh=pKROz/B/m8c1NbQhgj0V5RmwZZKqs3KliH+giSvqQlQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=N0ly/oFAa4++y7xp824S/VdlXL6wZS4ZUhpk9xvnG5/8CxNGzHixjMq8CVuK7HSY+
	 Yf+v1wSvppAzLTEIC4mbBRQ9ndo5bEHeH12ihH+swbxSL0QnDp2Zfbj46QRG2aro4T
	 94NPEMgG1trAfBv2KFwiMH3q3KsHYG8sp21nNBwIm3inejFgMwx+X8KbsAZ2L2xzgq
	 iolEcnOnRl8o5Vb+TK74EDvXJg4sGQBmbIRaRmJ0fOEe260UyzZtFo//ypigwd6ypX
	 cozZBe88HnfKD5Guo/L3tVx+UARu8LXq3i+MLweRLf5fQ93YJMAVPL5ODa6w3Ecu5V
	 E+lecPX6dxvCg==
Content-Type: multipart/mixed; boundary="===============3320775570681954549=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <72faa93630282ccbafab90b19af73aeeb9c2d4ac58b649fd7afb2f334d148c86@mail.kernel.org>
In-Reply-To: <20261006192601.1875100-6-kuniyu@google.com>
References: <20261006192601.1875100-6-kuniyu@google.com>
Subject: Re: [PATCH v4 bpf-next 05/10] bpf: tcp: Check BPF_SOCK_OPS_TEST_FLAG() after cgroup_bpf_enabled(CGROUP_SOCK_OPS).
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: ameryhung@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@kernel.org,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,cleger@meta.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  6 Oct 2026 20:11:11 +0000 (UTC)

--===============3320775570681954549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: tcp: Check BPF_SOCK_OPS_TEST_FLAG() after cgroup_bpf_enabled(CGROUP_SOCK_OPS).

TL;DR: Nit only: a comment in tcp_set_state() still mentions
tcp_call_bpf_2arg(), which this patch removes; it may need to name
tcp_call_bpf_flag() instead.

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index fa69961c47d3..5d9d3bcde8f7 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2994,8 +2994,7 @@ void tcp_set_state(struct sock *sk, int state)
>  	 */
>  	BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
>
> -	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_STATE_CB_FLAG))
> -		tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_STATE_CB, oldstate, state);
> +	tcp_call_bpf_flag(sk, BPF_SOCK_OPS_STATE_CB, oldstate, state);
>  	bpf_tcp_ops_call(set_state, sk, state);
>
>  	switch (state) {

This isn't a bug, but the comment earlier in tcp_set_state() still refers to
a helper that this patch removes:

	/* We defined a new enum for TCP states that are exported in BPF
	 * so as not force the internal TCP states to be frozen. The
	 * following checks will detect if an internal state value ever
	 * differs from the BPF value. If this ever happens, then we will
	 * need to remap the internal value to the BPF value before calling
	 * tcp_call_bpf_2arg.
	 */

tcp_call_bpf_2arg() no longer exists after this change.  Should the comment
now say tcp_call_bpf_flag() instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37521083031
--===============3320775570681954549==--
