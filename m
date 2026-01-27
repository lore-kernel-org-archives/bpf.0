Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE3C355024
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519472; cv=none; b=TCs9aox/iNyOzeubg5tHy7f/Cex8edQpU8vDZKjYyKmpeVDLmLYgGnuJ56su75OXy4qvCNeBG6ZkELfHNB/hmjHpWFnOsKOHtWTIa3rN5SOZQxBNbYk1dqBOFrdfXssYlNxjOjB5V7jxg8vsnZPXyY1Q1X2RfWfsedq6NzSPS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519472; c=relaxed/simple;
	bh=Yb48oTTyvytkqZo72LomphVlIKlkpTYlcpwJCoD9iAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSSzs8dDfYK5OhoPsPu24Waz/Zlko6aCeNjlDbr/rTblHndvAnARpvbws03M6j1HBnlsWcHN2VqRZznVuMqYsc3bkcPAwswduL+8bis1/gIZ66fn6ChRf4xyztyMqScI+TJwIj+01A3qkLOU5/NiaApyqdQ1xOPwpJ3rpC20SNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=YIEH7rkN; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="YIEH7rkN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kUoPGv2r0RdydIXstnqWqEZ4XCUyL7jY83JLFSm8stg=; b=YIEH7rkNq/SbTikEy6DmQns37O
	WwfFtF/kx/FbUH6xaamP71aCHiOZfRpMgNV1+VvNa3nX2c3qC9HPq1keafUE6TOjrKKqRNNK+8P+U
	IjYvG966z0H8d1x1MoXXNCH3Jk1Wkam06bVatV7jMPLoHdDbOmIpSSXapvmknqP2HWec/frGEEV6w
	pmQMLaWT9alihahDXQnwbTDmbyJdCMsLaKXPrYA5J1iZrJkGtFB6pbNYSckbuukG9P8XVxEs82zaj
	Hx7kWs5oK+3PaeXrx/8DkCDjYzVHt6kPI+s+jdL85sO0i629TmRG8oPhy4KTkc0QLjt36s52sXTlb
	0xP+4X+A==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vkiqS-000MqQ-0R;
	Tue, 27 Jan 2026 14:11:00 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1vkiqS-0009Su-0S;
	Tue, 27 Jan 2026 14:10:59 +0100
Message-ID: <8ae6e34c-3c6d-4777-ba21-34a525728b3c@iogearbox.net>
Date: Tue, 27 Jan 2026 14:10:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4] bpf: Fix tcx/netkit detach permissions when prog
 fd isn't given
To: Guillaume Gonnet <ggonnet.linux@gmail.com>, alexei.starovoitov@gmail.com
Cc: ast@kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
 martin.lau@linux.dev
References: <CAADnVQ++Bx+xZ1jmeM6rLC7xeLHfsSUNizzMtw0=zOcPfLcc6g@mail.gmail.com>
 <20260127082616.28850-1-ggonnet.linux@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260127082616.28850-1-ggonnet.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27893/Tue Jan 27 08:24:09 2026)

Hi Guillaume,

On 1/27/26 9:26 AM, Guillaume Gonnet wrote:
> This commit fixes a security issue where BPF_PROG_DETACH on tcx or
> netkit devices could be executed by any user when no program fd was
> provided, bypassing permission checks. The fix adds a capability
> check for CAP_NET_ADMIN or CAP_SYS_ADMIN in this case.
> 
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Signed-off-by: Guillaume Gonnet <ggonnet.linux@gmail.com>
> ---
>   include/linux/bpf.h       |  5 +++++
>   include/linux/bpf_mprog.h | 12 ++++++++++++
>   kernel/bpf/syscall.c      |  7 ++-----
>   3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4427c6e98331..5f59d1f173a2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2742,6 +2742,11 @@ static inline bool bpf_bypass_spec_v4(const struct bpf_token *token)
>   		bpf_token_capable(token, CAP_PERFMON);
>   }
>   
> +static inline bool bpf_net_capable(void)
> +{
> +	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
> +}
> +
>   int bpf_map_new_fd(struct bpf_map *map, int flags);
>   int bpf_prog_new_fd(struct bpf_prog *prog);
>   
> diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
> index 929225f7b095..18d26ae6a5b6 100644
> --- a/include/linux/bpf_mprog.h
> +++ b/include/linux/bpf_mprog.h
> @@ -340,4 +340,16 @@ static inline bool bpf_mprog_supported(enum bpf_prog_type type)
>   		return false;
>   	}
>   }
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +static inline bool bpf_mprog_detach_empty(enum bpf_prog_type type)
> +{
> +	switch (type) {
> +	case BPF_PROG_TYPE_SCHED_CLS:
> +		return bpf_net_capable();
> +	default:
> +		return false;
> +	}
> +}
> +#endif /* CONFIG_BPF_SYSCALL */

While this silences the kbuild bot issue, it would be better to move the
bpf_net_capable() outside the ifdef CONFIG_BPF_SYSCALL in the bpf.h header
given this is the actual underlying cause. Then we don't need the ifdef
above, e.g. bpf_mprog_supported() does not have it either.

Thanks,
Daniel
