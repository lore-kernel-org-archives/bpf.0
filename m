Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99EB1F03D7
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770362183; cv=none; b=uZhmA/c/7YWrH+CO6sOhXEUALG/SrZ9o8XX93oTUH355sH/xUG+Krh3+m1mI4GdsmC6uSFTvouLYnWJdRewGH+K+1wYR6aLfUwDWoPESxUDGNAXDgk8z9tRfK1bXIjvln3iCknsynNUY25HhZxLNnuWd9771FS3t06wdCmhhb0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770362183; c=relaxed/simple;
	bh=L+VQ+PxTCyWvrHd+1VewiZQRFO9LPlaHeUzZMf2rcjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k82F4OcgeFqxFo5bOGeub1Li6oB8b4G92c4stoHfyYlTcycGlVa0SFJdcGqXQaWnbuJp551dmPBhl+kcxXyB89y/EvzNOgEP2KC5DsCnJKhN/ftQ10pV5DDUBFtmZ6xMWxWQYg6/Zdwr7Eo5zrs3Rv3HzqcmzdmCwWElYTcdGik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Rl7FdjFu; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Rl7FdjFu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1770362061;
	bh=/Vul21+ISQacwTUF7OTfl8dj1bgbi/35CWI7daY6gKo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Rl7FdjFu18x4Sh3IonTe//n8MkrsRrIR+3NIQ8tWbOevbXQ2cRjFZpCKCuwO3iW8+
	 jJUVIsDMO111m1XcnRGT018v9zc0PDejSiSS0r3RfVeocvGZG8NvDiDBIqZ10mSDHD
	 GGOdMYyOzMZh6DeJ79HxkBtEX70z8pnPGRRBD0Jo=
X-QQ-mid: zesmtpip4t1770362043t2cc3e028
X-QQ-Originating-IP: qJD/3LovQX6BjVuq37tqGMuBs54va7/MIAHhdsEEj/M=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Feb 2026 15:14:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 204545660866557785
EX-QQ-RecipientCnt: 10
From: xulang <xulang@uniontech.com>
To: martin.lau@linux.dev
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dddddd@hust.edu.cn,
	dzm91@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com,
	kaiyanm@hust.edu.cn,
	sdf@fomichev.me,
	xulang <xulang@uniontech.com>
Subject: [PATCH] bpf: fix: Race condition in bpf_trampoline_unlink_cgroup_shim
Date: Fri,  6 Feb 2026 15:13:57 +0800
Message-ID: <68AC3CE38AB1BD07+20260206071357.4075301-1-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <dd71a6ff-929d-4958-ac73-99b4852808e4@linux.dev>
References: <dd71a6ff-929d-4958-ac73-99b4852808e4@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OXbMFIZh3FGE3dBHeeypkrrTDVXH+2vYARUQyuXHs6KyZoxVG7KNkXim
	daICmNPEcGl7nMA99WHe8XA24HJYQm8nMO8R27no7Xo3OXPSW8EXDma6nKzmz4r+tMdG21U
	aFP5CCdWIXS+N/GYoq+wZxu7rUixGeJcckMHw8p/KgaSu67fg7LwmJ1gnzHKwCJ66eHFdRJ
	OKz0XCMervRHspt0/kf/N7+OdJW0+KXWig8eR2SOgw21Uow6cLTEKPnRUWJk+tsY+B0wI4t
	4Vaj5XWnJoXAEa3CQoH33gL0Z39mBhPsamHwH6kOSSVKg4GLcnbfg4PcycfS/+xhxQB5pHY
	/h1JYsCoc7n4M19PC6H1MliWGuflO08riwZHjTPckIkT1zxJdQa460RMc6eIdlKfTsjv3DL
	I1IsW1ECbz4+lmne20XuuNBXebTIeouNSo+kt/Kw+KnXkFBmYCVvli6vpfE1kXrIg9UbIEL
	O84p8w3cwuTId1f9Eh3vbzSGxDRjEd46YKPEkhuFMv7G8C18MfBG9UguBq7Ac/WmqJkjWMe
	JdL65d83tbWYkDgYTer8de1PThyz9JMcVsLlLAsZ59BuWeN3JV/0aCpT9WoSRUR7D0RdRH6
	vHGK+WxSSUF2iBGHUVVaINCCmoyv4Gd1KXdZtqahVuFyXs7u/Pa0kGiGkB1GVZe0mLFLQIH
	btIqel/pcsoXz93zid5oHHzPPkwYynEouN8GB/iKBpSpu7ItuNHMzwlzGNDiY3vYDvIQmet
	7kA6/PLD66UH/2aw9c7qK969kZ1qAnexa7GrFHpR2/OpXgmGdXlnkIt6fHr3AXe+Ol3CwQl
	CeX+rIevaXTzpTOloNgpI/EDejjWR8BiyAKlddsNCKge1fNtxAvYTUdkUVt6u2KYFM5OJBs
	1P6mc84yQzZpPO96WZlzeMaiVSg1Afu/Obndkf+fDBXutM+6ouAeI5bfAS6M68MwU9psJlj
	Bzd20Lq6yuDSKBwCG1cx7yKpdTs7bhIEbb/LJPYaIx89zdMNHxXV52Qn/cmGZXpqwcPSXpN
	fqhec0htngoE5CwVqWW7YF5V/J+VI4tlMlnzkqPakw1YuYaUhhDH4C7L6QmxAGDDpdRRaq1
	tTnS/3AXVDd9qirKrijA26lAj7qQJs+dQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

