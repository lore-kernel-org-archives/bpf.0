Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A714534F
	for <bpf@vger.kernel.org>; Sun, 31 Mar 2024 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711915439; cv=none; b=M+OPjscMBaMmPrtoRtRTgar8VEqskyIakwgNDWnYZiDOD3r+Va7NTeGDJRyKjJ1QO8oSNHx2oIWSSuu8ePbpvftSrLThXf4jnu/BLWNbWaTEuDRICNaConORUrKXVL+PwBlh99XN//3DxSk3CNN/QNxe00dPo9gjjCFutGHUlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711915439; c=relaxed/simple;
	bh=0eMdmJPwZ+ASvrtNQSPkRRRFcJReYa9J+UxlifZRl5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M8eVRbgJajws0L02Ickz0Vu/Oz6kg4tZkYSAECPXz5bov89c6NRls4+qYR0tnYhw0W8DEWk64drVY6VJurLxNRGzYtqeWmgd9aTS+gHFEZjRdKzE+72CUVP+pniGegsGB/Tbx1/VsYhhTnFlhbxz8IiUZi8UZXQyr8Gl053RoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfXWDjQn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfXWDjQn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD0FC433B2;
	Sun, 31 Mar 2024 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711915439;
	bh=0eMdmJPwZ+ASvrtNQSPkRRRFcJReYa9J+UxlifZRl5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KfXWDjQnbJC/0pvn65fvw004a6LFfDC4bQCBa0FM7EzCIe57y+Ry6K+MBIrfWqP3x
	 KzBYWg0Yth4sJEkluMaCfO11WHayfcXhWm1zOayFwpcbkuZ0JaMDhGj29FkN0tRT/9
	 uFpnrNRfkGRlcX638ZsPtD1NhcCC8foJSejxkFeEWiLHaBqObsExMJujPnsxmAut9l
	 tJoEYqQbkjH9KbggfzlE+8ipNkEkg5cGh7OYQdlt+ya2tTYO7frd3bgOHayAf3qrS2
	 MgvVV/IgQMiweXugVe9+DmtRkWLvyoPDgAiJFuCHFMf1jPyHuNW7m+3TMfwr1im/vK
	 P2F2W5qKBgwig==
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
Subject: [PATCH bpf-next 1/3] bpftool: Use simpler indentation in source rST for documentation
Date: Sun, 31 Mar 2024 21:03:44 +0100
Message-Id: <20240331200346.29118-2-qmo@kernel.org>
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

The rST manual pages for bpftool would use a mix of tabs and spaces for
indentation. While this is the norm in C code, this is rather unusual
for rST documents, and over time we've seen many contributors use a
wrong level of indentation for documentation update.

Let's fix bpftool's indentation in docs once and for all:

- Let's use spaces, that are more common in rST files.
- Remove one level of indentation for the synopsis, the command
  description, and the "see also" section. As a result, all sections
  start with the same indentation level in the generated man page.
- Rewrap the paragraphs after the changes.

There is no content change in this patch, only indentation and
rewrapping changes. The wrapping in the generated source files for the
manual pages is changed, but the pages displayed with "man" remain the
same, apart from the adjusted indentation level on relevant sections.

[ Quentin: rebased on bpf-next, removed indent level for command
  description and options, updated synopsis, command summary, and "see
  also" sections. ]

Signed-off-by: Rameez Rehman <rameezrehman408@hotmail.com>
Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/Documentation/Makefile      |   6 +-
 .../bpf/bpftool/Documentation/bpftool-btf.rst | 116 +++--
 .../bpftool/Documentation/bpftool-cgroup.rst  | 198 ++++----
 .../bpftool/Documentation/bpftool-feature.rst | 115 +++--
 .../bpf/bpftool/Documentation/bpftool-gen.rst | 338 +++++++-------
 .../bpftool/Documentation/bpftool-iter.rst    |  50 +-
 .../bpftool/Documentation/bpftool-link.rst    |  73 ++-
 .../bpf/bpftool/Documentation/bpftool-map.rst | 232 +++++-----
 .../bpf/bpftool/Documentation/bpftool-net.rst |  98 ++--
 .../bpftool/Documentation/bpftool-perf.rst    |  34 +-
 .../bpftool/Documentation/bpftool-prog.rst    | 426 +++++++++---------
 .../Documentation/bpftool-struct_ops.rst      |  71 ++-
 tools/bpf/bpftool/Documentation/bpftool.rst   |  60 +--
 .../bpftool/Documentation/common_options.rst  |  26 +-
 14 files changed, 880 insertions(+), 963 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/Makefile b/tools/bpf/bpftool/Documentation/Makefile
index ac8487dcff1d..4315652678b9 100644
--- a/tools/bpf/bpftool/Documentation/Makefile
+++ b/tools/bpf/bpftool/Documentation/Makefile
@@ -31,9 +31,9 @@ see_also = $(subst " ",, \
 	"\n" \
 	"SEE ALSO\n" \
 	"========\n" \
-	"\t**bpf**\ (2),\n" \
-	"\t**bpf-helpers**\\ (7)" \
-	$(foreach page,$(call list_pages,$(1)),",\n\t**$(page)**\\ (8)") \
+	"**bpf**\ (2),\n" \
+	"**bpf-helpers**\\ (7)" \
+	$(foreach page,$(call list_pages,$(1)),",\n**$(page)**\\ (8)") \
 	"\n")
 
 $(OUTPUT)%.8: %.rst
diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index 342716f74ec4..1be6b9aae053 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -14,82 +14,76 @@ tool for inspection of BTF data
 SYNOPSIS
 ========
 
-	**bpftool** [*OPTIONS*] **btf** *COMMAND*
+**bpftool** [*OPTIONS*] **btf** *COMMAND*
 
-	*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } }
+*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } }
 
-	*COMMANDS* := { **dump** | **help** }
+*COMMANDS* := { **dump** | **help** }
 
 BTF COMMANDS
 =============
 
-|	**bpftool** **btf** { **show** | **list** } [**id** *BTF_ID*]
-|	**bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*]
-|	**bpftool** **btf help**
+| **bpftool** **btf** { **show** | **list** } [**id** *BTF_ID*]
+| **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*]
+| **bpftool** **btf help**
 |
-|	*BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
-|	*FORMAT* := { **raw** | **c** }
-|	*MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
-|	*PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
+| *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
+| *FORMAT* := { **raw** | **c** }
+| *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
+| *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
 
 DESCRIPTION
 ===========
-	**bpftool btf { show | list }** [**id** *BTF_ID*]
-		  Show information about loaded BTF objects. If a BTF ID is
-		  specified, show information only about given BTF object,
-		  otherwise list all BTF objects currently loaded on the
-		  system.
-
-		  Since Linux 5.8 bpftool is able to discover information about
-		  processes that hold open file descriptors (FDs) against BTF
-		  objects. On such kernels bpftool will automatically emit this
-		  information as well.
-
-	**bpftool btf dump** *BTF_SRC*
-		  Dump BTF entries from a given *BTF_SRC*.
-
-		  When **id** is specified, BTF object with that ID will be
-		  loaded and all its BTF types emitted.
-
-		  When **map** is provided, it's expected that map has
-		  associated BTF object with BTF types describing key and
-		  value. It's possible to select whether to dump only BTF
-		  type(s) associated with key (**key**), value (**value**),
-		  both key and value (**kv**), or all BTF types present in
-		  associated BTF object (**all**). If not specified, **kv**
-		  is assumed.
-
-		  When **prog** is provided, it's expected that program has
-		  associated BTF object with BTF types.
-
-		  When specifying *FILE*, an ELF file is expected, containing
-		  .BTF section with well-defined BTF binary format data,
-		  typically produced by clang or pahole.
-
-		  **format** option can be used to override default (raw)
-		  output format. Raw (**raw**) or C-syntax (**c**) output
-		  formats are supported.
-
-	**bpftool btf help**
-		  Print short help message.
+**bpftool btf { show | list }** [**id** *BTF_ID*]
+    Show information about loaded BTF objects. If a BTF ID is specified, show
+    information only about given BTF object, otherwise list all BTF objects
+    currently loaded on the system.
+
+    Since Linux 5.8 bpftool is able to discover information about processes
+    that hold open file descriptors (FDs) against BTF objects. On such kernels
+    bpftool will automatically emit this information as well.
+
+**bpftool btf dump** *BTF_SRC*
+    Dump BTF entries from a given *BTF_SRC*.
+
+    When **id** is specified, BTF object with that ID will be loaded and all
+    its BTF types emitted.
+
+    When **map** is provided, it's expected that map has associated BTF object
+    with BTF types describing key and value. It's possible to select whether to
+    dump only BTF type(s) associated with key (**key**), value (**value**),
+    both key and value (**kv**), or all BTF types present in associated BTF
+    object (**all**). If not specified, **kv** is assumed.
+
+    When **prog** is provided, it's expected that program has associated BTF
+    object with BTF types.
+
+    When specifying *FILE*, an ELF file is expected, containing .BTF section
+    with well-defined BTF binary format data, typically produced by clang or
+    pahole.
+
+    **format** option can be used to override default (raw) output format. Raw
+    (**raw**) or C-syntax (**c**) output formats are supported.
+
+**bpftool btf help**
+    Print short help message.
 
 OPTIONS
 =======
-	.. include:: common_options.rst
+.. include:: common_options.rst
 
-	-B, --base-btf *FILE*
-		  Pass a base BTF object. Base BTF objects are typically used
-		  with BTF objects for kernel modules. To avoid duplicating
-		  all kernel symbols required by modules, BTF objects for
-		  modules are "split", they are built incrementally on top of
-		  the kernel (vmlinux) BTF object. So the base BTF reference
-		  should usually point to the kernel BTF.
+-B, --base-btf *FILE*
+    Pass a base BTF object. Base BTF objects are typically used with BTF
+    objects for kernel modules. To avoid duplicating all kernel symbols
+    required by modules, BTF objects for modules are "split", they are
+    built incrementally on top of the kernel (vmlinux) BTF object. So the
+    base BTF reference should usually point to the kernel BTF.
 
-		  When the main BTF object to process (for example, the
-		  module BTF to dump) is passed as a *FILE*, bpftool attempts
-		  to autodetect the path for the base object, and passing
-		  this option is optional. When the main BTF object is passed
-		  through other handles, this option becomes necessary.
+    When the main BTF object to process (for example, the module BTF to
+    dump) is passed as a *FILE*, bpftool attempts to autodetect the path
+    for the base object, and passing this option is optional. When the main
+    BTF object is passed through other handles, this option becomes
+    necessary.
 
 EXAMPLES
 ========
diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index 2ce900f66d6e..1dbabe33e56a 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -14,134 +14,130 @@ tool for inspection and simple manipulation of eBPF progs
 SYNOPSIS
 ========
 
-	**bpftool** [*OPTIONS*] **cgroup** *COMMAND*
+**bpftool** [*OPTIONS*] **cgroup** *COMMAND*
 
-	*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } }
+*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } }
 
-	*COMMANDS* :=
-	{ **show** | **list** | **tree** | **attach** | **detach** | **help** }
+*COMMANDS* :=
+{ **show** | **list** | **tree** | **attach** | **detach** | **help** }
 
 CGROUP COMMANDS
 ===============
 
-|	**bpftool** **cgroup** { **show** | **list** } *CGROUP* [**effective**]
-|	**bpftool** **cgroup tree** [*CGROUP_ROOT*] [**effective**]
-|	**bpftool** **cgroup attach** *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
-|	**bpftool** **cgroup detach** *CGROUP* *ATTACH_TYPE* *PROG*
-|	**bpftool** **cgroup help**
+| **bpftool** **cgroup** { **show** | **list** } *CGROUP* [**effective**]
+| **bpftool** **cgroup tree** [*CGROUP_ROOT*] [**effective**]
+| **bpftool** **cgroup attach** *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
+| **bpftool** **cgroup detach** *CGROUP* *ATTACH_TYPE* *PROG*
+| **bpftool** **cgroup help**
 |
-|	*PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
-|	*ATTACH_TYPE* := { **cgroup_inet_ingress** | **cgroup_inet_egress** |
-|		**cgroup_inet_sock_create** | **cgroup_sock_ops** |
-|		**cgroup_device** | **cgroup_inet4_bind** | **cgroup_inet6_bind** |
-|		**cgroup_inet4_post_bind** | **cgroup_inet6_post_bind** |
-|		**cgroup_inet4_connect** | **cgroup_inet6_connect** |
-|		**cgroup_unix_connect** | **cgroup_inet4_getpeername** |
-|		**cgroup_inet6_getpeername** | **cgroup_unix_getpeername** |
-|		**cgroup_inet4_getsockname** | **cgroup_inet6_getsockname** |
-|		**cgroup_unix_getsockname** | **cgroup_udp4_sendmsg** |
-|		**cgroup_udp6_sendmsg** | **cgroup_unix_sendmsg** |
-|		**cgroup_udp4_recvmsg** | **cgroup_udp6_recvmsg** |
-|		**cgroup_unix_recvmsg** | **cgroup_sysctl** |
-|		**cgroup_getsockopt** | **cgroup_setsockopt** |
-|		**cgroup_inet_sock_release** }
-|	*ATTACH_FLAGS* := { **multi** | **override** }
+| *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
+| *ATTACH_TYPE* := { **cgroup_inet_ingress** | **cgroup_inet_egress** |
+|     **cgroup_inet_sock_create** | **cgroup_sock_ops** |
+|     **cgroup_device** | **cgroup_inet4_bind** | **cgroup_inet6_bind** |
+|     **cgroup_inet4_post_bind** | **cgroup_inet6_post_bind** |
+|     **cgroup_inet4_connect** | **cgroup_inet6_connect** |
+|     **cgroup_unix_connect** | **cgroup_inet4_getpeername** |
+|     **cgroup_inet6_getpeername** | **cgroup_unix_getpeername** |
+|     **cgroup_inet4_getsockname** | **cgroup_inet6_getsockname** |
+|     **cgroup_unix_getsockname** | **cgroup_udp4_sendmsg** |
+|     **cgroup_udp6_sendmsg** | **cgroup_unix_sendmsg** |
+|     **cgroup_udp4_recvmsg** | **cgroup_udp6_recvmsg** |
+|     **cgroup_unix_recvmsg** | **cgroup_sysctl** |
+|     **cgroup_getsockopt** | **cgroup_setsockopt** |
+|     **cgroup_inet_sock_release** }
+| *ATTACH_FLAGS* := { **multi** | **override** }
 
 DESCRIPTION
 ===========
