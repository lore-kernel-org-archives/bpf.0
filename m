Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEE03E92A7
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174089; cv=none; b=Z0Bwi2tuR9rC3T9q5AxjhaJ2XiUIK30+ARqf25FDB5vE6GowEWBfpcA1zc2cHp1esdrvLn/uoKZF6cZ+GTRmL7TOGI/pTSSWJwnCRPRMHWqEHLQcfwsHG42/yJ78tFmfdXdArx1Kuqc8n5LLEIbyL2lqPuF9m+P+EDmAhi0qHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174089; c=relaxed/simple;
	bh=celh8eF/dxD9cYaTHCfog7OqihCVIHrL/xhSFPiM/IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoWPNh8MRakeNpRbxCRY4/oS/S40348pbQRVWqRKNt3t5dzPJWXsmdQJutQgoytbEgmEZHtu4wDk5PoSOjWnXh58KwvERTuHE41dChV0U4k9fJIGVzyUEhPCfxJlICEMq2b2pN6ezVnRXeU/RL1FlKthuEVN3Zuw9U1mF/lAsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqI+ZqEr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqI+ZqEr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773174087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJfG1JwDuOgTCv7ruA7kH2Kv1IMYgbflkixcGCsT6rE=;
	b=BqI+ZqErbJKCKo6tUIuOh48nnu9CF/ni+nzArwekqZk7/AWq8bC/aDh/Fk6dYMRtTcSIjb
	fysGTPRm3Pk99jmDDms4ww/lIvEKga96qPNq9DqUt5hXbSRyIHgG2W4ewYZuCv30SbSRj9
	DuBJ06lw6H+JrJU1BZ276SXJt3C4ih8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-zhdR7OEpObelt3aIxVCUZQ-1; Tue,
 10 Mar 2026 16:21:22 -0400
X-MC-Unique: zhdR7OEpObelt3aIxVCUZQ-1
X-Mimecast-MFC-AGG-ID: zhdR7OEpObelt3aIxVCUZQ_1773174080
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 446E81956088;
	Tue, 10 Mar 2026 20:21:20 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.80.152])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D06F8180049D;
	Tue, 10 Mar 2026 20:21:17 +0000 (UTC)
From: Gregory Bell <grbell@redhat.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	Gregory Bell <grbell@redhat.com>
Subject: [PATCH bpf-next 1/1] bpf: Fix BTF module cleanup race condition in struct_ops
Date: Tue, 10 Mar 2026 16:21:02 -0400
Message-ID: <a46d40ac2b56f96b3b6e953847ad4719694d68eb.1773170190.git.grbell@redhat.com>
In-Reply-To: <cover.1773170190.git.grbell@redhat.com>
References: <cover.1773170190.git.grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When running BPF struct_ops tests consecutively, the second test fails
because BTF object references take longer to be released while their
associated module is removed from btf_modules list immediately
during module unload. This creates a race condition where the second
test retrieves the cached BTF object but cannot find valid module
information, causing btf_try_get_module() to return NULL.

Fix this by modifying MODULE_STATE_GOING handling to wait for
active BTF references to be released before completing module
cleanup. This ensures BTF objects are properly cleaned up from the
cache before their module metadata is removed, eliminating the timing
window that caused the race condition.

Signed-off-by: Gregory Bell <grbell@redhat.com>
---
 kernel/bpf/btf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 09fcbb125155..81c9f46a7bb7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8382,7 +8382,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
 			if (btf_mod->module != module)
 				continue;
-
+			unsigned int timeout = 1000;
+			while (refcount_read(&btf_mod->btf->refcnt) > 1
+			&& timeout > 0 ) {
+				msleep(1);
+				timeout--;
+			}
 			list_del(&btf_mod->list);
 			if (btf_mod->sysfs_attr)
 				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
-- 
2.52.0

