Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548461A317D;
	Tue, 19 May 2026 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779160986; cv=none; b=d46g25/z6fiZszK+ggvboMBrJqXqldM+Z0vC0WII+6JUpVnaWp20D5XgiXnxzN1wc/sX/Ggqk60cStdOsvmNI1rDUkefbAWuJdoY+KT4kKIBBcEIMcuPxOHIlVvotKGhcvYLnnVrxv+bK8MN5UkAj+ccA0EGUqumX3Iiyz63mUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779160986; c=relaxed/simple;
	bh=7ksgAIhdmfwQmcfxOFgYVpxcH8aIUZbdHNZ5yqY94hE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Iqn1atcOBjD5jC2ODRYvCi+r9O41Akk4Sc4EYsd3GtCIVhC1WY0+2wIwTK+55HCL7fEgRBo85EgvryHcm1Eqox65HWx+WBVgWJPGzbGAQh0PELMhsQdgsRXDEValcVNzdINZ2NnkRNt+Qf4xFrl/LXfeZKndFLeo3bfbmAuO6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id CEFE91C0085;
	Tue, 19 May 2026 03:23:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id A38B120026;
	Tue, 19 May 2026 03:22:58 +0000 (UTC)
Date: Mon, 18 May 2026 23:23:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>,
 "Subject:[PATCH  v2]"@web.codeaurora.org, tracing/pr@web.codeaurora.org
Subject: [PATCH v4] tracing/probes: Allow use of BTF names to dereference
 pointers
Message-ID: <20260518232312.0c78f055@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A38B120026
X-Rspamd-Server: rspamout06
X-Stat-Signature: pz6mm1srrt9qxipi9kkt5b81disfde4t
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/nkEElyuwDZO8nXNDD9xaoXhJBHoNrHm4=
X-HE-Tag: 1779160978-619539
X-HE-Meta: U2FsdGVkX1+ykUv/9GuKr1vnu3I8gWdjRq7V2+P8yOCTmyWVgp7QslT1gy83K1Zk2HsA7FbReXXiQPmytlj2mGTda47g6qk7qfXq1vnwK7604wJilCollofBFAOhOYbGaOh/6MBvUtM20bvyJX1Rt9lJ9DKJdvQemsy7OIgHxTgMmqS0gXBFD98K5M4oboupP2RE7jO3ZWfn3Z+GI+QeN8tbTkQdt2yRd/O+L2CCIjBRSKMSX84CtI/IYuLuo4XrpEV2m/xqmosUUe40437V6HwqbmGEgGut94azPNWP1m/a9SS8WOxGntFV28pil4vJC7+uBNwltF7ukXk0kbuCQLKZplncccj9V7JGIkCJ6fXrYkzNI6Q0XIXnAI+J8kcoCbOdbFNdh0RbjuEm9T3keNIcGQiWQcfdtO/7YOesyLefifRB+loh1RniAaIAoMTPjqsM4RmQhVhz4l2KMmPj6Q==

From: Steven Rostedt <rostedt@goodmis.org>

Add syntax to the FETCHARGS parsing of probes to be able to typecast a
value to a pointer to a structure.

Currently, a dereference must be a number, where the user has to figure
out manually the offset of a member of a structure that they want to
dereference, unless the member is a function parameter that BTF already has
information about what structure the argument is pointing to.

But for event probes, or generic kprobes that records a register that
happens to be a pointer to a structure, they cannot dereference these
values with BTF naming, but must use numerical offsets.

For example, to find out what device a sk_buff is pointing to in the
net_dev_xmit trace event, one must first use gdb to find the offsets of the
members of the structures:

 (gdb) p &((struct sk_buff *)0)->dev
 $1 = (struct net_device **) 0x10
 (gdb) p &((struct net_device *)0)->name
 $2 = (char (*)[16]) 0x118

And then use the raw numbers to dereference:

  # echo 'e:xmit net.net_dev_xmit +0x118(+0x10($skbaddr)):string' >> dynamic_events

