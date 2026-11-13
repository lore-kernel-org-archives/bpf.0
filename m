Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590168;
	b=GEGU5WUzSgiFjWihCI/PMn8LODgLsnyJNapiH/fmXMNzGVMfTu73EkX56xe3fYiZm+8Q
	 c0Mr335C0ztxg0BD2amR4OdoIbWl9hQqwzem7aHnFwPPIyjs08vxP/1YjqJsAzfTQjCx1
	 wB3n4KcRdOWIqzzglUWVDlQ/ZqzNJOMrWrqkz2dIArO+cFBdvQbPCp8j0Iblk+YbOGDHx
	 TEcWGgiQp/EWVNh1sug+wDmbCyy71vUHRE3ppqpZXJZkLY6bPlv59N+X4Q1gMsqEslPw4
	 XLGEjnwoTDIaSxzf65ml+kWoaxJK1ClGo2jFkQH8m5H4iDtxtYjD9JN85JkAxbOBF2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590168;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=84RgXKmSK/6kR3BtGZyphwm5qswS5TA7bZtJ3FBhypk=;
	b=PPqJE6jz9p8PKbQtX8UqVrDphxAw6+6ZT0ISPerolgb1/6hkD+sqv2ExulXrvcPacHsr
	 AQW/T00iPxDMZCtZN0jsza8q2VTzHwf+6JysS+mXuyDbfC9GCAvkVYPa8sj1DGF+mWjDa
	 BWfWiZRY425CXEyIlzbsZwadB3D6a6wQVYi3afAlxI8LZqMrrL7imqE2KG3bMjASyvNuf
	 aFOTBKtER8I8pVpe2d4zowUA3NUrHcle9ZxPLRniRFBX0HbLni5GUNQO+AOWOE6CPLwPy
	 aCXtdFh2IMHbl28xp3ea+8H9889ncbuApTBxEttQbMacVflw5lFwS8IBjaJkiTC9RVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qzd7GWZx;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QMwC62KE;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD85606E238
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 17:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCD85606E238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qzd7GWZx;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QMwC62KE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794590167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=84RgXKmSK/6kR3BtGZyphwm5qswS5TA7bZtJ3FBhypk=;
	b=Qzd7GWZxtf73BgXr8C2s81iSkIKk9PsMmFHhqqX1t/9qNXM0vYLLcotIU3JhIcgh1jvgGi
	sVGtFmjvwN5qR/8gk9c98+oxG4OnxGVGZVYqv4H3C/akhGt8gqmQ7yDLzISizHkRp9Se8B
	NSz52xRYUpFvv3VxQiqzu9lQsXR/k70=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-jGg9c1o2PyOuJtOnZzSvtw-1; Fri, 13 Nov 2026 12:16:04 -0500
X-MC-Unique: jGg9c1o2PyOuJtOnZzSvtw-1
X-Mimecast-MFC-AGG-ID: jGg9c1o2PyOuJtOnZzSvtw_1794590163
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a204ac318aso5206985e9.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794590163; x=1795194963; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=84RgXKmSK/6kR3BtGZyphwm5qswS5TA7bZtJ3FBhypk=;
        b=QMwC62KEuEMX2/2mswkrV2l9gK2fjt2Xo6FjJXVxYuvlUmpQwBRMUK+tLAKik16G/5
         Xh/RMx36SYNgF9TMsFiW3HKTCyLqwQ1gX/4ReyTRijGvr/TAtP0hU4B666i+4spAalLb
         QeW505xwwdeBNY7fxTstERVg8Ed3I6QhhEt+82J7Iug0/5hLM34ZQxomOHaSnLiod84B
         1x0CBuox5k9itpfowxZZ+lTolbr65dQcehp6iDIu/nVzgdH6HkoS/7UeTvGrGcS4M7W4
         MKwpEQDLSVYmQSqpWGEvn8UWXMTBPwwXe+JgMSacmHMgpimAEM0X0IC9QL9j8aEcKp0G
         L2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590163; x=1795194963;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=84RgXKmSK/6kR3BtGZyphwm5qswS5TA7bZtJ3FBhypk=;
        b=yx98eByT5jaS3/biCplZOYuHos2P8WDH/2V001psyjvtI4a0N8VlKT+Y2XNy4r1vkV
         WPq7cgT0WRvQwwi9Xkr1b/QKIKqCwYf8HutKLhIZXu5UDCH0gkqOjv7k4Rr9u/iR1kA0
         FC4XRxJd6bl6eONhPTN8Mtc5wgEq4Y8Ye8ipQUaP77+GZ+xB7RqpE4js2LpnV4p8GpDy
         BQbHKr7tyZ1tMS5EqhnDqpto74LeFdeYWT/nisKp2+I8WPWVsxvn+5ZDKmbJy4ngmika
         VySBACnzRkh0YhEQw/p+brWvnBJOS45EwAE6JansvG07Hx3yNzNZq97jfwb7DFW6nTto
         jXGw==
