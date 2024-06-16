Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781C970CC8
	for <bpf@vger.kernel.org>; Sun, 16 Jun 2024 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718576189; cv=none; b=lII+Yp5qStbo9rXxMmdvTRStjOyWFyQxFRIieAHcwYb+zB9vOXfO2ozTo+GNSEFnamLXKbUr2zJiKYQiTdpp0N9kWTXGwBoXJG6Mc5MZFKUxNCpU26FLH8I1I9/cGep4c8ucI1kV+k3+3Sbuxn0Lu9CMVji3vrF5CYTiEs7tjqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718576189; c=relaxed/simple;
	bh=lo+oeZVMK/4uEN2JKvGOYaDSJbWGHZiF943FAjLP9pE=;
	h=Message-Id:To:From:Date:Subject; b=IPerUxuJd2l1hXzaSll7l5lLkkaA96UjZlD7qXJzrutq+Z0pqTFfjYI1RPdmCOoFk5ejgLDFPTtzG2gqurqDLYgTjr+4q/4uP78yLFkbFImc6AABsZEoNhfHpWSMoS4Y3WOWH3TOsHZr8htDD0xNEmueBXR+nAUSdek7/siduu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ayaya.dev; spf=pass smtp.mailfrom=ayaya.dev; dkim=pass (1024-bit key) header.d=ayaya.dev header.i=@ayaya.dev header.b=ogsf+P12; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ayaya.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ayaya.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ayaya.dev header.i=@ayaya.dev header.b="ogsf+P12"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ayaya.dev; s=key1;
	t=1718576185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc; bh=UIdHYP3QLfnOTxXTzChcQxicQkbbIiXfqG1lXNeaPYc=;
	b=ogsf+P12DB6WNxp+nzv/pqaMXnUIX0oouCDhZ1dtlNRzYZ4jeYaqQK5rNPcPdJgxbXwajt
	bmXKGdFb7Oa6pSI6k+imphbv7tdyQfwcJoTWvgKAvlTodRvWj8XJYsM5cLOD5wxYThtZi+
	vGui4RtjC4JIgUV6GZaAjmsXitV8Hzc=
Message-Id: <D21SEVE6F615.2LMUOCTGW8AI7@ayaya.dev>
To: <bpf@vger.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "psykose" <alice@ayaya.dev>
Date: Sun, 16 Jun 2024 22:11:05 +0000
Subject: [PATCH] libbpf: fix signed multiplication overflow in hash_combine
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

when using -fsanitize=undefined (which flags signed overflow which is
UB), a crash can be reproduced when building the linux kernel with BTF
info.

cast to unsigned first to make the overflow not invoke UB semantics- the
result is the same.

Signed-off-by: psykose <alice@ayaya.dev>
---
 src/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/btf.c b/src/btf.c
index 2d0840e..60cd412 100644
--- a/src/btf.c
+++ b/src/btf.c
@@ -3317,7 +3317,7 @@ struct btf_dedup {
 
 static long hash_combine(long h, long value)
 {
-	return h * 31 + value;
+	return (long)((unsigned long)h * 31 + (unsigned long)value);
 }
 
 #define for_each_dedup_cand(d, node, hash) \

base-commit: 42065ea6627ff6e1ab4c65e51042a70fbf30ff7c
-- 
2.45.2
