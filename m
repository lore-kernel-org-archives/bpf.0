Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A46314534F
	for <bpf@vger.kernel.org>; Sun, 31 Mar 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711915442; cv=none; b=UKcdaXl/vY2ToJz/DikhgLrNZif/zSvFEMXG/VV8C8vp6Th1xkrqxfTSskZ2RqNAuPr5f1lFmpYZ1J/Q08+Q78ehUMxxZmKv+Lt0GXtxLj4Ov+WZJYCb76PnmGW5hDkdvT4SfGhE2f71hQEH5zq+lFFAgHUN24NyxU9j9MXJBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711915442; c=relaxed/simple;
	bh=gNvZF84gCGhOBGuwWY6RqN1Ad6MtXKq7nbg7ihP/Dvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrZom7msRs27D41TrgLI+lqXn6OLxZddgPWfFDLjEKvDHemzEZZTh2LlCJIr48gWNU9HRWIaZEV4zWSvlhv17sqTCdEMGMUDTlA4JxLAWwvFDeyuy5CasFB/pJ2PnzybNkZYeiHBnFnGbXkz13FqqK+jTKEQbHhnhK05G6q/Veo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaqUYpKg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaqUYpKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C38CC433A6;
	Sun, 31 Mar 2024 20:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711915442;
	bh=gNvZF84gCGhOBGuwWY6RqN1Ad6MtXKq7nbg7ihP/Dvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaqUYpKg92hnolbMc8UayCRVMS+R3HqvpnkuxjKyesIzUcvEyzokBgdP4icqP4lX9
	 +cW2rEyWQC9pwXJa7uVHcioVuimCuFA5CPUra0aIESJxTvcMjROpc991omlIo/SC3N
	 /x4EyBeSG1zDxFhipPinmPznPkaIDiYmgaUiDXpq+DpIKhOxZA9d/LZNNEHGFzJ3PU
	 r4lRmtqZYTT3mesZgsTfothtyckL+6vhNBUeTLxpSTnBHNM9zMzf8IeE0Z3P2kWoFC
	 /9UUO7RQdwAkn9FieAAu6pDjKpAjLGU9G498wJif+251GL/zzXuwlYHrW+GnGVvtmP
	 /5Bnz++yRWODg==
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
Subject: [PATCH bpf-next 2/3] bpftool: Remove useless emphasis on command description in man pages
Date: Sun, 31 Mar 2024 21:03:45 +0100
Message-Id: <20240331200346.29118-3-qmo@kernel.org>
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

As it turns out, the terms in definition lists in the rST file are
already rendered with bold-ish formatting when generating the man pages;
all double-star sequences we have in the commands for the command
description are unnecessary, and can be removed to make the
documentation easier to read.

The rST files were automatically processed with:

    sed -i '/DESCRIPTION/,/OPTIONS/ { /^\*/ s/\*\*//g }' b*.rst

Signed-off-by: Rameez Rehman <rameezrehman408@hotmail.com>
Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  6 ++--
 .../bpftool/Documentation/bpftool-cgroup.rst  | 10 +++---
 .../bpftool/Documentation/bpftool-feature.rst |  8 ++---
 .../bpf/bpftool/Documentation/bpftool-gen.rst | 10 +++---
 .../bpftool/Documentation/bpftool-iter.rst    |  4 +--
 .../bpftool/Documentation/bpftool-link.rst    |  8 ++---
 .../bpf/bpftool/Documentation/bpftool-map.rst | 32 +++++++++----------
 .../bpf/bpftool/Documentation/bpftool-net.rst |  8 ++---
 .../bpftool/Documentation/bpftool-perf.rst    |  4 +--
 .../bpftool/Documentation/bpftool-prog.rst    | 22 ++++++-------
 .../Documentation/bpftool-struct_ops.rst      | 10 +++---
 11 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index 1be6b9aae053..f66781f20af2 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -34,7 +34,7 @@ BTF COMMANDS
 
 DESCRIPTION
 ===========
-**bpftool btf { show | list }** [**id** *BTF_ID*]
+bpftool btf { show | list } [id *BTF_ID*]
     Show information about loaded BTF objects. If a BTF ID is specified, show
     information only about given BTF object, otherwise list all BTF objects
     currently loaded on the system.
@@ -43,7 +43,7 @@ DESCRIPTION
     that hold open file descriptors (FDs) against BTF objects. On such kernels
     bpftool will automatically emit this information as well.
 
