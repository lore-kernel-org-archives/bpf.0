Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828D13A542D
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378047; cv=none; b=ZRGFbvJd5safIm4AFapJ5U0bP9oHEJx9kjo0o/W1ouuQYxY8aW/wUYnpTRqyPWFOlijTHye8zp3n+hWpz49pdr7IguZAnsC1cwsdvkyOTfjHkrHG5o9SRY+HMoc0TvRTNEtoJsZwrxsLlC8W/u4qI3e6p5N+YfnI+pwafdqXW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378047; c=relaxed/simple;
	bh=53FtnsCuM4e6/5F3bf619l1FA5IlHw/iDpC6DaQWCI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2trflTOKF4Cx9tQemZd5rseBnsjz9dZzOENRP9i2Hu0wEvjOnjbAD3DcXhQ3R1VYRobZ6HjcO4AemyUrwiRBQPkrXvVRzyZLL4oxdIuMzWmQ262vrnrjLKyBgbkTW7X1xOAC5YoRe/gsMJSAka07dTo8YiNq0s2+ViV5svSG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozTA+Dht; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozTA+Dht"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad4d639db3so19396675ad.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774378044; x=1774982844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EEDLAzRE9U1qCNYBdZlpQSbdmAzEh2YrqmR/0ul8nw=;
        b=ozTA+DhtlLLiqEwYoxl6OOqJ8PdTG6/M4Tw1JdPkrAWKXWBqMw3u78nfakPHlA+v6U
         D8naOwk1ALlyfmNt96IkiL0hiMg7Z9Hy9VeWJTPQ2QeAtkWbsYJ297CIw8RcRVrd56st
         Jm6DEwa1s8ZVM/hnRfMOJ30+V2zC5WmO8ZAbRuEnh6W95AL99yYkMwGYcaQ8xEW83Jtg
         MwWeLQm1MnzVlSOAL+QGDKFQyB9yWLCsFHEnu/QiV+IvieMFoq1avjEqxtqwZkqgLBWK
         QsLQffHFnbbU2mVbjuARZOW5fJOsLbXJ5Ekuw743VQE3FwmSp3wkz8EGoL17jKp0koa4
         BvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774378044; x=1774982844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+EEDLAzRE9U1qCNYBdZlpQSbdmAzEh2YrqmR/0ul8nw=;
        b=b+hZuSNqcmYZoCeTeb6R+ubkav4q18MQXzZrC3Zk708vOh24tFRFwiGQeEkA8OK8fz
         TTPJEbFPJF9kqobzIcHjp0rBxmnYjiBHj7pABkrBcGH0/uZ4+7kRZPSMjknz2vHqbAQI
         ms3ZJLraq17n5XRg3HclzZd6Z1TGqEJuIqAHhqfRLDqsdoBmvgezEc3q7scGCRkiTsho
         z8bRkxt+u7pfdeaQM2PVy+jr9yHYFP82eCE4+28Dk9Vcw0aRIFTj4IPZaA5z1lvRVM1P
         jeM96mRp9n9V3t3LyJMk0JhDcUNPEyPAPm3v3ijeD9jBBMOAZrD7ZEpRh1wKpgUpQ8nx
         NMQg==
X-Forwarded-Encrypted: i=1; AJvYcCUU9JVuRKyezUiJxelAJQR0/+7GF7u/DCrZDTxkfaBTuMUw93fOHoA0l0pkAj9bxjRA0po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyva4qrAxTGiYEGqm/uZfemYTnBlSy3pskoVT+ozQO16Mu9TtSU
	Vb6Y8Lv3aGGuNu6kLeGbnjys0R7CTtOpQIJ0psFMcbOqNZ/LCJnohc8V
