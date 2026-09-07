Received: from out-zbxj-a77.jellyfish.systems (out-zbxj-a77.jellyfish.systems [198.54.127.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D58274670
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744062; cv=none; b=EJYDGQncxh8pp+kOjfaluf7XSW/qzEZrZHEQzizkyLedrTKAm1dVxqvetqrMrCc+ZRa3Tqw9pWfvQwnSTMnD2SkrNREYr2niv5iwpcpFFNtwFqll+0/3m2Cq1c/b/+Wzy7WRMxlV9vpAupOdQ9gP9gI8hhdF6eMeNjPDXmWp1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744062; c=relaxed/simple;
	bh=OWuRsukFHNgbA3POD+VwO2FjiUD488fWqlLhdNCtmJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mjajd4v5RbtPol27o2HDO9EJDEGEY+FxdH6vJQJVuT49dlsZ29Y6blAT7lcHP4TsDzCO/dIs1O77GHZ4dIGbGj07pPiMCdVOtMfeIsTWSj+yDQe3yLF7IfU+Ai075Cq801YlSX8eYP65VNvMoqdVFipNMZO/jbSNzBdod7lTQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=H5vX82cS; arc=none smtp.client-ip=198.54.127.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="H5vX82cS"
Received: from 192.168.5.3 (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdTm84wmhz8sYS;
	Mon, 07 Sep 2026 01:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788744059;
	bh=fy+VK0RYIEhXyo4vNZqNu0k6NoqHGr3SSYM8V7FyajI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5vX82cSszlOYG5KuMvkxynNk2C4UyoX1iCL9NnotjCt3dgHFwXi4/yhBpP9rZfjo
	 xO+G32IZSCU8qcHqwpbmhaZTqY6EsIwQSaZlz0kLw+PBH6c4JjRz5FoPnqrQZ38MGb
	 TvFLSsl9Y/rpnerY/f2BH25ZOS6El2J51aSNwCZO0spV1JJIExtJBarLor/AzvqvTE
	 CWHEA7zSI8MeUYNrCWFTtDvKeU9+z4Yv/A90ptt/O2OKXa+YDGgCLTcLU22+D01wAG
	 3RDmYXBEFxyGgvINkjtjAT3NvrwewTKr5GWGfeN9onNqcmMdkpDdX6MrNq/Cgc2xo8
	 2E2ganDAsAiSw==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	Quentin Monnet <qmo@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpftool: Accept symbolic map creation flags
Date: Mon,  7 Sep 2026 09:20:50 +0800
Message-ID: <178874362959.1415955.3136948443938068365.flags-v2-1@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178874362959.1415955.5742268739057412911.flags-v2-0@tychen.cc>
References: <20260906170715.1212085-1-hi@tychen.cc> <178874362959.1415955.5742268739057412911.flags-v2-0@tychen.cc>
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
 .../bpf/bpftool/Documentation/bpftool-map.rst | 13 +++-
 tools/bpf/bpftool/bash-completion/bpftool     | 26 ++++++-
 tools/bpf/bpftool/map.c                       | 77 ++++++++++++++++++-
 3 files changed, 110 insertions(+), 6 deletions(-)

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
index 75cbcb512eb..73f6a811826 100644
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
@@ -729,7 +733,27 @@ _bpftool()
                             COMPREPLY=( $( compgen -W "$BPFTOOL_MAP_CREATE_TYPES" -- "$cur" ) )
                             return 0
                             ;;
-                        key|value|flags|entries)
+                        flags)
+                            compopt -o nospace
+                            local flags='BPF_F_NO_PREALLOC BPF_F_NO_COMMON_LRU
+                                BPF_F_NUMA_NODE BPF_F_RDONLY BPF_F_WRONLY
+                                BPF_F_STACK_BUILD_ID BPF_F_ZERO_SEED
+                                BPF_F_RDONLY_PROG BPF_F_WRONLY_PROG BPF_F_CLONE
+                                BPF_F_MMAPABLE BPF_F_PRESERVE_ELEMS BPF_F_INNER_MAP
+                                BPF_F_LINK BPF_F_VTYPE_BTF_OBJ_FD BPF_F_TOKEN_FD
+                                BPF_F_SEGV_ON_FAULT BPF_F_NO_USER_CONV
+                                BPF_F_RB_OVERWRITE'
+                            local prefix= flag
+                            # Readline replaces only the suffix after a word break.
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
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 684a8fb7241..d703af60d0b 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1250,6 +1250,73 @@ static int do_pin(int argc, char **argv)
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
@@ -1301,9 +1368,14 @@ static int do_create(int argc, char **argv)
 					  "max entries"))
 				goto exit;
 		} else if (is_prefix(*argv, "flags")) {
-			if (parse_u32_arg(&argc, &argv, &attr.map_flags,
-					  "flags"))
+			NEXT_ARG();
+			if (attr.map_flags) {
+				p_err("flags already specified");
+				goto exit;
+			}
+			if (parse_map_create_flags(*argv, &attr.map_flags))
 				goto exit;
+			NEXT_ARG();
 		} else if (is_prefix(*argv, "dev")) {
 			p_info("Warning: 'bpftool map create [...] dev <ifname>' syntax is deprecated.\n"
 			       "Going further, please use 'offload_dev <ifname>' to request hardware offload for the map.");
@@ -1474,6 +1546,7 @@ static int do_help(int argc, char **argv)
 		"       DATA := { [hex] BYTES }\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       VALUE := { DATA | MAP | PROG }\n"
+		"       FLAGS := { integer | BPF_F_NAME[,BPF_F_NAME...] }\n"
 		"       UPDATE_FLAGS := { any | exist | noexist }\n"
 		"       TYPE := { hash | array | prog_array | perf_event_array | percpu_hash |\n"
 		"                 percpu_array | stack_trace | cgroup_array | lru_hash |\n"
-- 
2.55.0

