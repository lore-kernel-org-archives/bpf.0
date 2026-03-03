Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962938C2C2
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772531585; cv=none; b=B5XxFKu1r2NGaVRHwsRkA8Au+r3kB9mTBSS/7ziBywV9w3Mf1NnVnFANpkvR8NXbIegxvYPJNaVUg19Ls2CpH4XmjNgR+6kbSkgPhyeGfgegGFJCs5qxCwzhIpLXbJpDHy4Mtl3xUrKosNep8J75id4DcZpFATNrYD5iIay3RXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772531585; c=relaxed/simple;
	bh=zop48+CHzjssPpSGVwIPSIDDOAJmsgpDV1LUYuAyqN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvo4INIicCjh65GyuRdz5bMt3TKvj5um3wH+6IYZ6o9+MDSKkt3W0CAo3AfZ5/7L1arQqS5eYQh93jrLvGRAu/wtqwPOf7aQVJTzFbzXKSaPElcknZSjuVK2MpiCBOoRfBCjK8bMx9uOno566H60U/awBi1RuUOyiHleGaU9Nl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SNDgTe0B; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SNDgTe0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772531546;
	bh=ATGljxreJxuAb1q1oikhv4OCA7tc0nM8ns76mKHdqgY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SNDgTe0BKI77tBKxfqVPgD965tfWxdUGR+5ykhm5h7T7/ia59uUCY+S8CGZkFFpy+
	 wqPJdgJ5b/gxYGqfDp3Ow98q1a+l5bnM0yymRmREPODz8k7JnTyAoWmJ3UB3/8ilcm
	 mVZPWZaiywm4ZAI7ntJzSxGHvugVHgRJEidvnG6w=
X-QQ-mid: zesmtpip2t1772531541t62c48cde
X-QQ-Originating-IP: SS1liby2+gwXPBjoKfMJY0+aZRXrPxbs3FwxJwJsD6U=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Mar 2026 17:52:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16806137112662569003
EX-QQ-RecipientCnt: 17
From: xulang <xulang@uniontech.com>
To: bot+bpf-ci@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	clm@meta.com,
	daniel@iogearbox.net,
	dddddd@hust.edu.cn,
	dzm91@hust.edu.cn,
	eddyz87@gmail.com,
	hust-os-kernel-patches@googlegroups.com,
	ihor.solodrai@linux.dev,
	kaiyanm@hust.edu.cn,
	martin.lau@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	xulang@uniontech.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf v5] bpf: fix: Race condition in bpf_trampoline_link_cgroup_shim
