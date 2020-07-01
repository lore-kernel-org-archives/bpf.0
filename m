Return-Path: <SRS0=pDiR=AM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C555C433E0
	for <bpf@archiver.kernel.org>; Wed,  1 Jul 2020 20:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FABB2082F
	for <bpf@archiver.kernel.org>; Wed,  1 Jul 2020 20:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPFcwwz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgGAUNP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgGAUNO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 16:13:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6952C08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 13:13:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z7so27444257ybz.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KeQTrd37BEFhJhhFg8eLib2y6OHrwfUDJnin6VhVDDE=;
        b=XPFcwwz+IN0GhlhFtLkS54T/AZox3vukZ/EUvPT/i0rbNqsZm+7ptZp6276Y0MIU7+
         zC7FNTBq8N7L4wY4fDKZ60+fAhTJGJQyvfPCVmzo1IKbh2DmWhuzvzsvft0La448sT6H
         yZWPG3KepMC7HMIor0MvX7mDyp8mIwsUSuwe1FvaSQP15JJ9SZMYAER72sVUUF+4X7AJ
         N0vEvGbIyoI3ZsstYS6khx6KqC+dInvaT4ppZws44O2ZjIYseM8SVQThZv4BV/mmqxdH
         qNuZ8VYr1we2UkHAO2V6xvapYhgcm49pQMDJnRMNjRBDYnk4Cl2rZWMxup4LwwUEyAG6
         M4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KeQTrd37BEFhJhhFg8eLib2y6OHrwfUDJnin6VhVDDE=;
        b=dCDYth5UBCEp0CCgEYYmRMRCXzxnEwdlKZ6mgkEaO35LBvhgRI/5QOtA61x5qXjpDV
         ALmz2QVcoHXp/G0WpIyX4SnPBuhNG+KNTvUX6XRqTTlPVfK8wu32iZcEl73V/WMeSdz1
         FCM3KOPAy9exMm2/837zYuy6TNZwKi4+XrUAd7I7VrUdeNIOk9vweLoPU0WYwvbr/Eu+
         cBAiwXbWuYetzKXUC3q833Pr2d20rue31T/l8z923PYRN/WnRtYdpDV9hCzDGeGVo8kh
         hVj8OVFvwG8JuWnAYzHLbo7OB4F1tsD/PM5x72VUGkvkOe2p1BGEpKkLP26XxutGV+ox
         Rzfg==
X-Gm-Message-State: AOAM533Vl/K170xzEEqeIkj1bVcKCfUG/n/iWtmrUslkA9jqk8mA8Lrc
        CI3OqzmrMQq0q1dSWN06PNcpHis=
X-Google-Smtp-Source: ABdhPJxz3YBEHyQoZOW9dyvNhF7Y+L81FC/JAfShrbT3eSsWT6KVByCnW9l5xQYbw0o6jDJ6VV/EmKk=
X-Received: by 2002:a25:3f87:: with SMTP id m129mr47200320yba.371.1593634392985;
 Wed, 01 Jul 2020 13:13:12 -0700 (PDT)
Date:   Wed,  1 Jul 2020 13:13:05 -0700
In-Reply-To: <20200701201307.855717-1-sdf@google.com>
Message-Id: <20200701201307.855717-3-sdf@google.com>
Mime-Version: 1.0
References: <20200701201307.855717-1-sdf@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH bpf-next v3 2/4] libbpf: add support for BPF_CGROUP_INET_SOCK_RELEASE
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add auto-detection for the cgroup/sock_release programs.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/include/uapi/linux/bpf.h | 1 +
 tools/lib/bpf/libbpf.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index da9bf35a26f8..548a749aebb3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -226,6 +226,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_INET4_GETSOCKNAME,
 	BPF_CGROUP_INET6_GETSOCKNAME,
 	BPF_XDP_DEVMAP,
+	BPF_CGROUP_INET_SOCK_RELEASE,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4ea7f4f1a691..88a483627a2b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6917,6 +6917,10 @@ static const struct bpf_sec_def section_defs[] = {
 	BPF_APROG_SEC("cgroup_skb/egress",	BPF_PROG_TYPE_CGROUP_SKB,
 						BPF_CGROUP_INET_EGRESS),
 	BPF_APROG_COMPAT("cgroup/skb",		BPF_PROG_TYPE_CGROUP_SKB),
+	BPF_EAPROG_SEC("cgroup/sock_create",	BPF_PROG_TYPE_CGROUP_SOCK,
+						BPF_CGROUP_INET_SOCK_CREATE),
+	BPF_EAPROG_SEC("cgroup/sock_release",	BPF_PROG_TYPE_CGROUP_SOCK,
+						BPF_CGROUP_INET_SOCK_RELEASE),
 	BPF_APROG_SEC("cgroup/sock",		BPF_PROG_TYPE_CGROUP_SOCK,
 						BPF_CGROUP_INET_SOCK_CREATE),
 	BPF_EAPROG_SEC("cgroup/post_bind4",	BPF_PROG_TYPE_CGROUP_SOCK,
-- 
2.27.0.212.ge8ba1cc988-goog