-**bpftool btf dump** *BTF_SRC*
+bpftool btf dump *BTF_SRC*
     Dump BTF entries from a given *BTF_SRC*.
 
     When **id** is specified, BTF object with that ID will be loaded and all
@@ -65,7 +65,7 @@ DESCRIPTION
     **format** option can be used to override default (raw) output format. Raw
     (**raw**) or C-syntax (**c**) output formats are supported.
 
-**bpftool btf help**
+bpftool btf help
     Print short help message.
 
 OPTIONS
diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index 1dbabe33e56a..1acf9f58fca2 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -49,7 +49,7 @@ CGROUP COMMANDS
 
 DESCRIPTION
 ===========
-**bpftool cgroup { show | list }** *CGROUP* [**effective**]
+bpftool cgroup { show | list } *CGROUP* [effective]
     List all programs attached to the cgroup *CGROUP*.
 
     Output will start with program ID followed by attach type, attach flags and
@@ -59,7 +59,7 @@ DESCRIPTION
     for events within a cgroup. This includes inherited along with attached
     ones.
 
-**bpftool cgroup tree** [*CGROUP_ROOT*] [**effective**]
+bpftool cgroup tree [*CGROUP_ROOT*] [effective]
     Iterate over all cgroups in *CGROUP_ROOT* and list all attached programs.
     If *CGROUP_ROOT* is not specified, bpftool uses cgroup v2 mountpoint.
 
@@ -71,7 +71,7 @@ DESCRIPTION
     for events within a cgroup. This includes inherited along with attached
     ones.
 
-**bpftool cgroup attach** *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
+bpftool cgroup attach *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
     Attach program *PROG* to the cgroup *CGROUP* with attach type *ATTACH_TYPE*
     and optional *ATTACH_FLAGS*.
 
@@ -126,10 +126,10 @@ DESCRIPTION
     **getsockname_unix** call to getsockname(2) for a unix socket (since 6.7);
     **sock_release** closing an userspace inet socket (since 5.9).
 
-**bpftool cgroup detach** *CGROUP* *ATTACH_TYPE* *PROG*
+bpftool cgroup detach *CGROUP* *ATTACH_TYPE* *PROG*
     Detach *PROG* from the cgroup *CGROUP* and attach type *ATTACH_TYPE*.
 
-**bpftool prog help**
+bpftool prog help
     Print short help message.
 
 OPTIONS
diff --git a/tools/bpf/bpftool/Documentation/bpftool-feature.rst b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
index 5c2433147ba4..c7f837898bc7 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-feature.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
@@ -32,7 +32,7 @@ FEATURE COMMANDS
 
 DESCRIPTION
 ===========
-**bpftool feature probe** [**kernel**] [**full**] [**macros** [**prefix** *PREFIX*]]
+bpftool feature probe [kernel] [full] [macros [prefix *PREFIX*]]
     Probe the running kernel and dump a number of eBPF-related parameters, such
     as availability of the **bpf**\ () system call, JIT status, eBPF program
     types availability, eBPF helper functions availability, and more.
@@ -59,14 +59,14 @@ DESCRIPTION
     bpftool is inadvertently run as non-root, for example. This keyword is
     unavailable if bpftool was compiled without libcap.
 
-**bpftool feature probe dev** *NAME* [**full**] [**macros** [**prefix** *PREFIX*]]
+bpftool feature probe dev *NAME* [full] [macros [prefix *PREFIX*]]
     Probe network device for supported eBPF features and dump results to the
     console.
 
     The keywords **full**, **macros** and **prefix** have the same role as when
     probing the kernel.
 
-**bpftool feature list_builtins** *GROUP*
+bpftool feature list_builtins *GROUP*
     List items known to bpftool. These can be BPF program types
     (**prog_types**), BPF map types (**map_types**), attach types
     (**attach_types**), link types (**link_types**), or BPF helper functions
@@ -75,7 +75,7 @@ DESCRIPTION
     (for all object types) or from the BPF UAPI header (list of helpers). This
     can be used in scripts to iterate over BPF types or helpers.
 
-**bpftool feature help**
+bpftool feature help
     Print short help message.
 
 OPTIONS
diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index 68104347d592..e9589c21e9c3 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -31,7 +31,7 @@ GEN COMMANDS
 
 DESCRIPTION
 ===========
-**bpftool gen object** *OUTPUT_FILE* *INPUT_FILE* [*INPUT_FILE*...]
+bpftool gen object *OUTPUT_FILE* *INPUT_FILE* [*INPUT_FILE*...]
     Statically link (combine) together one or more *INPUT_FILE*'s into a single
     resulting *OUTPUT_FILE*. All the files involved are BPF ELF object files.
 
