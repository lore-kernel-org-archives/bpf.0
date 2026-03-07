Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B71917FB
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843831; cv=none; b=Am8y80uchig550C8DzLG2lsto790MsDmA2l3I2IOEaxg0+XfvcKdnOPTB+C8Cxwxk3A7Bu+vez10O+KiUKVCc3eCvnsaOjOWembbFWiu/CpVaCAz7QsVd2nMbBnsl/zSk4UwpPxWs2WWGJcAicCWhwYbstQdhFc56ksvKAGVYBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843831; c=relaxed/simple;
	bh=/IDppTsrmj69Vg3t38a2DnbXINuyLSAj9Ra10/1u96g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmEumx2c17aa1v+wmBGKrW5d9D7PkJwZ+CuIx3tvkQm3IU5ukudOIRI/6eXTt/NCRRtuRZxch9Gg/LgNGDd7IWbQu1qaxk/ofBvqowLmS/5JYOftoGds74wl81DTmyXqlm4e00LK7O/h9mrj4VtVKYIGoaZuIPbdx4jzVSoA7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CAKApwoi; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CAKApwoi"
Message-ID: <d891ea63-b9e8-47dc-8127-82533ab09098@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772843826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzP0Th8bxVDSkLVCKuMX8bLwEEBuXlfxdkYxXKjgf7M=;
	b=CAKApwoiRcAzFf8AQXcxNaDzbc5lC1Lh9FwPXPXT8i0Q/8ttnDcIjmUAVQA9Ofu/w37fKA
	xxE/PD+4ofdWJW3Z92hyUCa8n9y65yXXYAxOrJ58/ecmoPqKG5pni8pudm1wFSgZGCsMCj
	AyKEaKoAXKzGaxpuUc9Qy/YYtdkZjPQ=
Date: Fri, 6 Mar 2026 16:36:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [External] Re: [PATCH bpf-next v4 1/2] libbpf: Handle duplicate
 kprobe symbols in attach_kprobe_opts
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, jolsa@kernel.org, emil@etsalapatis.com,
 linux-open-source@crowdstrike.com, Kernel Team <kernel-team@meta.com>
References: <20260302210532.381083-1-andrey.grodzovsky@crowdstrike.com>
 <20260302210532.381083-2-andrey.grodzovsky@crowdstrike.com>
 <CAEf4BzYiwAczqqdb40YKq8yRd7JWgOV_cgyehpCRzoEZ6qeP7g@mail.gmail.com>
 <CAOu3gNgUp0sqgTUfCM_UFsEi6jwsTDjMrAZL_Pv=FZ4Fx_Khug@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAOu3gNgUp0sqgTUfCM_UFsEi6jwsTDjMrAZL_Pv=FZ4Fx_Khug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/6/26 1:08 PM, Andrey Grodzovsky wrote:
> On Thu, Mar 5, 2026 at 5:47 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, Mar 2, 2026 at 1:05 PM Andrey Grodzovsky
>> <andrey.grodzovsky@crowdstrike.com> wrote:
>>>
>>> When a kernel module exports a symbol with the same name as an existing
>>> vmlinux symbol, kprobe attachment via bpf_program__attach_kprobe_opts()
>>> fails with EADDRNOTAVAIL (perf_event_open path) or EINVAL (legacy
>>> tracefs path).
>>
>> If the same symbol name resolves to multiple addresses, that's an
>> ambiguity that libbpf has no business resolving. It should be on user
>> to resolve and use attachment by address, which libbpf supports
>> through bpf_kprobe_opts or multi-kprobe opts.

Hi Andrey, see my comments below.

TL;DR is that I agree with Andrii here. The proposed mechanism with a
fallback and kallsyms parsing just doesn't fit in libbpf, especially
given that a user-side workaround is feasible (even if inconvenient).

The first point that seems obvious to me is that modules shouldn't
shadow kernel symbols. If your module does it accidentally: fix your
module. If it's on purpose: sorry, you're on your own then.

But let's set that aside for now. After all the module may be an
external dependency of whatever system you're building or tracing.

