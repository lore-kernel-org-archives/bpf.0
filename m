Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232061;
	b=dax86Q3gf/Gfe+f1S6Gm25gCWLhilXCecXtQfC9EnRDkdluzT0EKyYp6MjLj0ySyD1Tk
	 aVwOdBvopSKVMVzBaJEPzlHEcNNjj1CfN5tmKifv+z2XmgZDShMdpxbsGu147ihgaCQv4
	 7mfKhd9jmBiO8e447CK027Th2nPOJc01VloxoMkDPF8NqSa6j/iHd3/e26Q4s+RTshUbr
	 9AnMAAi/4Znd/+Mp4lt0YKB5ggevw8+TWa+TFAb9amdkTR1M30poN2UJLXqwYq2+Bbd+T
	 irsjOMI+kgkkCWlz/L+jnPhYFkbReX9d+Ff1gNTmf4yl8WMDEnLuiRvexeSMtWeHsfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=MWN3G6USZ/dj8AJfyvahPduuzp3NKOxmGRBSQgdtHV8=;
	b=mPyO7VV741W8El8tG7LhWz3V4m437354A+WqZWwKC3PbuXn2hCG033iewG+3KiRqpKFE
	 c+a3KUftAiFkk+wk+aijiGR1XqT7P7331CncNXA8Hk+dVW6TLlRvA+ZMNmX2qJlnSxzQX
	 sL94cMUDfw6FeHp9N0nb1HnJsdrrqKyA1m+DzZTkOeg5B78HMRsz++aELcY+tXP5zMPSb
	 Qv2+UMWCdYi/EtEZ7wjW16/GDVK+Fpixas9wEDsN7x6WtTE1MkV8GtOIk0WAIiyiGwGwf
	 UUJptul6Bzz3cewHtOIzRIK7qTARsdAkfI6t3gY/aDC13guKsyBG+ejETW4mf+0HAiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Peiv54B7;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83142606D803
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 13:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83142606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Peiv54B7
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso5076465e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 05:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794232060; x=1794836860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MWN3G6USZ/dj8AJfyvahPduuzp3NKOxmGRBSQgdtHV8=;
        b=Peiv54B7LWZaSvhVVKsk2sgJbYgCH3fx02yq75B0DGc++TJzWsY6qK5P4onJUBghmY
         ZSo0bd0tgXOSlYPA2gPVWmro8dNgSu/kdnyUWocvFJcw6LzHHsHxSBuD6T4yC60r32yu
         9mFruvo7VcL+MXHVdFSF3Pc66y5VY9KDmb9znGGg49KrQkQ2F1/Qj/z1VSyVwbjEk5s0
         U6No4OgSOXvRe14kWi+GMnNouI0jE2BC5nluhaNfXsiWkT3xFtGLRbdGMVBR0qOzOpe5
         TxTH2XhyPbIJdtnRMErWNGm6u/Nss/hpgGwp62/VHuBLQNqAWCbQqbBxk22xirSddYaF
         3HGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232060; x=1794836860;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MWN3G6USZ/dj8AJfyvahPduuzp3NKOxmGRBSQgdtHV8=;
        b=Ij2O0+Sa1MDLM9MO043ijI4xnMoQE8KP6U1RGtoN/uBx0CVA2j/cI9kiy+cBRBP2IM
         XJqBSEckM7UoUDIjTfZc5Nw6WH4BvpCMtt3lQBei708bvYtI+oAr1DliJdxYAyndjjpV
         9xXRqOZyu/J4V6sWhjNp4UN01k7+v7kBFQyygCHMwzDc5jxnC+PCmwrcmPl6WVsGWvnv
         Duha9mQUgGii0xDSMBPSLngnbOykK5fSiNt9zpUuglfkG4e5JKjeD/997DUFtVFMOrwg
         bKCcAFfZ6BJv96nIkMnlRFPYwvqaBKv1g7GhX/4O4aR4PxRi1qIYPFN3I83swGcfCOzP
         ULCw==
X-Forwarded-Encrypted: i=1; AL+hErHsISwTGCgmUkdryZczmt9C8w7ytZY7vgce9DtU5WiSBdEpDQeV3SzYHcaQz5RvCFxecmI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VMFKZafhHGzhBLMbtNZ6/r/sW9APSNCROH72JIrTiiUdsrO2S
	KR6RSmKk6mP3WF83Mve5JqZACNyGAcVUP9Bjxkrs9x9bsQs1Y8XbDyHC
