Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C214B203A;
	Thu,  3 Sep 2026 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444133; cv=none; b=uBu86gTwa9ATTgvn3JGr2yFN6irkhoKoIL4bOwcMPTQyINCVdZioQOkt05BoCTWlWmJLlBEsMDH1wuI8oDmXw0gNY0ySckUZDmAZhlU48SPrBH2BmRffW30K2FpvIteoK2WCrjGGGAuYIAnJv57vFCWMcLESyXRg8QLQ2CDIUxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444133; c=relaxed/simple;
	bh=Mpm+2gSk0KcHCAC3FrfW80ns2FvddQM7L50oGYP+CP8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tG6m38IMvCz70BqZ7FMqbZjhw7Wi0dU56J6luoGBf5L0jExV1NbA8OsU97jx5NyXf//mv0ZDVj6uJtfAW0v2gLa4tAqB2y1Xvnuz7En3wF9Vph+O42Xj6QPx0e9XXZzPGjmZaJePPr2RKSN8YCq/cZVgFHJzJwo1bKzS7h7+Fe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGOi3nCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGOi3nCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9A21F00A3A;
	Thu,  3 Sep 2026 14:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788444120;
	bh=+n84nme5mcwj2ZATP+IqzOi+xKkQiR6pMmo4Y0hPmXo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UGOi3nCDqkbIHaaq45hucr5sZ5dnkszL9YOvEeOPDY8Qr4L9f2WzGbCsBRDzz0Dki
	 O1wdKekGPBiG+hcShw1I2wL1Y4w5yrjGe1PaBgJ+tP8iduokPb4j+Ce+Ho8Wmo9GAl
	 g1SBKhxm6Ai2qmFwFUEjNUG993c6yzfRvOFU7VbAYUcGbLyxADXkCv6wEC/XZ50Op9
	 UEqPQM0TA2lG1l0AEkjhDg5gJakiP4vgtZxUJYvSJWj2c8vNJ5fn3+Tbdx+E5Xtl1y
	 aIwcNv0nBU+NlYgZCzESR1aWV+uMqtbLotpuRUcmJdoZ9itytCbuKcjh4mFHiLEzFC
	 908ZttKaJpjYA==
Content-Type: multipart/mixed; boundary="===============1260188190606007013=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <88d25f82f5261c0a7f12d6e82988bda387f8180c656cd163eec959d327f48769@mail.kernel.org>
In-Reply-To: <20260903125306.299943-1-jiayuan.chen@linux.dev>
References: <20260903125306.299943-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf 1/2] bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,xmei5@asu.edu,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,martin.lau@linux.dev,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,aditi.ghag@isovalent.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 14:01:59 +0000 (UTC)

--===============1260188190606007013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e7535523..1bbb72138ac64 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12912,8 +12912,8 @@ __bpf_kfunc_start_defs();
>   * @sock: Pointer to socket to be destroyed
>   *
>   * Return:
> - * On error, may return EPROTONOSUPPORT, EINVAL.
> - * EPROTONOSUPPORT if protocol specific destroy handler is not supported.
> + * On error, may return EOPNOTSUPP, EINVAL.
> + * EOPNOTSUPP if protocol specific destroy handler is not supported.
>   * 0 otherwise

The EPROTONOSUPPORT -> EOPNOTSUPP correction is right, but the rewritten
error list is incomplete. tcp_abort() returns -ENOENT when the socket is
already closed (net/ipv4/tcp.c, around the sk_state == TCP_CLOSE check):

    /* Avoid closing the same socket twice. */
    if (sk->sk_state == TCP_CLOSE) {
        if (!has_current_bpf_ctx())
            release_sock(sk);
        return -ENOENT;
    }

That error propagates through sk->sk_prot->diag_destroy(sk, ECONNABORTED)
and is reachable from a BPF iterator (destroying a sock the iterator
already destroyed, or one closed concurrently). In contrast, EINVAL is only
reachable through the narrower tcp_abort_override() path for MPTCP listener
subflows.

Should ENOENT be added to the list?

> @@ -12925,8 +12925,12 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
>  	 * Supporting protocols will need to acquire sock lock in the BPF context
>  	 * prior to invoking this kfunc.
>  	 */
> -	if (!sk->sk_prot->diag_destroy || (sk->sk_protocol != IPPROTO_TCP &&
> -					   sk->sk_protocol != IPPROTO_UDP))
> +	if (!sk->sk_prot->diag_destroy)
> +		return -EOPNOTSUPP;
> +
> +	if (sk_fullsock(sk) &&
> +	    sk->sk_protocol != IPPROTO_TCP &&
> +	    sk->sk_protocol != IPPROTO_UDP)
>  		return -EOPNOTSUPP;
>
>  	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33760037892
--===============1260188190606007013==--
