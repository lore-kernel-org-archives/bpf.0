Return-Path: <SRS0=Gc+U=US=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6DEC31E5B
	for <bpf@archiver.kernel.org>; Wed, 19 Jun 2019 17:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938B921855
	for <bpf@archiver.kernel.org>; Wed, 19 Jun 2019 17:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NR+Tcsvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfFSRAL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:00:11 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:48958 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSRAK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jun 2019 13:00:10 -0400
Received: by mail-ua1-f73.google.com with SMTP id s14so6549uap.15
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2019 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aMAVJjYPVW0LDE+1k3jh4sYPHN+8Kpd0vTrAOfnc5og=;
        b=NR+Tcsvnd6raptmD17C9IZB8amlVB0DPEfby19huupj8AUMzsHZm3WAhHwDreER/Ef
         5FeD6Eax30cL56UP0gO2KMSpJwQsSSNHtf2+/Lovq6KYoVj+hcTcnLpApEmpJbeVqqGr
         7FGdHzOZBhruYDtq5gO787VtGNv4MsktdvpWekmn1D4Drklh76K5cXA477GJVAFUwERf
         l4IFvyvdMZ31yZGvbPlzF9Chx3yvgySf0+/ivVejonznnu17Xm2b11S6PAAHD+RmAGMI
         lGjILseuzZWkWPbEFFa3NGGoSr3jkLTYHVCGheQjvOrRUyPEdXDgY5V7WIK8y4H6aK44
         i8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aMAVJjYPVW0LDE+1k3jh4sYPHN+8Kpd0vTrAOfnc5og=;
        b=ICn0HMZxpggSEh3iswEquNqDv5Aw6j6TpKfAT5KFX4+ICb9cgonGlvex/7G9oCBzAq
         G5H9FsUrpSmMsOfsUlfV/OBri34Oe43j1iC2eaIWULiT/q4yh514RDKUDa5lt2k/i4+L
         k59c1EqSwftIaIw5Ntzv1YUgSQtbZNgKCXutDDrsElwYLufy64Gam/RzZd3p3rJfV2DR
         AcvxFBDoCl/lTztxzCGvPzIyDQzjlF4+Lv7fUhoiN3IIMHMXDEXD6nibaDan+THHQ9Qn
         E4wH+jNxJ32cc8E5+tnvtv8bYPk/qOelPyFeqfJi7cOMkKmTz8Ll6jf056qF08DbxvHI
         8+FA==
X-Gm-Message-State: APjAAAXgER+/PcOH23TsD7sq3f8CeMW69kAEmTpKheMQ8usKMbcrRw0/
        nkFfM+5TFb21OU6uDo9qHnmr/Po=
X-Google-Smtp-Source: APXvYqwJlS5Tix4as0unV4lH0IF/ZTiXuJllbLdGgY5TOCXXD38551JMEKYFmc02vbYrmI9LWhtgK5w=
X-Received: by 2002:ab0:4108:: with SMTP id j8mr10028578uad.104.1560963609775;
 Wed, 19 Jun 2019 10:00:09 -0700 (PDT)
Date:   Wed, 19 Jun 2019 09:59:52 -0700
In-Reply-To: <20190619165957.235580-1-sdf@google.com>
Message-Id: <20190619165957.235580-5-sdf@google.com>
Mime-Version: 1.0
References: <20190619165957.235580-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v7 4/9] selftests/bpf: test sockopt section name
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests that make sure libbpf section detection works.

Cc: Martin Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_section_names.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_section_names.c b/tools/testing/selftests/bpf/test_section_names.c
index bebd4fbca1f4..5f84b3b8c90b 100644
--- a/tools/testing/selftests/bpf/test_section_names.c
+++ b/tools/testing/selftests/bpf/test_section_names.c
@@ -124,6 +124,16 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SYSCTL, BPF_CGROUP_SYSCTL},
 		{0, BPF_CGROUP_SYSCTL},
 	},
+	{
+		"cgroup/getsockopt",
+		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT},
+		{0, BPF_CGROUP_GETSOCKOPT},
+	},
+	{
+		"cgroup/setsockopt",
+		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
+		{0, BPF_CGROUP_SETSOCKOPT},
+	},
 };
 
 static int test_prog_type_by_name(const struct sec_name_test *test)
-- 
2.22.0.410.gd8fdbe21b5-goog

