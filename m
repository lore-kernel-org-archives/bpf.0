Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DE025EF9C
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207295; cv=none; b=jIJhCbs84tPM95AVcPOpHBm8r7x6C/NhKj3oaMDHxTTJmYx9gdK0N8ksGpZCnB9Uw/tnU4R0lA8l8qetGAPjKaruuuSckf0CeNDjTnOlxtY2OUINuf7E8EmmvK4cCjdb0X83nRsAN3bTgQ4hIfuPbYymVtx89NAFgpRQC0ORKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207295; c=relaxed/simple;
	bh=/lNahW0qH8K0+NIvZOluCBfxYa6+/OAUPOrP6arGj7c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mbLdWi2e1LRE8oSdGyPhaFaLIKMnfSlAXd3n7ak1TexfK+9v8S476XFUl3oICZOSVcCKFz9SqfuZ0tlhji1VaIJDO7YmV5qzt+cBC1z4LBXL5+kNJmf2TB9skO66w5/lFiEMVoamSIWfwjEUvGMmGDDO2l4r1yVzbMvGyh8c6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhD8ywl8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhD8ywl8"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8f83efb5729so144167385a.1
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 19:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778207293; x=1778812093; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R4fDbIAs9UGsG5BRjIV/zutXsgn+/A8hyIYyhPO4W8k=;
        b=JhD8ywl8YTG+oe9AKARZqGyR6Z6S/zxlPtSDoZNErOEbpMBzzuzOZ2WFKZLN7fKUbf
         7c6NjfsFmN1pGfTfV0s1itkQ2H5eTAhbpkmaXA4bWMrSqxL+F/JxpCBNIm40u8dBPsLS
         xOrGOzTkTkqks7KaqmF65W3NoI8KdTKLmhpyEV0+52lVWW8dOTpUsj30+zP0Shhpid2H
         WTmsGg9I+XQdo1lr1p6tlq8eoxrfhUCSjZGyjteGOb87GAzHqfT7RfzM+MPaRlLd++VU
         gylL5ddgdHa9thRiDMrjmeSIHHd4HyXW6WdfFWXdQpUCnqYRfD9fiw9XkwECVm2KgZib
         L9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778207293; x=1778812093;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4fDbIAs9UGsG5BRjIV/zutXsgn+/A8hyIYyhPO4W8k=;
        b=Od1rygpxJBNd6W1BZNxePobGRkId7e4aKD9Jbtdg1FEWIMNNV/o06gr4c+umure9hv
         l8uhbc5h1qPcMVLCV+sQR8gOvOu/rlIJa7r7ydxj8gbvn4u14pGTA1ZFc0G4kzAvPr9X
         npjnGbuasMn1cpMKJNaT8OZKex3ou4zw2sDLAc28FZSS040lIfX+5CoddO1n3tqxYXN7
         yjDb4+SKxBP53yAn0ZRtzf/Q+tnqo1b1m4I0oqh8Wk67tHX76x5yqaa/JOSwNlD465vt
         q1EJqF9MsfugyuiKRP3yPvEXNiXxviGVO5CMTAJZdtsomAFOyeQzK+GCuwo+5Optwab3
         tXKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QvbLbmm10UzVjUUq8+P4OXdU7rvuYy9QBX82ARiRBeQ2Mnnblf7VuslexvmFLrgsMr7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJrS4+GIoXAY0h99h0teSYNyUVaexH+1v7KZ7gCLOcHuXkliCX
	7+zgCeJ7ynVOVB8zfsJrSZHUsljJ4DJSlUuZbnDkUdbRwvIwLMNBpjxz
X-Gm-Gg: AeBDieslPn8DpqgFZedRYBgxjRCnNQWRKy3XBUrhLwlAMi4/d4h5YHBNLL9U6p8pJ+t
	3UWTog5Wvi2F46pFIu/1RNPmBy1owp41DuG3Mr0oPha9XJ+4/pUcCv4IlmPOlKxapOx45YaF2pT
	nzLwVIGa9cx0Bld31ivxF3XVNZY0FC4WsGF5Tt9zFMA+gA4LqRXhm7i4gCysIsPK9X8YOz8zmEY
	GiA2rf3F80by8taGxxSwvR58GZHIhLZqrcykw09KGPQolnW6S0wo6nA3CmD2NtHljo0eIHQefFf
	KrwxB/bPCeu4IXBCMQ9QP+1l/GhYtzC+RH5QElee/k5xcjg2Prd1QQNAU/rs8ryNpaQNLWBeK3p
	MljI13Fcu2ilmphefphQT7wjwHMhPHOeLnPDaFX95NJ2iZmCGA9Zab+IKLOFyFEwefnyQzBLvt3
	RCkKx2t6Q38Q3+Chj/5I4hTg==
X-Received: by 2002:a05:620a:454f:b0:8c6:a2f2:d874 with SMTP id af79cd13be357-904d5d0d5bfmr1616784585a.39.1778207292615;
        Thu, 07 May 2026 19:28:12 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:25::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cd7dsm2077258785a.37.2026.05.07.19.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:28:12 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v3 0/8] net: devmem: support devmem with netkit
 devices
Date: Thu, 07 May 2026 19:27:45 -0700
Message-Id: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACJK/WkC/13NTQqDMBBA4auEWTslTPzDVe9RXGgy1qEYJQnBI
 t69kGXXD753QeQgHGFQFwTOEmX3MChTKbDr5N+M4mBQQJpaXZPBZA90G3pOH0lIs+v6uTW9Mxo
 qBUfgRc7ivcBzQs9ngrFSsEpMe/iWUabSi9no+s/MhBqb1jU02Y4WVz83TtPD7huM933/ANASU
 N+zAAAA
