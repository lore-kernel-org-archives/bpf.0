Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB0366822
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110897; cv=none; b=ImMB8Y9HrsCCuVXsC+fHzKWoDVI+DMVdW8ONHdWz5vGvcIfAtZ6R6PNS5k19mGSDWjXhZW36165jQecB+PJ7W+C0wQaY/M/kELhvRAgpyZJ08cclyAtHEsVUHqunqa1AwDfFtPHawLOVYelRlfJtTwymLb16Ce/BMmgm0Dybqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110897; c=relaxed/simple;
	bh=JLorzAW35DaFqnEj+XhouKB2iFF8gIaX+AGTNOEZF3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwd5VY9DNav3hyXQcTxb9SxtBnZ/xnBQApoxeCjq5WczSdOt/Ub6739iUm0eDtYD6hzF27zMDQ85R+l0I+5Bd2g1wny9N2w7SQY7B3iuycw/N/sXkAK8YDl++gA/K+XQs6Uk8OZav6o+aysuh40yHgAvKfU6Z6eQu+OFLv/PIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B6F2940847;
	Mon, 18 May 2026 13:28:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 27A548000F;
	Mon, 18 May 2026 13:28:13 +0000 (UTC)
Date: Mon, 18 May 2026 09:28:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2] tracing/probes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260518092827.0a339a7b@gandalf.local.home>
In-Reply-To: <20260516215834.49107C19425@smtp.kernel.org>
References: <20260516173310.1dbad146@fedora>
	<20260516215834.49107C19425@smtp.kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: yaccokbmwi5cgqicr5kobarohd7aczxx
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 27A548000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+cANp4g2WCmVCESaDnNNgke97Tc5BwQPM=
X-HE-Tag: 1779110893-434972
X-HE-Meta: U2FsdGVkX1+hcI06vSoeF4snogVUg4SdO2r3sN067Cw6VQATezTuz6PwDiBv+CQLMVrmFUPrd5bIieQirn1b7p2AylSV1TemAYXnZUeIjE4FGzRNT2mdjJpW2BtFWjx/iN/MDVRUwlqMJhAdG1Wdo9y/q00pgcwo6gOgSuVCpK3+uvGVHhL/RFOb4QJbGQzfW4LEErmVtwk6oesidbC342UyjTTjOxEcK4gvOr4E5HEaEGdLeFRhaq4f4804JXMD7dAl3q89nFzp5foFNir8OQdCYsSJiO2bftJyNgMsh6L+YrcJoFnpeaBMtid+k4VP8CHDFnBVzEMGbSc5KndshbdIiOHgib/x


[ /me finds it weird talking to a bot ]

On Sat, 16 May 2026 21:58:33 +0000
sashiko-bot@kernel.org wrote:

