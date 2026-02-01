Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784B24B45
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769969167; cv=none; b=qQa4HoWVj4wjmSD32DUh6/70SXQ0EeHWWFrI1UukM4mtnYFQIkaZkoBptrjYEMwsmeSqnQoC2WBVbmHVzRugvRA7uht/nSyZzeYubqVuhjoiDg/p7SlbtLXACvfw0dx3pUvS7qSAUR2903l46x2eoPu5q2qj34TqwEtACs3hGTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769969167; c=relaxed/simple;
	bh=QvYG1NXSzapY3iN4ReseN1zWtPiBu3A106cjFPaZZgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H2VHHz8nnfN3TxPET5x6yT+VVVqR75AzHPXHfCAbN5KSwbudquaQnHPtAt+vE7emdmioHUOOyB1Bpa34MaH+7++QxhT+jK4cFXA4FQE3svadR/nkY8Hx3fsykWrBIn+HfPDIUSzhmbWqFYLFFJ7S3p/+UTs7OrPQHEgwelepDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ke5YHglO; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ke5YHglO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769969163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DquVoHz0bHRbcPaOo1xT2MSMheeHJTE2vLWSd+7qSoU=;
	b=Ke5YHglOg5C/WDjMUBbXslPEyrWrm5KgiVEReLHCMQPGDH9MMXSDoDU7EnwknGuSKptG/v
	SMMpxk+PBceEF3yE7muACEK7i7eb+Qo3e72f+khFXccXLagO4LRg7K6wWWCKtzl5s2QJjt
	SgAUWl/KKtPbNxb2LZPgd4wi4cxJoas=
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
Subject: [PATCH bpf-next] bpf: Replace snprintf("%s", ...) with strscpy()
Date: Sun,  1 Feb 2026 19:04:46 +0100
Message-ID: <20260201180445.664056-2-thorsten.blum@linux.dev>
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
 kernel/bpf/btf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8959f3bc1e92..72fa0cb1a71b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -25,6 +25,7 @@
 #include <linux/perf_event.h>
 #include <linux/bsearch.h>
 #include <linux/kobject.h>
+#include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/overflow.h>
 
@@ -1210,8 +1211,7 @@ static const char *btf_show_name(struct btf_show *show)
 
 	/* Even if we don't want type name info, we want parentheses etc */
 	if (show->flags & BTF_SHOW_NONAME)
-		snprintf(show->state.name, sizeof(show->state.name), "%s",
-			 parens);
+		strscpy(show->state.name, parens);
 	else
 		snprintf(show->state.name, sizeof(show->state.name),
 			 "%s%s%s(%s%s%s%s%s%s)%s",
@@ -6324,7 +6324,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	btf->data_size = data_size;
 	btf->kernel_btf = true;
 	btf->named_start_id = 0;
-	snprintf(btf->name, sizeof(btf->name), "%s", name);
+	strscpy(btf->name, name);
 
 	err = btf_parse_hdr(env);
 	if (err)
@@ -6443,7 +6443,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
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

