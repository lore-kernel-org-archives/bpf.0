Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4486341;
	Wed, 15 Jul 2026 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080400; cv=none; b=H1hXqG+e1KWhtCXmWGqRHcHcdlT5+5NcbTf7+ErIOc2t3G6yPwVNhg7khOxmfXZHRL1GpBaU4HRj0bZtXFGYa+15S8hP4XQMwfww1yvTS9iDM/df1SC/NW7iI4EhDQgR2y8OxpyNM5UysgK4Jp7DLG11KcHweI0MVZUxvEhgerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080400; c=relaxed/simple;
	bh=PhcNvwSnjvy/2Zo2A00mnn0LBTk6NQqbMFVyrDmDk2k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pUSn3Vm3DBDvRFv1M+FCiSWkP0B2QPhyfuBGM8EPu0+LZJVocsofpXo1HYRkw+Dgq9X1/wvd4bdyY7K4jSOZEa2XZzN113+oQDS+XhKXWkeuYKRJ/X+eNtvwap5cvWdUatfsfNqW+R6GuS9NzO3E6vOi8WCeK0nqCBm50JYvUKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nd9Z1dgO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nd9Z1dgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798BA1F000E9;
	Wed, 15 Jul 2026 01:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784080399;
	bh=UXBW/juAIMWcu3PBqtxPKmUX6J4RCuOVZU0N0+X4O7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nd9Z1dgOG2tlkg9rPblaXC4y86/CW1Wvrr0GPBXeepYoY/mePFeTnd6XD3+dP4+lq
	 UFBPU25TjUgMnLCH+5+mDRvPIWXXmlv2tz+LHV4Yd6mdVZZgdXjY3JltowTmWsTh7P
	 SBntaUJxECYk8uYABVmXD93mvp95AAhp/A7BmASPTM7x+LziSDE6aPmfEj+vPuNp4k
	 thk7WOrBxyoFg91vLs01+1ObMghCb3ZttgM+L17zc/sAmFyLJoEHg3v99J69P2wXai
	 HmgxAe3UWivKgmulfxahUIIB03D7zGsLVcG4k5FVbJFvtXpqvBkaVEJ0kVlKPd4YMj
	 FnTarVnRo2DFg==
Date: Wed, 15 Jul 2026 10:53:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf/btf: Move tracing BTF APIs to the BTF library
Message-Id: <20260715105314.5708c8ab918718942fb5b31e@kernel.org>
In-Reply-To: <20260714103401.0aa3f9e0@gandalf.local.home>
References: <169694605862.516358.5321950027838863987.stgit@devnote2>
	<20260714103401.0aa3f9e0@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 10:34:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Whatever happened to this patch?

IIRC, this got rejected, so we ended up having
to keep maintaining it within the trace.
(because bpf does not use these functions.)

Thanks,

