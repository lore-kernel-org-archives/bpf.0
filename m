Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E937AA9E;
	Mon,  3 Aug 2026 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753839; cv=none; b=tphuynl73A4YxLijvBM0teCLgAPd0lxvMjmPS6/rdoFywH1RuUNVvmGQ+Ne5d4oX8iwQMqxjZn1DH84jE23PgQt+A9VJEHPc5aPJ5EnKwg1Fx6MCa+z0Ui0TzukYBcNmcKcj23HAixekJDegMRru8qEt8/Apsgat3sx3dPuhQNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753839; c=relaxed/simple;
	bh=spa257znP8NXhKnNJ4GeagVPQqom2J9S+l2Rk/fa+IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcG4x0h+mmt3l/y8oVLqJ4YBu3M6xjT/t1NJ4m9qim8vN8mw6npS6lBei7T6wXxdlSgJufXEwKV17a9grxP9XuMuNwVR/DaNULj97jRBjxqy6oV5OVoDMFnbP75xoE5P4VA/siZZXs3aeNeEqZUSM3E4qedJ3EqDlvE25ciagw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=qgjcrsDB; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="qgjcrsDB"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wqq91-001sPk-6F; Mon, 03 Aug 2026 12:43:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=k1yWqb+Ce/M20wgB+/QGxvzPnAaiZPWRZcxBnwBy4x4=; b=qgjcrsDB/wCPNk70+uuXQwySky
	bmGMounFRfX5iGjuj9Z8qjyA3TLv+eyuXf2WiO9FFrmdNqJl5M72lmQXN2RE49E12Arlvo+fqOvvR
	wzxdf7eLnLkR1Zc+xpnbBwTLIt6uC2mrMe2scMlvilfLAbgaSw4EOXB00NssNXoSs92a3mSYRVIxB
	TDbMY8Wc9Ho9JxGyoVbc2zRPEhhPMlwd1Avy/ofzvsT5l/oiCEQzRxiUcZY2FqrOSZ6KNU611Z6w0
	dFDmnTVzqFB5rLtLmQiYXBDDMRoY8nOlkpIopzjU6Xk5OMnEVkqn2PZI107D6RQaTQjxzYGfHM/bG
	SZ+VaL6A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wqq8z-0003rZ-PW; Mon, 03 Aug 2026 12:43:41 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wqq8h-00G30o-0s;
	Mon, 03 Aug 2026 12:43:23 +0200
Message-ID: <329fffdc-9e4b-4812-8140-e0bf947e4ac6@rbox.co>
Date: Mon, 3 Aug 2026 12:43:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] bpf: Extract shared reqsk-to-listener upgrade
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, john.fastabend@gmail.com,
 sdf@fomichev.me, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 jakub@cloudflare.com, jiayuan.chen@linux.dev, joe@wand.net.nz
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260803-sockmap-lookup-tcp-leak-v2-1-306e025bfe66@rbox.co>
 <43cad9ddcd7b1c7541a179444b27cd6b40fdf32f7aabfff2080c12bfc945dc94@mail.kernel.org>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <43cad9ddcd7b1c7541a179444b27cd6b40fdf32f7aabfff2080c12bfc945dc94@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 11:44, bot+bpf-ci@kernel.org wrote:
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 11bb0d236822..fede810ef37f 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -7079,6 +7079,28 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
>>  	return sk;
>>  }
>>
>> +static struct sock *
>> +bpf_sk_lookup_full_sk(struct sock *sk)
>> +{
> 
> This isn't a bug, but since this helper only converts a reqsk to its
> listener rather than performing a lookup, would a name outside the
> bpf_sk_lookup_* family - say sk_lookup_full_sk() or
> bpf_reqsk_to_listener() - read more clearly next to
> bpf_sk_lookup_tcp()/bpf_sk_lookup_udp() and struct bpf_sk_lookup?
> 
> The bpf_sk_lookup_ prefix in this file already denotes the BPF helper family
> (bpf_sk_lookup_tcp(), bpf_sk_lookup_udp(), bpf_sk_lookup_assign(),
> bpf_sk_lookup_enabled) and the UAPI context type struct bpf_sk_lookup /
> struct bpf_sk_lookup_kern. Sitting about 20 lines above bpf_sk_lookup()
> itself, the name reads like another lookup entry point rather than a
> reqsk-to-listener conversion.

I've meant it to be a bpf-lookup helper, not a bpf lookup-helper. So yeah,
I'm happy to change it to something more appropriate. sk_lookup_full_sk() then?

>> +	struct sock *sk2 = sk_to_full_sk(sk);
>> +
>> +	/*
>> +	 * sk_to_full_sk() may return sk->rsk_listener, make sure the original
>> +	 * sk sock refcnt is decremented to prevent a request_sock leak.
>> +	 */
>> +	if (sk2 != sk) {
>> +		sock_gen_put(sk);
>> +		/* Ensure there is no need to bump sk2 refcnt. */
>> +		if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
>> +			WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
>> +			return NULL;
>> +		}
>> +		sk = sk2;
>> +	}
>> +
>> +	return sk;
>> +}
> 
> [ ... ]
