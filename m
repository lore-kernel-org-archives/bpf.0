Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF47625;
	Sat, 16 May 2026 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778967205; cv=none; b=j9RnU9prjLYLyDy7VUSZE9SMkpDALW7cSoKmeOm3IMlIlHb0tYCJuMts1Z9jQa1r2jTDcJIVCQJyfbtVEWU/X6BCoWzLtJ5s8AQ0ykhk8RUQsjz0cCrRZrE5w+2bDduwSaUckuxoFUZGqeYKyJbnyL9DDjLWtXYjc4FOEik2VH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778967205; c=relaxed/simple;
	bh=lEXWcVBf4aU+c90Kj7fPIN4doCUUwZX7/RxIJgIzes0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sXIgA2ZMNXvBd+JxzhCHT8i9p1vEoipVpPLl2Eo+TJU7L4o96w6RbNwtAsE0TEv0KxE5VoT+NAMvU5IsTii5LuF9l9YM/qw2drUp3dx8e9dXTFk/6NUM3p0rJeVPdfji6I6KobJSW/DrneP0jLPTP8eAXEmyHixprRekRzdl7d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B15F61C02D1;
	Sat, 16 May 2026 21:33:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 5B0A42000E;
	Sat, 16 May 2026 21:33:12 +0000 (UTC)
Date: Sat, 16 May 2026 17:33:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH v2] tracing/probes: Allow use of BTF names to dereference
 pointers
Message-ID: <20260516173310.1dbad146@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5B0A42000E
X-Stat-Signature: 136d9wdf4tuyhh4r4pdugsg4pprfdni9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+C61qPPJ4runrvhZdWElO3A/yFAI1Q3js=
X-HE-Tag: 1778967192-258273
X-HE-Meta: U2FsdGVkX1+l0qZyFu3IauMDLtCktkJxQ2UoGRAgGz/vKX85AoscdKUUbiRhQcEf/i1w8OcPQ87SyQ4JjoToonD0u5FcPaQti9z7N9XwuxLWITRkFQIy2t57q0hZwyTyoRO3iTuSf011ikxnHXNynwPJvdexkGXFY4+1JFvgrx089Sb2z7VdjiGfsIpHAj9U1ZCxgkTboE1BZCby8JKTmKbEMaGRX8uWTW8tjxXYViC+cCugdTFaunz7D/Q2XHF0Qdp/lA4wKGhWQROMunlcNdDnmfUAgaHOVfyRVgAY81uSog/4ZDOS8Yw+Z3axxDqqo6jEeWibuO6C29RX7sbiUC14LG33fG1ni60eJ9npsh9URFDXK6HI1jcXdXUD3K02tXCQRCZAWuYYtKY7ZtQut2eZ8cGNJSYM/M8y5rKHG9iPILFtDYiiblL28J75j82toPqK7BbvEY1Xqa/FNXfIfA==

From: Steven Rostedt <rostedt@goodmis.org>

Add syntax to the FETCHARGS parsing of probes to allow the use of
structure and member names to get the offsets to dereference pointers.

Currently, a dereference must be a number, where the user has to figure
out manually the offset of a member of a structure that they want to
reference. For example, to get the size of a kmem_cache that was passed to
the function kmem_cache_alloc_noprof, one would need to do:

 # cd /sys/kernel/tracing
 # echo 'f:cache kmem_cache_alloc_noprof size=+0x18($arg1):u32' >> dynamic_events

This requires knowing that the offset of size is 0x18, which can be found
with gdb:

  (gdb) p &((struct kmem_cache *)0)->size
  $1 = (unsigned int *) 0x18

If BTF is in the kernel, it can be used to find this with names, where the
user doesn't need to find the actual offset:

 # echo 'f:cache kmem_cache_alloc_noprof size=+kmem_cache.size($arg1):u32' >> dynamic_events

Instead of the "+0x18", it would have "+kmem_cache.size" where the format is:

  +STRUCT.MEMBER[.MEMBER[..]]

The delimiter is '.' and the first item is the structure name. Then the
member of the structure to get the offset of. If that member is an
embedded structure, another '.MEMBER' may be added to get the offset of
its members with respect to the original value.

  "+kmem_cache.size($arg1)" is equivalent to:

  (*(struct kmem_cache *)$arg1).size