@@ -48,7 +48,7 @@ DESCRIPTION
     command) or passed directly into **libbpf** (using **bpf_object__open()**
     family of APIs).
 
-**bpftool gen skeleton** *FILE*
+bpftool gen skeleton *FILE*
     Generate BPF skeleton C header file for a given *FILE*.
 
     BPF skeleton is an alternative interface to existing libbpf APIs for
@@ -132,7 +132,7 @@ DESCRIPTION
     used to fetch and update (non-read-only) data from userspace, with same
     simplicity as for BPF side.
 
-**bpftool gen subskeleton** *FILE*
+bpftool gen subskeleton *FILE*
     Generate BPF subskeleton C header file for a given *FILE*.
 
     Subskeletons are similar to skeletons, except they do not own the
@@ -154,7 +154,7 @@ DESCRIPTION
       Frees the storage for the subskeleton but *does not* unload any BPF
       programs or maps.
 
-**bpftool** **gen min_core_btf** *INPUT* *OUTPUT* *OBJECT* [*OBJECT*...]
+bpftool gen min_core_btf *INPUT* *OUTPUT* *OBJECT* [*OBJECT*...]
     Generate a minimum BTF file as *OUTPUT*, derived from a given *INPUT* BTF
     file, containing all needed BTF types so one, or more, given eBPF objects
     CO-RE relocations may be satisfied.
@@ -174,7 +174,7 @@ DESCRIPTION
 
     Check examples bellow for more information how to use it.
 
-**bpftool gen help**
+bpftool gen help
     Print short help message.
 
 OPTIONS
diff --git a/tools/bpf/bpftool/Documentation/bpftool-iter.rst b/tools/bpf/bpftool/Documentation/bpftool-iter.rst
index af17cc0201d4..7bcb4e993d7d 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-iter.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-iter.rst
@@ -31,7 +31,7 @@ ITER COMMANDS
 
 DESCRIPTION
 ===========
-**bpftool iter pin** *OBJ* *PATH* [**map** *MAP*]
+bpftool iter pin *OBJ* *PATH* [map *MAP*]
     A bpf iterator combines a kernel iterating of particular kernel data (e.g.,
     tasks, bpf_maps, etc.) and a bpf program called for each kernel data object
     (e.g., one task, one bpf_map, etc.). User space can *read* kernel iterator
@@ -48,7 +48,7 @@ DESCRIPTION
 
     User can then *cat PATH* to see the bpf iterator output.
 
-**bpftool iter help**
+bpftool iter help
     Print short help message.
 
 OPTIONS
diff --git a/tools/bpf/bpftool/Documentation/bpftool-link.rst b/tools/bpf/bpftool/Documentation/bpftool-link.rst
index 6d39ad890fea..6f09d4405ed8 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-link.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-link.rst
@@ -33,7 +33,7 @@ LINK COMMANDS
 
 DESCRIPTION
 ===========
-**bpftool link { show | list }** [*LINK*]
+bpftool link { show | list } [*LINK*]
     Show information about active links. If *LINK* is specified show
     information only about given link, otherwise list all links currently
     active on the system.
@@ -45,19 +45,19 @@ DESCRIPTION
     that hold open file descriptors (FDs) against BPF links. On such kernels
     bpftool will automatically emit this information as well.
 
-**bpftool link pin** *LINK* *FILE*
+bpftool link pin *LINK* *FILE*
     Pin link *LINK* as *FILE*.
 
     Note: *FILE* must be located in *bpffs* mount. It must not contain a dot
     character ('.'), which is reserved for future extensions of *bpffs*.
 
-**bpftool link detach** *LINK*
+bpftool link detach *LINK*
     Force-detach link *LINK*. BPF link and its underlying BPF program will stay
     valid, but they will be detached from the respective BPF hook and BPF link
     will transition into a defunct state until last open file descriptor for
     that link is closed.
 
-**bpftool link help**
+bpftool link help
     Print short help message.
 
 OPTIONS
diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 864257169942..252e4c538edb 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -59,7 +59,7 @@ MAP COMMANDS
 
 DESCRIPTION
 ===========
-**bpftool map { show | list }**   [*MAP*]
+bpftool map { show | list }   [*MAP*]
     Show information about loaded maps.  If *MAP* is specified show information
     only about given maps, otherwise list all maps currently loaded on the
     system.  In case of **name**, *MAP* may match several maps which will all
