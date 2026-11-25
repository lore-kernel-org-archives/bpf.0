Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626717;
	b=GfoljbHqj9ggHhRKbqUwUZ3EDOyOyCbI281q06Zqzoft8XCY6E7tESDAuAYCdmVYKt9i
	 0koGIFRo6+356d7gP2cNyR9AKkdAvQVCgWsC6ypaTGblvBhgpHPvs5XRevqYqgvOkGUcB
	 SyjAueXpqPPqwKe46VrwodHznCPENTsCHU7ApNYwup3/O5iLQj8fnE9JFdgNExGSbrLXz
	 TXMW1tzyfwcbiwxuuPHnbhbPG4WNsYBqq7B8Ge3WbcP016vLpAvGgBqVXCGTdGLMJ438u
	 5+HGk1onw7W9Hm8q+Cy5OAMN3snUS5zly26X/F4Uf2LgyvVaXDJhFetoG+M2F2zGdKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626717;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
	b=zzCSuu+2j7RSV6wnQ3IJsRKzJud9ynYpulEyaLUHHMBye8phAtxkbsS2zILlt8J8AeZf
	 lGElxhpDIRMjGky+eoIXSsyD5uyZMGW0dsRzI0/b8IhxKRVHTEGvrH9OtREf+3XOcatO3
	 7QToM4pmtI+tsouCPUnyPTHyxSX15sU/jJPU0pTeiFPcxSbvXVoOcCDWRlS2Ytexk8xcx
	 zsoxN7GWFv1JtzMzaE9MAdj/fhf7GV5clOoRXqS00YZbyzz7iEsIV3HLgF6OwKdat6kQg
	 dIWLiOY2TjaAutSaCuD2QYAD4JfrO2VLBDV1IAJKOwCiHoGSp0tzBEcVjg3BEOkoicg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gwt1iAHU;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=D0wQeWAa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC77606A32D
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EC77606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gwt1iAHU;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=D0wQeWAa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795626715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
	b=Gwt1iAHUVMwCbOAfvitXOiEYwhojYbZJh0SyOxfUb5oytjeSTyvVWeA6ztn1EgRxVbooDN
	Fqv0zboUdkDdYLi050ws9Pq8lmndcCDT/6Z6LDfElXiPTynVViHflp3jAFqYMW0aIN6Ykb
	Zd2S6/0Ih4yzlLnQd81YDjRNwljUiks=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-9nOlz0DANNiIiGQZ8mJLlA-1; Wed, 25 Nov 2026 17:11:53 +0000
X-MC-Unique: 9nOlz0DANNiIiGQZ8mJLlA-1
X-Mimecast-MFC-AGG-ID: 9nOlz0DANNiIiGQZ8mJLlA_1795626713
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b0bf2140b7so80236147b3.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 09:11:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795626713; cv=none;
        d=google.com; s=arc-20260327;
        b=RXmNzeTjXDJBrX81n97eEzQ5xfTLUQAC7s7XLiDzEkPkIJCLhfZqVEVSImt5fG8DfV
         fTDChgrVecq2jur3iheRc9iJYhx7sT9N8tEsRLepBtyFPnYYGXS9AeBrVrxh3Sa1n8mX
         HtGm2F4mSagD39S9mC2Y2UgEr6mKYBhjdAI+UjYcZVPHzOzJyq7qj5Z4RF6euVaM++2L
         dH4ZFTmhKx04d9KqATOQE+RbPh3caW22nKzR7GeWwEMU0Z4s/yL3caDwn5YCBvfSbhZM
         lkUzrMAgM7cYiQ409eVUUXX73myv7EQEoEoCknor3ikdYJb6vpzpA4KIRgo/rge1yFA/
         Kb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
        fh=zdASKLMK/aAJ7aifU1lm1pm0NLothz0s9TVOqFkzBnc=;
        b=qw3iwjmJE7stwx5AvSjzd9vPW4c90M2ZjVf9eKYLryqpRwTKw2nmkCJp8o6g/l4+f1
         xEDZNDQ2YF1/UA0EhDhFyl3Pu22q8HMAOVmbWQ7ejZ5rt3TFj9zS0/ME3y9GUiqrdGWS
         6bSY9hqj4AOsBvuSJdI+MpciL38Heuu9/Mr6+RlwiSYzTqxEeQVMAmVpw8bNUMOqxCRY
         PlRF6urZNuTzfqmywTNh5qzxalgG/7M7PLozovsTHs2t9PRQRAhYJ/mLSWezuEVXCQf/
         YE3IjveaKCg6WPaimC3yMkw/5s9eCikYZ6MheUe28WDxovwhMOn/YLSLygB+zlreV0sN
         YBPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795626713; x=1796231513; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
        b=D0wQeWAaebB28+WKLQBSOH4C2jOFLLlSZTlO04f71qF0Aa+Kyyhryv/vMtWXYnbvuT
         k6iAnPClddwWtDpUDuQsaqXT9ZiPmBpetc/POaZJ4XLLpC7W8isgpVShvNq1LTzChtAg
         t0Tq0bZdciT7TRUz1dmRtlu0m94iT7c0k3eQ7hoUgxj+HLNXGhBSpPqGUSo+w38U25V7
         v1iAQAZYAd68wWaGlNRRBkdYB9MYjiJL8VkALML1ApACMyKKVRcChwhC2YrvvKf+Mk7I
         qqCSwS+qUy6ye4DZ1arJuofB1aNTR9ShOI+a0SSfz1P5Vdsg4MabmJ73nWu6B2XzZIaE
         MxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626713; x=1796231513;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
        b=sCPwvVm0IRjHezVfe6nDkb1NW2oQ5mIkl65NJArP0fNQEdvx6wkUX5XQgV634c2pxl
         NEb9W/WGy6IEE52KaIfTSYFtX3qvdhb0fga2ckXVlAwJRjYW8ACbCuws+d8pIIgJd4Ix
         KHKVS/obfAK3//zRgJNA0o1D9QzaQ6W5XWz/Mx5dja8tN44QfTvJbaOeGI5YgbmoESDj
         1FcZ+JIVMZuFoClGMLf23U8vd7FKl0uE10IDh+iFJVzBslgvCfc1KLB8NJZ7PQHvL7lF
         vpc4uWL7I6inVV+T6vfnkjvMNTrA9HYiGv1Tyx+VdpaTBEQSX/SQp0dZaqLLzikA5mED
         5pEA==
