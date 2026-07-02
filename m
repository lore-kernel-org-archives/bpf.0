Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEC0431E53
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962249; cv=none; b=DcAp0oqwEdatSrHRclyR1hOIFUQzPsv/DHLSOzOPJ568sAZrwt5IgyI9ORFufchSe6+P2KIyCpKDAhpxiZmZWsORDesiEdVx+ap2tuAZx6NW3iJnm8SzKUBPacVaW+RHX6Qx4O9DG67JQfEoaNOFbP98BpeeeaDjqOby4DTu6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962249; c=relaxed/simple;
	bh=7tHwDppsCdqtyqxvAVoJuKHL4Tf5QnyH6AdPQqUOMcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tW7mhGdIRoI0NgjevWiY00S+ep/N+VodoGfzpc5SZQjvEAzaq8HM6v9gfZGM7gBWSsIl1zTcIc/UigNuswZRMVP6CMZxsUa+wO7+pOhWvx9PT8hIl6H39DU18gvcO8Ob51jf3ZSTPt98w+4tC5MkZFRQ8ODotzj1n791ui4qn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ThbLoYK7; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ThbLoYK7"
Message-ID: <3fe115fd-8df8-4bf0-805b-2d0c2c40fdf5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782962236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpRNLle6+4yZkierBTC2/qWgn38I+N4gkbA1peSKMc0=;
	b=ThbLoYK76ulkLhRZKA5Ab5Io+WsmGdRgEzYOJm9CNkFKGZq/W5rpG+pADH8AKYJbROUIhr
	M/cnjxSJiyp7KxupX1t5/QKB2kmim2jhU3Q6u/nDEfy4h8NBy/VDVIJTyk5tGDfQX7Q8vs
	+i11uSidFCPbFb+XGdpUk/NVVKXQ2Pg=