X-Change-ID: 20260423-tcp-dm-netkit-2bd78b638d30
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series enables TCP devmem TX through netkit devices.

Netkit now supports queue leasing. A physical NIC's RX queue can be
leased to a netkit guest interface inside a container namespace. This
gives the container a devmem-capable data path on the RX side (bind-rx,
etc...). On the TX side, the container process binds to its netkit guest
interface and sends traffic that netkit redirects (via BPF or ip
forwarding) to the physical NIC for DMA.

Two things in the existing devmem TX path prevent this from working:

1. validate_xmit_unreadable_skb() requires dev->netmem_tx before it will
   forward a dmabuf-backed (unreadable) skb. This protects skbs from
   landing on devices that don't have the IOMMU mappings for the backing
   dmabuf or that don't speak netmem. Netkit, however, does not support
   DMA, doesn't attempt to read unreadable skb pages and so doesn't
   break netmem (it is pure skb routing and redirection). It is
   functionally capable of routing unreadable skbs, but there is no way
   for the TX validation pathway to distinguish between a device that
   will actually attempt DMA-ing the skb and another device
   (like netkit) that does not DMA but also does not break
   netmem.

2. bind_tx_doit uses the bound device as the DMA device.  When the user
   binds devmem TX to the netkit guest, the bind handler attempts to
   create DMA mappings against netkit, which has no DMA capability and
   no IOMMU mappings.

This series solves these problems as follows:

1. Extend netmem_tx to two bits, assigned to one of three values:

   NETMEM_TX_NONE   - netmem not supported
   NETMEM_TX_DMA    - netmem supported and performs DMA
   NETMEM_TX_NO_DMA - netmem supported, but does not DMA

   With these bits, phys devices can set NETMEM_TX_DMA and devices like
   netkit set NETMEM_TX_NO_DMA. The validation TX path ensures that any
   DMA-capable netdev exactly matches the bound device, guaranteeing the
   correct mapping of the bound dmabuf. The validation TX path also
   allows devices with NETMEM_TX_NO_DMA to pass, knowing these devices
   will not misuse netmem or run into IOMMU faults. After redirection or
   routing and the skb finally makes its way through the stack to a
   physical device's TX path, the above NETMEM_TX_DMA check is performed
   again to guarantee the device has the appropriate binding/mappings.

2. On TX bind, the bind handler recognizes NETMEM_TX_NO_DMA devices and
   finds the phys TX device and binds to that instead. For the netkit
   case, if it has been leased a queue from a DMA-capable device
   already, then the bind action is performed on the DMA-capable device
   instead and the dmabuf is mapped correctly.

---
Changes in v3:
- Fix validate_xmit_unreadable_skb() logic for non-devmem
  unreadable niovs (should not be dropped) (Sashiko)
- Simplify lock handling in bind_tx, no premature release (Jakub)
- split NO_DMA changes into separate patch (Jakub)
- fixed some pylint issues, one required an additional patch ("selftests:
  drv-net: make attr _nk_guest_ifname public") to rename a variable from
  private to public
- see per-patch changelist for more detailed changes
- Link to v2: https://lore.kernel.org/r/20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com

Changes in v2:
- Squash driver conversion patches (2-5) into patch 1 (Jakub)
- In validate_xmit_unreadable_skb() to check netmem_tx mode before inspecting
  frags (Jakub)
- Lock bind_dev around netdev_queue_get_dma_dev() when bind_dev != netdev to
  fix lockdep (Sashiko)
- Move require_devmem() into individual test functions so KsftSkipEx goes up to
  ksft_run() (Sashiko)
- Add nk_devmem.py to TEST_PROGS in Makefile (Sashiko)
- Link to v1:
  https://lore.kernel.org/all/20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com/

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Bobby Eshleman (8):
      net: convert netmem_tx flag to enum
      net: netkit: declare NETMEM_TX_NO_DMA mode
      net: devmem: support TX over NETMEM_TX_NO_DMA devices
      selftests: drv-net: ncdevmem: add -n flag to skip NIC configuration
      selftests: drv-net: make attr _nk_guest_ifname public
      selftests: drv-net: refactor devmem command builders into lib module
      selftests: drv-net: add primary_rx_redirect support to NetDrvContEnv
      selftests: drv-net: add netkit devmem tests

 .../networking/net_cachelines/net_device.rst       |   2 +-
 Documentation/networking/netmem.rst                |   8 +-
 .../translations/zh_CN/networking/netmem.rst       |   7 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |   2 +-
 drivers/net/netkit.c                               |   1 +
 include/linux/netdevice.h                          |  11 +-
 net/core/dev.c                                     |   5 +-
 net/core/devmem.c                                  |   6 +-
 net/core/devmem.h                                  |   9 +-
 net/core/netdev-genl.c                             |  65 +++++-
 tools/testing/selftests/drivers/net/hw/Makefile    |   1 +
 tools/testing/selftests/drivers/net/hw/devmem.py   |  77 ++------
 .../selftests/drivers/net/hw/lib/py/devmem.py      | 218 +++++++++++++++++++++
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |  58 +++---
 .../testing/selftests/drivers/net/hw/nk_devmem.py  |  55 ++++++
 .../drivers/net/hw/nk_primary_rx_redirect.bpf.c    |  39 ++++
 .../testing/selftests/drivers/net/hw/nk_qlease.py  |   8 +-
 tools/testing/selftests/drivers/net/lib/py/env.py  | 109 ++++++++---
 21 files changed, 549 insertions(+), 138 deletions(-)
---
base-commit: 790ead9394860e7d70c5e0e50a35b243e909a618
change-id: 20260423-tcp-dm-netkit-2bd78b638d30

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

