Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F62DC323
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481882; cv=none; b=SeRhwXWdz0Kq0W27I2nj/B/KnwXsw0FXeaLTg4p56Cc67afLwtOVNAP8T4kZy/alQjlv+vBsOPtgdXlLA0JWZVK/UNr0+w5CyUf48PwfLH/DJ37wrMRqMX5kmMZDOd7RZXgmS4KfcK19CnpuUVDNMoCMxgVs2QDhFXzKVAb3AYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481882; c=relaxed/simple;
	bh=drngIWW+fAztlwvma0OKHAnuxBd2wbIi7X6i9RJecoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LI5G1JupgjqLYhGJEP2dWNJv94qjUaP/c5kQKuFcBfytlGHe+3jEBJhPxtE+sLIVjbfXM+fk8J8e5GEOtJ4C64KZ/j0R0u8HglfRWGq/kfMzE6WoRsRJckQrRjZgrEM/1Y7tSeSQmnQwkLI00+ljC8al4J7Xwq8MIPdvZCNpJNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VqQ1tgRF; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VqQ1tgRF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769481878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=prFf4bLkFxmL672PFq9iQpUXEdYH2JnxC6I8++AT3IY=;
	b=VqQ1tgRFsg9DAgp80I7caK5fAICVmELmNdTF3Zfbr0DSK81FtixqJsAebJ1U9YfHuIkQ4t
	60z0NHIBhH9awJ7ue48VxidiZgdzn3sQ96nCcnN2Pj6SPvLGFTwlndFkXlGYwe1r48iJZH
	HOoR42cTjeMrewVKEgocLz1xOVH+Tek=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next v3 03/17] libbpf: fix return value on memory allocation failure
Date: Mon, 26 Jan 2026 18:44:06 -0800
Message-ID: <20260127024421.494929-4-roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-1-roman.gushchin@linux.dev>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bpf_map__attach_struct_ops() returns -EINVAL instead of -ENOMEM
on the memory allocation failure. Fix it.

Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c8bf0b5cce4..46d2762f5993 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13480,7 +13480,7 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 
 	link = calloc(1, sizeof(*link));
 	if (!link)
-		return libbpf_err_ptr(-EINVAL);
+		return libbpf_err_ptr(-ENOMEM);
 
 	/* kern_vdata should be prepared during the loading phase. */
 	err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
-- 
2.52.0

