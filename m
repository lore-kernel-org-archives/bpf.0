Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4D43B637A
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566768; cv=none; b=i7ilR5uul228ENc1fgHGB3eXFvuW+V96oTuacA7pD/KzGnTozEVk2TTyyOEjHrluEo/iPsd1/opOMIdW0djPFgHOJ1Qc9b/5uMLdNyUnyltGt5rL5kn69ZeLMNGjth+tZ9QHKM6l8I/IfPPwLG/Wfuzps9zjQefjsqIhFSazPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566768; c=relaxed/simple;
	bh=ClqFDEJCQMCUYOkyBLnDQcgCM/IUjoTgXeAQm1kT/pU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNTOeznG0uEICK19eWRA1CqQ2M6fvuFj1zqlPsmT/mEaATmBAw8NIvi5MozCJHpLW/nZBwmo3/jEPWW6wuns0Cpfvyc3LQyTGq3f8ot4WibYzIPrlGCy0qDkgnX5WG/Nn4pf54dTMKoS7+HZxcDIRIS+KCqNzDMHyuCqsXybY0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYGwn3qZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYGwn3qZ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso45729325e9.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775566765; x=1776171565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4jBPWe3dTTt2wPLm8plPgxj5fmcSgMWAxKmxL7KXCM=;
        b=BYGwn3qZU+iYZWuVdWPVaEbabgbnQrMHYzDh8hgoOSMuiWkexHvoTnNXraHyY1P5Ka
         bg6POdMGdw8BGQGzpj7JAzsUUGqdjz88R9ryUmsBt8PvblbxyF7x667KAUFrEd/CDD7N
         MGwKjntEBXCgXMsNkiBXdA1LhYtZkobbYpC9ZOmCP55LNm0mz8nwy7i3kekm7kH7B5kq
         jk6h8PAKtDpYozmsvVOA3V2nRFPKA7oGsYzDAJmjCrwiG34/8qFg+Sfck/+cocejw2N4
         0tIvtlCz+U0yLCD9jiLnuPofL09OB2S5u30NS9rU1rYFBV0aIcCLEmaz0ype/DiB4LUI
         HlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775566765; x=1776171565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4jBPWe3dTTt2wPLm8plPgxj5fmcSgMWAxKmxL7KXCM=;
        b=SHzGpCb7MQ7Mn6pfsVwN4ETotIRq4lLOJHbndRzfheHjCr+js8zR6lRI/BMUgUYxiu
         +eVqo5LptDeHk+mTTuG3c4Ynw6qx8+G/lbgMxFWn4WcefU7oDddpmc7kObZVr8szrYyf
         kENPl6128opKtJu0EjHevTSoLDs0deDaO8jsXWGBk5uet+0pn/wbi4n1T6jdKwBLO0b2
         zW24eZhZqXFRas1fiDZfkps4JAN1zVL5CLEUL0LAmydxXcjiWOlc0OLWQ2PQPp9yc2Gw
         np/ZuB1BLYdgMB26NRHloWlO5OUQ90VVAkYAryyVuTdxw2Gqzd1eiiuo+ltRO4comN49
         v45w==
X-Gm-Message-State: AOJu0YxsZK++p+9EpUpiv4CEvARe3oyW8vjyZhM3ybUfOzrZzCFCb3Uc
	f1OjEkXZi6i/IqEt4rCDtJWIWJdgvoXLLTLiZQNhjXd8L4HuAwCW/PNZ
X-Gm-Gg: AeBDieuHBm0Rk1xPsh19879DSq+TcFQ5NiKLDgFVNEeKxdOmIrqpAfzi/Gzyh13JRJp
	l7mNY4XaXYA7xp0W4JDCT5QlQ/FUDQS6rT+VkmQ+QLWjSEmx32TSYs1FhS+CM4zythleSBmnG6f
	KFoFmMqs54HvgPzp6vf9odsTukhefbe1Qu5SGLHTs+JJ0ewMPiV3PrOwCq3BZBRA03UmaJShzvC
	VTIIKjOr7+GGZpIw54TggTD6tdNTSZJv9hoBTren8OvoW7iACb71pHCFWcGcCmJvpwUMvUUoRJy
	Ld0nUzUv0a3k7wxLXyT0q53joGue5KCjmx1Ef9bg23M29/HiKek61bBKeONdP0TQtDsHwjLH/bu
	4uCpwLoboimR5isC2J7Fi3f+PW7wym5742j3raedj2zN1R6tiW9q8x29e87Bbgni0z+BBL/ikK4
	c0GNvX+e0R7e8=
