Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793387108;
	b=5HJCqv1eOHodrk6EgiZp0Qkj/Yoz3aHlZS4jR1mVdEb/tlJGPmxp1W1rL0LJTUHjchBl
	 8jakZ2SuD/UfBDpth67ccdQYT+3euSkeG9EDfXiQbsWNX/AHa3lnX2dQYK09Jctv1aYmF
	 tpBISSoi1s0gOzH8RWle4H1nrJpv2OZ0FCBBc0LG4HsWWc9HoDhrcjSrM1sL02LGqA9eG
	 zk5hEbc2+CHWLm7K5uwiCKA14WFd2X4yBCEuYzkAwHST3Q52HyydMt8r+4jHRWyjSBGU7
	 kt5kFv/fBTWBtE5U2ceiQHT2dki+ABaaNS75CAsm2MF9lQqxundJuXptA2DLqQdhVvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793387108;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9S4RNIkOFNm8jW4ZND0khesHKzdGtefV6/Ci1GIOCS0=;
	b=R4VDZyDmGvv3+t14/Tsmku1Q4ndhcdDUFVsVhT48bAj8s9xBWlZrxrClEmtSRDpAsQKX
	 lIEJbChuzNYpqgKv7cisB5NYm3253QSIXSymBeT9D5cv2vYTXJ+yQ/wnYWIBfm4QVeONj
	 lG8MHeOIwdC/QaFSQ+AwJMCqm7WmOgWSHA59GGR+bUtrM4TJ/YSdvU/f3rYXYU/QciKmp
	 vwVxNPFcMKOh6OdxBiIXHlO1DIaxeJhmfhEQU8DBQ97l+SVfyGcrPYac57zVaC3GIReJr
	 2nplkUCaStO0kE6X/kgjVNMxCYqGe5q+npaTbJ4OVpipb0Vj0q/pNX7y8VqJ9i1HJUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cm8GW42x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6306A606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cm8GW42x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245831F000C1;
	Fri, 30 Oct 2026 19:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793387108;
	bh=9S4RNIkOFNm8jW4ZND0khesHKzdGtefV6/Ci1GIOCS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cm8GW42xd8qs0azAfXRnfDb7yvU554SGjssE5HRoRbg5Kk9lfg/M6Gx/u6wZszOcC
	 uhtic6vVspgyK8C/L+xkJ5K9Srvp0ycs7VVS1grYEtzuEepx7td4TXbbvCji24GpF2
	 9e36FHPFUrOTxY34lkacByHTg78tmC6ZLD4NU0x4shcfv/SkBI2f4TpUqldlJ7BLZ0
	 1u1jAenb4B7z+KkbtnuCUqTcTNKC7M+jz0qKifBTWWdyqEbMMlJC3bs813cDMW1HHz
	 pIrOmR9HDQkO6k1N+Sfgqa8+GXeYR/H/dFenzcKv2wf3P/GZgRKdBxRm4fC/nW4HZl
	 98CXk8PQ67iOg==
Message-ID: <sashiko-outbox-191430@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: port test_ftrace.sh to
 test_progs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261030-ftrace_in_test_progs-v1-2-aa50c5dd1ccc@bootlin.com>
References: <20261030-ftrace_in_test_progs-v1-0-aa50c5dd1ccc@bootlin.com>
 <20261030-ftrace_in_test_progs-v1-2-aa50c5dd1ccc@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 19:05:07 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Medium] selftests/bpf: double free of ftrace in serial_test_fgraph_tramp=
oline()
- [Medium] selftests/bpf: incomplete filter write and clear in configure_tr=
acer()
- [Medium] selftests/bpf: unchecked realloc() in tracefs_read()
- [Medium] selftests/bpf: ignored tracefs_read() error in tracefs_ctl_updat=
e()
- [Low] selftests/bpf: uninitialized retval read in serial_test_fgraph_tram=
poline()
- [Low] selftests/bpf: multi-line comment style violation in fgraph_trampol=
ine.c
--

commit 504c8aaf5a6be7eba87f8423527b44e26046eff9
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

selftests/bpf: port test_ftrace.sh to test_progs

