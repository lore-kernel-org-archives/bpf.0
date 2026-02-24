Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E439A7F2
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938755; cv=none; b=tqCZoxATNOlGrAgN9HZ74DDXlUmfZ1S5jF56tc14GscVwnu8lmfnFOBDfAUQPpkmeUxpa7Uggtyyqc7hGRk8j5mF/bP5pLaE6xBHhcSIckQAFko+xJNwG8i96E2b+tzL7MhqkOxSn6tyJqAFiCPMCzzyNyJ/2KCfJ/2WxLcjuH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938755; c=relaxed/simple;
	bh=wbOBk0Fd0SKtT/JaetizwZKdyxIePRjiQd2+sCd5Rls=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViQw4HKIXjtZTZfK3QWwTpOTkE4oml2aQRy36ZdiZFNhUMg3ghIediEWqychVdcWj4KIWBh+E0iPtKy/iTok9DyKP9qTRQ09OTedaNSV8TaRkco72HnyN2oQtgadI44+MWUuTxtzSnDGy4fuaI48jWGEpNLQORb3TburSb9EMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iW5eEvfM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iW5eEvfM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483a233819aso53553775e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 05:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771938753; x=1772543553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMsQLpJRHzcAo8oV79WX+29rruSKqqv3UZmJUPZ2+IY=;
        b=iW5eEvfMuUvnJX5p/0ocBBgPoTGpLQyWCar7cWqCMY5JnMuhnLbz4D+MYIW+cw8NHk
         GzZmNYBg6gS3UuLrLUbRk44SE823R1rwUytYHoc4l9b6Wl8PUemWHZlDxvvmkuY7OCPy
         mucO97w8UVYl1c68Cx3XypnUbmu0Bb3cIRgOljmS8t0RPY3b3mmAfWHhRTS59yP2BI8c
         HIKJb5cTEYc2YXiKv/N1IezBL1Hs1sRArB7R+XP/lpxCtacIbYyyRVNJ37if6+ySChXY
         guphTZIrsAa8qmNl98GaLelvCQ7ys8+TAhV0oe+KxU+CwYY7OoSmycak13SWaOwFTiAD
         b9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771938753; x=1772543553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMsQLpJRHzcAo8oV79WX+29rruSKqqv3UZmJUPZ2+IY=;
        b=w48tbHqUNPvg76/ifk2vOed+g9JM99dFCMu3115mrFH9piyt871XZh9rP0AveczS24
         rDJVowgDDmdf1E2uZ/ARtlYN4PcCliZ8Kg8Jw3pPCzzBX4a6OjJmJTaSyxvMCFY4N+B7
         qm6ZQ9SkwLmZOL8azc4jlOzeK7PajgyN1T6A+8AEe1mzJR54I1Hk7DmMxich1vZzUr3O
         2EkJOrSQwpSCp9F0+s56u0yz0JZqSH62sAUSEAR/MuFcr9tCIjxFdwJOSPP5Nnqti3Hi
         vKNNpex8/DzzeOdie9vHCam4x9OsVWvrD+gS+TkFRpASzy3G2JhtHJOV4kXPQlsGtVxG
         rbhw==
X-Gm-Message-State: AOJu0YyScjJSXO64J2lDDM3hjf/SVOBAJyX8OAUiszuaTB28njyEKOZn
	2zZIy6ahMIRLMDsw/8i0D/cbRXAy1W99cMgKZ0u7FYZc4pxKS1OCVeki
X-Gm-Gg: AZuq6aIPA7WzTcWTKKXTiNfmpWzDDMkU/YyOhzs9loemmVZaXy3pFSPlfN3IUvgioUt
	ImcKCgnUoghcAv8J21FJTnNsiezyWF8ESknx+bNaJVXTsYzwWh3r5pBDb+7g8PHquZDbZYExBGk
	jVIcyfNdxrqD+LSFpNfEVDfIxyTMyiDzoxS7zizs5BT7dQkBCJwO9JHa/L72+lGlTqy7WY8HbM/
	/bApeqBfXugp6TldZf46gVgIhM9Nt3VZGoVHBfVo9M1NbR/ZrcPr7GvGxfSoJYrCHERPhETdU/Z
	PBjPcUKa5v5s02ddLkaQADcU6nZA+wmW6nhAl54WRlyFcd+hqpxbrLg2rlTNzmgqTka+MiJMKDI
	sklYYz2UDve6Y8Kq4odGmFMHQKTpfa/vESQ1zKpVoofmlCGHoUxP6rb9v8ZBhzMPm8wyyIBqj
