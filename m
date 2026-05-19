Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AAF39B97E;
	Tue, 19 May 2026 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194198; cv=none; b=BWYrSst/oEYRqUcfQi/dcIP8P2a7AtxgcCM82fRY+Ejg3KXwyLiwU/SrzpydLqbO+Nk9sl13LlvumoA//KOfJTuobwaTLxbIhtLuGIUis0ssJxok/A+ah/mUBCDmM6WL/sGiXPMsDtDDA0F5m6lQciFck4uXK4ILckyl8hA+g+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194198; c=relaxed/simple;
	bh=DxYTCPktYIssfeHLafIzhbnitgb8itgz2J1/c1lstEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHopW8YoDTdYSqsTpR2HdWaV+NsiBB5f5A9qz+2z/ozcG2y++TWD4FelFNB/ILgtxHmbvNohYUgDQNrX/vgNeWqkMWfjaeva6AiTAUmjRdFp1fAOx5g/Uko5UyoVxoFEgB2MWRsup8Mglsk3vrWiziDNNaVH4YABiFRLVdKzsi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 23D8FC17C9;
	Tue, 19 May 2026 12:36:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 24FCC6000C;
	Tue, 19 May 2026 12:36:32 +0000 (UTC)
Date: Tue, 19 May 2026 08:36:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [PATCH v4] tracing/probes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260519083648.102b320f@gandalf.local.home>
In-Reply-To: <20260519040928.458C4C2BCB3@smtp.kernel.org>
References: <20260518232312.0c78f055@gandalf.local.home>
	<20260519040928.458C4C2BCB3@smtp.kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fcg7fsex3ihpmciqusuy4x8iyx5pdyr8
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 24FCC6000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/KiVOAbbHFFSo62NVVqTMZ20YSbt8jR2o=
X-HE-Tag: 1779194192-410666
X-HE-Meta: U2FsdGVkX19oHWBuvFm3o5tIkNDklPTUEzBfq/bBbZcmRo3AGbiK/Og8hrgnlD2t+5UXY++HrzvpsD7eA7mPzYZ+3lw+Btm+U7uVmmNn4BV/XVTAzEjZhnHl/+ZtfXdiLsExkrLZxqMO35EzB6hEX56pTgz+Sjz11ay+n053n4tHztVVrcSkAHH02C7KmLgnLafjY2tg/LE0Jfj8o2+iqxUyv1yjVAKu0NVRW5x+Y8rKJeP3CN/kmv74wrWY0pA6dBMyWZFxzLHAWLi5EqElFPBha2bfEk/NJhuRc5TFtCzcNnSq62oaX7dy3Ukmc/MDpoS8JqE9NMu8r1pATaD4pvjuJLCDoY/zzeeOH0w29YwjbZRG0w4TijFGhQrbH+gQege2dMt1QZRKmwX/QiUKeg==

On Tue, 19 May 2026 04:09:27 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] NULL pointer dereference in `parse_btf_arg()` when typecasting `$retval`
> - [High] Instruction stream corruption when typecasting BTF variables with field dereferences
> - [High] Parser state corruption breaks multi-argument probes and standard BTF parameter resolution
> - [Medium] Hardcoded syntax check strictly prohibits typecasting hardware registers and standard BTF arguments
> - [Medium] Using `strrchr` causes parsing failures for memory dereferences containing parentheses
> --
> 
> commit 8ce6119a14206ed21706a773d9694dc24e53436e
> Author: Steven Rostedt <rostedt@goodmis.org>
> 
> tracing/probes: Allow use of BTF names to dereference pointers
> 
> This commit adds syntax to FETCHARG parsing to allow typecasting a value
> to a pointer to a structure. This allows users to rely on BTF to figure out
> member offsets instead of manually finding and hardcoding numerical offsets.
> 
> > But for event probes, or generic kprobes that records a register that
> > happens to be a pointer to a structure, they cannot dereference these
> > values with BTF naming, but must use numerical offsets.  
> 
> Does the code actually support dereferencing a register here? Hardware
> registers (like %rdi) and standard BTF arguments (like skb) do not begin
> with a $ character, but the parser explicitly enforces that the cast is
> followed by a $.

Heh, it doesn't support it yet. But I plan on doing so. I'll either add the
support or fix the change log.

