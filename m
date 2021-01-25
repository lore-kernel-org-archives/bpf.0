Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E586C433DB
	for <bpf@archiver.kernel.org>; Mon, 25 Jan 2021 07:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57B922581
	for <bpf@archiver.kernel.org>; Mon, 25 Jan 2021 07:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbhAYHMm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Jan 2021 02:12:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:35221 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbhAYGle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 01:41:34 -0500
IronPort-SDR: nPyJQ9qc9pPrOL4dnWEHeA3bKLVU9K9zbvr4s4A/V3FGDnMhJYv8+HKLAgoJxJxGq19y49wRxn
 86x36vyYSr4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="179751939"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="179751939"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 22:39:47 -0800
IronPort-SDR: x1pQtgl3vcIHAqaNMGPNforbqej7B9oB3xCmQyOi3Cxrqt5aXqhbxSa/ieMbla22NotuJZShiL
 NCXbB8TkfwQQ==
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="429144312"
Received: from ymachlev-mobl1.ger.corp.intel.com (HELO outtakka.ger.corp.intel.com) ([10.214.244.152])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 22:39:44 -0800
From:   Mikko Ylinen <mikko.ylinen@linux.intel.com>
To:     kpsingh@kernel.org
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, kpsingh@google.com,
        linux-kernel@vger.kernel.org, mikko.ylinen@linux.intel.com
Subject: [PATCH v2] bpf: Drop disabled LSM hooks from the sleepable set
Date:   Mon, 25 Jan 2021 08:39:36 +0200
Message-Id: <20210125063936.89365-1-mikko.ylinen@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <CACYkzJ5i6DNxY3D3SqiO_LO2HBbA-EgPFdK8ZBcFNmTVWweucg@mail.gmail.com>
References: <CACYkzJ5i6DNxY3D3SqiO_LO2HBbA-EgPFdK8ZBcFNmTVWweucg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some networking and keys LSM hooks are conditionally enabled
and when building the new sleepable BPF LSM hooks with those
LSM hooks disabled, the following build error occurs:

BTFIDS  vmlinux
FAILED unresolved symbol bpf_lsm_socket_socketpair

To fix the error, conditionally add the relevant networking/keys
LSM hooks to the sleepable set.

Fixes: 423f16108c9d8 ("bpf: Augment the set of sleepable LSM hooks")
Signed-off-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
---
 kernel/bpf/bpf_lsm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 70e5e0b6d69d..1622a44d1617 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -149,7 +149,11 @@ BTF_ID(func, bpf_lsm_file_ioctl)
 BTF_ID(func, bpf_lsm_file_lock)
 BTF_ID(func, bpf_lsm_file_open)
 BTF_ID(func, bpf_lsm_file_receive)
+
+#ifdef CONFIG_SECURITY_NETWORK
 BTF_ID(func, bpf_lsm_inet_conn_established)
+#endif /* CONFIG_SECURITY_NETWORK */
+
 BTF_ID(func, bpf_lsm_inode_create)
 BTF_ID(func, bpf_lsm_inode_free_security)
 BTF_ID(func, bpf_lsm_inode_getattr)
@@ -166,7 +170,11 @@ BTF_ID(func, bpf_lsm_inode_symlink)
 BTF_ID(func, bpf_lsm_inode_unlink)
 BTF_ID(func, bpf_lsm_kernel_module_request)
 BTF_ID(func, bpf_lsm_kernfs_init_security)
+
+#ifdef CONFIG_KEYS
 BTF_ID(func, bpf_lsm_key_free)
+#endif /* CONFIG_KEYS */
+
 BTF_ID(func, bpf_lsm_mmap_file)
 BTF_ID(func, bpf_lsm_netlink_send)
 BTF_ID(func, bpf_lsm_path_notify)
@@ -181,6 +189,8 @@ BTF_ID(func, bpf_lsm_sb_show_options)
 BTF_ID(func, bpf_lsm_sb_statfs)
 BTF_ID(func, bpf_lsm_sb_umount)
 BTF_ID(func, bpf_lsm_settime)
+
+#ifdef CONFIG_SECURITY_NETWORK
 BTF_ID(func, bpf_lsm_socket_accept)
 BTF_ID(func, bpf_lsm_socket_bind)
 BTF_ID(func, bpf_lsm_socket_connect)
@@ -195,6 +205,8 @@ BTF_ID(func, bpf_lsm_socket_recvmsg)
 BTF_ID(func, bpf_lsm_socket_sendmsg)
 BTF_ID(func, bpf_lsm_socket_shutdown)
 BTF_ID(func, bpf_lsm_socket_socketpair)
+#endif /* CONFIG_SECURITY_NETWORK */
+
 BTF_ID(func, bpf_lsm_syslog)
 BTF_ID(func, bpf_lsm_task_alloc)
 BTF_ID(func, bpf_lsm_task_getsecid)
-- 
2.17.1

