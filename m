Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB4F3AAF6A
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 03:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098432; cv=none; b=JPXfjAsC21tiYgP3YmZE4LydrF5HXoIcTfHWtIUsa3+VJ3BJMQHPpwJTBSiuAzN1+pb7GKMa9RagIx1Bed/bBi4R2m/Di1Cw6EQgeBMwY9O/CvSwQ98mrTSxAVdBtIRH5BS70eo6iS5MrjhssEM1jl6OvhEJ99d0ng5CJ5b1A6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098432; c=relaxed/simple;
	bh=Px6YMCS7alQ0hC+MCuBrJS6+RtKZJP5xwq6PvaHZGvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhL5sieWMslpS7WWEwXT67vo7jfhv7YH9JHmnnPH9pcv5+MqlJgNCi0ldw+ncJTYg2K6Lxsa7vC1NRI60X11u+QzjKM2Jqv/EmK/R26zVn2oLP6s1YTJ9OO6FrAvUFw/9/PrvJgAEbAx3KOS6E16wlFAshUuDpYI9w16iXy9ld8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdvC8Z4P; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdvC8Z4P"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-396a51b2605so204148a91.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 20:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789098430; x=1789703230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KxO9xckzpQFJK+vCemppGSlZt+kd6zyn//X+ZaDalos=;
        b=KdvC8Z4PEZYvbDCnqDAZY521SWFTxc2xjv8CqpqCq6lZbjmLrAeOdDOjKYTx18LLxp
         6cAhwwPX317SUWfJThq/Uzs/gy9fQXqlcvZiZ2laLO4zUguJK6EHuQNudXv0kAFImsVO
         hwrNbHt/bCOpikX1hgBPXqVcop8R81qIbxTfmSgQtU5M50WvmYIIh7wKvMVyVsVO0ZKx
         C5eCvu7tN2CdJ5mQTWaa2RvdH3EMqBV/qiAnuoNimx6eCEReN+ooidJzS4Tu0cyvTqRD
         eF7fs5TV65WQXOjUjNiVPsDrcGCc09W0kGaCUtRk03wOQqYkGSbHwyNKp//SLV/b4tZF
         kuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789098430; x=1789703230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KxO9xckzpQFJK+vCemppGSlZt+kd6zyn//X+ZaDalos=;
        b=Z8nF/M7XeWZUAFQlfwDaVnoW8BF0emfz0qT6qIySQcS4vSWAnVINEG3pClupmyro4M
         ShsZOyh7+oV6SSnTtNUTDB0D9CBTzq/DortP4aLW6mJy9AzxQTyb0mzX0SS5AxvX+jaw
         eSraCuuLmOmPeUTaCQWeHyCdUNygjeAE6RwtBqHhdnmMOdRIymu2aVxn3o3Voxh12yRF
         ZNy1gtaISkev+Uag7trRoMtR25z4nLPo/0v+o0BNG5x3KR2Cu48sFzPDheSwamX7jau5
         gGbOSDW8pjUZPhARlPuUTiqAF1tvG0e1WMror8puw2hRTV31bVSEJEEltlQPYHansx/M
         sugg==
X-Forwarded-Encrypted: i=1; AKwUvBwQYi6LOAQBJ4S98pHz5w/et4qAN54+J5cBNzSTbneFf43lqjVRLsA+4H621QGkdTXS66U=@vger.kernel.org
X-Gm-Message-State: AFuF++k7cLDY8L+bLKUy8XBLl5fNQQ+2iyHxmQS3t6x5doXNtnjopSk7
	u0X5qK/RCsnLs5ksyJEHcC3pMsfODZ0hWcDtQm9hnxLEAhCScqrDHR31fQGj3jz3DEvvHg==
X-Gm-Gg: AYBFou2Tx1rGmHVXNBSsniBlvZqCxaj07U7gnO9U/VVD5+dNPj31FHKXfEGYppI2vL0
	4sk05jQ1j4z+ZSF5nLo6tdLDBQ5CbWExWNMwze2NkP+CICMCkRPuIp+hN4rCMIvHE5Nmgekn/SR
	rzetGSmCaxPVoERW6eQhW2DGV2TsYOs/Gf8vIy0/jSQuLDimhmyxnLdiaRRMFHuIBs3iCB2MFyv
	T0IKPhsggJq3fLRoZMilsXyVppfPxgLWnpUmlmFET1Oy74yJNd1DisNmTQjiZUGXNOZqoDE68XD
	u8aeypqVfpiPh4K0q6P9ndsIubDi22WLuLdOQxEn5oAF5eS1AfPOI92Rq3hR7QcnPFReF5koxtA
	jIMzEOrzCTv9NW3rfJAalTes1I0RS3HIRJ3guUFS4ehg+MAGQDFf63+R116oDURwWlX9+0mGwm3
	8yZ0d78Erelf8gXcvH+13ZLctQqAHmo4f3v3d2z9I7mPk26cHAhmE9GPSCBk4huY3o
X-Received: by 2002:a17:90b:4d0c:b0:395:5f43:4ec4 with SMTP id 98e67ed59e1d1-39d9b97d29emr3471216a91.0.1789098429787;
        Thu, 10 Sep 2026 20:47:09 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9959ac65sm2119710a91.16.2026.09.10.20.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:47:09 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 1/2] bpftool: Accept symbolic map creation flags
