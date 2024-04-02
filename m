Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583117BBA
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038589; cv=none; b=b3L9itaHCGrCW9m0rKz4LhMlAgUmzAmoq9neojMvKbiRaku6NrBKZV9pnT+HOqrB6gYsq9qkM+LSS94ZdCl9cyK6E0QKPJyKaznec3kQngALf4s5cZUAs3vTnEC3uh1+QUz8E3uz9PTqdHqikPC2XjRapInCGUsNgsUVeukAw70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038589; c=relaxed/simple;
	bh=0ecctPjGDvIqROT2UQPixeYUJ6OQ1u0HSdcNuh7Sfpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SK98pKhsdfru95aJwMmeObaaSnpyPgg5Sk4BegdRSyuDuXMNzfoAfFyp75FCd6RiRE9Rxtx028H8NyNYRx/03MTpQkBWZ+7wHNcQLx6p1xFGTDnwyynp0MGlWJ57hrWZZskPXMe55kmL9REWSglDlyd6NVUaCyUqeEfEgBvTOuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QNTvF902; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QNTvF902"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712038579; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=plZ6MJwiiKtRP0JnX+6DkE1lVoIExLEEqxqWhNVdxYg=;
	b=QNTvF902IcOIOOMZcbRIqwm4vYw8hOGnO4dLrByL1Ut2w83RBnyOzYH2DStatZspFgmTdtXSZfVBt2ZzRNxkDWphfM950xhkUWPsn0WDr24pWJTpc1lLdsl11k/eRvQFjnuLjMOIqZE/5I5MpO9o4GTvYbiA7Lrn/bCq55HgEs0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W3nHHzk_1712038577;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W3nHHzk_1712038577)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 14:16:18 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH bpf-next 2/3] bpf: allow invoking bpf_for_each_map_elem with different maps
Date: Tue,  2 Apr 2024 14:16:14 +0800
Message-Id: <20240402061615.48894-3-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240402061615.48894-1-lulie@linux.alibaba.com>
References: <20240402061615.48894-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Taking different maps within a single bpf_for_each_map_elem call is not
allowed before, because from the second map,
bpf_insn_aux_data->map_ptr_state will be marked as *poison*. In fact
both map_ptr and state are needed to support this use case: map_ptr is
used by set_map_elem_callback_state() while poison state is needed to
determine whether to use direct call.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 kernel/bpf/verifier.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 515ac6165ab1..f0a33f7c2604 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9649,11 +9649,7 @@ static int set_map_elem_callback_state(struct bpf_verifier_env *env,
 	struct bpf_map *map;
 	int err;
 
-	if (bpf_map_ptr_poisoned(insn_aux)) {
-		verbose(env, "tail_call abusing map_ptr\n");
-		return -EINVAL;
-	}
-
+	/* should not check poison */
 	map = insn_aux->map_ptr_state.map_ptr;
 	if (!map->ops->map_set_for_each_callback_args ||
 	    !map->ops->map_for_each_callback) {
-- 
2.32.0.3.g01195cf9f

