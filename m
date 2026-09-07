Received: from out-zbxj-a65.jellyfish.systems (out-zbxj-a65.jellyfish.systems [198.54.127.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F2E3BD225
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747326; cv=none; b=cvjYSaCcNxMy3kRQ5mtd/zMEAWjR4QyuP7DuCMTc4yBS5Q8xOC3Facad6QeDe/+K7pn8GGwu8EYPJXriM5MUWSIJ+3dqOWSTdDTC0LBbIAy+hlw9/L1uzXWTSh8dktbiXiHEaTaNCPg4n7dMZYGoM4kdIQdhkp9HugvLkkDvUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747326; c=relaxed/simple;
	bh=WvfL2tbIRtgug7dvpgdaN/4F5SeCx1ruS9/K9mDtrvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0b/iS+PIWQTpINqvyRGkx4bC88buxKuVD4H2cuChGW0uQbmffL2RjEVGi2TPHoU6z74uxIK0n0JAxyGhwt3uBppLGzaQCdanKb36pDSznET0cTZVzRtYRwhWVesD24oyIlyLAvYBkz7IZRfZpBcAu3vxN8280gDUEd09Oc9vTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=GqcfsEtE; arc=none smtp.client-ip=198.54.127.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="GqcfsEtE"
Received: from 192.168.5.3 (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdVyw35wPz2x9Q;
	Mon, 07 Sep 2026 02:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788747322;
	bh=riuASYFppaqsKbiQ/+xQNpCUx5HnduVyV2MG09x9aCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GqcfsEtE5Di3YovT5Zp2RRg4GnzI4+VCxrWDOFsrlASc0EYZlhu/jd/wvVbdojj+c
	 SpRP+j92Tk3txeRgklgF1rHv+7PC3p7472W+kVkTgV0e13R1xim1x5lwWxPDGQyHZU
	 Wf4bTdKN7phPblW9xMjK6tk9S3gOuZs1kFGkGI5fEZW9bg4nB2WehWH7wWhvbYLW70
	 c1Xq7vgAjGmEb+OvTrsmgyPP86ixn7ojWRkX46wbTtpF/0ucNIaz2q13Jl8C1g/0aE
	 WFq+FAlqhJxKmhRLsQIXq1N1EZhsD+3/mFeWYffzQojK5M6AJ0fpkYyBhExHl2Qpyq
	 n32jDxFlMcDYA==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc
Subject: [PATCH bpf-next v3 1/2] bpftool: Accept symbolic map creation flags
Date: Mon,  7 Sep 2026 10:15:15 +0800
Message-ID: <178874713816.1519295.12130500880299787860.flags-v3-1@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178874713816.1519295.5079603775338308680.flags-v3-0@tychen.cc>
References: <178874362959.1415955.5742268739057412911.flags-v2-0@tychen.cc> <178874713816.1519295.5079603775338308680.flags-v3-0@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Accept comma-separated BPF_F_* names for map create flags, so callers
can use the UAPI names without looking up their numeric values. Keep
base-0 numeric input, including bits unknown to this bpftool.

Reject empty names, unknown names, mixed numeric and symbolic lists,
and values outside the unsigned 32-bit range. Limit symbolic names to
map creation flags and let the kernel validate map-specific combinations.
Document the syntax and complete names within comma-separated lists.

Avoid appending a space to completed list elements so another flag can
be added to the same argument.

Link: https://github.com/libbpf/bpftool/issues/57

Assisted-by: Codex:GPT-6
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpftool/Documentation/bpftool-feature.rst | 10 ++-
 .../bpf/bpftool/Documentation/bpftool-map.rst | 13 ++-
 tools/bpf/bpftool/bash-completion/bpftool     | 22 ++++-
 tools/bpf/bpftool/feature.c                   |  7 +-
 tools/bpf/bpftool/main.h                      |  1 +
 tools/bpf/bpftool/map.c                       | 85 ++++++++++++++++++-
 6 files changed, 125 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-feature.rst b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
index c7f837898bc..597f2426d25 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-feature.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
@@ -28,7 +28,7 @@ FEATURE COMMANDS
 | **bpftool** **feature help**
 |
 | *COMPONENT* := { **kernel** | **dev** *NAME* }
-| *GROUP* := { **prog_types** | **map_types** | **attach_types** | **link_types** | **helpers** }
+| *GROUP* := { **prog_types** | **map_types** | **map_create_flags** | **attach_types** | **link_types** | **helpers** }
 
 DESCRIPTION
 ===========
@@ -68,12 +68,14 @@ bpftool feature probe dev *NAME* [full] [macros [prefix *PREFIX*]]
 
 bpftool feature list_builtins *GROUP*
     List items known to bpftool. These can be BPF program types
-    (**prog_types**), BPF map types (**map_types**), attach types
+    (**prog_types**), BPF map types (**map_types**), map creation flags
+    (**map_create_flags**), attach types
     (**attach_types**), link types (**link_types**), or BPF helper functions
     (**helpers**). The command does not probe the system, but simply lists the
     elements that bpftool knows from compilation time, as provided from libbpf
-    (for all object types) or from the BPF UAPI header (list of helpers). This
-    can be used in scripts to iterate over BPF types or helpers.
+    (for all object types) or from the BPF UAPI header (helpers and map creation
+    flags). This can be used in scripts to iterate over BPF types, helpers, or
+    the symbolic flags accepted by **map create**.
 
 bpftool feature help
     Print short help message.
diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 5daf3de5c74..375321d5582 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -76,9 +76,16 @@ bpftool map { show | list }   [*MAP*]
 bpftool map create *FILE* type *TYPE* key *KEY_SIZE* value *VALUE_SIZE*  entries *MAX_ENTRIES* name *NAME* [flags *FLAGS*] [inner_map *MAP*] [offload_dev *NAME*]
     Create a new map with given parameters and pin it to *bpffs* as *FILE*.
 
-    *FLAGS* should be an integer which is the combination of desired flags,
-    e.g. 1024 for **BPF_F_MMAPABLE** (see bpf.h UAPI header for existing
-    flags).
+    *FLAGS* accepts an unsigned 32-bit integer combining the desired flags
+    (decimal, hexadecimal with a **0x** prefix, or octal with a **0** prefix),
+    or a comma-separated list of full, case-sensitive map creation flag names
+    from the bpf.h UAPI header. For example, **1024**, **0x400**, and
+    **BPF_F_MMAPABLE** are equivalent. Multiple names are combined with
+    bitwise OR, for example **BPF_F_NO_PREALLOC,BPF_F_RDONLY_PROG**.
+    Repeated names are allowed. Empty list elements, abbreviated names, and
+    lists mixing numbers with names are not accepted. Use **0** for no flags.
+    Numeric values can include bits unknown to bpftool. The kernel checks
+    whether the flags are valid for the requested map type.
 
     To create maps of type array-of-maps or hash-of-maps, the **inner_map**
     keyword must be used to pass an inner map. The kernel needs it to collect
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 75cbcb512eb..ea3f521b6f0 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -718,6 +718,10 @@ _bpftool()
                     esac
                     ;;
                 create)
+                    # Keep a flags list together if readline splits at commas.
+                    if [[ $COMP_WORDBREAKS == *,* && ( $cur == , || $prev == , ) ]]; then
+                        _get_comp_words_by_ref -n , cur prev
+                    fi
                     case $prev in
                         $command)
                             _filedir
@@ -729,7 +733,21 @@ _bpftool()
                             COMPREPLY=( $( compgen -W "$BPFTOOL_MAP_CREATE_TYPES" -- "$cur" ) )
                             return 0
                             ;;
-                        key|value|flags|entries)
+                        flags)
+                            compopt -o nospace
+                            local flags="$(bpftool feature list_builtins map_create_flags 2>/dev/null)"
+                            local prefix= flag
+                            # If comma is not a word break, Readline replaces the whole
+                            # word, so preserve the flags before the last comma.
+                            if [[ $cur == *,* && $COMP_WORDBREAKS != *,* ]]; then
+                                prefix="${cur%,*},"
+                            fi
+                            for flag in $(compgen -W "$flags" -- "${cur##*,}"); do
+                                COMPREPLY+=( "${prefix}${flag}" )
+                            done
+                            return 0
+                            ;;
+                        key|value|entries)
                             return 0
                             ;;
                         inner_map)
