Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817204;
	b=UZNQM8YsNbQtAljYEaZNK+QxNNKLsCgNQ9pACzCeLd/UPr/3evVbtOpoOejKbl8cpJoy
	 cItlB8Vp5xUI6z49DShQQB+13FXXqyeQvLGS0lYoYB9/UuhARylxTa1PYDIurGRi7t7EE
	 43XtleXgg52ZqI+YEBdqPLqaF4LfY3uBEczJzTSF4D3ufNPjF/LGbiJU0aZWxFucJUA75
	 V+lLkTzLiiF5mr5vggIcA6FmzHqZAHtibzTAszKwobKs/tSCfrqLAdvzM4A3M/fvFlFn0
	 q+C4ycsWmrR8NnhGd9NHyKpn8ZCXd87lsnX+1r2q/6nSolsWRsjmQw79rpduRgoJNWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dZJEIVEG28glfd0CAZR7e5GpNzf2U/0XgvN5No7CeMA=;
	b=NmPQW0/LFyXkj3Mf6cba47as/ejmdA3ngw1jq7pwee40q1e85Wr57ggrRsu1mrXOvG7h
	 Kqk/44kN0zYhZN/6fWUiKUJQjN1BG1ywN29H8evUIVmFPqB/p+3TcG/sLE9DoysU68GLU
	 OEunUG6HMQ/IrW1O/1c9s5xHP59t0QPGfMJuXYGZap+0UpgGtYEqkwS+tVx4VokuJGWaK
	 YCIXnD/vp8m8m+67sXCCbejl4NRvLIA7quMhvoEPs5BtAaQM7y53VYmhnRe7Sc1tGNfcv
	 B+4N0r2VT5YxcfrKZ+HN9Py9+eUhLHj+mQvlJCX15wnLnpamq42UwXsuUSi8i5tks3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qIpAUGhv;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D28606A329
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 18:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6D28606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qIpAUGhv
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36d94af5b9eso205707eec.0
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 10:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817203; x=1794422003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZJEIVEG28glfd0CAZR7e5GpNzf2U/0XgvN5No7CeMA=;
        b=qIpAUGhvFdhdjiNZY95XDqTQbtGBbGg7sgpqh306FuV+wFMlmPguGtm67f+68aFJkX
         YESK5wz+nx+lDSX0oVgx3A8NLmsosisHzaPapWs/bKWNNgw1e6ZE/IY6pkVtPIRIC2UD
         43ep6FIHUK8tFR/9GHyeD/OUNh+bCcQPQqmQCLWznxBlIPrs4lk/PA5iJmeyCMi/udrp
         DWqs3N4hTIgCQcdc75yy0l3FCCsJ6STwaHtNs+qwzlDbMn4wqwFhOPDU4A0Lgj6hF6Ow
         1tDeuRDbLKduAtYpaMH3ybvkwthxk+XN0nvwL0szzBNh2MEsDnv6xSemPaD4aXXleoPm
         5rqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817203; x=1794422003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZJEIVEG28glfd0CAZR7e5GpNzf2U/0XgvN5No7CeMA=;
        b=cTUpPEuu+IPCzg5BjCADiuTiwvgr+nAvmXUEs2iMIajrLO1t257rgrjNwT5D47IUXD
         9n7Q17ybChUyQY0XCIU7hLRQTbxAxy1czMdaMAh/cnYMIvOVYzLIcUONcmdS+Gof79Jc
         elVKSMVi8LPDpRLk77OzRerYpVnYKl2SdK27Kp8Dt+dZsALhczTzSFuROk4TbDnf1uNk
         iDZH0g3y8prAU5gng8OV6wOvk3sxJmPvQPTuJQ/6N9qaGtVDH3MzMmO5qlRSWrYoZw2L
         VmnuLPb7LbvA6bCH5gbHIr/rfzW8JgALqbTYZzO/b/QZtUfBZ07BKJqTa1XJKW3myhQ0
         B5cw==
X-Forwarded-Encrypted: i=1; AKwUvBxJG+1mb4HmGsbNZClzJ0CtKMd++Bw5vktQsKz3kB0CY/XNpVieaf7it6iBP4lZwoSlaro=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cjh5ucmIWsqUKYrD+vtBTVTPEJmMrXngVfYMPREx2XhTFTO1k
	ZfjaogNpcxDHDLuUxRZYTX4N+1bY7kPCmNAJwOJHzpcytU8UalzARWS12Pb6gH7mMzc=
