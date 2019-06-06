Return-Path: <SRS0=vsg3=UF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E94C04AB5
	for <bpf@archiver.kernel.org>; Thu,  6 Jun 2019 07:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F218D20872
	for <bpf@archiver.kernel.org>; Thu,  6 Jun 2019 07:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJ/XAoNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfFFH4x (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:56:53 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40452 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfFFH4x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 03:56:53 -0400
Received: by mail-yw1-f66.google.com with SMTP id b143so510861ywb.7
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9i+39qzlLlaj4ZIJyuysO0V74pT4jxs4rHh5xzjVecc=;
        b=pJ/XAoNin++ppwq0Yryx58yYTvqaZaQj8So8vITNx5j6Ty5ySAWqIr36sESXSFmaR8
         9HomApkEVr1IiR6M4JnOxf4jg7D3RXcLWx0RgOKLxj0C/TA1UXqAq7i1S7bWi6bVY+Uq
         9/nZJtNx9DaywajZ/iowMTY7S0YAJ7AfcOAFxET8HWmzQxO2UT7I8H2scnQojIHiELvA
         Xk3CwGnga560N3HRVcVF/JkEIA5SY/HjaWWvmIvVSQRZprabi//HTGKoOvsdFIiwtFCa
         P8qiEP0zgewtJW0XMD891BgK1PL82mlWRyb8cy0BcXqubHqc1dSM2oAR31pY3r2y6THY
         AL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9i+39qzlLlaj4ZIJyuysO0V74pT4jxs4rHh5xzjVecc=;
        b=JYGD2vXnJiKMY0htNRfE4FaShTIT1KaLBD6bcBuAFYbadQYQdtxJ7IpU7nLJ9A0y12
         qMoJlQ1FdlPnWUIx0V97JK5YpYS+YxrVWsy2xTnir7wcUP/ZIXbJoBJ5poft+KchByrB
         0mrGhmUjcLU/sunNK9+TZ1aliBm1ZT+0CxfZb3T54WIiV2ChNf8MdvIQ/qXsVbe9iIYQ
         xMe+m1WYe6U27tqXEYLcKa/dpOFl2gwo3q+EKcdqOt7jkhNP+dZkDOl0cc2Kzi7fXgdL
         K/bh0KJr5GIr1nFh8DrMyb84atkgd6UWRU42naygfNoX3iB07Mr1EuJ32XBBhtz+bzvD
         EGRA==
X-Gm-Message-State: APjAAAXJs5s6UNat957QawFb9N8+SDxuPZl/WpeXnh2dtqpp+E+VFYGY
        vsSKgUMI7CjVqeAM6pFuSn1aDA==
X-Google-Smtp-Source: APXvYqzBoIij+GY609wSEIttcFA3t55zCx1DUNATNXk8Jbe9N2y6y9kv5BsG96+2mq9PAiF/I6Wf1g==
X-Received: by 2002:a81:2981:: with SMTP id p123mr10051401ywp.430.1559807812812;
        Thu, 06 Jun 2019 00:56:52 -0700 (PDT)
Received: from localhost.localdomain (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id 14sm316343yws.16.2019.06.06.00.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 00:56:52 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/4] perf augmented_raw_syscalls: Remove duplicate macros
Date:   Thu,  6 Jun 2019 15:56:15 +0800
Message-Id: <20190606075617.14327-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606075617.14327-1-leo.yan@linaro.org>
References: <20190606075617.14327-1-leo.yan@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The macro SYS_EXECVE has been defined twice, remove the duplicate one.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 68a3d61752ce..5c4a4e715ae6 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -90,7 +90,6 @@ struct augmented_filename {
 /* syscalls where the second arg is a string */
 
 #define SYS_PWRITE64            18
-#define SYS_EXECVE              59
 #define SYS_RENAME              82
 #define SYS_QUOTACTL           179
 #define SYS_FSETXATTR          190
-- 
2.17.1

