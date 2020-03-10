Return-Path: <SRS0=x1rW=43=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E46C18E5A
	for <bpf@archiver.kernel.org>; Tue, 10 Mar 2020 17:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C44920727
	for <bpf@archiver.kernel.org>; Tue, 10 Mar 2020 17:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="witwoPxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgCJRrc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:47:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39051 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgCJRrc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Mar 2020 13:47:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id f7so2378117wml.4
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2020 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=npmqyLC4H/hqzxrhW1ZFXspPQ84Dm9XWgo+tS3ZwYuE=;
        b=witwoPxUMnZ1q4jIFaWCCe9GWQWLXaMvo+Jd0UehTaGGw0ZT+jNrbQDFdHWAVQYfCj
         ggOpJkXSFnPqHQlIMZS+pKecTPIGzSktjhI3lWajEHuiEE5oRiwJwHCRLflqfXaRE8FM
         b6pkY6tvS7aBQXslcYSkanLted/u+n9dGm0SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npmqyLC4H/hqzxrhW1ZFXspPQ84Dm9XWgo+tS3ZwYuE=;
        b=VLnr/vVtWdpT6VhBN5AzGE4yoSiQhk7cVKX7UC7S9H1iAfLd8ukHC2ZT1swjssgz6G
         5t4Yo988qTwc8t99QB8BX0n3z2J2FTNumDGOsjJqaUcKP3iboszDl8xElJzj5m+VjpFy
         Nrr2b+JwmWMvA6K2BAWWj4EAnNYXNq9FMxrL7lMFUk24qaqAwix/a3fpffBmpDV6O+nG
         w7xWk2enoV5ol7PgOG5SJRYNOPwiPT4AaAY0ZHtdXWz0XxNxcgQ4JmHzLIW+4kAqCX4o
         yCciD5p1BKD01XXLZlGJuKXewIaVrRx8rDwO03cEa26iIRzagQrvHUAnqWSYT3raIWVR
         Kabg==
X-Gm-Message-State: ANhLgQ0HGC7l6Z4jxnIdhNIIi7fGAiwrgHIe11mXnZ/lZsF9fpbjQkBW
        nzo1w1QeOXD1HbbgR/U0hfTPFg==
X-Google-Smtp-Source: ADFU+vtai1/9M3ILySaSaKTd96UOxXEAKNdtViy5HhG7OgZRyr5BzXvebagcWd+0u1zYdlwaWP+2Bg==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr3074313wma.114.1583862450625;
        Tue, 10 Mar 2020 10:47:30 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:9494:775c:e7b6:e690])
        by smtp.gmail.com with ESMTPSA id k4sm9118691wrx.27.2020.03.10.10.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:47:29 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] bpf: convert queue and stack map to map_copy_value
Date:   Tue, 10 Mar 2020 17:47:08 +0000
Message-Id: <20200310174711.7490-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310174711.7490-1-lmb@cloudflare.com>
References: <20200310174711.7490-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Migrate BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK to map_copy_value,
by introducing small wrappers that discard the (unused) key argument.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/queue_stack_maps.c | 18 ++++++++++++++++++
 kernel/bpf/syscall.c          |  5 +----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index f697647ceb54..5c89b7583cd2 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -262,11 +262,28 @@ static int queue_stack_map_get_next_key(struct bpf_map *map, void *key,
 	return -EINVAL;
 }
 
+/* Called from syscall */
+static int queue_map_copy_value(struct bpf_map *map, void *key, void *value)
+{
+	(void)key;
+
+	return queue_map_peek_elem(map, value);
+}
+
+/* Called from syscall */
+static int stack_map_copy_value(struct bpf_map *map, void *key, void *value)
+{
+	(void)key;
+
+	return stack_map_peek_elem(map, value);
+}
+
 const struct bpf_map_ops queue_map_ops = {
 	.map_alloc_check = queue_stack_map_alloc_check,
 	.map_alloc = queue_stack_map_alloc,
 	.map_free = queue_stack_map_free,
 	.map_lookup_elem = queue_stack_map_lookup_elem,
+	.map_copy_value = queue_map_copy_value,
 	.map_update_elem = queue_stack_map_update_elem,
 	.map_delete_elem = queue_stack_map_delete_elem,
 	.map_push_elem = queue_stack_map_push_elem,
@@ -280,6 +297,7 @@ const struct bpf_map_ops stack_map_ops = {
 	.map_alloc = queue_stack_map_alloc,
 	.map_free = queue_stack_map_free,
 	.map_lookup_elem = queue_stack_map_lookup_elem,
+	.map_copy_value = stack_map_copy_value,
 	.map_update_elem = queue_stack_map_update_elem,
 	.map_delete_elem = queue_stack_map_delete_elem,
 	.map_push_elem = queue_stack_map_push_elem,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6503824e81e9..20c6cdace275 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -218,10 +218,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 		return bpf_map_offload_lookup_elem(map, key, value);
 
 	bpf_disable_instrumentation();
-	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
-	    map->map_type == BPF_MAP_TYPE_STACK) {
-		err = map->ops->map_peek_elem(map, value);
-	} else if (map->ops->map_copy_value) {
+	if (map->ops->map_copy_value) {
 		err = map->ops->map_copy_value(map, key, value);
 	} else {
 		rcu_read_lock();
-- 
2.20.1