X-Gm-Gg: AYBFou18RYSPzPS4kPtNx29WFsrdIw4pSmGmDSk1VjM9gTNWRFDU+ExfokbYZX7+g2L
	+3KfUma/JWnD+MgEG9W79UDIJAwBG2G+vPVf39M0YaR07UKmnVc8GltxlakMB0q1xm1LJWdbG2m
	QVINFWzKSHrhDIi0e01M8KJ8mxh10tA/NbJkMcP4SZmkhlskDVuJLJ7QrVtdAAx4vmXOprWNuoC
	761UtV3u2GhwA0ZkgXIL7JP+xRIiCXd0U7ZZxLT/a0ZyAmegCWtU5QyDrpBMdr37Q5Zc+adk8aC
	ftuOqcjoV5E1UN+GDdS+WWIgq7nmzhxxut4/BdCOFeGy99zbWxSto8O8M4ss/rkriXb/hnPyUwM
	h3+o8b6CR7KfHW041K9XB0f3E6D2HLatU0fU5gB207Jd0ZKZONLOfDGpsfUeZQDWwi3hV8GH5Hv
	01p5GIteu81J8X47DjSVAhA1n8YQknpS1WPAmW0AsMRiAtnDBQJ/ALd0MR/S9u1lAuUSTMtUDKS
	LnuFhRkuJsJN8Tt2TZ6pA1a187TkzljcZys9jqgikucpqtR0f1OtiBY1ocg+YVX6ZK6zdrZE7jz
	1MRr1Aj32jR3Sk/yd1lTevZM6IwCclLjkXwQ2RlD4HEz1V538YJiC1MUTLv4imPbVMYviikssu3
	1G5KnsF8sNn10/KYYzBEr
X-Received: by 2002:a05:693c:88c9:20b0:35c:8b96:94d9 with SMTP id 5a478bee46e88-36a42444bf2mr26662280eec.19.1793817202132;
        Wed, 04 Nov 2026 10:33:22 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c0f:581b:f54f:2020:25aa:5e4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36dd7ec8881sm1851435eec.18.2026.11.04.10.33.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 10:33:21 -0800 (PST)
From: Dhanush Arivappagari <arivappa.dvorak@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Dhanush Arivappagari <arivappa.dvorak@gmail.com>
Subject: [PATCH bpf-next] bpftool: Add missing commands to documentation synopses
Date: Thu,  5 Nov 2026 00:00:18 +0530
Message-ID: <20261104183018.30052-1-arivappa.dvorak@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several commands and objects implemented in bpftool are currently missing
from the SYNOPSIS sections in the man pages, causing documentation drift.

Update the documentation across bpftool man pages:
- Add the missing 'token' object and its commands to bpftool.rst.
- Add missing subcommands to the SYNOPSIS blocks of btf, feature, gen,
  link, map, net, and prog man pages to reflect existing implementations.
- Update help command headings in the cgroup and token documentation
  to reference their respective objects instead of prog.

Signed-off-by: Dhanush Arivappagari <arivappa.dvorak@gmail.com>
---
 tools/bpf/bpftool/Documentation/bpftool-btf.rst |  2 +-
 .../bpftool/Documentation/bpftool-cgroup.rst    |  2 +-
 .../bpftool/Documentation/bpftool-feature.rst   |  2 +-
 tools/bpf/bpftool/Documentation/bpftool-gen.rst |  2 +-
 .../bpf/bpftool/Documentation/bpftool-link.rst  |  2 +-
 tools/bpf/bpftool/Documentation/bpftool-map.rst |  3 ++-
 .../bpf/bpftool/Documentation/bpftool-prog.rst  |  2 +-
 .../bpf/bpftool/Documentation/bpftool-token.rst |  2 +-
 tools/bpf/bpftool/Documentation/bpftool.rst     | 17 ++++++++++-------
 9 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index c6dc445cd4a1..e25277260ceb 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -18,7 +18,7 @@ SYNOPSIS
 
 *OPTIONS* := { |COMMON_OPTIONS| | [{ **-B** | **--base-btf**} *FILE*]...  }
 
-*COMMANDS* := { **dump** | **help** }
+*COMMANDS* := { **show** | **list** | **dump** | **help** }
 
 BTF COMMANDS
 =============
diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index d1b8193dc576..7633a42b54b0 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -131,7 +131,7 @@ bpftool cgroup attach *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
 bpftool cgroup detach *CGROUP* *ATTACH_TYPE* *PROG*
     Detach *PROG* from the cgroup *CGROUP* and attach type *ATTACH_TYPE*.
 
-bpftool prog help
+bpftool cgroup help
     Print short help message.
 
 OPTIONS
diff --git a/tools/bpf/bpftool/Documentation/bpftool-feature.rst b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
index c7f837898bc7..9ed5ff93ebdb 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-feature.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
@@ -18,7 +18,7 @@ SYNOPSIS
 
 *OPTIONS* := { |COMMON_OPTIONS| }
 
-*COMMANDS* := { **probe** | **help** }
+*COMMANDS* := { **probe** | **list_builtins** | **help** }
 
 FEATURE COMMANDS
 ================
diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index d0a36f442db7..0c0f9616f676 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -18,7 +18,7 @@ SYNOPSIS
 
 *OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } | [ { **-S** | **--sign** } {**-k** <private_key.pem>} **-i** <certificate.x509> ] }
 