-	**bpftool cgroup { show | list }** *CGROUP* [**effective**]
-		  List all programs attached to the cgroup *CGROUP*.
+**bpftool cgroup { show | list }** *CGROUP* [**effective**]
+    List all programs attached to the cgroup *CGROUP*.
 
-		  Output will start with program ID followed by attach type,
-		  attach flags and program name.
+    Output will start with program ID followed by attach type, attach flags and
+    program name.
 
-		  If **effective** is specified retrieve effective programs that
-		  will execute for events within a cgroup. This includes
-		  inherited along with attached ones.
+    If **effective** is specified retrieve effective programs that will execute
+    for events within a cgroup. This includes inherited along with attached
+    ones.
 
-	**bpftool cgroup tree** [*CGROUP_ROOT*] [**effective**]
-		  Iterate over all cgroups in *CGROUP_ROOT* and list all
-		  attached programs. If *CGROUP_ROOT* is not specified,
-		  bpftool uses cgroup v2 mountpoint.
+**bpftool cgroup tree** [*CGROUP_ROOT*] [**effective**]
+    Iterate over all cgroups in *CGROUP_ROOT* and list all attached programs.
+    If *CGROUP_ROOT* is not specified, bpftool uses cgroup v2 mountpoint.
 
-		  The output is similar to the output of cgroup show/list
-		  commands: it starts with absolute cgroup path, followed by
-		  program ID, attach type, attach flags and program name.
+    The output is similar to the output of cgroup show/list commands: it starts
+    with absolute cgroup path, followed by program ID, attach type, attach
+    flags and program name.
 
-		  If **effective** is specified retrieve effective programs that
-		  will execute for events within a cgroup. This includes
-		  inherited along with attached ones.
+    If **effective** is specified retrieve effective programs that will execute
+    for events within a cgroup. This includes inherited along with attached
+    ones.
 
-	**bpftool cgroup attach** *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
-		  Attach program *PROG* to the cgroup *CGROUP* with attach type
-		  *ATTACH_TYPE* and optional *ATTACH_FLAGS*.
+**bpftool cgroup attach** *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
+    Attach program *PROG* to the cgroup *CGROUP* with attach type *ATTACH_TYPE*
+    and optional *ATTACH_FLAGS*.
 
-		  *ATTACH_FLAGS* can be one of: **override** if a sub-cgroup installs
-		  some bpf program, the program in this cgroup yields to sub-cgroup
-		  program; **multi** if a sub-cgroup installs some bpf program,
-		  that cgroup program gets run in addition to the program in this
-		  cgroup.
+    *ATTACH_FLAGS* can be one of: **override** if a sub-cgroup installs some
+    bpf program, the program in this cgroup yields to sub-cgroup program;
+    **multi** if a sub-cgroup installs some bpf program, that cgroup program
+    gets run in addition to the program in this cgroup.
 
-		  Only one program is allowed to be attached to a cgroup with
-		  no attach flags or the **override** flag. Attaching another
-		  program will release old program and attach the new one.
+    Only one program is allowed to be attached to a cgroup with no attach flags
+    or the **override** flag. Attaching another program will release old
+    program and attach the new one.
 
-		  Multiple programs are allowed to be attached to a cgroup with
-		  **multi**. They are executed in FIFO order (those that were
-		  attached first, run first).
+    Multiple programs are allowed to be attached to a cgroup with **multi**.
+    They are executed in FIFO order (those that were attached first, run
+    first).
 
-		  Non-default *ATTACH_FLAGS* are supported by kernel version 4.14
-		  and later.
+    Non-default *ATTACH_FLAGS* are supported by kernel version 4.14 and later.
 
-		  *ATTACH_TYPE* can be on of:
-		  **ingress** ingress path of the inet socket (since 4.10);
-		  **egress** egress path of the inet socket (since 4.10);
-		  **sock_create** opening of an inet socket (since 4.10);
-		  **sock_ops** various socket operations (since 4.12);
-		  **device** device access (since 4.15);
-		  **bind4** call to bind(2) for an inet4 socket (since 4.17);
-		  **bind6** call to bind(2) for an inet6 socket (since 4.17);
-		  **post_bind4** return from bind(2) for an inet4 socket (since 4.17);
-		  **post_bind6** return from bind(2) for an inet6 socket (since 4.17);
-		  **connect4** call to connect(2) for an inet4 socket (since 4.17);
-		  **connect6** call to connect(2) for an inet6 socket (since 4.17);
-		  **connect_unix** call to connect(2) for a unix socket (since 6.7);
-		  **sendmsg4** call to sendto(2), sendmsg(2), sendmmsg(2) for an
-		  unconnected udp4 socket (since 4.18);
-		  **sendmsg6** call to sendto(2), sendmsg(2), sendmmsg(2) for an
-		  unconnected udp6 socket (since 4.18);
-		  **sendmsg_unix** call to sendto(2), sendmsg(2), sendmmsg(2) for
-		  an unconnected unix socket (since 6.7);
-		  **recvmsg4** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
-		  an unconnected udp4 socket (since 5.2);
-		  **recvmsg6** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
-		  an unconnected udp6 socket (since 5.2);
-		  **recvmsg_unix** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
-		  an unconnected unix socket (since 6.7);
-		  **sysctl** sysctl access (since 5.2);
-		  **getsockopt** call to getsockopt (since 5.3);
-		  **setsockopt** call to setsockopt (since 5.3);
-		  **getpeername4** call to getpeername(2) for an inet4 socket (since 5.8);
-		  **getpeername6** call to getpeername(2) for an inet6 socket (since 5.8);
-		  **getpeername_unix** call to getpeername(2) for a unix socket (since 6.7);
-		  **getsockname4** call to getsockname(2) for an inet4 socket (since 5.8);
-		  **getsockname6** call to getsockname(2) for an inet6 socket (since 5.8).
-		  **getsockname_unix** call to getsockname(2) for a unix socket (since 6.7);
-		  **sock_release** closing an userspace inet socket (since 5.9).
+    *ATTACH_TYPE* can be on of:
+    **ingress** ingress path of the inet socket (since 4.10);
+    **egress** egress path of the inet socket (since 4.10);
+    **sock_create** opening of an inet socket (since 4.10);
+    **sock_ops** various socket operations (since 4.12);
+    **device** device access (since 4.15);
+    **bind4** call to bind(2) for an inet4 socket (since 4.17);
+    **bind6** call to bind(2) for an inet6 socket (since 4.17);
+    **post_bind4** return from bind(2) for an inet4 socket (since 4.17);
+    **post_bind6** return from bind(2) for an inet6 socket (since 4.17);
+    **connect4** call to connect(2) for an inet4 socket (since 4.17);
+    **connect6** call to connect(2) for an inet6 socket (since 4.17);
+    **connect_unix** call to connect(2) for a unix socket (since 6.7);
+    **sendmsg4** call to sendto(2), sendmsg(2), sendmmsg(2) for an unconnected
+    udp4 socket (since 4.18);
+    **sendmsg6** call to sendto(2), sendmsg(2), sendmmsg(2) for an unconnected
+    udp6 socket (since 4.18);
+    **sendmsg_unix** call to sendto(2), sendmsg(2), sendmmsg(2) for an
+    unconnected unix socket (since 6.7);
+    **recvmsg4** call to recvfrom(2), recvmsg(2), recvmmsg(2) for an
+    unconnected udp4 socket (since 5.2);
+    **recvmsg6** call to recvfrom(2), recvmsg(2), recvmmsg(2) for an
+    unconnected udp6 socket (since 5.2);
+    **recvmsg_unix** call to recvfrom(2), recvmsg(2), recvmmsg(2) for an
+    unconnected unix socket (since 6.7);
+    **sysctl** sysctl access (since 5.2);
+    **getsockopt** call to getsockopt (since 5.3);
+    **setsockopt** call to setsockopt (since 5.3);
+    **getpeername4** call to getpeername(2) for an inet4 socket (since 5.8);
+    **getpeername6** call to getpeername(2) for an inet6 socket (since 5.8);
+    **getpeername_unix** call to getpeername(2) for a unix socket (since 6.7);
+    **getsockname4** call to getsockname(2) for an inet4 socket (since 5.8);
+    **getsockname6** call to getsockname(2) for an inet6 socket (since 5.8).
+    **getsockname_unix** call to getsockname(2) for a unix socket (since 6.7);
+    **sock_release** closing an userspace inet socket (since 5.9).
 
-	**bpftool cgroup detach** *CGROUP* *ATTACH_TYPE* *PROG*
-		  Detach *PROG* from the cgroup *CGROUP* and attach type
-		  *ATTACH_TYPE*.
+**bpftool cgroup detach** *CGROUP* *ATTACH_TYPE* *PROG*
+    Detach *PROG* from the cgroup *CGROUP* and attach type *ATTACH_TYPE*.
 
-	**bpftool prog help**
-		  Print short help message.
+**bpftool prog help**
+    Print short help message.
 
 OPTIONS
 =======
-	.. include:: common_options.rst
+.. include:: common_options.rst
 
-	-f, --bpffs
-		  Show file names of pinned programs.
+-f, --bpffs
+    Show file names of pinned programs.
 
 EXAMPLES
 ========
diff --git a/tools/bpf/bpftool/Documentation/bpftool-feature.rst b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
index e44039f89be7..5c2433147ba4 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-feature.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
@@ -14,77 +14,70 @@ tool for inspection of eBPF-related parameters for Linux kernel or net device
 SYNOPSIS
 ========
 
-	**bpftool** [*OPTIONS*] **feature** *COMMAND*
+**bpftool** [*OPTIONS*] **feature** *COMMAND*
 
-	*OPTIONS* := { |COMMON_OPTIONS| }
+*OPTIONS* := { |COMMON_OPTIONS| }
 
-	*COMMANDS* := { **probe** | **help** }
+*COMMANDS* := { **probe** | **help** }
 
 FEATURE COMMANDS
 ================
 
-|	**bpftool** **feature probe** [*COMPONENT*] [**full**] [**unprivileged**] [**macros** [**prefix** *PREFIX*]]
-|	**bpftool** **feature list_builtins** *GROUP*
-|	**bpftool** **feature help**
+| **bpftool** **feature probe** [*COMPONENT*] [**full**] [**unprivileged**] [**macros** [**prefix** *PREFIX*]]
+| **bpftool** **feature list_builtins** *GROUP*
+| **bpftool** **feature help**
 |
-|	*COMPONENT* := { **kernel** | **dev** *NAME* }
-|	*GROUP* := { **prog_types** | **map_types** | **attach_types** | **link_types** | **helpers** }
+| *COMPONENT* := { **kernel** | **dev** *NAME* }
+| *GROUP* := { **prog_types** | **map_types** | **attach_types** | **link_types** | **helpers** }
 
 DESCRIPTION
 ===========
-	**bpftool feature probe** [**kernel**] [**full**] [**macros** [**prefix** *PREFIX*]]
-		  Probe the running kernel and dump a number of eBPF-related
-		  parameters, such as availability of the **bpf**\ () system call,
-		  JIT status, eBPF program types availability, eBPF helper
-		  functions availability, and more.
-
-		  By default, bpftool **does not run probes** for
-		  **bpf_probe_write_user**\ () and **bpf_trace_printk**\()
-		  helpers which print warnings to kernel logs. To enable them
-		  and run all probes, the **full** keyword should be used.
-
-		  If the **macros** keyword (but not the **-j** option) is
-		  passed, a subset of the output is dumped as a list of
-		  **#define** macros that are ready to be included in a C
-		  header file, for example. If, additionally, **prefix** is
-		  used to define a *PREFIX*, the provided string will be used
-		  as a prefix to the names of the macros: this can be used to
-		  avoid conflicts on macro names when including the output of
-		  this command as a header file.
-
-		  Keyword **kernel** can be omitted. If no probe target is
-		  specified, probing the kernel is the default behaviour.
-
-		  When the **unprivileged** keyword is used, bpftool will dump
-		  only the features available to a user who does not have the
-		  **CAP_SYS_ADMIN** capability set. The features available in
-		  that case usually represent a small subset of the parameters
-		  supported by the system. Unprivileged users MUST use the
-		  **unprivileged** keyword: This is to avoid misdetection if
-		  bpftool is inadvertently run as non-root, for example. This
-		  keyword is unavailable if bpftool was compiled without
-		  libcap.
-
-	**bpftool feature probe dev** *NAME* [**full**] [**macros** [**prefix** *PREFIX*]]
-		  Probe network device for supported eBPF features and dump
-		  results to the console.
-
-		  The keywords **full**, **macros** and **prefix** have the
-		  same role as when probing the kernel.
-
-	**bpftool feature list_builtins** *GROUP*
-		  List items known to bpftool. These can be BPF program types
-		  (**prog_types**), BPF map types (**map_types**), attach types
-		  (**attach_types**), link types (**link_types**), or BPF helper
-		  functions (**helpers**). The command does not probe the system, but
-		  simply lists the elements that bpftool knows from compilation time,
-		  as provided from libbpf (for all object types) or from the BPF UAPI
-		  header (list of helpers). This can be used in scripts to iterate over
-		  BPF types or helpers.
-
-	**bpftool feature help**
-		  Print short help message.
+**bpftool feature probe** [**kernel**] [**full**] [**macros** [**prefix** *PREFIX*]]
+    Probe the running kernel and dump a number of eBPF-related parameters, such
+    as availability of the **bpf**\ () system call, JIT status, eBPF program
+    types availability, eBPF helper functions availability, and more.
+
+    By default, bpftool **does not run probes** for **bpf_probe_write_user**\
+    () and **bpf_trace_printk**\() helpers which print warnings to kernel logs.
+    To enable them and run all probes, the **full** keyword should be used.
+
+    If the **macros** keyword (but not the **-j** option) is passed, a subset
+    of the output is dumped as a list of **#define** macros that are ready to
+    be included in a C header file, for example. If, additionally, **prefix**
+    is used to define a *PREFIX*, the provided string will be used as a prefix
+    to the names of the macros: this can be used to avoid conflicts on macro
+    names when including the output of this command as a header file.
+
+    Keyword **kernel** can be omitted. If no probe target is specified, probing
+    the kernel is the default behaviour.
+
+    When the **unprivileged** keyword is used, bpftool will dump only the
+    features available to a user who does not have the **CAP_SYS_ADMIN**
+    capability set. The features available in that case usually represent a
+    small subset of the parameters supported by the system. Unprivileged users
+    MUST use the **unprivileged** keyword: This is to avoid misdetection if
+    bpftool is inadvertently run as non-root, for example. This keyword is
+    unavailable if bpftool was compiled without libcap.
+
+**bpftool feature probe dev** *NAME* [**full**] [**macros** [**prefix** *PREFIX*]]
+    Probe network device for supported eBPF features and dump results to the
+    console.
+
+    The keywords **full**, **macros** and **prefix** have the same role as when
+    probing the kernel.
+
+**bpftool feature list_builtins** *GROUP*
+    List items known to bpftool. These can be BPF program types
+    (**prog_types**), BPF map types (**map_types**), attach types
+    (**attach_types**), link types (**link_types**), or BPF helper functions
+    (**helpers**). The command does not probe the system, but simply lists the
+    elements that bpftool knows from compilation time, as provided from libbpf
+    (for all object types) or from the BPF UAPI header (list of helpers). This
+    can be used in scripts to iterate over BPF types or helpers.
+
+**bpftool feature help**
+    Print short help message.
 
 OPTIONS
 =======
