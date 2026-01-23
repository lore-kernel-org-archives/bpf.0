Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661632FD685
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158582; cv=none; b=OMtx5N0sqS0vsVaiYA3pG/dvUDy34Cr/zTwGuVfkhuRmYhrneVHSbonXI/zRrwIf01FqSRkh+r2NwVcJcb4OCEqsf9A/i3qfqyCX6EnaXUeWOUtugsTKrIxIlNQv/2681eqe9BaSaXm+KWZyoM5XB+OL9PaVBG8y0z47XEIWaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158582; c=relaxed/simple;
	bh=bWju0Pu/q1fcHhJ75vFo+k/1nN5ACrnizuMh4PQ2PyU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYCx5qaSjXx04kU3b0zReVBXTq+QnWkqRDw3d0YqigsiUdqpU0gO5ItbKURi0KSyk1ZWx/py+HB3W0kw/AKspfj54c1CSD3a41PMfLSTZQBeJAX7+TO2E5U4GQNf5qpJWNxXQEcrodZTL3rrNrYEF1YsA74a/o+XIz0//jaNVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I2mHUI2A; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I2mHUI2A"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769158578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IZwwlsklIfyYIeeJQqajpok/bifebBH8KgsHF7gR+Y=;
	b=I2mHUI2AYbqOhP0GZVQ7d5GjtaXLD2bXmUkzdEJnIsbrYIYnXnORHCehEq1EhcFDRTLZe4
	lJuKqiCRjeZj8O4b1t5Th3DoiD+cse/Y69dRz5iANYxn/eayBcnQplrZ4hCExPD/EjK81m
	Q5XMWVUkr84piWYFfOv54D77MdMEa+A=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Lance Yang <lance.yang@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH bpf-next v3 01/12] bpf: move bpf_struct_ops_link into bpf.h
Date: Fri, 23 Jan 2026 16:55:19 +0800
Message-ID: <6ddaa3949346e2b048b7bd6714d182c96a586d4c.1769157382.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1769157382.git.zhuhui@kylinos.cn>
References: <cover.1769157382.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Roman Gushchin <roman.gushchin@linux.dev>

Move struct bpf_struct_ops_link's definition into bpf.h,
where other custom bpf links definitions are.

It's necessary to access its members from outside of generic
bpf_struct_ops implementation, which will be done by following
patches in the series.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/bpf.h         | 6 ++++++
 kernel/bpf/bpf_struct_ops.c | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5936f8e2996f..031682f1ad39 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1881,6 +1881,12 @@ struct bpf_raw_tp_link {
 	u64 cookie;
 };
 
+struct bpf_struct_ops_link {
+	struct bpf_link link;
+	struct bpf_map __rcu *map;
+	wait_queue_head_t wait_hup;
+};
+
 struct bpf_link_primer {
 	struct bpf_link *link;
 	struct file *file;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index c43346cb3d76..de01cf3025b3 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -55,12 +55,6 @@ struct bpf_struct_ops_map {
 	struct bpf_struct_ops_value kvalue;
 };
 
-struct bpf_struct_ops_link {
-	struct bpf_link link;
-	struct bpf_map __rcu *map;
-	wait_queue_head_t wait_hup;
-};
-
 static DEFINE_MUTEX(update_mutex);
 
 #define VALUE_PREFIX "bpf_struct_ops_"
-- 
2.43.0