Date: Thu, 2 Jul 2026 11:17:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5] bpf: Reject programs with inlined helpers if
 JIT is unavailable
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, KaFai Wan <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev
References: <20260702022108.17693-1-yangtiezhu@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260702022108.17693-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/7/26 10:21, Tiezhu Yang wrote:
[...]
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ba09795e0bfd..463fae6a5c33 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1865,8 +1865,9 @@ struct bpf_prog_aux {
>  
>  struct bpf_prog {
>  	u16			pages;		/* Number of allocated pages */
> -	u16			jited:1,	/* Is our filter JIT'ed? */
> +	u32			jited:1,	/* Is our filter JIT'ed? */
>  				jit_requested:1,/* archs need to JIT the prog */
> +				jit_required:1, /* program strictly requires JIT compiler */

Looks good to put jit_required together with jit_requested.

However, 'u16 -> u32' changes the layout of struct bpf_prog.

Before the change, pahole -C bpf_prog ./vmlinux

struct bpf_prog {
	u16                        pages;                /*     0     2 */
	u16                        jited:1;              /*     2: 0  2 */
	u16                        jit_requested:1;      /*     2: 1  2 */
	u16                        gpl_compatible:1;     /*     2: 2  2 */
	u16                        cb_access:1;          /*     2: 3  2 */
	u16                        dst_needed:1;         /*     2: 4  2 */
	u16                        blinding_requested:1; /*     2: 5  2 */
	u16                        blinded:1;            /*     2: 6  2 */
	u16                        is_func:1;            /*     2: 7  2 */
	u16                        kprobe_override:1;    /*     2: 8  2 */
	u16                        has_callchain_buf:1;  /*     2: 9  2 */
	u16                        enforce_expected_attach_type:1; /*     2:10
2 */
	u16                        call_get_stack:1;     /*     2:11  2 */
	u16                        call_get_func_ip:1;   /*     2:12  2 */
	u16                        call_session_cookie:1; /*     2:13  2 */
	u16                        tstamp_type_access:1; /*     2:14  2 */
	u16                        sleepable:1;          /*     2:15  2 */
	enum bpf_prog_type         type;                 /*     4     4 */
	enum bpf_attach_type       expected_attach_type; /*     8     4 */
	u32                        len;                  /*    12     4 */
	u32                        jited_len;            /*    16     4 */
	union {
		u8                 digest[32];           /*    20    32 */
		u8                 tag[8];               /*    20     8 */
	};                                               /*    20    32 */

	/* XXX 4 bytes hole, try to pack */

	struct bpf_prog_stats *    stats;                /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u8 *                       active;               /*    64     8 */
	unsigned int               (*bpf_func)(const void  *, const struct
bpf_insn  *); /*    72     8 */
	struct bpf_prog_aux *      aux;                  /*    80     8 */
	struct sock_fprog_kern *   orig_prog;            /*    88     8 */
	union {
		struct {
			struct {
			} __empty_insns;                 /*    96     0 */
			struct sock_filter insns[0];     /*    96     0 */
		};                                       /*    96     0 */
		struct {
			struct {
			} __empty_insnsi;                /*    96     0 */
			struct bpf_insn insnsi[0];       /*    96     0 */
		};                                       /*    96     0 */
	};                                               /*    96     0 */

	/* size: 96, cachelines: 2, members: 28 */
	/* sum members: 90, holes: 1, sum holes: 4 */
	/* sum bitfield members: 16 bits (2 bytes) */
	/* last cacheline: 32 bytes */
};


After the change, pahole -C bpf_prog ./vmlinux

struct bpf_prog {
	u16                        pages;                /*     0     2 */

	/* Bitfield combined with previous fields */

	u32                        jited:1;              /*     0:16  4 */
	u32                        jit_requested:1;      /*     0:17  4 */
	u32                        jit_required:1;       /*     0:18  4 */
	u32                        gpl_compatible:1;     /*     0:19  4 */
	u32                        cb_access:1;          /*     0:20  4 */
	u32                        dst_needed:1;         /*     0:21  4 */
	u32                        blinding_requested:1; /*     0:22  4 */
	u32                        blinded:1;            /*     0:23  4 */
	u32                        is_func:1;            /*     0:24  4 */
	u32                        kprobe_override:1;    /*     0:25  4 */
	u32                        has_callchain_buf:1;  /*     0:26  4 */
	u32                        enforce_expected_attach_type:1; /*     0:27
4 */
	u32                        call_get_stack:1;     /*     0:28  4 */
	u32                        call_get_func_ip:1;   /*     0:29  4 */
	u32                        call_session_cookie:1; /*     0:30  4 */
	u32                        tstamp_type_access:1; /*     0:31  4 */
	u32                        sleepable:1;          /*     4: 0  4 */

	/* XXX 31 bits hole, try to pack */

	enum bpf_prog_type         type;                 /*     8     4 */
	enum bpf_attach_type       expected_attach_type; /*    12     4 */
	u32                        len;                  /*    16     4 */
	u32                        jited_len;            /*    20     4 */
	union {
		u8                 digest[32];           /*    24    32 */
		u8                 tag[8];               /*    24     8 */
	};                                               /*    24    32 */
	struct bpf_prog_stats *    stats;                /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u8 *                       active;               /*    64     8 */
	unsigned int               (*bpf_func)(const void  *, const struct
bpf_insn  *); /*    72     8 */
	struct bpf_prog_aux *      aux;                  /*    80     8 */
	struct sock_fprog_kern *   orig_prog;            /*    88     8 */
	union {
		struct {
			struct {
			} __empty_insns;                 /*    96     0 */
			struct sock_filter insns[0];     /*    96     0 */
		};                                       /*    96     0 */
		struct {
			struct {
			} __empty_insnsi;                /*    96     0 */
			struct bpf_insn insnsi[0];       /*    96     0 */
		};                                       /*    96     0 */
	};                                               /*    96     0 */

	/* size: 96, cachelines: 2, members: 29 */
	/* sum members: 90 */
	/* sum bitfield members: 17 bits, bit holes: 1, sum bit holes: 31 bits */
	/* last cacheline: 32 bytes */
};


Luckily, the total size keeps 96 bytes. The layout change is the hole:
from 4 bytes to 31 bits.

Thanks,
Leon

>  				gpl_compatible:1, /* Is filter GPL compatible? */
>  				cb_access:1,	/* Is control block accessed? */
>  				dst_needed:1,	/* Do we need dst entry? */
> [...]
