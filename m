Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E91C28E
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858876; cv=none; b=MfB0bs0pSVGgNGlIVTYh0d3n6k8ew631eB8lLOI+1EB1w4CHuEi82LW/xDleHDDvu59t67NGUERTtNANUMM6FPWFfo0lARgScMUhhGalRo0nBpmhwXxOn6ZcO9tmYVIN1mSVnj3TjAVTiRT4SWYWqnqcyXsOn6e7L4v1oai4lfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858876; c=relaxed/simple;
	bh=Oohu9IsctUk6dZrEbLhnkff8ZOoO0y7lszSYXVT5uiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ql9r9EBgxZDsZR+IKOM54y25UMRlhr7//FJ/+Dbge7CqzC4CNfYFG0csesQXOe77G/0wnMTM/oncxlQ2FnlbSbANmJCroA7kr3hZmWCp160/aqMtwkZDQgPQEmqOrBgimxo1wfNsw4hRCtKfckCSlM8cmMAA0yY63MSwG2JjDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bmhQgjSt; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bmhQgjSt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770858872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RYJyENWs1ZudeDBODTP1Tg5qAi1DxUPNeH2H4e0hzs=;
	b=bmhQgjStbRcKXE8muJK3tUf5EkPKUzkPuW80V9AExeNr+vSe/abmF68bZcaRk6WstBnM+7
	3APjeC3SworF/FZi7LLiqVEQGkekmFtgVYgrLfoNJT7LsECH2CcKnpXpwMxD/86hde2qBt
	tIgd1JAAkkXiVC3MBcbOgvtDl2HpxWY=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 07/14] veristat: Fix a memory leak for preset ENUMERATOR
Date: Wed, 11 Feb 2026 17:13:49 -0800
Message-ID: <20260212011356.3266753-8-ihor.solodrai@linux.dev>
In-Reply-To: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ASAN detected a memory leak in veristat. The cleanup code handling
ENUMERATOR value missed freeing strdup-ed svalue. Fix it.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/veristat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 1be1e353d40a..75f85e0362f5 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -3378,6 +3378,8 @@ int main(int argc, char **argv)
 			}
 		}
 		free(env.presets[i].atoms);
+		if (env.presets[i].value.type == ENUMERATOR)
+			free(env.presets[i].value.svalue);
 	}
 	free(env.presets);
 	return -err;
-- 
2.53.0