Based on Martin KaFai Lau's suggestions, I have created a simple patch.

The root cause of this bug is that when `bpf_link_put` reduces the
refcount of `shim_link->link.link` to zero, the resource is considered
released but may still be referenced via `tr->progs_hlist` in
`cgroup_shim_find`. The actual cleanup of `tr->progs_hlist` in
`bpf_shim_tramp_link_release` is deferred. During this window, another
process can cause a use-after-free via `bpf_trampoline_link_cgroup_shim`.

To fix this:
1. Add an atomic non-zero check in `bpf_trampoline_link_cgroup_shim`.
   Only increment the refcount if it is not already zero.
2. Guard the freeing of `shim_link` with `tr->mutex` to prevent release
   while the mutex is held.

Testing:
I used a non-rigorous method to verify the fix by adding a delay in
`bpf_link_put` to make the bug easier to trigger:

void bpf_link_put(struct bpf_link *link)
{
        if (!atomic64_dec_and_test(&link->refcnt))
                return;
+       msleep(100);
        INIT_WORK(&link->work, bpf_link_put_deferred);
        schedule_work(&link->work);
}

Before the patch, running a PoC easily reproduced the crash (often within
dozens of iterations) with a call trace similar to KaiyanM's report.
After the patch, the bug no longer occurs even after millions of
iterations.

Signed-off-by: xulang <xulang@uniontech.com>
---
 kernel/bpf/trampoline.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 976d89011b15..c16a53cca5e0 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -702,15 +702,23 @@ static void bpf_shim_tramp_link_release(struct bpf_link *link)
 		return;
 
 	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link, shim_link->trampoline, NULL));
-	bpf_trampoline_put(shim_link->trampoline);
 }
 
 static void bpf_shim_tramp_link_dealloc(struct bpf_link *link)
 {
 	struct bpf_shim_tramp_link *shim_link =
 		container_of(link, struct bpf_shim_tramp_link, link.link);
+	struct bpf_trampoline *tr = shim_link->trampoline;
 
+	if (!tr) {
+		kfree(shim_link);
+		return;
+	}
+
+	mutex_lock(&tr->mutex);
 	kfree(shim_link);
+	mutex_unlock(&tr->mutex);
+	bpf_trampoline_put(tr);
 }
 
 static const struct bpf_link_ops bpf_shim_tramp_link_lops = {
@@ -800,10 +808,8 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	mutex_lock(&tr->mutex);
 
 	shim_link = cgroup_shim_find(tr, bpf_func);
-	if (shim_link) {
+	if (shim_link && atomic64_inc_not_zero(&shim_link->link.link.refcnt)) {
 		/* Reusing existing shim attached by the other program. */
-		bpf_link_inc(&shim_link->link.link);
-
 		mutex_unlock(&tr->mutex);
 		bpf_trampoline_put(tr); /* bpf_trampoline_get above */
 		return 0;
-- 
2.50.1

