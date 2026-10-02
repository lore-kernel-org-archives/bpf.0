Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD49175A83;
	Fri,  2 Oct 2026 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901784; cv=none; b=Re97u1dgcYmI0vTACGDLLF9IRtIUnO7AisV2QlSLx+XEyqk38z35O8xEdncZ+whJYaoUvnMpApdHrkS1dYqamsA/pCBvuVV6DurrnOFLF5TGI29svHYTurVbAsBzNQyo4EC3FGxEraEHJyFa3jsTHQnSfq82ejHYbUZ+8zLSpgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901784; c=relaxed/simple;
	bh=N4+ofsEjXj9Zwa4EbKCqlTip6D/MrCTNJ0783xBl1Lg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fjv0LBfeWkiliqoEH2w5yaJydEfW5Vdr0GWNrskCsqb3JLi1o4KJhgj04AeZs/NQv3DP3/TDaBVEsdhYJE7q0ZL5HFwpFi6miN3p5LpmhjB+Sk9uRJfZ2k1kWh6VGMBlGBJe4chBsOjN6exyDj92+3HIXtCUaL4iUaAxuVzhNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5fY9Sqd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5fY9Sqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCB01F000FF;
	Fri,  2 Oct 2026 00:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790901782;
	bh=xKRVVGpU2T8KhtrGYwrWKA1LKXrqmHaL1/7GTpmrv6Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=D5fY9SqdotBv9Ojt1XSZKnRYGgAiVrEw/RDM5LUKcGunu3fXbyuFDPOTQ5bIsaaFL
	 YttYLsRVrUj1CJ8F6iomNZkFQWnXcNkzQNsdUx8JBgm8lP675eKbEimlN+QVE+10/T
	 dmGnpFwf2bWb/kJ9IVTg+RiqC6G/EUNwUYWeeqpJAttcym7xSgFixwGxJNiQ2eEcTq
	 pBDdw0l6ITPuQM/d58oQUcQF4QWzBdEdp+JQKagn6q773eHyOmsgZ7gCZf5mhAkUWH
	 UmLBQLDddAz7LQwti3W3xQO+/3KDSPA2dFMQvrM92/XEblzdVBirlK1ZFNtriIzYn1
	 nforl62LH4PNw==
Content-Type: multipart/mixed; boundary="===============2011148496410822248=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8eb78c006e3ba41c64fce24adafe146c9467d40f4a7d8cea2cf112d610cd2598@mail.kernel.org>
In-Reply-To: <20261001152042.124445-9-gmonaco@redhat.com>
References: <20261001152042.124445-9-gmonaco@redhat.com>
Subject: Re: [PATCH v2 08/15] tools/rv: Implement BPF monitor loading and tracing
From: bot+bpf-ci@kernel.org
To: gmonaco@redhat.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,rostedt@goodmis.org,gmonaco@redhat.com
Cc: alexei.starovoitov@gmail.com,namcao@linutronix.de,wen.yang@linux.dev,tobias.schaffner@siemens.com,vmalik@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 00:43:01 +0000 (UTC)

--===============2011148496410822248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools/rv: Implement BPF monitor loading and tracing

TL;DR:
- Tracing may end early on -EINTR (e.g. Ctrl-Z then fg), unloading the monitor
- BPF monitors may not start without CONFIG_RV
- Enum with exactly 64 members possibly rejected
- Trace column misalignment, misleading comment, unused parameter (nits)

> diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification/rv/src/bpf_monitor.c
> index a1de0c157712..9a3f00febfeb 100644
> --- a/tools/verification/rv/src/bpf_monitor.c
> +++ b/tools/verification/rv/src/bpf_monitor.c

[ ... ]

> @@ -221,3 +279,595 @@ int bpf_list_monitors(char *container)

[ ... ]

