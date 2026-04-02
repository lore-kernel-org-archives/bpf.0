Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310435F61F
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 04:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103254; cv=none; b=QWQPyqduIjxCTEKP6Ds2s7VXEIes8Ur7gvv6217XhrTGUQ60DYTJkPpYy9/ZYuCHC6Y+LYXhj9x/aiy/wyzJ4sQygHsOvADj+P7eVnRtfN5JjoNkcMpQCXAzIM/zX4GD2S6Wuki0uwAAsATbju+0BM68hpdEm53BXrlfAnLLzb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103254; c=relaxed/simple;
	bh=FUX31B9jO+2YDQ//I9SUc7yjDD/x+fdGS1AQ6NG66K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=po2A7BlF3CNubQQNV+8zouX/+O5xklBx3Vp/f7z4D+1I/Tg5YjCqmEyo+R3zrrAgfrxmExuBrnkYzsXPSb/R6aUgRGPTpP5zM16l0ZM1HVjblalbFl1vyOzmujYm4oTVap7ukaoZ6v+7jdRISmmYHhKJISlwR0K7t0ocA8fDu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ptyE7T95; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ptyE7T95"
Message-ID: <a6ed5221-876c-499e-aacf-a9f6cac438f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775103241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cP9KTGZrxxjUnGTO4F59TXW5UOjeg7N0Y/qlqLazzA=;
	b=ptyE7T95rQqp90FJFQcwnePl4shSKs+OyJo8gP56+M3v46+K+UMxCzzTTBrPA2h59j6YdP
	7snmzILy5vxC/gSFhqaoYFwy9If89jwvX20gPx3IUKUir4S5Zt/hz2YRAGEhWHBWH6WnCO
	8r9uNmmF5gfEq6euDolfeHw9x8wnnao=
Date: Thu, 2 Apr 2026 12:13:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add test to ensure kprobe_multi
 is not sleepable
Content-Language: en-US
To: Varun R Mallya <varunrmallya@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com,
 yonghong.song@linux.dev, jolsa@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260401191126.440683-1-varunrmallya@gmail.com>
 <20260401191126.440683-2-varunrmallya@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260401191126.440683-2-varunrmallya@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Above all, I think the test should reproduce the BUG without the fix.

I update the test to reproduce the BUG, then verify that the BUG will be
rejected with the fix.

The updated test is attached at last.

On 2/4/26 03:11, Varun R Mallya wrote:
> Add a selftest to ensure that kprobe_multi programs cannot be attached
> using the BPF_F_SLEEPABLE flag. This test succeeds when the kernel
> rejects attachment of kprobe_multi when the BPF_F_SLEEPABLE flag is set.
> 
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>  .../bpf/prog_tests/kprobe_multi_test.c        | 41 +++++++++++++++++++
>  .../bpf/progs/kprobe_multi_sleepable.c        | 13 ++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 78c974d4ea33..f02fec2b6fda 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -10,6 +10,7 @@
>  #include "kprobe_multi_session_cookie.skel.h"
>  #include "kprobe_multi_verifier.skel.h"
>  #include "kprobe_write_ctx.skel.h"
> +#include "kprobe_multi_sleepable.skel.h"
>  #include "bpf/libbpf_internal.h"
>  #include "bpf/hashmap.h"
>  
> @@ -633,6 +634,44 @@ static void test_attach_write_ctx(void)
>  }
>  #endif
>  
> +static void test_attach_multi_sleepable(void)
> +{
> +	struct kprobe_multi_sleepable *skel;
> +	int err;
> +
> +	skel = kprobe_multi_sleepable__open();
> +	if (!ASSERT_OK_PTR(skel, "kprobe_multi_sleepable__open"))
> +		return;
> +
> +	err = bpf_program__set_flags(skel->progs.handle_kprobe_multi_sleepable,
> +				     BPF_F_SLEEPABLE);
> +	if (!ASSERT_OK(err, "bpf_program__set_flags"))
> +		goto cleanup;
> +
> +	/* Load should succeed even with BPF_F_SLEEPABLE for KPROBE types */
> +	err = kprobe_multi_sleepable__load(skel);
> +	if (!ASSERT_OK(err, "kprobe_multi_sleepable__load"))
> +		goto cleanup;
> +
> +	/* Attachment must fail for kprobe.multi + BPF_F_SLEEPABLE.
> +	 * Also chosen a stable symbol to send into opts
> +	 */
> +	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> +	const char *sym = "vfs_read";

They should stay with skel and err. See below.

> +
> +	opts.syms = &sym;
> +	opts.cnt = 1;
> +
> +	skel->links.handle_kprobe_multi_sleepable =
> +		bpf_program__attach_kprobe_multi_opts(skel->progs.handle_kprobe_multi_sleepable,
> +						      NULL, &opts);
> +	ASSERT_ERR_PTR(skel->links.handle_kprobe_multi_sleepable,
> +		       "bpf_program__attach_kprobe_multi_opts");

As Kumar suggested, better to also verify the error here.

	ASSERT_EQ(libbpf_get_error(skel->links.handle_kprobe_multi_sleepable),
-EINVAL,
		  "bpf_program__attach_kprobe_multi_opts error");

> +
> +cleanup:
> +	kprobe_multi_sleepable__destroy(skel);
> +}
> +

