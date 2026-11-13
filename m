Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582467;
	b=wPhwusW53W28Xkg9Dbh/TTTbVqRZQmLywiW/ROQ1hBHBpOEOSwEiNViddPxZPpa0JbPt
	 I0ilnDJgDY03yfQbiKL2vFhfRVX7YYYwqgvJTGLw0mgf4N5a//HfaLdLIVcUQndr3m5cD
	 RLfbZUbfW4ontey3grqsubIfra6EPRf30WmotCXu1bO0xNRXr0Irna4OHT0IcDbuWO0Av
	 x5muO92j1ivIXIwfGBpzEIpd6H2cbptxlccOy5UtAIpDFFtL8kX9amFOaamwJMERIDwWA
	 FV9ZhdwSeVb8ExT7sWz+kZ1PpRfNtIjov+/YmMK45gMouEGIuJa/nMl00S2TgKxQpPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Xdl4Tdbv431DSm2QRDQ9sk/ziyVXTlG68qSFJIbEu6c=;
	b=YXEWR0n/kCCdiuKjK4ybFdoebTG3Q2LnFcn19IHOQQOv3mja+mXm9lFqbpXDCIydw7pJ
	 Vp3ixKyx6fJdyneOjQY8vfZaIZVqpEuJEbBrZZkjRsqlQo/bLk6Sqr0mUOBc6TsfU6yvW
	 ddQ9CoVNvx9/lecO5mqghAwFr3MP7w4fpy819Z5tyw/veww0sHBx4FS4mE4QVvS/K4S8o
	 5r7YP7GbnBeWOHmugCqHIOJdXdpaQeltPJoZL2i7j8M96xLwR+EPr7jKjJBnhb2l73RBH
	 NYbukv0nPvbRJap6LRoX+SnVooTYtnC62hi/UvqGPt+eUibYELnW089s8C0KKsxyAHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KlKFJQ5Q;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF509606A897
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF509606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KlKFJQ5Q
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ecd9a400cbso1577088e0c.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 07:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794582466; x=1795187266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xdl4Tdbv431DSm2QRDQ9sk/ziyVXTlG68qSFJIbEu6c=;
        b=KlKFJQ5QPmLUdTnjclUHm38zTF2SAkx0xiF0MhAa3Y89oCgC52J4hdLsyOdxXE9slo
         fkG2uJJxtO6pqBB0fdepdqPiia0eUjc9WNW5nj7L5EL8dt73uJxAG6IVVMx4psoVW7ww
         jwBeXuVj0KXEax7xTZnZrxu7dqfvMuEuP6BnOAqcCr++FtVqm4tGd4yS3Y1rN92TjGy4
         Ta5mjQ5XdVUN1FqFG3QuGnVMJ+9WaOhTbWILnZtdeHU/v9FJyjjiQG1cBkKqoIRemjQj
         mkQvg+v43o+eaVir/iQvs5GmAfIEILoS+Gi+D+NC2LwXcQGd1d2/rjq1t0y9hg+oTA0E
         KIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582466; x=1795187266;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xdl4Tdbv431DSm2QRDQ9sk/ziyVXTlG68qSFJIbEu6c=;
        b=ry5zAzfPcmYxo7f3tPQYzGFYVaBRVkPHQv+k1VUCZI+S5JyzRTCu2CPuHjWn3TGt/5
         Cb1yM7ynS4sRf3bBjbmu0vTZ3GLehKgwB1vxsv8kurFvDhY2Fhic82ZqIgFSlzvUao3z
         ilbP67ZMEMud9Qh8wCtJ2Lr34igP0Sci8nCBk3FaO4L6CqibmXEpR9Ct+Lx2VV8tBVd2
         c3l7hXKP7y5Zw4HfsbQ1jQESgCO+bI66pfPOhkjvw1Qev9w8tBQfBpFX48mh8rg5p1PT
         aNWOW1myZSqyXlUZE6VieIO4bacFJbm6+A1RUBXfunyFLYRNsSFm9QCnJu4WlFcc6mvQ
         s9FA==
X-Forwarded-Encrypted: i=1; AL+hErGGJeYdM0N/3tN3+euVkw+ZzuDuffWjsG63d4m9gkyk5Exv2nOvH1+1PsTcTag3UO3ZM9M=@vger.kernel.org
X-Gm-Message-State: APuU4Z83GdXVzy7x9ZDRDeJ9NmUObQ6/vA8pcIFzo3oKQi0vUaDIbV/+
	WVeyU+91uspu2N2x1OsFqD6l9+cFFfbqRlxcVtotHYy54KwZCHh/NgAM
