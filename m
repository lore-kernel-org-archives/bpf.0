Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698832;
	b=u5lzltZrtuj1RCfwRa77R3xJkTaz0UW0l/I9TX5A3AQly/dyhkPE9S/Or9m82j8pHGxg
	 o6s7J7v2qVVsczqirTDdx6pruHOF1L9exDIzQFoRGuir61Gx3ekfqJVypwaPPNkILyThU
	 9+hntXeyw3VG9qAGHabkenGYlzv536+fN4oPGnnxP+AKCn04pDNIKTITXxjhWp69/6Vzn
	 Z3oC+dCKr3Q8pfTtS4kcAVM9A2OvW06PuakgPCZTGOfISYkNb1wA6wnqYrWC0lMeLOqFb
	 6+IfICftPgEIgziNjc5eRCO775dsI7UI/wATJDJvWUp680XiMmHlD+p6xfMpG3lImfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Qi3Jocybrq+ZLQPnY5PxIGQt0Ou9QPikkmlHIdJMbL0=;
	b=jKBml4jviJMfOhTcI/b/8BiMbH1RoEBmSPA8OwtOqKUhpSMmkTqBXwKW+iVcuPRfRN8K
	 iPpuvburlmFPrQS92VZ0OapJDIanA8//rkmmnQA/t3mziPODEvtm5uYIBS+Tea10ydLtQ
	 z3CeegDWqywqxTdUz7bX/+v0zcslsKHSIjqgI4ATANdM2sFQHkCcTWJ/oueszP9sovgkA
	 UcODcw2jiqykicOCbIuC2Sc/SjJ6waszJv4kNfvb576uTvHtiLBbuWZZ0N+EaNBOyWtKS
	 nXZH4CZxmC8O6m+tBspSNHQ8JyIlAuSFsvGqZgrFIMKmWD+E3g/erGZMvP9RgemZoag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZqUPzzU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB9606A31C;
	Thu, 26 Nov 2026 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZqUPzzU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7241F000CA;
	Thu, 26 Nov 2026 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795698831;
	bh=Qi3Jocybrq+ZLQPnY5PxIGQt0Ou9QPikkmlHIdJMbL0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MZqUPzzUYwnDvQf+iqrUl/rH1Gi225HU1LIYPu8Fr/SnTD4bemrk6US6b3qa+0Sl7
	 JbfjYSLr6114NuvCSJbE+YeK0LbPMdzKBpr8R0K1hOgsiNn6t4y+grz6LCuWgctPMM
	 IKN2hSX/4B2ADubZDFIWR10GrwX15O0cY/oHxERS27oyfbmgYKi0GQ+dNVy0cKeFbr
	 TMy1ggYZkI9VJ//6j52RwZ40YKxhnNEbVBh0hx1cyqBaVlSWr0ibDsDJA3NWGNRcn5
	 j3c+fvYG+uwEwT+MJzvKGaAxgK+uDpvZ9WhgH4IBQ72Jk0WxVd0ZvQ1V4hSlvSSWY4
	 oeU3ZfOA1zswg==
Message-ID: <sashiko-outbox-235580@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/18] tools/rv: Rework tracing to support generic
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261126130004.127155-12-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
 <20261126130004.127155-12-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 13:13:51 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] tools/rv: missing pid field check in enable_specific_event()
  self filter
--

commit 6b11a8a850e9f9fbce2a029fa1ab5858e9dcc9dc
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Rework tracing to support generic events

This commit replaces the DA-specific trace event formatting callbacks
with default tep_print_event() formatting and moves self-PID filtering
into ftrace event filters to support LTL and generic BPF monitor events.

> diff --git a/tools/verification/rv/src/trace.c b/tools/verification/rv/sr=
c/trace.c
> index aa4bb73624ecd..6fdbff2c28d45 100644
> --- a/tools/verification/rv/src/trace.c
> +++ b/tools/verification/rv/src/trace.c
[ ... ]
> +/*
> + * enable_specific_event - enable a monitor-specific event with filters
>   */
> -static int da_event_handler(struct trace_seq *s, struct tep_record *reco=
rd,
> -			    struct tep_event *trace_event, void *context)
> +static int enable_specific_event(struct trace_instance *inst, const char=
 *event_name)
>  {
> -	char *state, *event, *next_state;
> -	unsigned long long final_state;
> -	unsigned long long pid;
> -	unsigned long long id;
> -	int val;
> -	bool missing_id;
> -
> -	if (config.has_id)
> -		missing_id =3D tep_get_field_val(s, trace_event, "id", record, &id, 1);
> -
> -	tep_get_common_field_val(s, trace_event, "common_pid", record, &pid, 1);
> +	struct tep_event *tevent =3D tep_find_event_by_name(inst->tep, "rv", ev=
ent_name);
> +	char filter[FILTER_MAX] =3D "";
> =20
> -	if (config.has_id && (config.my_pid =3D=3D id))
> -		return 0;
> -	else if (config.my_pid =3D=3D pid)
> -		return 0;
> -
> -	tep_print_event(trace_event->tep, s, record, "%16s-%-8d [%.3d] ",
> -			TEP_PRINT_COMM, TEP_PRINT_PID, TEP_PRINT_CPU);
> -
> -	if (config.is_container)
> -		tep_print_event(trace_event->tep, s, record, "%s ", TEP_PRINT_NAME);
> -	else
> -		trace_seq_printf(s, "event ");
> +	if (!tevent) {
> +		err_msg("trace: fail finding the rv:%s event\n", event_name);
> +		return -1;
> +	}
> =20
> -	if (config.has_id) {
> -		if (missing_id)
> -			/* placeholder if we are dealing with a mixed-type container*/
> -			trace_seq_printf(s, "        ");
> +	if (config.my_pid > 0) {
> +		if (tep_find_field(tevent, "id"))
> +			snprintf(filter, sizeof(filter), "common_pid !=3D %d && id !=3D %d",
> +				 config.my_pid, config.my_pid);
>  		else
> -			trace_seq_printf(s, "%8llu ", id);
> +			snprintf(filter, sizeof(filter), "common_pid !=3D %d",
> +				 config.my_pid);
>  	}

[Severity: Low]
Does enable_specific_event() miss filtering the target task PID for LTL
monitors?

While per-task DA monitor tracepoints name their target task PID field
"id", LTL monitor tracepoints (event_ltl_monitor_id and
error_ltl_monitor_id in kernel/trace/rv/rv_trace.h) define that field as
"pid".  Because tep_find_field(tevent, "id") returns NULL for LTL
events, the filter falls back to "common_pid !=3D %d" and will not filter
out events targeting the rv process when emitted from another task or
interrupt context (such as sched_waking waking the rv process).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126130004.1271=
55-1-gmonaco@redhat.com?part=3D11
