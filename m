Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0C36A031
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873719; cv=none; b=kSLUT3lYJw+VtJz8PlHHMHEXyYS5pdCy8K2zn1GTLILQ62VXXQ7FpadGiXR6PHpD/wOQw02vM8Rqlcq6oii5fzJtQ1jnJEEAj+FYn6V6K6fTEPlyX07UPEQM+zxgvfSTcHBf+B01q3WlMzzehED2iB7fK6LFac/u5cJrraSonxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873719; c=relaxed/simple;
	bh=kwrsgq8rd0jKppaiL7WPQlFKokPcRkuuqua0r2Z1GHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJKu7HX87BnFQb1F4Z8YdE6IThPFLMNJ5fpkH4Aws+3SiIRcTh/vSbCayEQ1wvntSMp2GubNNJCxbDn/6JB/9qsRJqCQeEQQibgifRtKHMwzhRA4s/Jth2QSgcEuNDo5TY4NmKlgG+N1Bw/ZWkL8L/dfKOaI3zahkMRYXYTptDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OoKm2B6w; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OoKm2B6w"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxHDHTJszBQ9UY5j/vo3lm9Z9CQCJiWhYDvWpF8HC5A=;
	b=OoKm2B6w79YWaV6FgBGp7vdqdA0Wsgfo7c56tWQ7qUkCgeLsh7oIhnVGstR/mXSvcsIjAA
	Mpk62eAqUvWKMkNr9BCE69cDjKvbz0BNpr9SOmPUTxrB3RpAuvWuPhJtAPWk0yWr/nlLAI
	mk1wtgWmy8MetwG56IOhW2GA0GTrzl8=
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
Subject: [PATCH bpf v4 12/20] veristat: Fix a memory leak for preset ENUMERATOR
Date: Mon, 23 Feb 2026 11:07:28 -0800
Message-ID: <20260223190736.649171-13-ihor.solodrai@linux.dev>
In-Reply-To: <20260223190736.649171-1-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
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

