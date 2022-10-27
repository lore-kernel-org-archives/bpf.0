Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98724FA3742
	for <bpf@archiver.kernel.org>; Thu, 27 Oct 2022 11:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiJ0LlV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Oct 2022 07:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiJ0LlU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 07:41:20 -0400
X-Greylist: delayed 242 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Oct 2022 04:41:19 PDT
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95196CD2E;
        Thu, 27 Oct 2022 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1666870876;
        bh=kq2dkLdtlAFSXtPcRBGcoOgLscYYb762vapxdZuQxtY=;
        h=From:To:Cc:Subject:Date;
        b=C4dzwzBj2PhL7Uf5vehDltmOxapHBzlFV8o/EDjAXbrHmxvXktRz8vL0Fe9QkcUFl
         K0zM3nTLk6B/WjqZVbdUpAG8/Je1mLngopGLi73n2GfDiq5BCBIuTai7tcgeCRkGLT
         5lkSP7UClzM5sC77mjXSKof0DiHe5o16VM+5H+5w=
Received: from localhost.localdomain ([2408:8406:7921:e168:31:95d9:81c3:8f7a])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 873AA247; Thu, 27 Oct 2022 19:33:51 +0800
X-QQ-mid: xmsmtpt1666870431tz61axw4g
Message-ID: <tencent_EE3E19F80ACD66955D26A878BC768CFA210A@qq.com>
X-QQ-XMAILINFO: M7uElAZZZMmFu5KDsmeZ/hj057vsdXmD9fbgbJsbI3L+ZJAKzeY6635AhyTWCr
         wEWttLcQ5MnRQGTlFR+XfvpCjETgBctsPVgaKiJqlagYt3ex61y7p5GXLTexiKyv7MdsdpF80Wfp
         jtr97YlABnP0c3MgB6SlNr4G5/kdyMeXXVbeM9MwEngaCCH9sm9KJGNQ49aRbVmfxhkteXY1+qWC
         Rqa8YoL4U2MJKsj6cVRIHUz1yHdXxIlsixPptxJOSf1AIn+18qfftN/YKw0Nv53pLQdU94xRCASd
         JLq9k7YqXaf/RtS6DWpgtc+CNuKLA96Yu47t9nPgsJDjV+O3aEYPRfaILly+n+mlAuHCf3knPkbM
         u6XYR9x9SOigUTIxt0zS3vcJa2TqO3CfwWQGRztFeI6Ar4batnN/auU/8c1TflJQ47L9tNV+sqw5
         2ZiSX3pkTF+pKGVJN2vrdYjjwEpIKuH/YZ+bNT9VXOGLb7JFDUzTftKY+T8+EB/Wzbr6gkTcAr+U
         ZlS+JH22M6Gp/OsPBpPg35hZmQ9izNKGZ/v7z6uMJoaLj8E1Gs8Z53V8ntJE4NZFZvVCuWxaBNYi
         3SRboncW0r6IBW6egthE2iQp1G9iinZSj5qINyOSHxOZprwhDDScOUzBzaQX78e5Tu5YK3YP+5LB
         uGkIbGGV5UROnwUQ3w9zzPPSVqhpk+gjQkfyaOUeGz7p/feD6h+ni2Mxh445aMCWPaugoGykIJzP
         6CBUOnlXDO7lFeLYzrfhf8xdDx6g5HghkAeXzEeCxNBl0PJPjaCkDWxa7cPm8dbpcE4Nj0F2WdCM
         eY4KuSbqr5W24h06bRNyzbYjg9zTPEfPmZ+UsLhRoWBdgQ2/bjnvfj4iBGbsSexksGf2QQaIrdmZ
         TeyoN5a3zj3QhmH2/qQWCtBNkFyeWXDVn2CFevj61noj62ScnhS6VCkz8bFoNNoAXLIh4vaIZuRo
         5kslU9Yu1Q4pzWUzC6WYKF3+RErSk6
From:   Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] selftests/bpf: Fix strncpy() fortify warning
Date:   Thu, 27 Oct 2022 19:33:50 +0800
X-OQ-MSGID: <20221027113350.40173-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Compile samples/bpf, error:
$ cd samples/bpf
$ make
...
In function ‘__enable_controllers’:
samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c:80:17: warning: ‘strncpy’ specified bound 4097 equals destination size [-Wstringop-truncation]
   80 |                 strncpy(enable, controllers, sizeof(enable));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index e914cc45b766..a70e873b267e 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -77,7 +77,7 @@ static int __enable_controllers(const char *cgroup_path, const char *controllers
 		enable[len] = 0;
 		close(fd);
 	} else {
-		strncpy(enable, controllers, sizeof(enable));
+		strncpy(enable, controllers, sizeof(enable) - 1);
 	}
 
 	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
-- 
2.31.1

