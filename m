Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73B2D7D42
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002662; cv=none; b=CeGZRql8PZAQLEWAlPq17mtFHhVs589KIX4CajOIjtvkKlFmX/J9RQ/Xzqexy7Vup/mDwnDGEk1PhVPEEla9CRHE2kcccXV4BjA0nok1+vpY4nwgB+N5c1uV6kCgkPOdDJ8h3MFj/mXsinGIhWeJzJXZvZsT4+VxSfWyUrgpl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002662; c=relaxed/simple;
	bh=eScL9dq0gEhIHp8Offn+cqlu8keUk9Gm/hrI92+q790=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4oUW66FVSsJJ80lyyVegj0rzPe81sd/Qe9WV2JfMTPOY3GRE/izA5XFIjjslaDf+Ycn/1PKHRVEYSdm2n19/5dpNuUX2m7f7mLpYr1i6FWw9UKzQvP5612fE1kUmJKKOIgBE0Yy7N/1TWp8S1zLAsnzGsxaTn1tN8FTo01st3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UpysrdKj; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UpysrdKj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772002541;
	bh=d6Yn5IwXA9o1ScLlEO+k7uOVaXSrXccDlxoLw6I2hzI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UpysrdKjndKiUfYCgnYvwDmKC/pexk3eEsXd2Ggl/0Ht8xzcDr/Ufdp/jnbKwvY6C
	 IRJSnB4wOcILkZOh42FJ2PspIjDz2TqnO4FjG5Et/rACjDdD1KvS3mgtyEmXGTDgL+
	 KaGzT8PyCszc76XfRWEWPN6iwCj3fh4FyNWgo90w=
X-QQ-mid: zesmtpip2t1772002524t3ad9bb83
X-QQ-Originating-IP: XfQ1+38j/4b0p6/KRR0kST8GTxf7BwZKTSCKjI9kS2E=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Feb 2026 14:55:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2990070636680215451
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
	xulang@uniontech.com
Subject: [PATCH v2] bpf: fix: Race condition in bpf_trampoline_unlink_cgroup_shim
Date: Wed, 25 Feb 2026 14:54:59 +0800
Message-ID: <B97C43D716882A74+20260225065459.2609916-1-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <64e56f03-bc93-46c1-8d5e-fa9720821620@linux.dev>
References: <64e56f03-bc93-46c1-8d5e-fa9720821620@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NrJHW3hvBPkCdWjQ9dckazrPT/iV25WhtTIiIrUvqRPVc2uoFa7aX4YG
	ZZAz7tRYWKRJRQf0CQyF+aHyVTJir5wo1VzH38RVOOIuz+CsP/NXv9uW8XDjitj/RzriaZK
	FrdtHAAxqZa8jUf62XEnqvImZJ2VJ1GORRow139QAgyou+IjTfnCFGGb27mJWi7g0Gb6NGs
	1DtfhLT9AAYE/8CiQ9q3sG14i6cVhg7Ncn6gfSCLw41kBLDyYr34H9VCzNmcTp5ZJeWfRpN
	4DcakzSm6lLg5uqmyhD3AZlq/LtD0KED77IzRymyrFC0I/7sSAwbq3eZI7a8cux31seqctc
	kePyCKiiQGU/tU+8jXYC8KeGfR3f7+n/7stqkrlWNIbCDlTYIRjBcaZuk/4yZ/j4XX6i9Zb
	Mia1iR/B5jUy4R2Gue0VGU0raPLJKwz8iPYlUFTfKkSQzTEcdAuk6jmz2djQGm1Qw6PE+16
	7LGzLg6/w44etyPIvDjmnpYH2mffmC1n7umYgtYNK9RJurD336diZQMFJtELLl6m3tARQss
	PrFgRVHPHBUGUzxWDFpuzfgBi+nVbInk3UutGR3whX5I8D7McfFAfX4JxKt8GOj8AIIy4t6
	LC3Dxwz/xio4boZxGDO5ceQvTJMjoYODDMgBFSwGLMLRAXMvQxZJUk3kJMLn47ymyIkrhg+
	Rw9nBy8xVqVKcMGPnJzPX82gDvwhY76Q4lcxboRZlwVnJyEAq/pGa+bJw0taC1SFqqy6lIF
	sgm3U9duT0bPn27kEmI9ogxbzReC/gUOU+QoDmcw/wKLLSh0w8IfKhsUANlvy44yQ3i7y91
	bWVmfkgqFVj7zefSGEZ+QGp5OfFZJlhS5sWPKMhTYr8HNUrejBrQYySdMJzy1KX8xWs4M5x
	4Ng+1Z1QNjP5j/jl/Ze+0u5Spl4WbLid1DMmghSv+CsSpuEA9aLAHn7YwjHLZHrZD3SeDUc
	n6GVBZjr33TCeZgUoMY41bAvPBeyyEFnZkakPeWNnbWaSr6Lve+PbO7AWIEj8wMWjQnMsHl
	1SD6bkvaH1xnsqxnq8UoQKWOM3GrpldMVie5mGjw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

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

Signed-off-by: xulang <xulang@uniontech.com>
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

