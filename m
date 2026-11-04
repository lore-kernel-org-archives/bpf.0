Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781700;
	b=Bi4C/Q7R9nCjWrrpTNkF1y8rjkdqKCl+rTPVMrT0AUrGOqKab4wBKawl+uulbqolaNKB
	 vFvA8YRPcbYOJTwPRSjVcaWPdCbkIhyQrcRFYvNeDWEhPBTBCSVHHv/ULP1Q3D77vgU76
	 ooMwrZxHJW+4HWULYM3yiY0bGGzNuM3/V36xu9NWjLU+cLdClRsoIugrqZT6P5vje5jyS
	 t+Y6uekddTwcXxoc8rtTKP1DV5+pzgaqnK1wdZ2WugU2N0dGQFdwi0pCqOrYejAb7ymFS
	 e1ZqHjdxWxqvurxl1IIaMKsmMOKPssEHlJk7riZEOjYFkxBxL7CTQtOx7KiourB8CZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781700;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=tOA6pkU/gNCWHcJNqJZg0NzRYRy3OJtENBm4suvgaWI=;
	b=uNujHXFJjF33WhrnPROVaTlR8G0lpyFvBVc2HiPe6bVxnBQ7cuhZVNPEwq/hdJgXo6ac
	 pAEF7Zy8KsrAg1RzhslRP62pTjK8Cb+c6+cL0AixZrj7ezW+Ge/Q77BQ856Ya5aajSIQn
	 peAmTEm9S92DkhsoP45SQDT76tgZJeDIQRkPl1q01/+vBBKHrnEcLdqMnpwYN1mJqU8tw
	 vz4FCfIfl1pchpQalxALiVLoSsLRC1iKN0WirK/1KuHfEbjgiZJa202KX0wG+fBLUG03G
	 44HygGmAXaJSI9NLEEgC7atDwe1jf+ma7WV1Ce6Jh5CdKuGKEBrZW9exa6w28FT2fCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YjOMFFH3;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="hkYPDeo/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8449606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 08:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8449606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YjOMFFH3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hkYPDeo/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793781698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOA6pkU/gNCWHcJNqJZg0NzRYRy3OJtENBm4suvgaWI=;
	b=YjOMFFH3B4gbABFW7fjGUAsevGp1qOhYK4t+oEW42rYDmrTfX0E62gBogAS5/RJcqmxlkv
	BfutCBRDBbt42KXBnUTkR7eaTtR9oNFSniWhgBQ60Vl6TvZqkl7Zrc3lRxfl4jpALUXJD6
	+tyms6FTx143skW03MLdFS5gnHblItI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-eAECPWdVNcqbSeFTLCYaQg-1; Wed, 04 Nov 2026 03:41:37 -0500
X-MC-Unique: eAECPWdVNcqbSeFTLCYaQg-1
X-Mimecast-MFC-AGG-ID: eAECPWdVNcqbSeFTLCYaQg_1793781696
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so3260465e9.3
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 00:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793781696; x=1794386496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tOA6pkU/gNCWHcJNqJZg0NzRYRy3OJtENBm4suvgaWI=;
        b=hkYPDeo/+rw5xYOEw5/EDKXBZ44X6fnZdMHtvBQtQeO0kKS2SpiKEtE/sZOsk4+37W
         YJelI7l9+h3FrNSB1Iib7+EvvhPgnjUJ9eEEKINL9oT6Vte3FSIG7OinOymwWJp7u7vD
         DBIg2CxBjteS95KbwDdWLuCDVpay4zdX9DLRqjmRN+UWtkqfqSGqRXaC+dfOF4/49HWS
         10nACvG/WkkngPf35DzrZZIxo+nQDqrVyeBPm1HSEzKXHyR+9AaA7xFAuLhsxQt5u68p
         +n4b13z8gbD/0LXI5wNUevVBTrtd+Wz/HtHYth4j693qQpEwrqnwSpKaMOsPYLm7NtHK
         s6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793781696; x=1794386496;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tOA6pkU/gNCWHcJNqJZg0NzRYRy3OJtENBm4suvgaWI=;
        b=H6L1dU7dRJAm+/zr26g2IDS5oeQzooWKmBwsqnTPnF8NN9a2UnhPNibkQSxcLzfPhX
         WWv/wcO/5srrZkB/6O6cmZj3WN8yvnNUPapJsJit2vpR6v/WWhoFykD4ESzstCCx5d9l
         T41169uspE9HI8ubdjZv8ryEsRyz2T3C10y9LAvA3UNY+M7XvLzQtVto4Ysd6P/2gn5V
         UShdW/+Y77cnfhEuYujLYrOlOwZt5ZyLXhxA6MIL3NlMun2iLdWLC3/QsFkX5YcepYhm
         KkyFNphNdJ3FqYH2IcB+u8rIL8JLSxy7MbD/rGnZ9AFRpfAP9wc/6koOHSsEs2mIe7K7
         zByA==