X-Gm-Gg: AYBFou1S8gih4td7qTmrl/IbPQ/8mqG09uJDF5WLR3DZc8H9xbFUmv7lMbbUWn1PqxL
	eo+iT9GL7s6T0SfNVFXXDGEuQKnGtWC1nLZzLGyUzYi0G58LzUHMVrbZiXsHQKxec62i+MEvCG2
	6wacD74nQIZM7GwHX8qlyjDwz6TroOFSF8bf+mZuaYV910uwla50Y6bIHdNFI/HznbMlxVd1ZZ+
	j/NYfAtuhTij5SUJVMcD2H36ZeeeZOGnabA4JpgFxqPR169NgJsRk6iR869NDkAtuRXVvZXHDxa
	sWognkA4Itej4mpuQ0d4LJ21g5USe409uAJXeLb+rvISpkIOxwuYXCfi44I03hgnHYThbQCRcIq
	BldyXEKiDC+jsZs0XAGXP1xUGipjNHmdADdj5saJAXQ/cLJ8j5bTLwoMmGfp4LfZh4wS4RXJwbd
	4ZDj2VtWaATIRyQAFR/4S33Kl7lAzXW6nc1OFf16DxGBQzFt2XFjzER9AT9mSNqN+3E1EFq5+g0
	H5T0YuqjQlMVZYr1No81RvnNmHS8GMFek7EL33mzBwGx8APJtsJIfAtIjQEBrJz6OzUrNw1sNG3
	e3kyV387CArzH1uMkttwqoHxN+qFHDLPvQ+5
X-Received: by 2002:a05:600c:4f0e:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4b963c6e154mr77001645e9.16.1794232059808;
        Mon, 09 Nov 2026 05:47:39 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm10425052f8f.47.2026.11.09.05.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:47:38 -0800 (PST)
Date: Mon, 9 Nov 2026 13:59:12 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, almagui@kernel.org,
	john.fastabend@gmail.com, qmo@kernel.org, brauner@kernel.org,
	kpsingh@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, sashal@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v1 bpf-next 16/18] selftests/bpf: Test fmod_ret
 candidates found by bpf_scan_ir
Message-ID: <avHRsGTClKW57FAt@mail.gmail.com>
References: <20261106210314.1767267-16-a.s.protopopov@gmail.com>
 <8b7031053a1e8023c64c8c33203f67f4215142ba84cdbab9d77c89050766c106@mail.kernel.org>
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
In-Reply-To: <8b7031053a1e8023c64c8c33203f67f4215142ba84cdbab9d77c89050766c106@mail.kernel.org>

On 26/11/06 09:50PM, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Test fmod_ret candidates found by bpf_scan_ir
> 
> TL;DR: Nits only in the selftests: a fmod_ret test program's name may
> misdescribe its target, and some includes in bpf_testmod_retval.c may be
> unused.
> 
> > diff --git a/tools/testing/selftests/bpf/progs/fmodret_retval.c b/tools/testing/selftests/bpf/progs/fmodret_retval.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/fmodret_retval.c
> 
> [ ... ]
> 
> > +/* Declared targets and the static rules are not restricted */
> > +SEC("fmod_ret/bpf_testmod_retval_declared")
> > +__success
> > +int BPF_PROG(declared_any, int ret)
> > +{
> > +	return -1;
> > +}
> > +
> > +SEC("fmod_ret/bpf_modify_return_test")
> > +__success
> > +int BPF_PROG(static_rule_any, int a, int *b, int ret)
> > +{
> > +	return -1;
> > +}
> 
> This isn't a bug, but bpf_modify_return_test() is in the
> bpf_test_modify_return_ids BTF_FMODRET set, so it looks like a declared
> target rather than one allowed by check_attach_modify_return().
> 
> Would a name like declared_vmlinux_any fit better, or was this meant to
> attach to something the static rules allow?

Yep, thanks. They have different nature: one is from vmlinux, one is from
module. Will rename correspondingly.

> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
> 
> [ ... ]
> 
> > +#include <linux/atomic.h>
> > +#include <linux/btf.h>
> > +#include <linux/btf_ids.h>
> > +#include <linux/compiler.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/error-injection.h>
> > +#include <linux/mutex.h>
> > +#include <linux/rcupdate.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/types.h>
> 
> This isn't a bug, but are linux/mutex.h, linux/rcupdate.h and linux/btf.h
> still needed here, or are they left over from earlier fixtures?
> 
> [ ... ]

Thanks, indeed, will remove.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42294987431

