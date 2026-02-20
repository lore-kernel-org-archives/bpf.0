Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422330C34A
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626410; cv=none; b=GZDKzJ2ki3loyTkArwyhOk3v7XHXHTFiyAya8UxDZylQVRC9qK+7flaTtPL27u1ZPLp3Wob5HQ+IJbDyIyODQpM/FFSBilhfr4UY34q3ATSA7Q7LX9ZM0cnMm6z7NKCX1e2bHJSMPvbl7fqYJE+/GOWjER9lUOJxoN0FGaTR5Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626410; c=relaxed/simple;
	bh=kwrsgq8rd0jKppaiL7WPQlFKokPcRkuuqua0r2Z1GHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRBKU+5pGFD1FGM0UZ8HuLluOk8F0YoyiuqJqEmYxful70Kv/0dDtDfM/mITJf/ikQhvWXVt32aiaBPBT/uSJlOvu2/LguJ0rixk95QHfBsMaDUImY4pxxpmhUcMFJ4QSocB6/KFvR39b5Y6mENgTX1pnqicnDiFh/8l8bY/Wh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kkyrrFs8; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kkyrrFs8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771626407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxHDHTJszBQ9UY5j/vo3lm9Z9CQCJiWhYDvWpF8HC5A=;
	b=kkyrrFs8b194JCWFPMKU8i20HKVXzrAJ3WoiDDiK/PkKE7cZDEz64WuPKQrfU/nrGXh7IH
	xQEZpNmB/GT0ySNP3elnzp3uQ3xxxFNfx4Noi04pu6n11q9stIzrcyhgIatWySH55O5lAm
	ECp0nYp5aijp87VUALCRFNAH8kTVGXE=
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
Subject: [PATCH bpf v3 07/15] veristat: Fix a memory leak for preset ENUMERATOR
Date: Fri, 20 Feb 2026 14:25:56 -0800
Message-ID: <20260220222604.1155148-8-ihor.solodrai@linux.dev>
In-Reply-To: <20260220222604.1155148-1-ihor.solodrai@linux.dev>
References: <20260220222604.1155148-1-ihor.solodrai@linux.dev>
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

