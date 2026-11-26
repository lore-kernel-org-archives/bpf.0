Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682966;
	b=FxOXDL7Zv3miMaJ6VkB8R+4S8ZPsVua7CKuDyFEXT/h/UfPmvJC3U3JrAMKsXX9ybxl4
	 +oLVk4EhBLxwyOCRFo9xjRuk841oKPC8fSbN0dwPxq9kFpgFWg4fOdKWu0R0vTWzc5QiN
	 PPcgMicLkFKbjk0GMP0x3rD5iGi9FFmfcrfXYuozAwmYwKWHq5IKFZACw1Lfq5XYTannY
	 LsGJsNkAwj1G+2/piCfVg+nhnLFlGzXCKg8zPhpHxHVeATzUs8BnlzfzbxwrNCi4aomLy
	 ufD+rw/vrM8XmPnkmsG7nZP2bevCcnFvPkACNIQgVu62a6ul7ZhXTGJo94jH1r/IoNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6Xcz3l/zZ6Iqj9au6rQ000kv3eoygO42XQVhjiRNctg=;
	b=iih9DPeJWZ2n306tMTD6xxqSA2qUfe7sg+8y58eXDFSbDLqVz5EO7vYB5OhUl3WHJ2FR
	 kLvYJpV5uMwx8BSIUhswJjUyHWejIATWY6LYe8AOteYP/t7bHGvGTILYM3hJVE2ZLlmKh
	 lknKazsh2qiSkLQR2Ki3GAKrB3FUEilPfkp9J81afTQWEMpeEq/aGdILI/1IJzBKm/Kwu
	 JLPvhoIpO+q/6xFUD02HkQIxvlZFDeQnI2u5SD/C5uTYTYFVS8xOUWJ+rhv7L1v6RYVr4
	 IcANXA3EWM6SNwIQhgMI2M4TxV7HG4dOBJNIE/JxZdZ1JO5mRf/lv5yhSQNK3baj/zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=NnQCD0I0;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7EA606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 08:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F7EA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=NnQCD0I0
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so60417005e9.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 00:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795682964; x=1796287764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Xcz3l/zZ6Iqj9au6rQ000kv3eoygO42XQVhjiRNctg=;
        b=NnQCD0I0Gg0nUp7Md+Zohu8pUilderzxUcNpRTkIPTvwduhE73VpypZanTjlUdt46z
         DNcBcj9Mtr69nosAuXWyHLg6XU9EOAPPiKX2+fKaFBOpPVXUiY0+s60unaCaBaVwBzSR
         77iquBG4UyfBINmJfeoeYqsTbtAJddX12YcuZrfO5niAqv/WBeJMVRIXba7JRyfmGVAc
         Byq0+fpDqr0TxF8jqL/54Jd67aKB9Xj2STWSox8XwFavgIekQKF5gMegQQ53pxJuKjU9
         SysggfuZ+tR3j0xP0JjtmFH3FGAyf3mB91ZGbNVjvp/WCmGZQKVkBeslBOh93ntbDXKL
         62fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795682964; x=1796287764;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Xcz3l/zZ6Iqj9au6rQ000kv3eoygO42XQVhjiRNctg=;
        b=09UkWuwUwG4qF2ivO6kiDUkrlf7o3myYAb2CIkrrRJDaCfrplay+Csstq1yvR1TO0g
         56aIXFpIG3szJXM56pAJ/03UP3vkHnZ478QR2x5RZAyPncmqEe2FkYisuouyphMFV8B7
         TEY8MYt9+ilwBELiB5u7xuBdqvaAcyD2IgfyVD1/YAjz+sOh1S1Dtmoxrn1QviBY0RYB
         CcWO+oNIVuyC9JdOL5Cvr+C1Bqj1TW7c+kkLfRqXeDDpjhd69lcAuL7G7E91B8mcBauo
         1pqQJAsBX6JPWFWzpf5JPONIvIjrZRu/pXuu3NLXCywl5Mi0Fm6GI+ePA3Wov6S17vKv
         cyQw==
X-Forwarded-Encrypted: i=1; AL+hErGn6Nw3X+ge/bjxvgor0ddJw7y+603i4D6aq/hQP6Kje0+g/xmFrTrL0tNf4VsA9bkwQs0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QVucqpWUalCBR6pBg5lw4tDvod9q0fTGJbMyi3wKbIjbjClz4
	3F3JenT2xxUI4tXuOeUJeytWxfGgBCF42kwkqK5AuLbDNmD+tSayaBY9de0X8/KGtP4=
