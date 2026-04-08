Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0446E36212D
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629317; cv=none; b=Gr7biNk7XO9B2065Dn4PrgntkiR+Yz47ka/c+9VUa1DYBnJwP3wSdbtQsN0/SqoGYFfC7elQ8xqtFiaGkxYXA9GBk8yvBuXONPSI4XQC896x+MxfQR1CAtbgeD1t7MLZFPiOpiXaWQc72EpIzuYf/DaOgx4PsFcSRUAbyTuiENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629317; c=relaxed/simple;
	bh=ws7lGY5DDx7cDa1bHI5ZlxYFjbZK7oocW2/1NSr3xtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnlAuukuur5Vj4TzO2hHz499YViV8KO2jy88iIPCJVTo/b2iaX8slPRJI9Awz2qvugH0TN7mFDintPZ+uQ+wQm4MgKTC+LVJG62vAXTr3pS5OBvbrp00+6O7wrSfMHfFj5He9I3MwS9z272mIFLSQlZgBb31+u4fj6STNbgNiXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MenQSDjX; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MenQSDjX"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82c68339cf0so293687b3a.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775629314; x=1776234114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptcHUH52MTJBYjzovgiwUsh2fxU5c/oxZodZTSTMLQs=;
        b=MenQSDjXUtM8ap+U73uxY02HlWfvIn1NSbjEXyExe4myMnNsiKsVumwkAoXogT2buY
         vKjLeIyIXiEaDRxUyGhI6qlA6jeyP/whN2UesGEF+tD1r2gbyRirhQD7q5SqJkdwH2LR
         DG7nvv5l2Jnqb5MhsZEVnpqhkewWayOjoPIt6oXVWRxFTs7UGe13FzlbFgZCSndThM4n
         5l0JRoGGxR6enrwaU8FLYh6CSf5Vdx/ZnLRorozfGakJ48D3IgKcqebZuooFAWA/hFL0
         63bDiQy88zVK09WqiVkypsESJOTIKOjqkpToI10NZg/hPRVkID6Ja1kDZUxENTzjNW/O
         OVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775629314; x=1776234114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ptcHUH52MTJBYjzovgiwUsh2fxU5c/oxZodZTSTMLQs=;
        b=KIl1KnwwdHsixLWUu6SyTqBuUoJlS8JOvqiGwj2yyXpCojDxpSE5sV4kqqf/Adm0H1
         ThN6+QqhdKtzA3fZQRc0ENjThoCwxj9cuSvs7CN2Uok8JWJoKcl8u1ax6UOD8ZABKiWN
         z1Cla75L2nzgTrxYHj98kQY09rwQLDdquvCWmq9oKFQs8VWGNEtTx71ovRGyiFzIlEFL
         tM/2aBcItBOV91/rgfJYlQEa+gmBNCNyjxXV//Cyh7R4Csv3JvVlq2YYtwbMNkhnvbXc
         sld5LKomYsoHeAycTPit3XLLxWEzccCaO1X6J5UtcMVMLA2IktJUtDaIIrFIQZnxy883
         BWqw==
X-Forwarded-Encrypted: i=1; AJvYcCVE9DnJReprVjfsJDCViK8rYNc1gzHQUvOu7jvJXFLqbZjnodeKjBEeoDqj7FeT1W3hOYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPEEiS3bveVaMgMAxveZpqs3t7J6FmkhoIa0IN9Q5PXdvn53Kf
	3YhngU3sDWUn7bTbEj6nvFTyfeK+JqoPp3x9pGJBO2+4O1UvHWKVPVhZ
