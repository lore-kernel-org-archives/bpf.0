Return-Path: <SRS0=V6te=D5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDE2C388F7
	for <bpf@archiver.kernel.org>; Thu, 22 Oct 2020 08:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEA9223BF
	for <bpf@archiver.kernel.org>; Thu, 22 Oct 2020 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603354937;
	bh=JWBpMbQjNa3iCp9Q3TAwK7cZwyAjXbCTC8bf0/smNBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BCMf01kaRj3Po+43IStbLizhlNtFh/Rxa8PTknuQCEC2f4ZfOk70mGSDHnWKdzRz9
	 JeVevGHikGNlrDvfx5a3HPdG5nv03gbBLrAmfX4sDSNkz5HVMp3EDI7xraYv1PloG8
	 aTJ/qtHY1K/Z/kRwtk3nI9jJKjEywhvNRUhWh24A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895233AbgJVIWP convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 22 Oct 2020 04:22:15 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:59072 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2895231AbgJVIWO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 22 Oct 2020 04:22:14 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-t04g1738PrSBKV3W_FzIHQ-1; Thu, 22 Oct 2020 04:22:09 -0400
X-MC-Unique: t04g1738PrSBKV3W_FzIHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B11110E2180;
        Thu, 22 Oct 2020 08:22:07 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F00160BFA;
        Thu, 22 Oct 2020 08:22:04 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jesper Brouer <jbrouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Viktor Malik <vmalik@redhat.com>
Subject: [RFC bpf-next 05/16] ftrace: Add register_ftrace_direct_ips function
Date:   Thu, 22 Oct 2020 10:21:27 +0200
Message-Id: <20201022082138.2322434-6-jolsa@kernel.org>
In-Reply-To: <20201022082138.2322434-1-jolsa@kernel.org>
References: <20201022082138.2322434-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding register_ftrace_direct_ips function that llows
to register array of ip addresses and trampolines
for direct filter. the interface is:

  int register_ftrace_direct_ips(unsigned long *ips,
                                 unsigned long *addrs,
                                 int count);

It wil be used in following patches to register bpf
trampolines in batch mode.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |  2 ++
 kernel/trace/ftrace.c  | 75 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index d71d88d10517..9ed52755667a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -291,6 +291,8 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 				unsigned long old_addr,
 				unsigned long new_addr);
 unsigned long ftrace_find_rec_direct(unsigned long ip);
+int register_ftrace_direct_ips(unsigned long *ips, unsigned long *addrs,
+			       int count);
 #else
 # define ftrace_direct_func_count 0
 static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 44c2d21b8c19..770bcd1a245a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5231,6 +5231,81 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 }
 EXPORT_SYMBOL_GPL(register_ftrace_direct);
 
+int register_ftrace_direct_ips(unsigned long *ips, unsigned long *addrs,
+			       int count)
+{
+	struct ftrace_hash *free_hash = NULL;
+	struct ftrace_direct_func *direct;
+	struct ftrace_func_entry *entry;
+	int i, j;
+	int ret;
+
+	mutex_lock(&direct_mutex);
+
+	/* Check all the ips */
+	for (i = 0; i < count; i++) {
+		ret = check_direct_ip(ips[i]);
+		if (ret)
+			goto out_unlock;
+	}
+
+	ret = -ENOMEM;
+	if (adjust_direct_size(direct_functions->count + count, &free_hash))
+		goto out_unlock;
+
+	for (i = 0; i < count; i++) {
+		entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry)
+			goto out_clean;
+
+		direct = get_direct_func(addrs[i]);
+		if (!direct) {
+			kfree(entry);
+			goto out_clean;
+		}
+
+		direct->count++;
+		entry->ip = ips[i];
+		entry->direct = addrs[i];
+		__add_hash_entry(direct_functions, entry);
+	}
+
+	ret = ftrace_set_filter_ips(&direct_ops, ips, count, 0);
+
+	if (!ret && !(direct_ops.flags & FTRACE_OPS_FL_ENABLED)) {
+		ret = register_ftrace_function(&direct_ops);
+		if (ret)
+			ftrace_set_filter_ips(&direct_ops, ips, count, 1);
+	}
+
+ out_clean:
+	if (ret) {
+		for (j = 0; j < i; j++) {
+			direct = get_direct_func(addrs[j]);
+			if (!direct)
+				continue;
+
+			if (!direct->count)
+				put_direct_func(direct);
+
+			entry = ftrace_lookup_ip(direct_functions, ips[j]);
+			if (WARN_ON_ONCE(!entry))
+				continue;
+			free_hash_entry(direct_functions, entry);
+		}
+	}
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	if (free_hash) {
+		synchronize_rcu_tasks();
+		free_ftrace_hash(free_hash);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_ftrace_direct_ips);
+
 static struct ftrace_func_entry *find_direct_entry(unsigned long *ip,
 						   struct dyn_ftrace **recp)
 {
-- 
2.26.2

