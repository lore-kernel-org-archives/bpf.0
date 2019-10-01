Return-Path: <SRS0=bsNo=X2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DC6C352AA
	for <bpf@archiver.kernel.org>; Tue,  1 Oct 2019 17:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D224E2053B
	for <bpf@archiver.kernel.org>; Tue,  1 Oct 2019 17:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R43ESF1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfJARh6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:37:58 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50541 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731273AbfJARh6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Oct 2019 13:37:58 -0400
Received: by mail-pf1-f201.google.com with SMTP id q127so10761905pfc.17
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2019 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wk/kSRiVr2+hsdRYwtEFf1vJ/Djbn8eKotL+Cap8me8=;
        b=R43ESF1qMXL4EzulkwPKBST9Dj9BWXUYzOA79YIBN3gl1tGYXc1vwhGctIq6E00cZs
         0/UjG2x1/oKDfi/3K/19NhvRkp+8lpVt4QD0EcW517r04E6T7md9G8OFfYeCb54cqRWW
         hFzCDuhmXbM62ySyLJzRaOr8xImhDdNMYqte9P8E99uDPTcvk6k5/o8SMaET/DQYIhiC
         XBqvzzqPoNyK4Qj5QBDw8DtSrRxTw1H6QgF/Iotstr3P/bwVSwEGLYWQC1svmAanmuSl
         Q08tr61T61IwMcGoYYyaD9N3u7i2s7GkmserM6YQ7yqFmj1awCGslVtUNUWbgxD3gDC2
         hRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wk/kSRiVr2+hsdRYwtEFf1vJ/Djbn8eKotL+Cap8me8=;
        b=BwN/AqZ9ebyuspCYCDD28R/UdmqXsRtLuFL6KH2vYKdbhobFtsQGRPti3QHudkskn9
         czAuyxjGZwYTttgrkUJnu3vNF2f4m8Ks+0pUfjrreJFsqCXcXcxh9RwFgnvYxJC8AlBX
         uNPYO2p4rpxd4YWQD5e9y0dkivVrNkgGQS30udsy7/hEk2M41fK2M283IdZS3O4OtNOR
         aK9XOcAqhX5mbAjhrDNfrRghfdDDQCK1jQP9k/LUy4vAXGxvLwy4SaES7yNH/twmOiX5
         Qm9qBaCktbLo64n0cQmGUtYVqf4fpO3o8x2hPUVvA66/ZJEwkWPQ3kkvZZtebqjvA+Fo
         +rlg==
X-Gm-Message-State: APjAAAUD9tNeUyjVLppTAOGlSUwunppbwnPh9dFFCAmsYgriFrNf+jrV
        sVSUSvqKSG/BvLmlFxn5MaJVW78RYYXK
X-Google-Smtp-Source: APXvYqypaHVZ+jWEwbZaptMaWnugEpNBCtzVp1uSABDkv7TEphW8RK4IYnhKiUDvh2qs9s1LSN74jWoUUaM1
X-Received: by 2002:a65:6252:: with SMTP id q18mr32002268pgv.111.1569951475681;
 Tue, 01 Oct 2019 10:37:55 -0700 (PDT)
Date:   Tue,  1 Oct 2019 10:37:28 -0700
In-Reply-To: <20191001173728.149786-1-brianvv@google.com>
Message-Id: <20191001173728.149786-3-brianvv@google.com>
Mime-Version: 1.0
References: <20191001173728.149786-1-brianvv@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH bpf 2/2] selftests/bpf: test_progs: don't leak server_fd in test_sockopt_inherit
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

server_fd needs to be close if pthread can't be created.

Fixes: e3e02e1d9c24 ("selftests/bpf: test_progs: convert test_sockopt_inherit")
Cc: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 6cbeea7b4bf16..8547ecbdc61ff 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -195,7 +195,7 @@ static void run_test(int cgroup_fd)
 
 	if (CHECK_FAIL(pthread_create(&tid, NULL, server_thread,
 				      (void *)&server_fd)))
-		goto close_bpf_object;
+		goto close_server_fd;
 
 	pthread_mutex_lock(&server_started_mtx);
 	pthread_cond_wait(&server_started, &server_started_mtx);
-- 
2.23.0.444.g18eeb5a265-goog