X-Gm-Gg: AeBDieucxm1YYb8I9FZcQ2wRqfPnNxtIBcZedsFIEZ9KkHuDhhnQ5REna8hClUn611S
	c4ZDBcQ+W1pz3QerUE4P5HPTomYRhlezf5cSQnjx7M4DqB1SYXmq/2A9sObvhHCHtqs2eXIfpaY
	4qL7GMFstGf6d//byHsWtcSL/lmdT3qeQADJ4v+Vd0u1oI3NgFN6HR4D1apqx/rgBIt1Q30uCXk
	k3W/o2HJUj9AryTYt6yc3IpwJt/w5Aens0t/Po1wS+qyv+HhknXNFmpIvEse1SHJKYi6ysjOfjN
	WUVF6BS+29GBs/stBQKCB8VOF4P5ykJ6ywkduqWX98YSSreMbT2xZiCFzeJkqYupCuHC6zIqb/U
	EXdVowHG6BdwuqBeDr026fpC8/YdACc1O4PK37bAfcwSTDhFRnkZVNtrbRLrBxb/EPfjHGHwDGS
	nSJrQYeWMAcqi8aYFvn624
X-Received: by 2002:a05:6a00:1ca2:b0:7a9:d8a8:992a with SMTP id d2e1a72fcca58-82d0023fdbcmr18985149b3a.13.1775629314258;
        Tue, 07 Apr 2026 23:21:54 -0700 (PDT)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b60199sm17827638b3a.25.2026.04.07.23.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 23:21:53 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	emil@etsalapatis.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] bpftool: add missing fsession to the usage and docs of bpftool
Date: Wed,  8 Apr 2026 14:21:09 +0800
Message-ID: <20260408062109.386083-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408062109.386083-1-dongml2@chinatelecom.cn>
References: <20260408062109.386083-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the fsession attach type to the usage of bpftool in do_help().
Meanwhile, add it to the bash-completion and bpftool-prog.rst too.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 2 +-
 tools/bpf/bpftool/bash-completion/bpftool        | 2 +-
 tools/bpf/bpftool/prog.c                         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 35aeeaf5f711..90fa2a48cc26 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -54,7 +54,7 @@ PROG COMMANDS
 |     **cgroup/sendmsg4** | **cgroup/sendmsg6** | **cgroup/sendmsg_unix** |
 |     **cgroup/recvmsg4** | **cgroup/recvmsg6** | **cgroup/recvmsg_unix** | **cgroup/sysctl** |
 |     **cgroup/getsockopt** | **cgroup/setsockopt** | **cgroup/sock_release** |
-|     **struct_ops** | **fentry** | **fexit** | **freplace** | **sk_lookup**
+|     **struct_ops** | **fentry** | **fexit** | **fsession** | **freplace** | **sk_lookup**
 | }
 | *ATTACH_TYPE* := {
 |     **sk_msg_verdict** | **sk_skb_verdict** | **sk_skb_stream_verdict** |
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index babb0d4e9753..75cbcb512eba 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -501,7 +501,7 @@ _bpftool()
                                 cgroup/post_bind4 cgroup/post_bind6 \
                                 cgroup/sysctl cgroup/getsockopt \
                                 cgroup/setsockopt cgroup/sock_release struct_ops \
-                                fentry fexit freplace sk_lookup'
+                                fentry fexit fsession freplace sk_lookup'
                             COMPREPLY=( $( compgen -W "$BPFTOOL_PROG_LOAD_TYPES" -- "$cur" ) )
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 6daf19809ca4..a9f730d407a9 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2583,7 +2583,7 @@ static int do_help(int argc, char **argv)
 		"                 cgroup/getsockname_unix | cgroup/sendmsg4 | cgroup/sendmsg6 |\n"
 		"                 cgroup/sendmsg_unix | cgroup/recvmsg4 | cgroup/recvmsg6 | cgroup/recvmsg_unix |\n"
 		"                 cgroup/getsockopt | cgroup/setsockopt | cgroup/sock_release |\n"
-		"                 struct_ops | fentry | fexit | freplace | sk_lookup }\n"
+		"                 struct_ops | fentry | fexit | fsession | freplace | sk_lookup }\n"
 		"       ATTACH_TYPE := { sk_msg_verdict | sk_skb_verdict | sk_skb_stream_verdict |\n"
 		"                        sk_skb_stream_parser | flow_dissector }\n"
 		"       METRIC := { cycles | instructions | l1d_loads | llc_misses | itlb_misses | dtlb_misses }\n"
-- 
2.53.0