X-Gm-Gg: ATEYQzx2BxqibQJYhqTrh6yVDDRZTaNY7s2ySDae+r5N6THrpqsCRtQsgI6Nk+qbVkB
	KtqZgHVW0jcP+bwb3XY+OpBkF0FQz7EhEDHnvwvjf3PWCUs6t0BS/MP2v2lXCENNjfFHtajhWpE
	4KKn65UDSpKJT7D59oD+2jhdKn7dJfcgmNxH80yAZT2kc8grDdYHpUa5EbMHa822AKPpulP/+UT
	E7ErZvrz/dQgINterXhX5V2J9CcXzgKRHY7mf3igPQmZVaB1M2PyNsX4Zl/wdDzkik7AfRHhNEw
	pggfu6/DcM7YoGozcR5yQxNOaU76MucJ+stnEq9qWZL4lIQAfXyLd54ZNUXnP0CAzu0m2AOZNW7
	XnUpbfv4S6OLgn2SRXnAGMNVl8JXdZT5GsJotzdLdykuPtNzbLEdvRBS32HXYL7v9UDYAGAa+Vj
	dV0DLQKezmchSPPvLZKsMszAi6qFKglgjTT7HJ7/SqK82p0c2suUptLPbEXzeZNB765fPmmdz8w
	Kc=
X-Received: by 2002:a17:902:f651:b0:2b0:6ce3:8f7 with SMTP id d9443c01a7336-2b0b0aead53mr6237685ad.43.1774378043889;
        Tue, 24 Mar 2026 11:47:23 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0a9801748sm36732975ad.17.2026.03.24.11.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:47:23 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	tj@kernel.org,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] docs: Raise minimum pahole version to 1.26 for KF_IMPLICIT_ARGS kfuncs
Date: Wed, 25 Mar 2026 02:47:18 +0800
Message-ID: <20260324184718.3747428-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAADnVQLbtuD=7mtGZFR25ULhjZ-3ifBpkyRcqu9jPSd2Mt3fBw@mail.gmail.com>
References: <CAADnVQLbtuD=7mtGZFR25ULhjZ-3ifBpkyRcqu9jPSd2Mt3fBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole
v1.26 or later.  Without it, such kfuncs will have incorrect BTF
prototypes in vmlinux, causing BPF programs to fail to load with a
"func_proto incompatible with vmlinux" error.  Many sched_ext kfuncs
are affected (e.g. scx_bpf_create_dsq, scx_bpf_kick_cpu).

The root cause: scripts/Makefile.btf passes --btf_features=decl_tag_kfuncs
to pahole only when pahole >= 1.26.  Without that flag, pahole emits no
DECL_TAG BTF entries for __bpf_kfunc-annotated functions.  As a result,
resolve_btfids/main.c::collect_kfuncs() finds no bpf_kfunc DECL_TAGs,
short-circuits at line 1002, and btf2btf() never creates the _impl
variants or strips the implicit 'aux' argument from the visible proto.
The vmlinux BTF retains the 3-param prototype while BPF programs declare
the 2-param version, triggering the mismatch.

Raise the minimum version in the requirements table from 1.22 to 1.26
and add a note explaining the failure mode, so users understand why
their BPF programs fail on distributions shipping pahole v1.25 (e.g.
Ubuntu 24.04 LTS).

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 Documentation/process/changes.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 6b373e193548..02068d72a101 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -38,7 +38,7 @@ bash                   4.2              bash --version
 binutils               2.30             ld -v
 flex                   2.5.35           flex --version
 bison                  2.0              bison --version
-pahole                 1.22             pahole --version
+pahole                 1.26             pahole --version
 util-linux             2.10o            mount --version
 kmod                   13               depmod -V
 e2fsprogs              1.41.4           e2fsck -V
@@ -145,6 +145,11 @@ Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
 generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from kernel
 modules as well.  This requires pahole v1.22 or later.
 
+Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole v1.26
+or later.  Without it, such kfuncs will have incorrect BTF prototypes in
+vmlinux, causing BPF programs to fail to load with a "func_proto incompatible
+with vmlinux" error.  Many sched_ext kfuncs are affected.
+
 It is found in the 'dwarves' or 'pahole' distro packages or from
 https://fedorapeople.org/~acme/dwarves/.
 
-- 
2.43.0

