Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22860C4360F
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06912084B
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="B4Z2rciH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbfCZSGp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:06:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35060 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732480AbfCZSGo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so15543848wrp.2
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m7nPu/pKQhL5sojiyqZrA/kh9tSYEiKRphQNX2XxZNk=;
        b=B4Z2rciHRqujg5G5jf4YAkAxmM/SgZ1kvSR9ZGB91H9z3fMOZhXU9DAWnOnhbj1/hn
         1ghLf3x5MEEhHU+z10f4J9I2WKfhCJUC0Ns87T7lVSagYEGtBFScmwgU+dw7BkorIGkv
         1E+xPEw9NrMj5YAydRCfInz+w1rslAC5VslpCCJBz9vsAbPIEYqGzL5bL11Yg/SrkWF1
         BNSG2i7kkqNWvSmAx6M5T4OGsjoux+WN69iXetUJL4KtbUik/CutowYHKO38a1RU2k1k
         h6TA7h4EE7QLBlLdoVOpmtsHcXgPvPzUUViAFVBV5EN10VZSbuPwZI4JghOxfdquq6ct
         TQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m7nPu/pKQhL5sojiyqZrA/kh9tSYEiKRphQNX2XxZNk=;
        b=ICEHTzGNhoe4KKpezxPP91LqMhy8LrfyvMCtZq3GQxLaajShzUhxJ7eGaDsNOeAt0j
         YKqPdBe7zdBXtmkJGO3oxGDou8ymEOv5GpNJL6ZbabbQ3bEa+wSU7jdu3zJpUe6zgyWe
         EeBdBTLKWtUBSCdjK/FQulhZVyypfLg3Z0JjrVsU0AO8rmxmDv/K4NfQJjVPUyFuovX+
         9QQVNFSudRd+tsHlxCY8xhlgGEyRpsw6vVXaxfOe9k7jOdLC0uQs42bW5wf3h3szOVvD
         631G9xhooS98OxEY2/iylFZdD0gx9U1/P0vwYoohZmDPDx753Sox2jYXp/L/VHombFVO
         pBDQ==
X-Gm-Message-State: APjAAAWkiUAo8up+jKCn63rcHfoWBrO8vDfv/BH0gBMlZzGsXWd2sh8I
        cRejKNnhfZeiNKj2Yb+gSg4InA==
X-Google-Smtp-Source: APXvYqwABR7iS3HcBOOWqfcjUuJgDTR8O3S/jTNM8OvA0kyj12jHz/rUF0fX9AS7ASxfnLcUvnc/tw==
X-Received: by 2002:adf:afd7:: with SMTP id y23mr19878648wrd.254.1553623602202;
        Tue, 26 Mar 2019 11:06:42 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:41 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC bpf-next 06/16] bpf: new sysctl "bpf_jit_32bit_opt"
Date:   Tue, 26 Mar 2019 18:05:29 +0000
Message-Id: <1553623539-15474-7-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After previous patches, verifier has marked those instructions that really
need zero extension on dst_reg.

It is then for all back-ends to decide how to use such information to
eliminate unnecessary zero extension codegen during JIT compilation.

One approach is:
  1. Verifier insert explicit zero extension for those instructions that
     need zero extension.
  2. All JIT back-ends do NOT generate zero extension for sub-register
     write any more.

The good thing for this approach is no major change on JIT back-end
interface, all back-ends could get this optimization.

However, only those back-ends that do not have hardware zero extension
want this optimization. For back-ends like x86_64 and AArch64, there is
hardware support, so this optimization should be disabled.

This patch introduces new sysctl "bpf_jit_32bit_opt" which is the control
variable for whether the optimization should be enabled.

It is initialized using target hook bpf_jit_hardware_zext which is default
true, meaning the underlying hardware will do zero extension automatically,
therefore the optimization will be disabled.

Offload targets do not use this native target hook, instead, they could
get the optimization results using bpf_prog_offload_ops.finalize.

The user could always enable or disable the optimization by using:

   sysctl net/core/bpf_jit_32bit_opt=[0 | 1]

