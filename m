Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EEA134428
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051277; cv=none; b=oJ3HVDj+EgAcA5HC3jvnyL99gwX10n6WqxhHMl9fcb/GA7qvWQmJ+D3+15DGJkcvowMlx2mj3aNNKFIwEvs+kZy9syU+pfDYksMBEjPh8sTYXTvrkne9JOFMFyoceeO2voiVEfNkwjX4uD2cts3C+mlIAP3j1Nn63lBa38oswXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051277; c=relaxed/simple;
	bh=+XzNW0r9gGhfWDAgjiQ5xYNIkosQ3qBe4Uk/6UbFQ7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeGCEYQbvFVK7yaDMCuWql5TFuNoWda0apVVdLmxYSe8mPZv8zpOGMmYeKhfVmKVcVsCsbOefa28rGwv1xMmiN0ptgqMJRwBFJ7+2dA1kPqdsUks0KDYSVLPxyRCyLuHiIokyGaiiWejlEAQj1NVWxitNelL6KToFmnaf5zRRIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id EB8CB221903A; Thu, 21 Mar 2024 13:01:08 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/5] libbpf: Mark libbpf_kallsyms_parse static function
Date: Thu, 21 Mar 2024 13:01:08 -0700
Message-ID: <20240321200108.2219280-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321200058.2218328-1-yonghong.song@linux.dev>
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently libbpf_kallsyms_parse() function is declared as a global
function but actually it is not a API and there is no external
users in bpftool/bpf-selftests. So let us mark the function as
static.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c          | 2 +-
 tools/lib/bpf/libbpf_internal.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 86df0d50cba7..a7a89269148c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7982,7 +7982,7 @@ static int bpf_object__sanitize_maps(struct bpf_obj=
ect *obj)
 	return 0;
 }
=20
-int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
+static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
 {
 	char sym_type, sym_name[500];
 	unsigned long long sym_addr;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index 864b36177424..b1bbbdcb7792 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -521,8 +521,6 @@ __s32 btf__find_by_name_kind_own(const struct btf *bt=
f, const char *type_name,
 typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_type,
 			     const char *sym_name, void *ctx);
=20
-int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *arg);
-
 /* handle direct returned errors */
 static inline int libbpf_err(int ret)
 {
--=20
2.43.0

