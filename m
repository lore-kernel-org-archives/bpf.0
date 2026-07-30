Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C35433BC0;
	Thu, 30 Jul 2026 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418498; cv=none; b=NjXlxQdEsN1cy2sj3CUN7WeSVvYkg2erdiWe0E8se0HaJj/8VGzvJUDD2hvg7EN+xcMBNU2xOIpRVKdynE1SeLtGv6DKYrNZ1LY/Kr4U/HXkPvb3MOLaz6J0YeKOFt7s0y1U6IgkS5OuEYpCfTE/ykTIJs+Sb4ZBilWaqbkRBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418498; c=relaxed/simple;
	bh=32k07tMwHqC5jGfUk0ymZm+EDDpXO5+ws18gTB9e3BM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTr47kzaGFc8ZL0MboUpTx5wvfDnDjKG08K5yU4tcTxys7nqIzl9GFTyZDWN0WqxQk0HJc8LdcfBZBS0Grcmm25PMsMktJQCRjCyNCPRInEsgFwmtguPxgBxrqrGRLPgnxWpr2YX4nfSe9xigRS3biAt7qhai2N5mksGKu80+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcGCKWg/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcGCKWg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800551F000E9;
	Thu, 30 Jul 2026 13:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785418497;
	bh=y6UdV8Ljrrj/Do3m3HasiOXKs4+5D49mrjlgSbHcrEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PcGCKWg/n5+tn7N8bWHivTcGSG0ld/p+OkLj4N4PVITGIQY1s0MfnH4gDQG3uFqQW
	 9LEh0RQAg8FA5aGd8aC4yJXmNvlVwy5LJRN9fYt9677JJh+4VNaJyexnTeoQeyUwXM
	 /ntE+5isrw2PEmx5xCpUZu8a3iUFx8d4TOA0kn43O91DhKFfm2LPJRl2xUkocpY8rp
	 3dH+S/Z7WCgv1NoJ4N8Xz/dmnFYOxjAO/lv/mOwpKTw3Db5MEcq78Y8rkk6vGP4CJC
	 ozAgo/n8epvjB535lsC2tA+lasUZXvS2JdJzs8eyOk/4OXcIh1k1ey1tc2Z/gBBOri
	 UJRmr5yuSW7PA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Jul 2026 15:34:07 +0200
Subject: [PATCH 5/9] selftests/exec: share the bpf handler preconditions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-work-binfmt_misc-preopen-v1-5-4a0b0da71f16@kernel.org>
References: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
In-Reply-To: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 jannh@google.com, mail@johnericson.me, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-3e0c3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2488; i=brauner@kernel.org;
 h=from:subject:message-id; bh=32k07tMwHqC5jGfUk0ymZm+EDDpXO5+ws18gTB9e3BM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlB72blqW+hGOS7eS4xBcPU4zuB7y/53L2SMczuT8TV
 u8I3n1+fkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEhJYyMtx3i65N5DN/Hz61
 9W3Arcy6m625O9WVF31NmtWl670wRZeR4em8qniuznqun6uXrlqlu+eFSvXZhYlxB54+7W246Tf
 xFjsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The bpf handler fixture opens with three probes, each with its own SKIP.
More fixtures with the same needs are about to be added, so hoist the
probes into a helper that reports the first missing precondition.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/exec/binfmt_misc_bpf.c | 43 ++++++++++++++++----------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/exec/binfmt_misc_bpf.c b/tools/testing/selftests/exec/binfmt_misc_bpf.c
index c6f5e8f34985..71bb6d8b4517 100644
--- a/tools/testing/selftests/exec/binfmt_misc_bpf.c
+++ b/tools/testing/selftests/exec/binfmt_misc_bpf.c
@@ -106,6 +106,30 @@ static int check_output(const char *cmd, const char *expected)
 	return strncmp(buf, expected, strlen(expected)) ? -1 : 0;
 }
 
+/* Does the kernel BTF know struct binfmt_misc_ops (CONFIG_BINFMT_MISC_BPF)? */
+static bool have_binfmt_misc_ops(void)
+{
+	struct btf *btf = btf__load_vmlinux_btf();
+	bool have;
+
+	have = btf && btf__find_by_name_kind(btf, "binfmt_misc_ops",
+					     BTF_KIND_STRUCT) >= 0;
+	btf__free(btf);
+	return have;
+}
+
+/* The reason bpf handler cases cannot run here, NULL if they can. */
+static const char *bpf_handler_unsupported(void)
+{
+	if (getuid() != 0)
+		return "test must be run as root";
+	if (!have_binfmt_misc_ops())
+		return "no struct binfmt_misc_ops in the kernel BTF (CONFIG_BINFMT_MISC_BPF)";
+	if (!binfmt_misc_available())
+		return "no binfmt_misc";
+	return NULL;
+}
+
 /* An attached handler with its 'B' entry activated. */
 struct bpf_case {
 	struct bpf_object *obj;
@@ -190,23 +214,10 @@ FIXTURE(bpf_handler) {
 FIXTURE_SETUP(bpf_handler)
 {
 	char src[PATH_MAX];
-	struct btf *btf;
-
-	if (getuid() != 0)
-		SKIP(return, "test must be run as root");
+	const char *why = bpf_handler_unsupported();
 
-	/* The kernel must know struct binfmt_misc_ops (CONFIG_BINFMT_MISC_BPF). */
-	btf = btf__load_vmlinux_btf();
-	if (!btf || btf__find_by_name_kind(btf, "binfmt_misc_ops",
-					   BTF_KIND_STRUCT) < 0) {
-		btf__free(btf);
-		SKIP(return,
-		     "no struct binfmt_misc_ops in the kernel BTF (CONFIG_BINFMT_MISC_BPF)");
-	}
-	btf__free(btf);
-
-	if (!binfmt_misc_available())
-		SKIP(return, "no binfmt_misc");
+	if (why)
+		SKIP(return, "%s", why);
 
 	/* Shared test interpreter. */
 	ASSERT_EQ(artifact_path(src, sizeof(src), "binfmt_bpf_interp"), 0);

-- 
2.53.0

