Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C422FE578
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770275296; cv=none; b=BGugiNHNmS5N7fizX1iTHda4WKK0PKw9fcvL2//22btV/1xwS1S3diGAobafntfnAVJxoKcSbHInyNi14iyNzmhkpy1FB5RzGf0xHubeTHsLWECH4MpRTm2IAwApWehZRESAzlgT8hdi4pjVtLNZnwNyzugtbd8mZ7PDiPks1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770275296; c=relaxed/simple;
	bh=sC8RLQAjbEeT2tQH9ptuTec+CBU89NqNFgjGWczzFDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2H1Oq2Rte6/7x1AZp5oR7QmromrPOsamXJh/a3325edxILtleEUXItnMzMFo2dkSA+bidwCyVDa42Fmb3l2MGT0FXjdW890yDdBDe0++zN93PwBy0Rg4/jg7IT8devh+UVjcMezjgOpdjx9aDPSOhGujT/dne1eFuEKvvnc/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/QQTlVr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/QQTlVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCD4C4CEF7;
	Thu,  5 Feb 2026 07:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770275295;
	bh=sC8RLQAjbEeT2tQH9ptuTec+CBU89NqNFgjGWczzFDQ=;
	h=From:To:Cc:Subject:Date:From;
	b=f/QQTlVridNphhhGZGKx7TUzi8dKPp53955WAw13tRgZQoHV83RA4+Z9eKhMaIFXn
	 TXET9/ujVTyLyOAHKZQGZGLbgdMGpZvJxZ2xSwV4OV/CV20khrCfKMbqpCiz+2vAjk
	 NOq/pbi+xGAECgAGZGkj/DUd1u4nvHtyeF9Mh2Mq7PggdJKX+Km7Yx+/2hUb/p5bSP
	 kVcbjWmrcF52pV+4vUiNkvHh749WO1guk7aUz6TjtGtWgyiNeE070Bc8Ga71dw2N54
	 AEdUIY7vxbKv3NWerRB6rJvtyRJnpvxYFTUI7C0Ghpdi9LNbkXdJgtSKfjhAdi8sWd
	 T3VmAZ23mlRFQ==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	Toshi Piazza <toshi.piazza@microsoft.com>,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf] bpf: Require frozen map for calculating map hash
Date: Thu,  5 Feb 2026 08:07:55 +0100
Message-ID: <20260205070755.695776-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, bpf_map_get_info_by_fd calculates and caches the hash of the
map regardless of the map's frozen state.

This leads to a TOCTOU bug where userspace can call
BPF_OBJ_GET_INFO_BY_FD to cache the hash and then modify the map
contents before freezing.

Therefore, a trusted loader can be tricked into verifying the stale hash
while loading the modified contents.

Fix this by returning -EPERM if the map is not frozen when the hash is
requested. This ensures the hash is only generated for the final,
immutable state of the map.

Fixes: ea2e6467ac36 ("bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD")
Reported-by: Toshi Piazza <toshi.piazza@microsoft.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4ff82144f885..868f55641cdd 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5310,6 +5310,9 @@ static int bpf_map_get_info_by_fd(struct file *file,
 		if (info.hash_size != SHA256_DIGEST_SIZE)
 			return -EINVAL;
 
+		if (!READ_ONCE(map->frozen))
+			return -EPERM;
+
 		err = map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, map->sha);
 		if (err != 0)
 			return err;
-- 
2.43.0

