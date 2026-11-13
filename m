Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601339;
	b=jLYVaV18Q+xblVa7CuGMmusJzZ+Lh9y4ok1+TgR8R/tYACaTJoZ9cpU7Qh0V7ATVh0TS
	 thGM3Z9PdYqoQNUDhUigKiAWu6pfsJ4bGhwMX6uuLHTBpXU6Jpvamlyh95s5ae097yP30
	 Go+BqQsdasavuPkejE4yCOMtxIOaLdkMSRjdI7l4ln32SfepaBZXqoxmaBfD/AzvVIgzj
	 XoyH1EwjuCSgY0P/LeIEjn3qyS0Rfxj9WK5HxPD8Z3VI5RQKABs61K3pIxjfvkUoYApUj
	 76Ykf4Zy3Abr4qZW3HCjazhsunIYy/lDjMjniOVpgbInfpqpKTzDdwLQaGgrDdhhLRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=e9XTism2h6GI5PEf3nzwBx2axJe/PDQpM09YQnNfZH0=;
	b=BwHnv1hQ2P1VrAco/bwT19Xq7WBeax52xLitBz9wAe6M9qWtXUUnAWLACdmJ3d359zE/
	 M4D/+5VFRreJqY8PjkN3XuozWS5hWEFQRWULoTyx4H/2yZmBKS6GeLPrMHA3MjgMAKVm3
	 CU1IsBjz+2xxAptUUiKTfyY64OM2XrjypP2i/GbV8jS2lQM+q80T6afysnT8GjFHGSceT
	 yXRghFjpl7GPRdJAyrhuS2YyZuDBmO73PPbf+nArX+Ddu+jmqgvHVcnhfLcAm+bOFkhrP
	 sVljkwys7MfyAgOkb6gcpGyd3Ps2KXlFPI/Izz6i4fBTxARh84khocdAId4LFWAytKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LpREJwCt;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A48606A323
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 20:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89A48606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LpREJwCt
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36d73027aedso486947eec.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 12:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601337; x=1795206137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e9XTism2h6GI5PEf3nzwBx2axJe/PDQpM09YQnNfZH0=;
        b=LpREJwCtrnK7Eiqzb4f/1THoEjElqDwm2lkFHnjYviKx/56ONT1jzBZVgpJSV/uqj3
         MvLDZl/7u8i1w39T6tT4486Fem3k99YZ5BLy0pIirLAzYlPOnzjV3LdbRqIWkiQWEw5T
         4JVT+c8vI9qL1ToLnzaXPEg9ZeAY7aR4BoVIPKURMRnKB6aqGWD57RxStkAJUpNJgIVU
         EISm+PfhbJrYHt+2bUY1RRBN/QL8U0Qxx096MCSAqUYCSPmB8MeUvVwTbdnPoEX0Rhiv
         6vOBkawWL4rduchCEHDlTjzTEOEt5i4FLiPbEbuNLMZruMbCrhNtq6qeIIRLLFQ0heLT
         aBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601337; x=1795206137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9XTism2h6GI5PEf3nzwBx2axJe/PDQpM09YQnNfZH0=;
        b=b6SBIqjAuUm4ATHBxEWs5H6XlkoeoVlVJfIkQ6OeDuPK5sFGjmKJrlp7kmF6FpAJo2
         tmeicpUEUHe7GtG6yHfoLBj5ST60mE2MS3hRWWFU+DUpvRkZSYbXu9eG6JnZx6ZE42zh
         LrODWQb9/KHawNLB3kuBgWfqZX5skL53Zaij8LgjnkuB5CauWc8/GMGz+nfciOhm056b
         wG91IKpksBzWJ0uFhzM7qyVeHxwL4XiuhhYus6UnSriR3chy73myf3ueoloyDY6PVNkN
         ldPKNEJuMhMKVY6TDtDAZjJUzptu6O+I/HdI0iMjwCJglS1a2ren1qxb8psTlgrCP7Go
         r3LA==
X-Forwarded-Encrypted: i=1; AL+hErFAeAQeA+pkp3K9Y7aBlth8oQXH8bCNgG1279cTFfE5Un61FBaU+XX0inM8dOIYzEGE+V4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qU7VwaIYInuzrawlj+FHlTfMSHGZuPhQBxXLEsf41lEVuOUmt
	VwdDU+EIlbQodoDZheecRjtc8f0R4mIWXIzGKsthv211uQuxYnDKhYis