@@ -72,7 +72,7 @@ DESCRIPTION
     that hold open file descriptors (FDs) against BPF maps. On such kernels
     bpftool will automatically emit this information as well.
 
-**bpftool map create** *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE*  **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] [**offload_dev** *NAME*]
+bpftool map create *FILE* type *TYPE* key *KEY_SIZE* value *VALUE_SIZE*  entries *MAX_ENTRIES* name *NAME* [flags *FLAGS*] [inner_map *MAP*] [offload_dev *NAME*]
     Create a new map with given parameters and pin it to *bpffs* as *FILE*.
 
     *FLAGS* should be an integer which is the combination of desired flags,
@@ -86,11 +86,11 @@ DESCRIPTION
     Keyword **offload_dev** expects a network interface name, and is used to
     request hardware offload for the map.
 
-**bpftool map dump**    *MAP*
+bpftool map dump    *MAP*
     Dump all entries in a given *MAP*.  In case of **name**, *MAP* may match
     several maps which will all be dumped.
 
-**bpftool map update**  *MAP* [**key** *DATA*] [**value** *VALUE*] [*UPDATE_FLAGS*]
+bpftool map update  *MAP* [key *DATA*] [value *VALUE*] [*UPDATE_FLAGS*]
     Update map entry for a given *KEY*.
 
     *UPDATE_FLAGS* can be one of: **any** update existing entry or add if
@@ -103,22 +103,22 @@ DESCRIPTION
     unless a "0x" prefix (for hexadecimal) or a "0" prefix (for octal) is
     provided.
 
-**bpftool map lookup**  *MAP* [**key** *DATA*]
+bpftool map lookup  *MAP* [key *DATA*]
     Lookup **key** in the map.
 
-**bpftool map getnext** *MAP* [**key** *DATA*]
+bpftool map getnext *MAP* [key *DATA*]
     Get next key.  If *key* is not specified, get first key.
 
-**bpftool map delete**  *MAP*  **key** *DATA*
+bpftool map delete  *MAP*  key *DATA*
     Remove entry from the map.
 
-**bpftool map pin**     *MAP*  *FILE*
+bpftool map pin     *MAP*  *FILE*
     Pin map *MAP* as *FILE*.
 
     Note: *FILE* must be located in *bpffs* mount. It must not contain a dot
     character ('.'), which is reserved for future extensions of *bpffs*.
 
-**bpftool** **map event_pipe** *MAP* [**cpu** *N* **index** *M*]
+bpftool map event_pipe *MAP* [cpu *N* index *M*]
     Read events from a **BPF_MAP_TYPE_PERF_EVENT_ARRAY** map.
 
     Install perf rings into a perf event array map and dump output of any
@@ -133,29 +133,29 @@ DESCRIPTION
     existing ring.  Any other application will stop receiving events if it
     installed its rings earlier.
 
-**bpftool map peek**  *MAP*
+bpftool map peek  *MAP*
     Peek next value in the queue or stack.
 
-**bpftool map push**  *MAP* **value** *VALUE*
+bpftool map push  *MAP* value *VALUE*
     Push *VALUE* onto the stack.
 
-**bpftool map pop**  *MAP*
+bpftool map pop  *MAP*
     Pop and print value from the stack.
 
-**bpftool map enqueue**  *MAP* **value** *VALUE*
+bpftool map enqueue  *MAP* value *VALUE*
     Enqueue *VALUE* into the queue.
 
-**bpftool map dequeue**  *MAP*
+bpftool map dequeue  *MAP*
     Dequeue and print value from the queue.
 
-**bpftool map freeze**  *MAP*
+bpftool map freeze  *MAP*
     Freeze the map as read-only from user space. Entries from a frozen map can
     not longer be updated or deleted with the **bpf**\ () system call. This
     operation is not reversible, and the map remains immutable from user space
     until its destruction. However, read and write permissions for BPF programs
     to the map remain unchanged.
 
-**bpftool map help**
+bpftool map help
     Print short help message.
 
 OPTIONS
diff --git a/tools/bpf/bpftool/Documentation/bpftool-net.rst b/tools/bpf/bpftool/Documentation/bpftool-net.rst
index 43d2c858fdf8..f8e65869f8b4 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-net.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-net.rst
@@ -33,7 +33,7 @@ NET COMMANDS
 
 DESCRIPTION
 ===========
-**bpftool net { show | list }** [ **dev** *NAME* ]
+bpftool net { show | list } [ dev *NAME* ]
     List bpf program attachments in the kernel networking subsystem.
 
     Currently, device driver xdp attachments, tcx, netkit and old-style tc
