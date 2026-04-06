Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3829E32ED55
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487690; cv=none; b=guVfd8UK/hs9oifis0KXwPvRZdf5SLtRceF2gZx//xwjTpfhoiafg56gqA7ajdqhInVeSYG0v2qQNehM1BZA+5Qyhn6/E7BmDEagBW2kEKyTSxkgyuS6G1HZUfjBwlrSu+nFxN96xz+vSsyFq+Y0FgNk9oSseA2hzqSCSuqfnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487690; c=relaxed/simple;
	bh=fehf5ORA5aaobb41m0mtH+zP0WMX2dIs8+HwS/o/KB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjAjh0YpMd2OnlCeu6BXTsaIU1go2DZ3XS7895/hXCXTzi8JetfPKE+g1qHOCBQufKuJXmY1oK/1FllPVlOCqFRsfyttMIXYze57k7tdJpEKW2Gsu88HbN7FyhTSISt+HcfT4JQk+LLNyXdO6y0LwjtLB07TArGaR25uCDpAIuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kn84/6dq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn84/6dq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ad135063so10114385e9.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775487687; x=1776092487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exL+nF9fbYWHXAdbv4WUOKgsre31Xls/pcijWPRTtJ8=;
        b=Kn84/6dqzaWWLZMzncu62OhFkczYTc14ATHH6eOzKebcNFeylr9+LLC3WdQp7teBKa
         wmtdhAWDPE2NpOXtUcK+zqX3j8zZJjANUKCisM/hus+I9JGXigbEgwyjp5WvTazi7uaS
         JIHVNcrBJ9xNGEy8EsLOGuukjQyPNFmTdl1JQTGUqLSU4hMhPhF+aZ/6CqHW4SeYhgLY
         FcmN6cCgVFdMw0O8qRSZrtopXMpRpl3rRxYxKQVVhX8qhg/pTXOXKRWnjSJNLpzrHl8h
         Ufp1sQbxmpme1dintg4/p1Ez12fsiHR4tcX6dCWn64lCi+umNnyTFO0+s1Vflji/Ojnp
         jKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775487687; x=1776092487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exL+nF9fbYWHXAdbv4WUOKgsre31Xls/pcijWPRTtJ8=;
        b=eESCCTKUxw/Vnrxx1LfyT0HgcNlLm9D8OKrGmNf9ifaAtq+S1xr48aJIS0ej2JTuYS
         QPLOFEcvVoAb+GJQJPrPDwWO9LgP2kM+j2heHSKJrlPficG3HIs/H1H5KZUzKbKAH9aJ
         5ifH/cMHwT3IzPGTJlSwX78sAae378RahyDeE3pKaM/q5xl8QuS3Uj/PaYMOl8cDUH93
         smsDuJ06xbTK1/W66ToNMmm2zgXL4beMxnFDe9t1Cw0GcMHzvisY8mVkiS2zjo/3GAoP
         ibWxLK2wnjnd0UpfiP0evBLU8YSskz7ZifqRxtTTKgfujWrYJtah5llSkKx2mpRMP92k
         0XOg==
X-Forwarded-Encrypted: i=1; AJvYcCX81NBuhsz/gMfAaZk7duAwQ+TPg4IpIcpyPdWQ+QBpA5v17DdXcNJ5dkS0AJUerMH7y2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97eKnEtqKNk1AFkhCj2P0lYMWczr7xAmstZJg7tc3F09PAETA
	WNxjlLNwJ9P4BR9Dkza9imtV6kchzSGoyhOfvgrLiW0jaZhszu41fLY/
X-Gm-Gg: AeBDiesppkMv9eo9uDQAmeCElvofmzkmTIpxnByDMrWWf6xr46WTQwrvXrzpcKEvYVg
	T5J2R6X+H1WlqXmz5+s+gaeCy14xwUK7vbu056Q+pu9w9mBkoVcmub6aVzhIf+dxVE+RbDUUXRJ
	jMoa9t2rA35gUx3auSmuvw8s0SxzLbJY1S0zxHhlCHSegVOEgrMSxRlG7uoIETZjnLeqfAOHzmB
	LkKnUn0hBCXNmuHITeosls5KspY+1/edmPZEqAzpm7rfexDqdR3ONYaUDXlUcXLgRFukRDuotes
	oa0Bn+ilVulvPCb/MuFTy7YNaxRyd49UYZhPHyINlx47ITZX7f076hLrEzcCC8vRwYn9m3qia5d
	C6uIjhDOu76qmpaWGD+2t9jtEdS/1EjD/iLsfHTpGYoYikydnc9vudQO6iUPMqjathFEXNAp8BL
	S5DOvxyjhV3ue5asVBirK2ioor0Fi9rjnffT9S252GL5ge3HaQafk0zsvLymZFwD6ldtsM4PmqB
	HeSOGHjs+qn2dz4YAaNmsbbM8dNfoR3PHnX9X90NNPuS/acf0MJ6ZyW+G07mXxHMIPcDlQT7J0t
	bOIkH7Oql2b/LFTWnPKQktPyOP2EeGs=