X-Gm-Gg: AYBFou3FAZ1sgL7IiYwmD7WxugIKTJ3EnMe02L89Kfe/MXnF4GoGfL8lcIXaKtAMLlA
	blaKVD0nzNbHS/oBc/thhOayf1GzlrE8Q7Vk7UwEeM3YY6GGX5ZWQEx+wKQ5vaAYCHB7Tmi4/vk
	VWt2NV+T3kNm5L3kMderXFpo7gAmRYJ8BcDXBWzdkhTGrGoK4sRAPYbpLe7sSmQCHTdnNv27vdY
	TUlO7KXjGfmM82+g4l+Yy1rHsbcF4yu4HglT75L58/e6B4fWtg2xd64nDUgPE3g7FchyY5J146Q
	324RLwi7CDhKdzFzxVVT1DTDb5CH7IqwkIColwvBxUmBKe/WTZlKtucdEn19W+gV7eix3DWtrh3
	NzCkq/kEMahVP/yqXTSpwGrbPLNthi9x22TROGniM6CbWVYoEmdstDcG8F5bfcFMcqHzEMsUpYs
	Suu9SkV21hbs61bB3SuYhon+zHxneq+njyEHo/tsvj3oP81dVghkpuOuzJJdQ1MPSFCEtpgLezj
	tLGHQ/ZyN8i+xIKPrbF+cvyqGu5gxyXNrkWc8Jk1oNC3iOus+RP7DSHxrJcTstRl71kuO3y3doE
	GFITaJ4imORE8FyEyNDrvN4=
X-Received: by 2002:a05:693c:2585:b0:369:ef63:ea95 with SMTP id 5a478bee46e88-37966e3a7e4mr2520589eec.6.1794601337204;
        Fri, 13 Nov 2026 12:22:17 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:43::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795591f4f8sm9979449eec.13.2026.11.13.12.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:22:16 -0800 (PST)
Date: Fri, 13 Nov 2026 12:21:27 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 1/3] net/tcp-ao: convert the getsockopt helpers
 to sockopt_t
Message-ID: <avdxDgmlDBTRgqM0@devvm16445.scu0.facebook.com>
References: <20261112-getsockopt_phase7-v1-0-1eb759dd0929@debian.org>
 <20261112-getsockopt_phase7-v1-1-1eb759dd0929@debian.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261112-getsockopt_phase7-v1-1-1eb759dd0929@debian.org>