X-Gm-Gg: AZFdTZf+KYdU4cAYnv2bFVZRxjNuR9xa+8hiqK+2evN0NHS7evpT2rjgnymH6AjG3H1
	dS+lVrDKpqhinlsOirjnXVbeBAFIZiNfTt06R8lqzzcZrrBOQqBaokQE/uVcMttggq68qEsiIVk
	gAsNQpi4itoDdw6uDILCkkG5iv5Yfl3VW4Hxv3ZawlT6V8u3zQGwDSkqLIwseT2ZxgMcr67pBSD
	bnvX31drJqVNaNoSeicSfYG5D4GI2v0Z4IhSsnUF9h1AnFG48WMDCV/VECEQAq54Uadd5bNkOEA
	3RjtJ+CQu35Vmk0631ZYp9/GxM/NThcdMv/RygPGpFNpRb9BZHXweZwJefP+Xw1s2gAqyye+MGO
	5Cau9DUnU4otgo3v3u+PlIexisA933TlOODTNUwnvlS4nPuPpvuv14e07ovc8OGe8N+A8jWITu+
	R7o5vDiHPemk4LPYFJ53nrzjU2GuNeikbku0AX4U9qFUsXvHsko6i+S/9ry+8p5ggrprQcHZ2m1
	acBZZyuCNo7tJgdhNW4P/OwO4wrpV3fZpDdY/3qt4WY2jj8fYFI4o1lgryzyrQ2jBBwrgwlkK1B
	8FL2/P5rQB/vUaFrN3u1jHOlOe1NNp89nx1124CT0RIYYyXKmmdyMnM55RLFWV9il0zf8ZEOj5V
	T9nXd
X-Received: by 2002:a05:600c:4e87:b0:4a3:59c9:a758 with SMTP id 5b1f17b1804b1-4bb88922c81mr410025075e9.32.1795682964396;
        Thu, 26 Nov 2026 00:49:24 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm1080362335e9.4.2026.11.26.00.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 00:49:23 -0800 (PST)
Message-ID: <cea8eaf8-ea5f-4165-84ff-a8b2a944ebb5@blackwall.org>
Date: Thu, 26 Nov 2026 10:49:22 +0200
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: keep skbs with a prefetched socket out of
 gro_cells gro
Content-Language: en-US, bg
To: willemb@google.com, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 kafai@fb.com, joe@wand.net.nz, daniel@iogearbox.net, bpf@vger.kernel.org
References: <20261121160204.4024204-1-razor@blackwall.org>
 <179548941922.3135.9577858774980848901@kernel.org>
 <38460544-04f5-41e0-b267-39c155bb08bb@blackwall.org>
 <willemb.1b39ecea58ba6@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <willemb.1b39ecea58ba6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/11/2026 02:36, willemb@google.com wrote:
> Nikolay Aleksandrov wrote:
>> On 24/11/2026 05:03, netdev-bot+sashiko@kernel.org wrote:
>> > Thank you for your contribution! Sashiko AI review found 1 potential
>> > issue(s) to consider.
>> >
>> > Critical: 0 · High: 1 · Medium: 0 · Low: 0
>> >
>> > If you believe none of the issues are legitimate, please reply to each
>> > issue of Medium severity or higher and explain why the AI is wrong.
>> > If any of them are legitimate and you plan to respin, please let patchwork
>> > know by including "pw-bot: cr" as a separate line at the end of your reply
>> > (one such reply per series is enough).
>> >
>> > - [High] The fix is incomplete.
>> >
>> > --
>> >
>> > net: keep skbs with a prefetched socket out of gro_cells gro
>> >
>> > This patch makes gro_cells_receive() send skbs that carry a prefetched
>> > socket from bpf_sk_assign() to netif_rx() instead of the GRO cell. The
>> > goal is to stop GRO from clearing skb->sk and skb->destructor on merged
>> > skbs, which leaks one socket reference per merged skb.
>> >
>> >> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
>> >> index 31352cac355ce..4e8b9c3cd7da0 100644
>> >> --- a/net/core/gro_cells.c
>> >> +++ b/net/core/gro_cells.c
>> >
>> > [ ... ]
>> >
>> >> @@ -26,7 +27,8 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
>> >>
>> >>       skb_unset_transport_header(skb);
>> >>
>> >> -    if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
>> >> +    if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev) ||
>> >> +        unlikely(skb_sk_is_prefetched(skb))) {
>> >
>> > [Severity: High]
>> > Is matching only skb->destructor == sock_pfree enough here? An skb that
>> > got its socket from bpf_sk_assign() can still reach gro_cells_receive()
>> > with a different destructor that owns one sk_refcnt reference per skb.
>> >
>> > One path: bpf_sk_assign() at tc ingress attaches a non-refcounted socket,
>> > such as a TCP listener or a UDP socket. It sets sock_pfree and takes no
>> > reference. ip_rcv_core() keeps it. Then an NFQUEUE rule matches the outer
>> > ipip/gre/esp packet, and __nf_queue() converts it:
>> >
> 
>> Oh well the bot seems right even though it's a weird case, I'd suggest to change
>> the check and orphan on any skb->sk set, i.e.: || unlikely(skb->sk)
>> instead of unlikely(skb_sk_is_prefetched(skb)), that is cache hot too as
>> skb->dev is read before and will catch
> 
>> Also tried asking an LLM if I'm missing something and the only case it could come up
>> that will not be aggregated is:
>> "the only correct aggregation that's lost is software ESP over veth or netdevsim in tunnel mode"
>> IMO that is ok.
> 
>> What do you think?
> 
> This also affects ESP over tuntap with IFF_NAPI. But that is not a common
> production configuration.
> 
> So LGTM.
> 
> Just a small note that redirect to netif_rx != orphan. No need to orphan.

Oh yes, of course. I was thinking and working on bpf_sk_assign egress support
which needs to orphan in a few places and blurped orphan when replying :)

Thanks!
