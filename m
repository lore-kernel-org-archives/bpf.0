Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826725;
	b=PkHFRT43MaH+vkVdITNr4NH4lIXewCYH2n4CUYt08dvy1Ijx1vGWoNWmoL6D6jcHuBlo
	 q6rrRhg1//VlTeQuGvsjy5IQL5mS9BnfOJSMnY7bip4VyEdfoDk6V/vAlLb51TJQBTGm3
	 gAe5S24yslH/V3o2BfBBaxD4lO3MXrUDE8D2ufEStv1Ef+wzno8Spmx3CJKBRf4y2mhhH
	 fKh4pC5k5+CDlAPvhw/6SjUKhpjeOPTzXAHo9I8N1FbosVGzoTm+RjdesirJ42ExcW1JY
	 V73CTnP+F26fma9sWKZRRHDAr7hLRboYxECQ1PcXVGA6tbeI3MFRj+lXPE6MAULz3GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=d290Y88I8EA7fRNVJZziFi6nFU4gyKqFXCYOMey3i64=;
	b=P+sBDWKjmCy02N3AHdA0t+pCpyXy3/p2oE8KDLfkc/FLndsCpoVXIWmVP/W8SqTzEqw7
	 APDaBnSyBPdp1mH2JqWjTG4RQXBei0PiH4/cHKkL8bu6uu5WTea8TkS9qBs5NgM3+3SVk
	 QlbyMotW3KeoIp1yTJ/13rrCpjoIwgl8c2c/v+k+c/74If/fML68j4L8hlwjFRzXXpgLx
	 wgmT8yikNliWGKwoIhmjQsGfkLhn4/jca0iJ0N2VK4lva1yiTlnQHiZeey1CFH2ZZFHXT
	 sdQvVtMKItKEwS/XuOhQNecGtDPOdYEt+9RVBZIGohH7KdhvcptEPLCeJHjwIs3n/jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FjvYHOEo;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A5A606D81F
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2A5A606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FjvYHOEo
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso237917f8f.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826723; x=1794431523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d290Y88I8EA7fRNVJZziFi6nFU4gyKqFXCYOMey3i64=;
        b=FjvYHOEonCEXOa4G5IS/DIryiNo0DG/deML6kx/7xmXYEOIWxCD2pLoo9N3LrNK1kl
         hLCFm4kNEnt75q0o23tolol38YrqbvOTwF6HWeqFAsPsXOE/Q5KO41J3Cio4yd3d1SGD
         hVJz0YNRZim4fxmp1ueQbzxmbryZ2vOKrP9yLAyUe01B1fdRw5VhdU7QnUu9tTy1Kan0
         4WnMFfxZImmb9LWShvv/grOSw3BwAi0KSuJKIXro9fc8u+zLDpJaUvHOOsaVext2/zVk
         daRyQjDXJlSsZZS+pIpaTCxTqvCHGg5S2qUK4eeNKk9C+a7lDGqY15oMs8hn5tqN8jVc
         xA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826723; x=1794431523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d290Y88I8EA7fRNVJZziFi6nFU4gyKqFXCYOMey3i64=;
        b=rGuxbpFwSJQSxkwL6iFnKcwd5YoRMpWA6ArcXyPo39Z4q2D8WSN6O0ErEzGe+1N/sF
         drtDu1Bmmncquq05BLev6VdMWYqUcX6Xdek+NIvBV/WL84iwVamcGiYtL0zTCdGhMCDn
         rPmr8MiwZndV+bWGye+sDu6vvxU87PL4tIdUWxQoSP3oGq6Ct1khqiH3sD1h1R7qc9gq
         jvZMspWNYgAlBSGl6VMxycXtLdF8GmN81U79TJo5sIanGdnk8X7psNg2s6m9ru8IXtdi
         i6+Ujmr2gjFZKvaC0dVvDFIjfZSjluDCcyympEsql7c9BAYGaID8V27V2v4UoN1orb06
         T0qg==
X-Forwarded-Encrypted: i=1; AKwUvBwkqnL6N35+daJDELUpaNjRH5CAzyW5dsMbc+ZaanbBJj1FAKadbIylrx0zoFOF9CAHtd0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+4ZIpOFI9UjzV32tsQ4EWG+fYdDhJR/+Yht4tq/bVWslmgrMm
	eVVJLHyUfzu6joshdh5XkeL58+Q7pguVbEj78+0glIzg7sHTCF6eFoQ8
X-Gm-Gg: AYBFou3OMGyubeDYhUO20R5a9msmzAw7lTnLII/3p/1L6qrMNZx0xwanV+ZVOp45fla
	2S79MxUzJm+CvhxAci4puV0Y9kHTlneHnEfgk1HpxbeI6JDkg3D34Z9bUrQcLt3ddq5vacMN24k
	iqNCX1fmOcgYdsbQJ5O36hjjR80yZzL/JbaV2f3/gANrnO3WmjLFupQnAwvlh27nrhIn4wTDPoc
	HKMBvioIGMehySVXdIXF4GEnFuxBLICOMKsv+8tKOwjDNdSlv5R5BJWhcS8GUtuJZ7NcNd9UUw6
	w9PwkVmhiFPMCRRhpT0H7N5N2wGsj7Be5WSAMaSuMaKwfW+3KYnO2IEW+dWTS44roMzcMpf2OOi
	6X1JVJVjGVe9cefuRnsXh/jIVyS2mLPrNw3wm8k79hNXOsOlLM+2DjCzchswIVVD02KvquWe2u/
	Wh3VrFFAsuOlFW3ad1rWHOBf5KlOlAa3jbFWaSI3LZPiDk47ZyUB4lr3/xGfaoJijVtKcI9O4m6
	V4LeQYZOUw242SN6p3vOpC9buwQpZvzKmCnIt7qM238S/8QbcACZpFH6yJLQMVmQKog6m6bR2ka
	WxRCVXGcVAaBx8s=
