Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F321BCCA485
	for <bpf@archiver.kernel.org>; Fri, 22 Jul 2022 02:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiGVCNX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Jul 2022 22:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiGVCNV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 22:13:21 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF697498
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 19:13:20 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 66-20020a630645000000b0041a63d6c638so1677262pgg.2
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DhjjSNuficgbRYAqqQ0W8XZGDABdrTHUp2H4nxtLaug=;
        b=PI4AMB4vSbp0OIWCtIi99l5y4UFdCqR/ok0FBs166w/hgCwQvkncSijD7lGvRoGySS
         Ua+FnMCqGvIRXN2qe0qH77bKrmYhFAwB5e6L+hNKsACMXnx+MLuG6goCLrTFH/hCi3Pl
         QHMcf1tqWKZKns+LlKiQ9RodcMfMMI5jeZmU4Sv4uRY3wo8nJnqQubNwUPaJLeqve4w0
         18WyJP6Wa1gNf02gbU0YwudKDR8P47mc6mIu2MjlZoyN6nr/mHEZFIYgVUiXCTFQY+5Q
         PSF8Ximzmamk1QeoF2Wacsv93SLBXFR/+gXPNly8OgWAOCz3BLuAMNV6K0Rvv1ycTXz8
         fIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DhjjSNuficgbRYAqqQ0W8XZGDABdrTHUp2H4nxtLaug=;
        b=5yvW7fJnR0zLgTEMhg3t31wVcmF7Zv1alWaB1JE0cv0HujOb3Y93f6fN4bjNI6ErT9
         Xl3eUHF1dJIVaAS6i7eVWSUmVGBq0FtmHboMt4XVOSPn03hMOJthAj4WDKRz4BDCsN6P
         THJRBsVSDqDAgV5nqZ2SvjMjC38sCooZKCGpfEqRSDG6K3KjCqfWz0Oiink0kzQi3P43
         AK0X7LbG9pFkaD0iTqJka+zdQ2EsLvLwpgetERcVotMlwZh2K089ApMxMWyBzjb+yzOn
         GRT0KuyMXyXAGZ1rEQu8hkrh0CT55HuG1g1fyq6Jj7sJYzJ9HTv2dqyGrJbEeFlUbbMl
         ufVQ==
X-Gm-Message-State: AJIora8XZG/NtphTm53UWWovRYYXY5q+FLAXEK0TJlDvGwuNiMjqpLGj
        ewSEdT2W6Y5CRhHjNqC7zUT5//r8uDlFTQVx
X-Google-Smtp-Source: AGRyM1sxVbhJAl0O1lOjA9XaioVuQButGgTNpgtk+la7oca/XTSvlK2lHRWIXeRdai+FgRh0VzQIg3+/kc0LFxFH
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:10e:b0:1f1:f3b0:9304 with SMTP
 id p14-20020a17090b010e00b001f1f3b09304mr837705pjz.1.1658455999390; Thu, 21
 Jul 2022 19:13:19 -0700 (PDT)
Date:   Fri, 22 Jul 2022 02:13:07 +0000
In-Reply-To: <20220722021313.3150035-1-yosryahmed@google.com>
Message-Id: <20220722021313.3150035-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220722021313.3150035-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH bpf-next v4 2/8] cgroup: enable cgroup_get_from_file() on cgroup1
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cgroup_get_from_file() currently fails with -EBADF if called on cgroup
v1. However, the current implementation works on cgroup v1 as well, so
the restriction is unnecessary.

This enabled cgroup_get_from_fd() to work on cgroup v1, which would be
the only thing stopping bpf cgroup_iter from supporting cgroup v1.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/cgroup/cgroup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccddb734..9943fcb1e574 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6090,11 +6090,6 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
 		return ERR_CAST(css);
 
 	cgrp = css->cgroup;
-	if (!cgroup_on_dfl(cgrp)) {
-		cgroup_put(cgrp);
-		return ERR_PTR(-EBADF);
-	}
-
 	return cgrp;
 }
 
-- 
2.37.1.359.gd136c6c3e2-goog

