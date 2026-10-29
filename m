Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263129;
	b=gcTGWXFEcRWR4XincewhKyNWOX+KWO6cq4PbgWG2ZjW4DBlpMQw+xpkqTEENQ7k/pyXU
	 OGQ2uEd4NF/avug4pG9ynFcarwWxlxMh5MVe9inJmGoTg2vEtzjb1gcAZCALI/Bd0Q8zM
	 jqFuzhdvHOF3AHKA3ujsDoH4y4fZ3qaZ2vK80ARUi+03O0fRPMW+ZmXvDQN8s4lQqpRC+
	 J0O/yLjdMQBITJLblFW6b7wO5bWPmG/2KTS3urb0vaUPmhmpq++PjE+M7EWWnQ/DXd1W7
	 DyeSt4NYSFx68vgkk4pN79W0LVSxN9KHuPo4zvJ4Uow+IkfLNkXVHgQxW7QJUdJNt6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ARZWbOaW7wv6T6KkZen2udFyVQtwRS9a+K+t3bSHiyc=;
	b=pA/nYsdn6aVicAjiR1C+2d3ONSG/BuHXTOlQ/2u0OjrKOP2VlL6G2Y3TOcs+LrkOu2Wf
	 o5VPCeZd/eVUR96vsxxqfOXPQxn+vMqIm2KCFctTHOk87BQRJb1D7AY1sAPaRaxwafeWO
	 MJjIsmuZdMvv3YXuXjxKsNQm22FssmR3bw9SPb7O3boBvwHpf3obcB1ppPmM0ottFJ5X8
	 cKuO6nfRATgOpQeb17r/Wztgz4DDFwWK3NU/eZc+r5l7XBVr7JTUHmPGc7WhxkfErE0JH
	 nQNkEAnIZ5C02v+IWeBCMeuEl9ajI/MG0oPoPTYqj+Me6ty3E8EGv8hb1dllhhFB9MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jTdzqa/j";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53706606A31D
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 08:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53706606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jTdzqa/j
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso12592245e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 01:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263128; x=1793867928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ARZWbOaW7wv6T6KkZen2udFyVQtwRS9a+K+t3bSHiyc=;
        b=jTdzqa/jSgI+0+3jmD0D2HSpCIR0FjNpHQERDulzCzNdMkycbVneN1+C3+yHpnAGTW
         HWytbEAnznC+f5k2muOazV25i2Ym8eInmbqa5pxCVINb361ttos9PmlCFCtNLZkFXKRn
         48ORji7CAGHOHZXk448bUtiyOjk5DuKuHaQCjoQDjDKxW6bjkVlOwLfZh4sLLNmNlyKu
         VLR5GvPOEm8BZKOY7e3cTV/NLGEwWdwyTS9Ih76smNQj/ee+VXir0S7DUlHDVqksT1Mn
         pJBljzxrL82HJz2Qpqe3n1BFT7fw6uq4IFhR2C8+ToSP1ySskM/yrph7k6vrAtdv9Alh
         cffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263128; x=1793867928;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ARZWbOaW7wv6T6KkZen2udFyVQtwRS9a+K+t3bSHiyc=;
        b=Nlz4tzUnKzRfAH9KMeDpw3xgRdAvIdWNI28UaXF0H18Yt129OTbrQsSFzjWv6gl8pd
         vnc1UuPnOW4TgkxXToP0kCKz6y8cVbTZuwcV7Xt7loqIlyAw2cixHLAE9EXwigddJMW3
         qpYJoQaN3RKoUvRj1LTlQmMAe9Ih5/zcjzlRVbY7mwqKHoHdP4mLCzvS7Pj8lWqZ7Wud
         YbQFZAkJVP1Mki1F0zFF4ncw/twaT+HhBZ4ilY+HVrV/CMMskMo6HK/rT6mvcwNhKRWV
         G+CzSgJ9Gex+aFAmZJ/3gkNkXBMZClxSsxy5IoP2YxpeWn2zVmvu0y0Qb5QTLX4tiWW3
         yAqQ==
X-Gm-Message-State: AFq9FYI4RnZWHiCkvst7oBlOThaD9MYtfS+162fTQ+zfASuYArz4CduZ
	cNGN2GoNXRdkYrOLFM9Zpm9gkCkfBJeMb7V/TFp96OZWOsovXfucfwgK
