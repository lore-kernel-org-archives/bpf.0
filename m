Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39772E63C
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838348; cv=none; b=Nx6Kt1jHi7ubkgi1cQwqnJeaByNuniDrtVU4m4svo59mqAqiphBFmWRrXR9LnzMaXJqGKXAN3or+96Q6e8HMQiXKct4VBYCBZ/flp9KRHKhG73Tkxdfo35Jp1qhlWkY1/aXhi5rhBiZYWnH7gbgJhILYG+kRsUVBqVRpgDXjSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838348; c=relaxed/simple;
	bh=9dvgB9J0rLg+HbrTwxBNX7mN1Kl2kNEpYBlbeeAR8qw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIvvCZyCXvQ7nn8bFniSCa6cjAoDySDv67iosukJuQy9k3sBK8oP5CWUs2+DftsLodnQ+torJhjGhU//x05/Nx2mTR+UlycG/REw5YBQLUnCCViTjLcmNgz//oll3eCX7v9hDSeGAUafByr7n+2PeMUxRwOtZt4j51Njqq6vwZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Slt04GEl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Slt04GEl"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483770e0b25so37776275e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 01:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771838345; x=1772443145; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z77OfwRz7L2ppSTA+3+G5CLp/Px17xfkNuJwxcwjhds=;
        b=Slt04GElYIeNArSVGP/PMqiYoXPX4hZBmHt9zISc411xxdNdQhBB0ZJmcnS0GvddXX
         tBa4jGCkuQsFCDB2Ezkt/7t0PmeOq3JVUJzBJFQX6YYoKDwWrrsjD38yepUJh8JDG+42
         s+qCBuk/PYj3a3cQCC28EnGGPVfL8aMcjJHdM2fx22O1yoDTao/4kw9dOs0ddMA0doAn
         UuYgJcjFE0z4cFwZ1r4K+1EaLA0X/WbB33BnmG+udlrBAfAr3T5ZbhpUyfixefqO8unW
         A54/l4ZIR8E8Sae6vqcbB9/pGKqctW06e8Hak/dewRmQPBHZKNxTD9KI9esKPB+aGVx5
         KVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771838345; x=1772443145;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z77OfwRz7L2ppSTA+3+G5CLp/Px17xfkNuJwxcwjhds=;
        b=ruqZ/K8pBfvENf+yBw4dUzLlsvY2tYdUnB8RWbjfuljZ6Rtv4NSe2wb5+vkuUgnhZb
         lnhqucjZwvy1D/r4AmoTO8LSLKEJhFCqbXagx8Qx6N3arLYOuHQKnF576L4jA2xXitlO
         VSwrzUQ6cWgs5b6wxIyv5sX4d6b0wgQZz1LOevgaJWISPFgKRoVu//mzjfbf9DFVZ2iq
         OqfRKsxv5HpBFnZDrnc2Ssq5UASo7h91zRxXiy2U39uRKW2hapUNI8WIvztHd9cuH/Fj
         qNB/1vp19n+dT5jov+xBWiHEMwsCkacrwaJdpvUkO0/iKeaSbBeh7lC6Zbsb7NepeP1h
         lOBg==
X-Gm-Message-State: AOJu0Yxm3izdeNv1WEK+341DMpwZ+Yk5TAvFc2DzHHwAO0GMQwswO9e6
	j0hv//Cw8tEstHE76QZbNQjieK0V+RftPE0EBiilVafYyXQpC0ZxPypF
X-Gm-Gg: AZuq6aJk9IgAQSz3Sx3mjscS+JBlU0njKpOtb7/+O4Jj5CNsKGT/Uh2SlRpdu4HJHgf
	NUTGil6X3mjkO1dPcoaAO02funyeT/fR9XJWr4Yn1dEECfdlvVEUeyF6AtL3ZAqw+kF09CtZiOI
	6n28NbJgNlmLMsMsc6kdWpHkujYaDbqBsnDT7K7+NGKHJqWeSEez6TP3LVhnIY2d2PgJ/zElyg6
	Hr6oUi84hTEKFlOG5ZPY79NuZzQhC0Y8B+DLb/4ZG60WQEpv1B3xRb3+cMLTBoeBwJXr7UoOClx
	HAy1hxPBEUWKcIB2kRFnRjKtWkaJtK0F2XVIz2lnTkblFZ6BR67GLrxPx06sAGt4YJJ6+7VfI4i
	rnD7LdR2x1We3nbqcqMkJp/p0mv3Yjk8WCbenK5zvPGGxvoSpvfXDJA34CBP+puYrp1K9u2bO
X-Received: by 2002:a05:600c:6217:b0:477:9cdb:e337 with SMTP id 5b1f17b1804b1-483a95eb5f1mr144131745e9.7.1771838344885;
        Mon, 23 Feb 2026 01:19:04 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9b7fddbsm180448335e9.8.2026.02.23.01.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:19:04 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Feb 2026 10:19:02 +0100
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next 2/2] selftests/bpf: Add tests for duplicate
 kprobe symbol handling
Message-ID: <aZwbhsJ1PgL21oXr@krava>
References: <20260218225617.354858-1-andrey.grodzovsky@crowdstrike.com>
 <20260218225617.354858-3-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218225617.354858-3-andrey.grodzovsky@crowdstrike.com>

On Wed, Feb 18, 2026 at 05:56:17PM -0500, Andrey Grodzovsky wrote:

SNIP

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
> new file mode 100644
> index 000000000000..98b3e085ae90
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
> @@ -0,0 +1,45 @@
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
> +noinline int __x64_sys_nanosleep(void)
> +#elif defined(__s390x__)
> +noinline int __s390x_sys_nanosleep(void)
> +#elif defined(__aarch64__)
> +noinline int __arm64_sys_nanosleep(void)
> +#elif defined(__riscv)
> +noinline int __riscv_sys_nanosleep(void)
> +#else
> +noinline int sys_nanosleep(void)
> +#endif
> +{
> +	WARN_ONCE(1, "bpf_testmod_dup_sym: dummy nanosleep symbol called - this should never execute!\n");
> +	return -EINVAL;
> +}

hi,
this fails to build for me:

  CC [M]  bpf_testmod_dup_sym.o
bpf_testmod_dup_sym.c:14:14: error: no previous prototype for ‘__x64_sys_nanosleep’ [-Werror=missing-prototypes]
   14 | noinline int __x64_sys_nanosleep(void)
      |              ^~~~~~~~~~~~~~~~~~~

jirka

> +
> +static int __init bpf_testmod_dup_sym_init(void)
> +{
> +	pr_info("bpf_testmod_dup_sym: loaded (duplicate symbol test module)\n");
> +	return 0;
> +}
> +
> +static void __exit bpf_testmod_dup_sym_exit(void)
> +{
> +	pr_info("bpf_testmod_dup_sym: unloaded\n");
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
