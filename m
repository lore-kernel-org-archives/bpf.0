Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785998;
	b=nt854MW8mpVlsCODZM/9s52Wtp/tceDcdJw6U32z6aByBo+8aKFV4hxf6trV6XCLdWPn
	 qBFfBOIEW+QIYm2MArhm7T2C0ZBW8w99ruE7/pcPkQzXhzagCKWaA+VDsQwk9WD6A8XET
	 TBTonqTsBvdEMigGYuxsBrZUVgGEyfA8bXd60i7xUdfDy2ewnkXvpJ3rlwKkhudT4C6uY
	 xtDnI22x8/UG79RXUgJ/0a1nGIsOVYF3SWMO/BQYTZBNksHgQgAnz3uuh8zYkXrNj0Gw+
	 lwEjDhyz3XBfWzIkeR6YKaQxv4l/mMbs8kAvuj3umfCAmn3mw0qOOqASQWXI7eDBuJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785998;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=tD5BN+ZcdUtMZDmocFa2R2hWIUoAJ4JHdKEFBbg9OT0=;
	b=g8mnROddKrJ+pKDOOXm3DtmwlpRkCQsofOYNlCV0hZQxUZgCA/ILuQ8nbzSFKQRyu791
	 pPjOygaaU+GvNYtsihYISNCdKz6bwGyGbpnIZiOvvI2uBTc3EtZu3u5VuZs2UJ9E9Xssi
	 z95yMVwTn4yWPA175n15n7/yRSccdR855W6+LQVryRuPukO/HTZJxVewd0+srWOmdJCmu
	 e3b692pdPe9njxpWArlMHtifHPy3CtpIH2jftCbmSmy96/gn6IuQ0aGlLTdiBNKUUrcfE
	 0EfsltdkYfumTUCzc53cr6Amj0xv3tHChVxQJVqC7JfT/8MA0BXf3VFlJ61K6d4vE0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b="cwG5upq/";
	arc=none smtp.remote-ip=195.10.208.62
Received: from mout-b-202.mailbox.org (mout-b-202.mailbox.org [195.10.208.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB18606A331;
	Fri, 27 Nov 2026 13:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBB18606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=cwG5upq/
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4jbZ1t5tM5zKnWX;
	Fri, 27 Nov 2026 14:26:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795785987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tD5BN+ZcdUtMZDmocFa2R2hWIUoAJ4JHdKEFBbg9OT0=;
	b=cwG5upq/Rg0X2pNDUmpC0F3JPICv5TVin68+p+O25iPanJMrHqgScbi+Jv78Zn3DHhK1bY
	jz55MPu7xashqNpW8B9Vo8/rc6H7MO3iv/5IKr+VGTSiUlsroIqC9TJM9SBxrThQY71sTo
	hWE6W6GOc4wr8P9sSUenjY3vokgDNUmMd9PzxczcSuMWpurUW2nL77TqRAyHadIfBKO8XM
	fpvG+oD65V0lbOxhAGWp8IWXxRS9+H9Uxfx0N5OIqytByzcOpd9BUPZuBdDtHtdETmPZmK
	k/P8C9sJcHGVustoABG5xku89rZU4KvtdJI2mAoiDpHnxo3wTDxFJelzyUhLfA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <7c31594b-0fb3-47d1-93c4-dc7ded039805@mandelbit.com>
Date: Fri, 27 Nov 2026 14:26:24 +0100
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
Subject: Re: [PATCH net-next v2 2/2] tun: skip the virtio-net header parsing
 without IFF_VNET_HDR
To: willemb@google.com, willemdebruijn.kernel@gmail.com, jasowangio@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20261124235959.1141963-1-antonio@mandelbit.com>
 <20261124235959.1141963-3-antonio@mandelbit.com>
 <willemb.880316e8f949@google.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <willemb.880316e8f949@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jbZ1t5tM5zKnWX

Hi,

On 26/11/2026 19:48, willemb@google.com wrote:
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 408bb0b40348..79aaadd9a2aa 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -1951,11 +1951,18 @@ static ssize_t tun_get_user(struct tun_struct 
>> *tun, struct tun_file *tfile,
>>           break;
>>       }
> 
>> -    if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr,
>> -                    (tun->flags & TUN_TYPE_MASK) == IFF_TAP)) {
>> -        atomic_long_inc(&tun->rx_frame_errors);
>> -        err = -EINVAL;
>> -        goto free_skb;
>> +    if (tun->flags & IFF_VNET_HDR) {
> 
> 
>      Checking tun->flags & IFF_VNET_HDR a second time here is not tied 
> to the
>      earlier check at line 1832 and introduces a narrow TOCTOU race with
>      tun_set_iff()
> 
>      snapshot `unsigned int flags = READ_ONCE(tun->flags);` once at the 
> start of tun_get_user()

very narrow, but definitely worth fixing it. Thanks for pointing it out.

pw-bot: cr


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