X-Forwarded-Encrypted: i=1; AL+hErFpALW57ehlwrO0KR/7OK8sF4cbSoev3ClbN/xM+kPvZQU8i/LYrdres+95lfLo6RPpxfI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/N0wBRrz7KfZ3MbHHvu7qt70TxAtgrl1zYpUZ0miA+X6BoB40q
	9zUnLvAqAUr2Y9mD1Gde6Ni8focN6wVwkjSGGMf4s537Om9teXQ83ApcNqfR/+FD+QIDX/y3vxG
	LV7k4YUNip4+yLR6Y7j9OAfPaAQiMdt3x9p9fXyPoksuKAgooyq7nMg==
X-Gm-Gg: AYBFou29xIx0mgypSiIgH5z4U4FdIXV4Lh0vJBsJY6d7iZ7wnVnf0hJdiZXWbxMANQl
	x7kB5VvSpusOFHPwgTlC8E8kuwtCLIWzlxBj6AVweR+KrcZXgTWJnav2vf0JY6MyYAWRGYGKBq4
	sGSEBuizo7qrEfDryu/CdR6EOwS/shypXKHFSkR9jVG44XA0WgNJbXDEpMLW3wzXiB6IuJfQjqQ
	fLz3x2/j5SBU2Y/CBfj+R8ae8JL1hw/U494DpdfvgOsTGgXx5l+eCyFdebMOxPOuuSg0VTihox+
	t+zSz6RtzG2CoTphcxwS2sPZtxWsU8VPqLU/arHKrVSAJ0eEDYoJFz+Z7xq44Y99vSL50Ss3BWt
	LZiwMyFfWcrJnCRfFW4TxCUMwKEgel2IkZNFPRF3RS3xAElKNcpKIr6DgNRK+mLgkGJC7SOwc1h
	v29EltzDmBDd8=
X-Received: by 2002:a05:600c:638e:b0:4bb:5bf3:8ee9 with SMTP id 5b1f17b1804b1-4bb5bf390e3mr37175375e9.31.1794590162662;
        Fri, 13 Nov 2026 09:16:02 -0800 (PST)
X-Received: by 2002:a05:600c:638e:b0:4bb:5bf3:8ee9 with SMTP id 5b1f17b1804b1-4bb5bf390e3mr37174515e9.31.1794590162207;
        Fri, 13 Nov 2026 09:16:02 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm5811907f8f.5.2026.11.13.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:16:00 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Subject: [PATCH RFC v3 0/8] vsock: add datagram support to virtio and vhost
Date: Fri, 13 Nov 2026 18:15:40 +0100
Message-Id: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTQqDMBAF4KuUWTeSxJ9IV0KhB+i2uIhx1FA0M
 rGhRbx7gxS6cfnmMd9bwSNZ9HA5rUAYrLduiiE9n8AMeuqR2TZmkFwWgkvFgnfmydqe9Mj8a54
 dLawoU50h19iggvg5E3b2vasPuN+uUMfjYP3i6LMvBbFXP7Q8RINgnGGWK9Mpg6jKytuJsNeJo
 34Xg/wrQqTHioxKo01nyrxRwmBF2A56SYwbod627Qv7XYPqAgEAAA==