On 11/12, Breno Leitao wrote:
> TCP_AO_GET_KEYS, TCP_AO_INFO and TCP_AO_REPAIR are read through
> tcp_ao_get_mkts(), tcp_ao_get_sock_info() and tcp_ao_get_repair(),
> reached from do_tcp_getsockopt() and from nowhere else. Convert them to
> sockopt_t. While do_tcp_getsockopt() still carries a sockptr_t pair, it
> calls them through tcp_ao_get_sockptr(), which builds the sockopt_t and
> writes optlen back.
> 
> TCP_AO_GET_KEYS and TCP_AO_INFO read a versioned struct from optval.
> Only a user buffer gets there, as BPF's sol_tcp_sockopt() takes no
> TCP-AO option, so they keep reading it with copy_struct_from_user(),
> now on iter_in.ubuf. A kernel buffer gets -EINVAL, as in
> sockopt_expand_out().
> 
> TCP_AO_GET_KEYS is sized by a field in optval rather than by optlen:
> optlen is the size of one entry, and nkeys says how many entries the
> buffer holds. The match count then goes into the first entry's nkeys,
> past optlen when the caller's struct is shorter than that field.
> 
> Userspace relies on this, so sockopt_expand_out() grows optval for the
> reply, as for MCAST_MSFILTER. The growth is bounded by the keys on the
> socket, not by nkeys alone: sockopt_expand_out() refuses a reply above
> MAX_RW_COUNT, and a large nkeys would otherwise get -EINVAL.
> 
> iter_out only moves forward, so the entries are written in turn and the
> bytes past each one are skipped, as before. The match count is written
> last, through a copy of iter_out saved at the head of optval.
> 
> A reply that still needs more than MAX_RW_COUNT bytes now fails with
> -EINVAL. With two keys on the socket, that takes entries of about 1 GiB.
> 
> TCP_AO_INFO and TCP_AO_REPAIR now write optlen back on success, with
> the value they were given. TCP_AO_GET_KEYS stores optlen after nkeys
> instead of before it, which only shows when one of the two writes
> faults.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/net/tcp_ao.h | 13 ++++-----
>  net/ipv4/tcp.c       | 28 +++++++++++++++++--
>  net/ipv4/tcp_ao.c    | 77 ++++++++++++++++++++++++++++++----------------------
>  3 files changed, 76 insertions(+), 42 deletions(-)
> 
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 9a2333e62e9940..0e1edd777a600a 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -210,9 +210,9 @@ void tcp_ao_calc_traffic_key(const struct tcp_ao_key *mkt, u8 *traffic_key,
>  void tcp_ao_destroy_sock(struct sock *sk, bool twsk);
>  void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp);
>  bool tcp_ao_ignore_icmp(const struct sock *sk, int family, int type, int code);
> -int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen);
> -int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen);
> -int tcp_ao_get_repair(struct sock *sk, sockptr_t optval, sockptr_t optlen);
> +int tcp_ao_get_mkts(struct sock *sk, sockopt_t *sopt);
> +int tcp_ao_get_sock_info(struct sock *sk, sockopt_t *sopt);
> +int tcp_ao_get_repair(struct sock *sk, sockopt_t *sopt);
>  int tcp_ao_set_repair(struct sock *sk, sockptr_t optval, unsigned int optlen);
>  enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
>  			const struct sk_buff *skb, unsigned short int family,
> @@ -334,18 +334,17 @@ static inline void tcp_ao_connect_init(struct sock *sk)
>  {
>  }
>  
> -static inline int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen)
> +static inline int tcp_ao_get_mkts(struct sock *sk, sockopt_t *sopt)
>  {
>  	return -ENOPROTOOPT;
>  }
>  
> -static inline int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen)
> +static inline int tcp_ao_get_sock_info(struct sock *sk, sockopt_t *sopt)
>  {
>  	return -ENOPROTOOPT;
>  }
>  
> -static inline int tcp_ao_get_repair(struct sock *sk,
> -				    sockptr_t optval, sockptr_t optlen)
> +static inline int tcp_ao_get_repair(struct sock *sk, sockopt_t *sopt)
>  {
>  	return -ENOPROTOOPT;
>  }
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index a1f89c1fa2ae51..552e8fe22e7e20 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4492,6 +4492,25 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
>  	return stats;
>  }
>  
> +/* Bridge the sockptr_t pair of do_tcp_getsockopt() to a TCP-AO getter. */
> +static int tcp_ao_get_sockptr(struct sock *sk,
> +			      int (*get)(struct sock *sk, sockopt_t *sopt),
> +			      sockptr_t optval, sockptr_t optlen)
> +{
> +	struct kvec kvec;
> +	sockopt_t sopt;
> +	int err;
> +
> +	err = sockptr_to_sockopt(&sopt, optval, optlen, &kvec);
> +	if (err)
> +		return err;
> +
> +	err = get(sk, &sopt);
> +	if (!err && copy_to_sockptr(optlen, &sopt.optlen, sizeof(int)))
> +		err = -EFAULT;
> +	return err;
> +}
> +
>  int do_tcp_getsockopt(struct sock *sk, int level,
>  		      int optname, sockptr_t optval, sockptr_t optlen)
>  {
> @@ -4830,16 +4849,19 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>  	case TCP_AO_REPAIR:
>  		if (!tcp_can_repair_sock(sk))
>  			return -EPERM;
> -		return tcp_ao_get_repair(sk, optval, optlen);
> +		return tcp_ao_get_sockptr(sk, tcp_ao_get_repair,
> +					  optval, optlen);
>  	case TCP_AO_GET_KEYS:
>  	case TCP_AO_INFO: {
>  		int err;
>  
>  		sockopt_lock_sock(sk);
>  		if (optname == TCP_AO_GET_KEYS)
> -			err = tcp_ao_get_mkts(sk, optval, optlen);
> +			err = tcp_ao_get_sockptr(sk, tcp_ao_get_mkts,
> +						 optval, optlen);
>  		else
> -			err = tcp_ao_get_sock_info(sk, optval, optlen);
> +			err = tcp_ao_get_sockptr(sk, tcp_ao_get_sock_info,
> +						 optval, optlen);
>  		sockopt_release_sock(sk);
>  
>  		return err;
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index bb7bbc20ba3fad..af33042478f9a8 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -2054,14 +2054,11 @@ int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen)
>  	return tcp_parse_ao(sk, cmd, AF_INET, optval, optlen);
>  }
>  
> -/* tcp_ao_copy_mkts_to_user(ao_info, optval, optlen)
> +/* tcp_ao_copy_mkts_to_user(ao_info, sopt)
>   *
>   * @ao_info:	struct tcp_ao_info on the socket that
>   *		socket getsockopt(TCP_AO_GET_KEYS) is executed on
> - * @optval:	pointer to array of tcp_ao_getsockopt structures in user space.
> - *		Must be != NULL.
> - * @optlen:	pointer to size of tcp_ao_getsockopt structure.
> - *		Must be != NULL.
> + * @sopt:	optval and optlen of that getsockopt(), described below.
>   *
>   * Return value: 0 on success, a negative error number otherwise.
>   *
> @@ -2091,29 +2088,31 @@ int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen)
>   */
>  static int tcp_ao_copy_mkts_to_user(const struct sock *sk,
>  				    struct tcp_ao_info *ao_info,
> -				    sockptr_t optval, sockptr_t optlen)
> +				    sockopt_t *sopt)
>  {
>  	struct tcp_ao_getsockopt opt_in, opt_out;
>  	struct tcp_ao_key *key, *current_key;
>  	bool do_address_matching = true;
>  	union tcp_ao_addr *addr = NULL;
>  	int err, l3index, user_len;
> +	unsigned int nr_keys = 0;
>  	unsigned int max_keys;	/* maximum number of keys to copy to user */
> -	size_t out_offset = 0;
>  	size_t bytes_to_write;	/* number of bytes to write to user level */
> +	struct iov_iter head;
>  	u32 matched_keys;	/* keys from ao_info matched so far */
> -	int optlen_out;
> +	size_t reply_len;
>  	__be16 port = 0;
>  
> -	if (copy_from_sockptr(&user_len, optlen, sizeof(int)))
> -		return -EFAULT;
> +	user_len = sopt->optlen;
>  
>  	if (user_len <= 0)
>  		return -EINVAL;
>  
>  	memset(&opt_in, 0, sizeof(struct tcp_ao_getsockopt));
> -	err = copy_struct_from_sockptr(&opt_in, sizeof(opt_in),
> -				       optval, user_len);
> +	if (WARN_ON_ONCE(!iter_is_ubuf(&sopt->iter_in)))
> +		return -EINVAL;
> +	err = copy_struct_from_user(&opt_in, sizeof(opt_in), sopt->iter_in.ubuf,
> +				    user_len);
>  	if (err < 0)
>  		return err;
>  
> @@ -2214,6 +2213,21 @@ static int tcp_ao_copy_mkts_to_user(const struct sock *sk,
>  	}
>  
>  	bytes_to_write = min_t(int, user_len, sizeof(struct tcp_ao_getsockopt));
> +

[..]

> +	/* The reply is up to nkeys entries, user_len apart, with the match
> +	 * count in the first entry's nkeys, so it can outgrow optlen. Size it
> +	 * by the keys on the socket rather than by the caller's nkeys.
> +	 */
> +	hlist_for_each_entry_rcu(key, &ao_info->head, node,
> +				 lockdep_sock_is_held(sk))
> +		nr_keys++;
> +	reply_len = max(array_size(min(max_keys, nr_keys), user_len),
> +			offsetofend(struct tcp_ao_getsockopt, nkeys));
> +	err = sockopt_expand_out(sopt, reply_len);
> +	if (err)
> +		return err;
> +	head = sopt->iter_out;

Is that faster / cleaner / more preferable than calling sockopt_expand_out
on every iteration hlist_for_each_entry_rcu below?
