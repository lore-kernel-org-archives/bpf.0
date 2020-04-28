Return-Path: <SRS0=8xVa=6M=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B974C83007
	for <bpf@archiver.kernel.org>; Tue, 28 Apr 2020 11:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD7E20661
	for <bpf@archiver.kernel.org>; Tue, 28 Apr 2020 11:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hteqOHM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgD1LJt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:09:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45560 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726493AbgD1LJs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 07:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588072187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6V60LfmG0tcTElXs5VJKM9UUG+GuW0pu0jDPXVuGiWM=;
        b=hteqOHM05+4VpR5UkkGwwugeRa5BvsOJ6982ybvvc72eaUKLaEGwQulXkdvGJPo8W9Y1ox
        i+33Ipt4xItXJMRiQiIRBxSK+SMCZ4e0a7K+5F+jkYY6FFkJGchqAJoiXs953wL5/87qB7
        NSS6NoHQhHCn+d7dVl7V3PCzfl4pzHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-Fno1ZsUVMESkOPmrv1oYRg-1; Tue, 28 Apr 2020 07:09:46 -0400
X-MC-Unique: Fno1ZsUVMESkOPmrv1oYRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5A8E835B48;
        Tue, 28 Apr 2020 11:09:43 +0000 (UTC)
Received: from [10.36.113.197] (ovpn-113-197.ams2.redhat.com [10.36.113.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E03035D9E2;
        Tue, 28 Apr 2020 11:09:34 +0000 (UTC)
From:   "Eelco Chaudron" <echaudro@redhat.com>
To:     "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>
Cc:     "Hangbin Liu" <liuhangbin@gmail.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org,
        "Toke =?utf-8?b?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=" <toke@redhat.com>,
        "Jiri Benc" <jbenc@redhat.com>,
        "Jesper Dangaard Brouer" <brouer@redhat.com>, ast@kernel.org,
        "Daniel Borkmann" <daniel@iogearbox.net>
Subject: Re: [RFC PATCHv2 bpf-next 1/2] xdp: add a new helper for dev map
 multicast support
Date:   Tue, 28 Apr 2020 13:09:32 +0200
Message-ID: <FDBD279B-B6F2-4612-B962-75CAFE147B0C@redhat.com>
In-Reply-To: <20200424141908.GA6295@localhost.localdomain>
References: <20200415085437.23028-1-liuhangbin@gmail.com>
 <20200424085610.10047-1-liuhangbin@gmail.com>
 <20200424085610.10047-2-liuhangbin@gmail.com>
 <20200424141908.GA6295@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 24 Apr 2020, at 16:19, Lorenzo Bianconi wrote:

[...]

>> +{
>> +
>> +	switch (map->map_type) {
>> +	case BPF_MAP_TYPE_DEVMAP:
>> +		return dev_map_get_next_key(map, key, next_key);
>> +	case BPF_MAP_TYPE_DEVMAP_HASH:
>> +		return dev_map_hash_get_next_key(map, key, next_key);
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>> +
>> +bool dev_in_exclude_map(struct bpf_dtab_netdev *obj, struct bpf_map=20
>> *map,
>> +			int exclude_ifindex)
>> +{
>> +	struct bpf_dtab_netdev *in_obj =3D NULL;
>> +	u32 key, next_key;
>> +	int err;
>> +
>> +	if (!map)
>> +		return false;
>
> doing so it seems mandatory to define an exclude_map even if we want=20
> just to do
> not forward the packet to the "ingress" interface.
> Moreover I was thinking that we can assume to never forward to in the=20
> incoming
> interface. Doing so the code would be simpler I guess. Is there a use=20
> case for
> it? (forward even to the ingress interface)
>

This part I can answer, it=E2=80=99s called VEPA, I think it=E2=80=99s pa=
rt of IEEE=20
802.1Qbg.