X-Gm-Gg: AYBFou1K9xWy93ZHY243upQNTLkvXwkvFlfQVn8MXznn1k+55X4tm6IcvwBcD4NXKOy
	6U3IpwrW1vLv9c8O3axtzLyWKLPMuLOQUneBC2DhIBcRjeK/wfxKASaPsMxS1tHGCRrw+S8u5xo
	vB3F4PJ8a+H7N5YMnVg7AERyPcsK5GpTnNvnhY9GsFJQTB+enwCoVuL3MZhPHW8HXLIBl/idnjK
	Sak2JwLGLGVW652NYPbkeRVP67fF0Of38fxYemibyF/UeYDyfzLESnBNIdW0LsHXLz+m0P4ON4+
	28LgcqnG5IFBPyFMlW2g7gDkFr+eEwLuk79SCS+kHefSt3n+G2EWan213NsYoNwRuJdJeev70Sl
	gtAqbsxYZU4CJlZQpsbKt1Ue579wmb0Nbjzlk+yDC3R/tDD6ErszVd5MZMh08U+M0OA0Lhe5XUE
	u6sA2YED7mBdElQBpqnYYEC2LwkWKy0k+DbIfjRPtmdnw8ftcGxs/L53BaLnfTyWeZz+HZEdkQV
	8fpplsDj1ONLz7AdYi1jyCx81fIKNjJA2FgvtrU+cBYKNenlhxkY+DuGz/D+Zn1vRRko+yyjl3r
	3g==
X-Received: by 2002:a05:600c:6088:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4a9677ca203mr111954735e9.27.1793263127536;
        Thu, 29 Oct 2026 01:38:47 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm50453155e9.1.2026.10.29.01.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:38:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 29 Oct 2026 09:38:45 +0100
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, rostedt@goodmis.org, ast@kernel.org,
	andrii@kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test kprobe and fentry/fexit
 programs on one function
Message-ID: <auMGFcERFA_RfgWt@krava>
References: <20261028202345.1215859-1-daniel@iogearbox.net>
 <20261028202345.1215859-2-daniel@iogearbox.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028202345.1215859-2-daniel@iogearbox.net>

