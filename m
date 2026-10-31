Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793453830;
	b=sok4QkyxTSW9N4HXJY59l4ulgszvx8QgoNSqWA2hJMd9EDkzwU8owxZQnwu8Iv+huVca
	 7bMcLqs1ZObke5IS6ENQZyT0iSLknnIkc16jQXl5A/dnHc+rtv7iMpWrKzdVbMASjjEF1
	 bBnO0Bfiadfqhf3iQODKte4//0PcWM7WV4MROfiY18lZuOfj/CpzP3Hws9/9cxBloFKK9
	 7jRMGaAoXKKfwP1nOIldCRdpe+BxW7/+b9M/tuPmEjuC/qKYPaLOhO+Em2hPk4p5D/Idw
	 ZuO596gc5ipKily/wly4MtYd5BHhD95vkmodUj5+OFv/4ClJZW88XeDOv5byHP38ipg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453830;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yvmt+PxpujZuntRtWqUrAq13mLgWXMBz246RFVlts+0=;
	b=PVwtC1KPrZiphmwy0+Ig+uaHwrMeNDA56hUpgi5QnOLx18WaLtxvVxctX6aZezDHCZ6K
	 EVr/Dr0cBki3HYOFpu1vCO27/nRFwmqFJWTV/9Pef2JhsJpOACgHEqIIWDszAqM/TWbNQ
	 kv6hSKWmfAx6SURaW1w9kyS56AVODUdRSB3Z8qajos92CohG61HzYmnnu+unxoOPhk6DJ
	 ZBIruKo3cnQD1yohfkWGaftnJxyQF8GfKnEHXX7/c2YNcBLG13ya5HD7DlUXb0odYzyy/
	 tLXHK+rhCvl3P7FQQd1gyXwPvxL5Qo8Z89mQzdl7fGD1gGuRSzE/slNRpN81eL9dt7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9HyArey;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC5606A31A;
	Sat, 31 Oct 2026 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9HyArey
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232EC1F000C1;
	Sat, 31 Oct 2026 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793453830;
	bh=yvmt+PxpujZuntRtWqUrAq13mLgWXMBz246RFVlts+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V9HyAreywWMvCn8vSXYMBQcwiFNL1jPhcxE2nsxB5Z19uxtFnTLCVOC6T/D/N1yuD
	 rplc+AH8uL1oiJSg3ah2DZ9pF3+E8AlD/28K9pJJffGJl8fkg786z8gm3aYIdqvY2n
	 SE+2l7kQ5xjdLe0D0IMyT0sPtbopI4djd+Ho14lXtzjtWm9SqjKXMJUUfApXEB+XNz
	 lbDJ2ErxYf7NIF/sDISVUh79cRxYrtpROVHyN1uutzhEdRcheTLxZByNNhwKdpP6HB
	 M2VfLmVAcc92Lu5SrWgVaXA5AGIvD64SWQ8FHhAVQUp1ZAnlCrMbOqQCwpHuYTBbcy
	 gE9somoS9HPiw==
Message-ID: <sashiko-outbox-191980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 08/13] tracing: parse the vmlinux BTF when
 BTF-typed output is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>, bpf@vger.kernel.org, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alan Maguire" <almagui@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, "Nathan
 Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, linux-kbuild@vger.kernel.org, "Arnd
 Bergmann" <arnd@arndb.de>, x86@kernel.org, "Hazem Mohamed Abuelfotoh" <abuehaze@amazon.com>, "Bjoern
 Doebel" <doebel@amazon.de>, "Martin Pohlack" <mpohlack@amazon.de>, jay.wang.upstream@gmail.com
In-Reply-To: <20261031130959.23472-9-wanjay@amazon.com>
References: <20261031130959.23472-1-wanjay@amazon.com>
 <20261031130959.23472-9-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 13:37:08 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] tracing: missing trace_btf_prepare() in irqsoff and wakeup trace=
rs
- [Medium] tracing: missing trace_btf_prepare() for persistent buffers and =
latency tracers
--

commit b7e170f2972f546cc8806104f942bd820ff8ecbb
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

tracing: parse the vmlinux BTF when BTF-typed output is enabled