If BTF is in the kernel, then instead, the $skbaddr can be typecast to
sk_buff and use the normal dereference logic.

  # echo 'e:xmit net.net_dev_xmit (sk_buff*)$skbaddr->dev->name:string' >> dynamic_events
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

The syntax is simply: ([STRUCT]*)(VAR)->FIELD[->FIELD..]

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v3: https://patch.msgid.link/20260518095832.52659a3a@gandalf.local.home

 *** COMPLETE REWRITE FROM V3 ***

- Rewrote it to use typecasting instead of simply replacing BTF names with
  offsets.

 Documentation/trace/kprobetrace.rst |   3 +
 kernel/trace/trace_probe.c          | 110 ++++++++++++++++++++++++----
 kernel/trace/trace_probe.h          |   3 +
 3 files changed, 100 insertions(+), 16 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 3b6791c17e9b..450ac646fe4c 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -54,6 +54,9 @@ Synopsis of kprobe_events
   $retval	: Fetch return value.(\*2)
   $comm		: Fetch current task comm.
   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
+  (STRUCT*)FETCHARG->FIELD[->FIELD] : If BTF is supported, typecast FETCHARG to
+                  a pointer to STRUCT and then derference the pointer defined by
+                  ->FIELD.
   \IMM		: Store an immediate value to the argument.
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e0d3a0da26af..b0829eb1cb52 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -464,6 +464,26 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
 	return NULL;
 }
 
+static int query_btf_struct(const char *sname, struct traceprobe_parse_context *ctx)
+{
+	int id;
+
+	if (!ctx->btf) {
+		struct btf *btf;
+		id = bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
+		if (id < 0)
+			return -EINVAL;
+		ctx->btf = btf;
+	} else {
+		id = btf_find_by_name_kind(ctx->btf, sname, BTF_KIND_STRUCT);
+		if (id < 0)
+			return -EINVAL;
+	}
+
+	ctx->last_struct = btf_type_by_id(ctx->btf, id);
+	return 0;
+}
+
 static int query_btf_context(struct traceprobe_parse_context *ctx)
 {
 	const struct btf_param *param;
@@ -471,12 +491,12 @@ static int query_btf_context(struct traceprobe_parse_context *ctx)
 	struct btf *btf;
 	s32 nr;
 
-	if (ctx->btf)
-		return 0;
-
 	if (!ctx->funcname)
 		return -EINVAL;
 
+	if (ctx->btf)
+		return 0;
+
 	type = btf_find_func_proto(ctx->funcname, &btf);
 	if (!type)
 		return -ENOENT;
@@ -514,6 +534,7 @@ static void clear_btf_context(struct traceprobe_parse_context *ctx)
 		ctx->proto = NULL;
 		ctx->params = NULL;
 		ctx->nr_params = 0;
+		ctx->last_struct = NULL;
 	}
 }
 
@@ -554,22 +575,28 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 	struct fetch_insn *code = *pcode;
 	const struct btf_member *field;
 	u32 bitoffs, anon_offs;
+	bool is_struct = ctx->flags & TPARG_FL_STRUCT;
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
+			type = btf_type_skip_modifiers(ctx->btf, type->type, &tid);
+			if (!type) {
+				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+				return -EINVAL;
+			}
 		}
