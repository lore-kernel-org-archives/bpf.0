Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B33E9F96;
	Mon, 30 Mar 2026 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910365; cv=none; b=dgxntStS5+7kuey6BLkjmgpBYN2aUQnr1xj2e/9PJIRuag/VdLy+nz9TeVAlpdaJBkn0d3HkRG3TCm/gpktTisfYJWpK8jghu1ogO8UtEompAfY/iFTCURhYEmHqCBvE4f91GLrSAVPdSedZ13Z64WsvQUtVvQr6httAzZjv15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910365; c=relaxed/simple;
	bh=TwsrmNJ7QssX1MDhmOKLBLHVuRzzNYSq93LE55QsCVc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gvqnkI64DkpFZEoj8lXF+X1EpdZL2RUJ+eQI+7smwvaiOCXaCO37uhCXNzdtDP9cBAxJ2XsSAsHSvuz1w/LYCEI5S9w39nv1gYkM5A5a3QRdQzzjc3rxyWPqr7tWbyJjXsgFNtGn7Ll/Te4n36tq+6c/8epZYXP47h4HvKJSPyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwdqFiTo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwdqFiTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC12C4CEF7;
	Mon, 30 Mar 2026 22:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774910364;
	bh=TwsrmNJ7QssX1MDhmOKLBLHVuRzzNYSq93LE55QsCVc=;
	h=Date:From:To:Cc:Subject:From;
	b=GwdqFiTogc7F2gsU+gMrS6MyLFsi0Z2jZ+MtjuE3l52DlAaQgpBkftxgsoTTB9jSa
	 PPzBO537tnppzqKFwmisVIe/ZjYklkkMTal7xkBy3EP3M1J+NPyxkNckpJFWYdtUzF
	 rKToAB2AE11OqXOD3Ib3N47fuaPAVaw6hEvblflyrK7htesktJCcZqB2xcIKjs2nlP
	 9HMTg1tHgfTUH1wSgz3urU6s4DEMpNwntLn7lMN7W+Pja2VG7Y2DXAKeDpuu7TeAUT
	 x0Nvum+zUm3klepemH1UTsEDY0CHkQcl11AyBa0EtWN9QRO4f9jhRThx3YJbDXKBGh
	 VK6Kr2w/eJ65Q==
Date: Mon, 30 Mar 2026 16:38:18 -0600
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
Subject: [PATCH v2][next] bpf: Avoid thousands of
 -Wflex-array-members-not-at-end warnings
Message-ID: <acr7Whmn0br3xeBP@kspp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Apparently, struct bpf_empty_prog_array exists entirely to populate a
single element of "items" in a global variable. "null_prog" is only
used during the initializer.

None of this is needed; globals will be correctly sized with an array
initializer of a flexible-array member.

So, remove struct bpf_empty_prog_array and adjust the rest of the code,
accordingly. 

With these changes, fix the following warnings:

7659 ./include/linux/bpf.h:2369:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Remove struct bpf_empty_prog_array. (Kees)

v1:
 -Link: https://lore.kernel.org/linux-hardening/aaZr2A1UPJq33127@kspp/

 include/linux/bpf-cgroup.h |  2 +-
 include/linux/bpf.h        |  7 +------
 kernel/bpf/core.c          | 12 +++++++-----
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 2f535331f926..b2e79c2b41d5 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -184,7 +184,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	struct bpf_prog_array *array;
 
 	array = rcu_access_pointer(cgrp->bpf.effective[type]);
-	return array != &bpf_empty_prog_array.hdr;
+	return array != &bpf_empty_prog_array;
 }
 
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b0..4f5b9e85a20c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2365,18 +2365,13 @@ struct bpf_prog_array {
 	struct bpf_prog_array_item items[];
 };
 
-struct bpf_empty_prog_array {
-	struct bpf_prog_array hdr;
-	struct bpf_prog *null_prog;
-};
-
 /* to avoid allocating empty bpf_prog_array for cgroups that
  * don't have bpf program attached use one global 'bpf_empty_prog_array'
  * It will not be modified the caller of bpf_prog_array_alloc()
  * (since caller requested prog_cnt == 0)
  * that pointer should be 'freed' by bpf_prog_array_free()
  */
-extern struct bpf_empty_prog_array bpf_empty_prog_array;
+extern struct bpf_prog_array bpf_empty_prog_array;
 
 struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
 void bpf_prog_array_free(struct bpf_prog_array *progs);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 67eb12b637a5..ca39d2e690b9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2613,8 +2613,10 @@ static struct bpf_prog_dummy {
 	},
 };
 
-struct bpf_empty_prog_array bpf_empty_prog_array = {
-	.null_prog = NULL,
+struct bpf_prog_array bpf_empty_prog_array = {
+	.items = {
+		{ .prog = NULL },
+	},
 };
 EXPORT_SYMBOL(bpf_empty_prog_array);
 
@@ -2625,14 +2627,14 @@ struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 	if (prog_cnt)
 		p = kzalloc_flex(*p, items, prog_cnt + 1, flags);
 	else
-		p = &bpf_empty_prog_array.hdr;
+		p = &bpf_empty_prog_array;
 
 	return p;
 }
 
 void bpf_prog_array_free(struct bpf_prog_array *progs)
 {
-	if (!progs || progs == &bpf_empty_prog_array.hdr)
+	if (!progs || progs == &bpf_empty_prog_array)
 		return;
 	kfree_rcu(progs, rcu);
 }
@@ -2653,7 +2655,7 @@ static void __bpf_prog_array_free_sleepable_cb(struct rcu_head *rcu)
 
 void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
 {
-	if (!progs || progs == &bpf_empty_prog_array.hdr)
+	if (!progs || progs == &bpf_empty_prog_array)
 		return;
 	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
 }
-- 
2.43.0