@@ -58,7 +58,7 @@ DESCRIPTION
     then all bpf programs attached to non clsact qdiscs, and finally all bpf
     programs attached to root and clsact qdisc.
 
-**bpftool** **net attach** *ATTACH_TYPE* *PROG* **dev** *NAME* [ **overwrite** ]
+bpftool net attach *ATTACH_TYPE* *PROG* dev *NAME* [ overwrite ]
     Attach bpf program *PROG* to network interface *NAME* with type specified
     by *ATTACH_TYPE*. Previously attached bpf program can be replaced by the
     command used with **overwrite** option. Currently, only XDP-related modes
@@ -70,13 +70,13 @@ DESCRIPTION
     **xdpdrv** - Native XDP. runs earliest point in driver's receive path;
     **xdpoffload** - Offload XDP. runs directly on NIC on each packet reception;
 
-**bpftool** **net detach** *ATTACH_TYPE* **dev** *NAME*
+bpftool net detach *ATTACH_TYPE* dev *NAME*
     Detach bpf program attached to network interface *NAME* with type specified
     by *ATTACH_TYPE*. To detach bpf program, same *ATTACH_TYPE* previously used
     for attach must be specified. Currently, only XDP-related modes are
     supported for *ATTACH_TYPE*.
 
-**bpftool net help**
+bpftool net help
     Print short help message.
 
 OPTIONS
diff --git a/tools/bpf/bpftool/Documentation/bpftool-perf.rst b/tools/bpf/bpftool/Documentation/bpftool-perf.rst
index 841789e30acd..8c1ae55be596 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-perf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-perf.rst
@@ -29,7 +29,7 @@ PERF COMMANDS
 
 DESCRIPTION
 ===========
-**bpftool perf { show | list }**
+bpftool perf { show | list }
     List all raw_tracepoint, tracepoint, kprobe attachment in the system.
 
     Output will start with process id and file descriptor in that process,
@@ -39,7 +39,7 @@ DESCRIPTION
     kernel virtual address. The attachment point for u[ret]probe is the file
     name and the file offset.
 
-**bpftool perf help**
+bpftool perf help
     Print short help message.
 
 OPTIONS
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index cc456d357db3..8e730cfb2589 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -67,7 +67,7 @@ PROG COMMANDS
 
 DESCRIPTION
 ===========
-**bpftool prog { show | list }** [*PROG*]
+bpftool prog { show | list } [*PROG*]
     Show information about loaded programs.  If *PROG* is specified show
     information only about given programs, otherwise list all programs
     currently loaded on the system. In case of **tag** or **name**, *PROG* may
@@ -87,7 +87,7 @@ DESCRIPTION
     that hold open file descriptors (FDs) against BPF programs. On such kernels
     bpftool will automatically emit this information as well.
 
-**bpftool prog dump xlated** *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] [**visual**] }]
+bpftool prog dump xlated *PROG* [{ file *FILE* | [opcodes] [linum] [visual] }]
     Dump eBPF instructions of the programs from the kernel. By default, eBPF
     will be disassembled and printed to standard output in human-readable
     format. In this case, **opcodes** controls if raw opcodes should be printed
@@ -108,7 +108,7 @@ DESCRIPTION
     displayed.  If **linum** is specified, the filename, line number and line
     column will also be displayed.
 
-**bpftool prog dump jited**  *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] }]
+bpftool prog dump jited  *PROG* [{ file *FILE* | [opcodes] [linum] }]
     Dump jited image (host machine code) of the program.
 
     If *FILE* is specified image will be written to a file, otherwise it will
@@ -121,13 +121,13 @@ DESCRIPTION
     **linum** is specified, the filename, line number and line column will also
     be displayed.
 
-**bpftool prog pin** *PROG* *FILE*
+bpftool prog pin *PROG* *FILE*
     Pin program *PROG* as *FILE*.
 
     Note: *FILE* must be located in *bpffs* mount. It must not contain a dot
     character ('.'), which is reserved for future extensions of *bpffs*.
 
-**bpftool prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** { **idx** *IDX* | **name** *NAME* } *MAP*] [{ **offload_dev** | **xdpmeta_dev** } *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
+bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *IDX* | name *NAME* } *MAP*] [{ offload_dev | xdpmeta_dev } *NAME*] [pinmaps *MAP_DIR*] [autoattach]
     Load bpf program(s) from binary *OBJ* and pin as *PATH*. **bpftool prog
     load** pins only the first program from the *OBJ* as *PATH*. **bpftool prog
     loadall** pins all programs from the *OBJ* under *PATH* directory. **type**