> [ ... ]
> 
> > +		/* Handle anonymous structures */
> > +		if (strlen(tname))
> > +			continue;
> > +
> > +		*type = btf_type_by_id(btf, member->type);
> > +		if (btf_type_is_struct(*type)) {
> > +			int offset = find_member(ptr, btf, type, level + 1);
> > +
> > +			if (offset < 0)
> > +				continue;  
> 
> If find_member() returns -E2BIG due to deep anonymous structure nesting,
> this check appears to swallow the error and just skip to the next member.
> Does this prevent -E2BIG from ever reaching the caller and make the
> TP_ERR_MEMBER_TOO_DEEP error handling dead code?

Ah yeah, this needs to be:

			if (offset < 0) {
				if (offset == -ENOENT)
					continue;
				return offset;
			}

> 
> > +
> > +			return offset + BITS_ROUNDDOWN_BYTES(member->offset);
> > +		}
> > +	}
> > +
> > +	return -ENOENT;
> > +}
> > +
> > +/**
> > + * btf_find_offset - Find an offset of a member for a structure  
> 
> [ ... ]
> 
> > +int btf_find_offset(char *arg, long *offset_p)
> > +{
> > +	const struct btf_type *t;
> > +	struct btf *btf;
> > +	long offset = 0;
> > +	char *ptr;
> > +	int ret;
> > +	s32 id;
> > +
> > +	ptr = strchr(arg, '.');
> > +	if (!ptr)
> > +		return -EINVAL;
> > +
> > +	*ptr = '\0';
> > +
> > +	ret = -ENXIO;
> > +	id = bpf_find_btf_id(arg, BTF_KIND_STRUCT, &btf);
> > +	if (id < 0)
> > +		goto error;  
> 
> If bpf_find_btf_id() fails here, it returns an error code and does not
> initialize the btf pointer.
> 
> Does this cause btf_put(btf) to dereference an uninitialized stack pointer
> in the error path below, potentially leading to a panic?

Probably. I have to add another label.

> 
> > +
> > +	/* Get BTF_KIND_FUNC type */
> > +	t = btf_type_by_id(btf, id);
> > +
> > +	/* May allow more than one member, as long as they are structures */
> > +	do {
> > +		ret = -ENXIO;
> > +		if (!t || !btf_type_is_struct(t))
> > +			goto error;  
> 
> If a structure member is a typedef or has a modifier (like const), the
> updated type from find_member() will be BTF_KIND_TYPEDEF or BTF_KIND_CONST.
> 
> Will btf_type_is_struct() then fail on the next iteration of this loop?
> Should btf_type_skip_modifiers() be used to resolve the underlying structure
> type first?

Probably.

> 
> [ ... ]
> 
> > +error:
> > +	btf_put(btf);
> > +	if (ptr)
> > +		*ptr = '.';
> > +	return ret;
> > +}  
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index e0d3a0da26af5..6fcede2de1a55 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -1165,7 +1165,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
> >  
> >  	case '+':	/* deref memory */
> >  	case '-':
> > -		if (arg[1] == 'u') {
> > +		if (arg[1] == 'u' && isdigit(arg[2])) {  
> 
> Does this new condition misidentify valid BTF structure lookups that happen
> to start with 'u' followed by a digit, such as +u16_port.id($arg)?
> 
> Also, does it break previously valid negative user-space offsets like
> +u-10($arg) since arg[2] would be a hyphen instead of a digit?

No, because any sane person should write that as "-u10($arg)" ;-)

> 
> >  			deref = FETCH_OP_UDEREF;
> >  			arg[1] = arg[0];
> >  			arg++;
> > @@ -1178,7 +1178,22 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
> >  			return -EINVAL;
> >  		}
> >  		*tmp = '\0';
> > -		ret = kstrtol(arg, 0, &offset);
> > +		if (arg[0] != '-' && !isdigit(*arg)) {
> > +			int err = 0;
> > +			ret = btf_find_offset(arg, &offset);
> > +			switch (ret) {
> > +			case -ENODEV: err = TP_ERR_NOSUP_BTFARG; break;
> > +			case -E2BIG: err = TP_ERR_MEMBER_TOO_DEEP; break;
> > +			case -EINVAL: err = TP_ERR_BAD_STRUCT_FMT; break;
> > +			case -ENXIO: err = TP_ERR_BAD_BTF_TID; break;
> > +			}  
> 
> If find_member() cannot find the specified member, it returns -ENOENT.
> Since -ENOENT is missing from this switch statement, err remains 0 and
> __trace_probe_log_err() is skipped.
> 
> Should there be a mapping for -ENOENT (perhaps to TP_ERR_NO_BTF_FIELD) so
> users get a specific error log when they misspell a field name?

I guess we could add that.

/me feels like he's a character in "Ex Machina"!

Will send a v3 soon.

-- Steve

> 
> > +			if (err)
> > +				__trace_probe_log_err(ctx->offset, err);
> > +			if (ret < 0)
> > +				return ret;
> > +		} else {
> > +			ret = kstrtol(arg, 0, &offset);
> > +		}
> >  		if (ret) {  
> 

