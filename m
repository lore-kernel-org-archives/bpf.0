Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4456C40488E
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006095; cv=none; b=Ui51Q6sX37NjAx5PxHYGsyfFQsjvcPl3b59Fda3rO0jK6lIJv+CfXHuDanK2Se3IMwaAk97CT9UT2b6uCX+FDBokBS0C1piMJ8OZTGTbuci9qBOktUSrFnxaL/ChFHfKR74q/74V3MCbr2kW3pxrG9lWwnng0oD/mv9bte4/oME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006095; c=relaxed/simple;
	bh=pURGLEfOlHNz5lnARlNYJ5uYP4yxdHs6TZKb5qNNxWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNhOoJbAo02QJlMsvzz91DXQnzt75nxi3V6ymrXUAm+GDCROOsDEi4yXxcNww3gihE7L8zxxWy9Yd31AafKLE5tvR3to9ca69157RVAlloTzA8T2mhGJoL7eDhIwWWLZgp/wJqx5mfJ+rwWmlcRiqRLbeQzFYZQzIGcSXqYPltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPY2Zide; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1Zkh6nf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPY2Zide";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1Zkh6nf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781006091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1dZ0b3532+qnimQ22844Y+HuqWQ6wMYq0EdeEWLSznM=;
	b=MPY2ZideULl+tqcDG1fU3Lmb9Hr+vKpDZlhyuE9/Tlp51FZL8/SX/b3E9yW+BF7eKxqEsQ
	tb4UCWsDGXWLUcx1Cq6i/Ds7OBNra+a1Tjdx6Mo3yVO5JxGZNHXagHT9hQgDuLBcPDCJaQ
	ZPY2V9jr6V35KYj8/u6Atqed+U0ESxA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-y2s5Ia9JNJu10y735W4PYw-1; Tue, 09 Jun 2026 07:54:50 -0400
X-MC-Unique: y2s5Ia9JNJu10y735W4PYw-1
X-Mimecast-MFC-AGG-ID: y2s5Ia9JNJu10y735W4PYw_1781006089
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b2f22ea2so56594155e9.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 04:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781006089; x=1781610889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1dZ0b3532+qnimQ22844Y+HuqWQ6wMYq0EdeEWLSznM=;
        b=S1Zkh6nftTyUm1VoiPGgTrQrsjXW4KC57vP2bN+vpseU0ggCpBh6ZPwk7FqrH5u5qy
         Vbtrw4m01SehWjXZkmZyUSgSaO1O7UaZ80GB+oo9R321Zp8HTFC3yeXzz11KxVpX5UXZ
         0od5AqM8xGfobkQUhmWHcjyMq5fwi+IHD7QQZjJr3PmNnfeZ4XoMSRMWIAdENTWlo5Fk
         BVcuflUWDa8z0Pm8iAvQTDOST+DB4y9aMNAbTs8xK+jGBncpMjt/Y7bfLibUv4Y+41sg
         4fcZHO6W8i71jSi8t7AgB5OFrJy0iYDG7IwU1qC6ZRRPxD29q2MfTdwK9KVOWeArC/b2
         7DLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006089; x=1781610889;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dZ0b3532+qnimQ22844Y+HuqWQ6wMYq0EdeEWLSznM=;
        b=o/1pjqNQcwzNtLmhxzUhvoymo7O5f3hSrz8PcK01r+f/BATZNUqBU2yWrDKCBxwwcA
         kau6vERmBqlOtcqN+tfWhu4+o8Yqv8n7obtX1v9UdInUXEuteRYiZz0nF5cQlgcGqits
         0GKQXz39apWmfZiRMg6AZrx//avIW0wEDRUqqCUaT7OvEGmOxf8H8ceyhsnCzPTn6qtM
         D1CSirpQuOzAs28dmassaa3473/LVsK+OZNnfwV4IFT9idZCnoMwMbVEgWOSPD0puCmX
         AxHW+y8PGxarKdkdjxi3vI1NJvi3mWdjIwvRQOGG9dK1EwVKfumOlCiZ10QlpmHovR72
         WWpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wVJh6ufya2zsPDeNr4oo4+wtZGOoBOGE5R1B0evpa4CXFbS/HNOQw19yrsD0kMuBEGHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpfSuDPxVtdFxAEZZnhK6dTAX0cEnbOnLS72ke6RqKUwnDxwuI
	myvnLkWZXLWSAwce74IO6XO5jyi720iWDGgHP557I2YeIoX1scChpukunGPs8rNvpWbPMfFkcIR
	eLgYtTVMWWaI/7XfAvHEDLharjJB5MNw/WUu8hj1+Cb/93ktZxxsHqw==