X-Gm-Message-State: APuU4Z9AD6vMzO9bekRXgKO4xMsFs87w31GqpyjW3Q4ZRbIkcv6uMGzm
	EOnJ/1f6zQbx4VqqwbcYtyHPXU6vc8hyRyYKvLhtGqw1t5lM70AZr4l2Ucq9h1REC8lsbNGglQo
	sA3bhOB9z6mUSuS/n51bZzkPWKV7Xorx+2ea3R4ZHjOzxJzLY31e/eg==
X-Gm-Gg: AYBFou3tWY339NTc+DUkoS93b0UspnUEQMPMpbI8cRdQftteyQ0es0/EjKkazCKEFuD
	JnOF7nElUuT5tg0xn/6WJ/A4hblALDLB5c7ZCyU9FZRfSja/iYG8V14IvuYChlaenXiLuMcCif2
	yWD0PztEcW2uaFftoxP27WjZtHgQmEnBitn3BF8IsfTzrGiAEni4h1ooGyiz93sLjBmtlV6BKX9
	eCur7BhcJV9wvdLB7vXVZYYMrZF6p9ZKNJLgvYR4Qmp0sy45CZxR3hSlxiFx2RV0eW3p5rbW4SZ
	2jNaCjAU9PRWdLoqOAtLUBIVD3d8+//8ctTPrEJ0z40MftRN3N58m9OM8+g4H0NDv2oJxqR0Rr/
	33gYo5GSs/0Zs+1pziqiCcdyvUaDmdo+KsS+Ioe0w3s1MvrKy9nsbCMjg4NYHO3uADWSKHoLfvX
	ejyIWSONcroaxsyUB1Bof8X2wdrd+r3Zd9bTFqspq4iIA=
X-Received: by 2002:a05:600c:6099:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4ac185bc1d2mr329183175e9.26.1793781696114;
        Wed, 04 Nov 2026 00:41:36 -0800 (PST)
X-Received: by 2002:a05:600c:6099:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4ac185bc1d2mr329182855e9.26.1793781695664;
        Wed, 04 Nov 2026 00:41:35 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d87b5sm2470040f8f.11.2026.11.04.00.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:41:35 -0800 (PST)
Message-ID: <f029172d-855b-4e93-8a86-d4aff72c9abb@redhat.com>
Date: Wed, 4 Nov 2026 09:41:34 +0100
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
Subject: Re: [PATCH net] net: reject a negative TCP header offset in
 qdisc_pkt_len_segs_init()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, network dev <netdev@vger.kernel.org>
References: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
 <sashiko-outbox-194018@kernel.org> <DML39PMNWP8Q.7K2P5T3AG8LP@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <DML39PMNWP8Q.7K2P5T3AG8LP@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 23:46, Alexei Starovoitov wrote:
> On Mon, Nov 02, 2026 at 11:44 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>>> +		/* A header in front of skb->data gives a negative offset. */
>>> +		if ((int)hdr_len < 0 ||
>>> +		    !pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
>>>   			return SKB_DROP_REASON_SKB_BAD_GSO;
>>
>> [Severity: High]
>> Should the (int)hdr_len < 0 check be placed immediately after hdr_len is
>> computed rather than only inside the SKB_GSO_TCPV4 | SKB_GSO_TCPV6 branch?
> 
> No. It's already explained in the commit log.
> 
>> When (int)hdr_len < -8, hdr_len + sizeof(struct udphdr) wraps to an
>> unsigned int in [0x80000008, 0xffffffff] (> INT_MAX), which triggers
>> DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in
>> include/linux/skbuff.h:pskb_may_pull_reason() before returning
>> SKB_DROP_REASON_SKB_BAD_GSO.
> 
> Not a bug. That's CONFIG_DEBUG_NET only and the warn is right:
> the header is stale.
> 
>> Can this write uh->len (and uh->check in bnxt_sw_udp_gso_xmit() and
>> enetc_tso_hdr_csum()) before the start of the header buffer when
>> skb_transport_offset(skb) < -4?
> 
> No. The driver doesn't see this offset.
> 
>> Third, for other GSO types (such as SKB_GSO_FRAGLIST, SKB_GSO_UDP,
>> SKB_GSO_SCTP, or SKB_GSO_ESP), hdr_len remains 2^32 - |offset| at the end
>> of qdisc_pkt_len_segs_init():
>>
>> When (gso_segs - 1) * |offset| > skb->len, can qdisc_skb_cb(skb)->pkt_len
>> underflow in 32-bit unsigned arithmetic to ~4.29 GiB (exceeding
>> QDISC_PKT_LEN_MAX), causing deficit-based schedulers such as drr_dequeue()
>> and ets_dequeue() to spin in their deficit-refill loops?
> 
> No.

FTR the nipa sashiko instance dismissed the above concerns autonomously:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101194433.2637113-1-alexei.starovoitov@gmail.com

you can reasonably safely refer only to such instance when submitting
patches to net/net-next.

/P

