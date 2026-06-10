Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA03EFD03
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088959; cv=none; b=PIOHlBMkeJN0mPOy9rUGHL9r4SLKHLd2Gp2fzmClgNCatAYlWcExHFEFjbuc6l1BHbwSObrnGYnxKi02ea2KkDN8Hwsi3oYxbKnC/b7R9heiuMxKDl9PIYhj2gjf/t9hQdz/QdWOe0qm2sgrxsaJUjWucNY6uqe9/EWOTetOKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088959; c=relaxed/simple;
	bh=ovtGbRiPOLnEwkvvTqucFCjHoWe+rPn1kQXmUEchTjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GvueGdS/dAFVpNhUm9+JR7/OtMJCMOYMUrTMnewgkUnloQftV9mHFNwSdKxyHhUHFaVmuIY3U2a/a8XvrLWoE3V5y/fkWlR/bDq1hlazSQnpb8AGqyGss7sPGdDPC/UTC22JjsLXUIFKfYBVB/7bj9+pOiplobKnjNAxmZjn9Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=PoLkFTHk; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="PoLkFTHk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=nQHSNtmd13pxv+HYcmVQ3LsI3UwNbSF/4U0FdkaoU4k=; b=PoLkFTHkF28spC0GPDFH+gawgK
	s92U4OsgBoakiXPDxoatU6iKRPEwfcNktUkdES8kP2zxpMA+r85yQ6uH56aBo9hqZNK5OjSwhnmIb
	+E5+1jrMujRPcdcbN5VYlhsVC+xTaCMQEP1MiTBjHrDNlAhyF2YFPnWlm9TrLEh2Jh9AniRwQYyh+
	imheZYwDi4T8axxjQ2RgfqXY3Sf8k4Wr3jR/2hVYsJeHcdZwbPDv+GcgA9OqsmfESX8v6Wu+IfzdF
	1+m0F4v6v/iGZ937PSP3Cv/js5Ew04lIwwuhkMv5u76sW5OTlEmlgkSdhCt2TF/nxvkKPSJOnUaxH
	eO3tV2sA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXGax-000Ajn-2d;
	Wed, 10 Jun 2026 12:55:39 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: yonghong.song@linux.dev,
	malin89@huawei.com,
	ast@kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Tighten cgroup storage cookie checks for prog arrays
Date: Wed, 10 Jun 2026 12:55:38 +0200
Message-ID: <20260610105539.705887-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28027/Wed Jun 10 08:29:13 2026)

The fix in commit abad3d0bad72 ("bpf: Fix oob access in cgroup local
storage") is still incomplete. The prog-array compatibility check
treats a program with no cgroup storage as compatible with any stored
storage cookie. This allows a storage-less program to bridge a tail
call chain between an entry program and a storage-using callee even
though cgroup local storage at runtime still follows the caller's
context, that is, A -> B(no storage) -> C(storage) path.

Requiring exact cookie equality would break the legitimate case of a
storage-less leaf program being tail called from a storage-using one.
Instead, only accept a zero storage cookie if the program cannot
perform tail calls itself. This keeps A -> B(no storage) working
while rejecting the A -> B(no storage) -> C(storage) bridge.

Fixes: abad3d0bad72 ("bpf: Fix oob access in cgroup local storage")
Reported-by: Lin Ma <malin89@huawei.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a656a8572bdb..649cce41e13f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2481,7 +2481,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 			cookie = aux->cgroup_storage[i] ?
 				 aux->cgroup_storage[i]->cookie : 0;
 			ret = map->owner->storage_cookie[i] == cookie ||
-			      !cookie;
+			      (!cookie && !aux->tail_call_reachable);
 		}
 		if (ret &&
 		    map->owner->attach_func_proto != aux->attach_func_proto) {
-- 
2.43.0