-	.. include:: common_options.rst
+.. include:: common_options.rst
diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index 5e60825818dd..68104347d592 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -14,199 +14,177 @@ tool for BPF code-generation
 SYNOPSIS
 ========
 
-	**bpftool** [*OPTIONS*] **gen** *COMMAND*
+**bpftool** [*OPTIONS*] **gen** *COMMAND*
 
-	*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
+*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
 
-	*COMMAND* := { **object** | **skeleton** | **help** }
+*COMMAND* := { **object** | **skeleton** | **help** }
 
 GEN COMMANDS
 =============
 
-|	**bpftool** **gen object** *OUTPUT_FILE* *INPUT_FILE* [*INPUT_FILE*...]
-|	**bpftool** **gen skeleton** *FILE* [**name** *OBJECT_NAME*]
-|	**bpftool** **gen subskeleton** *FILE* [**name** *OBJECT_NAME*]
-|	**bpftool** **gen min_core_btf** *INPUT* *OUTPUT* *OBJECT* [*OBJECT*...]
-|	**bpftool** **gen help**
+| **bpftool** **gen object** *OUTPUT_FILE* *INPUT_FILE* [*INPUT_FILE*...]
+| **bpftool** **gen skeleton** *FILE* [**name** *OBJECT_NAME*]
+| **bpftool** **gen subskeleton** *FILE* [**name** *OBJECT_NAME*]
+| **bpftool** **gen min_core_btf** *INPUT* *OUTPUT* *OBJECT* [*OBJECT*...]
+| **bpftool** **gen help**
 
 DESCRIPTION
 ===========
-	**bpftool gen object** *OUTPUT_FILE* *INPUT_FILE* [*INPUT_FILE*...]
-		  Statically link (combine) together one or more *INPUT_FILE*'s
-		  into a single resulting *OUTPUT_FILE*. All the files involved
-		  are BPF ELF object files.
-
-		  The rules of BPF static linking are mostly the same as for
-		  user-space object files, but in addition to combining data
-		  and instruction sections, .BTF and .BTF.ext (if present in
-		  any of the input files) data are combined together. .BTF
-		  data is deduplicated, so all the common types across
-		  *INPUT_FILE*'s will only be represented once in the resulting
-		  BTF information.
-
-		  BPF static linking allows to partition BPF source code into
-		  individually compiled files that are then linked into
-		  a single resulting BPF object file, which can be used to
-		  generated BPF skeleton (with **gen skeleton** command) or
-		  passed directly into **libbpf** (using **bpf_object__open()**
-		  family of APIs).
-
-	**bpftool gen skeleton** *FILE*
-		  Generate BPF skeleton C header file for a given *FILE*.
-
-		  BPF skeleton is an alternative interface to existing libbpf
-		  APIs for working with BPF objects. Skeleton code is intended
-		  to significantly shorten and simplify code to load and work
-		  with BPF programs from userspace side. Generated code is
-		  tailored to specific input BPF object *FILE*, reflecting its
-		  structure by listing out available maps, program, variables,
-		  etc. Skeleton eliminates the need to lookup mentioned
-		  components by name. Instead, if skeleton instantiation
-		  succeeds, they are populated in skeleton structure as valid
-		  libbpf types (e.g., **struct bpf_map** pointer) and can be
-		  passed to existing generic libbpf APIs.
-
-		  In addition to simple and reliable access to maps and
-		  programs, skeleton provides a storage for BPF links (**struct
-		  bpf_link**) for each BPF program within BPF object. When
-		  requested, supported BPF programs will be automatically
-		  attached and resulting BPF links stored for further use by
-		  user in pre-allocated fields in skeleton struct. For BPF
-		  programs that can't be automatically attached by libbpf,
-		  user can attach them manually, but store resulting BPF link
-		  in per-program link field. All such set up links will be
-		  automatically destroyed on BPF skeleton destruction. This
-		  eliminates the need for users to manage links manually and
-		  rely on libbpf support to detach programs and free up
-		  resources.
-
-		  Another facility provided by BPF skeleton is an interface to
-		  global variables of all supported kinds: mutable, read-only,
-		  as well as extern ones. This interface allows to pre-setup
-		  initial values of variables before BPF object is loaded and
-		  verified by kernel. For non-read-only variables, the same
-		  interface can be used to fetch values of global variables on
-		  userspace side, even if they are modified by BPF code.
-
-		  During skeleton generation, contents of source BPF object
-		  *FILE* is embedded within generated code and is thus not
-		  necessary to keep around. This ensures skeleton and BPF
-		  object file are matching 1-to-1 and always stay in sync.
-		  Generated code is dual-licensed under LGPL-2.1 and
-		  BSD-2-Clause licenses.
-
-		  It is a design goal and guarantee that skeleton interfaces
-		  are interoperable with generic libbpf APIs. User should
-		  always be able to use skeleton API to create and load BPF
-		  object, and later use libbpf APIs to keep working with
-		  specific maps, programs, etc.
-
-		  As part of skeleton, few custom functions are generated.
-		  Each of them is prefixed with object name. Object name can
-		  either be derived from object file name, i.e., if BPF object
-		  file name is **example.o**, BPF object name will be
-		  **example**. Object name can be also specified explicitly
-		  through **name** *OBJECT_NAME* parameter. The following
-		  custom functions are provided (assuming **example** as
-		  the object name):
-
-		  - **example__open** and **example__open_opts**.
-		    These functions are used to instantiate skeleton. It
-		    corresponds to libbpf's **bpf_object__open**\ () API.
-		    **_opts** variants accepts extra **bpf_object_open_opts**
-		    options.
-
-		  - **example__load**.
-		    This function creates maps, loads and verifies BPF
-		    programs, initializes global data maps. It corresponds to
-		    libppf's **bpf_object__load**\ () API.
-
-		  - **example__open_and_load** combines **example__open** and
-		    **example__load** invocations in one commonly used
-		    operation.
-
-		  - **example__attach** and **example__detach**
-		    This pair of functions allow to attach and detach,
-		    correspondingly, already loaded BPF object. Only BPF
-		    programs of types supported by libbpf for auto-attachment
-		    will be auto-attached and their corresponding BPF links
-		    instantiated. For other BPF programs, user can manually
-		    create a BPF link and assign it to corresponding fields in
-		    skeleton struct. **example__detach** will detach both
-		    links created automatically, as well as those populated by
-		    user manually.
-
-		  - **example__destroy**
-		    Detach and unload BPF programs, free up all the resources
-		    used by skeleton and BPF object.
-
-		  If BPF object has global variables, corresponding structs
-		  with memory layout corresponding to global data data section
-		  layout will be created. Currently supported ones are: *.data*,
-		  *.bss*, *.rodata*, and *.kconfig* structs/data sections.
-		  These data sections/structs can be used to set up initial
-		  values of variables, if set before **example__load**.
-		  Afterwards, if target kernel supports memory-mapped BPF
-		  arrays, same structs can be used to fetch and update
-		  (non-read-only) data from userspace, with same simplicity
-		  as for BPF side.
-
-	**bpftool gen subskeleton** *FILE*
-		  Generate BPF subskeleton C header file for a given *FILE*.
-
-		  Subskeletons are similar to skeletons, except they do not own
-		  the corresponding maps, programs, or global variables. They
-		  require that the object file used to generate them is already
-		  loaded into a *bpf_object* by some other means.
-
-		  This functionality is useful when a library is included into a
-		  larger BPF program. A subskeleton for the library would have
-		  access to all objects and globals defined in it, without
-		  having to know about the larger program.
-
-		  Consequently, there are only two functions defined
-		  for subskeletons:
-
-		  - **example__open(bpf_object\*)**
-		    Instantiates a subskeleton from an already opened (but not
-		    necessarily loaded) **bpf_object**.
-
-		  - **example__destroy()**
-		    Frees the storage for the subskeleton but *does not* unload
-		    any BPF programs or maps.
-
-	**bpftool** **gen min_core_btf** *INPUT* *OUTPUT* *OBJECT* [*OBJECT*...]
-		  Generate a minimum BTF file as *OUTPUT*, derived from a given
-		  *INPUT* BTF file, containing all needed BTF types so one, or
-		  more, given eBPF objects CO-RE relocations may be satisfied.
-
-		  When kernels aren't compiled with CONFIG_DEBUG_INFO_BTF,
-		  libbpf, when loading an eBPF object, has to rely on external
-		  BTF files to be able to calculate CO-RE relocations.
-
-		  Usually, an external BTF file is built from existing kernel
-		  DWARF data using pahole. It contains all the types used by
-		  its respective kernel image and, because of that, is big.
-
-		  The min_core_btf feature builds smaller BTF files, customized
-		  to one or multiple eBPF objects, so they can be distributed
-		  together with an eBPF CO-RE based application, turning the
-		  application portable to different kernel versions.
-
-		  Check examples bellow for more information how to use it.
-
-	**bpftool gen help**
-		  Print short help message.
+**bpftool gen object** *OUTPUT_FILE* *INPUT_FILE* [*INPUT_FILE*...]
+    Statically link (combine) together one or more *INPUT_FILE*'s into a single
+    resulting *OUTPUT_FILE*. All the files involved are BPF ELF object files.
+
+    The rules of BPF static linking are mostly the same as for user-space
+    object files, but in addition to combining data and instruction sections,
+    .BTF and .BTF.ext (if present in any of the input files) data are combined
+    together. .BTF data is deduplicated, so all the common types across
+    *INPUT_FILE*'s will only be represented once in the resulting BTF
+    information.
+
+    BPF static linking allows to partition BPF source code into individually
+    compiled files that are then linked into a single resulting BPF object
+    file, which can be used to generated BPF skeleton (with **gen skeleton**
+    command) or passed directly into **libbpf** (using **bpf_object__open()**
+    family of APIs).
+
+**bpftool gen skeleton** *FILE*
+    Generate BPF skeleton C header file for a given *FILE*.
+
+    BPF skeleton is an alternative interface to existing libbpf APIs for
+    working with BPF objects. Skeleton code is intended to significantly
+    shorten and simplify code to load and work with BPF programs from userspace
+    side. Generated code is tailored to specific input BPF object *FILE*,
+    reflecting its structure by listing out available maps, program, variables,
+    etc. Skeleton eliminates the need to lookup mentioned components by name.
+    Instead, if skeleton instantiation succeeds, they are populated in skeleton
+    structure as valid libbpf types (e.g., **struct bpf_map** pointer) and can
+    be passed to existing generic libbpf APIs.
+
+    In addition to simple and reliable access to maps and programs, skeleton
+    provides a storage for BPF links (**struct bpf_link**) for each BPF program
+    within BPF object. When requested, supported BPF programs will be
+    automatically attached and resulting BPF links stored for further use by
+    user in pre-allocated fields in skeleton struct. For BPF programs that
+    can't be automatically attached by libbpf, user can attach them manually,
+    but store resulting BPF link in per-program link field. All such set up
+    links will be automatically destroyed on BPF skeleton destruction. This
+    eliminates the need for users to manage links manually and rely on libbpf
+    support to detach programs and free up resources.
+
+    Another facility provided by BPF skeleton is an interface to global
+    variables of all supported kinds: mutable, read-only, as well as extern
+    ones. This interface allows to pre-setup initial values of variables before
+    BPF object is loaded and verified by kernel. For non-read-only variables,
+    the same interface can be used to fetch values of global variables on
+    userspace side, even if they are modified by BPF code.
+
+    During skeleton generation, contents of source BPF object *FILE* is
+    embedded within generated code and is thus not necessary to keep around.
+    This ensures skeleton and BPF object file are matching 1-to-1 and always
+    stay in sync. Generated code is dual-licensed under LGPL-2.1 and
+    BSD-2-Clause licenses.
+
+    It is a design goal and guarantee that skeleton interfaces are
+    interoperable with generic libbpf APIs. User should always be able to use
+    skeleton API to create and load BPF object, and later use libbpf APIs to
+    keep working with specific maps, programs, etc.
+
+    As part of skeleton, few custom functions are generated. Each of them is
+    prefixed with object name. Object name can either be derived from object
+    file name, i.e., if BPF object file name is **example.o**, BPF object name
+    will be **example**. Object name can be also specified explicitly through
+    **name** *OBJECT_NAME* parameter. The following custom functions are
+    provided (assuming **example** as the object name):
+
+    - **example__open** and **example__open_opts**.
+      These functions are used to instantiate skeleton. It corresponds to
+      libbpf's **bpf_object__open**\ () API. **_opts** variants accepts extra
+      **bpf_object_open_opts** options.
+
+    - **example__load**.
+      This function creates maps, loads and verifies BPF programs, initializes
+      global data maps. It corresponds to libppf's **bpf_object__load**\ ()
+      API.
+
+    - **example__open_and_load** combines **example__open** and
+      **example__load** invocations in one commonly used operation.
+
+    - **example__attach** and **example__detach**
+      This pair of functions allow to attach and detach, correspondingly,
+      already loaded BPF object. Only BPF programs of types supported by libbpf
+      for auto-attachment will be auto-attached and their corresponding BPF
+      links instantiated. For other BPF programs, user can manually create a
+      BPF link and assign it to corresponding fields in skeleton struct.
+      **example__detach** will detach both links created automatically, as well
+      as those populated by user manually.
+
+    - **example__destroy**
+      Detach and unload BPF programs, free up all the resources used by
+      skeleton and BPF object.
+
+    If BPF object has global variables, corresponding structs with memory
+    layout corresponding to global data data section layout will be created.
+    Currently supported ones are: *.data*, *.bss*, *.rodata*, and *.kconfig*
+    structs/data sections. These data sections/structs can be used to set up
+    initial values of variables, if set before **example__load**. Afterwards,
+    if target kernel supports memory-mapped BPF arrays, same structs can be
+    used to fetch and update (non-read-only) data from userspace, with same
+    simplicity as for BPF side.
+
+**bpftool gen subskeleton** *FILE*
+    Generate BPF subskeleton C header file for a given *FILE*.
+
+    Subskeletons are similar to skeletons, except they do not own the
+    corresponding maps, programs, or global variables. They require that the
+    object file used to generate them is already loaded into a *bpf_object* by
+    some other means.
+
+    This functionality is useful when a library is included into a larger BPF
+    program. A subskeleton for the library would have access to all objects and
+    globals defined in it, without having to know about the larger program.
+
+    Consequently, there are only two functions defined for subskeletons:
+
+    - **example__open(bpf_object\*)**
+      Instantiates a subskeleton from an already opened (but not necessarily
+      loaded) **bpf_object**.
+
+    - **example__destroy()**
+      Frees the storage for the subskeleton but *does not* unload any BPF
+      programs or maps.
+
+**bpftool** **gen min_core_btf** *INPUT* *OUTPUT* *OBJECT* [*OBJECT*...]
+    Generate a minimum BTF file as *OUTPUT*, derived from a given *INPUT* BTF
+    file, containing all needed BTF types so one, or more, given eBPF objects
+    CO-RE relocations may be satisfied.
+
+    When kernels aren't compiled with CONFIG_DEBUG_INFO_BTF, libbpf, when
+    loading an eBPF object, has to rely on external BTF files to be able to
+    calculate CO-RE relocations.
+
+    Usually, an external BTF file is built from existing kernel DWARF data
+    using pahole. It contains all the types used by its respective kernel image
+    and, because of that, is big.
+
+    The min_core_btf feature builds smaller BTF files, customized to one or
+    multiple eBPF objects, so they can be distributed together with an eBPF
+    CO-RE based application, turning the application portable to different
+    kernel versions.
+
+    Check examples bellow for more information how to use it.
+
+**bpftool gen help**
+    Print short help message.
 
 OPTIONS
 =======
