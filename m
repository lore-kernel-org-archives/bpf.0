Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7F5102F
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710530493; cv=none; b=q3wXHE9vsKb3rhJBjT7BE0Cdn5n2DLh5PjCh+LrwVO7hmqwZSjw/NQT6rjuIAl+Z2K5o0bkPokl7O6g7grKpWdt7kfMhlQtcJQfPq/1LOYRqLwftA/m9LHUPajt4paysuM//Jq8bRSYntRTv97mDADxIELRzQVhGxFcZ7N7EH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710530493; c=relaxed/simple;
	bh=mWf0gQpDHkYLJdzeMwFIP4FeKl/2JIS4hyIpR6zYX+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAjbw5RofZmOCPlxGNcOlssn3DhKrme0tp3ot+LX2wl7CccLn3BSL7nAYHLnpNkzbowoZCfSkCe0Ymf2WpJG20Soy56uo+t3XtxlzKc9EUhdYcaermFiUlXL7Te91CqPLLqpRH8Dr6ChPUvYzjOHAYg2aJHqzzDzD8I57QEN/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iQMVw4nG; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iQMVw4nG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710530488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oVxhjczIkyv+nS7khJgSyfcCSIlEdqE3wfLuLm6ctVc=;
	b=iQMVw4nGI+YA2egxC4/BZrb6i1095J93+0MxQeMSjh2LsICrJakkKlFyds/Ce/Bxl8xZrs
	+AqDeyWEunjDWUSZfBY5+yfXCHWvZqmuPIRsXcOr/bgBCzXHuOna4T+7bUQlM3NiUcd2/5
	ucvbbjvtfSSCtn98DPPNfPslnN2aLFI=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next] bpf: Remove unnecessary err < 0 check in bpf_struct_ops_map_update_elem
Date: Fri, 15 Mar 2024 12:21:12 -0700
Message-ID: <20240315192112.2825039-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

There is a "if (err)" check earlier, so the "if (err < 0)"
check that this patch removing is unnecessary. It was my overlook
when making adjustments to the bpf_struct_ops_prepare_trampoline()
such that the caller does not have to worry about the new page when
the function returns error.

Cc: Kui-Feng Lee <thinker.li@gmail.com>
Fixes: 187e2af05abe ("bpf: struct_ops supports more than one page for trampolines.")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_struct_ops.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 43356faaa057..3fcd35314ce5 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -728,8 +728,6 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			cur_image = image;
 			trampoline_start = 0;
 		}
-		if (err < 0)
-			goto reset_unlock;
 
 		*(void **)(kdata + moff) = image + trampoline_start + cfi_get_offset();
 
-- 
2.43.0

