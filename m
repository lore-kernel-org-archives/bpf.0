Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137954;
	b=1RFxk6WzPD0ip7Ma8TOgwRbe17NoMUEgluXHN3oLg8FXdMOQ9O9s1uZuBsWy04sGLfVu
	 JEUX84b/LwZp8lYcNyGrWd/lpgFgYhRlqpSX+k6SrececpfbQMb/vsIv3B/+6vVTR3xEX
	 rGYFi7bMUlnrWXPwJO+Mjeap5ePHPLoWsE72Wgzev/BqH1h5wJhbZ4S3uZsLDyoqC4G/u
	 jeS6nxgdh3I5yNh7Ii+hmi7fnt5tHj75udQJAPAl6bcQkVvVKGTc4qOOBx45+ZoM8571y
	 B/TVi9N4CbyERsW2eGIjrRihGfFYMxDMeVlUTazCaAe17rqFUCvCnFnfzxa4IJGf1tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137954;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k/JlVhtdHW1N7+kfk+zWcbzIZHLZh0ZrTv2A0uour0Y=;
	b=TBi7eVnYJe8TgFK2z+N+ScLqUz8WmL3SCaQgtrznJ/oVVRGQtjGHoGZgo3oYGAv2ZKbF
	 9HSCZsnA89bac5fQL8XMU2muu0dRpVzJVPEDugCHyWjbhh4WZmVfSDC9NTFb77OlTYJuV
	 +M7NLeMNCZ8b02obNPkSIhFB7yE7xGBCTzeL+86tV7NnVB4/bHKgoE8VlEY68qVocLM6Z
	 FHSaZTdaBKYMSG5IM3EIlDDMUQ+z8Bzoc7b0Lq4JMNqQAFJ/9mtCt05UqQenLrVhAtRU3
	 dCxdgCrpt8qrKeZiD5fCKOCZ5DzKdma59OsmZQVbjN7yhop7yMOtwfhfNErYJqufL/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=bQ0UtJQT;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCB8606A31C;
	Sun,  8 Nov 2026 11:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCCB8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=bQ0UtJQT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=bQ0UtJQT/dgIUSZd+hfA3NZf90pdvg1CzJBYIsVuOR7Ut1tMz7kobpi19EQRoqDCtgJOzK6NuFQjt
	 15Eu87YHioxIv59a8eyvESMPUgXDaB0OiFpOgD88QVyth3hm0AmZhXHJnECELvR9ckSrMdwcPfTX6U
	 qqHppyYQcZzVHTWc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af05f5da3a-b8eb3;
	Sun, 08 Nov 2026 19:39:09 +0800 (CST)
X-RM-TRANSID:2ee56af05f5da3a-b8eb3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af05f47e53-6669c;
	Sun, 08 Nov 2026 19:39:09 +0800 (CST)
X-RM-TRANSID:2eea6af05f47e53-6669c
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/3] virtio_net: AF_XDP zero-copy fixes for arm64 and suspend
Date: Mon,  9 Nov 2026 04:38:36 +0900
Message-ID: <20261108193845.73621-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three AF_XDP zero-copy fixes for virtio_net.

Patch 1: on arm64, binding a zero-copy socket fails with -ENOMEM and a
"rejecting DMA map of vmalloc memory" warning whenever the device uses
the DMA API (e.g. VIRTIO_F_ACCESS_PLATFORM), because the static TX
header lives in the kernel image, which arm64 maps in the vmalloc area.

Patch 2: removing XDP can leave a zero-copy pool bound to a queue above
curr_queue_pairs. Closing the socket then fails in the driver, and the
queue is refilled from the freed pool.

Patch 3: freeze frees the rx/tx queues while the sockets stay bound in
the xsk core. The driver state of the pools is leaked, and closing the
socket after resume hits a "Missing register" warning and a NULL
pointer dereference in xp_dma_unmap(). v2 keeps the pools DMA mapped
across suspend and only moves the driver state to the new queues.

Freeze also drops the XDP program of virtio_net, so it has to be
attached again after resume. That is an older issue and this series
does not change it.

Testing used x86_64 KASAN kernels in QEMU/KVM (q35, intel-iommu,
virtio-net-pci with iommu_platform=on, x-pcie-pm-init=off) with a
small /init that binds an XDP_ZEROCOPY socket, redirects to it with an
XSKMAP program, and sends an ARP request through the TX ring and waits
for the reply on the RX ring, before suspend and after each of two
suspend cycles (pm_test=devices), then closes the socket:

- net: no TX or RX on the socket after resume, and an oops when it is
  closed. With a socket bound to an XDP queue and XDP removed, closing
  it gives "Failed to disable zero-copy!" and a KASAN use-after-free in
  xp_alloc_batch().
- v1: passes with an aligned umem, but with an unaligned umem nothing
  is received after resume. The XDP queue case behaves as on net.
- v2: all cases pass, without warnings, also with an unaligned umem and
  with a suspend cycle between removing XDP and closing the socket.

The test program is not part of the series; I can send it if useful.
Patch 1 is unchanged since v1, where it was tested on arm64 (QEMU TCG,
virt) with a KASAN kernel; arm64 was not tested again for v2. Real
hibernation and multiqueue traffic were not tested.

The issues were found with the help of an AI coding assistant.

Changes in v2:
- Patch 1: drop the sentence about cache lines from the changelog
  (Sashiko).
- New patch 2, for a pool left on a queue above curr_queue_pairs
  (Sashiko).
- Patch 3: keep the pools DMA mapped across suspend and set the driver
  state up on the new queues before NAPI is enabled, instead of
  disabling and enabling the pools while their sockets are still bound
  (Sashiko). This avoids a race with the RX path on freeze, stale DMA
  addresses with an unaligned umem, and transmitting before the TX
  header is mapped on restore.
- Rebased on net 30c71476d842.

v1: https://lore.kernel.org/netdev/20261107125723.33547-1-yanhaishuang@cmss.chinamobile.com/

Haishuang Yan (3):
  virtio_net: Don't DMA map the kernel image for the AF_XDP TX header
  virtio_net: Disable AF_XDP pools on queues above curr_queue_pairs
  virtio_net: Keep AF_XDP zero-copy pools bound across suspend

 drivers/net/virtio_net.c | 177 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 166 insertions(+), 11 deletions(-)


base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
-- 
2.43.0