On Wed, Oct 28, 2026 at 09:23:45PM +0100, Daniel Borkmann wrote:
> A kprobe next to a BPF trampoline makes the ftrace site of the function
> call ftrace_regs_caller and from there the list of ftrace callbacks,
> the path that crashed while ftrace_ops_list_func() started at an odd
> address. No test covers a function traced by both. Thus, attach an
> fentry program and a kprobe to bpf_fentry_test1(), then a second fentry
> program, which modifies the trampoline of the shared site, then an fexit
> program, after which ftrace_regs_caller enters the trampoline by a jmp,
> then detach the kprobe, after which the site jumps to it directly. After
> each step, check that every attached program ran once for the call and
> saw its argument, and the fexit program its return value.
> 
> Without the previous fix the test crashes the kernel, but only where
> ftrace_ops_list_func() is at an odd address (in my test with gcc +
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y). With the fix it passes:
> 
>   # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t fentry_kprobe_shared
>   [...]
>   #147     fentry_kprobe_shared:OK
>   Summary: 1/0 PASSED, 0 SKIPPED, 0/0 FAILED
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Menglong Dong <dongml2@chinatelecom.cn>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> ---
>  .../bpf/prog_tests/fentry_kprobe_shared.c     | 65 +++++++++++++++++++
>  .../bpf/progs/fentry_kprobe_shared.c          | 49 ++++++++++++++
>  2 files changed, 114 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_kprobe_shared.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_kprobe_shared.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_kprobe_shared.c b/tools/testing/selftests/bpf/prog_tests/fentry_kprobe_shared.c
> new file mode 100644
> index 000000000000..751aa49d6106
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/fentry_kprobe_shared.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "fentry_kprobe_shared.skel.h"
> +
> +static void trigger(struct fentry_kprobe_shared *skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	int err;
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.fentry1), &topts);
> +	ASSERT_OK(err, "test_run");
> +}
> +
> +/*
> + * With a kprobe next to the trampoline, the ftrace site of the function
> + * reaches the trampoline through the list of ftrace callbacks, and so does
> + * the site of a trampoline that is modified to add or remove a program.
> + * With the fexit program, the trampoline is entered by a jmp.
> + */
> +void test_fentry_kprobe_shared(void)
> +{
> +	struct fentry_kprobe_shared *skel;
> +
> +	skel = fentry_kprobe_shared__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +	skel->bss->pid = getpid();
> +
> +	skel->links.fentry1 = bpf_program__attach(skel->progs.fentry1);
> +	if (!ASSERT_OK_PTR(skel->links.fentry1, "attach_fentry1"))
> +		goto out;
> +	skel->links.kprobe1 = bpf_program__attach(skel->progs.kprobe1);
> +	if (!ASSERT_OK_PTR(skel->links.kprobe1, "attach_kprobe1"))
> +		goto out;
> +	trigger(skel);
> +	ASSERT_EQ(skel->bss->fentry1_hits, 1, "fentry1_hits");
> +	ASSERT_EQ(skel->bss->kprobe_hits, 1, "kprobe_hits");
> +
> +	skel->links.fentry2 = bpf_program__attach(skel->progs.fentry2);
> +	if (!ASSERT_OK_PTR(skel->links.fentry2, "attach_fentry2"))
> +		goto out;
> +	trigger(skel);
> +	ASSERT_EQ(skel->bss->fentry1_hits, 2, "fentry1_hits");
> +	ASSERT_EQ(skel->bss->fentry2_hits, 1, "fentry2_hits");
> +	ASSERT_EQ(skel->bss->kprobe_hits, 2, "kprobe_hits");
> +
> +	skel->links.fexit1 = bpf_program__attach(skel->progs.fexit1);
> +	if (!ASSERT_OK_PTR(skel->links.fexit1, "attach_fexit1"))
> +		goto out;
> +	trigger(skel);
> +	ASSERT_EQ(skel->bss->fentry1_hits, 3, "fentry1_hits");
> +	ASSERT_EQ(skel->bss->fentry2_hits, 2, "fentry2_hits");
> +	ASSERT_EQ(skel->bss->fexit_hits, 1, "fexit_hits");
> +	ASSERT_EQ(skel->bss->kprobe_hits, 3, "kprobe_hits");
> +
> +	bpf_link__destroy(skel->links.kprobe1);
> +	skel->links.kprobe1 = NULL;
> +	trigger(skel);
> +	ASSERT_EQ(skel->bss->fentry1_hits, 4, "fentry1_hits");
> +	ASSERT_EQ(skel->bss->fentry2_hits, 3, "fentry2_hits");
> +	ASSERT_EQ(skel->bss->fexit_hits, 2, "fexit_hits");
> +	ASSERT_EQ(skel->bss->kprobe_hits, 3, "kprobe_hits");
> +out:
> +	fentry_kprobe_shared__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/fentry_kprobe_shared.c b/tools/testing/selftests/bpf/progs/fentry_kprobe_shared.c
> new file mode 100644
> index 000000000000..3d16773aada8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fentry_kprobe_shared.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int pid;
> +int fentry1_hits;
> +int fentry2_hits;
> +int fexit_hits;
> +int kprobe_hits;
> +
> +static bool from_test(int a)
> +{
> +	return (bpf_get_current_pid_tgid() >> 32) == pid && a == 1;
> +}
> +
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(fentry1, int a)
> +{
> +	if (from_test(a))
> +		fentry1_hits++;
> +	return 0;
> +}
> +
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(fentry2, int a)
> +{
> +	if (from_test(a))
> +		fentry2_hits++;
> +	return 0;
> +}
> +
> +SEC("fexit/bpf_fentry_test1")
> +int BPF_PROG(fexit1, int a, int ret)
> +{
> +	if (from_test(a) && ret == 2)
> +		fexit_hits++;
> +	return 0;
> +}
> +
> +SEC("kprobe/bpf_fentry_test1")
> +int BPF_KPROBE(kprobe1, int a)
> +{
> +	if (from_test(a))
> +		kprobe_hits++;
> +	return 0;
> +}
> -- 
> 2.43.0
> 