A brief diagram below to show the logic of how the optimization is
controlled.

        arm                       ppc                      x86_64
bpf_jit_hardware_zext()  bpf_jit_hardware_zext()  bpf_jit_hardware_zext()
         |                         |                         |
         V                         V                         V
       false                     false                      true
            |                      |                          |
             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                   |
                                   V
                            bpf_jit_32bit_opt
                                   /\
                                  /  \
                                true false -> disable optimization
                                 |
                                 V
                               enable optimization

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 Documentation/sysctl/net.txt | 15 +++++++++++++++
 include/linux/filter.h       |  2 ++
 kernel/bpf/core.c            | 16 ++++++++++++++++
 net/core/sysctl_net_core.c   |  9 +++++++++
 4 files changed, 42 insertions(+)

diff --git a/Documentation/sysctl/net.txt b/Documentation/sysctl/net.txt
index 2ae91d3..f820e3b 100644
--- a/Documentation/sysctl/net.txt
+++ b/Documentation/sysctl/net.txt
@@ -101,6 +101,21 @@ compiler in order to reject unprivileged JIT requests once it has
 been surpassed. bpf_jit_limit contains the value of the global limit
 in bytes.
 
+bpf_jit_32bit_opt
+-----------------
+
+This enables verifier optimizations related with sub-register access. These
+optimizations aim to help JIT back-ends doing code-gen efficiently. There is
+only one such optimization at the moment, the zero extension insertion pass.
+Once it is enabled, verifier will guarantee high bits clearance semantics
+when doing sub-register write whenever it is necessary. Without this, JIT
+back-ends always need to do code-gen for high bits clearance, which leads to
+significant redundancy.
+
+Values :
+	0 - disable these optimization passes
+	1 - enable these optimization passes
+
 dev_weight
 --------------
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 6074aa0..b66a4d9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -819,6 +819,7 @@ u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
+bool bpf_jit_hardware_zext(void);
 bool bpf_helper_changes_pkt_data(void *func);
 
 static inline bool bpf_dump_raw_ok(void)
@@ -905,6 +906,7 @@ extern int bpf_jit_enable;
 extern int bpf_jit_harden;
 extern int bpf_jit_kallsyms;
 extern long bpf_jit_limit;
+extern int bpf_jit_32bit_opt;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 8834d80..cc7f0fd 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -524,6 +524,14 @@ int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_ALWAYS_ON);
 int bpf_jit_harden   __read_mostly;
 int bpf_jit_kallsyms __read_mostly;
 long bpf_jit_limit   __read_mostly;
+int bpf_jit_32bit_opt __read_mostly;
+
+static int __init bpf_jit_32bit_opt_init(void)
+{
+	bpf_jit_32bit_opt = !bpf_jit_hardware_zext();
+	return 0;
+}
+pure_initcall(bpf_jit_32bit_opt_init);
 
 static __always_inline void
 bpf_get_prog_addr_region(const struct bpf_prog *prog,
@@ -2089,6 +2097,14 @@ bool __weak bpf_helper_changes_pkt_data(void *func)
 	return false;
 }
 
+/* Return TRUE is the target hardware of JIT will do zero extension to high bits
+ * when writing to low 32-bit of one register. Otherwise, return FALSE.
+ */
+bool __weak bpf_jit_hardware_zext(void)
+{
+	return true;
+}
+
 /* To execute LD_ABS/LD_IND instructions __bpf_prog_run() may call
  * skb_copy_bits(), so provide a weak definition of it for NET-less config.
  */
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 84bf286..68be151 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -416,6 +416,15 @@ static struct ctl_table net_core_table[] = {
 		.extra1		= &zero,
 		.extra2		= &one,
 	},
+	{
+		.procname	= "bpf_jit_32bit_opt",
+		.data		= &bpf_jit_32bit_opt,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec_minmax_bpf_restricted,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
 # endif
 	{
 		.procname	= "bpf_jit_limit",
-- 
2.7.4

