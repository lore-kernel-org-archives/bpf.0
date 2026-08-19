Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5153B47D9
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787100724; cv=none; b=tTDcy1ChjstK8NgdGl1rqmkZ71ykFajKAwdQ6OGSk2wqCfqQjXIYuzwlcdK0FayKe9d6B3azsekyktDEjWILjRHXxme9kFFNAH6iiSl8zduiy6ck6TjgBvhuIV9FJI/rpSQgAx0p3JXr9Phy+9SuIv7Wuebwj3fwUAcyvfgZEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787100724; c=relaxed/simple;
	bh=drmmQM2zQ/3arwMjOC24nDokB5ci0sg/YNQXNeZP4ZY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fWkaEmxtnlyH0gMhLg7dQnuW6iUCAtWFkBAdx1eoRATu2oaSuWLOOsJjtGkdL3jLkXROXI1UDhpQwIcqdddJP8MMZuzXo6xolmltHD7O+SBPp0ql3G73dHAfdd8rweAri0H1ilypZwUqy5nLeOpCF2ZCAXUHsrowX7qdr7p5Nrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=0byo8aul; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="0byo8aul"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1168507a12.1
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 17:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787100718; x=1787705518; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YqZ+lquUct7OgV0Kb+n4xKfmL/YvvXGtH+0T7/T1vGA=;
        b=0byo8aulb98gQBT1GOBiCV06WKlti9ylavZIfqFlVUYiR3UGz8TC9FH91UvGgX72W+
         H3aC0Ibjqpblq+6vX35IlVtJXBkZdIWk7w4rNapu/PWWff2E2d6fktN1/6tuGJYCGYVQ
         cYCyU3ggFdvLm3c/95U53vW83d+QUJF4FwOUkh4E7HK9+ORco9YWUwB4lr0Wn/8YW5Kh
         kLPbwijCZC/+PhoTmZ7zsDkF8Af7wHZWmYVaGkAuxNE8HOaJl2M01mYALSOfZYGPr8az
         ryjnZjS3E4x6Sx4seea06ooIH0+mQ5DTPgpJg8ah4ys22CuSKAoKTce3CXPfrkRKyBXl
         SVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787100718; x=1787705518;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YqZ+lquUct7OgV0Kb+n4xKfmL/YvvXGtH+0T7/T1vGA=;
        b=qay5Sjd8Mg2Mb518/7Gbm1K9Cz0fmiZBxA8eSc0ReVpLa6wYfIvm062kNNulXTEWxG
         6iwNuGxYzZ1gstcz83MSCDWb84J3LJOb9M+wT9iFEH/RjOABTcYMhPaW3Oq/2syAElCM
         uB5UzIutpGmkmIESomUZXOYsv6rv9GV9Hs8mNaaFdYhALqJndylUEtMhQgDT7VfZAURN
         FkOAluDVh0+RnNhonmY0dKUGH2NlPBz70O/bdNQvgvz7PtpF9NkhBl58o9AcNZ/oVDpv
         yu0HkVX/Rsc1LFDgwisGeBjR1JPGIP4prsnoJOpRkFwts4nW1PX9B6uTesyZm4HKqoK9
         hxSQ==
X-Forwarded-Encrypted: i=1; AHgh+RraE8/5zkm5oz22TYMyKJZdB4JxwTw3I99YyKscygF79BJt+iq0uASIBKk4KZA44b0LYQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLPDW7Bn3XoSXZ0CzmzHN4okYcqRFuO0tsSvqSc1dfP3V6Boe
	lChLKUXQ8MxTWkePP4xIR6VA3fNVm07QrfrKdQHqg9pWcdbt4mKUs8rJ4jJ2q7jrm+k=
X-Gm-Gg: AR+sD13L9iiLVQbdV4JQFFT3AaZHYOAjezEcWGDSW9wN4X63/okjxOZamCUso2gOf41
	NbGxw6HRzEHxbT0xOVWYJPzmw2n0FY+1FW024rXYWgTTvxlgEDcqURPmN1YqF8x9W3Tfk6VHcXQ
	U3g+UEl+bs8jYoyoOIECZT/z8lju2VBYr3/Q9htLhqnXIIGX8DPZcwYwzStvTNhTLvnfxs2UM2X
	gmr8zM4zyUjxLoIiYPxYiDg0gDrxvDbCPnExGTGqQ8glpYd5oV72Tyh5xZhOZnZKyZ66SsLC3qg
	nPCsLzcnphRwgFRgWd7knBHuTp/4qP1MLF03EZRSsPJ+CnP9NvPwAtafAiS0bM2RD3btcWfUr0a
	Vn9TY39KyBNFPyrH1UIjqCmiJp+OT+fiwVAD97Z5foDGLl+nhnJ6ZWm99lUMyKJwn8wIBmj/n4P
	/Oc47zNXZrWN+4YIXcYxR9uQsT5r/fKKJKIEeXgZkhV84BoSgpodlk9uKTa/N3tf5pBg6hyciBB
	xPuYUDyUwrVwkvV/g==