>>
>> pw-bot: cr
>>
> 
> I understand the concern about libbpf making policy decisions on
> ambiguous symbol resolution. But I think the skeleton-based auto-attach
> workflow makes this impractical for the user to handle.
> 
> The recommended upstream pattern is:
> 
>   skel = my_prog__open_and_load();
>   my_prog__attach(skel);
> 
> So it's something along the lines of
> 
> our_skeleteon_bpf__attach(skel)
>     → bpf_object__attach_skeleton(skel->skeleton)
>       → prog->sec_def->prog_attach_fn()  [= attach_kprobe()]
>         → bpf_program__attach_kprobe_opts(prog, func, &opts)
>           → perf_event_open_probe(name=func, offset=0)
>             → perf_event_open() → EADDRNOTAVAIL
> 
> So bpf_object__attach_skeleton(), which iterates over all
> programs and calls attach_kprobe() internally. That function extracts
> the symbol name from the ELF section name (SEC("kprobe/func_name"))
> and passes it to bpf_program__attach_kprobe_opts(). The user has no
> control point in this chain - no callback, no option struct, no way
> to intercept a failed attach and supply an address instead.

You are right that the skeleton auto-attach path doesn't have a direct
interception point, but this is solvable without libbpf changes.

The workaround is essentially what Andrii suggested: resolve the
address yourself before attaching. I vibe-coded a change on top of
your selftest patch to demonstrate it, pasted at the bottom. It works.

But even ignoring the workaround, I think there are conceptual issues
with the proposed approach, regardless of whether the fallback is in
attach_kprobe_opts or limited to auto-attach.

The fallback unconditionally prefers vmlinux over module symbols.
If someone legitimately wants to probe a module function that shadows
a vmlinux name, this silently attaches to the wrong target with no
opt-out.

The EINVAL catch in legacy mode is overly broad. EINVAL can come from
many conditions (bad offset, bad probe name, write errors), not just
duplicate symbols. The func_name != NULL guard helps but doesn't
eliminate false positives that trigger unnecessary kallsyms parsing.

kprobe_multi is not covered. libbpf_available_kallsyms_parse()
resolves symbols by name via glob_match() without module filtering.
The same duplicate-symbol issue exists there.

Every retry parses all of /proc/kallsyms linearly (that's 100k+
symbols). If multiple probes fail in sequence, the cost compounds.


> 
> If a kernel module happens to export a symbol with the same name as
> a vmlinux function the user is probing, the attach fails with
> EADDRNOTAVAIL and the user has no recovery path within the skeleton
> API. The only options would be:
> 
> 1. Abandon skeleton auto-attach entirely for any kprobe program
>  that might hit a duplicate, and manually call
>  bpf_program__attach_kprobe_opts() with a resolved address for
>  each one. This defeats the purpose of skeletons.
> 
> 2. Proactively scan /proc/kallsyms before every attach to detect
>  potential duplicates, set prog->autoattach = false for affected
>  programs, and manually attach those. But autoattach is not
>  exposed in the public skeleton API either.
> 
> Since a kernel module can be loaded at any time, any kprobe could
> potentially become ambiguous. Pushing resolution to the user
> effectively means the skeleton auto-attach pattern cannot be
> reliably used for kprobes.

To that I'd say that you can not *reliably* use kprobes. Period.
There is a whole can of worms with inlining and functions being
optimized away etc.

Handling a case when your userspace+BPF system smartly handles symbol
changes due to module loads is not libbpf or kernel's business IMO.

> 
> The fallback in this patch is intentionally conservative - it only
> triggers on the specific error codes that indicate duplicate symbols
> (EADDRNOTAVAIL for perf_event_open, EINVAL for legacy), and it
> resolves strictly to the vmlinux text symbol, skipping module symbols.
> This seems like the only reasonable behavior for auto-attach, where
> the user has expressed intent to probe a specific function by name.
> 
> Would it make sense to limit this fallback to the auto-attach path
> (attach_kprobe) rather than the explicit attach_kprobe_opts API?
> That way users who call attach_kprobe_opts directly still get the
> raw error and can handle it themselves, while the skeleton workflow
> has a reasonable default.
> 
> Happy to hear alternative suggestions on how to make this work
> within the existing API.

I think we can reframe the issue in terms of "how to make this more
convenient".

It looks to me that the main issue here is in number_of_same_symbols()
(in trace_kprobe.c). When no module qualifier is given, it counts
matching symbols across vmlinux AND all loaded modules. There is no
mechanism to scope the check only to kernel AFAIU. So any module that
exports a matching symbol makes the vmlinux symbol unattachable by
name.

It may be worth a discussion whether a "I want a kernel symbol"
mechanism could be introduced for kprobes, since the kernel already
supports MOD:SYM qualification.

With a kernel side change like that, the skeleton auto-attach path
will just work, no libbpf changes needed at all.

