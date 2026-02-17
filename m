Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5322218ADD;
	Tue, 17 Feb 2026 00:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771288525; cv=none; b=e1CNt1txacPd0THOcUMpfLwyJ5OOoZM9VE8TLjvcyFwk16Df02+L+e311myfBc7AyfEQv7pq8CxrqbQoUI64KP76uqN56nT+yKfz92rOkTH2yV7z9K8ak24EtJTJxx2vIhUXe+AP2pGt9ylFurb6r52FBBJxD4ya+4IJZcJK99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771288525; c=relaxed/simple;
	bh=cifugiWI+DvwJnYavKdokpcMDJ/GQ71ckZHXUJVVCqI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=catm6mVzNZpkg9dp3u/UjdRXrX339SvWETHxHRT0slOG3XspToZmJq5empCv6mqO8tyDbxBMDxlYtMl8ujhLP35ty1Lhq++3Jw+lGSIYLRe9kJvy2sFyXCrQgcKIoxzjjzb2XC1mdAVdfLW+cgwrXUK1bU82FgJ5Uy+iLn3FV8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWhipd6s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWhipd6s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BD7C116C6;
	Tue, 17 Feb 2026 00:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771288525;
	bh=cifugiWI+DvwJnYavKdokpcMDJ/GQ71ckZHXUJVVCqI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IWhipd6s0GYqoHym9we+k7zFe4q69hnLe9yKjF7jss88I0k74tNaa+zvU2aW7HDZr
	 SZ8pbkctjoQhc0uOg5qdBcZgbbC9Jrk1wMGqZJJuQejsp5qswL3Rlq2i9tTZiLsiij
	 kmJScP5jXIFgynhXTOYbVvldF5dq0qsJWAIENEgCPLdewWiVdpKsH+6zPuXw3peNgH
	 bkS4IL3uUGzWtrHRiNYEkM6kUEi6ZMCHkgoBNzpECpKOfewCdeSB1e8OU7pYYKFzf1
	 QgLe4J4XFknf7sAGNBkaNS+d1rIFAZhyjRJQAm3T/uG5OMMeywgw0aN83JxxjDbzPU
	 KLcUy94XqF+GQ==
Content-Type: multipart/mixed; boundary="===============1222204316904146046=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <062f4372a96b902640c4bd217f48dde8bd54c82a6b54f5582fbcbffdfb8bbfd4@mail.kernel.org>
In-Reply-To: <20260217000701.791189-3-kuniyu@google.com>
References: <20260217000701.791189-3-kuniyu@google.com>
Subject: Re: [PATCH v2 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,john.fastabend@gmail.com,jakub@cloudflare.com
Cc: willemdebruijn.kernel@gmail.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 17 Feb 2026 00:35:25 +0000 (UTC)

--===============1222204316904146046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/sock.c b/net/core/sock.c
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2673,8 +2673,12 @@ void sock_wfree(struct sk_buff *skb)
>  	int old;
>
>  	if (!sock_flag(sk, SOCK_USE_WRITE_QUEUE)) {
> +		void (*sk_write_space)(struct sock *sk);
> +
> +		sk_write_space = READ_ONCE(sk->sk_write_space);

With the reader now using READ_ONCE(), should the restore path
in udp_bpf_update_proto() also use WRITE_ONCE()?

net/ipv4/udp_bpf.c:udp_bpf_update_proto() {
    if (restore) {
        sk->sk_write_space = psock->saved_write_space;
        ...
    }
}

This plain store can race with sock_wfree() reading
sk->sk_write_space via:

    sk_psock_drop()
      -> sk_psock_restore_proto()
        -> udp_bpf_update_proto(sk, psock, true)

The caller holds write_lock_bh(&sk->sk_callback_lock), but
sock_wfree() does not hold that lock.

This was raised during v1 review:
https://lore.kernel.org/bpf/4fa31330c83ad1ab8e4498d2c92dbd4e7660d90bf162395c19bc7bfa7e38b70c@mail.kernel.org/

> +
> +		if (sock_flag(sk, SOCK_RCU_FREE) &&
> +		    sk_write_space == sock_def_write_space) {

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22081407735

AI-authorship-score: low
AI-authorship-explanation: The commit is a small, focused data race annotation fix consistent with the author's established kernel networking contributions and standard kernel style.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Incomplete data race annotation leaves the udp_bpf_update_proto() restore path with a plain store to sk->sk_write_space that can race with the new READ_ONCE in sock_wfree(), though the practical impact is limited to KCSAN warnings.

--===============1222204316904146046==--
