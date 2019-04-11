Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDD5C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 16:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7162083E
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 16:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4xt95pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfDKQMG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:12:06 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:35483 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKQMG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 12:12:06 -0400
Received: by mail-it1-f202.google.com with SMTP id a64so5932137ith.0
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2019 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=fzkhHqdfXw1hzWoZacMZgH0zkdofFMSTU1efDvcW3WM=;
        b=i4xt95pIBplaAOQTcXyGF/kCvKP6kOOGSsvABszFn+Hq7C1xcjrRq0ZnqFlVEt66zj
         9aoWy0sdIw6RwAUam8XnePgKIOVW/TaEoD2GXSC9VJTkE8X/DXNLsDS3VU4ZA/cOPqeT
         6zmuokKkVb35rJBxwdsYBbwmjOrlBRqIb/wAxINrIG9tnFQ3GfTZxsrtUPh7YAPkDvFG
         re12jVe3bH7A0kYzw5L6tUmYo62JfRrvqv4ohoR8SwT3XF4B84UCEkN5x9AZRlqzVW3o
         UF8HK9GqVfDW4Z0l1EdEEtsNO/ofl9SiZP0abRW84xRgCjORd8rkgOUN1zkJK1SGYMpP
         y7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=fzkhHqdfXw1hzWoZacMZgH0zkdofFMSTU1efDvcW3WM=;
        b=ECaHdAY7XpEBnp+1Pb7COioH30UxgTnuBwOab2Ec0CEYJB1YW6RWTSkyJIG9KTeK6a
         PpHzOjlzTP4YcGjqEyObXEZWCb9U/BpBNynD2HdyJG7oALRnImUTXcp3XY62jBCIOOSC
         0DSyp/FWevoZq4SDosf92Nzd/Ljv91I7gjjIz+L2dkBL4rtG0aT7IO6fi9WO0j695SzT
         3l6Xt73rbtUSdFbyfWZzSDQ+3LbDUXmRhGCpwuFmXiDbyxYGoz4TOqMbkD6WgT9dzeMz
         O1Vef1UiORMt4zdOcTl+gOwEB5U2+Gmfsyymu5GQnwYuU+TREwWQTPwSTZ8KgvEaTv/B
         YqMQ==
X-Gm-Message-State: APjAAAW9ghG1Zq/13Y9nsESKkaU+kaz21kLx+oO2HdrVTP5lzkUA8QYi
        0z7bCp9NP4q1ITWXfEX7J+JgnPQ=
X-Google-Smtp-Source: APXvYqypN9bbL8DMA6m84gUEX2o9SWM2gu26vd3JazkOam4sQrd+gwY8/owVnYspOn5nD1SjQG85EhI=
X-Received: by 2002:a05:660c:60b:: with SMTP id i11mr2782884itk.9.1554999125418;
 Thu, 11 Apr 2019 09:12:05 -0700 (PDT)
Date:   Thu, 11 Apr 2019 09:12:02 -0700
Message-Id: <20190411161202.167610-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next] bpf: fix missing bpf_check_uarg_tail_zero in BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit b0b9395d865e ("bpf: support input __sk_buff context in
BPF_PROG_TEST_RUN") started using bpf_check_uarg_tail_zero in
BPF_PROG_TEST_RUN. However, bpf_check_uarg_tail_zero is not defined
for !CONFIG_BPF_SYSCALL:

net/bpf/test_run.c: In function =E2=80=98bpf_ctx_init=E2=80=99:
net/bpf/test_run.c:142:9: error: implicit declaration of function =E2=80=98=
bpf_check_uarg_tail_zero=E2=80=99 [-Werror=3Dimplicit-function-declaration]
   err =3D bpf_check_uarg_tail_zero(data_in, max_size, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~

Let's not build net/bpf/test_run.c when CONFIG_BPF_SYSCALL is not set.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: b0b9395d865e ("bpf: support input __sk_buff context in BPF_PROG_TEST=
_RUN")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h | 36 ++++++++++++++++++++++++++++--------
 net/bpf/Makefile    |  2 +-
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 65f7094c40b4..e4d4c1771ab0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -483,14 +483,6 @@ typedef u32 (*bpf_convert_ctx_access_t)(enum bpf_acces=
s_type type,
 u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_=
size,
 		     void *ctx, u64 ctx_size, bpf_ctx_copy_t ctx_copy);
=20
-int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kat=
tr,
-			  union bpf_attr __user *uattr);
-int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kat=
tr,
-			  union bpf_attr __user *uattr);
-int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
-				     const union bpf_attr *kattr,
-				     union bpf_attr __user *uattr);
-
 /* an array of programs to be executed under rcu_lock.
  *
  * Typical usage:
@@ -681,6 +673,13 @@ static inline int bpf_map_attr_numa_node(const union b=
pf_attr *attr)
 struct bpf_prog *bpf_prog_get_type_path(const char *name, enum bpf_prog_ty=
pe type);
 int array_map_alloc_check(union bpf_attr *attr);
=20
+int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kat=
tr,
+			  union bpf_attr __user *uattr);
+int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kat=
tr,
+			  union bpf_attr __user *uattr);
+int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
+				     const union bpf_attr *kattr,
+				     union bpf_attr __user *uattr);
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {
@@ -792,6 +791,27 @@ static inline struct bpf_prog *bpf_prog_get_type_path(=
const char *name,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline int bpf_prog_test_run_xdp(struct bpf_prog *prog,
+					const union bpf_attr *kattr,
+					union bpf_attr __user *uattr)
+{
+	return -ENOTSUPP;
+}
+
+static inline int bpf_prog_test_run_skb(struct bpf_prog *prog,
+					const union bpf_attr *kattr,
+					union bpf_attr __user *uattr)
+{
+	return -ENOTSUPP;
+}
+
+static inline int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
+						   const union bpf_attr *kattr,
+						   union bpf_attr __user *uattr)
+{
+	return -ENOTSUPP;
+}
 #endif /* CONFIG_BPF_SYSCALL */
=20
 static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
diff --git a/net/bpf/Makefile b/net/bpf/Makefile
index 27b2992a0692..b0ca361742e4 100644
--- a/net/bpf/Makefile
+++ b/net/bpf/Makefile
@@ -1 +1 @@
-obj-y	:=3D test_run.o
+obj-$(CONFIG_BPF_SYSCALL)	:=3D test_run.o
--=20
2.21.0.392.gf8f6787159e-goog