> 
> -- Steve
> 
> 
> On Tue, 10 Oct 2023 22:54:19 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Move the BTF APIs used in tracing to the BTF library code for sharing it
> > with others.
> > Previously, to avoid complex dependency in a series I made it on the
> > tracing tree, but now it is a good time to move it to BPF tree because
> > these functions are pure BTF functions.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  include/linux/btf.h        |   24 +++++++++
> >  kernel/bpf/btf.c           |  115 +++++++++++++++++++++++++++++++++++++++++
> >  kernel/trace/Makefile      |    1 
> >  kernel/trace/trace_btf.c   |  122 --------------------------------------------
> >  kernel/trace/trace_btf.h   |   11 ----
> >  kernel/trace/trace_probe.c |    2 -
> >  6 files changed, 140 insertions(+), 135 deletions(-)
> >  delete mode 100644 kernel/trace/trace_btf.c
> >  delete mode 100644 kernel/trace/trace_btf.h
> > 
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 928113a80a95..8372d93ea402 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -507,6 +507,14 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
> >  int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
> >  bool btf_types_are_same(const struct btf *btf1, u32 id1,
> >  			const struct btf *btf2, u32 id2);
> > +const struct btf_type *btf_find_func_proto(const char *func_name,
> > +					   struct btf **btf_p);
> > +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
> > +					   s32 *nr);
> > +const struct btf_member *btf_find_struct_member(struct btf *btf,
> > +						const struct btf_type *type,
> > +						const char *member_name,
> > +						u32 *anon_offset);
> >  #else
> >  static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
> >  						    u32 type_id)
> > @@ -559,6 +567,22 @@ static inline bool btf_types_are_same(const struct btf *btf1, u32 id1,
> >  {
> >  	return false;
> >  }
> > +static inline const struct btf_type *btf_find_func_proto(const char *func_name,
> > +							 struct btf **btf_p)
> > +{
> > +	return NULL;
> > +}
> > +static inline const struct btf_param *
> > +btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
> > +{
> > +	return NULL;
> > +}
> > +static inline const struct btf_member *
> > +btf_find_struct_member(struct btf *btf, const struct btf_type *type,
> > +		       const char *member_name, u32 *anon_offset)
> > +{
> > +	return NULL;
> > +}
> >  #endif
> >  
> >  static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 8090d7fb11ef..e5cbf3b31b78 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -912,6 +912,121 @@ static const struct btf_type *btf_type_skip_qualifiers(const struct btf *btf,
> >  	return t;
> >  }
> >  
> > +/*
> > + * Find a function proto type by name, and return the btf_type with its btf
> > + * in *@btf_p. Return NULL if not found.
> > + * Note that caller has to call btf_put(*@btf_p) after using the btf_type.
> > + */
> > +const struct btf_type *btf_find_func_proto(const char *func_name, struct btf **btf_p)
> > +{
> > +	const struct btf_type *t;
> > +	s32 id;
> > +
> > +	id = bpf_find_btf_id(func_name, BTF_KIND_FUNC, btf_p);
> > +	if (id < 0)
> > +		return NULL;
> > +
> > +	/* Get BTF_KIND_FUNC type */
> > +	t = btf_type_by_id(*btf_p, id);
> > +	if (!t || !btf_type_is_func(t))
> > +		goto err;
> > +
> > +	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> > +	t = btf_type_by_id(*btf_p, t->type);
> > +	if (!t || !btf_type_is_func_proto(t))
> > +		goto err;
> > +
> > +	return t;
> > +err:
> > +	btf_put(*btf_p);
> > +	return NULL;
> > +}
> > +
> > +/*
> > + * Get function parameter with the number of parameters.
> > + * This can return NULL if the function has no parameters.
> > + * It can return -EINVAL if the @func_proto is not a function proto type.
> > + */
> > +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
> > +{
> > +	if (!btf_type_is_func_proto(func_proto))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	*nr = btf_type_vlen(func_proto);
> > +	if (*nr > 0)
> > +		return (const struct btf_param *)(func_proto + 1);
> > +	else
> > +		return NULL;
> > +}
> > +
> > +#define BTF_ANON_STACK_MAX	16
> > +
> > +struct btf_anon_stack {
> > +	u32 tid;
> > +	u32 offset;
> > +};
> > +
> > +/*
> > + * Find a member of data structure/union by name and return it.
> > + * Return NULL if not found, or -EINVAL if parameter is invalid.
> > + * If the member is an member of anonymous union/structure, the offset
> > + * of that anonymous union/structure is stored into @anon_offset. Caller
> > + * can calculate the correct offset from the root data structure by
> > + * adding anon_offset to the member's offset.
> > + */
> > +const struct btf_member *btf_find_struct_member(struct btf *btf,
> > +						const struct btf_type *type,
> > +						const char *member_name,
> > +						u32 *anon_offset)
> > +{
> > +	struct btf_anon_stack *anon_stack;
> > +	const struct btf_member *member;
> > +	u32 tid, cur_offset = 0;
> > +	const char *name;
> > +	int i, top = 0;
> > +
> > +	anon_stack = kcalloc(BTF_ANON_STACK_MAX, sizeof(*anon_stack), GFP_KERNEL);
> > +	if (!anon_stack)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +retry:
> > +	if (!btf_type_is_struct(type)) {
> > +		member = ERR_PTR(-EINVAL);
> > +		goto out;
> > +	}
> > +
> > +	for_each_member(i, type, member) {
> > +		if (!member->name_off) {
> > +			/* Anonymous union/struct: push it for later use */
> > +			type = btf_type_skip_modifiers(btf, member->type, &tid);
> > +			if (type && top < BTF_ANON_STACK_MAX) {
> > +				anon_stack[top].tid = tid;
> > +				anon_stack[top++].offset =
> > +					cur_offset + member->offset;
> > +			}
> > +		} else {
> > +			name = btf_name_by_offset(btf, member->name_off);
> > +			if (name && !strcmp(member_name, name)) {
> > +				if (anon_offset)
> > +					*anon_offset = cur_offset;
> > +				goto out;
> > +			}
> > +		}
> > +	}
> > +	if (top > 0) {
> > +		/* Pop from the anonymous stack and retry */
> > +		tid = anon_stack[--top].tid;
> > +		cur_offset = anon_stack[top].offset;
> > +		type = btf_type_by_id(btf, tid);
> > +		goto retry;
> > +	}
> > +	member = NULL;
> > +
> > +out:
> > +	kfree(anon_stack);
> > +	return member;
> > +}
> > +
> >  #define BTF_SHOW_MAX_ITER	10
> >  
> >  #define BTF_KIND_BIT(kind)	(1ULL << kind)
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index 057cd975d014..64b61f67a403 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -99,7 +99,6 @@ obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
> >  endif
> >  obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
> >  obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
> > -obj-$(CONFIG_PROBE_EVENTS_BTF_ARGS) += trace_btf.o
> >  obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
> >  obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
> >  obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
> > diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> > deleted file mode 100644
> > index ca224d53bfdc..000000000000
> > --- a/kernel/trace/trace_btf.c
> > +++ /dev/null
> > @@ -1,122 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#include <linux/btf.h>
> > -#include <linux/kernel.h>
> > -#include <linux/slab.h>
> > -
> > -#include "trace_btf.h"
> > -
> > -/*
> > - * Find a function proto type by name, and return the btf_type with its btf
> > - * in *@btf_p. Return NULL if not found.
> > - * Note that caller has to call btf_put(*@btf_p) after using the btf_type.
> > - */
> > -const struct btf_type *btf_find_func_proto(const char *func_name, struct btf **btf_p)
> > -{
> > -	const struct btf_type *t;
> > -	s32 id;
> > -
> > -	id = bpf_find_btf_id(func_name, BTF_KIND_FUNC, btf_p);
> > -	if (id < 0)
> > -		return NULL;
> > -
> > -	/* Get BTF_KIND_FUNC type */
> > -	t = btf_type_by_id(*btf_p, id);
> > -	if (!t || !btf_type_is_func(t))
> > -		goto err;
> > -
> > -	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> > -	t = btf_type_by_id(*btf_p, t->type);
> > -	if (!t || !btf_type_is_func_proto(t))
> > -		goto err;
> > -
> > -	return t;
> > -err:
> > -	btf_put(*btf_p);
> > -	return NULL;
> > -}
> > -
> > -/*
> > - * Get function parameter with the number of parameters.
> > - * This can return NULL if the function has no parameters.
> > - * It can return -EINVAL if the @func_proto is not a function proto type.
> > - */
> > -const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
> > -{
> > -	if (!btf_type_is_func_proto(func_proto))
> > -		return ERR_PTR(-EINVAL);
> > -
> > -	*nr = btf_type_vlen(func_proto);
> > -	if (*nr > 0)
> > -		return (const struct btf_param *)(func_proto + 1);
> > -	else
> > -		return NULL;
> > -}
> > -
> > -#define BTF_ANON_STACK_MAX	16
> > -
> > -struct btf_anon_stack {
> > -	u32 tid;
> > -	u32 offset;
> > -};
> > -
> > -/*
> > - * Find a member of data structure/union by name and return it.
> > - * Return NULL if not found, or -EINVAL if parameter is invalid.
> > - * If the member is an member of anonymous union/structure, the offset
> > - * of that anonymous union/structure is stored into @anon_offset. Caller
> > - * can calculate the correct offset from the root data structure by
> > - * adding anon_offset to the member's offset.
> > - */
> > -const struct btf_member *btf_find_struct_member(struct btf *btf,
> > -						const struct btf_type *type,
> > -						const char *member_name,
> > -						u32 *anon_offset)
> > -{
> > -	struct btf_anon_stack *anon_stack;
> > -	const struct btf_member *member;
> > -	u32 tid, cur_offset = 0;
> > -	const char *name;
> > -	int i, top = 0;
> > -
> > -	anon_stack = kcalloc(BTF_ANON_STACK_MAX, sizeof(*anon_stack), GFP_KERNEL);
> > -	if (!anon_stack)
> > -		return ERR_PTR(-ENOMEM);
> > -
> > -retry:
> > -	if (!btf_type_is_struct(type)) {
> > -		member = ERR_PTR(-EINVAL);
> > -		goto out;
> > -	}
> > -
> > -	for_each_member(i, type, member) {
> > -		if (!member->name_off) {
> > -			/* Anonymous union/struct: push it for later use */
> > -			type = btf_type_skip_modifiers(btf, member->type, &tid);
> > -			if (type && top < BTF_ANON_STACK_MAX) {
> > -				anon_stack[top].tid = tid;
> > -				anon_stack[top++].offset =
> > -					cur_offset + member->offset;
> > -			}
> > -		} else {
> > -			name = btf_name_by_offset(btf, member->name_off);
> > -			if (name && !strcmp(member_name, name)) {
> > -				if (anon_offset)
> > -					*anon_offset = cur_offset;
> > -				goto out;
> > -			}
> > -		}
> > -	}
> > -	if (top > 0) {
> > -		/* Pop from the anonymous stack and retry */
> > -		tid = anon_stack[--top].tid;
> > -		cur_offset = anon_stack[top].offset;
> > -		type = btf_type_by_id(btf, tid);
> > -		goto retry;
> > -	}
> > -	member = NULL;
> > -
> > -out:
> > -	kfree(anon_stack);
> > -	return member;
> > -}
> > -
> > diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
> > deleted file mode 100644
> > index 4bc44bc261e6..000000000000
> > --- a/kernel/trace/trace_btf.h
> > +++ /dev/null
> > @@ -1,11 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > -#include <linux/btf.h>
> > -
> > -const struct btf_type *btf_find_func_proto(const char *func_name,
> > -					   struct btf **btf_p);
> > -const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
> > -					   s32 *nr);
> > -const struct btf_member *btf_find_struct_member(struct btf *btf,
> > -						const struct btf_type *type,
> > -						const char *member_name,
> > -						u32 *anon_offset);
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 4dc74d73fc1d..b33c424b8ee0 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -12,7 +12,7 @@
> >  #define pr_fmt(fmt)	"trace_probe: " fmt
> >  
> >  #include <linux/bpf.h>
> > -#include "trace_btf.h"
> > +#include <linux/btf.h>
> >  
> >  #include "trace_probe.h"
> >  
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