> 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index e1c73065dae51..29b5a99074d76 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c  
> [ ... ]
> > @@ -471,12 +491,12 @@ static int query_btf_context(struct traceprobe_parse_context *ctx)
> >  	struct btf *btf;
> >  	s32 nr;
> >  
> > -	if (ctx->btf)
> > -		return 0;
> > -
> >  	if (!ctx->funcname)
> >  		return -EINVAL;
> >  
> > +	if (ctx->btf)
> > +		return 0;
> > +  
> 
> If a user creates a probe with a struct cast for the return value (like
> (struct task_struct*)$retval), query_btf_struct() resolves the struct and
> sets ctx->btf but leaves ctx->proto as NULL.
> 
> When parse_btf_arg() later handles $retval, it calls query_btf_context(),
> which will return 0 here because ctx->btf is already set. Does this lead
> to parse_btf_arg() unconditionally dereferencing a NULL ctx->proto?
> 
> Additionally, for multi-argument probes where the first argument is a cast
> (like arg1=(struct foo*)$arg1 arg2=skb), setting ctx->btf for the first
> argument causes this check to return early for the second argument. Could
> this skip populating ctx->params and ctx->nr_params, causing valid BTF
> arguments to be rejected?

Yeah, this will be fixed by Masami's suggestion of using a different btf
for the structure.

> 
> [ ... ]
> > @@ -952,6 +986,12 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
> >  	int ret = 0;
> >  	int len;
> >  
> > +	if (ctx->flags & TPARG_FL_STRUCT) {
> > +		ret = parse_btf_arg(orig_arg, pcode, end, ctx);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +  
> 
> When parse_btf_arg() successfully parses a typecast with field dereferences,
> it emits a FETCH_OP_DEREF instruction and advances the *pcode pointer.
> 
> Since this block doesn't return upon success, execution continues and matches
> the base variable name later in parse_probe_vars(). The local code pointer
> is not updated to reflect the advanced *pcode, so it writes a new instruction
> (like FETCH_OP_ARG) into the same slot.
> 
> Will this overwrite the FETCH_OP_DEREF instruction and corrupt the trace probe
> bytecode?

Good catch. I need to move the code = *pcode; to after that if block.

> 
> [ ... ]
> > @@ -1231,6 +1271,43 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
> >  				code->op = FETCH_OP_IMM;
> >  		}
> >  		break;
> > +	case '(':
> > +		tmp = strrchr(arg, ')');  
> 
> If a user attempts to cast a standard memory dereference that itself
> contains parentheses (such as (struct foo*)+0($arg1)), strrchr() will
> find the final parenthesis of $arg1).

Ah, I should have used strchr(). Thanks.

> 
> Will this cause the pointer validation logic below to evaluate the wrong
> segment of the string and incorrectly fail with NO_PTR_STRCT?
> 
> > +		if (!tmp) {
> > +			trace_probe_log_err(ctx->offset + strlen(arg),
> > +					    DEREF_OPEN_BRACE);
> > +			return -EINVAL;
> > +		}
> > +
> > +		tmp--;
> > +		if (*tmp != '*') {
> > +			trace_probe_log_err(ctx->offset + (tmp - arg),
> > +					    NO_PTR_STRCT);
> > +			return -EINVAL;
> > +		}
> > +		*tmp = '\0';
> > +		ret = query_btf_struct(arg + 1, ctx);
> > +		*tmp = '*';
> > +
> > +		if (ret < 0) {
> > +			trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
> > +			return -EINVAL;
> > +		}
> > +
> > +		ctx->flags |= TPARG_FL_STRUCT;
> > +		tmp += 2;
> > +
> > +		if (*tmp != '$') {  
> 
> Is this strict check for '$' intentional?
> 
> As mentioned regarding the commit message, this prevents typecasting hardware
> registers and standard BTF arguments since they do not start with a '$',
> effectively restricting the feature to $retval, $stack, and $argN.

It was the only thing I tested. I'll remove it and test other options.

Thanks,

-- Steve

> 
> > +			trace_probe_log_err(ctx->offset + (tmp - arg),
> > +					    BAD_VAR);
> > +			return -EINVAL;
> > +		}
> > +
> > +		ctx->offset += tmp - arg;
> > +		ret = parse_probe_vars(tmp, type, pcode, end, ctx);
> > +		ctx->flags &= ~TPARG_FL_STRUCT;
> > +		ctx->last_struct = NULL;
> > +		break;  
> 

