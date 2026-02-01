Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAD26E173
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769982803; cv=none; b=vCWgkl7kn0jMRdfCYSE6IHN75vwnN9+Y6RReOOXbjr1objIZkDmWFX4WndbURMiETdlPo6KJ8CbiJLw+r5xj2/1fl26wAROiaNvSugfNAdg24/d0wtjI0rUCTF5xB4oEyMkP5KNI+Kia4myy0C+uoltVWw3XMlT+en3DnggZgxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769982803; c=relaxed/simple;
	bh=tW+ompafPZXV49JuSnFEfBy/BkZIMjs1dqECeICfgDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZA0nreFzVvxPInxaEtIEDpxtYUqCKW6RTEUITgNauxfSB/eCJkuvRk8mAob5Dp+0+tFK3YMZ6sBeEVXoNRkikXMXiO1rFV5+yevmxGDMs2ROjPZ6gHPOPTBpdOzYwC4/+CI+mb/E1kaD26m5XEyS735p+h3uZVIdwYldUHFK6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VDIKzZ0V; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VDIKzZ0V"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769982799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7mGV3Nuub+VvmJ8cY/wNMOcNA2p422Z13U0w6JvGN+Q=;
	b=VDIKzZ0VlcGtXTcVZHqs4gbzzKZTHGyapB/DLw9SXhiUWjlJtOp+yX2lDSSJmCU8dF47Se
	mYV9+0elF4NgyluGm+Lmc8QxQ93njcbIypEpy3e0xYZJO5FkBu142aNsD9k9o2rMRnTqyF
	L4sUXqsCB92R/qAgKDPPK2qAmHAFJpY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf: Replace snprintf("%s", ...) with strscpy in parse_{base,module}
Date: Sun,  1 Feb 2026 22:52:48 +0100
Message-ID: <20260201215247.677121-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace snprintf("%s", ...) with the faster and more direct strscpy().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Keep snprintf("%s", ...) in btf_show_name() as suggested by Alexei
- Update patch title
- Link to v1: https://lore.kernel.org/lkml/20260201180445.664056-2-thorsten.blum@linux.dev/
---
 kernel/bpf/btf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8959f3bc1e92..7708958e3fb8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -25,6 +25,7 @@
 #include <linux/perf_event.h>
 #include <linux/bsearch.h>
 #include <linux/kobject.h>
+#include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/overflow.h>
 
@@ -6324,7 +6325,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	btf->data_size = data_size;
 	btf->kernel_btf = true;
 	btf->named_start_id = 0;
-	snprintf(btf->name, sizeof(btf->name), "%s", name);
+	strscpy(btf->name, name);
 
 	err = btf_parse_hdr(env);
 	if (err)
@@ -6443,7 +6444,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	btf->start_str_off = base_btf->hdr.str_len;
 	btf->kernel_btf = true;
 	btf->named_start_id = 0;
-	snprintf(btf->name, sizeof(btf->name), "%s", module_name);
+	strscpy(btf->name, module_name);
 
 	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!btf->data) {
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