+		/* Only the first type can skip being a pointer */
+		is_struct = false;
 
 		bitoffs = 0;
 		do {
@@ -635,12 +662,12 @@ static int parse_btf_arg(char *varname,
 {
 	struct fetch_insn *code = *pcode;
 	const struct btf_param *params;
-	const struct btf_type *type;
+	const struct btf_type *type = NULL;
 	char *field = NULL;
 	int i, is_ptr, ret;
 	u32 tid;
 
-	if (WARN_ON_ONCE(!ctx->funcname))
+	if (WARN_ON_ONCE(!ctx->funcname && !(ctx->flags & TPARG_FL_STRUCT)))
 		return -EINVAL;
 
 	is_ptr = split_next_field(varname, &field, ctx);
@@ -704,11 +731,18 @@ static int parse_btf_arg(char *varname,
 			goto found;
 		}
 	}
+
+	if (ctx->flags & TPARG_FL_STRUCT) {
+		type = ctx->last_struct;
+		goto found;
+	}
+
 	trace_probe_log_err(ctx->offset, NO_BTFARG);
 	return -ENOENT;
 
 found:
-	type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
+	if (!type)
+		type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
 	if (!type) {
 		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 		return -EINVAL;
@@ -952,6 +986,12 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
 	int ret = 0;
 	int len;
 
+	if (ctx->flags & TPARG_FL_STRUCT) {
+		ret = parse_btf_arg(orig_arg, pcode, end, ctx);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (ctx->flags & TPARG_FL_TEVENT) {
 		if (code->data)
 			return -EFAULT;
@@ -1231,6 +1271,43 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 				code->op = FETCH_OP_IMM;
 		}
 		break;
+	case '(':
+		tmp = strrchr(arg, ')');
+		if (!tmp) {
+			trace_probe_log_err(ctx->offset + strlen(arg),
+					    DEREF_OPEN_BRACE);
+			return -EINVAL;
+		}
+
+		tmp--;
+		if (*tmp != '*') {
+			trace_probe_log_err(ctx->offset + (tmp - arg),
+					    NO_PTR_STRCT);
+			return -EINVAL;
+		}
+		*tmp = '\0';
+		ret = query_btf_struct(arg + 1, ctx);
+		*tmp = '*';
+
+		if (ret < 0) {
+			trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
+			return -EINVAL;
+		}
+
+		ctx->flags |= TPARG_FL_STRUCT;
+		tmp += 2;
+
+		if (*tmp != '$') {
+			trace_probe_log_err(ctx->offset + (tmp - arg),
+					    BAD_VAR);
+			return -EINVAL;
+		}
+
+		ctx->offset += tmp - arg;
+		ret = parse_probe_vars(tmp, type, pcode, end, ctx);
+		ctx->flags &= ~TPARG_FL_STRUCT;
+		ctx->last_struct = NULL;
+		break;
 	default:
 		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
 			if (!tparg_is_function_entry(ctx->flags) &&
@@ -1504,6 +1581,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
 
 	ctx->last_type = NULL;
+	ctx->last_struct = NULL;
 	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
 			      ctx);
 	if (ret < 0)
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 262d8707a3df..88ab9f6da591 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -394,6 +394,7 @@ static inline int traceprobe_get_entry_data_size(struct trace_probe *tp)
  * TPARG_FL_KERNEL and TPARG_FL_USER are also mutually exclusive.
  * TPARG_FL_FPROBE and TPARG_FL_TPOINT are optional but it should be with
  * TPARG_FL_KERNEL.
+ * TPARG_FL_STRUCT is set if an argument was typecast to a structure.
  */
 #define TPARG_FL_RETURN BIT(0)
 #define TPARG_FL_KERNEL BIT(1)
@@ -402,6 +403,7 @@ static inline int traceprobe_get_entry_data_size(struct trace_probe *tp)
 #define TPARG_FL_USER   BIT(4)
 #define TPARG_FL_FPROBE BIT(5)
 #define TPARG_FL_TPOINT BIT(6)
+#define TPARG_FL_STRUCT BIT(7)
 #define TPARG_FL_LOC_MASK	GENMASK(4, 0)
 
 static inline bool tparg_is_function_entry(unsigned int flags)
@@ -423,6 +425,7 @@ struct traceprobe_parse_context {
 	s32 nr_params;			/* The number of the parameters */
 	struct btf *btf;		/* The BTF to be used */
 	const struct btf_type *last_type;	/* Saved type */
+	const struct btf_type *last_struct;	/* Saved structure */
 	u32 last_bitoffs;		/* Saved bitoffs */
 	u32 last_bitsize;		/* Saved bitsize */
 	struct trace_probe *tp;
-- 
2.53.0