-	.. include:: common_options.rst
+.. include:: common_options.rst
 
-	-L, --use-loader
-		  For skeletons, generate a "light" skeleton (also known as "loader"
-		  skeleton). A light skeleton contains a loader eBPF program. It does
-		  not use the majority of the libbpf infrastructure, and does not need
-		  libelf.
+-L, --use-loader
+    For skeletons, generate a "light" skeleton (also known as "loader"
+    skeleton). A light skeleton contains a loader eBPF program. It does not use
+    the majority of the libbpf infrastructure, and does not need libelf.
 
 EXAMPLES
 ========
diff --git a/tools/bpf/bpftool/Documentation/bpftool-iter.rst b/tools/bpf/bpftool/Documentation/bpftool-iter.rst
index 84839d488621..af17cc0201d4 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-iter.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-iter.rst
@@ -14,50 +14,46 @@ tool to create BPF iterators
 SYNOPSIS
 ========
 
-	**bpftool** [*OPTIONS*] **iter** *COMMAND*
+**bpftool** [*OPTIONS*] **iter** *COMMAND*
 
-	*OPTIONS* := { |COMMON_OPTIONS| }
+*OPTIONS* := { |COMMON_OPTIONS| }
 
-	*COMMANDS* := { **pin** | **help** }
+*COMMANDS* := { **pin** | **help** }
 
 ITER COMMANDS
 ===================
 
-|	**bpftool** **iter pin** *OBJ* *PATH* [**map** *MAP*]
-|	**bpftool** **iter help**
+| **bpftool** **iter pin** *OBJ* *PATH* [**map** *MAP*]
+| **bpftool** **iter help**
 |
-|	*OBJ* := /a/file/of/bpf_iter_target.o
-|	*MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
+| *OBJ* := /a/file/of/bpf_iter_target.o
+| *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
 
 DESCRIPTION
 ===========
-	**bpftool iter pin** *OBJ* *PATH* [**map** *MAP*]
-		  A bpf iterator combines a kernel iterating of
-		  particular kernel data (e.g., tasks, bpf_maps, etc.)
-		  and a bpf program called for each kernel data object
-		  (e.g., one task, one bpf_map, etc.). User space can
-		  *read* kernel iterator output through *read()* syscall.
+**bpftool iter pin** *OBJ* *PATH* [**map** *MAP*]
+    A bpf iterator combines a kernel iterating of particular kernel data (e.g.,
+    tasks, bpf_maps, etc.) and a bpf program called for each kernel data object
+    (e.g., one task, one bpf_map, etc.). User space can *read* kernel iterator
+    output through *read()* syscall.
 
-		  The *pin* command creates a bpf iterator from *OBJ*,
-		  and pin it to *PATH*. The *PATH* should be located
-		  in *bpffs* mount. It must not contain a dot
-		  character ('.'), which is reserved for future extensions
-		  of *bpffs*.
+    The *pin* command creates a bpf iterator from *OBJ*, and pin it to *PATH*.
+    The *PATH* should be located in *bpffs* mount. It must not contain a dot
+    character ('.'), which is reserved for future extensions of *bpffs*.
 
-		  Map element bpf iterator requires an additional parameter
-		  *MAP* so bpf program can iterate over map elements for
-		  that map. User can have a bpf program in kernel to run
-		  with each map element, do checking, filtering, aggregation,
-		  etc. without copying data to user space.
+    Map element bpf iterator requires an additional parameter *MAP* so bpf
+    program can iterate over map elements for that map. User can have a bpf
+    program in kernel to run with each map element, do checking, filtering,
+    aggregation, etc. without copying data to user space.
 
-		  User can then *cat PATH* to see the bpf iterator output.
+    User can then *cat PATH* to see the bpf iterator output.
 
-	**bpftool iter help**
-		  Print short help message.
+**bpftool iter help**
+    Print short help message.
 
 OPTIONS
 =======
-	.. include:: common_options.rst
+.. include:: common_options.rst
 
 EXAMPLES
 ========
diff --git a/tools/bpf/bpftool/Documentation/bpftool-link.rst b/tools/bpf/bpftool/Documentation/bpftool-link.rst
index 52a4eee4af54..6d39ad890fea 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-link.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-link.rst
@@ -14,67 +14,62 @@ tool for inspection and simple manipulation of eBPF links
 SYNOPSIS
 ========
 
-	**bpftool** [*OPTIONS*] **link** *COMMAND*
+**bpftool** [*OPTIONS*] **link** *COMMAND*
 
-	*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } | { **-n** | **--nomount** } }
+*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } | { **-n** | **--nomount** } }
 
-	*COMMANDS* := { **show** | **list** | **pin** | **help** }
+*COMMANDS* := { **show** | **list** | **pin** | **help** }
 
 LINK COMMANDS
 =============
 
-|	**bpftool** **link { show | list }** [*LINK*]
-|	**bpftool** **link pin** *LINK* *FILE*
-|	**bpftool** **link detach** *LINK*
-|	**bpftool** **link help**
+| **bpftool** **link { show | list }** [*LINK*]
+| **bpftool** **link pin** *LINK* *FILE*
+| **bpftool** **link detach** *LINK*
+| **bpftool** **link help**
 |
-|	*LINK* := { **id** *LINK_ID* | **pinned** *FILE* }
+| *LINK* := { **id** *LINK_ID* | **pinned** *FILE* }
 
 
 DESCRIPTION
 ===========
-	**bpftool link { show | list }** [*LINK*]
-		  Show information about active links. If *LINK* is
-		  specified show information only about given link,
-		  otherwise list all links currently active on the system.
+**bpftool link { show | list }** [*LINK*]
+    Show information about active links. If *LINK* is specified show
+    information only about given link, otherwise list all links currently
+    active on the system.
 
-		  Output will start with link ID followed by link type and
-		  zero or more named attributes, some of which depend on type
-		  of link.
+    Output will start with link ID followed by link type and zero or more named
+    attributes, some of which depend on type of link.
 
-		  Since Linux 5.8 bpftool is able to discover information about
-		  processes that hold open file descriptors (FDs) against BPF
-		  links. On such kernels bpftool will automatically emit this
-		  information as well.
+    Since Linux 5.8 bpftool is able to discover information about processes
+    that hold open file descriptors (FDs) against BPF links. On such kernels
+    bpftool will automatically emit this information as well.
 
-	**bpftool link pin** *LINK* *FILE*
-		  Pin link *LINK* as *FILE*.
+**bpftool link pin** *LINK* *FILE*
+    Pin link *LINK* as *FILE*.
 
-		  Note: *FILE* must be located in *bpffs* mount. It must not
-		  contain a dot character ('.'), which is reserved for future
-		  extensions of *bpffs*.
+    Note: *FILE* must be located in *bpffs* mount. It must not contain a dot
+    character ('.'), which is reserved for future extensions of *bpffs*.
 
-	**bpftool link detach** *LINK*
-		  Force-detach link *LINK*. BPF link and its underlying BPF
-		  program will stay valid, but they will be detached from the
-		  respective BPF hook and BPF link will transition into
-		  a defunct state until last open file descriptor for that
-		  link is closed.
+**bpftool link detach** *LINK*
+    Force-detach link *LINK*. BPF link and its underlying BPF program will stay
+    valid, but they will be detached from the respective BPF hook and BPF link
+    will transition into a defunct state until last open file descriptor for
+    that link is closed.
 
-	**bpftool link help**
-		  Print short help message.
+**bpftool link help**
+    Print short help message.
 
 OPTIONS
 =======
-	.. include:: common_options.rst
+    .. include:: common_options.rst
 
-	-f, --bpffs
-		  When showing BPF links, show file names of pinned
-		  links.
+    -f, --bpffs
+        When showing BPF links, show file names of pinned links.
 
-	-n, --nomount
-		  Do not automatically attempt to mount any virtual file system
-		  (such as tracefs or BPF virtual file system) when necessary.
+    -n, --nomount
+        Do not automatically attempt to mount any virtual file system (such as
+        tracefs or BPF virtual file system) when necessary.
 
 EXAMPLES
 ========
diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 9d6a314dfd7a..864257169942 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -14,166 +14,160 @@ tool for inspection and simple manipulation of eBPF maps
 SYNOPSIS
 ========
 
-	**bpftool** [*OPTIONS*] **map** *COMMAND*
+**bpftool** [*OPTIONS*] **map** *COMMAND*
 
-	*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } | { **-n** | **--nomount** } }
+*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } | { **-n** | **--nomount** } }
 
-	*COMMANDS* :=
-	{ **show** | **list** | **create** | **dump** | **update** | **lookup** | **getnext** |
-	**delete** | **pin** | **help** }
+*COMMANDS* :=
+{ **show** | **list** | **create** | **dump** | **update** | **lookup** | **getnext** |
+**delete** | **pin** | **help** }
 
 MAP COMMANDS
 =============
 
-|	**bpftool** **map** { **show** | **list** }   [*MAP*]
-|	**bpftool** **map create**     *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE* \
-|		**entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] \
-|		[**offload_dev** *NAME*]
-|	**bpftool** **map dump**       *MAP*
-|	**bpftool** **map update**     *MAP* [**key** *DATA*] [**value** *VALUE*] [*UPDATE_FLAGS*]
-|	**bpftool** **map lookup**     *MAP* [**key** *DATA*]
-|	**bpftool** **map getnext**    *MAP* [**key** *DATA*]
-|	**bpftool** **map delete**     *MAP*  **key** *DATA*
-|	**bpftool** **map pin**        *MAP*  *FILE*
-|	**bpftool** **map event_pipe** *MAP* [**cpu** *N* **index** *M*]
-|	**bpftool** **map peek**       *MAP*
-|	**bpftool** **map push**       *MAP* **value** *VALUE*
-|	**bpftool** **map pop**        *MAP*
-|	**bpftool** **map enqueue**    *MAP* **value** *VALUE*
-|	**bpftool** **map dequeue**    *MAP*
-|	**bpftool** **map freeze**     *MAP*
-|	**bpftool** **map help**
+| **bpftool** **map** { **show** | **list** }   [*MAP*]
+| **bpftool** **map create**     *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE* \
+|     **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] \
+|     [**offload_dev** *NAME*]
+| **bpftool** **map dump**       *MAP*
+| **bpftool** **map update**     *MAP* [**key** *DATA*] [**value** *VALUE*] [*UPDATE_FLAGS*]
+| **bpftool** **map lookup**     *MAP* [**key** *DATA*]
+| **bpftool** **map getnext**    *MAP* [**key** *DATA*]
+| **bpftool** **map delete**     *MAP*  **key** *DATA*
+| **bpftool** **map pin**        *MAP*  *FILE*
+| **bpftool** **map event_pipe** *MAP* [**cpu** *N* **index** *M*]
+| **bpftool** **map peek**       *MAP*
+| **bpftool** **map push**       *MAP* **value** *VALUE*
+| **bpftool** **map pop**        *MAP*
+| **bpftool** **map enqueue**    *MAP* **value** *VALUE*
+| **bpftool** **map dequeue**    *MAP*
+| **bpftool** **map freeze**     *MAP*
+| **bpftool** **map help**
 |
