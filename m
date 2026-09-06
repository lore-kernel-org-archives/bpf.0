Received: from out-utut-a193.jellyfish.systems (out-utut-a193.jellyfish.systems [198.177.127.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69B367B90
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.177.127.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714478; cv=none; b=HM21OqbrxHkjOYYT7Y7qq9LmyieEm3DD5hshpljxC0XhXTiNPb4ar19dBZLhaV5WkkyS0chs+w6uoqkNqSB5R8nC2YshERnBpyl2awypedbylIZTLCoEcPSpmSYLbPhUtHnyMYnnU2OgjPxGIdUbkwnTTUaFBgdbQkm6Oli6Kz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714478; c=relaxed/simple;
	bh=usxubgOoX74CgAcYdCMyfRvlDB7WtZG8c5wleHYh4gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHGVphyMIyqHW/f+LPUWa00uvzhOiyBV2Lnba1AfXk/XTmxXiYbZxN41FYpLtfGUJLx4P73bZ6xq2C5QAaRdvp7GcKS3fL/iy+CnXFh3gYhTntDnXNSNQfMGc3h4LBhLfVi0F9QkVA3FlgNv38NzeQ6P+7RTKuIuJWvA1R+iwn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=cjeMIX1Z; arc=none smtp.client-ip=198.177.127.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="cjeMIX1Z"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdGpq5khQz2xBb;
	Sun, 06 Sep 2026 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788714458;
	bh=cX4ZE1QxqcGy81AGsDk0TwQkgBBiC27MtNtkMQ1CotQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjeMIX1ZDCQCvCjZoD43VZ4qiMTOTSppmmIb8aiKPzCTPKPgBWEryxPT6zG6KZ1lW
	 r6S7cbm95pUP8Wgj+FcQ2i8f7WQl7KTu/zIpxbQ09AnLK9jKMtaJbkV7rM5i1h3TLG
	 sluwIE111w+F/oTc04kDvWMDmO0G6vo0Hg2sHqIPdDAc/rcy5oYxzdEFOCGP/5LjrT
	 cQIXC9FiIBwFGESE5hdDvtmiPzjhJY7Iz5X2/5l9NZ5yerT4/+eOtrXVApCQG25/iO
	 PaIJKRFbksVH587vkzgmp+Fv7EI2bMAZHNq+od3HMtHjpF/Be2Sv6Oj2DjskLxpwDN
	 9OhusA/WOvEhQ==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpftool: Accept symbolic map creation flags
Date: Mon,  7 Sep 2026 01:07:14 +0800
Message-ID: <20260906170715.1212085-2-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906170715.1212085-1-hi@tychen.cc>
References: <20260906170715.1212085-1-hi@tychen.cc>
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

Assisted-by: Codex:GPT-6
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/bpftool/Documentation/bpftool-map.rst | 13 +++-
 tools/bpf/bpftool/bash-completion/bpftool     | 25 +++++-
 tools/bpf/bpftool/map.c                       | 77 ++++++++++++++++++-
 3 files changed, 109 insertions(+), 6 deletions(-)

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
index 75cbcb512eb..95f16fff876 100644
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
@@ -729,7 +733,26 @@ _bpftool()
                             COMPREPLY=( $( compgen -W "$BPFTOOL_MAP_CREATE_TYPES" -- "$cur" ) )
                             return 0
                             ;;
-                        key|value|flags|entries)
+                        flags)
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

