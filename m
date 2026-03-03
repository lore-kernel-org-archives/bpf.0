Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AC83890E1;
	Tue,  3 Mar 2026 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568295; cv=none; b=FiJXcTKfjxno/bgXNpOI75h1IsLDS0uby2UNZ5nyH0C8id7Z1cQgWGaEZ1Yp5RinmYcc+FTlqtI2/Qz0p58h1H4rUDk0nE7KdYNtXq1HoYygJn3TYQ2ZQ6jmbxULbC/NTYcMuc5cD68p12rqX43XGdDtYi3xwyO5IXZj0ZwNltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568295; c=relaxed/simple;
	bh=Qj8+TYobz9svKb+bbVJ56ph3mB+FicVT/jE7eZHw7D4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rXa8DaAKEyJco5JD0kAEWMyiWMMt/+JrG7F+nbTDjfJLA4gqUUdWWRKQVnV79kCgnkTiij0ycDoc2Yt6DSyuqCq/KZ8C7ShpLZXVUndlWxP0T+R3o+oOFoXzvZ5lrd5wNaHQx4bxK3tFwFhkX+2hT22zdlVwPZlltFLdjzHG8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsOYV8l/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsOYV8l/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB21C116C6;
	Tue,  3 Mar 2026 20:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772568295;
	bh=Qj8+TYobz9svKb+bbVJ56ph3mB+FicVT/jE7eZHw7D4=;
	h=Date:From:To:Cc:Subject:From;
	b=YsOYV8l/ULA0bztoVlum4Bs5mIihyKus1QiZv5aesrnEud8RTLrIdC0Jqu+eUvVsg
	 65VtWbl0hFSYN+4TKxN5WmSycdTMWA4jFRp6hIDqdGipxnsD3BJBYyYS920lWaTsBE
	 E2A3b2HxS4+UFMGfbbo3+Omhi4w//iKpStymRR0GCeiY0f4dEVbk5zRW90OSa9s3kx
	 DrO6p5OxSMPXSPKfvTMeFKxhdLLi6W170MEU7vWAuY6jbtlVYPRIOYNjFJAo6LoXmU
	 o5+zfHm23ZwUS23cGk/H/pU9VjMMKetWkRgVYlMU/JW6vhRoKpe7w94B69avdLG0K4
	 WHl5KtIfEebkg==
Date: Tue, 3 Mar 2026 14:04:24 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH][next] bpf: Avoid thousands of
 -Wflex-array-members-not-at-end warnings
Message-ID: <aaZr2A1UPJq33127@kspp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

struct bpf_prog_array is a flexible structure, this is a structure that
contains a flexible-array member (struct bpf_prog_array_item items[];).

We create the new struct bpf_prog_array_hdr type, and use it to replace
the object type causing trouble in struct bpf_empty_prog_array, namely
struct bpf_prog_array hdr; 

Also, once -fms-extensions is enabled, we can use transparent struct
members in struct bpf_prog_array.

Notice that the newly created type does not contain the flex-array
member `items`, which is the object causing the -Wfamnae warnings
in struct bpf_empty_prog_array.

With these changes, fix the following warnings:
    
7659 ./include/linux/bpf.h:2369:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/bpf-cgroup.h | 2 +-
 include/linux/bpf.h        | 8 ++++++--
 kernel/bpf/core.c          | 6 +++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 2f535331f926..e7d266600ac7 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -184,7 +184,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	struct bpf_prog_array *array;
 
 	array = rcu_access_pointer(cgrp->bpf.effective[type]);
-	return array != &bpf_empty_prog_array.hdr;
+	return (void *)array != (void *)&bpf_empty_prog_array.hdr;
 }
 
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b0..488de065466e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2360,13 +2360,17 @@ struct bpf_prog_array_item {
 	};
 };
 
-struct bpf_prog_array {
+struct bpf_prog_array_hdr {
 	struct rcu_head rcu;
+};
+
+struct bpf_prog_array {
+	struct bpf_prog_array_hdr;
 	struct bpf_prog_array_item items[];
 };
 
 struct bpf_empty_prog_array {
-	struct bpf_prog_array hdr;
+	struct bpf_prog_array_hdr hdr;
 	struct bpf_prog *null_prog;
 };
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 229c74f3d6ae..ac15ab8b7d3c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2598,14 +2598,14 @@ struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 	if (prog_cnt)
 		p = kzalloc_flex(*p, items, prog_cnt + 1, flags);
 	else
-		p = &bpf_empty_prog_array.hdr;
+		p = (void *)&bpf_empty_prog_array.hdr;
 
 	return p;
 }
 
 void bpf_prog_array_free(struct bpf_prog_array *progs)
 {
-	if (!progs || progs == &bpf_empty_prog_array.hdr)
+	if (!progs || (void *)progs == (void *)&bpf_empty_prog_array.hdr)
 		return;
 	kfree_rcu(progs, rcu);
 }
@@ -2626,7 +2626,7 @@ static void __bpf_prog_array_free_sleepable_cb(struct rcu_head *rcu)
 
 void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
 {
-	if (!progs || progs == &bpf_empty_prog_array.hdr)
+	if (!progs || (void *)progs == (void *)&bpf_empty_prog_array.hdr)
 		return;
 	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
 }
-- 
2.43.0

