Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E782BEC5E
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374692; cv=none; b=IztNuJX7BFvmi07CCxDw347xaVGb6ndY4U1b3kqBT93ZXeFe9u4F0dvqMDEq4XqF4+8qpsdjDbR6XCwkA75Bn8K96N7tI7kM7sbjLBc1zG3+M4FhUjKH8qWDh3HQ8+6HL0IdlZHcPTZv3DP6MsMDhzVHYlEKkVYe31NmmEYsR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374692; c=relaxed/simple;
	bh=kwrsgq8rd0jKppaiL7WPQlFKokPcRkuuqua0r2Z1GHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+6Dlsr0AdLB2oYSiWHVmn/xiwjHJy19Eb1HocpTAPO7k2YP9mxQOPIyAZ5h/awcyMk5oPZBMVzizUXG93TB4fz9yJ2PI9FT/qF78oAaOEIQXe6isQxjHtpCQTq/FR+TFK9H6uJJ93LRluIj0XPfbipQ0cESsNWJXPRHY9vLKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PQGwlAuQ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PQGwlAuQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771374689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxHDHTJszBQ9UY5j/vo3lm9Z9CQCJiWhYDvWpF8HC5A=;
	b=PQGwlAuQ2Tq4V5hBW3t5XDJyERxMviuceFBdhFaLWFRNyygxgiRjYfZltqOnB5z36VgLjo
	6CvtnGbO/vFkYwjdfq0gNdlowpXkK1aN9j46EUibI1b24ERe7L/UIckOKwDuzVM6PF5jTt
	5mDdXRo6BkMX7ippdqRkIOlKugocrmk=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v2 07/15] veristat: Fix a memory leak for preset ENUMERATOR
Date: Tue, 17 Feb 2026 16:30:33 -0800
Message-ID: <20260218003041.1156774-8-ihor.solodrai@linux.dev>
In-Reply-To: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
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

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
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

