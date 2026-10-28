Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203504;
	b=gfCw28Pn9SxthdXLZx97KHtcYTSreMD4ZAmKPV9DnO4OB6ShcbVEMGDjXDNlYMAfg/o6
	 VlRaN9cUbXvcRsRXxOToHVW3+kL73qriHXW3PND61EjfayGTasEsH796OOnY7cdhibHEV
	 lYKdaXRIz9WoZ546qlLissVYkSE+jGm0StZVw6xfMEao7Id7b8e9i77PC/bvyPcDo0JX2
	 ZMgC4UuiMF7ofEPd1WFPF0Z/OPVt291AjJ9aTvJ2TPGfHuTQ6i0MLYAq3Mk0L9xUbYiRN
	 GJC7WkpNMLh6tj846W6LKQj6xk+YpCaxOnTHGjSTU7Jy9TlMwTevLIxMpGCiNnoBnDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203504;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
	b=YPuBvvnumlOkS2bg/kNZe1M6hSe293x8kQwkZc4+7WxSsh68iOIIhbnnaG7SkHJmWFg1
	 0KTE3FlHZDjvczSIRliv19obz60R6hO5cnEWbPsk23NbT2ez/USsmRB0kQyxV2BSo0run
	 cSn8UikAgYqjjyRttQ3oril2ETRZ4Q/I4NBlwZvQN1fvCNTPmbnuSBdBUlKGJRi8UmW00
	 h11mbnSwbley/g9a2PJUjIAtNVEJkT5RYtxVZAdnw42RENzMb0kpWUzqwPim+cfUjnqZ/
	 Fyh3oKm2nTtkvqI2p+MgU/rxMmDhuWy/EDgsmF4pxdV8AeCrX3VHv/oJYKu68+oTd7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RGgdv3ov;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FQm719pg;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79436606A31F
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 16:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79436606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RGgdv3ov;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FQm719pg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
	b=RGgdv3ov5x7YywirkIc6TwDWPJ6H0Jh2YPm+p4JiMCxLBdbt2nJExSxqKlDmY+ioUhLsS/
	6hLt5bl2gLnasW2pzm6CCHQV76GeN4gOZ7YCfrx/iPPE+fXzrlPZ4R4HuEyyULdwlc2kU1
	TAE57ee/SVTdO29ix9QXr/WIcW3c5GI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-b16pKqp_MVq5ks-4XxtQpw-1; Wed, 28 Oct 2026 12:04:55 -0400
X-MC-Unique: b16pKqp_MVq5ks-4XxtQpw-1
X-Mimecast-MFC-AGG-ID: b16pKqp_MVq5ks-4XxtQpw_1793203494
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c25501f4aa2so155391966b.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793203494; x=1793808294; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
        b=FQm719pgpZJsJPVOMbeCVPOFeqVtgdSaQLW5q4G1+LouBGH1LcY7GWMtSHET8KPc25
         Y+sb5/01dGAOR1x7QVxz2PcMbyEwhf58dTE1WstxW7n7/lQsNFXP2rM0KQuBuXewsCDp
         Qfs5nrWFKsM7mDh7N/QkijSplTTMXuOyOXfGzCNgQ4imR1o6B/JzpySRainwLccUD7Wv
         TbIFuiRDUep1SmmI+EmeTcwniOM8xSeLhWnHSp4WnttalMp22x90G5cO1Fx5csdh2bOW
         JY3W2Q+zKsxXqVSoZZ3ryIc3/YPDF8tcErp3rH5++QE7SX1gGzf5VjuQFDsiycSNkCn0
         qzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203494; x=1793808294;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
        b=iuAlfN9/lmMacKY8ho5UO1ViBlV1WgVI8cJ8jN8txbU5j3L/PZVLRqib28glQjdrUc
         RnXOGY95gFMBB+Ik5oCaCgUHTl5lpuXGkK9bmsSAEwcC7CXHWh4/4eTprQM9cA+xqyVx
         MKDsTceK/y8+/eKUPO1SUM0JBBkLJGUstxjeLO8ZEqWRzUlEU8rW9zJndn1LsuL8+By9
         wUYddyzLd2AaXRK1VyDhZo/zTTQi7C4Y/4QI8yCRrCHh3vzpmKJY+8ZqDDhJ6q666ah2
         RlBhdttkCcUylIU3QDCX5exI0Baj5HjOnJ50AqRYBndp4I/psnv30S9NecJnNPokRCWX
         LamA==