-*COMMAND* := { **object** | **skeleton** | **help** }
+*COMMAND* := { **object** | **skeleton** | **subskeleton** | **min_core_btf** | **help** }
 
 GEN COMMANDS
 =============
diff --git a/tools/bpf/bpftool/Documentation/bpftool-link.rst b/tools/bpf/bpftool/Documentation/bpftool-link.rst
index 6f09d4405ed8..21b22aa70fdc 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-link.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-link.rst
@@ -18,7 +18,7 @@ SYNOPSIS
 
 *OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } | { **-n** | **--nomount** } }
 
-*COMMANDS* := { **show** | **list** | **pin** | **help** }
+*COMMANDS* := { **show** | **list** | **pin** | **detach** | **help** }
 
 LINK COMMANDS
 =============
diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index e4ed7e701c9e..391b0c6c0c6a 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -20,7 +20,8 @@ SYNOPSIS
 
 *COMMANDS* :=
 { **show** | **list** | **create** | **dump** | **update** | **lookup** | **getnext** |
-**delete** | **pin** | **help** }
+**delete** | **pin** | **event_pipe** | **peek** | **push** | **pop** | **enqueue** | **dequeue** |
+**freeze** | **help** }
 
 MAP COMMANDS
 =============
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 8dbd34ef3d8b..c239cb506c38 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -23,7 +23,7 @@ SYNOPSIS
 
 *COMMANDS* :=
 { **show** | **list** | **dump xlated** | **dump jited** | **pin** | **load** |
-**loadall** | **help** }
+**loadall** | **attach** | **detach** | **tracelog** | **run** | **profile** | **help** }
 
 PROG COMMANDS
 =============
diff --git a/tools/bpf/bpftool/Documentation/bpftool-token.rst b/tools/bpf/bpftool/Documentation/bpftool-token.rst
index d082c499cfe3..1f4e6f4f64b0 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-token.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-token.rst
@@ -35,7 +35,7 @@ bpftool token { show | list }
     **bpf**\ () system call commands, maps, programs, and attach types for the
     token.
 
-bpftool prog help
+bpftool token help
     Print short help message.
 
 OPTIONS
diff --git a/tools/bpf/bpftool/Documentation/bpftool.rst b/tools/bpf/bpftool/Documentation/bpftool.rst
index f38ae5c40439..a213f7032d8d 100644
--- a/tools/bpf/bpftool/Documentation/bpftool.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool.rst
@@ -21,35 +21,38 @@ SYNOPSIS
 **bpftool** **version**
 
 *OBJECT* := { **map** | **prog** | **link** | **cgroup** | **perf** | **net** | **feature** |
-**btf** | **gen** | **struct_ops** | **iter** }
+**btf** | **gen** | **struct_ops** | **iter** | **token** }
 
 *OPTIONS* := { { **-V** | **--version** } | |COMMON_OPTIONS| }
 
 *MAP-COMMANDS* :=
 { **show** | **list** | **create** | **dump** | **update** | **lookup** | **getnext** |
-**delete** | **pin** | **event_pipe** | **help** }
+**delete** | **pin** | **event_pipe** | **peek** | **push** | **pop** | **enqueue** | **dequeue** |
+**freeze** | **help** }
 
 *PROG-COMMANDS* := { **show** | **list** | **dump jited** | **dump xlated** | **pin** |
-**load** | **attach** | **detach** | **help** }
+**load** | **loadall** | **attach** | **detach** | **run** | **profile** | **tracelog** | **help** }
 
 *LINK-COMMANDS* := { **show** | **list** | **pin** | **detach** | **help** }
 
-*CGROUP-COMMANDS* := { **show** | **list** | **attach** | **detach** | **help** }
+*CGROUP-COMMANDS* := { **show** | **list** | **tree** | **attach** | **detach** | **help** }
 
 *PERF-COMMANDS* := { **show** | **list** | **help** }
 
-*NET-COMMANDS* := { **show** | **list** | **help** }
+*NET-COMMANDS* := { **show** | **list** | **attach** | **detach** | **help** }
 
-*FEATURE-COMMANDS* := { **probe** | **help** }
+*FEATURE-COMMANDS* := { **probe** | **list_builtins** | **help** }
 
 *BTF-COMMANDS* := { **show** | **list** | **dump** | **help** }
 
-*GEN-COMMANDS* := { **object** | **skeleton** | **min_core_btf** | **help** }
+*GEN-COMMANDS* := { **object** | **skeleton** | **subskeleton** | **min_core_btf** | **help** }
 
 *STRUCT-OPS-COMMANDS* := { **show** | **list** | **dump** | **register** | **unregister** | **help** }
 
 *ITER-COMMANDS* := { **pin** | **help** }
 
+*TOKEN-COMMANDS* := { **show** | **list** | **help** }
+
 DESCRIPTION
 ===========
 *bpftool* allows for inspection and simple modification of BPF objects on the
