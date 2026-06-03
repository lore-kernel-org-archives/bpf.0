Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82825368D5C;
	Wed,  3 Jun 2026 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484906; cv=none; b=NkjL1nserz3xX0zAr1dYMXDt9QxbQZBKoHJmkEHIEgebwA4jPZT+EyfiFpBHRmWM4oY/hpTVtJxvQXPGXOo4uBqYO4ZDNPo6IHnhKZJ7n3UEBZtulrz76U4rXqvpG66UixzBd7Df39grY9C1y+sBDAEowzLC9Kn3cR1UxMAovhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484906; c=relaxed/simple;
	bh=bmdUIOcySOHmvh0UPoO8H8Jfhct+U0HTnTfuyIgabl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnryIMCTSonkDJFUVjBm9WBgga14XAhUYQKZEmA51q+36Y5dmYaKFWQaBIM2OEfCRlpKh/SDAbcVotQ3Q1t5rWfc2A2z6rBr59Y8nTHVNVBZeCKhsc5tf2iBzs3c5Itg1RjVGqIPUbEiMMFSacNcKLvAjzLc14uZLS3FODwK1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIQFdO/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIQFdO/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3E91F00893;
	Wed,  3 Jun 2026 11:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484905;
	bh=KNf4zhMY/A9RTrwAvq0pzoiDBm5B8mp0FaiL7LRpHtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SIQFdO/VrwZGklGa+8D+txBjyMqxwOgMeADYpgRX9pHCpmlCli6DDsmnhHB80jLwP
	 hE23QTomjeR7n9WW+6woPVo92ITGZRSEtri3X1onbw5LxLdLk+3T1+ZWGAfZqC9ccD
	 6V3FT56FPXPIRDSKWfRjiCFrcN9fc3ALzIHhIIsAgkNTuBE9QXpE/Nmr/cGJaVZtrx
	 CTTgmrBKJh5MWwgDCmeroggeGJ7ED3wvt7uZVnYcy4MH12XzGR7unapVEurr6iJ8YI
	 5nPn1TFZI7RS/GNj0X0XzW9mBdU+fw0p0WzJBsmckEEBhGxOlAQURbx1ZWtxVgWeZo
	 QcWixQaR3xtSA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv7 bpf-next 14/29] bpf: Add support for tracing_multi link cookies
Date: Wed,  3 Jun 2026 13:05:38 +0200
Message-ID: <20260603110554.29590-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603110554.29590-1-jolsa@kernel.org>
References: <20260603110554.29590-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to specify cookies for tracing_multi link.

Cookies are provided in array where each value is paired with provided
BTF ID value with the same array index.

Such cookie can be retrieved by bpf program with bpf_get_attach_cookie
helper call.

We need to sort cookies array together with ids array in check_dup_ids,
to keep the id->cookie relation.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/trampoline.c        |  1 +
 kernel/trace/bpf_trace.c       | 37 ++++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h |  1 +
 5 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ae0a4b255a35..2da0de17275a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1952,6 +1952,7 @@ struct bpf_tracing_multi_data {
 struct bpf_tracing_multi_link {
 	struct bpf_link link;
 	struct bpf_tracing_multi_data data;
+	u64 *cookies;
 	int nodes_cnt;
 	struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 951a0122baaf..39407a77133b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1874,6 +1874,7 @@ union bpf_attr {
 			} cgroup;
 			struct {
 				__aligned_u64	ids;
+				__aligned_u64	cookies;
 				__u32		cnt;
 			} tracing_multi;
 		};
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 957e5d7f9554..a3537fda50cf 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1613,6 +1613,7 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 
 		mnode->trampoline = tr;
 		mnode->node.link = &link->link;
+		mnode->node.cookie = link->cookies ? link->cookies[i] : 0;
 
 		cond_resched();
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9e3cb547651e..e33492739ed1 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3659,6 +3659,7 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
+	kvfree(tr_link->cookies);
 	kvfree(tr_link);
 }
 
@@ -3678,13 +3679,24 @@ static int ids_cmp_r(const void *pa, const void *pb, const void *priv __maybe_un
 static void ids_swap_r(void *a, void *b, int size __maybe_unused,
 		       const void *priv __maybe_unused)
 {
-	u32 *id_a = a, *id_b = b;
+	u64 *cookie_a, *cookie_b, *cookies;
+	u32 *id_a = a, *id_b = b, *ids;
+	void **data = (void **) priv;
 
+	ids     = data[0];
+	cookies = data[1];
+
+	if (cookies) {
+		cookie_a = cookies + (id_a - ids);
+		cookie_b = cookies + (id_b - ids);
+		swap(*cookie_a, *cookie_b);
+	}
 	swap(*id_a, *id_b);
 }
 
-static int check_dup_ids(u32 *ids, u32 cnt)
+static int check_dup_ids(u32 *ids, u64 *cookies, u32 cnt)
 {
+	void *data[2] = { ids, cookies };
 	int err = 0;
 
 	/*
@@ -3692,7 +3704,7 @@ static int check_dup_ids(u32 *ids, u32 cnt)
 	 * and check it for duplicates. The ids and cookies arrays
 	 * are left sorted.
 	 */
-	sort_r_nonatomic(ids, cnt, sizeof(ids[0]), ids_cmp_r, ids_swap_r, NULL);
+	sort_r_nonatomic(ids, cnt, sizeof(ids[0]), ids_cmp_r, ids_swap_r, data);
 
 	for (int i = 1; i < cnt; i++) {
 		if (ids[i] == ids[i - 1]) {
@@ -3708,6 +3720,8 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	struct bpf_tracing_multi_link *link = NULL;
 	struct bpf_link_primer link_primer;
 	u32 cnt, *ids = NULL;
+	u64 __user *ucookies;
+	u64 *cookies = NULL;
 	u32 __user *uids;
 	int err;
 
@@ -3730,7 +3744,20 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		goto error;
 	}
 
-	err = check_dup_ids(ids, cnt);
+	ucookies = u64_to_user_ptr(attr->link_create.tracing_multi.cookies);
+	if (ucookies) {
+		cookies = kvmalloc_objs(*cookies, cnt);
+		if (!cookies) {
+			err = -ENOMEM;
+			goto error;
+		}
+		if (copy_from_user(cookies, ucookies, cnt * sizeof(*cookies))) {
+			err = -EFAULT;
+			goto error;
+		}
+	}
+
+	err = check_dup_ids(ids, cookies, cnt);
 	if (err)
 		goto error;
 
@@ -3748,6 +3775,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		goto error;
 
 	link->nodes_cnt = cnt;
+	link->cookies = cookies;
 
 	err = bpf_trampoline_multi_attach(prog, ids, link);
 	kvfree(ids);
@@ -3758,6 +3786,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	return bpf_link_settle(&link_primer);
 
 error:
+	kvfree(cookies);
 	kvfree(ids);
 	kvfree(link);
 	return err;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 951a0122baaf..39407a77133b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1874,6 +1874,7 @@ union bpf_attr {
 			} cgroup;
 			struct {
 				__aligned_u64	ids;
+				__aligned_u64	cookies;
 				__u32		cnt;
 			} tracing_multi;
 		};
-- 
2.54.0

