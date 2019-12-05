Return-Path: <SRS0=13Dn=Z3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D1FC43603
	for <bpf@archiver.kernel.org>; Thu,  5 Dec 2019 08:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B082464E
	for <bpf@archiver.kernel.org>; Thu,  5 Dec 2019 08:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPwfJcRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfLEIBX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:01:23 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:39722 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfLEIBX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Dec 2019 03:01:23 -0500
Received: by mail-pj1-f42.google.com with SMTP id v93so968229pjb.6;
        Thu, 05 Dec 2019 00:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOUoKHbS1u9GIqS8UItvwKhjwVm+XnN17eY9A2NQhRA=;
        b=EPwfJcRxvnV6Jk2eHz9MkNyxDHyFvZdET8hSzE0CBd9KvYnA0EvNl8NZ3WE9+cKLje
         XoI+ppqogTLoCSPWUcsGmPoqJRS6wNjEoKbtOKn94DjNGALjArXfBsHO9Zsp3IejZD3u
         pVOAL95ZNpEBfElSwzmvKmBNyleLETL0v0A0CEf+mWDCbtWJSe3UqWtggqqGTgfqXHFl
         6Xo/UMzikZbWjKkFryKXwfjIz0l7ZUv3IRWaxKVqBWbEiRRyy37TnudUMgpPjDc0DCWk
         AL+UsAwa+JaAMOH2Neu1e9NcXvgLvE5e4BbHhKGOmGXE1ADKiS9iEYfBEoOXzHhX7hMf
         xwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOUoKHbS1u9GIqS8UItvwKhjwVm+XnN17eY9A2NQhRA=;
        b=TWFoS+Zsa22dYg3cOZQb3NtSqtBeEfsdwI8iuK/6evUPwmI0JcuVi8ye71/LS77Bgk
         CvrSSgMdJjxOqe1mRFqB6XLoRwkhhFR1WJnWk5U3WUThgdBmc6sI5BynjyvHuWKi5Z5F
         gQoIf/LIxcF+2YpXbjeDUFFkaumYbksmgT5PGFjBBYKDEnNwr/TuqmaA5DrO2pEWPvaX
         upjei2kTmpfqRxlZxK6z+UORJdHxKIY51qPiSUfhIJCQMi1U0QwzQw/mYkV7fmjFAHBV
         L0KSRXUxGzVM23oQfHhFOx/9fT0N1O1xAlrGG0e/VE1bAJCTCDR1Age0K2d0PROXTG6I
         JG8g==
X-Gm-Message-State: APjAAAUxVoaAICZoVIyPh6ELRXl/s2W2dzxyPSiApUIuSRQrH8UfzOPC
        v5CPdn+zRjEgLlbhO3KlUw==
X-Google-Smtp-Source: APXvYqw9IvPGpaEuBszneItFaPtRHTBiFnea3oOQcfUlfxJ6no8XOOJkO8NrqPCiuJYN1Ih7H9K9jQ==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr7726970plk.284.1575532882216;
        Thu, 05 Dec 2019 00:01:22 -0800 (PST)
Received: from localhost.localdomain ([114.71.48.24])
        by smtp.gmail.com with ESMTPSA id 129sm11510739pfw.71.2019.12.05.00.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 00:01:21 -0800 (PST)
From:   "Daniel T. Lee" <danieltimlee@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH,bpf-next v2 0/2] Fix broken samples due to symbol mismatch
Date:   Thu,  5 Dec 2019 17:01:12 +0900
Message-Id: <20191205080114.19766-1-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, there are broken samples due to symbol mismatch (missing or
unused symbols). For example, the function open() calls the syscall 
'sys_openat' instead of 'sys_open'. And there are no exact symbols such
as 'sys_read' or 'sys_write' under kallsyms, instead the symbols have
prefixes. And these error leads to broke of samples.

This Patchset fixes the problem by changing the symbol match.

Changes in v2:
 - remove redundant casting 

Daniel T. Lee (2):
  samples: bpf: replace symbol compare of trace_event
  samples: bpf: fix syscall_tp due to unused syscall

 samples/bpf/syscall_tp_kern.c  | 18 ++++++++++++++++--
 samples/bpf/trace_event_user.c |  4 ++--
 2 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.24.0

