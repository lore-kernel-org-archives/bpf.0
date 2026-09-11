Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F3A31715D;
	Fri, 11 Sep 2026 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135413; cv=none; b=JpTo27N7uYYlkOob5QCuhSM17SxFMncrp+VJ6BJFqGXzOcUeoQX173+UVnQdw1fQJn/LcumIj+o/lHRfuJFLtqrY1cDDzgNeZYFkY5F1roFZ3GMVd8IqAwd/Q1daBkU4xSvUJ+tW9FR5k7oRnl9Wh5FVhi5ExLNesFMseS1tB6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135413; c=relaxed/simple;
	bh=BtmDOcrJzTirInUyJZ4Yn0/HlvkxpOsf18Vh5suxajg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VNyZZYtJEgXrLiFucM9hB1fSSs0LTpRrvCV3eJyWcfLHuNmkSwkKAJHpAQvOmAeZOfefAuLL73qPnCagL4NyC85MWbgK1RWUdXtatTmr9pRIixRmgjyDZvPErI7/D7Ax6xkCvotQ2LZnHe71ESJcTNPRWXaI+QTTyphb+cNlFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F+qBxK/k; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F+qBxK/k"
Received: from localhost.localdomain (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 967FE20B7166;
	Fri, 11 Sep 2026 07:02:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 967FE20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789135369;
	bh=nko1lzDX3HYjX2ZcfcghQ19ySoGi04r5ioAQrMQSqwE=;
	h=From:To:Cc:Subject:Date:From;
	b=F+qBxK/ke+HD0YetRgg/ZMn/CIDC2IdYBk5xKNw+U0ZGTYZNZj3EAkWjEOrJEOTWu
	 PnGCq7kMSzHKULddloXe4Yzxzd2m6zm7SbJ2YhWxuU6ZJ3MFoAh/9BQReh8JIAJOdA
	 64L0IykprkeZ6WipYdaK+43ijmekDCU9b+Az6TX0=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: Amery Hung <ameryhung@gmail.com>,
	Xuanqiang Luo <xuanqiang.luo@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Kees Cook <kees@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: [PATCH bpf v2] bpf: Fix NULL pointer dereference in __bpf_sk_storage_map_seq_show
Date: Fri, 11 Sep 2026 10:03:08 -0400
Message-ID: <20260911140308.81560-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterating a sk_storage map is a two-stage operation:
bpf_sk_storage_map_seq_find_next() returns a selem, then
__bpf_sk_storage_map_seq_show() uses it. The latter re-reads
selem->local_storage via rcu_dereference() without checking for NULL.
A concurrent socket close can unlink the selem and clear that pointer
between the two stages, causing a NULL dereference of sk_storage->owner.

Oops: general protection fault, probably for non-canonical
   address 0xdffffc0000000011
  net/core/bpf_sk_storage.c:809 __bpf_sk_storage_map_seq_show()
  bpf_seq_read+0x366/0x1120
  vfs_read+0x174/0xa50
  ksys_read+0xfc/0x1d0

Return SEQ_SKIP if the re-read yields NULL. This prevents the dereference
and tells bpf_seq_read() that the stale element was skipped, so it does
not consume an iterator sequence number without running the BPF program.

Fixes: 0be08389c7f2 ("bpf: Switch to bpf_selem_unlink_nofail in bpf_local_storage_{map_free, destroy}")
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Closes: https://lore.kernel.org/all/20260827051859.45511-1-blbllhy@gmail.com/
Suggested-by: Amery Hung <ameryhung@gmail.com>
Suggested-by: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Link: https://lore.kernel.org/all/CAMB2axNFOC9G2RwOCnsWDth83REMWnmPE8gxMwbLYoGusw9miA@mail.gmail.com/
Link: https://lore.kernel.org/all/c3f2a61d-d5bc-454c-987d-717b5f8c8809@linux.dev/
Cc: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
Assisted-by: Copilot (Grok 4.6)
---
Changes in v2:
- Return SEQ_SKIP instead of 0 when the storage disappeared, preserving
  the iterator sequence number for the next valid element.
- Correct the Fixes tag to the commit that switched the destruction path
  to bpf_selem_unlink_nofail().
- Rebase onto the current bpf master branch.

 net/core/bpf_sk_storage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 1d295a8769fa..7d02245aa704 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -806,6 +806,8 @@ static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
 		ctx.map = info->map;
 		if (selem) {
 			sk_storage = rcu_dereference(selem->local_storage);
+			if (!sk_storage)
+				return SEQ_SKIP;
 			ctx.sk = sk_storage->owner;
 			ctx.value = SDATA(selem)->data;
 		}

base-commit: 15071f2a1263e82150c77eeb1e94dbfc31950a8e
-- 
2.55.0