X-Received: by 2002:a05:600c:4fd5:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-483a9637a61mr168023725e9.26.1771938752378;
        Tue, 24 Feb 2026 05:12:32 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b3d88sm369903185e9.3.2026.02.24.05.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:12:32 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Feb 2026 14:12:30 +0100
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next 3/3] selftests/bpf: add tests for
 kprobe.session optimization
Message-ID: <aZ2jviVuAYEENerC@krava>
References: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
 <20260223215113.924599-4-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223215113.924599-4-andrey.grodzovsky@crowdstrike.com>

On Mon, Feb 23, 2026 at 04:51:13PM -0500, Andrey Grodzovsky wrote:
> Add two new subtests to kprobe_multi_test to validate the
> kprobe.session exact function name optimization:

SNIP

> +static void test_session_errors(void)
> +{
> +	struct kprobe_multi_session_errors *skel = NULL;
> +	struct bpf_link *link_wildcard = NULL;
> +	struct bpf_link *link_exact = NULL;
> +	int err_wildcard, err_exact;
> +
> +	skel = kprobe_multi_session_errors__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "kprobe_multi_session_errors__open_and_load"))
> +		return;
> +
> +	/*
> +	 * Test error code consistency: both wildcard (slow path) and exact name
> +	 * (fast path) should return the same error code (ENOENT) for non-existent
> +	 * functions. This protects against future kernel changes that might alter
> +	 * error return values.
> +	 */
> +
> +	/* Try to attach with non-existent wildcard pattern (slow path) */
> +	link_wildcard = bpf_program__attach(skel->progs.test_nonexistent_wildcard);
> +	err_wildcard = -errno;
> +	ASSERT_ERR_PTR(link_wildcard, "attach_nonexistent_wildcard");
> +	ASSERT_EQ(err_wildcard, -ENOENT, "wildcard_error_enoent");
> +
> +	/* Try to attach with non-existent exact name (fast path) */
> +	link_exact = bpf_program__attach(skel->progs.test_nonexistent_exact);
> +	err_exact = -errno;
> +	ASSERT_ERR_PTR(link_exact, "attach_nonexistent_exact");
> +	ASSERT_EQ(err_exact, -ENOENT, "exact_error_enoent");
> +
> +	/*
> +	 * Verify both paths return identical error codes - this is critical for
> +	 * API consistency and prevents user code from breaking when switching
> +	 * between wildcard patterns and exact function names.
> +	 */
> +	ASSERT_EQ(err_wildcard, err_exact, "error_consistency");
> +
> +	kprobe_multi_session_errors__destroy(skel);

there's already subtest for attach failures (test_attach_api_fails),
so maybe let's put this over there?

SNIP

> diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_syms.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_syms.c
> new file mode 100644
> index 000000000000..6a4bd57af1fc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_syms.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Test kprobe.session with exact function names to verify syms[] optimization */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <stdbool.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int pid = 0;
> +
> +/* Results for each function: incremented on entry and return */
> +__u64 test1_count = 0;
> +
> +/* Track entry vs return */
> +bool test1_return = false;
> +
> +/*
> + * No tests in here, just to trigger 'bpf_fentry_test*'
> + * through tracing test_run
> + */
> +SEC("fentry/bpf_modify_return_test")
> +int BPF_PROG(trigger)
> +{
> +	return 0;
> +}
> +
> +/*
> + * Test 1: Exact function name (no wildcards) - uses fast syms[] path
> + * This should attach via opts.syms array, bypassing kallsyms parsing
> + */
> +SEC("kprobe.session/bpf_fentry_test1")
> +int test_kprobe_syms_1(struct pt_regs *ctx)

perhaps we could execute this as part of test_session_skel_api test?

seems like we could put this directly to progs/kprobe_multi_session.c and
call session_check(ctx) and change test_results validation accordingly

thanks,
jirka


> +{
> +	if (bpf_get_current_pid_tgid() >> 32 != pid)
> +		return 0;
> +
> +	test1_count++;
> +
> +	/* Check if this is return probe */
> +	if (bpf_session_is_return(ctx))
> +		test1_return = true;
> +
> +	return 0;  /* Always execute return probe */
> +}
> -- 
> 2.34.1
> 