@@ -1192,7 +1210,7 @@ _bpftool()
                     ;;
                 list_builtins)
                     [[ $prev != "$command" ]] && return 0
-                    COMPREPLY=( $( compgen -W 'prog_types map_types \
+                    COMPREPLY=( $( compgen -W 'prog_types map_types map_create_flags \
                         attach_types link_types helpers' -- "$cur" ) )
                     ;;
                 *)
diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 0f6070a0c8e..b5419d5a661 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -1220,6 +1220,8 @@ static int do_list_builtins(int argc, char **argv)
 		get_name = (const char *(*)(unsigned int))libbpf_bpf_prog_type_str;
 	} else if (is_prefix(*argv, "map_types")) {
 		get_name = (const char *(*)(unsigned int))libbpf_bpf_map_type_str;
+	} else if (is_prefix(*argv, "map_create_flags")) {
+		get_name = map_create_flag_name;
 	} else if (is_prefix(*argv, "attach_types")) {
 		get_name = (const char *(*)(unsigned int))libbpf_bpf_attach_type_str;
 	} else if (is_prefix(*argv, "link_types")) {
@@ -1227,7 +1229,7 @@ static int do_list_builtins(int argc, char **argv)
 	} else if (is_prefix(*argv, "helpers")) {
 		get_name = get_helper_name;
 	} else {
-		p_err("expected 'prog_types', 'map_types', 'attach_types', 'link_types' or 'helpers', got: %s", *argv);
+		p_err("expected 'prog_types', 'map_types', 'map_create_flags', 'attach_types', 'link_types' or 'helpers', got: %s", *argv);
 		return -1;
 	}
 