> +static void bpf_print_header(void)
> +{
> +	printf("%16s-%-8s %5s %5s ", "<TASK>", "PID", "[CPU]", "TYPE");
> +	if (config.has_id)
> +		printf(" %8s", "ID");
> +
> +	printf("%24s x %-24s -> %-24s %s\n",
> +		"STATE",
> +		"EVENT",
> +		"NEXT_STATE",
> +		"FINAL");

[ ... ]

> +	printf("%16s-%-8"PRIu64" [%.3"PRIu64"] ", comm, entry[FIELD_PID], entry[FIELD_CPU]);
> +	if (entry[FIELD_EVENT_TYPE] == mon_ctx->trace_types[TRACE_TYPE_ERROR]) {
> +		printf("error ");
> +		if (config.has_id)
> +			printf(" %8"PRIu64"", entry[FIELD_ID]);
> +		printf(" %24s x %-24s\n",
> +		       get_state_name(mon_ctx, entry[FIELD_CURR_STATE]),
> +		       get_event_name(mon_ctx, entry[FIELD_EVENT]));
> +	} else if (entry[FIELD_EVENT_TYPE] == mon_ctx->trace_types[TRACE_TYPE_EVENT]) {
> +		printf("event ");
> +		read_field(entry, FIELD_IS_FINAL, raw, mon_ctx);
> +		read_field(entry, FIELD_NEXT_STATE, raw, mon_ctx);
> +
> +		if (config.has_id)
> +			printf(" %8"PRIu64"", entry[FIELD_ID]);
> +		printf(" %24s x %-24s -> %-24s %c\n",
> +		       get_state_name(mon_ctx, entry[FIELD_CURR_STATE]),
> +		       get_event_name(mon_ctx, entry[FIELD_EVENT]),
> +		       get_state_name(mon_ctx, entry[FIELD_NEXT_STATE]),
> +		       entry[FIELD_IS_FINAL] ? 'Y' : 'N');

Is the extra leading space before %24s in the data rows intentional?

bpf_print_header() prints the STATE column with no leading space:

    printf("%24s x %-24s -> %-24s %s\n", "STATE", ...);

while handle_event() prints:

    printf(" %24s x %-24s -> %-24s %c\n", ...);

The prefixes before that point have the same width ("comm-pid [cpu] event "
versus the TYPE header, plus the 9 column ID field), so every STATE, EVENT,
NEXT_STATE and FINAL value lands one column to the right of its header label
and of the " | " separator row.  With has_id the header " x " sits at column
71 and the data rows at column 72; without an id it is 62 versus 63.

The error line in the TRACE_TYPE_ERROR branch has the same extra space.

The in-kernel ikm_print_header() and ikm_event_handler() line up because
both use "%8s " / "%8llu " followed by "%24s".  Should the data rows use
"%24s x ..." or the header " %24s x ...", so the columns match?

No later commit in the series (up to 3b00bc9b2e54) changes
bpf_print_header() or handle_event().

[ ... ]

> +static int extract_enum_names(const struct btf *btf, const char *enum_kind,
> +			       char dest[][MAX_DA_NAME_LEN], struct bpf_monitor_ctx *ctx)

[ ... ]

> +		if (!name || count >= MAX_ENUMS)
> +			break;
> +
> +		/* max value must be the last */
> +		if (!strcmp(name, buf)) {
> +			if (i == vlen - 1)
> +				arrived_at_last = true;
> +			break;
> +		}

[ ... ]

> +	if (!arrived_at_last) {
> +		debug_msg("bpf: malformed %ss enum, could fill %d\n", enum_kind, count);
> +		return -1;
> +	}

Can this reject a valid enum with exactly MAX_ENUMS members?  The capacity
check runs before the terminator check:

    if (!name || count >= MAX_ENUMS)
            break;

    /* max value must be the last */
    if (!strcmp(name, buf)) {

Take an enum with 64 real members followed by state_max_X (vlen = 65).
Iterations i = 0..63 fill dest[0..63] and leave count == 64.  At i == 64
the name is "state_max_X", but count >= MAX_ENUMS is already true, so the
loop breaks before the strcmp() can set arrived_at_last.

extract_enum_names() then logs "malformed states enum, could fill 64" and
returns -1.  That propagates:

    extract_enum_names() -> extract_btf_info() -> open_bpf_monitor()

open_bpf_monitor() prints "bpf: failed to enable tracing" and returns NULL,
so "rv mon X -t" fails entirely.

ctx->state_names and ctx->event_names are char [MAX_ENUMS][MAX_DA_NAME_LEN],
so they have room for all 64 names.  Should the *_max_* name be checked
before the capacity check?  As written the real limit is 63 entries, with a
misleading "malformed" diagnostic for a well-formed enum.

No shipped monitor (tqueue, nohz) is this large, but rvgen -b (8c5ba90eb059,
later in the series) generates BPF monitors from arbitrary models.  The code
is unchanged at the end of the series (3b00bc9b2e54).

[ ... ]

> +/*
> + * attach_bpf_handlers - attach all BPF programs
> + *
> + * Attaches all non-struct_ops programs and stores links in the provided array.
> + *
> + * Returns fd of enable program on success, -1 on error.
> + */
> +static int attach_bpf_handlers(const char *monitor_name, struct bpf_object *obj,
> +				struct bpf_link **links, int *link_count)

This isn't a bug, but the comment says this "Attaches all non-struct_ops
programs", and the code never checks for struct_ops.  The only program
skipped is PROG_ENABLE_MON ("enable_monitor"); every other program from
bpf_object__for_each_program() is passed to bpf_program__attach().

In libbpf, SEC_DEF("struct_ops+", STRUCT_OPS, 0, SEC_NONE) has no
prog_attach_fn, so bpf_program__attach() returns NULL with errno set to
EOPNOTSUPP for such a program.  attach_bpf_handlers() would then print
"bpf: error attaching program" and return -1, so the monitor would fail to
start, which is the opposite of what the comment says.

The comment also does not mention that enable_monitor is skipped and its fd
returned.  Should the comment describe what the code does (attach everything
except enable_monitor), or should the code skip struct_ops programs, for
example by checking bpf_program__type(prog) == BPF_PROG_TYPE_STRUCT_OPS?

This mismatch is still present at the end of the series (3b00bc9b2e54).

Also, this isn't a bug, but the monitor_name parameter of
attach_bpf_handlers() is never used in the body.  The function only uses
obj, links and link_count, and its error messages print prog_name,
*link_count and PROG_ENABLE_MON.  bpf_run_monitor() still passes it:

    enable_mon_fd = attach_bpf_handlers(monitor_name, obj, links, &link_count);

Could the parameter be dropped, or used in the error messages (for example
"bpf: %s: error attaching program '%s'") so failures say which monitor
they belong to?  It is also unused at the end of the series (3b00bc9b2e54).

[ ... ]

> +	while (!should_stop()) {
> +		if (!config.trace) {
> +			sleep(1);
> +			continue;
> +		}
> +		res = ring_buffer__poll(rb, 100);
> +		if (res == -EINTR)
> +			break;
> +		if (res < 0) {
> +			err_msg("bpf: error polling ring buffer: %s\n", strerror(-res));
> +			goto cleanup;
> +		}
> +	}

Can this end the trace session without a stop having been requested?
The loop condition already checks should_stop(), which is set by the
SIGINT/SIGTERM handler stop_rv(), but any -EINTR from ring_buffer__poll()
breaks out of the loop, even when the interruption did not come from those
signals.

ring_buffer__poll() returns libbpf_err(-errno) when epoll_wait() fails, and
ep_poll() returns -EINTR whenever signal_pending() is true.  That is not
one of the -ERESTART* codes, so the kernel does not restart the call.  On
Linux, epoll_wait() returns EINTR after a process is stopped by a job
control signal and then resumed with SIGCONT (see signal(7)), and rv
installs no handler for SIGTSTP or SIGCONT.

For example, with "rv mon tqueue -t", press Ctrl-Z and then run "fg":

    epoll_wait() returns EINTR
      -> ring_buffer__poll() returns -EINTR
      -> break, with should_stop() still false
      -> cleanup: bpf_link__destroy(), bpf_object__close()

The monitor is unloaded and rv exits with success instead of resuming the
trace.  The in-kernel path (ikm_run_monitor) handles this case, because its
sleep(1)/tracefs loop just re-checks should_stop().  Should -EINTR use
"continue" here and let should_stop() decide?  The code is unchanged at the
end of the series (3b00bc9b2e54).

[ ... ]

> diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
> index 7c4a2e49ff9d..571c9a14c1a2 100644
> --- a/tools/verification/rv/src/rv.c
> +++ b/tools/verification/rv/src/rv.c

[ ... ]

> @@ -127,6 +127,9 @@ static void rv_mon(int argc, char **argv)
>  	 */
>  	run += ikm_run_monitor(monitor_name, argc-1, &argv[1]);
>  
> +	if (!run)
> +		run += bpf_run_monitor(monitor_name, argc-1, &argv[1]);
> +
>  	if (!run)
>  		err_msg("rv: monitor %s does not exist\n", monitor_name);
>  	exit(run > 0 ? EXIT_SUCCESS : EXIT_FAILURE);

Can BPF monitors still be started on a kernel without CONFIG_RV?  rv list
still shows them there, but ikm_run_monitor() does not return 0 ("not
found") when the in-kernel RV interface is missing.  It returns -1
("error"):

    __ikm_find_monitor_name():
        available_monitors = tracefs_instance_file_read(NULL, "rv/available_monitors", NULL);
        if (!available_monitors)
                return -1;

    ikm_run_monitor():
        retval = __ikm_find_monitor_name(monitor_name, full_name);
        ...
        if (retval < 0) {
                err_msg("ikm: error finding monitor %s\n", nested_name);
                return -1;
        }

With no tracefs rv/ directory, run is -1 and "if (!run)" is false, so
bpf_run_monitor() is never called.  "rv mon nohz" prints "ikm: error finding
monitor nohz" and exits with failure.

The listing path treats the same situation differently: rv_list() calls
bpf_list_monitors() even after ikm_list_monitors() fails with "is CONFIG_RV
enabled?", so the BPF monitors are listed but then cannot be run.

The BPF monitors added later in the series only attach to generic hooks:
nohz uses fentry/sched_tick, fentry/tick_nohz_restart_sched_tick and
tp_btf/tick_stop, and tqueue uses tp_btf/sched_{en,de}queue_tp, which are
exported unconditionally in kernel/sched/core.c.  Neither needs CONFIG_RV.

Should the dispatch fall through to the BPF path when the in-kernel
interface is unavailable, rather than only on run == 0?  No later commit in
the series (up to 3b00bc9b2e54) changes this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36944413541
--===============2011148496410822248==--
