Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46CB3CAE71
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694876; cv=none; b=VjOKQ+xjISQpRQfroFOzQ6LIKD97RhBvGKKODAtC6GRqBG4VSDK3Q+QVAfaAmZtsw+scHCAC9e7ahAl1gH05tyjxe8kdr/FyJHYrkIg+X/MylhbComIzC2ia3iMibb4AzNYSedGwi32pMKxP8dghS0KQV6WYgh4apw8JXiU5crw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694876; c=relaxed/simple;
	bh=3LSYplLreYqdrEEacxHpD4l3Wy6uwORxMyV8UTwIIoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0qmSVaPxwAFQYuaIus5cLsdDwdG7vQSK/dNGqF8AtjjAoV5tm/uEqR6x4in37zp/neT628xl1VBA0K5+Q5oPrBaGvpC6lPhDqOYSNdxQId56C9yESh6RjcfMxMO6nU7A5Y6mE3Q2KtHDcNPK4GXFv6OaC8sfgKgYydnOo3YIQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AD1Z0Gqw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD1Z0Gqw"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso8954365e9.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776694873; x=1777299673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEXxlv8BImKZUhebuilBAJ2jXt3hQ6Gumy7BXoBLO4E=;
        b=AD1Z0GqwJEwSF4JOScjc/RDELUqb9ypkcUgKE4ok8BfwrqyluJPLz+VDoUscsi+Mg7
         hy4ihSgLlTHIp8w9/QTFm1R4HapjEmV4n+6Tj7aeZdNPRFdKqdz72uCcGZBP7PE3zbil
         yMbbwBBZkYKIKnqOKU9fSdepnGoSIre7XlHq2PeT4AWbYgN8n79tDnqy2beYb2bY2yUD
         18h96eCDXXP5qd9s5l+Ve3oEUXHnBDMw5zg+GdXIJlrBp4L23lhFUFniLujiyu+mdll/
         aa1C9z5K7Ls3fNHRQrkLBj41pr4N0d3+uv0smAQRJAgNGwftPAN4LQhTnQcwaSukXELk
         p6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694873; x=1777299673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEXxlv8BImKZUhebuilBAJ2jXt3hQ6Gumy7BXoBLO4E=;
        b=gTUbXnoS1xscA2Yrt7kt+ryHZk/N1h4WlhOKmCZrkzL4pNfcDuMH8JzzfqJ70Nhr2x
         0+d9bOoLObx/PnVIVm1tsoBWuqGG4eQpBzWEaLDpZ4Mz9wROCKBYk9fws5Bgh+IYEl9t
         /HSM+Ynfwzfj+ZnTWsWXj4JAjsDiY7g94m0L4hFT4FxwtI5YoSHXuWtTuOBPeRNnWHbe
         Vyj45GfRz4lJ4KqJHuIsWnpIhotRmBJml9oSJhQc8kSM/gCo31QrIGEFZS/A+EyMXsgG
         3W0s6GDQ0T4JXbI3MQLivzTAYdu7E74Md6rC0F/JRDea7lChFjPfgKw0ud+FIlQiZpSA
         ZEbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TovaBH1LnF7dnu+cmkwDMldG0PJTJB63yqEZD7Jw71AbajCZjcP+Dp2/dMNPnvfc4q3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJitXfiM2Gfw5LuLs3MfHCS9c0lgz+EQr/RuROzzq9LeTKyPNV
	XJ7bvv6GMcZVMOel3Ena1ciLTjNF3n9z+UcKVJimgqJ5bWjHA2ILY/Ux
X-Gm-Gg: AeBDieudO5Vl3u2Gnx21g7+M+Rjzb73WXXS5NySru8YkK6VZ6VKjwSGHqGaualnRK20
	B5lE3kswy53l1m0t11VSYQ/VeEAN4dd0o7432ApGR83aOUVZasqhqilwmJJhdjtqhCDxUaXURgW
	j81MZQSI3W5QWm3bEa2+0nU70zQUh/MPTNusad2+Q6hIqvx25CWiIPnR6G3C20dD0qPGrPGWh6S
	XgFuIyms+VxQRIDLhJgU4GHgyWH2m6MeTw11Q1ygq2518Sd3+xhE3UYxnuAUkSigN9asjsn/0h9
	1ZSb817dBgA8hmZT8IX04V6ZEubvKXV4l1pIXkUFskW34vGpVC+w9EIbn3t7Qxscpv8F3s3gZNf
	LK3NWJulqg1TGcjcjHcaghfhblrDy7VaQgFO2RRfRJEPssEGaLFDKlE0/r+jJ5vlIoP4zohOhzt
	aoMkNwPi/zWw83UqhzlvtBvSt52TPVHEWSoZlVIfrqhbmgfeXwTXMPpdOFi16xrE9CM3oSnwWrC
	Lh7jCGD
