Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA2367B7C;
	Tue, 19 May 2026 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210116; cv=none; b=Sn7bzOXitDzM9029VyX7Jzvje1PIr81f6UU7g05bBVL8bD//1a6kqgnElLlNNFTeS2ehfaH3BOewb/G5Ivc/qV4/ln80xn7I+vmBCU9NbZF0DADEguFyVfSE7Q2r2eHdbeQ7C9VKvVrgP7RSpsvm/q3vOwUmGMNEDn4z7/0kfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210116; c=relaxed/simple;
	bh=kTeMQPWSyv5X8+4cOAfZQkRK1bxLFJ9SnssVz2blj6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dUF05n8z4VQzEOXa1hPXtpWCmo7VoIF6+sWDW2bpAmSbORoz5JYIQeoCNnf9O2xj/mF3EpUwaXxV7+Mpp+/kImD9N1e3nnY8hjNM+uJL6a4CF+JwZvgPmaWwbwxdy6SGtI3EDGKj14qPqUQSMwurFOjEaZNJi1ntnHszwQAellE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 6D88640768;
	Tue, 19 May 2026 17:01:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 319AA2F;
	Tue, 19 May 2026 17:01:47 +0000 (UTC)
Date: Tue, 19 May 2026 13:01:44 -0400
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
Subject: [PATCH v5] tracing/eprobes: Allow use of BTF names to dereference
 pointers
Message-ID: <20260519130144.40e71a00@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5u1brxyxe8s6815wmwonsc1wf7fs8c9n
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 319AA2F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19jMf6aI0/pRgolw+6PhbjW/So5NJidAKE=
X-HE-Tag: 1779210107-832206
X-HE-Meta: U2FsdGVkX1/rnB1WCtrXE1plXwuW8+psiKrUeohyvZIA7RjT62uEDyyXW9pm9gaZXoRznuVfNx+uk89N5875McAWGVpdyOJsIwTTGJEi81YTbPU8njMhuvwFSIFInzMZNI0eWDQQbhAtqLojdlB5q5W76jM0Pag6f5tyrmwK4/KpQjgSmLn5KcydhMwkRA1R/uTbFo/Tc9qME7IlkuXFoLH6Z6L1PsNvSQFItK2QVpOSeYqHFtC7u8oElGWbi9iXkLGJwKI+Tjj76KHl55SaokLoMqBpIh/ZSzBdQ1rrbwOh8rPdGCF5A4wqJVrO/2gWSjCIvGBCcHBsE3f0rC+As+3ONo6VDCc6q+Kvii7b6Jyy/9calaAugYepiE2YeRt8cXtB3amju+2Cq7mlu/PYk+ZiY73RYox8uOmnqkPY2m5e5rjz/IjmCgmHpb+erlGGjT6dZ4J0MC2PSNy5nq51jA==

From: Steven Rostedt <rostedt@goodmis.org>

Add syntax to the parsing of eprobes to be able to typecast a trace event
field that is a pointer to a structure.

Currently, a dereference must be a number, where the user has to figure
out manually the offset of a member of a structure that they want to
dereference.

But for event probes that records a field that happens to be a pointer to
a structure, it cannot dereference these values with BTF naming, but
must use numerical offsets.

For example, to find out what device a sk_buff is pointing to in the
net_dev_xmit trace event, one must first use gdb to find the offsets of the
members of the structures:

 (gdb) p &((struct sk_buff *)0)->dev
 $1 = (struct net_device **) 0x10
 (gdb) p &((struct net_device *)0)->name
 $2 = (char (*)[16]) 0x118

And then use the raw numbers to dereference:

  # echo 'e:xmit net.net_dev_xmit +0x118(+0x10($skbaddr)):string' >> dynamic_events

If BTF is in the kernel, then instead, the skbaddr can be typecast to
sk_buff and use the normal dereference logic.

  # echo 'e:xmit net.net_dev_xmit (sk_buff)skbaddr->dev->name:string' >> dynamic_events
  # echo 1 > events/eprobes/xmit/enable
  # cat trace
[..]
    sshd-session-1022    [000] b..2.   860.249343: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.250061: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.250142: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.263553: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.283820: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.302716: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.322905: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.342828: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.362268: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.382335: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.400856: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.419893: xmit: (net.net_dev_xmit) arg1="enp7s0"

The syntax is simply: (STRUCT)(FIELD)->MEMBER[->MEMBER..]

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes from v4: https://patch.msgid.link/20260518232312.0c78f055@gandalf.local.home

- Only describe this for eprobes, as that is currently the only user of
  this. Kprobes registers can come later. (Sashiko)

- Update the documentation to only be in the eprobetrace.rst.