-|	*MAP* := { **id** *MAP_ID* | **pinned** *FILE* | **name** *MAP_NAME* }
-|	*DATA* := { [**hex**] *BYTES* }
-|	*PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
-|	*VALUE* := { *DATA* | *MAP* | *PROG* }
-|	*UPDATE_FLAGS* := { **any** | **exist** | **noexist** }
-|	*TYPE* := { **hash** | **array** | **prog_array** | **perf_event_array** | **percpu_hash**
-|		| **percpu_array** | **stack_trace** | **cgroup_array** | **lru_hash**
-|		| **lru_percpu_hash** | **lpm_trie** | **array_of_maps** | **hash_of_maps**
-|		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
-|		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
-|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
-|		| **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
+| *MAP* := { **id** *MAP_ID* | **pinned** *FILE* | **name** *MAP_NAME* }
+| *DATA* := { [**hex**] *BYTES* }
+| *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
+| *VALUE* := { *DATA* | *MAP* | *PROG* }
+| *UPDATE_FLAGS* := { **any** | **exist** | **noexist** }
+| *TYPE* := { **hash** | **array** | **prog_array** | **perf_event_array** | **percpu_hash**
+|     | **percpu_array** | **stack_trace** | **cgroup_array** | **lru_hash**
+|     | **lru_percpu_hash** | **lpm_trie** | **array_of_maps** | **hash_of_maps**
+|     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
+|     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
+|     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
+|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
 
 DESCRIPTION
 ===========
-	**bpftool map { show | list }**   [*MAP*]
-		  Show information about loaded maps.  If *MAP* is specified
-		  show information only about given maps, otherwise list all
-		  maps currently loaded on the system.  In case of **name**,
-		  *MAP* may match several maps which will all be shown.
+**bpftool map { show | list }**   [*MAP*]
+    Show information about loaded maps.  If *MAP* is specified show information
+    only about given maps, otherwise list all maps currently loaded on the
+    system.  In case of **name**, *MAP* may match several maps which will all
+    be shown.
 
-		  Output will start with map ID followed by map type and
-		  zero or more named attributes (depending on kernel version).
+    Output will start with map ID followed by map type and zero or more named
+    attributes (depending on kernel version).
 
-		  Since Linux 5.8 bpftool is able to discover information about
-		  processes that hold open file descriptors (FDs) against BPF
-		  maps. On such kernels bpftool will automatically emit this
-		  information as well.
+    Since Linux 5.8 bpftool is able to discover information about processes
+    that hold open file descriptors (FDs) against BPF maps. On such kernels
+    bpftool will automatically emit this information as well.
 
-	**bpftool map create** *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE*  **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] [**offload_dev** *NAME*]
-		  Create a new map with given parameters and pin it to *bpffs*
-		  as *FILE*.
+**bpftool map create** *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE*  **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] [**offload_dev** *NAME*]
+    Create a new map with given parameters and pin it to *bpffs* as *FILE*.
 
-		  *FLAGS* should be an integer which is the combination of
-		  desired flags, e.g. 1024 for **BPF_F_MMAPABLE** (see bpf.h
-		  UAPI header for existing flags).
+    *FLAGS* should be an integer which is the combination of desired flags,
+    e.g. 1024 for **BPF_F_MMAPABLE** (see bpf.h UAPI header for existing
+    flags).
 
-		  To create maps of type array-of-maps or hash-of-maps, the
-		  **inner_map** keyword must be used to pass an inner map. The
-		  kernel needs it to collect metadata related to the inner maps
-		  that the new map will work with.
+    To create maps of type array-of-maps or hash-of-maps, the **inner_map**
+    keyword must be used to pass an inner map. The kernel needs it to collect
+    metadata related to the inner maps that the new map will work with.
 
-		  Keyword **offload_dev** expects a network interface name,
-		  and is used to request hardware offload for the map.
+    Keyword **offload_dev** expects a network interface name, and is used to
+    request hardware offload for the map.
 
-	**bpftool map dump**    *MAP*
-		  Dump all entries in a given *MAP*.  In case of **name**,
-		  *MAP* may match several maps which will all be dumped.
+**bpftool map dump**    *MAP*
+    Dump all entries in a given *MAP*.  In case of **name**, *MAP* may match
+    several maps which will all be dumped.
 
-	**bpftool map update**  *MAP* [**key** *DATA*] [**value** *VALUE*] [*UPDATE_FLAGS*]
-		  Update map entry for a given *KEY*.
+**bpftool map update**  *MAP* [**key** *DATA*] [**value** *VALUE*] [*UPDATE_FLAGS*]
+    Update map entry for a given *KEY*.
 
-		  *UPDATE_FLAGS* can be one of: **any** update existing entry
-		  or add if doesn't exit; **exist** update only if entry already
-		  exists; **noexist** update only if entry doesn't exist.
+    *UPDATE_FLAGS* can be one of: **any** update existing entry or add if
+    doesn't exit; **exist** update only if entry already exists; **noexist**
+    update only if entry doesn't exist.
 
-		  If the **hex** keyword is provided in front of the bytes
-		  sequence, the bytes are parsed as hexadecimal values, even if
-		  no "0x" prefix is added. If the keyword is not provided, then
-		  the bytes are parsed as decimal values, unless a "0x" prefix
-		  (for hexadecimal) or a "0" prefix (for octal) is provided.
+    If the **hex** keyword is provided in front of the bytes sequence, the
+    bytes are parsed as hexadecimal values, even if no "0x" prefix is added. If
+    the keyword is not provided, then the bytes are parsed as decimal values,
+    unless a "0x" prefix (for hexadecimal) or a "0" prefix (for octal) is
+    provided.
 
-	**bpftool map lookup**  *MAP* [**key** *DATA*]
-		  Lookup **key** in the map.
+**bpftool map lookup**  *MAP* [**key** *DATA*]
+    Lookup **key** in the map.
 
-	**bpftool map getnext** *MAP* [**key** *DATA*]
-		  Get next key.  If *key* is not specified, get first key.
+**bpftool map getnext** *MAP* [**key** *DATA*]
+    Get next key.  If *key* is not specified, get first key.
 
-	**bpftool map delete**  *MAP*  **key** *DATA*
-		  Remove entry from the map.
+**bpftool map delete**  *MAP*  **key** *DATA*
+    Remove entry from the map.
 
-	**bpftool map pin**     *MAP*  *FILE*
-		  Pin map *MAP* as *FILE*.
+**bpftool map pin**     *MAP*  *FILE*
+    Pin map *MAP* as *FILE*.
 
-		  Note: *FILE* must be located in *bpffs* mount. It must not
-		  contain a dot character ('.'), which is reserved for future
-		  extensions of *bpffs*.
+    Note: *FILE* must be located in *bpffs* mount. It must not contain a dot
+    character ('.'), which is reserved for future extensions of *bpffs*.
 
-	**bpftool** **map event_pipe** *MAP* [**cpu** *N* **index** *M*]
-		  Read events from a **BPF_MAP_TYPE_PERF_EVENT_ARRAY** map.
+**bpftool** **map event_pipe** *MAP* [**cpu** *N* **index** *M*]
+    Read events from a **BPF_MAP_TYPE_PERF_EVENT_ARRAY** map.
 
-		  Install perf rings into a perf event array map and dump
-		  output of any **bpf_perf_event_output**\ () call in the kernel.
-		  By default read the number of CPUs on the system and
-		  install perf ring for each CPU in the corresponding index
-		  in the array.
+    Install perf rings into a perf event array map and dump output of any
+    **bpf_perf_event_output**\ () call in the kernel. By default read the
+    number of CPUs on the system and install perf ring for each CPU in the
+    corresponding index in the array.
 
-		  If **cpu** and **index** are specified, install perf ring
-		  for given **cpu** at **index** in the array (single ring).
+    If **cpu** and **index** are specified, install perf ring for given **cpu**
+    at **index** in the array (single ring).
 
-		  Note that installing a perf ring into an array will silently
-		  replace any existing ring.  Any other application will stop
-		  receiving events if it installed its rings earlier.
+    Note that installing a perf ring into an array will silently replace any
+    existing ring.  Any other application will stop receiving events if it
+    installed its rings earlier.
 
-	**bpftool map peek**  *MAP*
-		  Peek next value in the queue or stack.
+**bpftool map peek**  *MAP*
+    Peek next value in the queue or stack.
 
-	**bpftool map push**  *MAP* **value** *VALUE*
-		  Push *VALUE* onto the stack.
+**bpftool map push**  *MAP* **value** *VALUE*
+    Push *VALUE* onto the stack.
 
-	**bpftool map pop**  *MAP*
-		  Pop and print value from the stack.
+**bpftool map pop**  *MAP*
+    Pop and print value from the stack.
 
-	**bpftool map enqueue**  *MAP* **value** *VALUE*
-		  Enqueue *VALUE* into the queue.
+**bpftool map enqueue**  *MAP* **value** *VALUE*
+    Enqueue *VALUE* into the queue.
 
-	**bpftool map dequeue**  *MAP*
-		  Dequeue and print value from the queue.
+**bpftool map dequeue**  *MAP*
+    Dequeue and print value from the queue.
 
-	**bpftool map freeze**  *MAP*
-		  Freeze the map as read-only from user space. Entries from a
-		  frozen map can not longer be updated or deleted with the
-		  **bpf**\ () system call. This operation is not reversible,
-		  and the map remains immutable from user space until its
-		  destruction. However, read and write permissions for BPF
-		  programs to the map remain unchanged.
+**bpftool map freeze**  *MAP*
+    Freeze the map as read-only from user space. Entries from a frozen map can
+    not longer be updated or deleted with the **bpf**\ () system call. This
+    operation is not reversible, and the map remains immutable from user space
+    until its destruction. However, read and write permissions for BPF programs
+    to the map remain unchanged.
 
-	**bpftool map help**
-		  Print short help message.
+**bpftool map help**
+    Print short help message.
 
 OPTIONS
 =======
-	.. include:: common_options.rst
+.. include:: common_options.rst
 
-	-f, --bpffs
-		  Show file names of pinned maps.
+-f, --bpffs
+    Show file names of pinned maps.
 
-	-n, --nomount
-		  Do not automatically attempt to mount any virtual file system
-		  (such as tracefs or BPF virtual file system) when necessary.
+-n, --nomount
+    Do not automatically attempt to mount any virtual file system (such as
+    tracefs or BPF virtual file system) when necessary.
 
 EXAMPLES
 ========
diff --git a/tools/bpf/bpftool/Documentation/bpftool-net.rst b/tools/bpf/bpftool/Documentation/bpftool-net.rst
index dd3f9469765b..43d2c858fdf8 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-net.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-net.rst
@@ -14,76 +14,74 @@ tool for inspection of networking related bpf prog attachments
 SYNOPSIS
 ========
 
-	**bpftool** [*OPTIONS*] **net** *COMMAND*
+**bpftool** [*OPTIONS*] **net** *COMMAND*
 
-	*OPTIONS* := { |COMMON_OPTIONS| }
+*OPTIONS* := { |COMMON_OPTIONS| }
 
-	*COMMANDS* :=
-	{ **show** | **list** | **attach** | **detach** | **help** }
+*COMMANDS* := { **show** | **list** | **attach** | **detach** | **help** }
 
 NET COMMANDS
 ============
 
-|	**bpftool** **net** { **show** | **list** } [ **dev** *NAME* ]
-|	**bpftool** **net attach** *ATTACH_TYPE* *PROG* **dev** *NAME* [ **overwrite** ]
-|	**bpftool** **net detach** *ATTACH_TYPE* **dev** *NAME*
-|	**bpftool** **net help**
+| **bpftool** **net** { **show** | **list** } [ **dev** *NAME* ]
+| **bpftool** **net attach** *ATTACH_TYPE* *PROG* **dev** *NAME* [ **overwrite** ]
+| **bpftool** **net detach** *ATTACH_TYPE* **dev** *NAME*
+| **bpftool** **net help**
 |
-|	*PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
-|	*ATTACH_TYPE* := { **xdp** | **xdpgeneric** | **xdpdrv** | **xdpoffload** }
+| *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
+| *ATTACH_TYPE* := { **xdp** | **xdpgeneric** | **xdpdrv** | **xdpoffload** }
 
 DESCRIPTION
 ===========
-	**bpftool net { show | list }** [ **dev** *NAME* ]
-		  List bpf program attachments in the kernel networking subsystem.
+**bpftool net { show | list }** [ **dev** *NAME* ]
+    List bpf program attachments in the kernel networking subsystem.
 
-		  Currently, device driver xdp attachments, tcx, netkit and old-style tc
-		  classifier/action attachments, flow_dissector as well as netfilter
-		  attachments are implemented, i.e., for
-		  program types **BPF_PROG_TYPE_XDP**, **BPF_PROG_TYPE_SCHED_CLS**,
-		  **BPF_PROG_TYPE_SCHED_ACT**, **BPF_PROG_TYPE_FLOW_DISSECTOR**,
-		  **BPF_PROG_TYPE_NETFILTER**.
+    Currently, device driver xdp attachments, tcx, netkit and old-style tc
+    classifier/action attachments, flow_dissector as well as netfilter
+    attachments are implemented, i.e., for program types **BPF_PROG_TYPE_XDP**,
+    **BPF_PROG_TYPE_SCHED_CLS**, **BPF_PROG_TYPE_SCHED_ACT**,
+    **BPF_PROG_TYPE_FLOW_DISSECTOR**, **BPF_PROG_TYPE_NETFILTER**.
 