X-Forwarded-Encrypted: i=1; AKwUvBxkhiBCaNVhoMVPXmF6B1TJ4IHpBh3zW8VNfFNhVMEEiNizjvKNWR2B72PUXkbt5dvOTmk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjpCywpS87gx/ZCTYiF8N0qcZvIiKiU4dUj6AGCDTSl6NMwUqT
	CHbCLxf1Y20SwCBPG0vYaq0W+8yAeYMPS1xwcDDTw3+/HTk1Cpp7p8gAOOw01xbPxauFWGguNg9
	ORPhe1sFEAn92npgV0AHWWF83eH1yTCldExhldBBkfAN4kNtTu5JoJvZkUaxU2etq
X-Gm-Gg: AYBFou2KgoPTFOeXIIuxqigokN7l0EJJJxBeNOWTR26v8Pnwq8oZQfTe73m2QkOuGsK
	xexfKy/pSZsrXtzHk153jSTm2rYeq5lr1vc5gkAhFYb9CvYv0qQH/a0jhZXJFomMaSnsL7q3nR+
	Unvs0FKMFClK8MggAJ2o7gnQv2NFLOTFazjNQlV+TNnsQmv7zYjPvqtK/UTtyRfv3v6191v2JgS
	nP1+bN0Agt5mC+MgeDH4UXQoyvD7Ar3kYolavx2Xzn4Ckovk0R3Bi3qugBMhtLV3TWR17MtACdw
	U6p89DqvsU317DHqh+dbxGXiN0+lqXyux2eewveiKeQO4pZb86coKkZlkJWvyeX3LV8jxawcd0X
	cf1zvcX5LG7g11p5bbAhG+u8WI8pOjM5dO4LrYz0lS+uYCwt19ia+p65Ij5IQnH/TZwGsT7kxgI
	xh5zIJ39FyuQ8=
X-Received: by 2002:a17:907:3faa:b0:c2a:ac35:95fb with SMTP id a640c23a62f3a-c49a742b50cmr551014166b.24.1793203493693;
        Wed, 28 Oct 2026 09:04:53 -0700 (PDT)
X-Received: by 2002:a17:907:3faa:b0:c2a:ac35:95fb with SMTP id a640c23a62f3a-c49a742b50cmr551001466b.24.1793203492607;
        Wed, 28 Oct 2026 09:04:52 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:04:51 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Subject: [PATCH RFC 0/8] vsock: add datagram support to virtio and vhost
Date: Wed, 28 Oct 2026 17:04:29 +0100
Message-Id: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNz3bLi/ORs3ZT0osRc3eLSgoL8ohJdMwvjRJNUg8TUpFRzJaDOgqL
 UtMwKsKnRSkFuzkqxtbUAP47zmGoAAAA=
X-Change-ID: 20261027-vsock-dgram-support-683a4e0aebe7
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3196; i=slp@sinrega.org;
 h=from:subject:message-id; bh=IAsDh8eAGF2GwPL8C87LSOoOWcUAY+hEvje7pI2yfrQ=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0ayuzqJP9Rcnuf3cdPX7iTWVlDw8ysZGp8Z
 wGNuM7AzKqJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdGgAKCRD0aSeNLwwC
 NZFHD/99IaYlGVSilyovjaYh2x2j+28+Keg9pElFi2ecT8gYqUy06MR1kFmZOrZsoqHy7pYwssH
 V4esQeAgESGZQtmvBNjEYuJ+SvP+jxLEqWzkQ7r0RzpIRxnGb+YjcYrTZu4HDNzFxBwL64Wmn02
 8ajh2a9t7wNNH/rvCNCpGt0V3zBKlQTB76xmObSCX5LfXENqL+fkV40PShUObL9gFOh6lwDQbkm
 qaHV0S7DGuhCDKFx+bOHBcI1WPuv+TVqoambXNF/El5GBreBkVoRFTzO4RaSLa2YK4yYsXjGdoN
 T4z1quggOJHvkITVGN/GItwaAFEOf6Bq8jQZ7QjAixm96Pi5OTxx/GeCmlV78mrHFPJe2gvOy/g
 WO+59N02oABNlSNaS8u+RQGwPigjgXYNDrITmaZePAtwTHi19KyDSVtI1RUhuTpM0kax/tdgUaV
 +HtPuC0HnrBXjNsU8UMvsi3soX4qOp3udDj312ClRvwBLneCo83BNxkTIImVlxCYfVCefkaaI22
 pNdV/ATqALFUZ54VVwWAVjzTvFx+1P/2plUbjAvLPEVGAWqFJGfvWF62xj2IsgkQ5AIMMZX8XBR
 /jnziV7xCe4LIWvGgd17vYzux4WMnxHqSRgiv/xLo+Ur85IEENwWIklCMJecGG/MYbEJZzl6omK
 7+lvOZABr5ugX2g==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