X-Change-ID: 20261027-vsock-dgram-support-683a4e0aebe7
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
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
 Dexuan Cui <decui@microsoft.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7564; i=slp@redhat.com;
 h=from:subject:message-id; bh=5TbAjGF4FfegO7dSKLQA2BNs4Bg65brL6KogvY7Caro=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq90XGOGgBFRHRHfVkVGgCHSYYfCPwDaTI/9+KT
 dyk8bQpnHWJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavdFxgAKCRD0aSeNLwwC
 NeusD/9yHQVTYzFerpOIXY5zPzkK6mhT3QpdS+j8gW9zYS3hE3Rt0JEF1NewA0GwZUL380zwdJA
 Gt1XS5D+c5+cRGu5VFOYe2ScPZy83rpdFGCTLSDignPHHMSJJYZ2gejtodURHXsj3ILpOPJkF+l
 Cd/S+Gvukv1VdG0seRc1Iy5s0UvxrazOAW8HJHD88Gh8AJYTzTuclart3DMo7B2goebR7QEP5p2
 MvRUsMY/P6EBGOINvSxmRWzrPi8dSM8ltDDPKYtriEocwo31XeDa0h+vYEMaeBW36tI6FNwuYCa
 VUppc7t3ce4ZJmz7rQbTq7rMIY4PE1oa4An8mWAHCmDw+lEB7oEcYtDXF0BhLGIytF7+LZBGF2S
 sAM+AhaqEK+uxHoFnBYDWmeqCuYdl1J++AhpJcMAqXed9IrczqE/b8jzRDNAFOvLjBM2aDCsDhu
 +rXaTf2W2B1Bcij/Bs179tVk7bE189KVlFmdSH/cgvzkeAzOCIx5yVH/a3UW45v2bneqtW1MuMD
 +3qV95brQ+e5mtDBJ/EB2c1fFbTnokFfYX5n2C+KbjP/wuUmw8RnXDbjV+/mXRj9K6V2y1lqKje
 EZWMsgF0BTZW4a9c/Kkh/oxtbAhiTPkuDwaybDcQbtKI146jW6xp5OAdIrTQ2u7NRwTpUs5DbtD
 obXehSJf3gbdvRw==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
the existing AF_VSOCK API. It is intended for guest and host services
that exchange independent requests, responses, or events and need message
boundaries and sender addresses without a stream connection or application
framing.

VIRTIO_VSOCK_F_DGRAM gates virtio traffic in both directions. Each virtio
send carries zero to 64 KiB of payload in one VIRTIO_VSOCK_TYPE_DGRAM
packet. On the RX virtqueue, the device may split a datagram across
page-sized guest buffers.
START and EOM delimit the message; the guest reassembles at most 64
fragments and 64 KiB before delivering it to a socket. Invalid or
incomplete messages are discarded. Datagram delivery is best effort:
there are no peer credits, acknowledgements, or retransmissions. Send
admission uses the socket send-memory limit, and SIOCOUTQ reports charged
send memory.

Datagram sockets have a separate port space from stream and seqpacket
sockets. The latter two continue to share their port space. Datagram
routes are chosen per destination among guest-to-host, host-to-guest, and
loopback transports, with VMCI as a fallback. VMCI still owns its socket
handle when it is present; loopback works without a directional transport.
Hyper-V continues to reject datagram sockets.

The Sashiko review of v2 also reported that a VMCI datagram bind in a
local-mode network namespace creates a receive handle in VMCI's global
port space, so a sender outside the namespace can deliver datagrams
across the namespace isolation boundary. The issue predates this series
and it's getting addressed in a separate patch:

https://lore.kernel.org/all/20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com

Within this series, local-mode namespaces bind datagrams only in the
core table and never create a VMCI handle.

Bobby Eshleman and Amery Hung explored this feature in their v6 series
and v7 work-in-progress branch. This series is a fresh implementation
against the current vsock code. It follows the separate datagram port
space, per-destination routing, and VMCI fallback requirements discussed
there. For guest receive buffers, it uses bounded fragmentation and
reassembly rather than full-message buffers or the earlier drop/error
queue approach:

https://lore.kernel.org/r/20240710212555.1617795-1-amery.hung@bytedance.com
https://github.com/ameryhung/linux/tree/vsock-dgram-v7

A corresponding virtio specification update has been drafted separately.
The wire format and feature negotiation still need specification review
before this series can be considered for merging.

The first patches expose the core port allocator and add datagram queue
reporting, then implement the common data path, guest and host feature
negotiation, routing, and RX fragmentation. The last patch extends
vsock_test with local and peer tests for message boundaries, routing,
connected peers, port sharing, queue accounting, and delayed reads.

