Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F12B4BFE90;
	Thu, 10 Sep 2026 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042037; cv=none; b=d315oWYZXlMChqzcZV6l4dS0Kdasj4o2XQQMs2zLVGH9SGxmd+L92I5zzATuM7/O697qsO8I5PiiN9A4sa2FTJA0DsoQnJbPT2MKSOBoJxxTlMIfp2v/3Vb5P1aiWaJgyZh6C79CUsSz3Z8Q3WkPwr2hY/LOV2UEvFaZR5Nu+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042037; c=relaxed/simple;
	bh=g3ZYCEkBBxWt7DIOOlABHsrEKeP+9WdYrIMPeDWEEYg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mB6jP8RaE1LbgBtKIKlyJ25GdX6vZwkevhWRV/50at/nuAiajt0e5Suxt6aL44Sz4pEtI4xqRSq6Fd+r3u0oaJO4s3ehuQKfqGCR2G75RdLh5SC9+qIJVJZJWY4O9WyaOw4YbpC78sRnf/GQ6qAFBV4mSdBEXYhuPbcuUugLvjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLGH1bWu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLGH1bWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479AC1F000FF;
	Thu, 10 Sep 2026 12:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789042035;
	bh=MXsEo9eDWBwZJSzFE3TWMA2FxYeWZOq70BkLywQ2TBE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TLGH1bWum3pyP9Q7PJjatv30y2xZA9f5PHUoBquEGbY+D2NTMsYuk5NfdTlJo9Inz
	 7R07X61lCvBMzc/nvoGuwM6jj/b1s/0szrtFUeEVS48CUpYvyD4Ffp5E4eYi7j9SEQ
	 aMeXoxE2l04f2cU61JVuzet9l/t6rHI1pqg3vC4JJY5jMeMqtzMcB+qae2G5DtVI3t
	 KDxX91BpJuTwdXSP+NwkS+Vyx9A04JejHIifpKbINzfoZTtj7rBttHWue5llG6DfPN
	 WWyr5czrRcqbO3l5fCeSNHoHXe5GbIpM/oVCgcc7JReqYZ/VzDLAFixM2bB9IfQfOC
	 b15W8BSpXj/7A==
Content-Type: multipart/mixed; boundary="===============2750645429148041420=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0a661bac8b617cc979ba16eeaec5f7c64a0b74bb01be40347dca187cbd7c24e4@mail.kernel.org>
In-Reply-To: <20260910112634.152195-1-jiayuan.chen@linux.dev>
References: <20260910112634.152195-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v3 1/3] bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,xmei5@asu.edu,kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ncardwell@google.com,shuah@kernel.org,aditi.ghag@isovalent.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 10 Sep 2026 12:07:14 +0000 (UTC)

--===============2750645429148041420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2a84f9d01131..cae43b999162 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12913,8 +12913,9 @@ __bpf_kfunc_start_defs();
>   * @sock: Pointer to socket to be destroyed
>   *
>   * Return:
> - * On error, may return EPROTONOSUPPORT, EINVAL.
> - * EPROTONOSUPPORT if protocol specific destroy handler is not supported.
> + * On error, may return EOPNOTSUPP, or whatever the protocol specific
> + * destroy handler returns.
> + * EOPNOTSUPP if protocol specific destroy handler is not supported.
>   * 0 otherwise
>   */
>  __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
> @@ -12926,8 +12927,12 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
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

This isn't a bug, but would it help to keep the TCP/UDP rationale comment
next to the protocol check, and add a short note that sk_protocol is only
valid on full socks? The block comment explaining the locking semantics
and TCP/UDP restriction now sits two statements away from the protocol
test it documents, and the newly added sk_fullsock() guard doesn't have
any nearby note explaining why it's there. The reason (sk_protocol is a
struct sock member not present in sock_common) is only in the changelog.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34471854292
--===============2750645429148041420==--
