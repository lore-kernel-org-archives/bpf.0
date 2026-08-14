Received: from mta1.migadu.com (out-140.mta1.migadu.com [95.215.58.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B31A4908A6
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728764; cv=none; b=LWGHLba8qiTRUTcezZ8t3udlo5WJmbkHWUFsmDS8OSM3UifSRdFq0UNXZElCJyRlul6oR6/Ht5U3ICxO6IoCD0S7dU5Ht2HB4LCk3nqbfSJrfLYRs3pZCNmYSfHepH8CbqO9s85tces+tDYWF2qNuCzRzkdUhE27aSoHiAyyRZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728764; c=relaxed/simple;
	bh=3ENQ7a7ZVw1Jubs+Y/z29VuNIVqciMWe+bFwERZaRYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ck8jMjebvHiqGz0HN2UIBlQynGDsKIq/oFJNP+G7IEMZZAxOakJRzL+58Ju3meIDpyRZTPCvVCn0AkS3dt5uTCamuq7WdNv72Qe8lMdVXNv+mpHnOOO2T8zvMrf3HfQWCiAMizgtrJeT9qeeOuK35DpiY9Lo4KmmwQdKQs9m5N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WhVLc8aS; arc=none smtp.client-ip=95.215.58.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WhVLc8aS"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3ENQ7a7ZVw1Jubs+Y/z29VuNIVqciMWe+bFwERZaRYk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786728760; v=1; x=1787333560;
 b=WhVLc8aSP+JaFkIeenB2MCaCfXRBO+2Fr/IXBTfyiWG7flhrMBPrhSrPafwu+RgNdz9/DQgB
 w2LMV+P6WmMvuxKFd0ALtK0o9QwAetxKCdnwaOXgJBPDTiEVLeXey3yk2fDUFz1FTiMjhSPvqH8
 pdXIRBy4jx75ZmOeECv1fdCE=
X-Envelope-To: bpf@vger.kernel.org
Received: from .linux.dev (117.20.149.103)
	by smtp.migadu.com with ESMTPS id dd5d7441ddaad0d1;
	Fri, 14 Aug 2026 17:32:40 +0000
X-Migadu-Flow: FLOW_OUT
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
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 3/5] bpftool: Update comments about skel data maps
Date: Sat, 15 Aug 2026 01:32:04 +0800
Message-ID: <20260814173206.93082-4-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814173206.93082-1-leon.hwang@linux.dev>
References: <20260814173206.93082-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since is_skel_data() includes the non-memory-mapped percpu_array map, the
"memory-mapped maps" in comments are incorrect for percpu data.

Update "memory-mapped internal maps" to "skel data maps" for better
explanation.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/bpf/bpftool/gen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a50540ef6521..e5e82255af24 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -303,7 +303,7 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 		return -errno;
 
 	bpf_object__for_each_map(map, obj) {
-		/* only generate definitions for memory-mapped internal maps */
+		/* only generate definitions for skel data maps */
 		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
 			continue;
 
@@ -510,7 +510,7 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
 	return map_sz;
 }
 
-/* Emit type size asserts for all top-level fields in memory-mapped internal maps. */
+/* Emit type size asserts for all top-level fields in skel data maps. */
 static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
 {
 	struct btf *btf = bpf_object__btf(obj);
-- 
2.55.0