X-Received: by 2002:a05:600c:3549:b0:471:700:f281 with SMTP id 5b1f17b1804b1-488997d5e5bmr177660785e9.25.1775487687129;
        Mon, 06 Apr 2026 08:01:27 -0700 (PDT)
Received: from Tunnel (2a01cb09e026ada2c97bbbb55b3a4739.ipv6.abo.wanadoo.fr. [2a01:cb09:e026:ada2:c97b:bbb5:5b3a:4739])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e9630ddsm485090475e9.13.2026.04.06.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 08:01:25 -0700 (PDT)
Date: Mon, 6 Apr 2026 17:01:22 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH bpf v3 1/2] bpf: reject negative CO-RE accessor indices
 in bpf_core_parse_spec()
Message-ID: <adPKwo1SdNe0xJ0t@Tunnel>
References: <20260404161221.961828-1-bestswngs@gmail.com>
 <20260404161221.961828-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404161221.961828-2-bestswngs@gmail.com>

On Sun, Apr 05, 2026 at 12:12:20AM +0800, Weiming Shi wrote:
> CO-RE accessor strings are colon-separated indices that describe a path
> from a root BTF type to a target field, e.g. "0:1:2" walks through
> nested struct members. bpf_core_parse_spec() parses each component with
> sscanf("%d"), so negative values like -1 are silently accepted.  The
> subsequent bounds checks (access_idx >= btf_vlen(t)) only guard the
> upper bound and always pass for negative values because C integer
> promotion converts the __u16 btf_vlen result to int, making the
> comparison (int)(-1) >= (int)(N) false for any positive N.
> 
> When -1 reaches btf_member_bit_offset() it gets cast to u32 0xffffffff,
> producing an out-of-bounds read far past the members array.  A crafted
> BPF program with a negative CO-RE accessor on any struct that exists in
> vmlinux BTF (e.g. task_struct) crashes the kernel deterministically
> during BPF_PROG_LOAD on any system with CONFIG_DEBUG_INFO_BTF=y
> (default on major distributions).  The bug is reachable with CAP_BPF:
> 
>  BUG: unable to handle page fault for address: ffffed11818b6626
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>  CPU: 0 UID: 0 PID: 85 Comm: poc Not tainted 7.0.0-rc6 #18 PREEMPT(full)
>  RIP: 0010:bpf_core_parse_spec (tools/lib/bpf/relo_core.c:354)
>  RAX: 00000000ffffffff
>  Call Trace:
>   <TASK>
>   bpf_core_calc_relo_insn (tools/lib/bpf/relo_core.c:1321)
>   bpf_core_apply (kernel/bpf/btf.c:9507)
>   check_core_relo (kernel/bpf/verifier.c:19475)
>   bpf_check (kernel/bpf/verifier.c:26031)
>   bpf_prog_load (kernel/bpf/syscall.c:3089)
>   __sys_bpf (kernel/bpf/syscall.c:6228)
>   </TASK>
> 
> CO-RE accessor indices are inherently non-negative (struct member index,
> array element index, or enumerator index), so reject them immediately
> after parsing.
> 
> Fixes: ddc7c3042614 ("libbpf: implement BPF CO-RE offset relocation algorithm")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

> ---
> v3: added selftest 
> v2: fix typo Signed-off-by tag (missing leading 'S')
> 
>  tools/lib/bpf/relo_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 6eea5edba58a..0ccc8f548cba 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -292,6 +292,8 @@ int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
>  			++spec_str;
>  		if (sscanf(spec_str, "%d%n", &access_idx, &parsed_len) != 1)
>  			return -EINVAL;
> +		if (access_idx < 0)
> +			return -EINVAL;
>  		if (spec->raw_len == BPF_CORE_SPEC_MAX_LEN)
>  			return -E2BIG;
>  		spec_str += parsed_len;
> -- 
> 2.43.0
> 
> 
