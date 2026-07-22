Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0028C386C2A;
	Wed, 22 Jul 2026 03:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784689900; cv=none; b=m9kC3HeRDkou/768XGI0+EO5iCA/p/4Vx+HPqcX6I2AWFFFTtXIyX1PEZoQ7eeSxULdclPriL8/KZZmbJhAnyOVcrwY8RE2Gu57Ad3QGhzvJpbp4534gXMUx628PTcWp+udiiRMGxwIJN9iaxJKSHS0Cw+o4m7GVah8JUs7WFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784689900; c=relaxed/simple;
	bh=Xf6hNoFp/RHCtjn9u+60i0YtJ+gsbkKW2Akw4bCm8G8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z1261GRKjUWpjTkwfPojNHPZ01t1g7taVL3KLAbtcaqWNIXz2YctzpyP9IykEND20hDYDCpdRevyLwG4D8cWpmkyzBX5wb59rOS4wMhn627WYCUY5k4QtBzRR1+dZ6P5wgGlj4ML3wijJkIdmBJJ1Z8OHBz5iycZHyEvhxt9E5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h4fQx3PB4zYQtmg;
	Wed, 22 Jul 2026 11:11:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CD35640561;
	Wed, 22 Jul 2026 11:11:33 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgD3BnPkNGBqkTtqCA--.42292S2;
	Wed, 22 Jul 2026 11:11:33 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH net v3] e1000e: Fix out-of-bounds MMIO access by validating BAR0 size
Date: Wed, 22 Jul 2026 03:16:03 +0000
Message-Id: <20260722031603.1471127-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3BnPkNGBqkTtqCA--.42292S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyUtr1rZFWrGF4rKrWUXFb_yoWruFW3pa
	y3Ga47ur4rJr17Xw48Ar4UWF98Cayjyay5Cry2gwsY9FyUGry8Jr17tFW3Gr47ZrWkJF9x
	tryUZ34I9F4qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Syzkaller reported a kernel panic caused by an out-of-bounds MMIO
access in the e1000e driver.

[   82.868719][  T404] e1000e 0000:00:02.0: The NVM Checksum Is Not Valid
[   82.872328][  T404] Unable to handle kernel paging request at virtual address ffff80008894e090
[   83.085218][  T404] CPU: 2 UID: 0 PID: 404 Comm: bash Not tainted 7.2.0-rc2-g3f1f75536668 #1 PREEMPTLAZY
[   83.129013][  T404] pc : e1000_get_cfg_done_82571+0x70/0x158
[   83.140092][  T404] lr : e1000_get_cfg_done_82571+0x68/0x158
[   83.151196][  T404] sp : ffff80008ac37410
[   83.158922][  T404] x29: ffff80008ac37410 x28: ffff0000cd6a11b8 x27: ffff0000c58190d0
[   83.173919][  T404] x26: ffff0000cd6a11b8 x25: ffff0000cd6a0bc0 x24: ffff0000cd6a0000
[   83.189417][  T404] x23: 0000000000001010 x22: ffff0000cd6a11c0 x21: ffff0000cd6a11b8
[   83.205195][  T404] x20: 0000000000000064 x19: ffff80008894e090 x18: 0000000000000000
[   83.220545][  T404] x17: ffff800081c1a3f4 x16: ffff800081c19c10 x15: ffff800081e86510
[   83.235764][  T404] x14: 0000000000000001 x13: 0000000000000001 x12: ffff60001bc8a8b3
[   83.251301][  T404] x11: 1fffe0001bc8a8b2 x10: ffff60001bc8a8b2 x9 : ffff800081eae25c
[   83.266705][  T404] x8 : 00009fffe437574e x7 : ffff0000de454593 x6 : 0000000000000001
[   83.281919][  T404] x5 : ffff0000cf2b9640 x4 : 0000000000000000 x3 : dfff800000000000
[   83.297317][  T404] x2 : 0000000000000007 x1 : ffff0000cd6a11c0 x0 : 0000000000000000
[   83.312601][  T404] Call trace:
[   83.318662][  T404]  e1000_get_cfg_done_82571+0x70/0x158 (P)
[   83.329748][  T404]  e1000e_phy_hw_reset_generic+0x17c/0x1a8
[   83.341541][  T404]  e1000_probe+0xbd8/0x1988
[   83.350334][  T404]  local_pci_probe+0x84/0x130

Repetition steps:
1. Find PCI device which BAR0 size <= 4K. If it's:
   Device Addr: 0000:00:02.0   BAR0 SIZE: 4K
   Vendor/Device ID: 0x1af4 0x1004
2. Unbind the above PCI device
   echo '0000:00:02.0' > /sys/bus/pci/devices/0000:00:02.0/driver/unbind
3. Set the above device to e1000e new_id
   echo '1af4 1004' > /sys/bus/pci/drivers/e1000e/new_id

During e1000_probe(), the driver maps the device's BAR0 memory region.
If the device has a 4K BAR0, ioremap() maps only 4K of space. Later in
the probe process, when the NVM checksum validation fails, the driver
attempts to perform a hardware reset and falls back to the err_eeprom
cleanup path.

This cleanup path will trigger an OOB access kernel panic:
e1000_phy_hw_reset
  e1000e_phy_hw_reset_generic
    e1000_get_cfg_done_82571
      er32(EEMNGCTL)
        readl(hw->hw_addr + EEMNGCTL); <-- EEMNGCTL(0x1010) > 4K, OOB access

Fix this by verifying that the MMIO length (pci_resource_len(pdev, 0))
is large enough to encompass the highest register offset
(E1000_SYSSTMPH) accessed by the driver before calling ioremap(). This
ensures that subsequent register reads/writes remain strictly within the
mapped boundary.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v3:
- Align the minimum BAR0 size to the largest register access offset. (Andrew)

v2:
- Update comment about E1000_MMIO_LEN_MIN. (Breno)

 drivers/net/ethernet/intel/e1000e/netdev.c | 5 +++++
 drivers/net/ethernet/intel/e1000e/regs.h   | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..46e58e926f7b 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7450,6 +7450,11 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	mmio_len = pci_resource_len(pdev, 0);
 
 	err = -EIO;
+	if (mmio_len < E1000_MMIO_LEN_MIN) {
+		dev_err(&pdev->dev, "MMIO len is too small\n");
+		goto err_ioremap;
+	}
+
 	adapter->hw.hw_addr = ioremap(mmio_start, mmio_len);
 	if (!adapter->hw.hw_addr)
 		goto err_ioremap;
diff --git a/drivers/net/ethernet/intel/e1000e/regs.h b/drivers/net/ethernet/intel/e1000e/regs.h
index 6c0cd8cab3ef..1e875227eef2 100644
--- a/drivers/net/ethernet/intel/e1000e/regs.h
+++ b/drivers/net/ethernet/intel/e1000e/regs.h
@@ -242,4 +242,7 @@
 /* PHY registers */
 #define I82579_DFT_CTRL	PHY_REG(769, 20)
 
+/* Smallest BAR0 that covers every register the driver accesses */
+#define E1000_MMIO_LEN_MIN	(E1000_SYSSTMPH + sizeof(u32))
+
 #endif
-- 
2.34.1

