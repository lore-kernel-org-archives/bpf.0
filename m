Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453244;
	b=lcEZjhetM9ISafNIPi5R01dLvWkppzz2TxOdEWFg7utUTK2dCPwcl8SKoCizZLJp/7uW
	 nbbZkm7UnKuQz2N8MA+ftf1yvX0zfMKpopdfpl9vdrWtQNnYWvmAv7v/H5FkfSI8p9KXE
	 mqtl+XjKoH+i8IPQu6aIR2p4/PmhwffizgfCOMLPGSgskUNsLMkPlh1sGSv45wD7a4Sa4
	 lsi/HB9cTtSuO1gZDHSkCMDHIp/m25cAD+d+5xBCn2o56gjgHRDI57JSjcx6BGdQMvWJo
	 jZXoOUZoWm+SFzGgPWN7biiVgPW2aIGqnM6XEwAXQSFc7KrZQUWbxRnVW5QRthDoP3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453244;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zqikwoBUu0eCLYMp7bcVrEZ+6pwvkxFl8gLa2oK3B4A=;
	b=LRqmLb2H31ev4un+U4ylsda1K5w/PHQZvtrI0sthObj6JIoes93Df7IDSdToc6D2KNZa
	 9m2aPmiz7ZxilVShW9nFozSAfMnuYAgkJR1shx8fPCHNsmKpT9V+4IHtvnAavEfzgjokr
	 0Ghf5OyttGmUxo8OrfSx1EPBOcLRRgXSGHnXelsrSYmZ5Yibqx3Ns2egHqCP//ZtJMKy4
	 rYblGkvMLfXJ50E7IyA4dbY1eGJa7Oj5kLWLXtv4kZHLDQfVGxTOHlw6dYtPs6h4RLthz
	 +wzBPG7QmkrPYpm594BYYt5Tlj9x/bnGW5bmph9Vd6JYW7HBDQjeFFdi16ucJftetmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=VM5jNWB4;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A1606A31C
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 03:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E07A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=VM5jNWB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794453233;
	bh=zqikwoBUu0eCLYMp7bcVrEZ+6pwvkxFl8gLa2oK3B4A=;
	h=From:To:Cc:Subject:Date;
	b=VM5jNWB4/3G12gbRHQ/Wulr/+YehAPyb4dJz2NbPZmA4L372gC2lYFhMZPgj/MlSw
	 FIn4A5fDLwPRsWpwDOVSY7y8GjCK9TNkzZXNGr2gI88j0/YpTvbChpEixXqpO4d2x+
	 8V4/emXsaFdDz2pfsSDK4iVrd/rCcWCx4MWbVmbE=
Received: from HAPYCAO-MC1.tencent.com ([61.151.228.147])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 37283A0E; Thu, 12 Nov 2026 11:13:50 +0800
X-QQ-mid: xmsmtpt1794453230tx8r0n4a2
Message-ID: <tencent_84A432FD1AE7054D384BEB36958789AAFA05@qq.com>
X-QQ-XMAILINFO: MqrcRCpyXC2Gc4tZ1E4IO5J2s34IEUI0ldAhgdmRrPeM2Oqo5tWCy74j9zK8UC
	 yGsn3Vxi9pb/q33si8GWT+mb3+g5w8WWP0GET7wk1XiAHECfwe7xJnmX9CiZ1aaUchJGhKHXMq8z
	 FXiUJMh52t/eri7SbFG8ZrLWin3An+N9DduaJ9zX5YZPVMkuLMLs5qkFjCifxI/ToKh+sPNvPBR+
	 7amyzZs38HMY9QJ5Mu3T46Y3YsTilUCxvkx3VCpCHLhxU7xhFjPieaDXNp34KqbYC+5H4ZH/j5gF
	 ru6uw6yn9rcGXgwx7xcBrHxoZ6yoDEEqGbhDcwZqBNRp/LfRZxO72kn9T0xtQEB1gp1K2UuarU6E
	 V66PIAv/Wg0e8pCJUSBWQ6oR/xEhuOVN66wjIm0JnmDcdcxyV9l3YpBYzYhFrHa4EGu6oWUjlGty
	 aaYrqGEKoXU3ds3P4qb45PStJVPctQev9lUi1dWBqp5EKQBB78Z8Zdwh9zNoRqKa4wsYD4091NF6
	 xQ2yPYTVKxMJ92ZsUJvjRp81yL1ELGxQb+bD8TKpc+lbuHd8y4qKa7bTCp25nua6BC2wsxvnwpI4
	 drp8NCcdw73i8pxJ5VOIGkSLe9pZnZLqLRROc03yL5o20JvM15/eFImxgqDnomnSIQc/2oexMWuw
	 eFodbpmNjzNV/W2+AzpmVCT8QAbKbqyA0B4oRqq7kq4WuaYBYNBggrWO1G/Rmjj43akkdwGw35if
	 4Z1bmjODgwjpCHng8Bg+Go6z6syYYP/jI79UoMSJtUpgX2ZKQB6UTXNCvP01k9WQZm6VKMweTxKk
	 hyxKX9OH/nsi9XQ1tP6/vUI0HmOQHvzBTOx1q9uzIbRe88U/Wl4nIQ690IiPohGXpAYss9iylLd5
	 aCLQQKdmIuugJC4mpS5hPsotVDel1DWteaVLGv70jIjhzJBWt+29h+h66tWsbyroLrPdJIapaaEU
	 eTihiErf7PJQYBozakHUP71ZUsRZF391aCs8RuuwcdKiAdtbeMi0acsomnaSJvgPvSaEHxvUU0ni
	 uWjmCQQyHQiYZejpt4KrYPcfoKuSIHDdQMWteK6ZdDFOUHYPrmBmHQO6YMQMBvpF4Yuh2c3Zsm/t
	 tJZpcuWHioTQ2VMpY=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: bo cao <treebacker@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	gregkh@linuxfoundation.org,
	Bo Cao <treebacker@foxmail.com>
