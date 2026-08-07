Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97E19B5B1;
	Fri,  7 Aug 2026 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068402; cv=none; b=Sju70OFknf8+PsNxBrtSDxaa610eCsbgfequKRtQ0bqBTYgZVhUtP+llog1RwcnmPs+ZIKTyeMDg6fK1tiwd0DzBpxpugLZH1ibLoydA/2SAx07bop9UcM24DRbLXBtYr2SSHjuiKNspk2sVXWziih4Ckiap6EKuyDxNSq/zmPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068402; c=relaxed/simple;
	bh=J3owbIxUWdCS03veoImOxU0NOsa7GlCCZs27wZvsYcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rk4o/Wf3KDuOtL1Nhj174tUdrxO+VwnFM+U4QCFQpu8yvpiE0mx47vrVRZTGGEnE52xTyVsH9oP1IGFYZ8DOWn08LggTotnzqPZ9XC2gV62yk/GiEBGefqzeseM3yde3x22XwZMPGdjb1wAdWPDJ1SDWE1e0m4rLLVXQxOxOFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aJnOggSU; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aJnOggSU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=n4
	9WzXlUXknWqJJoFZvX46j5Iuso8UbjfkpiYYOIJcM=; b=aJnOggSUPByidclQEB
	aTHltcv094BPVj2Uk0SdZcPuctVdOnTbEnLpyBA4hrLbnh7wqjJr9A1Zvv83m0So
	uKJDl+0xnlUmdmfEh9OiIBY5G93p8FMUbeTcGT5koBPCvQkegKRFHy4s6ycBKt6v
	bml+u68rQGNy2UBHructlsgdE=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCXnpiGPXVqyp9rNw--.41530S3;
	Fri, 07 Aug 2026 10:06:03 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH 1/2] bpf: Fix queue/stack map u32 index overflow
Date: Fri,  7 Aug 2026 10:05:47 +0800
Message-ID: <20260807020548.1376979-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807020548.1376979-1-chenyuan_fl@163.com>
References: <20260807020548.1376979-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXnpiGPXVqyp9rNw--.41530S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy5XFy5uw1rCr4fuFyxGrg_yoW8Wr47pF
	s8Ja4rX3WDtr47G3yktw4DWF9xWws5GFZxKF9rWryvyrn3GryxWry8KF4agr9ayrn2y3Wa
	q3ZFqrZxC3yUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjJPiUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5QtpJ2p1PYutRAAA3g

From: Yuan Chen <chenyuan@kylinos.cn>

The queue/stack map addresses elements[] with the product of a u32
head/tail index and value_size, but the storage itself is allocated in
64-bit arithmetic. When max_entries * value_size exceeds U32_MAX, the
product wraps and push/peek/pop operate on the wrong element, corrupting
map data and leaking stale values to user space.

The original bound check was removed by c85d69135a91 ("bpf: move memory
size checks to bpf_map_charge_init()"), which migrated only the
bytes-to-pages conversion and dropped the overflow guard, so oversized
queue/stack maps can be created again.

Restore the bound in queue_stack_map_alloc_check(): reject maps whose
element storage would exceed U32_MAX bytes, keeping the u32 index
multiplication overflow-free.

Fixes: c85d69135a91 ("bpf: move memory size checks to bpf_map_charge_init()")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/queue_stack_maps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index c1c9dee4dcdd..f9ff701ab27b 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -59,6 +59,13 @@ static int queue_stack_map_alloc_check(union bpf_attr *attr)
 		 */
 		return -E2BIG;
 
+	/*
+	 * The u32 head/tail index is multiplied by value_size to address
+	 * elements[]. Bound the map size so the product cannot overflow.
+	 */
+	if ((u64)attr->max_entries * attr->value_size > U32_MAX)
+		return -E2BIG;
+
 	return 0;
 }
 
-- 
2.54.0

