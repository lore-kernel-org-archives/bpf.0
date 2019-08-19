Return-Path: <SRS0=Vw9o=WP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F0C3A5A0
	for <bpf@archiver.kernel.org>; Mon, 19 Aug 2019 19:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1552D22CEB
	for <bpf@archiver.kernel.org>; Mon, 19 Aug 2019 19:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDZutR5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfHSTR4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:17:56 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:36797 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbfHSTR4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Aug 2019 15:17:56 -0400
Received: by mail-ua1-f74.google.com with SMTP id r11so468713uao.3
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2019 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WY76z6d6LzfXIWyRVMRCt1MQ9lLGs/hOrzblL370r2g=;
        b=KDZutR5ru85AygNjM3Epaoooty3iJqSOQCCIBMIvBpmArOd+IeImQBb4ZFE69BtEw+
         d1VTRi1rbsxb8QBXSfb5M5QWanqMfV/DlAz0K7U7n6c64NBLrT4yIbjPNjQSHDbafYjm
         5pawekj28Kbfu62mi7eJfqa4jrtFTPJ7AZq+JWv014xQurP7mWvhKNiHLK+4EdoD2Hxg
         PT7GAd3kqnTE9h4HZch3K9efbbB1Vwj0I5alr6p7wibDwYz4S4NsizPLeh1ILDuKSpxa
         F+CCKZiO6oc9NDszNvWMhEI8OiNnx3sl6OaOxYEYnnmpu5PPYXYakKw02FFe7UqZBjvu
         740Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WY76z6d6LzfXIWyRVMRCt1MQ9lLGs/hOrzblL370r2g=;
        b=ik0yhpBTAMvkuSEVlfG4MZeud7w7bi6e2Cn/8ydZ02bPWregw9Pyq/l5f83d+Dnru6
         zJ+jetWnuqKAO0BOT0jU6EOGLt+EKp+dGX2pH80EAeb9oQUWb73yncH8ISyWce70iqGE
         9rm1DlPcNRl+bZV6Fo2E0vJW/tHtSVNq3kZ3ZUdQdTtmBnuAFzeRYQDDAyEBQ+MOhE6X
         tWFTg5EunzA0JcsdZk1+hGmpi1sl/au8Bn1PQ2crHYkv8h1QxWphi1UQqQ7K3J7szXsj
         FHk79vwSLqxksNmkkFr/zgXc1iH6SbBfcfvziUHq3cVHbGOh19xfATMl9pEWZUGivdFj
         UWBA==
X-Gm-Message-State: APjAAAUy2PQCJpRVah9AMi/Qm7bIB0fpxYJX52reFYHp2SyCz+VoZxz1
        wQUTFuCe4tr+WydTybuloLMhZB8=
X-Google-Smtp-Source: APXvYqwbkPus3Yyw3D5MKkF13ZrsV4mF5TIlsBZC5AK093kJuSzqMnosy2SCysS96WXjwDK5EQj3z5M=
X-Received: by 2002:a1f:dec7:: with SMTP id v190mr8901238vkg.39.1566242274749;
 Mon, 19 Aug 2019 12:17:54 -0700 (PDT)
Date:   Mon, 19 Aug 2019 12:17:48 -0700
Message-Id: <20190819191752.241637-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH bpf-next v2 0/4] selftests/bpf: test_progs: misc fixes
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

* add test__skip to indicate skipped tests
* remove global success/error counts (use environment)
* remove asserts from the tests
* remove unused ret from send_signal test

v2:
* drop patch that changes output to keep consistent with test_verifier
  (Alexei Starovoitov)
* QCHECK instead of test__fail (Andrii Nakryiko)
* test__skip count number of subtests (Andrii Nakryiko)

Cc: Andrii Nakryiko <andriin@fb.com>

Stanislav Fomichev (4):
  selftests/bpf: test_progs: test__skip
  selftests/bpf: test_progs: remove global fail/success counts
  selftests/bpf: test_progs: remove asserts from subtests
  selftests/bpf: test_progs: remove unused ret

 .../selftests/bpf/prog_tests/bpf_obj_id.c     | 20 +++++----
 .../bpf/prog_tests/bpf_verif_scale.c          |  9 +---
 .../selftests/bpf/prog_tests/flow_dissector.c |  4 +-
 .../bpf/prog_tests/get_stack_raw_tp.c         |  3 --
 .../selftests/bpf/prog_tests/global_data.c    | 20 +++------
 .../selftests/bpf/prog_tests/l4lb_all.c       |  8 +---
 .../selftests/bpf/prog_tests/map_lock.c       | 37 ++++++++--------
 .../selftests/bpf/prog_tests/pkt_access.c     |  4 +-
 .../selftests/bpf/prog_tests/pkt_md_access.c  |  4 +-
 .../bpf/prog_tests/queue_stack_map.c          |  8 +---
 .../bpf/prog_tests/reference_tracking.c       |  4 +-
 .../selftests/bpf/prog_tests/send_signal.c    | 43 +++++++++----------
 .../selftests/bpf/prog_tests/spinlock.c       | 16 +++----
 .../bpf/prog_tests/stacktrace_build_id.c      |  7 +--
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  |  7 +--
 .../selftests/bpf/prog_tests/stacktrace_map.c | 17 +++-----
 .../bpf/prog_tests/stacktrace_map_raw_tp.c    |  9 ++--
 .../bpf/prog_tests/task_fd_query_rawtp.c      |  3 --
 .../bpf/prog_tests/task_fd_query_tp.c         |  5 ---
 .../selftests/bpf/prog_tests/tcp_estats.c     |  4 +-
 tools/testing/selftests/bpf/prog_tests/xdp.c  |  4 +-
 .../bpf/prog_tests/xdp_adjust_tail.c          |  4 +-
 .../selftests/bpf/prog_tests/xdp_noinline.c   |  7 +--
 tools/testing/selftests/bpf/test_progs.c      | 41 ++++++++++++------
 tools/testing/selftests/bpf/test_progs.h      | 19 +++++---
 25 files changed, 135 insertions(+), 172 deletions(-)

-- 
2.23.0.rc1.153.gdeed80330f-goog