Date: Tue,  3 Mar 2026 17:52:17 +0800
Message-ID: <279EEE1BA1DDB49D+20260303095217.34436-1-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <73e7c1b535284b3b65b44534db868fd5d8cee5530821278c07b8c64a46ce79dc@mail.kernel.org>
References: <73e7c1b535284b3b65b44534db868fd5d8cee5530821278c07b8c64a46ce79dc@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Oe8iwmjPdG65pKat3kf54Pt+EXwT4y4u3cPScrDU25ma1AOMm3+fcdtr
	2E5KDDdz/VB6YoUtl4kTKoiEOZmihoNoDTL1f5fBNB1YjWVrVv6NiW/vYvpI1g7ITHKy8Lf
	OQpFG1Lwq2WyBq7Wz8KuVQptS8kT6ITP7H4Fg8RRen/+hsS/fyy4sKPURjaeDGaFwG+cF6R
	Mnf70Qoi2IugleMBr4HsCb444BYNKVLPAe7lhVnmsJAIFiEV6eoKtJKX5NUg7s79/89ABHV
	etwSD7nEChPJMA7kNE+AIQaDRLC6AJeUs3cBjEv+4Z2uG7CsTWcb9gZ0LKFO1WTu+0rjffJ
	2Iw4Tps5GtNmGgpQ8/lVa6R62+ArII5Dep5XgYrFWpW1aTFkMgIgbL9xkRkN6zy5cpWhSr+
	vcU5DTBQF8vwdmmlDrzYZE92qtqA795az9cpRPrEfg1fD8BE3k2kHGaY2FriZIP+M8G7hUC
	BH6W9Eiq0ibMipUbNsf2b7qcFTvnkadjvqZjfY9hqLL42n7kKVqfjQVD2KYyRInmxBhQ1nb
	VrzbuCkaDaB5VGXTfh7t5SzTiBy8dNzPmIXCFn+hdv3NGoO0CweOMOKDvTfTB9B74d1hvte
	hoWhz5HHix9mMoj7cssJ/saiGY4eaAgmBHtW3aAqKuHGtPUjyXPW5MEv/Cgfhzco4KO0xUS
	X9rIPkemWKNuOTKetjuiN7pt+YzNgypR60CZqFUZoQXJ/z/+rHOAttM8cEmaEHFSh/Io0D6
	TDXOSeF7izKhBxDkadAKfJ0/ztsR8Lftz1GWC1z0imcx47JUVz53+HhNimTMnf3wTUzfgjy
	HFBUORaXHFgZEVOPa8NDBCatuzqlO0Q9tAv5OAn2uxo08YXA1CXL70zT96KszAjjPHqK8x5
	MaIcJQY/sMey9AfTwiWmqyhQ1jS+Cl7Lwy4EG3S2UcvtFeKSVM7Glq1sGd6lcO+t258djRr
	84KMjgjjnP/n0uTKJQ6IF3jpybYtPXxpafLuVZX4eJUXba9wBcUjmdrvdKFbZEh6HNS2xRD
	KlWqis5eqA+wZkRrKVDWcDkEafrU26pNHzMGn/0l/xy1VhnZMfSrhnnE7IEzIBMeg3Lv3pi
	Q==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Lang Xu <xulang@uniontech.com>

The root cause of this bug is that when `bpf_link_put` reduces the
refcount of `shim_link->link.link` to zero, the resource is considered
released but may still be referenced via `tr->progs_hlist` in
`cgroup_shim_find`. The actual cleanup of `tr->progs_hlist` in
`bpf_shim_tramp_link_release` is deferred. During this window, another
process can cause a use-after-free via `bpf_trampoline_link_cgroup_shim`.

Based on Martin KaFai Lau's suggestions, I have created a simple patch.

To fix this:
   Add an atomic non-zero check in `bpf_trampoline_link_cgroup_shim`.
   Only increment the refcount if it is not already zero.

Optimized testing:
   I used a non-rigorous method to verify the fix by adding a delay in
   `bpf_shim_tramp_link_release` to make the bug easier to trigger:

static void bpf_shim_tramp_link_release(struct bpf_link *link)
{
    ...
    if (!shim_link->trampoline)
        return;

+   msleep(100);
    WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link,
        shim_link->trampoline, NULL));
    bpf_trampoline_put(shim_link->trampoline);
}

Before the patch, running a PoC easily reproduced the crash(almost 100%)
with a call trace similar to KaiyanM's report.
After the patch, the bug no longer occurs even after millions of
iterations.

Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Signed-off-by: Lang Xu <xulang@uniontech.com>
---
 kernel/bpf/trampoline.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index dbe7754b4f4e..894cd6f205f5 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -749,10 +749,8 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	mutex_lock(&tr->mutex);
 
 	shim_link = cgroup_shim_find(tr, bpf_func);
-	if (shim_link) {
+	if (shim_link && !IS_ERR(bpf_link_inc_not_zero(&shim_link->link.link))) {
 		/* Reusing existing shim attached by the other program. */
-		bpf_link_inc(&shim_link->link.link);
-
 		mutex_unlock(&tr->mutex);
 		bpf_trampoline_put(tr); /* bpf_trampoline_get above */
 		return 0;
-- 
2.51.0

