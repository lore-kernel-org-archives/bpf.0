Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9226D3254A3
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 02:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772245582; cv=none; b=MGuEypVEllbEwilczu0NvB40ylz2IUbJ7MTgboGy82DScG5phtxQVS8dFR9V/DeTiLkP0fJUCaNJgDybcDKtgPqVX2dYYXC5HXsWOUm+8zzOf7k7rFo/o2Jqfpzxz3E8jVh3OWHxJ5fhZnzO/tlWWJcbNMwNGebvYDV6XxXtrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772245582; c=relaxed/simple;
	bh=+WedI4SDPcAyOqs3Esa+dbDCFMV2GhorkTEI0NKRemM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfCvhe0j54ZHIsT2AWeXT9pUyVDaBf4oUdZ0Ip3yQeoT/j3f2OOGsOwQr9ULp1Xa23w3XjlzZDEExVFPaiGcAAYL2kKjMBtHFIt9pQSlJpHpZNj1bm7hFY0za7Jh2qxQtCI1CaQ4Ujn4dQVNRlqb0uTqyhAVfr5bPrP7CrFPx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KJpB76+F; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KJpB76+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772245533;
	bh=W580SusHpQxRbve0Xr47P2Q3tDjZ29+ojQpMZapetAA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=KJpB76+FUUeYuWmlP4QDh5IyuEJYI9wH7iOtNROaIEowVrmRf2nADP47U/Ynt64qD
	 wIVzUzIBZg/uXkFEXdp/Aie+gm1LyPvVLGEvjoP3G3w2Bk94Bwi2s3aPTOgAKdEHnC
	 mzp9pQXJl+R4p7Vmv53+7syqH3uVzehdCESvSlZg=
X-QQ-mid: zesmtpip4t1772245528t10951844
X-QQ-Originating-IP: Z4lL1BVlpW/e1btHOm8ABmMBgFyVEgfv40QhRWlCLbg=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Feb 2026 10:25:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3126562635015746238
EX-QQ-RecipientCnt: 17
From: xulang <xulang@uniontech.com>
To: martin.lau@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bot+bpf-ci@kernel.org,
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
	sdf@fomichev.me,
	xulang@uniontech.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf v3] bpf: fix: Race condition in bpf_trampoline_unlink_cgroup_shim
Date: Sat, 28 Feb 2026 10:24:03 +0800
Message-ID: <FFFA8066FE63B894+20260228022403.99235-1-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cd99eba7-ac03-4b53-a79c-a6206abbddb6@linux.dev>
References: <cd99eba7-ac03-4b53-a79c-a6206abbddb6@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MDqtQ4jGWXAGid+dzn3wo+k+l88CsHFLvju5NbskvPuFzAF94KXX1/kw
	rSv/qtPSsGQBMqdCd+vfd0UFa4jp/vPDziegW2v1WP5WdYGhUJPdMA95msYDAdJntyA8Db1
	8vgZWwfN7BwNUZUKKwJqCpW78/L1f8Ox4C0Oxpo5l/j2zokU+8EkXHLTa3Mi62B0mh13Rqd
	kzb5dSaY4EJvu3dAwsCE9j6TPHmINP/pUvjWiNQWHp6AT+bjr5s2BfBJgUCTeu54kcW07p3
	ipk00VIyty/8Oqa58rGWfSj6eoWfB82O4rq1eYhIrZDXismOix2gQFLDm10rXfA4TVNdYXk
	zc9wKlLSrValukpUcdKbX5MU9Pw+vCD2pXwd9letw8ml///wXsmRGtEy1y6QBV4esGyF3oq
	xk1B43bRgB8Ih9lpXt8MIat8wn4Q3GkiBJ3ZGVj8WBrPxLqC+ubGcnB5qo9ISfFVBA9PYaj
	gArjvc1yQsjcqJi6YGkbQAU4KcPvMfpFY5bgbjco5skmIK8SO7pDwBPd8DZTnu3Irxi0DL2
	nMDvgtGQnTh33DR2+3bcNb4odRSJordxio8vN14ZqbdZJs63FrN1O30tCa+r7pTGfOhJKQH
	p4P9keXyROeo2bm2o/tFl9JDLzd6sAZ/0BnaooR4nxTS8CoX2uAzui0wqFxAHPMbHLYTX8C
	bp/qBhaOpuHwD2kV/ynfNvRhSpIcG1gB2b9Q1KmoqbLJqm3tt/pdbEeBuahFnNZvwH25UhR
	2JHXNL2/ERBA8hAuW0iBBYFjtWF+bWnhnhxbtuLneuZLlhnPDxmxvXwtH043pewX3nJwkwT
	w6aoz3J0JcUsuWxDLWaJj3cwFyzmsAlgWp0l8hOErNt1hl/TscSoYIJCvLLqrzNgsuky3Gx
	JoS++ke1kMuWmuJ2UP1EwVLX22oMAWbHMv4MMHjY1A2mOhPNkMjriDxMe6O6e7u8x179vU8
	HJfkwyC3RqjzTy4JMtchMcyiumI//BxgHpT7vNPGWt9Md8snEREeqTxXHUz0GxAYvqL7HQO
	75Dpd9mnbC4eL0mgEtD8hVImlOhho=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Lang Xu <xulang@uniontech.com>

Based on Martin KaFai Lau's suggestions, I have created a simple patch.

The root cause of this bug is that when `bpf_link_put` reduces the
refcount of `shim_link->link.link` to zero, the resource is considered
released but may still be referenced via `tr->progs_hlist` in
`cgroup_shim_find`. The actual cleanup of `tr->progs_hlist` in
`bpf_shim_tramp_link_release` is deferred. During this window, another
process can cause a use-after-free via `bpf_trampoline_link_cgroup_shim`.

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

Signed-off-by: Lang Xu <xulang@uniontech.com>
---
 kernel/bpf/trampoline.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 976d89011b15..ac99725403ad 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -779,6 +779,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	struct bpf_shim_tramp_link *shim_link = NULL;
 	struct bpf_attach_target_info tgt_info = {};
 	struct bpf_trampoline *tr;
+	struct bpf_link *link;
 	bpf_func_t bpf_func;
 	u64 key;
 	int err;
@@ -801,12 +802,13 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 
 	shim_link = cgroup_shim_find(tr, bpf_func);
 	if (shim_link) {
-		/* Reusing existing shim attached by the other program. */
-		bpf_link_inc(&shim_link->link.link);
-
-		mutex_unlock(&tr->mutex);
-		bpf_trampoline_put(tr); /* bpf_trampoline_get above */
-		return 0;
+		link = &shim_link->link.link;
+		if (link == bpf_link_inc_not_zero(link)) {
+			/* Reusing existing shim attached by the other program. */
+			mutex_unlock(&tr->mutex);
+			bpf_trampoline_put(tr); /* bpf_trampoline_get above */
+			return 0;
+		}
 	}
 
 	/* Allocate and install new shim. */
-- 
2.51.0