Subject: [PATCH] bpf, sockmap: Fix ring capacity invariant break in bpf_msg_push_data()
Date: Thu, 12 Nov 2026 11:13:41 +0800
X-OQ-MSGID: <20261112031341.92203-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Bo Cao <treebacker@foxmail.com>

A push at msg->size ends the element walk on the ring's free slot, so
the "no space, absorb by copy" fallback reads the free slot's length
instead of the last live element's. Nothing is absorbed and the split
path runs anyway: with the ring already holding MAX_MSG_FRAGS live
elements it advances sg.end onto sg.start, all NR_MSG_FRAG_IDS slots
become live, and the occupancy (the distance from sg.start to
sg.end) reads 0 -- "empty". Every capacity check in push/pop is then
bypassed and later transforms corrupt the element list.

Without the fix, a single send() with an SK_MSG verdict program on a
full ring deterministically crashes the SK_DROP teardown (arm64,
7.4.0-rc2 + the bpf master sockmap series):

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
  ESR = 0x0000000096000004  FSC = 0x04: level 0 translation fault
  Internal error: Oops: 0000000096000004 [#1]  SMP
  CPU: 2 UID: 0 PID: 546 Comm: skmsg_panic Tainted: G        W           7.4.0-rc2 #1 PREEMPT(full)
  pc : sk_msg_free_elem+0x90/0x148
  lr : __sk_msg_free+0x8c/0x10c
  x14: 4141414141414141
  Call trace:
   sk_msg_free_elem+0x90/0x148
   __sk_msg_free+0x8c/0x10c
   sk_msg_free+0x18/0x24
   tcp_bpf_sendmsg+0x298/0xa54
   inet_sendmsg+0x44/0x70
   __sys_sendto+0x120/0x198

put_page() on a zeroed scatterlist entry. With the fix the helper
returns -ENOSPC, the message frees normally, and the crash is gone.

Never read the free slot in the fallback: absorb into the last live
element when the walk ended on it and the ring is full, or fail with
-ENOSPC if there is nothing to absorb, so the guard slot is never
consumed.

The bug was found with LLM-assisted source auditing and verified end
to end: it is reachable with CAP_BPF/CAP_NET_ADMIN and confirmed
exploitable for local privilege escalation (details reported to the
maintainers separately). Regression tested with
tools/testing/selftests/bpf/test_sockmap.

Tested on top of v7.4-rc2 plus the sockmap fix series currently in
bpf/bpf.git master (b889ea1f6dbe..0048086bd361); neither that series
nor the June sk_msg fixes (f3f34ca45b96 and friends) touch the ring
capacity invariant, and the patch applies to mainline and bpf master
alike.

Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Signed-off-by: Bo Cao <treebacker@foxmail.com>
---
 net/core/filter.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 1f81a3dd6a5c..371c090d7f8d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2892,8 +2892,29 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	 * offset case because its the common case for inserting a
 	 * header.
 	 */
-	if (!space || (space == 1 && start != offset))
-		copy = msg->sg.data[i].length;
+	if (!space || (space == 1 && start != offset)) {
+		/* A push at msg->size leaves the walk on the ring's free
+		 * slot, which is not a live element: its length reads 0
+		 * (or stale data left by an earlier ring rotation), so
+		 * the copy fallback would absorb nothing and the split
+		 * path below would run. With the ring already full
+		 * (space == 0) that path advances sg.end onto sg.start,
+		 * leaving all NR_MSG_FRAG_IDS slots live -- the ring can
+		 * no longer tell "full" from "empty" and later
+		 * transforms corrupt state. Absorb into the last live
+		 * element instead, or fail if there is nothing to absorb.
+		 */
+		if (i == msg->sg.end) {
+			if (!space) {
+				sk_msg_iter_var_prev(i);
+				copy = msg->sg.data[i].length;
+				if (!copy)
+					return -ENOSPC;
+			}
+		} else {
+			copy = msg->sg.data[i].length;
+		}
+	}
 
 	if (unlikely(copy + len < copy))
 		return -EINVAL;
-- 
2.39.5 (Apple Git-154)