X-Gm-Gg: Acq92OH77+2JK8j9+LMlOquo9jyblz0Mw/Cq5xGWeSzydMJ9QAOfHjZ5VUGKNhFriGM
	ngnd6U7d3cAgT62uEmetGE+eYy++ZiVJ+tPm7QUbe116ydLaSMYw81wvuiZ6ca/VwPPAvtFiVXX
	zymHplMZibcTIjsK8gvsPKynn3kI9NLyB4VFNeZSKVs4P8+C8xpL3roBnimxetnkHuuY1fX318/
	Wo44o0ejPLnpPVhglqAu/d40sK3vTQTQXxMaQm7banaYUsNgQMj6p7ZMXvHavaeQDabwELom2UX
	rrBZUzfhXCHHx152NVmoAppjeNl2oFyB7MQ3FPG00a0hcLHuH+LUwr6qHYK0q4OFbhA+G3f+FxZ
	VA2e7WkG5RuDkQJIWSV6zI6gKldxRqdOIXGPDJ0fJZDJ3UPg4Y/qwJSyOW5RIiyoliw==
X-Received: by 2002:a05:600c:1f90:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-490c2602971mr335847195e9.28.1781006088633;
        Tue, 09 Jun 2026 04:54:48 -0700 (PDT)
X-Received: by 2002:a05:600c:1f90:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-490c2602971mr335846755e9.28.1781006088273;
        Tue, 09 Jun 2026 04:54:48 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm67726434f8f.35.2026.06.09.04.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:54:47 -0700 (PDT)
Message-ID: <f5a3896d-7fbc-410a-b727-e910b6b182c4@redhat.com>
Date: Tue, 9 Jun 2026 13:54:46 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 1/2] tcp: rehash onto different local ECMP
 path on retransmit timeout
To: Neil Spring <ntspring@meta.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net
References: <20260604212246.265079-1-ntspring@meta.com>
 <20260604212246.265079-2-ntspring@meta.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260604212246.265079-2-ntspring@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/26 11:22 PM, Neil Spring wrote:
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 7995a89bafc9..fc8e886f7791 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5020,8 +5020,10 @@ static void tcp_rcv_spurious_retrans(struct sock *sk,
>  	    skb->protocol == htons(ETH_P_IPV6) &&
>  	    (tcp_sk(sk)->inet_conn.icsk_ack.lrcv_flowlabel !=
>  	     ntohl(ip6_flowlabel(ipv6_hdr(skb)))) &&
> -	    sk_rethink_txhash(sk))
> +	    sk_rethink_txhash(sk)) {
>  		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDUPLICATEDATAREHASH);
> +		__sk_dst_reset(sk);

Instead of touchin all the sk_rethink_txhash() call-sites, I'm wondering
if the __sk_dst_reset() could be placed directly into
sk_rethink_txhash() ? Note that this patch does not touch the
dst_negative_advice() caller.

> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 0a88b376141d..7a2b1de7487c 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -823,6 +823,9 @@ int inet6_sk_rebuild_header(struct sock *sk)
>  	fl6->flowi6_uid = sk_uid(sk);
>  	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
>  
> +	if (ip6_multipath_hash_policy(sock_net(sk)) == 0 && sk->sk_txhash)
> +		fl6->mp_hash = (sk->sk_txhash >> 1) ?: 1;

I think you could place the above logic in a shared helper and re-use it
in several places below to avoid code duplication.

/P