- Make the btf value separate for structures and functions. As a function
  may use a BTF from a module, it can point to a structure that is in
  vmlinux. Make them separate and add a ctx_btf() helper function to
  figure out which one to use. (Masami Hiramatsu)

- Remove updating query_btf_context() by having it check funcname first.
  The above ctx_btf() helper fixes this.

- Rename TPARG_FL_STRUCT to TPARG_FL_TYPECAST (Masami Hiramatsu)

- Have the typecast code call parse_btf_arg() directly, instead of going
  through parse_probe_vars(). This fixes issues with updating the pcode
  value, and simplifies the formatting and code (Sashiko).

  Added a parse_trace_event() helper to duplicate the handling of
  TPARG_FL_TEVENT.

- Use "goto found_type;" instead of relying on type being NULL in
  parse_btf_arg(). (Masami Hiramatsu)

- Add query_btf_struct() stub function when CONFIG_PROBE_EVENTS_BTF_ARGS
  is not defined. (kernel test robot)

- Remove need for '*' in typecast (Masami Hiramatsu)

- Have the event fields not use '$' when the typecast is used.
  (Masami Hiramatsu)

 Documentation/trace/eprobetrace.rst |   4 +
 kernel/trace/trace_probe.c          | 158 ++++++++++++++++++++++------
 kernel/trace/trace_probe.h          |   4 +
 3 files changed, 135 insertions(+), 31 deletions(-)

diff --git a/Documentation/trace/eprobetrace.rst b/Documentation/trace/eprobetrace.rst
index 89b5157cfab8..fe3602540569 100644
--- a/Documentation/trace/eprobetrace.rst
+++ b/Documentation/trace/eprobetrace.rst
@@ -46,6 +46,10 @@ Synopsis of eprobe_events
 		  (x8/x16/x32/x64), VFS layer common type(%pd/%pD), "char",
                   "string", "ustring", "symbol", "symstr" and "bitfield" are
                   supported.
+  (STRUCT)FIELD->MEMBER[->MEMBER] : If BTF is supported, typecast FIELD to
+                  a pointer to STRUCT and then derference the pointer defined by
+                  ->MEMBER. Note that when this is used, the FIELD name does not
+                  need to be prefixed with a '$'.
 
 Types
 -----
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e0d3a0da26af..cd54deb985f4 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -376,11 +376,17 @@ static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
 		&& BTF_INT_BITS(intdata) == 8;
 }
 
+static struct btf *ctx_btf(struct traceprobe_parse_context *ctx)
+{
+	return ctx->flags & TPARG_FL_TYPECAST ?
+		ctx->struct_btf : ctx->btf;
+}
+
 static int check_prepare_btf_string_fetch(char *typename,
 				struct fetch_insn **pcode,
 				struct traceprobe_parse_context *ctx)
 {
-	struct btf *btf = ctx->btf;
+	struct btf *btf = ctx_btf(ctx);
 
 	if (!btf || !ctx->last_type)
 		return 0;
@@ -464,6 +470,27 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
 	return NULL;
 }
 
+static int query_btf_struct(const char *sname, struct traceprobe_parse_context *ctx)
+{
+	int id;
+
+	if (!ctx->struct_btf) {
+		struct btf *btf;
+
+		id = bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
+		if (id < 0)
+			return id;
+		ctx->struct_btf = btf;
+	} else {
+		id = btf_find_by_name_kind(ctx->struct_btf, sname, BTF_KIND_STRUCT);
+		if (id < 0)
+			return id;
+	}
+
+	ctx->last_struct = btf_type_by_id(ctx->struct_btf, id);
+	return 0;
+}
+
 static int query_btf_context(struct traceprobe_parse_context *ctx)
 {
 	const struct btf_param *param;
@@ -515,6 +542,10 @@ static void clear_btf_context(struct traceprobe_parse_context *ctx)
 		ctx->params = NULL;
 		ctx->nr_params = 0;
 	}
+	if (ctx->struct_btf) {
+		btf_put(ctx->struct_btf);
+		ctx->last_struct = NULL;
+	}
 }
 
 /* Return 1 if the field separator is arrow operator ('->') */
@@ -554,22 +585,29 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 	struct fetch_insn *code = *pcode;
 	const struct btf_member *field;
 	u32 bitoffs, anon_offs;