This commit prepares the vmlinux BTF when BTF-typed function or function_gr=
aph
tracer output is enabled or when reading an event's btf_ids file, and chang=
es
print_function_args() and btf_trim_retval() to peek at the vmlinux BTF rath=
er
than parsing it on demand while holding trace read locks.

> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index a5ad76175d10d..cdb926c9d4e21 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -739,6 +739,9 @@ void print_function_args(struct trace_seq *s, unsigne=
d long *args,
>  	if (lookup_symbol_name(func, name))
>  		goto out;
> =20
> +	/* see trace_btf_prepare() */
> +	if (IS_ERR_OR_NULL(bpf_peek_btf_vmlinux()))
> +		goto out;

[Severity: Medium]
Can this cause recorded function arguments to be omitted (printed as empty
parentheses) for latency tracers and persistent boot ring buffers when
CONFIG_DEBUG_INFO_BTF_LAZY is enabled and nothing else has triggered vmlinux
BTF parsing yet?

First, when CONFIG_FUNCTION_TRACE_ARGS is enabled, the irqsoff, preemptoff,
preemptirqsoff, wakeup, wakeup_rt, and wakeup_dl latency tracers record
function arguments via fregs into TRACE_FN entries since commit 76fe0337c219
("ftrace: Add arguments to function tracer"):

kernel/trace/trace_irqsoff.c:irqsoff_tracer_call() {
	...
	trace_function(tr, ip, parent_ip, trace_ctx, fregs);
}

kernel/trace/trace_sched_wakeup.c:wakeup_tracer_call() {
	...
	local_irq_save(flags);
	trace_function(tr, ip, parent_ip, trace_ctx, fregs);
	local_irq_restore(flags);
}

When reading trace or trace_pipe in default (non-graph) mode,
irqsoff_print_line() and wakeup_print_line() return TRACE_TYPE_UNHANDLED,
which dispatches TRACE_FN entries through trace_fn_trace() ->
print_fn_trace() -> print_function_args():

kernel/trace/trace_output.c:trace_fn_trace() {
	...
	args_size =3D iter->ent_size - offsetof(struct ftrace_entry, args);
	if (args_size >=3D FTRACE_REGS_MAX_ARGS * sizeof(long))
		args =3D field->args;
	else
		args =3D NULL;

	print_fn_trace(s, field->ip, field->parent_ip, args, iter->tr, flags);
}

However, neither __irqsoff_tracer_init() / register_irqsoff_function() nor
__wakeup_tracer_init() / register_wakeup_function() calls trace_btf_prepare=
().

Second, when a persistent trace_array instance (TRACE_ARRAY_FL_LAST_BOOT) is
set up across boots via trace_instance=3D on the command line (using reserv=
e_mem
or backup=3D in enable_instances()), allocate_trace_buffer() and
setup_trace_scratch() preserve the ring buffer events and address deltas fr=
om
the previous boot while the instance starts in the new boot with nop_trace =
and
default tracer flags. Selecting a tracer in the new boot via
tracing_set_tracer() calls update_last_data(tr), which resets the ring buff=
er
and clears the previous boot data (and backup=3D instances are marked
TRACE_ARRAY_FL_RDONLY):

kernel/trace/trace.c:tracing_set_tracer() {
	...
	guard(mutex)(&trace_types_lock);

	update_last_data(tr);
	...
}

When reading trace or trace_pipe from that persistent instance to inspect t=
he
previous boot's TRACE_FN or TRACE_GRAPH_ENT entries, print_trace_fmt()
dispatches them to trace_fn_trace() -> print_fn_trace() ->
print_function_args() or print_graph_function_event() ->
print_graph_entry_leaf() / print_graph_entry_nested() ->
print_function_args() without trace_btf_prepare() having been called in the
current boot:

kernel/trace/trace_output.c:print_fn_trace() {
	...
	ip =3D trace_adjust_address(tr, ip);
	parent_ip =3D trace_adjust_address(tr, parent_ip);

	seq_print_ip_sym(s, ip, flags);
	if (args)
		print_function_args(s, args, ip);
	...
}

Should trace_btf_prepare() also be called when initializing the irqsoff and
wakeup tracers and when setting up a persistent last-boot trace buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031130959.2347=
2-1-wanjay@amazon.com?part=3D8
