Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEC814534F
	for <bpf@vger.kernel.org>; Sun, 31 Mar 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711915445; cv=none; b=KCIrAFhz7RM9hOF+GaT2XZHjxBH7IHRb6q0Y+jJDInLjfiZqnOagLOyGr6PjdjYgEpw96gdCb2WI8xuz+1uaCIlMusdqchlfyDhCWKV2YPhLpn0B0xWaNf/oMCjL5LBhQn/8AJf85tQZdCkc2CT13IESd4hrezQ5wE3rxmI5nnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711915445; c=relaxed/simple;
	bh=gKuSNBSsY/2u3lY/nG0np6qohP4wbB3CGXo0102HunE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CzaZM/dVFFAHn2Ab4TXiL5Vh7G0QwRc/xO8afn8OfeihAtIN3mKtc7ZJMzO5GzPMZKRKUejroMTNj/Wda28i98v5DKeA2rG68Z+4+G9xPd707RUvj3521EvDV0CXSer6CcbXXMg88sXZ01c0bHDVYY1FypYJ9i7Pfq63Ibtohtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onKn46Jh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onKn46Jh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF2CC43330;
	Sun, 31 Mar 2024 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711915445;
	bh=gKuSNBSsY/2u3lY/nG0np6qohP4wbB3CGXo0102HunE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=onKn46Jhn8OmvAW5Q/jLlXafUW/oL2s0iDe98lAooDVtudyUIMj9gi5VYQP5ppTNT
	 0R6aX117XU/8Q5SCe//bIRiYUhukoThAMn2Dp9urUiXLuUctO/jE7g06oCkAyoWgp1
	 2VD+zYz+lPHWbe3D5ZjtysXvEp/wwcbLKW1NsZDBZPCw2HmN1yeKfTRMPJje/mzTmB
	 DZzHscvHNxLeQL+7qj/+wlc/fm1LxOZNexUnLwGS6hbAV5oypH8SK3+gnFRHZJnzPy
	 +GmLbpDJufEupo3pQO1b7y2qd0AwPjCvTSefVbbMSTj6Z4WON5Lux8pDjIbaHPvBpg
	 RcvybrQ+y9/iA==
From: Quentin Monnet <qmo@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Rameez Rehman <rameezrehman408@hotmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 3/3] bpftool: Clean-up typos, punctuation, list formatting in docs
Date: Sun, 31 Mar 2024 21:03:46 +0100
Message-Id: <20240331200346.29118-4-qmo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240331200346.29118-1-qmo@kernel.org>
References: <20240331200346.29118-1-qmo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rameez Rehman <rameezrehman408@hotmail.com>