@@ -1265,7 +1267,8 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       COMPONENT := { kernel | dev NAME }\n"
-		"       GROUP := { prog_types | map_types | attach_types | link_types | helpers }\n"
+		"       GROUP := { prog_types | map_types | map_create_flags |\n"
+		"                  attach_types | link_types | helpers }\n"
 		"       " HELP_SPEC_OPTIONS " }\n"
 		"",
 		bin_name, argv[-2]);
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 9315a1db1f7..3e2856c9f59 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -180,6 +180,7 @@ int do_token(int argc, char **argv) __weak;
 int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
 int prog_parse_fd(int *argc, char ***argv);
 int prog_parse_fds(int *argc, char ***argv, int **fds);
+const char *map_create_flag_name(unsigned int id);
 int map_parse_fd(int *argc, char ***argv, __u32 open_flags);
 int map_parse_fds(int *argc, char ***argv, int **fds, __u32 open_flags);
 int map_parse_fd_and_info(int *argc, char ***argv, struct bpf_map_info *info,
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 684a8fb7241..4445014247d 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1250,6 +1250,81 @@ static int do_pin(int argc, char **argv)
 	return err;
 }
 
+static const struct {
+	const char *name;
+	__u32 value;
+} map_create_flags[] = {
+#define MAP_CREATE_FLAG(flag) { #flag, flag }
+	MAP_CREATE_FLAG(BPF_F_NO_PREALLOC),
+	MAP_CREATE_FLAG(BPF_F_NO_COMMON_LRU),
+	MAP_CREATE_FLAG(BPF_F_NUMA_NODE),
+	MAP_CREATE_FLAG(BPF_F_RDONLY),
+	MAP_CREATE_FLAG(BPF_F_WRONLY),
+	MAP_CREATE_FLAG(BPF_F_STACK_BUILD_ID),
+	MAP_CREATE_FLAG(BPF_F_ZERO_SEED),
+	MAP_CREATE_FLAG(BPF_F_RDONLY_PROG),
+	MAP_CREATE_FLAG(BPF_F_WRONLY_PROG),
+	MAP_CREATE_FLAG(BPF_F_CLONE),
+	MAP_CREATE_FLAG(BPF_F_MMAPABLE),
+	MAP_CREATE_FLAG(BPF_F_PRESERVE_ELEMS),
+	MAP_CREATE_FLAG(BPF_F_INNER_MAP),
+	MAP_CREATE_FLAG(BPF_F_LINK),
+	MAP_CREATE_FLAG(BPF_F_VTYPE_BTF_OBJ_FD),
+	MAP_CREATE_FLAG(BPF_F_TOKEN_FD),
+	MAP_CREATE_FLAG(BPF_F_SEGV_ON_FAULT),
+	MAP_CREATE_FLAG(BPF_F_NO_USER_CONV),
+	MAP_CREATE_FLAG(BPF_F_RB_OVERWRITE),
+#undef MAP_CREATE_FLAG
+};
+
+const char *map_create_flag_name(unsigned int id)
+{
+	if (id >= ARRAY_SIZE(map_create_flags))
+		return NULL;
+
+	return map_create_flags[id].name;
+}
+
+static int parse_map_create_flags(const char *arg, __u32 *flags)
+{
+	const char *name = arg, *comma;
+	long long value;
+	__u32 parsed = 0;
+	size_t len, i;
+	char *end;
+
+	/* Keep base-0 numeric input, including bits unknown to this bpftool. */
+	if (strncmp(arg, "BPF_F_", 6)) {
+		errno = 0;
+		value = strtoll(arg, &end, 0);
+		if (errno || end == arg || *end || value < 0 || value > UINT32_MAX)
+			goto invalid;
+		*flags = value;
+		return 0;
+	}
+
+	do {
+		comma = strchr(name, ',');
+		len = comma ? (size_t)(comma - name) : strlen(name);
+		for (i = 0; i < ARRAY_SIZE(map_create_flags); i++) {
+			if (strlen(map_create_flags[i].name) == len &&
+			    !strncmp(name, map_create_flags[i].name, len))
+				break;
+		}
+		if (i == ARRAY_SIZE(map_create_flags))
+			goto invalid;
+		parsed |= map_create_flags[i].value;
+		if (comma)
+			name = comma + 1;
+	} while (comma);
+
+	*flags = parsed;
+	return 0;
+invalid:
+	p_err("can't parse %s as map creation flags", arg);
+	return -1;
+}
+
 static int do_create(int argc, char **argv)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, attr);
