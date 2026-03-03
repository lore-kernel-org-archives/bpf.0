Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF053845BE
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527034; cv=none; b=S6wOdR+Hyu5UbULWc6nAfeiS+KtxTF8ER1P9XTLY7q5ar6a6iZqAYl38NmlizfLshBJxfWsWU8hKC74PNdFiHqjiiPZnJW5kDscx9bXiBpY3/TaiZz6X0nvfAnrPLLu4dj1wAwBUOLTJpHlWXMrw2rpS/Ug0TsY44rh27IYy0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527034; c=relaxed/simple;
	bh=zop48+CHzjssPpSGVwIPSIDDOAJmsgpDV1LUYuAyqN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hb55XjubErLdUXaAAsclpv+PJI1aUGyNCbWSanEsJddfw3p8Rydc0cH2lgk0Uu2ILXFeufr0LqcytpuGzF5zw08PrF2+YW2pq5muGKKN5/F1yRxiwumtutozvZb3oZJzGYseVXEHtMk9A24Nsdo4NA8Ln1470b8AChLkGCtaOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XgrFGCGC; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XgrFGCGC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772526997;
	bh=ATGljxreJxuAb1q1oikhv4OCA7tc0nM8ns76mKHdqgY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XgrFGCGCy3nhyYey+ty8CINB3HMlXgH1lihG8F+m5GD9/xieCFASv/FDkSz8VIBgb
	 rNnzUo1XgKHkBCqt0vuF/XekL86/aGVCBrVIloZWk4WFxT70Gi4hSbY7WhBZktiKwi
	 Jt/5iBCkHNN7PSEIkxfLQULqJ48AKSxp3WCtaXNU=
X-QQ-mid: zesmtpip2t1772526992t424fc284
X-QQ-Originating-IP: rxbWQxnTmsbOqdi30IbbegNnmrnDi+Q68Q8oiCrlV58=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Mar 2026 16:36:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1541072100980126208
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
Subject: [PATCH bpf v4] bpf: fix: Race condition in bpf_trampoline_unlink_cgroup_shim
Date: Tue,  3 Mar 2026 16:36:26 +0800
Message-ID: <851F26B7D9E91336+20260303083626.1107524-1-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <ad50571a-ce13-47c9-ba5d-570adb4fc689@linux.dev>
References: <ad50571a-ce13-47c9-ba5d-570adb4fc689@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N3IC8um5pMyYKUlmS0tZUmJXMJ7FJFGbsKVr9fkIHGKLi/uKhYXDFe1p
	A5isPYQKnCSDJE6Urp80RHaMLPp2KUTby6hwxAJjLZuHqHvPKBe4Rf8wtDdKwWufisrtchQ
	SkLcIKyJi+IJdnpOwClF6GbdTLqlgn+mbrm8GlJH9UwRxAHXaTePuTCMDqRHKY6Zy3DJIhq
	3jeKPtbKJRMPtVdxSMt/WQ5QpT0DwImC8o02Hl/isAwV74MtL/WLDBlHQFkdKtZuX88P5pD
	9C57bEMnbbs33NrysArH/bbgwMNxAR7RHlDqVglK59qm69dX39WM6q0vSmPDnUZykawhvCQ
	smMxJoaaAvZOj9b2PnFiTnTl7AOGFVxcAxU4k4hbTJSirmyPXQrFAQOLpHBMl+pDGtw1OyA
	UH0PV7Nz7nfjvGs1XTkEl8QVnxUZW14q4SBPJgWDnnAa/79fPi/pPpi2f0gQL/JQjduHcEE
	kyAneV4q7qnPSJy9ZUQS6ypePbl85jMjziEOMLncXUBqeWMW08ALhxFVDCm/bOUrc++ysHc
	YgbduS+UOf5hdkaqLAeJlDNPunRmJN4LMuyJFsG8KJWN6sfIoAPCuXfMytyv/FpihMJoFWb
	hzA2nH1UEAp7PvJWqqeTT2oT2CV43UDtKuVoxoDzyldVHcL7khsLBPY+64/Ltea2yqIbDzO
	i5cN8FMMA3hQfuMAdK07eRwT8SQNsQ/cLKFlFrcR6L0YwpnQEXTu3oliRXfcjrQsogq0rdo
	sAsWmYWZ6ZLwpOEwPhOYNzqkYTKIDKj1RgCYGPicBIareFmpnRZA2bkgfT2+hYETi+3i+Kn
	u9HBKnOw/nxLnDE+hctHtRsRwOo4s8JKcMpxvvpcgdXsGwYfHdQGeIuNm7A4aim+JEdFRyT
	PFzMhYRszI4+8dDGBBWyel2q6o8W+vIh8+D4WtwHPuDSbm+xm1ALG1Ey8z3qziP2CT3X2vv
	cEn/kF8w9S1O26jlK7zQUSYdiymNyqZ8XkJI5gfVs0G3hmlhrY62vJxut0hhlKKWkQT9575
	HWVQIoEiaeSZax6y808G3nFVN5VTd6XUZ5W4jh8xIDMnBiqqve
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