X-Forwarded-Encrypted: i=1; AL+hErFxOcUpX74ow5P/tnMb/pJpUun8m95OTNqDnQujJVETwA8pAu4S3fdMVNS6HZt10g9Y6WI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RGaJcsAeXq0L/XfrwiiR6FDOoxOGkaT3WwbVjm2P4tig9Ztsw
	/M6RjshWyxXfr63XgiUQEledm9UHvJErkmxlSr80ZLrgh8LgrwqT6tYaryPFjEtsm/LsXff+GaY
	XnYRAmER25u9HdRJOX+e/Y72yAeN2Is1xy5prD9TnpQCKyARFePEBrAgxjY60/kIQafhIOrmsXJ
	zCKPFX3j9tzYFgWKM+yK8ruyYjVAxq
X-Gm-Gg: AZFdTZdP+So7hxIg4JHyZzhJisaZZ7sX+Sdmc0u67Zk01p7J8cVJp/SiJ1Oumbz1NQ2
	z/7W05EDy6j0EfU+a+nQjlbJBqRSTpSN1CaZdPHILBKaMYhsm8PrXbrTXP2Fzn7YvyqV/clQHz5
	fG3pakE+tUxuNMJq6qdNjHBdhb9sscbJcJ7wYb5sZfhNS9pyw65IRWpmA=
X-Received: by 2002:a53:ca02:0:b0:67d:c2d1:5f40 with SMTP id 956f58d0204a3-67df44a9f94mr7458620d50.97.1795626712804;
        Wed, 25 Nov 2026 09:11:52 -0800 (PST)
X-Received: by 2002:a53:ca02:0:b0:67d:c2d1:5f40 with SMTP id
 956f58d0204a3-67df44a9f94mr7458599d50.97.1795626712243; Wed, 25 Nov 2026
 09:11:52 -0800 (PST)
Received: from 821463759402 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 09:11:51 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <aveRRt/rHQ1By6ul@devvm29614.prn0.facebook.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
 <20261113-vsock-dgram-support-v3-7-1523c8e9b27e@redhat.com> <aveRRt/rHQ1By6ul@devvm29614.prn0.facebook.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 09:11:51 -0800
X-Gm-Features: Aa3M54rWhP6JPS6dAHPhCuA1V9j2mDkBDAmNkK_cOM-iU_dy7BMJhibPYf3kF0A
Message-ID: <CAAiTLFWpoZu9ArNVQ_uq6RRQyiiQYvy5=uNVbhpb=6-OBJV8mQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 7/8] vsock: fragment datagrams across receive buffers
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bobby Eshleman <bobbyeshleman@meta.com> writes:

(I've just noticed I've missed replying to this review, sorry about that).

