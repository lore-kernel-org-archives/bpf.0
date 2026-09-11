Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23273DDDA1
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095058; cv=none; b=Ed+jVAQryWQ1ojdNcAQfKzWItPgQk6EGMNhdnjMHNFzDYJzG1R84u3+lO+YYaEztfZ2kLSjd6aV0eNLRj/xOv0IQryRCDC1u01vehbcDom9y1JE9F3Jhu5AtGuJVfG2YN3Ub+KJ1m57TmwbkGybKWNXYGPkz5+OdkvV6PTiD10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095058; c=relaxed/simple;
	bh=eVKqhebTBXzDhIGN6swy4CPYlSmFLbcQioQoDeSib7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfcjGTVmAXoeEyY9MwcOmPDvCPX6McUJL2/ifajB1H9xqgHY0Tqm501M6QsM+gQqSX5sQRl4o6FlhQsCgPyTpJJBiIO4RK8+0jthXlhUdsk0/qfS5+LeMW9SLO86tGcT5SeVyi9yciOxHzDA+FHj25M3j+vvU3O/7SP03/Vxzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjQ5509g; arc=none smtp.client-ip=74.125.228.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjQ5509g"
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cc4ae01fe88so240479a12.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095056; x=1789699856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yL0iK8iM182ITjV+IRNoyKiJ/G27RWOlI9LBB+dre8E=;
        b=YjQ5509gr5virNjmuIkNy3I2tmeYDkwqmyP5O0nxMDQ8OELxbi/wD9HzLWdNeAjyH3
         0DiZIfS0+/L9NwCNEhoXa2cHzr/iCuK6tU2iudtF2ciCAiCJoFMWRvMRB8o/ieXNp5U8
         99ThSjeq2W+zCdpAxLht5N+uujSQSv1KJnCCAG6GXEpNPRwfqiun8I7kQGZPKrRMpOFC
         ALqfiOCgyK7CY/aOV3odZhesZxndJWlqd5dTuRaRynigmH134ucKxOQEv1lfTAOmCx57
         WvV8+JYUfY8agYc+PypSQxYQEsUNrAJR/Xsm09cCONGvjkqPzUsp9q27+ImtYn6sWfcA
         Kkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095056; x=1789699856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yL0iK8iM182ITjV+IRNoyKiJ/G27RWOlI9LBB+dre8E=;
        b=ocwtl5mqYNsZ9UVblxgIKA6Pa1blOWe9OyGpLaXojc13hDUXkPWDdyWKGXAXcPUhZ6
         KnJ3O7fswN8TOPetz+6UbJAb5NShUL0HALUJuyshLR6vgXypUU9mc/XjE9RlJ7KubL1s
         GYl+2NphW1VAiwksWZdyvoQFb62hq6ptCXFpWNlhH3D0A1fbwTaK+Ohn85L8HY8nzG7K
         QOdImtAkrNmjAUTrU7n1grh8F+RBaVN1XgHgdplPgvL4ou6WBqkMyC3TjE19xD6g8WRM
         O5NGZ8ruLozaxdj3mqOKXAgjMRYzj/g/Hn8q8XOyx7J7l+FUZ/A7l2Yb3GQA4KfgmWxR
         fo/A==
X-Forwarded-Encrypted: i=1; AKwUvBxfmi4EO3BIKTFr5HoKzQjQvNexaxAtmnENFAdKhbAcv4tyoo4xTD2YvJro5OrZf8PEYVY=@vger.kernel.org
X-Gm-Message-State: AFuF++kt/7E/5bx+tcXj7Esoy2d5VwqKTO+A/iPsMBKtbbP3VW/cnGyX
	WHRyya8xo/+eYB+1IDE0++S+oulElxmpCPSv/ur9D/+r+YBrYAMVaNx8
X-Gm-Gg: AYBFou0cBAGR0GzR7jE/3LP/XLRTKeZuAhnb4rAjrsLBZWWvRD+t5pzQNgjJm5CC8qV
	lu+WtZiw3C+OaLr8O37G6swZJJYR94+h1Du52lYptLTdL8KbZ2ewgBvfRbBuhkTW4cZTXz6Lp96
	o8Os2UcJQnNyEm1gBnfudm+dAV0f9ltK4pAwi3U1/fh8KqkmFyDeT1I6EcNVOBQCWBw6COFJ58w
	ZVYPuUlBh8HgzIwjdqk6lh7y1I5NK7RzWxba9eMDyzPNda49RBrc7G23CJwaRnamG5l2/HgaN4Z
	8J20E9+KYK+ZC14506KnH+hb9eLoTY4DIus5zMXffhQV71goKoQE03jWq2Ddt7hvYN/aJ8mcNiV
	RT8Fc5cQlpoVJvw61oW5dhX/KARFFc6DUjodBwjJ3fgOTBO39rBV8zv5twGGo21M6Xfm3eAlx+Q
	HnvderQPdi3KiBGUacAKMPyyFOTKAJFSbH3j6stVFc6L2yXdvSSmGDkMXmzleeAiM5
X-Received: by 2002:a05:6a00:a254:b0:86a:9ddc:7ee5 with SMTP id d2e1a72fcca58-86b30413307mr3734934b3a.2.1789095055934;
        Thu, 10 Sep 2026 19:50:55 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29bb8f28sm385299b3a.40.2026.09.10.19.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 19:50:55 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 1/2] bpftool: Accept symbolic map creation flags
Date: Fri, 11 Sep 2026 10:50:43 +0800
Message-ID: <20260911025044.190540-2-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911025044.190540-1-diannaaav@gmail.com>
References: <20260911025044.190540-1-diannaaav@gmail.com>
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
base-0 numeric input, including bits unknown to this bpftool.

Reject empty names, unknown names, mixed numeric and symbolic lists,
and values outside the unsigned 32-bit range. Limit symbolic names to
map creation flags and let the kernel validate map-specific combinations.
Document the syntax and complete names within comma-separated lists.

Avoid appending a space to completed list elements so another flag can
be added to the same argument.

Link: https://github.com/libbpf/bpftool/issues/57

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpftool/Documentation/bpftool-feature.rst | 10 ++-
 .../bpf/bpftool/Documentation/bpftool-map.rst | 14 ++-
 tools/bpf/bpftool/bash-completion/bpftool     | 22 ++++-
 tools/bpf/bpftool/feature.c                   |  7 +-
 tools/bpf/bpftool/main.h                      |  1 +
 tools/bpf/bpftool/map.c                       | 85 ++++++++++++++++++-
 6 files changed, 126 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-feature.rst b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
index c7f837898bc7..597f2426d255 100644
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
index 5daf3de5c744..5a5c26f789cd 100644
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
@@ -76,9 +77,16 @@ bpftool map { show | list }   [*MAP*]
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
index 75cbcb512eba..ea3f521b6f08 100644
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
index 0f6070a0c8e7..b5419d5a661a 100644
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
index 9315a1db1f7c..3e2856c9f595 100644
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
index 684a8fb72414..4445014247d6 100644
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