Improve the formatting of the attach flags for cgroup programs in the
relevant man page, and fix typos ("can be on of", "an userspace inet
socket") when introducing that list. Also fix a couple of other trivial
issues in docs.

[ Quentin: Fixed trival issues in bpftool-gen.rst and bpftool-iter.rst ]

Signed-off-by: Rameez Rehman <rameezrehman408@hotmail.com>
Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 .../bpftool/Documentation/bpftool-cgroup.rst  | 65 +++++++++----------
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  8 +--
 .../bpftool/Documentation/bpftool-iter.rst    |  2 +-
 3 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index 1acf9f58fca2..b2610d169e60 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -90,41 +90,36 @@ bpftool cgroup attach *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
 
     Non-default *ATTACH_FLAGS* are supported by kernel version 4.14 and later.
 
-    *ATTACH_TYPE* can be on of:
-    **ingress** ingress path of the inet socket (since 4.10);
-    **egress** egress path of the inet socket (since 4.10);
-    **sock_create** opening of an inet socket (since 4.10);
-    **sock_ops** various socket operations (since 4.12);
-    **device** device access (since 4.15);
-    **bind4** call to bind(2) for an inet4 socket (since 4.17);
-    **bind6** call to bind(2) for an inet6 socket (since 4.17);
-    **post_bind4** return from bind(2) for an inet4 socket (since 4.17);
-    **post_bind6** return from bind(2) for an inet6 socket (since 4.17);
-    **connect4** call to connect(2) for an inet4 socket (since 4.17);
-    **connect6** call to connect(2) for an inet6 socket (since 4.17);
-    **connect_unix** call to connect(2) for a unix socket (since 6.7);
-    **sendmsg4** call to sendto(2), sendmsg(2), sendmmsg(2) for an unconnected
-    udp4 socket (since 4.18);
-    **sendmsg6** call to sendto(2), sendmsg(2), sendmmsg(2) for an unconnected
-    udp6 socket (since 4.18);
-    **sendmsg_unix** call to sendto(2), sendmsg(2), sendmmsg(2) for an
-    unconnected unix socket (since 6.7);
-    **recvmsg4** call to recvfrom(2), recvmsg(2), recvmmsg(2) for an
-    unconnected udp4 socket (since 5.2);
-    **recvmsg6** call to recvfrom(2), recvmsg(2), recvmmsg(2) for an
-    unconnected udp6 socket (since 5.2);
-    **recvmsg_unix** call to recvfrom(2), recvmsg(2), recvmmsg(2) for an
-    unconnected unix socket (since 6.7);
-    **sysctl** sysctl access (since 5.2);
-    **getsockopt** call to getsockopt (since 5.3);
-    **setsockopt** call to setsockopt (since 5.3);
-    **getpeername4** call to getpeername(2) for an inet4 socket (since 5.8);
-    **getpeername6** call to getpeername(2) for an inet6 socket (since 5.8);
-    **getpeername_unix** call to getpeername(2) for a unix socket (since 6.7);
-    **getsockname4** call to getsockname(2) for an inet4 socket (since 5.8);
-    **getsockname6** call to getsockname(2) for an inet6 socket (since 5.8).
-    **getsockname_unix** call to getsockname(2) for a unix socket (since 6.7);
-    **sock_release** closing an userspace inet socket (since 5.9).
+    *ATTACH_TYPE* can be one of:
+
+    - **ingress** ingress path of the inet socket (since 4.10)
+    - **egress** egress path of the inet socket (since 4.10)
+    - **sock_create** opening of an inet socket (since 4.10)
+    - **sock_ops** various socket operations (since 4.12)
+    - **device** device access (since 4.15)
+    - **bind4** call to bind(2) for an inet4 socket (since 4.17)
+    - **bind6** call to bind(2) for an inet6 socket (since 4.17)
+    - **post_bind4** return from bind(2) for an inet4 socket (since 4.17)
+    - **post_bind6** return from bind(2) for an inet6 socket (since 4.17)
+    - **connect4** call to connect(2) for an inet4 socket (since 4.17)
+    - **connect6** call to connect(2) for an inet6 socket (since 4.17)
+    - **connect_unix** call to connect(2) for a unix socket (since 6.7)
+    - **sendmsg4** call to sendto(2), sendmsg(2), sendmmsg(2) for an unconnected udp4 socket (since 4.18)
+    - **sendmsg6** call to sendto(2), sendmsg(2), sendmmsg(2) for an unconnected udp6 socket (since 4.18)
+    - **sendmsg_unix** call to sendto(2), sendmsg(2), sendmmsg(2) for an unconnected unix socket (since 6.7)
+    - **recvmsg4** call to recvfrom(2), recvmsg(2), recvmmsg(2) for an unconnected udp4 socket (since 5.2)
+    - **recvmsg6** call to recvfrom(2), recvmsg(2), recvmmsg(2) for an unconnected udp6 socket (since 5.2)
+    - **recvmsg_unix** call to recvfrom(2), recvmsg(2), recvmmsg(2) for an unconnected unix socket (since 6.7)
+    - **sysctl** sysctl access (since 5.2)
+    - **getsockopt** call to getsockopt (since 5.3)
+    - **setsockopt** call to setsockopt (since 5.3)
+    - **getpeername4** call to getpeername(2) for an inet4 socket (since 5.8)
+    - **getpeername6** call to getpeername(2) for an inet6 socket (since 5.8)
+    - **getpeername_unix** call to getpeername(2) for a unix socket (since 6.7)
+    - **getsockname4** call to getsockname(2) for an inet4 socket (since 5.8)
+    - **getsockname6** call to getsockname(2) for an inet6 socket (since 5.8)
+    - **getsockname_unix** call to getsockname(2) for a unix socket (since 6.7)
+    - **sock_release** closing a userspace inet socket (since 5.9)
 
 bpftool cgroup detach *CGROUP* *ATTACH_TYPE* *PROG*
     Detach *PROG* from the cgroup *CGROUP* and attach type *ATTACH_TYPE*.
diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index e9589c21e9c3..c768e6d4ae09 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -110,7 +110,7 @@ bpftool gen skeleton *FILE*
     - **example__open_and_load** combines **example__open** and
       **example__load** invocations in one commonly used operation.
 
-    - **example__attach** and **example__detach**
+    - **example__attach** and **example__detach**.
       This pair of functions allow to attach and detach, correspondingly,
       already loaded BPF object. Only BPF programs of types supported by libbpf
       for auto-attachment will be auto-attached and their corresponding BPF
@@ -119,7 +119,7 @@ bpftool gen skeleton *FILE*
       **example__detach** will detach both links created automatically, as well
       as those populated by user manually.
 
-    - **example__destroy**
+    - **example__destroy**.
       Detach and unload BPF programs, free up all the resources used by
       skeleton and BPF object.
 
@@ -146,11 +146,11 @@ bpftool gen subskeleton *FILE*
 
     Consequently, there are only two functions defined for subskeletons:
 
-    - **example__open(bpf_object\*)**
+    - **example__open(bpf_object\*)**.
       Instantiates a subskeleton from an already opened (but not necessarily
       loaded) **bpf_object**.
 
-    - **example__destroy()**
+    - **example__destroy()**.
       Frees the storage for the subskeleton but *does not* unload any BPF
       programs or maps.
 
diff --git a/tools/bpf/bpftool/Documentation/bpftool-iter.rst b/tools/bpf/bpftool/Documentation/bpftool-iter.rst
index 7bcb4e993d7d..2e5d81c906dc 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-iter.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-iter.rst
@@ -21,7 +21,7 @@ SYNOPSIS
 *COMMANDS* := { **pin** | **help** }
 
 ITER COMMANDS
-===================
+=============
 
 | **bpftool** **iter pin** *OBJ* *PATH* [**map** *MAP*]
 | **bpftool** **iter help**
-- 
2.34.1