@@ -1301,9 +1376,14 @@ static int do_create(int argc, char **argv)
 					  "max entries"))
 				goto exit;
 		} else if (is_prefix(*argv, "flags")) {
-			if (parse_u32_arg(&argc, &argv, &attr.map_flags,
-					  "flags"))
+			NEXT_ARG();
+			if (attr.map_flags) {
+				p_err("flags already specified");
 				goto exit;
+			}
+			if (parse_map_create_flags(*argv, &attr.map_flags))
+				goto exit;
+			NEXT_ARG();
 		} else if (is_prefix(*argv, "dev")) {
 			p_info("Warning: 'bpftool map create [...] dev <ifname>' syntax is deprecated.\n"
 			       "Going further, please use 'offload_dev <ifname>' to request hardware offload for the map.");
@@ -1474,6 +1554,7 @@ static int do_help(int argc, char **argv)
 		"       DATA := { [hex] BYTES }\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       VALUE := { DATA | MAP | PROG }\n"
+		"       FLAGS := { integer | BPF_F_NAME[,BPF_F_NAME...] }\n"
 		"       UPDATE_FLAGS := { any | exist | noexist }\n"
 		"       TYPE := { hash | array | prog_array | perf_event_array | percpu_hash |\n"
 		"                 percpu_array | stack_trace | cgroup_array | lru_hash |\n"
-- 
2.55.0