This commit ports the standalone test_ftrace.sh script to a serial test_pro=
gs
test (fgraph_trampoline) using the new tracefs_ctl helpers, testing fentry,
fexit, and fmod_ret BPF programs while the function_graph tracer is enabled,
and removes test_ftrace.sh.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fgraph_trampoline.c b=
/tools/testing/selftests/bpf/prog_tests/fgraph_trampoline.c
> new file mode 100644
> index 0000000000000..98edd77cf214e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/fgraph_trampoline.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "trace_helpers.h"
> +#include "fgraph_trampoline.skel.h"
> +
> +#define TRACER_GRAPH	"function_graph"
> +
> +#define FTRACE_NOTRACE	"*printk* *console* *wake* *serial* *lock*"
> +#define GRAPH_FUNCS	"bpf_prog_test*"
> +
> +/* See test_run.c: we are overriding bpf_modify_return_test with a progr=
am
> + * returning 5, but not bpf_modify_return_test2
> + */

[Severity: Low]
This isn't a bug, but in BPF code and selftests, should multi-line comments
place the opening /* on its own line with the comment text starting on the
following line?

> +#define FMOD_EXPECTED_RETVAL ((1 << 16) | (5 + 1 + 3 + 3 + 4 + 5 + 6 + 7=
))
> +
> +static int configure_tracer(struct tracefs_ctl *ftrace)
> +{
> +	int err;
> +
> +	err =3D tracefs_ctl_filter_write(ftrace, "set_ftrace_filter", "");
> +	if (err)
> +		return err;
> +	err =3D tracefs_ctl_filter_write(ftrace, "set_ftrace_notrace",
> +				       FTRACE_NOTRACE);
> +	if (err)
> +		return err;
> +	err =3D tracefs_ctl_filter_write(ftrace, "set_graph_function", GRAPH_FU=
NCS);
> +	if (err)
> +		return err;
> +	err =3D tracefs_ctl_filter_write(ftrace, "set_graph_notrace", "");
> +	if (err)
> +		return err;

[Severity: Medium]
Do these tracefs_ctl_filter_write() calls in configure_tracer() actually cl=
ear
existing filters and write all patterns in FTRACE_NOTRACE?

First, when configure_tracer() passes "" to clear set_ftrace_filter and
set_graph_notrace on the first access to those files, tracefs_ctl_update() =
in
tools/testing/selftests/bpf/trace_helpers.c opens the file without O_TRUNC =
and
writes to the same descriptor instead of calling tracefs_write_file():

    fd =3D open(path, O_CLOEXEC | O_RDWR);
    if (fd < 0)
        return fd;

    err =3D tracefs_read(fd, &old);
    ...
    err =3D tracefs_write(fd, str);
    close(fd);

In the kernel (ftrace_regex_open() and __ftrace_graph_open() in
kernel/trace/ftrace.c), filter hashes are only cleared when the file is ope=
ned
with O_TRUNC; opening without O_TRUNC copies the existing filter hash, and a
zero-byte write(fd, "", 0) returns 0 without clearing it. In addition,
configure_tracer() does not clear set_ftrace_notrace or set_graph_function
before writing to them, so pre-existing filters in all four files remain ac=
tive.

Second, FTRACE_NOTRACE contains multiple space-separated patterns
("*printk* *console* *wake* *serial* *lock*"). In the kernel,
ftrace_notrace_write() -> ftrace_regex_write() -> trace_get_user() consumes
only one whitespace-delimited token per write() call and returns the number=
 of
bytes consumed for that first token. Because tracefs_write() in
tools/testing/selftests/bpf/trace_helpers.c does a single write() without
looping over partial writes:

    ret =3D write(fd, str, strlen(str));
    if (ret < 0)
        return ret;
    return 0;

won't all patterns after "*printk*" be silently dropped?

> +	err =3D tracefs_ctl_set(ftrace, "current_tracer", TRACER_GRAPH);
> +	if (err)
> +		return err;
> +
> +	return err;
> +}

[Severity: Medium]
When configure_tracer() calls tracefs_ctl_filter_write() or tracefs_ctl_set=
(),
tracefs_ctl_update() invokes tracefs_read() in
tools/testing/selftests/bpf/trace_helpers.c:

    do {
        n =3D read(fd, tmp, CHUNK_SIZE);
        if (n < 0) {
            if (buf)
                free(buf);
            return n;
        }
        if (!n)
            break;
        buf =3D realloc(buf, len + n + 1);
        memcpy(buf + len, tmp, n);
        len +=3D n;
    } while (1);

If realloc() fails and returns NULL, doesn't this leak the prior buf alloca=
tion
and immediately dereference NULL in memcpy(buf + len, tmp, n)?

> +
> +static int run_test_under_ftrace_graph(struct tracefs_ctl *ftrace,
> +				       struct bpf_program *prog, int *retval)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	int err, stop_err;
> +
> +	err =3D tracefs_ctl_set(ftrace, "tracing_on", "1");
> +	if (err)
> +		return err;
> +
> +	err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
> +	if (retval)
> +		*retval =3D opts.retval;
> +
> +	stop_err =3D tracefs_ctl_set(ftrace, "tracing_on", "0");
> +	if (!err)
> +		err =3D stop_err;
> +
> +	return err;
> +}
> +
> +void serial_test_fgraph_trampoline(void)
> +{
> +	struct fgraph_trampoline *skel =3D NULL;
> +	struct tracefs_ctl *ftrace;
> +	int retval;
> +
> +	ftrace =3D tracefs_ctl_init();
> +	if (!ASSERT_OK_PTR(ftrace, "tracefs_ctl_init"))
> +		return;
> +
> +	if (configure_tracer(ftrace)) {
> +		test__skip();
> +		tracefs_ctl_restore(ftrace);
> +		goto cleanup;
> +	}

[Severity: Medium]
If configure_tracer(ftrace) fails in serial_test_fgraph_trampoline(), won't
calling tracefs_ctl_restore(ftrace) before jumping to cleanup cause a
use-after-free and double-free of ftrace?

In tools/testing/selftests/bpf/trace_helpers.c, tracefs_ctl_restore() frees
each entry->old buffer, ctl->entries, and ctl itself:

    for (i =3D ctl->cnt; i > 0; i--) {
        struct tracefs_ctl_entry *entry =3D &ctl->entries[i - 1];
        ...
        free(entry->old);
    }
    free(ctl->entries);
    free(ctl);

Jumping to the cleanup label then calls tracefs_ctl_restore(ftrace) a second
time on the already freed pointer.

[ ... ]

> +	if (test__start_subtest("attach_fmod_ret")) {
> +		skel->links.fmod_ret_test =3D
> +			bpf_program__attach(skel->progs.fmod_ret_test);
> +		if (!ASSERT_OK_PTR(skel->links.fmod_ret_test, "attach_fmod_ret"))
> +			goto destroy_cleanup;
> +
> +		ASSERT_OK(run_test_under_ftrace_graph(ftrace,
> +						      skel->progs.fmod_ret_test,
> +						      &retval),
> +			  "run test with fmod_ret");
> +		ASSERT_EQ(retval, FMOD_EXPECTED_RETVAL, "fmod return value");

[Severity: Low]
In serial_test_fgraph_trampoline(), retval is declared without initializati=
on.
If run_test_under_ftrace_graph() fails at tracefs_ctl_set(ftrace, "tracing_=
on",
"1") and returns early before writing *retval, ASSERT_OK() will record the
failure without returning and ASSERT_EQ(retval, FMOD_EXPECTED_RETVAL, ...) =
will
read the uninitialized retval variable. Could retval be initialized or only
checked when run_test_under_ftrace_graph() succeeds?

> +
> +		fgraph_trampoline__detach(skel);
> +	}
> +
> +destroy_cleanup:
> +	fgraph_trampoline__destroy(skel);
> +cleanup:
> +	tracefs_ctl_restore(ftrace);
> +}

[Severity: Medium]
Does tracefs_ctl_update() in tools/testing/selftests/bpf/trace_helpers.c le=
ave
tracefs state unrecorded for tracefs_ctl_restore() if tracefs_read() fails?

In tracefs_ctl_update():

    err =3D tracefs_read(fd, &old);
    if (!err) {
        ...
        recorded =3D true;
    }

    err =3D tracefs_write(fd, str);

If tracefs_read(fd, &old) returns an error, tracefs_ctl_update() skips reco=
rding
the original value in ctl->entries but still calls tracefs_write(fd, str),
modifying the system-wide tracefs file without saving its previous state for
tracefs_ctl_restore().

Also, in tracefs_ctl_restore():

    err =3D tracefs_restore_file(entry);
    if (err)
        fprintf(stderr, "Failed to restore %s: %s\n",
                entry->path, strerror(-err));

open(), lseek(), and write() failures in tracefs_write_file() and
tracefs_write() return -1 rather than -errno, so passing -err to strerror()
will always report EPERM when a syscall fails.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-ftrace_in_=
test_progs-v1-0-aa50c5dd1ccc@bootlin.com?part=3D2