-		  For programs attached to a particular cgroup, e.g.,
-		  **BPF_PROG_TYPE_CGROUP_SKB**, **BPF_PROG_TYPE_CGROUP_SOCK**,
-		  **BPF_PROG_TYPE_SOCK_OPS** and **BPF_PROG_TYPE_CGROUP_SOCK_ADDR**,
-		  users can use **bpftool cgroup** to dump cgroup attachments.
-		  For sk_{filter, skb, msg, reuseport} and lwt/seg6
-		  bpf programs, users should consult other tools, e.g., iproute2.
+    For programs attached to a particular cgroup, e.g.,
+    **BPF_PROG_TYPE_CGROUP_SKB**, **BPF_PROG_TYPE_CGROUP_SOCK**,
+    **BPF_PROG_TYPE_SOCK_OPS** and **BPF_PROG_TYPE_CGROUP_SOCK_ADDR**, users
+    can use **bpftool cgroup** to dump cgroup attachments. For sk_{filter, skb,
+    msg, reuseport} and lwt/seg6 bpf programs, users should consult other
+    tools, e.g., iproute2.
 
-		  The current output will start with all xdp program attachments, followed by
-		  all tcx, netkit, then tc class/qdisc bpf program attachments, then flow_dissector
-		  and finally netfilter programs. Both xdp programs and tcx/netkit/tc programs are
-		  ordered based on ifindex number. If multiple bpf programs attached
-		  to the same networking device through **tc**, the order will be first
-		  all bpf programs attached to tcx, netkit, then tc classes, then all bpf programs
-		  attached to non clsact qdiscs, and finally all bpf programs attached
-		  to root and clsact qdisc.
+    The current output will start with all xdp program attachments, followed by
+    all tcx, netkit, then tc class/qdisc bpf program attachments, then
+    flow_dissector and finally netfilter programs. Both xdp programs and
+    tcx/netkit/tc programs are ordered based on ifindex number. If multiple bpf
+    programs attached to the same networking device through **tc**, the order
+    will be first all bpf programs attached to tcx, netkit, then tc classes,
+    then all bpf programs attached to non clsact qdiscs, and finally all bpf
+    programs attached to root and clsact qdisc.
 
-	**bpftool** **net attach** *ATTACH_TYPE* *PROG* **dev** *NAME* [ **overwrite** ]
-		  Attach bpf program *PROG* to network interface *NAME* with
-		  type specified by *ATTACH_TYPE*. Previously attached bpf program
-		  can be replaced by the command used with **overwrite** option.
-		  Currently, only XDP-related modes are supported for *ATTACH_TYPE*.
+**bpftool** **net attach** *ATTACH_TYPE* *PROG* **dev** *NAME* [ **overwrite** ]
+    Attach bpf program *PROG* to network interface *NAME* with type specified
+    by *ATTACH_TYPE*. Previously attached bpf program can be replaced by the
+    command used with **overwrite** option. Currently, only XDP-related modes
+    are supported for *ATTACH_TYPE*.
 
-		  *ATTACH_TYPE* can be of:
-		  **xdp** - try native XDP and fallback to generic XDP if NIC driver does not support it;
-		  **xdpgeneric** - Generic XDP. runs at generic XDP hook when packet already enters receive path as skb;
-		  **xdpdrv** - Native XDP. runs earliest point in driver's receive path;
-		  **xdpoffload** - Offload XDP. runs directly on NIC on each packet reception;
+    *ATTACH_TYPE* can be of:
+    **xdp** - try native XDP and fallback to generic XDP if NIC driver does not support it;
+    **xdpgeneric** - Generic XDP. runs at generic XDP hook when packet already enters receive path as skb;
+    **xdpdrv** - Native XDP. runs earliest point in driver's receive path;
+    **xdpoffload** - Offload XDP. runs directly on NIC on each packet reception;
 
-	**bpftool** **net detach** *ATTACH_TYPE* **dev** *NAME*
-		  Detach bpf program attached to network interface *NAME* with
-		  type specified by *ATTACH_TYPE*. To detach bpf program, same
-		  *ATTACH_TYPE* previously used for attach must be specified.
-		  Currently, only XDP-related modes are supported for *ATTACH_TYPE*.
+**bpftool** **net detach** *ATTACH_TYPE* **dev** *NAME*
+    Detach bpf program attached to network interface *NAME* with type specified
+    by *ATTACH_TYPE*. To detach bpf program, same *ATTACH_TYPE* previously used
+    for attach must be specified. Currently, only XDP-related modes are
+    supported for *ATTACH_TYPE*.
 
-	**bpftool net help**
-		  Print short help message.
+**bpftool net help**
+    Print short help message.
 
 OPTIONS
 =======
-	.. include:: common_options.rst
+.. include:: common_options.rst
 
 EXAMPLES
 ========
diff --git a/tools/bpf/bpftool/Documentation/bpftool-perf.rst b/tools/bpf/bpftool/Documentation/bpftool-perf.rst
index 5fea633a82f1..841789e30acd 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-perf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-perf.rst
@@ -14,37 +14,37 @@ tool for inspection of perf related bpf prog attachments
 SYNOPSIS
 ========
 
-	**bpftool** [*OPTIONS*] **perf** *COMMAND*
+**bpftool** [*OPTIONS*] **perf** *COMMAND*
 
-	*OPTIONS* := { |COMMON_OPTIONS| }
+*OPTIONS* := { |COMMON_OPTIONS| }
 
-	*COMMANDS* :=
-	{ **show** | **list** | **help** }
+*COMMANDS* :=
+{ **show** | **list** | **help** }
 
 PERF COMMANDS
 =============
 
-|	**bpftool** **perf** { **show** | **list** }
-|	**bpftool** **perf help**
+| **bpftool** **perf** { **show** | **list** }
+| **bpftool** **perf help**
 
 DESCRIPTION
 ===========
-	**bpftool perf { show | list }**
-		  List all raw_tracepoint, tracepoint, kprobe attachment in the system.
+**bpftool perf { show | list }**
+    List all raw_tracepoint, tracepoint, kprobe attachment in the system.
 
-		  Output will start with process id and file descriptor in that process,
-		  followed by bpf program id, attachment information, and attachment point.
-		  The attachment point for raw_tracepoint/tracepoint is the trace probe name.
-		  The attachment point for k[ret]probe is either symbol name and offset,
-		  or a kernel virtual address.
-		  The attachment point for u[ret]probe is the file name and the file offset.
+    Output will start with process id and file descriptor in that process,
+    followed by bpf program id, attachment information, and attachment point.
+    The attachment point for raw_tracepoint/tracepoint is the trace probe name.
+    The attachment point for k[ret]probe is either symbol name and offset, or a
+    kernel virtual address. The attachment point for u[ret]probe is the file
+    name and the file offset.
 
-	**bpftool perf help**
-		  Print short help message.
+**bpftool perf help**
+    Print short help message.
 
 OPTIONS
 =======
-	.. include:: common_options.rst
+.. include:: common_options.rst
 
 EXAMPLES
 ========
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 58e6a5b10ef7..cc456d357db3 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -14,250 +14,226 @@ tool for inspection and simple manipulation of eBPF progs
 SYNOPSIS
 ========
 
-	**bpftool** [*OPTIONS*] **prog** *COMMAND*
+**bpftool** [*OPTIONS*] **prog** *COMMAND*
 
-	*OPTIONS* := { |COMMON_OPTIONS| |
-	{ **-f** | **--bpffs** } | { **-m** | **--mapcompat** } | { **-n** | **--nomount** } |
-	{ **-L** | **--use-loader** } }
+*OPTIONS* := { |COMMON_OPTIONS| |
+{ **-f** | **--bpffs** } | { **-m** | **--mapcompat** } | { **-n** | **--nomount** } |
+{ **-L** | **--use-loader** } }
 
-	*COMMANDS* :=
-	{ **show** | **list** | **dump xlated** | **dump jited** | **pin** | **load** |
-	**loadall** | **help** }
+*COMMANDS* :=
+{ **show** | **list** | **dump xlated** | **dump jited** | **pin** | **load** |
+**loadall** | **help** }
 
 PROG COMMANDS
 =============
 