> On Fri, Nov 13, 2026 at 06:15:47PM +0100, Sergio Lopez wrote:
>> The guest already uses page-sized RX allocations. A datagram can exceed
>> one RX buffer. Growing every posted buffer to hold a full datagram would
>> increase virtqueue memory use and make small queued datagrams retain large
>> backing allocations. With delayed reads, a bounded receive queue could
>> then fill after only a few messages.
>>
>> Define START and EOM flags for datagram packets. Mark outgoing messages
>> with both flags, and let vhost split a message across guest RX buffers,
>> keeping START on the first fragment and EOM on the last. When a data
>> packet meets a descriptor with no payload space, vhost returns that
>> descriptor with zero used bytes. It drops datagrams but requeues stream
>> and seqpacket data for a later buffer.
>>
>> Reassemble consecutive fragments in the guest before tap or socket
>> delivery. Bound a partial message to 64 fragments and 64 KiB. Discard
>> incomplete messages on malformed packets, a new START, a peer mismatch,
>> an intervening non-datagram packet, or virtqueue teardown. Require complete
>> framing for host and loopback ingress.
>>
>> A QEMU reproducer now delivers a 9 KiB datagram as one message and all
>> 16 messages of a delayed-read burst. Paired host/guest selftests cover
>> 64 KiB messages and the burst through both a userspace backend and the
>> patched Linux vhost backend, with stream and seqpacket controls. A nested
>> vhost-vsock guest posting header-only RX buffers also passes stream and
>> seqpacket receive tests.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  drivers/vhost/vsock.c                   |  15 +++++
>>  include/uapi/linux/virtio_vsock.h       |   8 +++
>>  net/vmw_vsock/virtio_transport.c        | 115 ++++++++++++++++++++++++++++++--
>>  net/vmw_vsock/virtio_transport_common.c |  11 ++-
>>  4 files changed, 141 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index f4fb2ac732f5..1ff4a9aff907 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -185,6 +185,19 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>  		 * buffer, we split it using multiple buffers.
>>  		 */
>>  		if (payload_len > iov_len - sizeof(*hdr)) {
>> +			if (iov_len == sizeof(*hdr)) {
>> +				/* Connected sockets must retry with the next buffer. */
>> +				if (le16_to_cpu(hdr->type) ==
>> +				    VIRTIO_VSOCK_TYPE_DGRAM)
>> +					kfree_skb(skb);
>> +				else
>> +					virtio_vsock_skb_queue_head(
>> +						&vsock->send_pkt_queue, skb);
>> +				vhost_add_used(vq, head, 0);
>> +				added = true;
>> +				continue;
>> +			}
>> +
>>  			payload_len = iov_len - sizeof(*hdr);
>>
>>  			/* As we are copying pieces of large packet's buffer to
>> @@ -244,6 +257,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>  		 */
>>  		if (VIRTIO_VSOCK_SKB_CB(skb)->offset < skb->len) {
>>  			hdr->flags |= cpu_to_le32(flags_to_restore);
>> +			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM)
>> +				hdr->flags &= ~cpu_to_le32(VIRTIO_VSOCK_DGRAM_START);
>>
>>  			/* We are queueing the same skb to handle
>>  			 * the remaining bytes, and we want to deliver it
>> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>> index 27b4b2b8bf13..e1937f756eeb 100644
>> --- a/include/uapi/linux/virtio_vsock.h
>> +++ b/include/uapi/linux/virtio_vsock.h
>> @@ -101,6 +101,14 @@ enum virtio_vsock_shutdown {
>>  enum virtio_vsock_rw {
>>  	VIRTIO_VSOCK_SEQ_EOM = 1,
>>  	VIRTIO_VSOCK_SEQ_EOR = 2,
>> +	/*
>> +	 * With VIRTIO_VSOCK_F_DGRAM, START marks the first RW packet of a
>> +	 * datagram and EOM marks the last. Both are set for a datagram that
>> +	 * fits in one packet. Fragments must be consecutive on the receive
>> +	 * virtqueue. Each packet's len is its fragment length.
>> +	 */
>> +	VIRTIO_VSOCK_DGRAM_EOM = VIRTIO_VSOCK_SEQ_EOM,
>> +	VIRTIO_VSOCK_DGRAM_START = 4,
>
> Should this be 4 if VIRTIO_VSOCK_DGRAM_EOM = VIRTIO_VSOCK_SEQ_EOM = 1?
> Seems like 3 is missing?

Yes, those are bitmasks. But they are also part of an enum, which is
weird and confusing. Perhaps I should prepend a patch removing the enum
and redefining those values in the form of "1U << 0"?

> Is VIRTIO_VSOCK_DGRAM_START strictly necessary? If we just received an
> EOM from a peer, then we know that the next pkt from that peer is also
> the start of a new dgram. We'd have to be careful to never abandon a
> datagram partway through, but for example I think we can just requeue
> the datagram fragment to later retry if we fail to place onto the vq?

Yeah, I thought about this quite a while too. Having START makes the
protocol less dependent on the transport semantics, allowing the guest
to identify an incomplete datagram to resume from a known boundary. I
think it makes the implementation more robust with a relatively small
cost.

Thanks!
Sergio.