X-Received: by 2002:a05:600c:a116:b0:486:af22:4a2a with SMTP id 5b1f17b1804b1-488fb74a447mr145774805e9.7.1776694872707;
        Mon, 20 Apr 2026 07:21:12 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5432:2d05:ea5:f7f7? ([2620:10d:c092:500::6:8ffd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891b46cffasm102223545e9.13.2026.04.20.07.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 07:21:12 -0700 (PDT)
Message-ID: <e8fa6144-b295-46a8-8cec-72e84579a98e@gmail.com>
Date: Mon, 20 Apr 2026 15:21:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Introduce
 __bpf_kfunc_mark_deprecated annotation
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Vineet Gupta <vineet.gupta@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
References: <20260418171701.610025-1-memxor@gmail.com>
 <20260418171701.610025-3-memxor@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260418171701.610025-3-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/18/26 6:16 PM, Kumar Kartikeya Dwivedi wrote:
> Documentation for KF_DEPRECATED documents the expectations and
> recommendations for deprecating existing kfuncs. Until now, such a flag
> never materialized. Unlike other kfunc flags, more context needs to be
> carried with such a flag, thus we introduce __bpf_kfunc_mark_deprecated
> as a replacement for the (non-existent) kfunc flag which takes a
> replacement kfunc to provide recommendations to the user.
> 
> Apply it to all existing impl-suffixed kfuncs that are preserved for
> backwards compatibility for a few kernel releases, after we introduced
> versions with KF_IMPLICIT_ARGS.
> 
> Note that this is only supported by LLVM-compiled kernels as of writing,
> since GCC does not support for BTF declaration tags.
> 
> Cc: Vineet Gupta <vineet.gupta@linux.dev>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   Documentation/bpf/kfuncs.rst                  | 42 ++++++++++---------
>   include/linux/bpf_verifier.h                  |  1 +
>   include/linux/btf.h                           |  5 +++
>   include/linux/compiler_types.h                | 14 ++++++-
>   kernel/bpf/helpers.c                          |  8 ++++
>   kernel/bpf/verifier.c                         | 41 ++++++++++++++++++
>   .../selftests/bpf/test_kmods/bpf_testmod.c    |  1 +
>   7 files changed, 90 insertions(+), 22 deletions(-)
> 
...
> +static void warn_for_deprecated_kfuncs(struct bpf_verifier_env *env,
> +				       struct bpf_kfunc_call_arg_meta *meta,
> +				       int insn_idx, s16 offset)
> +{
> +	const struct bpf_line_info *linfo;
> +	const char *replacement;
> +	const struct btf_type *t;
> +	struct bpf_kfunc_desc *desc;
> +	const char *file;
> +	int line_num;
> +
> +	if (!env->prog->aux->btf)
> +		return;
> +
> +	t = btf_type_by_id(meta->btf, meta->func_id);
> +	replacement = btf_find_decl_tag_value(meta->btf, t, -1, BPF_KFUNC_DECL_TAG_DEPRECATED);
> +	if (IS_ERR(replacement) || str_is_empty(replacement))
> +		return;
> +
> +	desc = find_kfunc_desc(env->prog, meta->func_id, offset);
> +	if (!desc || desc->warned_deprecated)
> +		return;
> +
> +	linfo = bpf_find_linfo(env->prog, insn_idx);
> +	if (linfo) {
> +		bpf_get_linfo_file_line(env->prog->aux->btf, linfo, &file, NULL, &line_num);
> +		warn(env, "%s:%d (insn #%d) uses deprecated kfunc %s(), which will be removed.\n",
> +		     file, line_num, insn_idx, meta->func_name);
> +	} else {
> +		warn(env, "(insn #%d) uses deprecated kfunc %s(), which will be removed.\n",
> +		     insn_idx, meta->func_name);
> +	}
> +
> +	warn(env, "Switch to kfunc %s() instead.\n", replacement);
> +	warn(env, "For older kernels, choose the correct kfunc using bpf_ksym_exists().\n");

Is it right to reference bpf_ksym_exists() macro from the verifier log, 
what if user does not use bpf_helpers.h header?

> +
> +	desc->warned_deprecated = true;
> +}
> +
>   static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   			    int *insn_idx_p)
>   {
> @@ -13016,6 +13055,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   
>   	insn_aux->is_iter_next = bpf_is_iter_next_kfunc(&meta);
>   
> +	warn_for_deprecated_kfuncs(env, &meta, insn_idx, insn->off);
> +
>   	if (!insn->off &&
>   	    (insn->imm == special_kfunc_list[KF_bpf_res_spin_lock] ||
>   	     insn->imm == special_kfunc_list[KF_bpf_res_spin_lock_irqsave])) {
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index d876314a4d67..5a57a92a8f8c 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1252,6 +1252,7 @@ __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args, st
>   
>   __bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux);
>   __bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux);
> +__bpf_kfunc_mark_deprecated(bpf_kfunc_implicit_arg_legacy)
>   __bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct bpf_prog_aux *aux);
>   
>   /* hook targets */