X-Received: by 2002:a05:600c:6986:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-488996ecbf3mr211953095e9.8.1775566765013;
        Tue, 07 Apr 2026 05:59:25 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a3d6944bsm280381005e9.11.2026.04.07.05.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:59:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 7 Apr 2026 14:59:23 +0200
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, ihor.solodrai@linux.dev, emil@etsalapatis.com,
	linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next v5 2/2] selftests/bpf: Add tests for
 duplicate kprobe symbol handling
Message-ID: <adT_q0MzIOOj9yL3@krava>
References: <20260406193158.754498-1-andrey.grodzovsky@crowdstrike.com>
 <20260406193158.754498-3-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406193158.754498-3-andrey.grodzovsky@crowdstrike.com>

On Mon, Apr 06, 2026 at 03:31:58PM -0400, Andrey Grodzovsky wrote:

SNIP

> +static void test_attach_probe_dup_sym(enum probe_attach_mode attach_mode)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
> +	struct bpf_link *kprobe_link, *kretprobe_link;
> +	struct test_attach_probe_manual *skel;
> +	int err;
> +
> +	/* Load module with duplicate symbol */
> +	err = load_module("bpf_testmod_dup_sym.ko", false);
> +	if (!ASSERT_OK(err, "load_bpf_testmod_dup_sym")) {
> +		test__skip();
> +		return;
> +	}
> +
> +	skel = test_attach_probe_manual__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_dup_sym_open_and_load"))
> +		goto unload_module;
> +
> +	/* manual-attach kprobe/kretprobe with duplicate symbol present */
> +	kprobe_opts.attach_mode = attach_mode;
> +	kprobe_opts.retprobe = false;
> +	kprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
> +						      SYS_NANOSLEEP_KPROBE_NAME,
> +						      &kprobe_opts);
> +	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_dup_sym"))
> +		goto cleanup;
> +	skel->links.handle_kprobe = kprobe_link;
> +
> +	kprobe_opts.retprobe = true;
> +	kretprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
> +							 SYS_NANOSLEEP_KPROBE_NAME,
> +							 &kprobe_opts);

maybe add tests for attaching the shadow module function as well?

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
> new file mode 100644
> index 000000000000..0e12f68afe3a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 CrowdStrike */
> +/* Test module for duplicate kprobe symbol handling */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +
> +/* Duplicate symbol to test kprobe attachment with duplicate symbols.
> + * This creates a duplicate of the syscall wrapper used in attach_probe tests.
> + * The libbpf fix should handle this by preferring the vmlinux symbol.
> + * This function should NEVER be called - kprobes should attach to vmlinux version.
> + */
> +#ifdef __x86_64__
> +int __x64_sys_nanosleep(void);
> +noinline int __x64_sys_nanosleep(void)
> +#elif defined(__s390x__)
> +int __s390x_sys_nanosleep(void);
> +noinline int __s390x_sys_nanosleep(void)
> +#elif defined(__aarch64__)
> +int __arm64_sys_nanosleep(void);
> +noinline int __arm64_sys_nanosleep(void)
> +#elif defined(__riscv)
> +int __riscv_sys_nanosleep(void);
> +noinline int __riscv_sys_nanosleep(void)
> +#else
> +int sys_nanosleep(void);
> +noinline int sys_nanosleep(void)
> +#endif

could we use module_fentry_shadow instead? it's in kernel and in bpf_testmod
for fentry shadowing test.. it's not executed via test_run but it could be
added or we just don't run it

jirka

> +{
> +	WARN_ONCE(1, "bpf_testmod_dup_sym: dummy nanosleep symbol called - this should never execute!\n");
> +	return -EINVAL;
> +}
> +
> +static int __init bpf_testmod_dup_sym_init(void)
> +{
> +	return 0;
> +}
> +
> +static void __exit bpf_testmod_dup_sym_exit(void)
> +{
> +}
> +
> +module_init(bpf_testmod_dup_sym_init);
> +module_exit(bpf_testmod_dup_sym_exit);
> +
> +MODULE_AUTHOR("Andrey Grodzovsky");
> +MODULE_DESCRIPTION("BPF selftest duplicate symbol module");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 
