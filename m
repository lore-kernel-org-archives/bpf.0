Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D9BC282DE
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 13:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF78C2171F
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 13:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="SAGKKXoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfDLN3z (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:29:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40541 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLN3y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 09:29:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so11122731wmi.5
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 06:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gj0f+g6Nl3MHCIF1zHqXaLIJ4ZP9uKspx8+x3phHaDI=;
        b=SAGKKXoPGCKN7hzNDNUjnQCG9MD03IJ0nelRegA72POLFWLmI1wOIzYWepXp3JiqUA
         GPl8dkOhZgoZFsvx5XxDJzGp63vibGbNN+R7udII3X2bG1Mf9GcZC6FUKONaIZpatTXp
         nWTNItNrJfX1ZsEYbgQhURkrcJ8G52NqDS18ipiejYNKc1hj2kgzwt3k1mXxfTRZAMUz
         joguCftPCVhvo8vBucOHXfi5IqzxERx75tA9aZEOWFTEgiWJm5sVQCoCneI1RJR57O62
         LAIgOLY4SEtWP7HxsSZOkf6EtNKxNlj8ehC75eyxyFBPqCyVrJ3o1psF+2qZsZPQGiHP
         eAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gj0f+g6Nl3MHCIF1zHqXaLIJ4ZP9uKspx8+x3phHaDI=;
        b=BJjwCDOIg4kDr/YO0afdvmB1al7NOaQKnHCWhktpEtvH/5xmkclzPyWm/caUR76/52
         3djvZ1iuGwCTXNc1Jvzexy6p44ojFA8ZxCBKxw2u7I3ozYJQoURqQTd/wpC1XiQTzIyn
         AK0KmkMdEMJZY2dT0KI95Wi4icK0LsEUZPdfGmAw7goXyus4JYZFyuVS3G0vma1DIp1h
         7kjCZ6LyspnAK3QJCNCq0fJ035m1v4z1xZ/SS6NlP0O3ITbNcL1N1Io8pPHTBNXTRLyH
         pbuI6NOBz3Ih8HYMNENXi/BTS8rPFzlekOyinNCCJlAe+YkZzbM45KeZNJi1V/RnaGnp
         IkkA==
X-Gm-Message-State: APjAAAUpPZSK5cmDwTeHJapQlQCC4ESd9whANPnuAyt9yXmuRti3giHX
        dIA3Loc6TwJHUpGLgQ8oCMayNQ==
X-Google-Smtp-Source: APXvYqxcbdGrs49yUZ65WEZv/bVZAMzVQLWuPurpojm7lHTXPvitfIISl9T+EoDyhLtLzQBpn6MD0Q==
X-Received: by 2002:a1c:808c:: with SMTP id b134mr10926591wmd.16.1555075792876;
        Fri, 12 Apr 2019 06:29:52 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v184sm15752915wma.6.2019.04.12.06.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:29:52 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 2/5] tools: bpftool: reset errno for "bpftool cgroup tree"
Date:   Fri, 12 Apr 2019 14:29:35 +0100
Message-Id: <20190412132938.9044-3-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412132938.9044-1-quentin.monnet@netronome.com>
References: <20190412132938.9044-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When trying to dump the tree of all cgroups under a given root node,
bpftool attempts to query programs of all available attach types. Some
of those attach types do not support queries, therefore several of the
calls are actually expected to fail.

Those calls set errno to EINVAL, which has no consequence for dumping
the rest of the tree. It does have consequences however if errno is
inspected at a later time. For example, bpftool batch mode relies on
errno to determine whether a command has succeeded, and whether it
should carry on with the next command. Setting errno to EINVAL when
everything worked as expected would therefore make such command fail:

        # echo 'cgroup tree \n net show' | \
                bpftool batch file -

To improve this, reset errno when its value is EINVAL after attempting
to show programs for all existing attach types in do_show_tree_fn().

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/cgroup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 4b5c8da2a7c0..a81b34343eb8 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -248,6 +248,13 @@ static int do_show_tree_fn(const char *fpath, const struct stat *sb,
 	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++)
 		show_attached_bpf_progs(cgroup_fd, type, ftw->level);
 
+	if (errno == EINVAL)
+		/* Last attach type does not support query.
+		 * Do not report an error for this, especially because batch
+		 * mode would stop processing commands.
+		 */
+		errno = 0;
+
 	if (json_output) {
 		jsonw_end_array(json_wtr);
 		jsonw_end_object(json_wtr);
-- 
2.17.1