[...]

Thanks,
Leon

---

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 78c974d4ea33..d59cf840da83 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -10,6 +10,7 @@
 #include "kprobe_multi_session_cookie.skel.h"
 #include "kprobe_multi_verifier.skel.h"
 #include "kprobe_write_ctx.skel.h"
+#include "kprobe_multi_sleepable.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"

@@ -633,6 +634,52 @@ static void test_attach_write_ctx(void)
 }
 #endif

+static void test_attach_multi_sleepable(void)
+{
+       struct kprobe_multi_sleepable *skel;
+       const char *sym = "bpf_fentry_test1";
+       int err;
+       LIBBPF_OPTS(bpf_test_run_opts, topts);
+       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts,
+                   .syms = &sym,
+                   .cnt = 1
+       );
+
+       skel = kprobe_multi_sleepable__open();
+       if (!ASSERT_OK_PTR(skel, "kprobe_multi_sleepable__open"))
+               return;
+
+       skel->bss->user_ptr = skel;
+
+       err =
bpf_program__set_flags(skel->progs.handle_kprobe_multi_sleepable,
+                                    BPF_F_SLEEPABLE);
+       if (!ASSERT_OK(err, "bpf_program__set_flags"))
+               goto cleanup;
+
+       /* Load should succeed even with BPF_F_SLEEPABLE for KPROBE types */
+       err = kprobe_multi_sleepable__load(skel);
+       if (!ASSERT_OK(err, "kprobe_multi_sleepable__load"))
+               goto cleanup;
+
+       /*
+        * Attachment must fail for kprobe.multi + BPF_F_SLEEPABLE.
+        * Also chosen a stable symbol to send into opts
+        */
+       skel->links.handle_kprobe_multi_sleepable =
+
bpf_program__attach_kprobe_multi_opts(skel->progs.handle_kprobe_multi_sleepable,
+                                                     NULL, &opts);
+       ASSERT_ERR_PTR(skel->links.handle_kprobe_multi_sleepable,
+                      "bpf_program__attach_kprobe_multi_opts");
+
ASSERT_EQ(libbpf_get_error(skel->links.handle_kprobe_multi_sleepable),
-EINVAL,
+                 "attach_multi_sleepable_err");
+
+       err =
bpf_prog_test_run_opts(bpf_program__fd(skel->progs.fentry), &topts);
+       ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+cleanup:
+       kprobe_multi_sleepable__destroy(skel);
+}
+
 void serial_test_kprobe_multi_bench_attach(void)
 {
        if (test__start_subtest("kernel"))
@@ -676,5 +723,7 @@ void test_kprobe_multi_test(void)
                test_unique_match();
        if (test__start_subtest("attach_write_ctx"))
                test_attach_write_ctx();
+       if (test__start_subtest("attach_multi_sleepable"))
+               test_attach_multi_sleepable();
        RUN_TESTS(kprobe_multi_verifier);
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
new file mode 100644
index 000000000000..932e1d9c72e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+void *user_ptr = 0;
+
+SEC("kprobe.multi")
+int handle_kprobe_multi_sleepable(struct pt_regs *ctx)
+{
+       int a, err;
+
+       err = bpf_copy_from_user(&a, sizeof(a), user_ptr);
+       barrier_var(a);
+       return err;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry)
+{
+       return 0;
+}
+
+char _license[] SEC("license") = "GPL";

