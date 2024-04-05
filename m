Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A221CA81
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 02:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285747; cv=none; b=SFkp4VLcurVe9fMYfdbSbtoKLt9+ivfqlTMoRQs7Oy195g0VY+z7oQwLRZcK3Gx2TFbMbjQ3GtRGi+Mjo04ur0OgDwq9zrynbBPY5Wjrx0SCpyyGbzlDSTDFlfL/UL2TUNnskLeG+IAxPKiFF7hYw/dQ86aYZIUt/DFo3DmBp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285747; c=relaxed/simple;
	bh=sglbc5wJHNORpr55BG638jvxqmNu6NJWf9TjaXqyMiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oiUs/lZVbJSkvx6649LyB2a7e5+Z2gzi2HBOud9T57x6dGH/3E6tp0ZBe0g4EBnIfcAd3hdFNwnp2UXhPW7j7+msGVZDOlkGd/6laLTkiTqFf7tbLCWRyTZPpBMDjK1vMoV+FqoMSpjLnqPErkwBZ1/qjElj/H8DiYysI3uEJH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qF90sqhC; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qF90sqhC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712285741; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+4W+yd2fMau2NNteVbfAIJrXWKOU1RoA5xQnaQul2VY=;
	b=qF90sqhCMQXo6b+9LBXg+27NDm4lp8GIW23VpHwAwRZhJnnPm8AEujp8JS50+8iq/R66EEnDLSJg3bV4jyUregOAtEXpMDzwGGJtzMZuuNC+2/+Gu2+SsLyRgz3xyK+BxDvzWN3AHaN4REbSBVqV02huqFs6ZUlPSXb/WBt8bkE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W3vv8Zi_1712285739;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W3vv8Zi_1712285739)
          by smtp.aliyun-inc.com;
          Fri, 05 Apr 2024 10:55:40 +0800
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
Subject: [PATCH bpf-next v1 2/3] bpf: allow invoking bpf_for_each_map_elem with different maps
Date: Fri,  5 Apr 2024 10:55:35 +0800
Message-Id: <20240405025536.18113-3-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240405025536.18113-1-lulie@linux.alibaba.com>
References: <20240405025536.18113-1-lulie@linux.alibaba.com>
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
index 7f95a186e636..3cb0dc254503 100644
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
+	/* valid map_ptr and poison value does not matter */
 	map = insn_aux->map_ptr_state.map_ptr;
 	if (!map->ops->map_set_for_each_callback_args ||
 	    !map->ops->map_for_each_callback) {
-- 
2.32.0.3.g01195cf9f