-|	**bpftool** **prog** { **show** | **list** } [*PROG*]
-|	**bpftool** **prog dump xlated** *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] [**visual**] }]
-|	**bpftool** **prog dump jited**  *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] }]
-|	**bpftool** **prog pin** *PROG* *FILE*
-|	**bpftool** **prog** { **load** | **loadall** } *OBJ* *PATH* [**type** *TYPE*] [**map** { **idx** *IDX* | **name** *NAME* } *MAP*] [{ **offload_dev** | **xdpmeta_dev** } *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
-|	**bpftool** **prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
-|	**bpftool** **prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
-|	**bpftool** **prog tracelog**
-|	**bpftool** **prog run** *PROG* **data_in** *FILE* [**data_out** *FILE* [**data_size_out** *L*]] [**ctx_in** *FILE* [**ctx_out** *FILE* [**ctx_size_out** *M*]]] [**repeat** *N*]
-|	**bpftool** **prog profile** *PROG* [**duration** *DURATION*] *METRICs*
-|	**bpftool** **prog help**
+| **bpftool** **prog** { **show** | **list** } [*PROG*]
+| **bpftool** **prog dump xlated** *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] [**visual**] }]
+| **bpftool** **prog dump jited**  *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] }]
+| **bpftool** **prog pin** *PROG* *FILE*
+| **bpftool** **prog** { **load** | **loadall** } *OBJ* *PATH* [**type** *TYPE*] [**map** { **idx** *IDX* | **name** *NAME* } *MAP*] [{ **offload_dev** | **xdpmeta_dev** } *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
+| **bpftool** **prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
+| **bpftool** **prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
+| **bpftool** **prog tracelog**
+| **bpftool** **prog run** *PROG* **data_in** *FILE* [**data_out** *FILE* [**data_size_out** *L*]] [**ctx_in** *FILE* [**ctx_out** *FILE* [**ctx_size_out** *M*]]] [**repeat** *N*]
+| **bpftool** **prog profile** *PROG* [**duration** *DURATION*] *METRICs*
+| **bpftool** **prog help**
 |
-|	*MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
-|	*PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
-|	*TYPE* := {
-|		**socket** | **kprobe** | **kretprobe** | **classifier** | **action** |
-|		**tracepoint** | **raw_tracepoint** | **xdp** | **perf_event** | **cgroup/skb** |
-|		**cgroup/sock** | **cgroup/dev** | **lwt_in** | **lwt_out** | **lwt_xmit** |
-|		**lwt_seg6local** | **sockops** | **sk_skb** | **sk_msg** | **lirc_mode2** |
-|		**cgroup/bind4** | **cgroup/bind6** | **cgroup/post_bind4** | **cgroup/post_bind6** |
-|		**cgroup/connect4** | **cgroup/connect6** | **cgroup/connect_unix** |
-|		**cgroup/getpeername4** | **cgroup/getpeername6** | **cgroup/getpeername_unix** |
-|		**cgroup/getsockname4** | **cgroup/getsockname6** | **cgroup/getsockname_unix** |
-|		**cgroup/sendmsg4** | **cgroup/sendmsg6** | **cgroup/sendmsg_unix** |
-|		**cgroup/recvmsg4** | **cgroup/recvmsg6** | **cgroup/recvmsg_unix** | **cgroup/sysctl** |
-|		**cgroup/getsockopt** | **cgroup/setsockopt** | **cgroup/sock_release** |
-|		**struct_ops** | **fentry** | **fexit** | **freplace** | **sk_lookup**
-|	}
-|	*ATTACH_TYPE* := {
-|		**sk_msg_verdict** | **sk_skb_verdict** | **sk_skb_stream_verdict** |
-|		**sk_skb_stream_parser** | **flow_dissector**
-|	}
-|	*METRICs* := {
-|		**cycles** | **instructions** | **l1d_loads** | **llc_misses** |
-|		**itlb_misses** | **dtlb_misses**
-|	}
+| *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
+| *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
+| *TYPE* := {
+|     **socket** | **kprobe** | **kretprobe** | **classifier** | **action** |
+|     **tracepoint** | **raw_tracepoint** | **xdp** | **perf_event** | **cgroup/skb** |
+|     **cgroup/sock** | **cgroup/dev** | **lwt_in** | **lwt_out** | **lwt_xmit** |
+|     **lwt_seg6local** | **sockops** | **sk_skb** | **sk_msg** | **lirc_mode2** |
+|     **cgroup/bind4** | **cgroup/bind6** | **cgroup/post_bind4** | **cgroup/post_bind6** |
+|     **cgroup/connect4** | **cgroup/connect6** | **cgroup/connect_unix** |
+|     **cgroup/getpeername4** | **cgroup/getpeername6** | **cgroup/getpeername_unix** |
+|     **cgroup/getsockname4** | **cgroup/getsockname6** | **cgroup/getsockname_unix** |
+|     **cgroup/sendmsg4** | **cgroup/sendmsg6** | **cgroup/sendmsg_unix** |
+|     **cgroup/recvmsg4** | **cgroup/recvmsg6** | **cgroup/recvmsg_unix** | **cgroup/sysctl** |
+|     **cgroup/getsockopt** | **cgroup/setsockopt** | **cgroup/sock_release** |
+|     **struct_ops** | **fentry** | **fexit** | **freplace** | **sk_lookup**
+| }
+| *ATTACH_TYPE* := {
+|     **sk_msg_verdict** | **sk_skb_verdict** | **sk_skb_stream_verdict** |
+|     **sk_skb_stream_parser** | **flow_dissector**
+| }
+| *METRICs* := {
+|     **cycles** | **instructions** | **l1d_loads** | **llc_misses** |
+|     **itlb_misses** | **dtlb_misses**
+| }
 
 
 DESCRIPTION
 ===========
-	**bpftool prog { show | list }** [*PROG*]
-		  Show information about loaded programs.  If *PROG* is
-		  specified show information only about given programs,
-		  otherwise list all programs currently loaded on the system.
-		  In case of **tag** or **name**, *PROG* may match several
-		  programs which will all be shown.
-
-		  Output will start with program ID followed by program type and
-		  zero or more named attributes (depending on kernel version).
-
-		  Since Linux 5.1 the kernel can collect statistics on BPF
-		  programs (such as the total time spent running the program,
-		  and the number of times it was run). If available, bpftool
-		  shows such statistics. However, the kernel does not collect
-		  them by defaults, as it slightly impacts performance on each
-		  program run. Activation or deactivation of the feature is
-		  performed via the **kernel.bpf_stats_enabled** sysctl knob.
-
-		  Since Linux 5.8 bpftool is able to discover information about
-		  processes that hold open file descriptors (FDs) against BPF
-		  programs. On such kernels bpftool will automatically emit this
-		  information as well.
-
-	**bpftool prog dump xlated** *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] [**visual**] }]
-		  Dump eBPF instructions of the programs from the kernel. By
-		  default, eBPF will be disassembled and printed to standard
-		  output in human-readable format. In this case, **opcodes**
-		  controls if raw opcodes should be printed as well.
-
-		  In case of **tag** or **name**, *PROG* may match several
-		  programs which will all be dumped.  However, if **file** or
-		  **visual** is specified, *PROG* must match a single program.
-
-		  If **file** is specified, the binary image will instead be
-		  written to *FILE*.
-
-		  If **visual** is specified, control flow graph (CFG) will be
-		  built instead, and eBPF instructions will be presented with
-		  CFG in DOT format, on standard output.
-
-		  If the programs have line_info available, the source line will
-		  be displayed.  If **linum** is specified, the filename, line
-		  number and line column will also be displayed.
-
-	**bpftool prog dump jited**  *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] }]
-		  Dump jited image (host machine code) of the program.
-
-		  If *FILE* is specified image will be written to a file,
-		  otherwise it will be disassembled and printed to stdout.
-		  *PROG* must match a single program when **file** is specified.
-
-		  **opcodes** controls if raw opcodes will be printed.
-
-		  If the prog has line_info available, the source line will
-		  be displayed.  If **linum** is specified, the filename, line
-		  number and line column will also be displayed.
-
-	**bpftool prog pin** *PROG* *FILE*
-		  Pin program *PROG* as *FILE*.
-
-		  Note: *FILE* must be located in *bpffs* mount. It must not
-		  contain a dot character ('.'), which is reserved for future
-		  extensions of *bpffs*.
-
-	**bpftool prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** { **idx** *IDX* | **name** *NAME* } *MAP*] [{ **offload_dev** | **xdpmeta_dev** } *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
-		  Load bpf program(s) from binary *OBJ* and pin as *PATH*.
-		  **bpftool prog load** pins only the first program from the
-		  *OBJ* as *PATH*. **bpftool prog loadall** pins all programs
-		  from the *OBJ* under *PATH* directory.
-		  **type** is optional, if not specified program type will be
-		  inferred from section names.
-		  By default bpftool will create new maps as declared in the ELF
-		  object being loaded.  **map** parameter allows for the reuse
-		  of existing maps.  It can be specified multiple times, each
-		  time for a different map.  *IDX* refers to index of the map
-		  to be replaced in the ELF file counting from 0, while *NAME*
-		  allows to replace a map by name.  *MAP* specifies the map to
-		  use, referring to it by **id** or through a **pinned** file.
-		  If **offload_dev** *NAME* is specified program will be loaded
-		  onto given networking device (offload).
-		  If **xdpmeta_dev** *NAME* is specified program will become
-		  device-bound without offloading, this facilitates access
-		  to XDP metadata.
-		  Optional **pinmaps** argument can be provided to pin all
-		  maps under *MAP_DIR* directory.
-
-		  If **autoattach** is specified program will be attached
-		  before pin. In that case, only the link (representing the
-		  program attached to its hook) is pinned, not the program as
-		  such, so the path won't show in **bpftool prog show -f**,
-		  only show in **bpftool link show -f**. Also, this only works
-		  when bpftool (libbpf) is able to infer all necessary
-		  information from the object file, in particular, it's not
-		  supported for all program types. If a program does not
-		  support autoattach, bpftool falls back to regular pinning
-		  for that program instead.
-
-		  Note: *PATH* must be located in *bpffs* mount. It must not
-		  contain a dot character ('.'), which is reserved for future
-		  extensions of *bpffs*.
-
-	**bpftool prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
-		  Attach bpf program *PROG* (with type specified by
-		  *ATTACH_TYPE*). Most *ATTACH_TYPEs* require a *MAP*
-		  parameter, with the exception of *flow_dissector* which is
-		  attached to current networking name space.
-
-	**bpftool prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
-		  Detach bpf program *PROG* (with type specified by
-		  *ATTACH_TYPE*). Most *ATTACH_TYPEs* require a *MAP*
-		  parameter, with the exception of *flow_dissector* which is
-		  detached from the current networking name space.
-
-	**bpftool prog tracelog**
-		  Dump the trace pipe of the system to the console (stdout).
-		  Hit <Ctrl+C> to stop printing. BPF programs can write to this
-		  trace pipe at runtime with the **bpf_trace_printk**\ () helper.
-		  This should be used only for debugging purposes. For
-		  streaming data from BPF programs to user space, one can use
-		  perf events (see also **bpftool-map**\ (8)).
-
-	**bpftool prog run** *PROG* **data_in** *FILE* [**data_out** *FILE* [**data_size_out** *L*]] [**ctx_in** *FILE* [**ctx_out** *FILE* [**ctx_size_out** *M*]]] [**repeat** *N*]
-		  Run BPF program *PROG* in the kernel testing infrastructure
-		  for BPF, meaning that the program works on the data and
-		  context provided by the user, and not on actual packets or
-		  monitored functions etc. Return value and duration for the
-		  test run are printed out to the console.
-
-		  Input data is read from the *FILE* passed with **data_in**.
-		  If this *FILE* is "**-**", input data is read from standard
-		  input. Input context, if any, is read from *FILE* passed with
-		  **ctx_in**. Again, "**-**" can be used to read from standard
-		  input, but only if standard input is not already in use for
-		  input data. If a *FILE* is passed with **data_out**, output
-		  data is written to that file. Similarly, output context is
-		  written to the *FILE* passed with **ctx_out**. For both
-		  output flows, "**-**" can be used to print to the standard
-		  output (as plain text, or JSON if relevant option was
-		  passed). If output keywords are omitted, output data and
-		  context are discarded. Keywords **data_size_out** and
-		  **ctx_size_out** are used to pass the size (in bytes) for the
-		  output buffers to the kernel, although the default of 32 kB
-		  should be more than enough for most cases.
-
-		  Keyword **repeat** is used to indicate the number of
-		  consecutive runs to perform. Note that output data and
-		  context printed to files correspond to the last of those
-		  runs. The duration printed out at the end of the runs is an
-		  average over all runs performed by the command.
-
-		  Not all program types support test run. Among those which do,
-		  not all of them can take the **ctx_in**/**ctx_out**
-		  arguments. bpftool does not perform checks on program types.
-
-	**bpftool prog profile** *PROG* [**duration** *DURATION*] *METRICs*
-		  Profile *METRICs* for bpf program *PROG* for *DURATION*
-		  seconds or until user hits <Ctrl+C>. *DURATION* is optional.
-		  If *DURATION* is not specified, the profiling will run up to
-		  **UINT_MAX** seconds.
-
-	**bpftool prog help**
-		  Print short help message.
+**bpftool prog { show | list }** [*PROG*]
+    Show information about loaded programs.  If *PROG* is specified show
+    information only about given programs, otherwise list all programs
+    currently loaded on the system. In case of **tag** or **name**, *PROG* may
+    match several programs which will all be shown.
+
+    Output will start with program ID followed by program type and zero or more
+    named attributes (depending on kernel version).
+
+    Since Linux 5.1 the kernel can collect statistics on BPF programs (such as
+    the total time spent running the program, and the number of times it was
+    run). If available, bpftool shows such statistics. However, the kernel does
+    not collect them by defaults, as it slightly impacts performance on each
+    program run. Activation or deactivation of the feature is performed via the
+    **kernel.bpf_stats_enabled** sysctl knob.
+
+    Since Linux 5.8 bpftool is able to discover information about processes
+    that hold open file descriptors (FDs) against BPF programs. On such kernels
+    bpftool will automatically emit this information as well.
+
+**bpftool prog dump xlated** *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] [**visual**] }]
+    Dump eBPF instructions of the programs from the kernel. By default, eBPF
+    will be disassembled and printed to standard output in human-readable
+    format. In this case, **opcodes** controls if raw opcodes should be printed
+    as well.
+
+    In case of **tag** or **name**, *PROG* may match several programs which
+    will all be dumped.  However, if **file** or **visual** is specified,
+    *PROG* must match a single program.
+
+    If **file** is specified, the binary image will instead be written to
+    *FILE*.
+
+    If **visual** is specified, control flow graph (CFG) will be built instead,
+    and eBPF instructions will be presented with CFG in DOT format, on standard
+    output.
+
+    If the programs have line_info available, the source line will be
+    displayed.  If **linum** is specified, the filename, line number and line
+    column will also be displayed.
+
+**bpftool prog dump jited**  *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] }]
+    Dump jited image (host machine code) of the program.
+
+    If *FILE* is specified image will be written to a file, otherwise it will
+    be disassembled and printed to stdout. *PROG* must match a single program
+    when **file** is specified.
+
+    **opcodes** controls if raw opcodes will be printed.
+
+    If the prog has line_info available, the source line will be displayed. If
+    **linum** is specified, the filename, line number and line column will also
+    be displayed.
+
+**bpftool prog pin** *PROG* *FILE*
+    Pin program *PROG* as *FILE*.
+
+    Note: *FILE* must be located in *bpffs* mount. It must not contain a dot
+    character ('.'), which is reserved for future extensions of *bpffs*.
+
+**bpftool prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** { **idx** *IDX* | **name** *NAME* } *MAP*] [{ **offload_dev** | **xdpmeta_dev** } *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
+    Load bpf program(s) from binary *OBJ* and pin as *PATH*. **bpftool prog
+    load** pins only the first program from the *OBJ* as *PATH*. **bpftool prog
+    loadall** pins all programs from the *OBJ* under *PATH* directory. **type**
+    is optional, if not specified program type will be inferred from section
+    names. By default bpftool will create new maps as declared in the ELF
+    object being loaded.  **map** parameter allows for the reuse of existing
+    maps. It can be specified multiple times, each time for a different map.
+    *IDX* refers to index of the map to be replaced in the ELF file counting
+    from 0, while *NAME* allows to replace a map by name. *MAP* specifies the
+    map to use, referring to it by **id** or through a **pinned** file. If
+    **offload_dev** *NAME* is specified program will be loaded onto given
+    networking device (offload). If **xdpmeta_dev** *NAME* is specified program
+    will become device-bound without offloading, this facilitates access to XDP
+    metadata. Optional **pinmaps** argument can be provided to pin all maps
+    under *MAP_DIR* directory.
+
+    If **autoattach** is specified program will be attached before pin. In that
+    case, only the link (representing the program attached to its hook) is
+    pinned, not the program as such, so the path won't show in **bpftool prog
+    show -f**, only show in **bpftool link show -f**. Also, this only works
+    when bpftool (libbpf) is able to infer all necessary information from the
+    object file, in particular, it's not supported for all program types. If a
+    program does not support autoattach, bpftool falls back to regular pinning
+    for that program instead.
+
+    Note: *PATH* must be located in *bpffs* mount. It must not contain a dot
+    character ('.'), which is reserved for future extensions of *bpffs*.
+
+**bpftool prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
+    Attach bpf program *PROG* (with type specified by *ATTACH_TYPE*). Most
+    *ATTACH_TYPEs* require a *MAP* parameter, with the exception of
+    *flow_dissector* which is attached to current networking name space.
+
+**bpftool prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
+    Detach bpf program *PROG* (with type specified by *ATTACH_TYPE*). Most
+    *ATTACH_TYPEs* require a *MAP* parameter, with the exception of
+    *flow_dissector* which is detached from the current networking name space.
+
+**bpftool prog tracelog**
+    Dump the trace pipe of the system to the console (stdout). Hit <Ctrl+C> to
+    stop printing. BPF programs can write to this trace pipe at runtime with
+    the **bpf_trace_printk**\ () helper. This should be used only for debugging
+    purposes. For streaming data from BPF programs to user space, one can use
+    perf events (see also **bpftool-map**\ (8)).
+
+**bpftool prog run** *PROG* **data_in** *FILE* [**data_out** *FILE* [**data_size_out** *L*]] [**ctx_in** *FILE* [**ctx_out** *FILE* [**ctx_size_out** *M*]]] [**repeat** *N*]
+    Run BPF program *PROG* in the kernel testing infrastructure for BPF,
+    meaning that the program works on the data and context provided by the
+    user, and not on actual packets or monitored functions etc. Return value
+    and duration for the test run are printed out to the console.
+
+    Input data is read from the *FILE* passed with **data_in**. If this *FILE*
+    is "**-**", input data is read from standard input. Input context, if any,
+    is read from *FILE* passed with **ctx_in**. Again, "**-**" can be used to
+    read from standard input, but only if standard input is not already in use
+    for input data. If a *FILE* is passed with **data_out**, output data is
+    written to that file. Similarly, output context is written to the *FILE*
+    passed with **ctx_out**. For both output flows, "**-**" can be used to
+    print to the standard output (as plain text, or JSON if relevant option was
+    passed). If output keywords are omitted, output data and context are
+    discarded. Keywords **data_size_out** and **ctx_size_out** are used to pass
+    the size (in bytes) for the output buffers to the kernel, although the
+    default of 32 kB should be more than enough for most cases.
+
+    Keyword **repeat** is used to indicate the number of consecutive runs to
+    perform. Note that output data and context printed to files correspond to
+    the last of those runs. The duration printed out at the end of the runs is
+    an average over all runs performed by the command.
+
+    Not all program types support test run. Among those which do, not all of
+    them can take the **ctx_in**/**ctx_out** arguments. bpftool does not
+    perform checks on program types.
+
+**bpftool prog profile** *PROG* [**duration** *DURATION*] *METRICs*
+    Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
+    user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
+    the profiling will run up to **UINT_MAX** seconds.
+
+**bpftool prog help**
+    Print short help message.
 
 OPTIONS
 =======
-	.. include:: common_options.rst
+.. include:: common_options.rst
 
-	-f, --bpffs
-		  When showing BPF programs, show file names of pinned
-		  programs.
+-f, --bpffs
+    When showing BPF programs, show file names of pinned programs.
 
-	-m, --mapcompat
-		  Allow loading maps with unknown map definitions.
+-m, --mapcompat
+    Allow loading maps with unknown map definitions.
 
-	-n, --nomount
-		  Do not automatically attempt to mount any virtual file system
-		  (such as tracefs or BPF virtual file system) when necessary.
+-n, --nomount
+    Do not automatically attempt to mount any virtual file system (such as
+    tracefs or BPF virtual file system) when necessary.
 
-	-L, --use-loader
-		  Load program as a "loader" program. This is useful to debug
-		  the generation of such programs. When this option is in
-		  use, bpftool attempts to load the programs from the object
-		  file into the kernel, but does not pin them (therefore, the
-		  *PATH* must not be provided).
+-L, --use-loader
+    Load program as a "loader" program. This is useful to debug the generation
+    of such programs. When this option is in use, bpftool attempts to load the
+    programs from the object file into the kernel, but does not pin them
+    (therefore, the *PATH* must not be provided).
 
-		  When combined with the **-d**\ \|\ **--debug** option,
-		  additional debug messages are generated, and the execution
-		  of the loader program will use the **bpf_trace_printk**\ ()
-		  helper to log each step of loading BTF, creating the maps,
-		  and loading the programs (see **bpftool prog tracelog** as
-		  a way to dump those messages).
+    When combined with the **-d**\ \|\ **--debug** option, additional debug
+    messages are generated, and the execution of the loader program will use
+    the **bpf_trace_printk**\ () helper to log each step of loading BTF,
+    creating the maps, and loading the programs (see **bpftool prog tracelog**
+    as a way to dump those messages).
 
 EXAMPLES
 ========
diff --git a/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst b/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
index 8022b5321dbe..61ec1286446c 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
@@ -14,61 +14,60 @@ tool to register/unregister/introspect BPF struct_ops
 SYNOPSIS
 ========
 
-	**bpftool** [*OPTIONS*] **struct_ops** *COMMAND*
+**bpftool** [*OPTIONS*] **struct_ops** *COMMAND*
 
-	*OPTIONS* := { |COMMON_OPTIONS| }
+*OPTIONS* := { |COMMON_OPTIONS| }
 
-	*COMMANDS* :=
-	{ **show** | **list** | **dump** | **register** | **unregister** | **help** }
+*COMMANDS* :=
+{ **show** | **list** | **dump** | **register** | **unregister** | **help** }
 
 STRUCT_OPS COMMANDS
 ===================
 
-|	**bpftool** **struct_ops { show | list }** [*STRUCT_OPS_MAP*]
-|	**bpftool** **struct_ops dump** [*STRUCT_OPS_MAP*]
-|	**bpftool** **struct_ops register** *OBJ* [*LINK_DIR*]
-|	**bpftool** **struct_ops unregister** *STRUCT_OPS_MAP*
-|	**bpftool** **struct_ops help**
+| **bpftool** **struct_ops { show | list }** [*STRUCT_OPS_MAP*]
+| **bpftool** **struct_ops dump** [*STRUCT_OPS_MAP*]
+| **bpftool** **struct_ops register** *OBJ* [*LINK_DIR*]
+| **bpftool** **struct_ops unregister** *STRUCT_OPS_MAP*
+| **bpftool** **struct_ops help**
 |
-|	*STRUCT_OPS_MAP* := { **id** *STRUCT_OPS_MAP_ID* | **name** *STRUCT_OPS_MAP_NAME* }
-|	*OBJ* := /a/file/of/bpf_struct_ops.o
+| *STRUCT_OPS_MAP* := { **id** *STRUCT_OPS_MAP_ID* | **name** *STRUCT_OPS_MAP_NAME* }
+| *OBJ* := /a/file/of/bpf_struct_ops.o
 
 
 DESCRIPTION
 ===========
-	**bpftool struct_ops { show | list }** [*STRUCT_OPS_MAP*]
-		  Show brief information about the struct_ops in the system.
-		  If *STRUCT_OPS_MAP* is specified, it shows information only
-		  for the given struct_ops.  Otherwise, it lists all struct_ops
-		  currently existing in the system.
+**bpftool struct_ops { show | list }** [*STRUCT_OPS_MAP*]
+    Show brief information about the struct_ops in the system. If
+    *STRUCT_OPS_MAP* is specified, it shows information only for the given
+    struct_ops.  Otherwise, it lists all struct_ops currently existing in the
+    system.
 
-		  Output will start with struct_ops map ID, followed by its map
-		  name and its struct_ops's kernel type.
+    Output will start with struct_ops map ID, followed by its map name and its
+    struct_ops's kernel type.
 
-	**bpftool struct_ops dump** [*STRUCT_OPS_MAP*]
-		  Dump details information about the struct_ops in the system.
-		  If *STRUCT_OPS_MAP* is specified, it dumps information only
-		  for the given struct_ops.  Otherwise, it dumps all struct_ops
-		  currently existing in the system.
+**bpftool struct_ops dump** [*STRUCT_OPS_MAP*]
+    Dump details information about the struct_ops in the system. If
+    *STRUCT_OPS_MAP* is specified, it dumps information only for the given
+    struct_ops.  Otherwise, it dumps all struct_ops currently existing in the
+    system.
 
-	**bpftool struct_ops register** *OBJ* [*LINK_DIR*]
-		  Register bpf struct_ops from *OBJ*.  All struct_ops under
-		  the ELF section ".struct_ops" and ".struct_ops.link" will
-		  be registered to its kernel subsystem.  For each
-		  struct_ops in the ".struct_ops.link" section, a link
-		  will be created.  You can give *LINK_DIR* to provide a
-		  directory path where these links will be pinned with the
-		  same name as their corresponding map name.
+**bpftool struct_ops register** *OBJ* [*LINK_DIR*]
+    Register bpf struct_ops from *OBJ*.  All struct_ops under the ELF section
+    ".struct_ops" and ".struct_ops.link" will be registered to its kernel
+    subsystem.  For each struct_ops in the ".struct_ops.link" section, a link
+    will be created.  You can give *LINK_DIR* to provide a directory path where
+    these links will be pinned with the same name as their corresponding map
+    name.
 
-	**bpftool struct_ops unregister**  *STRUCT_OPS_MAP*
-		  Unregister the *STRUCT_OPS_MAP* from the kernel subsystem.
+**bpftool struct_ops unregister**  *STRUCT_OPS_MAP*
+    Unregister the *STRUCT_OPS_MAP* from the kernel subsystem.
 
-	**bpftool struct_ops help**
-		  Print short help message.
+**bpftool struct_ops help**
+    Print short help message.
 
 OPTIONS
 =======
-	.. include:: common_options.rst
+.. include:: common_options.rst
 
 EXAMPLES
 ========
diff --git a/tools/bpf/bpftool/Documentation/bpftool.rst b/tools/bpf/bpftool/Documentation/bpftool.rst
index 09e4f2ff5658..f38ae5c40439 100644
--- a/tools/bpf/bpftool/Documentation/bpftool.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool.rst
@@ -14,57 +14,57 @@ tool for inspection and simple manipulation of eBPF programs and maps
 SYNOPSIS
 ========
 
-	**bpftool** [*OPTIONS*] *OBJECT* { *COMMAND* | **help** }
+**bpftool** [*OPTIONS*] *OBJECT* { *COMMAND* | **help** }
 
-	**bpftool** **batch file** *FILE*
+**bpftool** **batch file** *FILE*
 
-	**bpftool** **version**
+**bpftool** **version**
 
-	*OBJECT* := { **map** | **prog** | **link** | **cgroup** | **perf** | **net** | **feature** |
-	**btf** | **gen** | **struct_ops** | **iter** }
+*OBJECT* := { **map** | **prog** | **link** | **cgroup** | **perf** | **net** | **feature** |
+**btf** | **gen** | **struct_ops** | **iter** }
 
-	*OPTIONS* := { { **-V** | **--version** } | |COMMON_OPTIONS| }
+*OPTIONS* := { { **-V** | **--version** } | |COMMON_OPTIONS| }
 
-	*MAP-COMMANDS* :=
-	{ **show** | **list** | **create** | **dump** | **update** | **lookup** | **getnext** |
-	**delete** | **pin** | **event_pipe** | **help** }
+*MAP-COMMANDS* :=
+{ **show** | **list** | **create** | **dump** | **update** | **lookup** | **getnext** |
+**delete** | **pin** | **event_pipe** | **help** }
 
-	*PROG-COMMANDS* := { **show** | **list** | **dump jited** | **dump xlated** | **pin** |
-	**load** | **attach** | **detach** | **help** }
+*PROG-COMMANDS* := { **show** | **list** | **dump jited** | **dump xlated** | **pin** |
+**load** | **attach** | **detach** | **help** }
 
-	*LINK-COMMANDS* := { **show** | **list** | **pin** | **detach** | **help** }
+*LINK-COMMANDS* := { **show** | **list** | **pin** | **detach** | **help** }
 
-	*CGROUP-COMMANDS* := { **show** | **list** | **attach** | **detach** | **help** }
+*CGROUP-COMMANDS* := { **show** | **list** | **attach** | **detach** | **help** }
 
-	*PERF-COMMANDS* := { **show** | **list** | **help** }
+*PERF-COMMANDS* := { **show** | **list** | **help** }
 
-	*NET-COMMANDS* := { **show** | **list** | **help** }
+*NET-COMMANDS* := { **show** | **list** | **help** }
 
-	*FEATURE-COMMANDS* := { **probe** | **help** }
+*FEATURE-COMMANDS* := { **probe** | **help** }
 
-	*BTF-COMMANDS* := { **show** | **list** | **dump** | **help** }
+*BTF-COMMANDS* := { **show** | **list** | **dump** | **help** }
 
-	*GEN-COMMANDS* := { **object** | **skeleton** | **min_core_btf** | **help** }
+*GEN-COMMANDS* := { **object** | **skeleton** | **min_core_btf** | **help** }
 
-	*STRUCT-OPS-COMMANDS* := { **show** | **list** | **dump** | **register** | **unregister** | **help** }
+*STRUCT-OPS-COMMANDS* := { **show** | **list** | **dump** | **register** | **unregister** | **help** }
 
-	*ITER-COMMANDS* := { **pin** | **help** }
+*ITER-COMMANDS* := { **pin** | **help** }
 
 DESCRIPTION
 ===========
-	*bpftool* allows for inspection and simple modification of BPF objects
-	on the system.
+*bpftool* allows for inspection and simple modification of BPF objects on the
+system.
 
-	Note that format of the output of all tools is not guaranteed to be
-	stable and should not be depended upon.
+Note that format of the output of all tools is not guaranteed to be stable and
+should not be depended upon.
 
 OPTIONS
 =======
-	.. include:: common_options.rst
+.. include:: common_options.rst
 
-	-m, --mapcompat
-		  Allow loading maps with unknown map definitions.
+-m, --mapcompat
+    Allow loading maps with unknown map definitions.
 
-	-n, --nomount
-		  Do not automatically attempt to mount any virtual file system
-		  (such as tracefs or BPF virtual file system) when necessary.
+-n, --nomount
+    Do not automatically attempt to mount any virtual file system (such as
+    tracefs or BPF virtual file system) when necessary.
diff --git a/tools/bpf/bpftool/Documentation/common_options.rst b/tools/bpf/bpftool/Documentation/common_options.rst
index 30df7a707f02..9234b9dab768 100644
--- a/tools/bpf/bpftool/Documentation/common_options.rst
+++ b/tools/bpf/bpftool/Documentation/common_options.rst
@@ -1,25 +1,23 @@
 .. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 
 -h, --help
-	  Print short help message (similar to **bpftool help**).
+    Print short help message (similar to **bpftool help**).
 
 -V, --version
-	  Print bpftool's version number (similar to **bpftool version**), the
-	  number of the libbpf version in use, and optional features that were
-	  included when bpftool was compiled. Optional features include linking
-	  against LLVM or libbfd to provide the disassembler for JIT-ted
-	  programs (**bpftool prog dump jited**) and usage of BPF skeletons
-	  (some features like **bpftool prog profile** or showing pids
-	  associated to BPF objects may rely on it).
+    Print bpftool's version number (similar to **bpftool version**), the number
+    of the libbpf version in use, and optional features that were included when
+    bpftool was compiled. Optional features include linking against LLVM or
+    libbfd to provide the disassembler for JIT-ted programs (**bpftool prog
+    dump jited**) and usage of BPF skeletons (some features like **bpftool prog
+    profile** or showing pids associated to BPF objects may rely on it).
 
 -j, --json
-	  Generate JSON output. For commands that cannot produce JSON, this
-	  option has no effect.
+    Generate JSON output. For commands that cannot produce JSON, this option
+    has no effect.
 
 -p, --pretty
-	  Generate human-readable JSON output. Implies **-j**.
+    Generate human-readable JSON output. Implies **-j**.
 
 -d, --debug
-	  Print all logs available, even debug-level information. This includes
-	  logs from libbpf as well as from the verifier, when attempting to
-	  load programs.
+    Print all logs available, even debug-level information. This includes logs
+    from libbpf as well as from the verifier, when attempting to load programs.
-- 
2.34.1