X-Received: by 2002:a5d:5f07:0:b0:48c:7caa:12cd with SMTP id ffacd0b85a97d-48e6e4faddbmr37238970f8f.22.1793826723128;
        Wed, 04 Nov 2026 13:12:03 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea180e7csm5907191f8f.5.2026.11.04.13.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:12:02 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Nov 2026 22:12:00 +0100
To: sashiko-reviews@lists.linux.dev
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: Re: [PATCHv2 bpf-next 4/8] selftests/bpf: Test const kfunc memory
 arguments
Message-ID: <auufoF_H3gau-sYx@krava>
References: <20261103075916.100050-1-jolsa@kernel.org>
 <20261103075916.100050-5-jolsa@kernel.org>
 <sashiko-outbox-194803@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-194803@kernel.org>

On Tue, Nov 03, 2026 at 08:10:24AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] selftests/bpf: kfunc_call_test_const_mem() fails verifier load with MEM_WRITE
> --
> 
> commit d0fe747011b126dd39ad19108026e34fdd9f18ce
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> selftests/bpf: Test const kfunc memory arguments
> 
> This commit adds BPF selftests and bpf_testmod kfuncs to test passing
> read-only global data, stack data, and const scalar structs to const-qualified
> kfunc memory arguments, as well as rejecting read-only data for writable
> memory arguments.
> 
> > diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> > index 8e6560c31e781..4f4a6713aa6e5 100644
> > --- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> > +++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> > @@ -5,6 +5,9 @@
> >  #include "bpf_misc.h"
> >  #include "../test_kmods/bpf_testmod_kfunc.h"
> >  
> > +static const char kfunc_const_data[] = "read-only source";
> > +static const struct prog_test_pass1 kfunc_const_struct = { .x0 = 1 };
> > +
> >  static struct bpf_spin_lock kfunc_call_lock SEC(".data.A");
> >  
> >  SEC("tc")
> > @@ -208,6 +211,17 @@ int kfunc_call_test_pass(struct __sk_buff *skb)
> >  	return 0;
> >  }
> >  
> > +SEC("tc")
> > +int kfunc_call_test_const_mem(struct __sk_buff *skb)
> > +{
> > +	char stack_data[] = "read-write";
> > +
> > +	bpf_kfunc_call_test_const_mem(kfunc_const_data, sizeof(kfunc_const_data));
> > +	bpf_kfunc_call_test_const_mem(stack_data, sizeof(stack_data));
> > +	bpf_kfunc_call_test_const_struct(&kfunc_const_struct);
> > +	return 0;
> > +}
> 
> [Severity: Medium]
> Does kfunc_call_test_const_mem() pass the verifier without a corresponding
> verifier change to preserve const qualifiers on kfunc memory arguments?
> 
> In kernel/bpf/verifier.c, get_kfunc_arg_type() strips all type modifiers
> including BTF_KIND_CONST from the pointed-to type via
> btf_type_skip_modifiers(), advances ref_id_ptr past them, and unconditionally
> sets MEM_WRITE on sized memory arguments:
> 

the verifier change gets the access flag separately from the original 
BTF parameter in args[arg]

> kernel/bpf/verifier.c:get_kfunc_arg_type() {
> 	...
> 	ref_id_ptr = &t->type;
> 	ref_t = btf_type_skip_modifiers(meta->btf, *ref_id_ptr, &ref_id);
> 	while (*ref_id_ptr != ref_id)
> 		ref_id_ptr = &btf_type_by_id(meta->btf, *ref_id_ptr)->type;
> 	...
> 	} else if (arg + 1 < nargs &&
> 		 (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
> 		  is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1]))) {
> 		...
> 		arg_type = ARG_PTR_TO_MEM | MEM_WRITE;
> 	}
> 	...
> 	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
> 		if (is_kfunc_arg_map(meta->btf, &args[arg]))
> 			proto->arg_btf_id[arg] = reg2btf_ids[CONST_PTR_TO_MAP];
> 		else
> 			proto->arg_btf_id[arg] = ref_id_ptr;
> }
> 
> Similarly, for bpf_kfunc_call_test_const_struct(), when &kfunc_const_struct
> (a PTR_TO_MAP_VALUE in .rodata) is passed, resolve_func_arg_type() converts
> the scalar-struct pointer argument to fixed-size memory with MEM_WRITE set:
> 
> kernel/bpf/verifier.c:resolve_func_arg_type() {
> 	...
> 	if (!btf_type_is_scalar_struct(env, btf, ref_t))
> 		return 0;
> 	...
> 	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
> 		    (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
> }
> 
> When check_func_arg() validates kfunc_const_data and &kfunc_const_struct,
> func_arg_access_type() returns BPF_READ | BPF_WRITE because MEM_WRITE is set,
> causing check_helper_mem_access() -> check_map_access_type() to reject the
> read-only .rodata map with -EACCES ("write into map forbidden").
> 
> Because kfunc_call_test_const_mem is an autoloaded SEC("tc") program in
> kfunc_call_test.c, wouldn't this cause kfunc_call_test__open_and_load() and
> kfunc_call_test_lskel__open_and_load() in verify_success() to fail and break
> the kfunc_call test suite?

the verifier support is added in previous:
  bpf: Honor const on generic kfunc memory arguments

jirka

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261103075916.100050-5-jolsa@kernel.org?part=1