+	bool is_struct = ctx->flags & TPARG_FL_TYPECAST;
+	struct btf *btf = ctx_btf(ctx);
 	char *next;
 	int is_ptr;
 	s32 tid;
 
 	do {
-		/* Outer loop for solving arrow operator ('->') */
-		if (BTF_INFO_KIND(type->info) != BTF_KIND_PTR) {
-			trace_probe_log_err(ctx->offset, NO_PTR_STRCT);
-			return -EINVAL;
-		}
-		/* Convert a struct pointer type to a struct type */
-		type = btf_type_skip_modifiers(ctx->btf, type->type, &tid);
-		if (!type) {
-			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
-			return -EINVAL;
+		if (!is_struct) {
+			/* Outer loop for solving arrow operator ('->') */
+			if (BTF_INFO_KIND(type->info) != BTF_KIND_PTR) {
+				trace_probe_log_err(ctx->offset, NO_PTR_STRCT);
+				return -EINVAL;
+			}
+
+			/* Convert a struct pointer type to a struct type */
+			type = btf_type_skip_modifiers(btf, type->type, &tid);
+			if (!type) {
+				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+				return -EINVAL;
+			}
 		}
+		/* Only the first type can skip being a pointer */
+		is_struct = false;
 
 		bitoffs = 0;
 		do {
@@ -580,7 +618,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 				return is_ptr;
 
 			anon_offs = 0;
-			field = btf_find_struct_member(ctx->btf, type, fieldname,
+			field = btf_find_struct_member(btf, type, fieldname,
 						       &anon_offs);
 			if (IS_ERR(field)) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
@@ -602,7 +640,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 				ctx->last_bitsize = 0;
 			}
 
-			type = btf_type_skip_modifiers(ctx->btf, field->type, &tid);
+			type = btf_type_skip_modifiers(btf, field->type, &tid);
 			if (!type) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 				return -EINVAL;
@@ -627,6 +665,26 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 	return 0;
 }
 
+
+static int parse_trace_event(char *arg, struct fetch_insn *code,
+			     struct traceprobe_parse_context *ctx)
+{
+	int ret;
+
+	if (code->data)
+		return -EFAULT;
+	ret = parse_trace_event_arg(arg, code, ctx);
+	if (!ret)
+		return 0;
+	if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
+		code->op = FETCH_OP_COMM;
+		return 0;
+	}
+	/* backward compatibility */
+	ctx->offset = 0;
+	return -EINVAL;
+}
+
 static int __store_entry_arg(struct trace_probe *tp, int argnum);
 
 static int parse_btf_arg(char *varname,
@@ -636,11 +694,12 @@ static int parse_btf_arg(char *varname,
 	struct fetch_insn *code = *pcode;
 	const struct btf_param *params;
 	const struct btf_type *type;
+	struct btf *btf = ctx_btf(ctx);
 	char *field = NULL;
 	int i, is_ptr, ret;
 	u32 tid;
 
-	if (WARN_ON_ONCE(!ctx->funcname))
+	if (WARN_ON_ONCE(!ctx->funcname && !(ctx->flags & TPARG_FL_TYPECAST)))
 		return -EINVAL;
 
 	is_ptr = split_next_field(varname, &field, ctx);
@@ -653,6 +712,14 @@ static int parse_btf_arg(char *varname,
 		return -EOPNOTSUPP;
 	}
 
+	if (ctx->flags & TPARG_FL_TEVENT) {
+		int ret;
+
+		ret = parse_trace_event(varname, code, ctx);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (ctx->flags & TPARG_FL_RETURN && !strcmp(varname, "$retval")) {
 		code->op = FETCH_OP_RETVAL;
 		/* Check whether the function return type is not void */
@@ -672,7 +739,7 @@ static int parse_btf_arg(char *varname,
 		return 0;
 	}
 
-	if (!ctx->btf) {
+	if (!btf) {
 		ret = query_btf_context(ctx);
 		if (ret < 0 || ctx->nr_params == 0) {
 			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
@@ -682,7 +749,7 @@ static int parse_btf_arg(char *varname,
 	params = ctx->params;
 
 	for (i = 0; i < ctx->nr_params; i++) {
-		const char *name = btf_name_by_offset(ctx->btf, params[i].name_off);
+		const char *name = btf_name_by_offset(btf, params[i].name_off);
 
 		if (name && !strcmp(name, varname)) {
 			if (tparg_is_function_entry(ctx->flags)) {
@@ -704,15 +771,22 @@ static int parse_btf_arg(char *varname,
 			goto found;
 		}
 	}
+
+	if (ctx->flags & TPARG_FL_TYPECAST) {
+		type = ctx->last_struct;
+		goto found_type;
+	}
+
 	trace_probe_log_err(ctx->offset, NO_BTFARG);
 	return -ENOENT;
 
 found:
-	type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
+	type = btf_type_skip_modifiers(btf, tid, &tid);
 	if (!type) {
 		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 		return -EINVAL;
 	}
+found_type:
 	/* Initialize the last type information */
 	ctx->last_type = type;
 	ctx->last_bitoffs = 0;
@@ -727,7 +801,7 @@ static int parse_btf_arg(char *varname,
 static const struct fetch_type *find_fetch_type_from_btf_type(
 					struct traceprobe_parse_context *ctx)
 {
-	struct btf *btf = ctx->btf;
+	struct btf *btf = ctx_btf(ctx);
 	const char *typestr = NULL;
 
 	if (btf && ctx->last_type)
@@ -764,6 +838,11 @@ static void clear_btf_context(struct traceprobe_parse_context *ctx)
 	ctx->btf = NULL;
 }
 
+static int query_btf_struct(const char *sname, struct traceprobe_parse_context *ctx)
+{
+	return -EOPNOTSUPP;
+}
+
 static int query_btf_context(struct traceprobe_parse_context *ctx)
 {
 	return -EOPNOTSUPP;
@@ -953,18 +1032,9 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
 	int len;
 
 	if (ctx->flags & TPARG_FL_TEVENT) {
-		if (code->data)
-			return -EFAULT;
-		ret = parse_trace_event_arg(arg, code, ctx);
-		if (!ret)
-			return 0;
-		if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
-			code->op = FETCH_OP_COMM;
-			return 0;
-		}
-		/* backward compatibility */
-		ctx->offset = 0;
-		goto inval;
+		if (parse_trace_event(arg, code, ctx) < 0)
+			goto inval;
+		return 0;
 	}
 
 	if (str_has_prefix(arg, "retval")) {
@@ -1231,6 +1301,30 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 				code->op = FETCH_OP_IMM;
 		}
 		break;
+	case '(':
+		tmp = strchr(arg, ')');
+		if (!tmp) {
+			trace_probe_log_err(ctx->offset + strlen(arg),
+					    DEREF_OPEN_BRACE);
+			return -EINVAL;
+		}
+		*tmp = '\0';
+		ret = query_btf_struct(arg + 1, ctx);
+		*tmp = ')';
+
+		if (ret < 0) {
+			trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
+			return -EINVAL;
+		}
+
+		ctx->flags |= TPARG_FL_TYPECAST;
+		tmp++;
+
+		ctx->offset += tmp - arg;
+		ret = parse_btf_arg(tmp, pcode, end, ctx);
+		ctx->flags &= ~TPARG_FL_TYPECAST;
+		ctx->last_struct = NULL;
+		break;
 	default:
 		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
 			if (!tparg_is_function_entry(ctx->flags) &&
@@ -1504,6 +1598,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
 
 	ctx->last_type = NULL;
+	ctx->last_struct = NULL;
 	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
 			      ctx);
 	if (ret < 0)
@@ -1705,13 +1800,14 @@ static int sprint_nth_btf_arg(int idx, const char *type,
 			      struct traceprobe_parse_context *ctx)
 {
 	const char *name;
+	struct btf *btf = ctx_btf(ctx);
 	int ret;
 
 	if (idx >= ctx->nr_params) {
 		trace_probe_log_err(0, NO_BTFARG);
 		return -ENOENT;
 	}
-	name = btf_name_by_offset(ctx->btf, ctx->params[idx].name_off);
+	name = btf_name_by_offset(btf, ctx->params[idx].name_off);
 	if (!name) {
 		trace_probe_log_err(0, NO_BTF_ENTRY);
 		return -ENOENT;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 262d8707a3df..6735b8b2432b 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -394,6 +394,7 @@ static inline int traceprobe_get_entry_data_size(struct trace_probe *tp)
  * TPARG_FL_KERNEL and TPARG_FL_USER are also mutually exclusive.
  * TPARG_FL_FPROBE and TPARG_FL_TPOINT are optional but it should be with
  * TPARG_FL_KERNEL.
+ * TPARG_FL_TYPECAST is set if an argument was typecast to a structure.
  */
 #define TPARG_FL_RETURN BIT(0)
 #define TPARG_FL_KERNEL BIT(1)
@@ -402,6 +403,7 @@ static inline int traceprobe_get_entry_data_size(struct trace_probe *tp)
 #define TPARG_FL_USER   BIT(4)
 #define TPARG_FL_FPROBE BIT(5)
 #define TPARG_FL_TPOINT BIT(6)
+#define TPARG_FL_TYPECAST BIT(7)
 #define TPARG_FL_LOC_MASK	GENMASK(4, 0)
 
 static inline bool tparg_is_function_entry(unsigned int flags)
@@ -422,7 +424,9 @@ struct traceprobe_parse_context {
 	const struct btf_param *params;	/* Parameter of the function */
 	s32 nr_params;			/* The number of the parameters */
 	struct btf *btf;		/* The BTF to be used */
+	struct btf *struct_btf;		/* The BTF to be used for structs */
 	const struct btf_type *last_type;	/* Saved type */
+	const struct btf_type *last_struct;	/* Saved structure */
 	u32 last_bitoffs;		/* Saved bitoffs */
 	u32 last_bitsize;		/* Saved bitsize */
 	struct trace_probe *tp;
-- 
2.53.0