@@ -156,24 +156,24 @@ DESCRIPTION
     Note: *PATH* must be located in *bpffs* mount. It must not contain a dot
     character ('.'), which is reserved for future extensions of *bpffs*.
 
-**bpftool prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
+bpftool prog attach *PROG* *ATTACH_TYPE* [*MAP*]
     Attach bpf program *PROG* (with type specified by *ATTACH_TYPE*). Most
     *ATTACH_TYPEs* require a *MAP* parameter, with the exception of
     *flow_dissector* which is attached to current networking name space.
 
-**bpftool prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
+bpftool prog detach *PROG* *ATTACH_TYPE* [*MAP*]
     Detach bpf program *PROG* (with type specified by *ATTACH_TYPE*). Most
     *ATTACH_TYPEs* require a *MAP* parameter, with the exception of
     *flow_dissector* which is detached from the current networking name space.
 
-**bpftool prog tracelog**
+bpftool prog tracelog
     Dump the trace pipe of the system to the console (stdout). Hit <Ctrl+C> to
     stop printing. BPF programs can write to this trace pipe at runtime with
     the **bpf_trace_printk**\ () helper. This should be used only for debugging
     purposes. For streaming data from BPF programs to user space, one can use
     perf events (see also **bpftool-map**\ (8)).
 
-**bpftool prog run** *PROG* **data_in** *FILE* [**data_out** *FILE* [**data_size_out** *L*]] [**ctx_in** *FILE* [**ctx_out** *FILE* [**ctx_size_out** *M*]]] [**repeat** *N*]
+bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ctx_in *FILE* [ctx_out *FILE* [ctx_size_out *M*]]] [repeat *N*]
     Run BPF program *PROG* in the kernel testing infrastructure for BPF,
     meaning that the program works on the data and context provided by the
     user, and not on actual packets or monitored functions etc. Return value
@@ -201,12 +201,12 @@ DESCRIPTION
     them can take the **ctx_in**/**ctx_out** arguments. bpftool does not
     perform checks on program types.
 
-**bpftool prog profile** *PROG* [**duration** *DURATION*] *METRICs*
+bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
     Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
     user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
     the profiling will run up to **UINT_MAX** seconds.
 
-**bpftool prog help**
+bpftool prog help
     Print short help message.
 
 OPTIONS
diff --git a/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst b/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
index 61ec1286446c..e871b9539ac7 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
@@ -36,7 +36,7 @@ STRUCT_OPS COMMANDS
 
 DESCRIPTION
 ===========
-**bpftool struct_ops { show | list }** [*STRUCT_OPS_MAP*]
+bpftool struct_ops { show | list } [*STRUCT_OPS_MAP*]
     Show brief information about the struct_ops in the system. If
     *STRUCT_OPS_MAP* is specified, it shows information only for the given
     struct_ops.  Otherwise, it lists all struct_ops currently existing in the
@@ -45,13 +45,13 @@ DESCRIPTION
     Output will start with struct_ops map ID, followed by its map name and its
     struct_ops's kernel type.
 
-**bpftool struct_ops dump** [*STRUCT_OPS_MAP*]
+bpftool struct_ops dump [*STRUCT_OPS_MAP*]
     Dump details information about the struct_ops in the system. If
     *STRUCT_OPS_MAP* is specified, it dumps information only for the given
     struct_ops.  Otherwise, it dumps all struct_ops currently existing in the
     system.
 
-**bpftool struct_ops register** *OBJ* [*LINK_DIR*]
+bpftool struct_ops register *OBJ* [*LINK_DIR*]
     Register bpf struct_ops from *OBJ*.  All struct_ops under the ELF section
     ".struct_ops" and ".struct_ops.link" will be registered to its kernel
     subsystem.  For each struct_ops in the ".struct_ops.link" section, a link
@@ -59,10 +59,10 @@ DESCRIPTION
     these links will be pinned with the same name as their corresponding map
     name.
 
-**bpftool struct_ops unregister**  *STRUCT_OPS_MAP*
+bpftool struct_ops unregister  *STRUCT_OPS_MAP*
     Unregister the *STRUCT_OPS_MAP* from the kernel subsystem.
 
-**bpftool struct_ops help**
+bpftool struct_ops help
     Print short help message.
 
 OPTIONS
-- 
2.34.1