X-Received: by 2002:a17:90b:4b91:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-3957f874e86mr1158483a91.1.1787100717529;
        Tue, 18 Aug 2026 17:51:57 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb87174sm519704a91.12.2026.08.18.17.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 17:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Aug 2026 20:51:55 -0400
Message-Id: <DKSIBYZNN07W.12NSCHYUCJQPH@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Shuah Khan" <shuah@kernel.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Add a test for arena
 fault-in under memory.max
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260808140720.293604-1-jiayuan.chen@linux.dev>
 <20260808140720.293604-5-jiayuan.chen@linux.dev>
In-Reply-To: <20260808140720.293604-5-jiayuan.chen@linux.dev>

On Sat Aug 8, 2026 at 10:05 AM EDT, Jiayuan Chen wrote:
> A child joins a memcg capped 64M above its post-load usage and faults an
> arena in until it runs out of that budget.
>
> With the fix the arena page comes from the sleepable allocator, so
> hitting memory.max goes through the memcg OOM path and the child is
> OOM-killed, which the test checks via memory.events "oom_kill".
>
> Without the fix the test may still pass, because a concurrent blocking
> allocation in the child (e.g. a COW fault on an inherited page) can hit
> memory.max and OOM-kill it first. The goal is only that the fixed kernel
> passes reliably.
>
>   # test_progs -v -t arena_memcg
>   serial_test_arena_memcg:PASS:child killed by signal
>   serial_test_arena_memcg:PASS:memcg oom_kill
>   #5       arena_memcg:OK
>
>   # dmesg (the OOM comes from the arena sleepable allocation)
>   test_progs invoked oom-killer: gfp_mask=3DGFP_KERNEL_ACCOUNT|__GFP_ZERO
>    arena_vm_fault+0x4bc/0xad0
>   Memory cgroup out of memory: Killed process 473 (test_progs)
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/prog_tests/arena_memcg.c    | 156 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/arena_memcg.c |  24 +++
>  2 files changed, 180 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
>  create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools=
/testing/selftests/bpf/prog_tests/arena_memcg.c
> new file mode 100644
> index 000000000000..af49d8b1b995
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <sys/user.h>
> +#ifndef PAGE_SIZE /* on some archs it comes in sys/user.h */
> +#include <unistd.h>
> +#define PAGE_SIZE getpagesize()
> +#endif
> +
> +#include "cgroup_helpers.h"
> +#include "arena_memcg.skel.h"
> +
> +#define CG_PATH		"/arena_memcg"
> +
> +/* Budget the arena gets on top of whatever is already charged after loa=
d. */
> +#define ARENA_BUDGET	(64 * 1024 * 1024)
> +
> +static void dump_memcg(int (*rd)(const char *, const char *, char *, siz=
e_t))
> +{
> +	char buf[512];
> +
> +	/*
> +	 * memory.current reads 0 once the child has left the cgroup, so it onl=
y
> +	 * carries information when dumped from the live child; memory.peak and
> +	 * memory.events survive the child and tell the story either way.
> +	 */
> +	if (!rd(CG_PATH, "memory.current", buf, sizeof(buf)))
> +		fprintf(stderr, "memory.current: %s", buf);
> +	if (!rd(CG_PATH, "memory.max", buf, sizeof(buf)))
> +		fprintf(stderr, "memory.max: %s", buf);
> +	if (!rd(CG_PATH, "memory.peak", buf, sizeof(buf)))
> +		fprintf(stderr, "memory.peak: %s", buf);
> +	if (!rd(CG_PATH, "memory.events", buf, sizeof(buf)))
> +		fprintf(stderr, "memory.events:\n%s", buf);
> +	fflush(NULL); /* _exit() in the child would not flush stdio otherwise *=
/
> +}
> +
> +/* Read one key from a flat keyed cgroup file, e.g. "oom_kill" in memory=
.events. */
> +static long cg_read_key(const char *cg, const char *file, const char *ke=
y)
> +{
> +	char buf[512], *p;
> +
> +	if (read_cgroup_file(cg, file, buf, sizeof(buf)))
> +		return -1;
> +	p =3D strstr(buf, key);
> +	if (!p)
> +		return -1;
> +	return strtol(p + strlen(key), NULL, 10);
> +}
> +
> +void serial_test_arena_memcg(void)
> +{
> +	int cgroup_fd =3D -1, status;
> +	const long ps =3D PAGE_SIZE;
> +	char buf[64];
> +	pid_t pid;
> +
> +	if (setup_cgroup_environment())
> +		return;
> +
> +	cgroup_fd =3D create_and_get_cgroup(CG_PATH);
> +	if (!ASSERT_OK_FD(cgroup_fd, "create_and_get_cgroup"))
> +		goto out;
> +
> +	/* No memory controller -> nothing to test. */
> +	if (read_cgroup_file(CG_PATH, "memory.current", buf, sizeof(buf))) {
> +		test__skip();
> +		goto out;
> +	}
> +
> +	pid =3D fork();
> +	if (!ASSERT_GE(pid, 0, "fork"))
> +		goto out;
> +	if (pid =3D=3D 0) {
> +		struct arena_memcg *cskel;
> +		__u32 i, npages;
> +		char *base;
> +		size_t sz;
> +		long cur;
> +
> +		/*
> +		 * Do everything from the child: the arena vma is VM_DONTCOPY so
> +		 * it would not survive fork(), only the child should be under the
> +		 * limit so that a memcg OOM cannot pick test_progs, and a map is
> +		 * charged to the memcg of the task that creates it - so join
> +		 * before load. The cgroup work dir belongs to the parent that set
> +		 * the environment up, so reach it with the _parent() helpers.
> +		 * Errors are reported to the parent through the exit code, since
> +		 * ASSERT_* in a forked child does not reach it.
> +		 */
> +		snprintf(buf, sizeof(buf), "%d", getpid());
> +		if (write_cgroup_file_parent(CG_PATH, "cgroup.procs", buf))
> +			_exit(2);
> +
> +		cskel =3D arena_memcg__open_and_load();
> +		if (!cskel)
> +			_exit(3);
> +
> +		base =3D bpf_map__initial_value(cskel->maps.arena, &sz);
> +		if (!base)
> +			_exit(4);
> +		npages =3D bpf_map__max_entries(cskel->maps.arena);
> +
> +		/*
> +		 * Cap only now, after load: everything but the fault-in is
> +		 * charged, so the arena gets a fixed budget regardless of what
> +		 * the load itself cost, and the load can never hit the limit.
> +		 */
> +		if (read_cgroup_file_parent(CG_PATH, "memory.current", buf, sizeof(buf=
)))
> +			_exit(5);
> +		cur =3D strtol(buf, NULL, 10);
> +		snprintf(buf, sizeof(buf), "%ld", cur + ARENA_BUDGET);
> +		if (write_cgroup_file_parent(CG_PATH, "memory.max", buf))
> +			_exit(6);
> +
> +		for (i =3D 0; i < npages; i++)
> +			base[(size_t)i * ps] =3D 1;
> +		/* Faulted everything without dying: no pressure built, dump why. */
> +		dump_memcg(read_cgroup_file_parent);
> +		_exit(0);
> +	}
> +
> +	if (!ASSERT_EQ(waitpid(pid, &status, 0), pid, "waitpid"))
> +		goto out;
> +
> +	/* A non-zero exit means the child failed to set up; the code says wher=
e. */
> +	if (WIFEXITED(status) && WEXITSTATUS(status)) {
> +		ASSERT_OK(WEXITSTATUS(status), "child setup");
> +		goto out;
> +	}
> +
> +	/*
> +	 * Faulting a valid arena address until memory.max is hit must not look
> +	 * like an invalid access. Without the fix the fault path allocated wit=
h
> +	 * the non-blocking allocator, turned its -ENOMEM into VM_FAULT_SIGSEGV=
,
> +	 * and the child died with SIGSEGV on a valid address; now it is handle=
d
> +	 * by the memcg OOM path instead. A SIGKILL alone would not prove the
> +	 * memcg OOM killer did it (a global OOM or an unrelated crash could al=
so
> +	 * kill the child), so check memory.events.oom_kill, which records the
> +	 * memcg OOM and survives the child.
> +	 */
> +	if (!ASSERT_TRUE(WIFSIGNALED(status), "child killed by signal"))
> +		goto out;
> +	if (!ASSERT_GE(cg_read_key(CG_PATH, "memory.events", "oom_kill"), 1,
> +		       "memcg oom_kill"))
> +		dump_memcg(read_cgroup_file);
> +out:
> +	if (cgroup_fd >=3D 0)
> +		close(cgroup_fd);
> +	cleanup_cgroup_environment();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/arena_memcg.c b/tools/test=
ing/selftests/bpf/progs/arena_memcg.c
> new file mode 100644
> index 000000000000..adecd9e8463e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_memcg.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_arena_common.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 100000); /* number of pages */
> +#ifdef __TARGET_ARCH_arm64
> +	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
> +#else
> +	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
> +#endif
> +} arena SEC(".maps");
> +
> +SEC("syscall")
> +int noop(void *ctx)
> +{
> +	return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";