Thanks,
Ihor

And here is the workaround example patch:

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 75c22af2f1b3..c20a1510b4d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -5,6 +5,7 @@
 #include "test_attach_probe.skel.h"
 #include "kprobe_write_ctx.skel.h"
 #include "testing_helpers.h"
+#include "trace_helpers.h"
 
 /* this is how USDT semaphore is actually defined, except volatile modifier */
 volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribute((section(".probes")));
@@ -177,6 +178,83 @@ static void test_attach_probe_dup_sym(enum probe_attach_mode attach_mode)
 	unload_module("bpf_testmod_dup_sym", false);
 }
 
+/* Workaround for duplicate kprobe symbols without libbpf changes.
+ *
+ * When a module exports a symbol with the same name as a vmlinux function,
+ * attaching by name fails with EADDRNOTAVAIL. The fix does NOT belong in
+ * libbpf. Instead, the user can:
+ *
+ *   1. Resolve the vmlinux address via /proc/kallsyms using kallsyms_find(),
+ *      which returns the first match -- vmlinux symbols precede module symbols
+ *      in kallsyms output (module symbols are annotated with [modname]).
+ *   2. Attach with func_name=NULL and opts.offset=absolute_address, bypassing
+ *      the kernel's duplicate-symbol check entirely.
+ *
+ * This demonstrates that no libbpf changes are needed; resolution of the
+ * ambiguity is the caller's responsibility.
+ */
+static void test_attach_probe_dup_sym_workaround(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
+	struct bpf_link *kprobe_link, *kretprobe_link;
+	struct test_attach_probe_manual *skel;
+	unsigned long long kaddr = 0;
+	int err;
+
+	/* Load module with duplicate symbol */
+	err = load_module("bpf_testmod_dup_sym.ko", false);
+	if (!ASSERT_OK(err, "load_bpf_testmod_dup_sym")) {
+		test__skip();
+		return;
+	}
+
+	/*
+	 * Resolve the vmlinux address of the target function.  kallsyms_find()
+	 * stops at the first match; vmlinux entries precede module entries, so
+	 * this gives us the vmlinux address even when a module shadows the name.
+	 */
+	err = kallsyms_find(SYS_NANOSLEEP_KPROBE_NAME, &kaddr);
+	if (!ASSERT_OK(err, "kallsyms_find_nanosleep"))
+		goto unload_module;
+	if (!ASSERT_NEQ(kaddr, 0, "kaddr_nonzero"))
+		goto unload_module;
+
+	skel = test_attach_probe_manual__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_dup_sym_workaround_open_and_load"))
+		goto unload_module;
+
+	/*
+	 * Attach by absolute address (func_name=NULL, offset=kaddr).
+	 * The kernel receives no symbol name to validate, so the duplicate
+	 * symbol in the module does not cause EADDRNOTAVAIL.
+	 */
+	kprobe_opts.retprobe = false;
+	kprobe_opts.offset = kaddr;
+	kprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
+						      NULL, &kprobe_opts);
+	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_dup_sym_workaround"))
+		goto cleanup;
+	skel->links.handle_kprobe = kprobe_link;
+
+	kprobe_opts.retprobe = true;
+	kretprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
+							 NULL, &kprobe_opts);
+	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe_dup_sym_workaround"))
+		goto cleanup;
+	skel->links.handle_kretprobe = kretprobe_link;
+
+	/* trigger & validate kprobe && kretprobe */
+	usleep(1);
+
+	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_dup_sym_workaround_res");
+	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_dup_sym_workaround_res");
+
+cleanup:
+	test_attach_probe_manual__destroy(skel);
+unload_module:
+	unload_module("bpf_testmod_dup_sym", false);
+}
+
 /* attach uprobe/uretprobe long event name testings */
 static void test_attach_uprobe_long_event_name(void)
 {
@@ -480,6 +558,9 @@ void test_attach_probe(void)
 	if (test__start_subtest("dup-sym-link"))
 		test_attach_probe_dup_sym(PROBE_ATTACH_MODE_LINK);
 
+	if (test__start_subtest("dup-sym-workaround"))
+		test_attach_probe_dup_sym_workaround();
+
 	if (test__start_subtest("auto"))
 		test_attach_probe_auto(skel);
 	if (test__start_subtest("kprobe-sleepable"))
-- 
2.52.0




> 
> Andrey
> 
> 
>> [...]