Testing used QEMU with the F_DGRAM property patch below, an x86-64
KASAN/lockdep kernel, paired guest tests, and a nested Linux vhost-vsock
backend. The tested paths include 64 KiB messages, delayed-read bursts,
feature-disabled ingress, stream and seqpacket controls, and header-only
guest RX buffers. A temporary userspace backend still fails stream test
21 on both the series base and tip; that case passes with Linux vhost.
VMCI's host personality was exercised in a QEMU guest, including
coexistence with virtio and self-send without loopback. A VMware VMCI guest
device and Hyper-V hardware were not exercised.

https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg08074.html

Code was written and reviewed both manually and assisted by Codex
(GPT-6.1-Sol) and Claude (Opus 4.6).

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
Changes in v3:
- Preserve Hyper-V stream routing and prefer virtio for guest CID_HOST
  datagrams (thanks to Sashiko AI bot).
- Bind explicit non-VMCI CIDs and local-mode sockets without a VMCI
  handle, resolve wildcard destinations, and retain VMCI self routes
  (thanks to Sashiko AI bot).
- Recheck bound addresses after receive takes the socket lock and set
  TO_HOST only for forwarded guest sources (thanks to Sashiko AI bot).
- Probe negotiated virtio datagrams and numeric local CIDs before running
  dependent tests; cover wildcard and VMCI coexistence (thanks to Sashiko
  AI bot).
- Link to v2: https://lore.kernel.org/r/20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com

Changes in v2:
- Keep guest RX buffers page-sized; add START/EOM framing and bounded
  datagram reassembly (thanks to Alexei Starovoitov and Bobby Eshleman).
- Preserve stream and seqpacket data when an RX buffer has no payload
  room.
- Separate datagram and connection-oriented port spaces, and share
  receive metadata and queueing (thanks to Alexei Starovoitov).
- Check negotiated support and destination CID on ingress, and require
  an exact connected peer CID and port (thanks to Sashiko AI bot).
- Select a capable route for each destination, retain VMCI as fallback,
  and support loopback-only sockets (thanks to Alexei Starovoitov).
- Preserve the connected peer address across temporary parent fallback
  (thanks to Sashiko AI bot).
- Use socket write-memory accounting for datagram SIOCOUTQ instead of
  separate transport counters (thanks to Alexei Starovoitov).
- Extend selftests for fragmentation, delayed reads, port sharing,
  connected peers, and capability-based skips; fix the test build and
  README entries (thanks to Alexei Starovoitov, Bobby Eshleman,
  and Sashiko AI bot).
- Link to v1: https://lore.kernel.org/r/20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org

---
Sergio Lopez (8):
      vsock: expose the core port allocator to transports
      vsock: report datagram receive and send queue state
      vsock/virtio: implement the datagram data path
      vsock/virtio: negotiate datagram support on the guest
      vhost/vsock: negotiate datagram support with guests
      vsock: allow datagrams to use directional transports
      vsock: fragment datagrams across receive buffers
      vsock: add datagram tests to vsock_test

 Documentation/admin-guide/sysctl/net.rst |    8 +-
 drivers/vhost/vsock.c                    |   51 +-
 include/linux/virtio_vsock.h             |    8 +-
 include/net/af_vsock.h                   |   31 +-
 include/uapi/linux/virtio_vsock.h        |   10 +
 net/vmw_vsock/af_vsock.c                 |  526 +++++++++++----
 net/vmw_vsock/hyperv_transport.c         |   11 +-
 net/vmw_vsock/virtio_transport.c         |  167 ++++-
 net/vmw_vsock/virtio_transport_common.c  |  172 ++++-
 net/vmw_vsock/vmci_transport.c           |  124 ++--
 net/vmw_vsock/vsock_bpf.c                |    3 +-
 net/vmw_vsock/vsock_loopback.c           |    2 +-
 tools/testing/vsock/Makefile             |    3 +-
 tools/testing/vsock/README               |   33 +-
 tools/testing/vsock/util.c               |   62 +-
 tools/testing/vsock/util.h               |   10 +
 tools/testing/vsock/vsock_test.c         |  175 ++++-
 tools/testing/vsock/vsock_test_dgram.c   | 1061 ++++++++++++++++++++++++++++++
 tools/testing/vsock/vsock_test_dgram.h   |   30 +
 19 files changed, 2195 insertions(+), 292 deletions(-)
---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261027-vsock-dgram-support-683a4e0aebe7

Best regards,
-- 
Sergio Lopez <slp@redhat.com>