Anonymous structures are also handled:

  # echo 'e:xmit net.net_dev_xmit +net_device.name(+sk_buff.dev($skbaddr)):string' >> dynamic_events

Where "+net_device.name(+sk_buff.dev($skbaddr))" is equivalent to:

  (*(struct net_device *)((*(struct sk_buff *)($skbaddr)).dev)->name)

Note that "dev" of struct sk_buff is inside an anonymous structure:

struct sk_buff {
	union {
		struct {
			/* These two members must be first to match sk_buff_head. */
			struct sk_buff		*next;
			struct sk_buff		*prev;

			union {
				struct net_device	*dev;
				[..]
			};
		};
		[..]
	};

This will allow up to three deep of anonymous structures before it will
fail to find a member.

The above produces:

    sshd-session-1080    [000] b..5.  1526.337161: xmit: (net.net_dev_xmit) arg1="enp7s0"

And nested structures can be found by adding more members to the arg:

  # echo 'f:read filemap_readahead.isra.0 file=+0(+dentry.d_name.name(+file.f_path.dentry($arg2))):string' >> dynamic_events

The above is equivalent to:

  *((*(struct dentry *)(*(struct file *)$arg2).f_path.dentry)->d_name.name)

And produces:

       trace-cmd-1381    [002] ...1.  2082.676268: read: (filemap_readahead.isra.0+0x0/0x150) file="trace.dat"

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20250729113335.2e4f087d@batman.local.home

- Pass error info back so that error_log can display what went wrong
  (Masami Hiramatsu)

- Use __btf_member_bit_offset() to get nested struct member offsets
  (Douglas Raillard)

- Add btf_put(btf) (Jiri Olsa)

 Documentation/trace/kprobetrace.rst |   3 +
 kernel/trace/trace_btf.c            | 111 ++++++++++++++++++++++++++++
 kernel/trace/trace_btf.h            |  10 +++
 kernel/trace/trace_probe.c          |  19 ++++-
 kernel/trace/trace_probe.h          |   4 +-
 5 files changed, 144 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 3b6791c17e9b..00273157100c 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -54,6 +54,8 @@ Synopsis of kprobe_events
   $retval	: Fetch return value.(\*2)
   $comm		: Fetch current task comm.
   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
+  +STRUCT.MEMBER[.MEMBER[..]](FETCHARG) : If BTF is supported, Fetch memory
+		  at FETCHARG + the offset of MEMBER inside of STRUCT.(\*5)
   \IMM		: Store an immediate value to the argument.
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
@@ -70,6 +72,7 @@ Synopsis of kprobe_events
         accesses one register.
   (\*3) this is useful for fetching a field of data structures.
   (\*4) "u" means user-space dereference. See :ref:`user_mem_access`.
+  (\*5) +STRUCT.MEMBER(FETCHARG) is equivalent to (*(struct STRUCT *)(FETCHARG)).MEMBER
 
 Function arguments at kretprobe
 -------------------------------
diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index 00172f301f25..be88cc4d97dd 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -120,3 +120,114 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 	return member;
 }
 