X-Gm-Gg: AYBFou380c1ETyMMuK1QoELWYbHlUBzxp0NZN0chVOFOfAdQK4bFKcjkm3ll5ZojOyT
	kaeaSFKkLU+FpKynQYqlMxqv2bqLGn1uD+5rlVTk7RGota3BhYuk/8pvIgWl4ccYWWijiTQeCSV
	kzusK/Es2UuHV6p3gDMYWkxIhNuDlwa1zX0YX6b129MwJA9Gw1MJ8g5i0zmrIDVEVYbhhyDzHxw
	E7yGLROHa6ZHHrO0Vevq2NaZJ8rCqoaJ3BfBXLxXCov/npBry4WV30cPMpkDPrYe0mRjKpyOCfA
	K1ccvf4yBHWAVJBdXgiSK3KE1rpSrz7t+dTo7lJ17EEARv1zLEnIb6fi+9VsNiT1MttRGOZP5kH
	Mb24rEPMDgPJqeasZrFfQmFRMIFqcIvFMBhj6XlCemoYWP4bS8r4km1NXqMjmBNdYfKchXiCQr7
	ba+kMxUZfjfAR16Ngp2gR+bGBm0rOFLJm6LiDu7ngbIATbJNdc7t8E8GTpOEQC+ZqtX4VALLwIz
	0SDjTSVjD+9DdapJHvuTSciRuXbj1LH1ZNg4oX9xNB6mKSYNjHpBem+sNkLcYbBihE5UGVJCNDE
	gQa4uZCwlqm8N3TNmXak0EtCCt/g9l62schMs/cumdRKE21ypkvyXJl4RTkffddREiMsRY50Ci/
	vjHdkwb2fQMTzhmWIivw6eEjIEmkZkKoFu3uODu16kkpKZb9L1aR4dTGtybA3AYalp3Nj8xx/Be
	EvMfI3p6/1
X-Received: by 2002:a05:6122:3382:b0:5e9:176f:a548 with SMTP id 71dfb90a1353d-5ee344ee205mr1106421e0c.0.1794582465695;
        Fri, 13 Nov 2026 07:07:45 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee3df52b8esm122502e0c.0.2026.11.13.07.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:07:44 -0800 (PST)
Date: Fri, 13 Nov 2026 10:07:44 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 jasowangio@gmail.com
Cc: andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 shuah@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 maheshb@google.com, 
 peterpenkov96@gmail.com, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.14b320acee076@gmail.com>
In-Reply-To: <73aa2f53-e2ba-42b7-9712-06e223459144@mandelbit.com>
References: <20261111014208.1795777-1-antonio@mandelbit.com>
 <20261111014208.1795777-3-antonio@mandelbit.com>
 <willemdebruijn.kernel.1220f3b31f685@gmail.com>
 <73aa2f53-e2ba-42b7-9712-06e223459144@mandelbit.com>
Subject: Re: [PATCH net v5 2/2] selftests: net: add a vhost-net test for the
 tun NAPI queue bound
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antonio Quartulli wrote:
> On 13/11/2026 00:34, Willem de Bruijn wrote:
> > Antonio Quartulli wrote:
> >> Send 16k packets from vhost-net into a tap device with IFF_NAPI and
> >> netdev_max_backlog set to 8, in the three ways vhost-net passes packets
> >> to tun: batches of XDP buffers, one packet per sendmsg() with MSG_MORE,
> >> and zerocopy buffers. Check that excess packets are dropped and counted,
> >> that the queue keeps draining while vhost-net keeps sending, that every
> >> packet is either delivered or dropped, and that every buffer comes back
> >> to the ring. If a dropped zerocopy buffer is never completed, the test
> >> fails, and closing vhost-net then blocks until the buffer is released.
> >>
> >> The zerocopy variant needs vhost_net loaded with experimental_zcopytx
> >> set and is skipped otherwise; with it, vhost-net does not batch and the
> >> batch variant is skipped instead.
> > 
> > That means it will be skipped as part of kselftests.
> > 
> > And as a misc device all tests may be skipped in minimal environments
> > if vhost-net is not autoloaded.
> > 
> > Maybe a .sh wrapper could resolve both.
> 
> Right. With a wrapper script we should be able to deal with these.
> 
> >   
> >> The test drives a minimal split virtqueue itself, in little-endian as
> >> VIRTIO_F_VERSION_1 requires. It needs root and CONFIG_VHOST_NET.
> >> netdev_max_backlog is global: the test lowers it only once setup has
> >> succeeded and restores it first in teardown, and should not run in
> >> parallel with other tests.
> >>
> >> Written and tested with the help of an AI coding assistant (Claude
> >> Code).
> >>
> >> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> >> ---
> >>   tools/testing/selftests/net/.gitignore  |   1 +
> >>   tools/testing/selftests/net/Makefile    |   1 +
> >>   tools/testing/selftests/net/config      |   1 +
> >>   tools/testing/selftests/net/tun_vhost.c | 409 ++++++++++++++++++++++++
> >>   4 files changed, 412 insertions(+)
> >>   create mode 100644 tools/testing/selftests/net/tun_vhost.c
> > 
> > That's a lot of code for a fairly narrow test.
> > 
> > Not that long ago I would have applauded all test coverage we can get.
> > But now that LLMs generate them instantly, not sure where to draw the
> > line.
> 
> Well, the test has already done its job because it immediately helped me 
> fix some small itches in patch 1.
> 
> This said, I can definitely shrink this test a bit, maybe around 50% of 
> the current code. But it'll still be quite some code for a small fix.
> 
> Should I just drop this patch?
> 
> Alternatively, I drop it from this series and I send the shrunk-down 
> version with the wrapper script to net-next later on.
> 
> 
> Opinions?

If you could compress it to about 50%, let's merge.

Maybe we can use it over time for more coverage in this area.
