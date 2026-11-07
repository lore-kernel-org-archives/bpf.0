Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794027494;
	b=m/ZB55983oFFsnodQ9cYYIAZc5FPE+kkbzYj8piftKyB5DuzTXtcyTt7BrqHhq034Nuc
	 fl6NF7c7szjuUTnLJwvTeRv1gK2ga7KwVX9olyIe1supcCfKcG/Ehifw3Vkb3cni+dEdD
	 I39mrSGcxlb8PhHJ6PU/VCUEXBqkR+RIRkHgQvZR7fA/LCFCKn2fmEz84kVbGYDG9LrWX
	 YjB3hlNEZ7nO+RuTxS57/o7yDm2AEn5suBhy3hBxEzC4CG3d/tfWgpBZt8nB3xndSD9Dw
	 4oGl6HxFzI+/FAy10+UwTGl0/0yyZ8aQD5RlGL2G2JC+nD8jw+DRsU+XK57I1E2/4fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027494;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TjJfxDxxVg+dnFXyzUyU8v0lNKHjR9TDaES/0qqPSJY=;
	b=GyLzzm2UpFPKlBEkl8D6oFwi8I+bZJDarE7Tp2W4WdmvWyA+k32ylY3eDbPc4z+kwQUA
	 1XVnjPeDJd2p8jn9fVi8EMQPLj2kciMCTnJD/rfA7TFtIIy73Sc9RVFU0LTGG3GiSxHNw
	 zh6KVkDO421/pAYkeGRl8kvUnr2lK7em5THhqjO7wMWnNVjf2PVnAQ1AhUDSqPJlV85pz
	 852uXxIshBitkbBXxQYFANaCz73qJXAtwz/VH77ZZqKQrYQbio0rIVby9ubLrWuT+UmQz
	 dfx0VCNHL2z+fUT6CghSVUNwchkY/4cQbLJbtbuj4KkH7Ur0rrtG2Zr1z8KMa7Ibyhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XOSJ4bbN;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD051606A326;
	Sat,  7 Nov 2026 04:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD051606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XOSJ4bbN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=XOSJ4bbNdngtvTUhpWu01KWnZ6inyNGFFKwblXcHP5uxiL9R5zVCtUZGGUHNrloB0SCwJH/21baZr
	 fsQg1SDcFnOFRKR/nhY5jiedtcQRMQ61+2LTOZlrhMm1nHSsbDNkBCvdpj9VRnNV0CKVm/VQ6CO6Ql
	 eOXuuH8BhoDqwNMA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86aeeafd25ca-5553b;
	Sat, 07 Nov 2026 12:58:00 +0800 (CST)
X-RM-TRANSID:2ee86aeeafd25ca-5553b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36aeeafb3fe6-3a4a9;
	Sat, 07 Nov 2026 12:58:00 +0800 (CST)
X-RM-TRANSID:2ee36aeeafb3fe6-3a4a9
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
Subject: [PATCH net 0/2] virtio_net: AF_XDP zero-copy fixes for arm64 and suspend
Date: Sat,  7 Nov 2026 21:57:01 +0900
Message-ID: <20261107125723.33547-1-yanhaishuang@cmss.chinamobile.com>
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

Two AF_XDP zero-copy fixes for virtio_net.

Patch 1: on arm64, binding a zero-copy socket fails with -ENOMEM and a
"rejecting DMA map of vmalloc memory" warning whenever the device uses
the DMA API (e.g. VIRTIO_F_ACCESS_PLATFORM), because the static TX
header lives in the kernel image, which arm64 maps in the vmalloc area.

Patch 2: freeze frees the rx/tx queues while the sockets stay bound in
the xsk core. The driver state of the pools is leaked, and closing the
socket after resume hits a "Missing register" warning and a NULL
pointer dereference in xp_dma_unmap().

Testing used KASAN kernels with a small /init that binds an
XDP_ZEROCOPY socket to eth0 queue 0, runs one suspend cycle with
pm_test=devices and closes the socket, on virtio-net-pci with
iommu_platform=on,disable-legacy=on:

- x86_64, QEMU/KVM on bare metal and nested inside a KVM guest:
  - without the series: WARNING + KASAN null-ptr-deref + oops on close
    (patch 1 does not apply to x86, binding works there)
  - with both patches:  no warnings
- A full x86_64 guest kernel with the series passed virtio-net ping,
  a 100MB HTTP download with checksum check and suspend cycles.

Haishuang Yan (2):
  virtio_net: Don't DMA map the kernel image for the AF_XDP TX header
  virtio_net: Keep AF_XDP zero-copy pools bound across suspend

 drivers/net/virtio_net.c | 70 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 4 deletions(-)


base-commit: 37dfd0efbfffc20a57e41c2eb349ac49b1ca1ff8
-- 
2.43.0