This series implements SOCK_DGRAM support for virtio-vsock and
vhost-vsock, allowing applications to exchange connectionless messages
through the existing AF_VSOCK datagram API.

Support is negotiated through VIRTIO_VSOCK_F_DGRAM. Each datagram uses
a single VIRTIO_VSOCK_TYPE_DGRAM packet, supporting payloads from zero
bytes through 64 KiB. Pending sends are bounded by the socket send
buffer rather than peer credits, with queue accounting and poll
readiness reflecting pending output.

Datagrams use destination-based routing across guest-to-host,
host-to-guest and loopback transports while retaining the socket's
transport state. VMCI keeps priority as the dedicated datagram
transport.  Guest RX buffers accommodate complete messages when
datagrams are negotiated, preserving message boundaries.

The patches first expose the core port allocator and add datagram
queue reporting, then implement the common data path, guest and host
feature negotiation, directional routing and RX buffer handling. The
final patch extends vsock_test with local and host/guest datagram
coverage, including peer filtering, route changes, message boundaries
and queue ioctls.  Unsupported cases skip automatically.

Tested using QEMU with a patch that exposed the VIRTIO_VSOCK_F_DGRAM
feature:

https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg08074.html

Code was written and reviewed both manually and assisted by Codex
(GPT-6.1-Sol) and Claude (Opus 4.6).

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
Sergio Lopez (8):
      vsock: expose the core port allocator to transports
      vsock: report datagram receive and send queue state
      vsock/virtio: implement the datagram data path
      vsock/virtio: negotiate datagram support on the guest
      vhost/vsock: negotiate datagram support with guests
      vsock: allow datagrams to use directional transports
      vsock: preserve host-to-guest datagram boundaries
      vsock: add datagram tests to vsock_test

 drivers/vhost/vsock.c                   |  37 +-
 include/linux/virtio_vsock.h            |   6 +
 include/net/af_vsock.h                  |  14 +-
 include/uapi/linux/virtio_vsock.h       |   2 +
 net/vmw_vsock/af_vsock.c                | 206 ++++++--
 net/vmw_vsock/hyperv_transport.c        |   4 +
 net/vmw_vsock/virtio_transport.c        |  71 ++-
 net/vmw_vsock/virtio_transport_common.c | 197 +++++++-
 net/vmw_vsock/vmci_transport.c          |  10 +
 net/vmw_vsock/vsock_bpf.c               |   3 +-
 net/vmw_vsock/vsock_loopback.c          |   1 +
 tools/testing/vsock/Makefile            |   3 +-
 tools/testing/vsock/README              |  23 +-
 tools/testing/vsock/util.c              |  62 +--
 tools/testing/vsock/util.h              |  10 +
 tools/testing/vsock/vsock_test.c        | 154 +++++-
 tools/testing/vsock/vsock_test_dgram.c  | 809 ++++++++++++++++++++++++++++++++
 tools/testing/vsock/vsock_test_dgram.h  |  26 +
 18 files changed, 1545 insertions(+), 93 deletions(-)
---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261027-vsock-dgram-support-683a4e0aebe7

Best regards,
-- 
Sergio Lopez <slp@sinrega.org>

