Received: from out-186.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D53A7F6F
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287734; cv=none; b=rijiD2uHfNcxjeajlkBjkF+WyyYUuLUpnUlDBkIBLLw0eS2lmP5WwslyR3PA+GaqTbIIPHjLZWdgy3NDNC4Knp8KdPnYoRs9vZ1oQH87AoHvaTJPWTc3WT3dhKuxJ2qU6GFxzIZW9wmTDGUZJID3fM8zC5aeiPDsSl9hlBGt1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287734; c=relaxed/simple;
	bh=BEoCcAyF+R/sOKReri78++IeZsP6ZHkO2YpBECkJFOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zm2kJzYfTRkaTuuph/WP/UWGK/biyuChRALuMPnOJG2BaQ6SVhVwHejrLIesn3c1KYeIT3lMQPiKGyCxRBBr+48r22iYsEjj3QVsrc+ejjz/1dUVNbbgrHMnwSTFwNt0palhYFPfudU3E7zvqfuSXgeMaGvyO4kOOlzjbmfP6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jraZSiFr; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jraZSiFr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786287731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvmPAjSTsp9C9P0krIgzdAKGfO6OEzvEZTGyYBjPPWc=;
	b=jraZSiFrWBbR17WCYVve0oahjZvxb//yOWl+2/23IGcg46nIn7usGNytHs1T8uMcx5MWq8
	1j1GlQ+r/NxKs9JJViz8j2XFng86QT4dIMlPAoSd0jL9ADi5ga6t0iIUx0CmMwlXWGZobh
	/Bp/FSe2ZPmoZCYaL3QXYT5dVvJ0Qsc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 03/13] bpf: Drop unnecessary ftrace_location() in update_fentry_multi()
Date: Sun,  9 Aug 2026 23:01:01 +0800
Message-ID: <20260809150111.45000-4-leon.hwang@linux.dev>
In-Reply-To: <20260809150111.45000-1-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since 'tr->ip' is already a 'ftrace_location()'-ed IP in
bpf_trampoline_lookup(), it is unnecessary to call ftrace_location() again
in update_fentry_multi().

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/trampoline.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 6e1898e1b200..eddd259d3776 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1573,12 +1573,11 @@ static int update_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags,
 			       struct bpf_tracing_multi_data *data)
 {
 	unsigned long addr = (unsigned long)(im ? im->image : tr->cur_image->image);
-	unsigned long ip = ftrace_location(tr->ip);
 
 	if (bpf_trampoline_use_jmp(tr->flags))
 		addr = ftrace_jmp_set(addr);
 
-	ftrace_hash_add(hash, data->entry, ip, addr);
+	ftrace_hash_add(hash, data->entry, tr->ip, addr);
 	tr->cur_image = im;
 	return 0;
 }
-- 
2.55.0