Date: Fri, 11 Sep 2026 11:46:57 +0800
Message-ID: <20260911034658.219396-2-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911034658.219396-1-diannaaav@gmail.com>
References: <20260911034658.219396-1-diannaaav@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyi Chen <hi@tychen.cc>

Accept comma-separated BPF_F_* names for map create flags, so callers
can use the UAPI names without looking up their numeric values. Keep
base-0 unsigned 32-bit numeric input, including bits unknown to bpftool.

Reject empty names, unknown names and mixed numeric and symbolic lists.
The old numeric parser accepted an empty string as zero and could
truncate or wrap out-of-range values; reject those inputs as well.
Parser acceptance still leaves the kernel to validate the flags for
the requested map type.

List accepted symbolic names through feature list_builtins and use the
same list for completion. Avoid appending a space to completed list
elements so another flag can be added to the same argument.

Link: https://github.com/libbpf/bpftool/issues/57

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpftool/Documentation/bpftool-feature.rst | 16 ++--
 .../bpf/bpftool/Documentation/bpftool-map.rst | 15 +++-
 tools/bpf/bpftool/bash-completion/bpftool     | 22 ++++-
 tools/bpf/bpftool/feature.c                   |  7 +-
 tools/bpf/bpftool/main.h                      |  1 +
 tools/bpf/bpftool/map.c                       | 86 ++++++++++++++++++-
 6 files changed, 131 insertions(+), 16 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-feature.rst b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
index c7f837898bc..fb10d2b6a55 100644
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
-    (**attach_types**), link types (**link_types**), or BPF helper functions
-    (**helpers**). The command does not probe the system, but simply lists the
-    elements that bpftool knows from compilation time, as provided from libbpf
-    (for all object types) or from the BPF UAPI header (list of helpers). This
-    can be used in scripts to iterate over BPF types or helpers.
+    (**prog_types**), BPF map types (**map_types**), map creation flags
+    (**map_create_flags**), attach types (**attach_types**), link types
+    (**link_types**), or BPF helper functions (**helpers**). The command does
+    not probe the system, but simply lists the elements that bpftool knows
+    from compilation time, as provided from libbpf (for all object types) or
+    from the BPF UAPI header (helpers and map creation flags). This can be used
+    in scripts to iterate over BPF types, helpers, or the symbolic flags
+    accepted by **map create**.
 
 bpftool feature help
     Print short help message.
diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 5daf3de5c74..15739a0806f 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -48,6 +48,7 @@ MAP COMMANDS
 | *DATA* := { [**hex**] *BYTES* }
 | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
 | *VALUE* := { *DATA* | *MAP* | *PROG* }
+| *FLAGS* := { integer | **BPF_F_NAME[,BPF_F_NAME...]** }
 | *UPDATE_FLAGS* := { **any** | **exist** | **noexist** }
 | *TYPE* := { **hash** | **array** | **prog_array** | **perf_event_array** | **percpu_hash**
 |     | **percpu_array** | **stack_trace** | **cgroup_array** | **lru_hash**
@@ -76,9 +77,17 @@ bpftool map { show | list }   [*MAP*]
 bpftool map create *FILE* type *TYPE* key *KEY_SIZE* value *VALUE_SIZE*  entries *MAX_ENTRIES* name *NAME* [flags *FLAGS*] [inner_map *MAP*] [offload_dev *NAME*]
     Create a new map with given parameters and pin it to *bpffs* as *FILE*.
 
-    *FLAGS* should be an integer which is the combination of desired flags,
-    e.g. 1024 for **BPF_F_MMAPABLE** (see bpf.h UAPI header for existing
-    flags).
+    *FLAGS* accepts an unsigned 32-bit integer combining the desired flags
+    (decimal, hexadecimal with a **0x** prefix, or octal with a **0** prefix),
+    or a comma-separated list of full, case-sensitive map creation flag names
+    from the bpf.h UAPI header. Use **bpftool feature list_builtins
+    map_create_flags** to list accepted symbolic names. For example, **1024**,
+    **0x400**, and **BPF_F_MMAPABLE** are equivalent. Multiple names are combined
+    with bitwise OR, for example **BPF_F_NO_PREALLOC,BPF_F_RDONLY_PROG**.
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
index 684a8fb7241..e3b643246c6 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1250,6 +1250,82 @@ static int do_pin(int argc, char **argv)
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
+	/* BPF_F_PATH_FD applies only to BPF_OBJ_PIN/BPF_OBJ_GET. */
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
@@ -1301,9 +1377,14 @@ static int do_create(int argc, char **argv)
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
@@ -1474,6 +1555,7 @@ static int do_help(int argc, char **argv)
 		"       DATA := { [hex] BYTES }\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       VALUE := { DATA | MAP | PROG }\n"
+		"       FLAGS := { integer | BPF_F_NAME[,BPF_F_NAME...] }\n"
 		"       UPDATE_FLAGS := { any | exist | noexist }\n"
 		"       TYPE := { hash | array | prog_array | perf_event_array | percpu_hash |\n"
 		"                 percpu_array | stack_trace | cgroup_array | lru_hash |\n"
-- 
2.55.0