+#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
+
+static int find_member(const char *ptr, struct btf *btf,
+		       const struct btf_type **type, int level)
+{
+	const struct btf_member *member;
+	const struct btf_type *t = *type;
+	int i;
+
+	/* Max of 3 depth of anonymous structures */
+	if (level > 3)
+		return -E2BIG;
+
+	for_each_member(i, t, member) {
+		const char *tname = btf_name_by_offset(btf, member->name_off);
+
+		if (strcmp(ptr, tname) == 0) {
+			int offset = __btf_member_bit_offset(t, member);
+			*type = btf_type_by_id(btf, member->type);
+			return BITS_ROUNDDOWN_BYTES(offset);
+		}
+
+		/* Handle anonymous structures */
+		if (strlen(tname))
+			continue;
+
+		*type = btf_type_by_id(btf, member->type);
+		if (btf_type_is_struct(*type)) {
+			int offset = find_member(ptr, btf, type, level + 1);
+
+			if (offset < 0)
+				continue;
+
+			return offset + BITS_ROUNDDOWN_BYTES(member->offset);
+		}
+	}
+
+	return -ENOENT;
+}
+
+/**
+ * btf_find_offset - Find an offset of a member for a structure
+ * @arg: A structure name followed by one or more members
+ * @offset_p: A pointer to where to store the offset
+ *
+ * Will parse @arg with the expected format of: struct.member[[.member]..]
+ * It is delimited by '.'. The first item must be a structure type.
+ * The next are its members. If the member is also of a structure type it
+ * another member may follow ".member".
+ *
+ * Note, @arg is modified but will be put back to what it was on return.
+ *
+ * Returns: 0 on success and -EINVAL if no '.' is present
+ *    or -ENXIO if the structure or member is not found.
+ *    Returns -EINVAL if BTF is not defined.
+ *  On success, @offset_p will contain the offset of the member specified
+ *    by @arg.
+ */
+int btf_find_offset(char *arg, long *offset_p)
+{
+	const struct btf_type *t;
+	struct btf *btf;
+	long offset = 0;
+	char *ptr;
+	int ret;
+	s32 id;
+
+	ptr = strchr(arg, '.');
+	if (!ptr)
+		return -EINVAL;
+
+	*ptr = '\0';
+
+	ret = -ENXIO;
+	id = bpf_find_btf_id(arg, BTF_KIND_STRUCT, &btf);
+	if (id < 0)
+		goto error;
+
+	/* Get BTF_KIND_FUNC type */
+	t = btf_type_by_id(btf, id);
+
+	/* May allow more than one member, as long as they are structures */
+	do {
+		ret = -ENXIO;
+		if (!t || !btf_type_is_struct(t))
+			goto error;
+
+		*ptr++ = '.';
+		arg = ptr;
+		ptr = strchr(ptr, '.');
+		if (ptr)
+			*ptr = '\0';
+
+		ret = find_member(arg, btf, &t, 0);
+		if (ret < 0)
+			goto error;
+
+		offset += ret;
+
+	} while (ptr);
+
+	btf_put(btf);
+	*offset_p = offset;
+	return 0;
+
+error:
+	btf_put(btf);
+	if (ptr)
+		*ptr = '.';
+	return ret;
+}
diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
index 4bc44bc261e6..7b0797a6050b 100644
--- a/kernel/trace/trace_btf.h
+++ b/kernel/trace/trace_btf.h
@@ -9,3 +9,13 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 						const struct btf_type *type,
 						const char *member_name,
 						u32 *anon_offset);
+
+#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
+/* Will modify arg, but will put it back before returning. */
+int btf_find_offset(char *arg, long *offset);
+#else
+static inline int btf_find_offset(char *arg, long *offset)
+{
+	return -EINVAL;
+}
+#endif
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e0d3a0da26af..6fcede2de1a5 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1165,7 +1165,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 
 	case '+':	/* deref memory */
 	case '-':
-		if (arg[1] == 'u') {
+		if (arg[1] == 'u' && isdigit(arg[2])) {
 			deref = FETCH_OP_UDEREF;
 			arg[1] = arg[0];
 			arg++;
@@ -1178,7 +1178,22 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			return -EINVAL;
 		}
 		*tmp = '\0';
-		ret = kstrtol(arg, 0, &offset);
+		if (arg[0] != '-' && !isdigit(*arg)) {
+			int err = 0;
+			ret = btf_find_offset(arg, &offset);
+			switch (ret) {
+			case -ENODEV: err = TP_ERR_NOSUP_BTFARG; break;
+			case -E2BIG: err = TP_ERR_MEMBER_TOO_DEEP; break;
+			case -EINVAL: err = TP_ERR_BAD_STRUCT_FMT; break;
+			case -ENXIO: err = TP_ERR_BAD_BTF_TID; break;
+			}
+			if (err)
+				__trace_probe_log_err(ctx->offset, err);
+			if (ret < 0)
+				return ret;
+		} else {
+			ret = kstrtol(arg, 0, &offset);
+		}
 		if (ret) {
 			trace_probe_log_err(ctx->offset, BAD_DEREF_OFFS);
 			break;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 262d8707a3df..d649bb9f5b7c 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -563,7 +563,9 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
 	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
 	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),	\
-	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),
+	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"), \
+	C(MEMBER_TOO_DEEP,	"Too many indirections of anonymous structure"), \
+	C(BAD_STRUCT_FMT,	"Unknown BTF structure"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a
-- 
2.53.0

