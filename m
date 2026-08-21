Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE141DDFA;
	Fri, 21 Aug 2026 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354700; cv=none; b=aiAciUR64NHn8SG9AoJNjtXmrdAdjEt4QEq6BN5l9iiq5pn2tfcXuIBrKp+IDMcEwaqQRYRK1i5k/ET4HkxG5M/G2hSBaC77iUWoBD7tOen0qppaksPFXQtASbi1k0biHpltgJXTiHepksxwj13rjWKbpBLYWWgRCYBGsLmDTeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354700; c=relaxed/simple;
	bh=HoC8evWdczBg6sd9Z6eu4Pyxj+fsYfodT9Lan2pW/5c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uF0uVGIgMmfpBlIydNpbS0hTBwu+rs/CtWojey6Nzg0Fb1AAgCSkEcus3m7u6bX6Ck19epGhxIPphsY3/SZjxI/w9KAFxjnQRTQiEk0VSDU1dck8HHoRqlr7Sh0QfxJl1g1s6ekb+a9r2tIg538MI+Uh4HeXVUtZXNVW7gyqRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXuGruv6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXuGruv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31B61F00A3D;
	Fri, 21 Aug 2026 23:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787354699;
	bh=2Vde3PZOQK2Cad3GpKkDo48mkPTZOicB3sYdMiQflvs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gXuGruv6xcxtO7B6S5teyQpAaSDNTM8AFpK1Pc12wdTGmPDZ9e8dN0ca5UI3EjQPd
	 C/4QhuNav6Is4NYoQQeXb/naJfgOrOscenSuzr7AYJzHMbzGizpw3G1mEvuw+rRRat
	 6KARS/daYpvN872X32V3YW3xQ8EKuIML0lbdLjhezXrcFE+oMKl0mLXbshovlzWxZp
	 +9AbN/+nEuKn3+Alx5n9JWJGmDVJDLFEd8hXFqcMIrU1AKG1IIfA0plVfriMvHArIv
	 6qjpNLw63pT2NVZvkcLiBZiAjFdR0MPQK5a7m8Ne+YSRu86AakZrT6Dg9j1y90lMwY
	 Jmf7Bb7/9HhFw==
Content-Type: multipart/mixed; boundary="===============4179424211322569270=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b2de3e4da41eccf60d05631644e3975af9a89584e96121f38fa9caac3ec76f2d@mail.kernel.org>
In-Reply-To: <20260822-kasan-v7-4-99afee6ef7fd@bootlin.com>
References: <20260822-kasan-v7-4-99afee6ef7fd@bootlin.com>
Subject: Re: [PATCH bpf-next v7 4/9] bpf, x86: emit KASAN checks in x86 JITed programs
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,tglx@kernel.org,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mingo@redhat.com,andreyknvl@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,laoar.shao@gmail.com
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 23:24:58 +0000 (UTC)

--===============4179424211322569270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 13ba3232993a..8134d028a2f2 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -21,6 +21,17 @@
>  #include <asm/unwind.h>
>  #include <asm/cfi.h>
>
> +#if IS_ENABLED(CONFIG_BPF_JIT_KASAN)
> +void __asan_load1(void *p);
> +void __asan_store1(void *p);
> +void __asan_load2(void *p);
> +void __asan_store2(void *p);
> +void __asan_load4(void *p);
> +void __asan_store4(void *p);
> +void __asan_load8(void *p);
> +void __asan_store8(void *p);
> +#endif
> +

This isn't a bug, but these eight prototypes duplicate declarations from
mm/kasan/kasan.h. Would it be worth exporting them from a shared header
such as include/linux/kasan.h under CONFIG_KASAN_GENERIC so each JIT does
not have to re-declare them? Also, this uses #if IS_ENABLED() while the
matching guard in emit_kasan_check() uses #ifdef CONFIG_BPF_JIT_KASAN.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32534828209
--===============4179424211322569270==--
