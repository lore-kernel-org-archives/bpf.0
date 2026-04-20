Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCF62D29C8
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698875; cv=pass; b=LmXaBZLWt4k6cUdMGhqlHMEXV+SEBopPkgDzl9ApSCxAbc9IkoyFxRC0EyJ53ZQU8qeQZaG/tGSBEjiRb/aOIwCkwi+1yDv3uYlH5oP/RE+M8z9iDQk9cedGWwjiZPNern9NTuCUZPGnhafqADUbvlxwt9li0b2D6c3oEF5kW9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698875; c=relaxed/simple;
	bh=f6fkjXv/uu8HG6AD2f+KPXe/ALVS+nU4/s4+BkNShzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0Ccpuf+yQCCMvx9m5nbD1lgJ5vgEKEYb34PF3LIfi1g6sKD9iD+jUSUaxUaT1KcjRIB8/xXLjTWfd1EC1iv22sZsOnOwhLNzf8I7mKQSDiy0rV20FzePiRUSLy4It9lAurSSg8HMFEXv29hQp5yWwuI4ikmD+IjDno3ORcePjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8Sa3Y4b; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8Sa3Y4b"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-488d2079582so37564915e9.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776698872; cv=none;
        d=google.com; s=arc-20240605;
        b=JwvW/jzDr0cBBSTvXfi1gnI27obGEtoO43eo56BGh6ua2izqTa3KELtnzYWMVzyHKV
         4kHd6NgOL2JPYCZPJElv58zVzeQQ/9XpHSJvbqr6k8e7IFd8sOPCJ8Pvzm/rR7EqYS7K
         KQY4E2SD7hIS27xRvlayarWcmEKSk6d8xrsRSX+fAqRyDz/NlUw2gyYQxgbDYnzIfw/A
         HxMrK81zHKh6JoEAu6c94t43gpObbOh1NBCuFYybUEWc66agAh7+oPx9kSDSOQVhVXXw
         +EQC51uNXNjFcUa+R7JyNrKoomJWjycWtalrYK1rmtDRVPAUzDEG51TdUGkZaY0VD8LH
         48IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mC2n5O3dplhvzREh5310uq6ozJwZ4YK066BvPCk5vTo=;
        fh=ovzQWY0MLbBSf05Moetph8cYw3T6be0W7cMJaX1s5ZQ=;
        b=g9AWCdf9sxxEDTna2HjIKjZHKPhW9KF6TbJruda3KtLZg9NChO4/S5a+Ib0ary0AZu
         0S7lZYxYoPclfVfyFKQGSOIU7VPn5CPMY4m1kY2s09a9uFAV6QDwDfqB6boS7P6Yo/5O
         KWhfOp6qbVoT5MNWbWTHlgP5Mi1IbwAisQeGSwqK7WtNcVyVMdPx2Zl49tV89SQyAglw
         xNJ0yw14C0vCRsX29blL5VOq3QB72x2X8cKc0oS4I1wTFMud+hedNyYIaJmxRxEEqbNl
         /HoJwE0ApKTeacHR2p9WMYoy/Jnz7LzIfRf7dy0GVhur6ypNGMENLOuuZ8/r72l8EO7x
         u+Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776698872; x=1777303672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mC2n5O3dplhvzREh5310uq6ozJwZ4YK066BvPCk5vTo=;
        b=H8Sa3Y4bzVyxrUrJ5QcI7Ac6Obo+eB6+kXZQmmiqWMOeO4qYdjuCnwv6AElsLBZ6VP
         xNXcFkvYJRXaDQlmQXygcS8GjHiyRl7W7hZqKoZD6e5k7rRB6GHLA/t/V6RzdnBCOhUv
         L81WwshHQLIVrWhC5VyC2N3TmlQSoxIN+liLTNn67uGlvnSLw2wyV/goE8NRm9KEJbtj
         SR+fpZyAXSQLUceIBgg9k2JW3hc7rsM/zQukcMsA3iln+cS81cM4ZX6L3OezWVFfK9Ws
         YgD5VPa6iNNthMBZifMLT7RxM+B93bsz0Kptg9J3WltMhVI3H3AQ06PR5VF8fZ5AyhyM
         qftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776698872; x=1777303672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mC2n5O3dplhvzREh5310uq6ozJwZ4YK066BvPCk5vTo=;
        b=LChrsCU3H0QajNJIt9Sf6muMoBrPV8nbO2B1UqhjRDQUwVrTT8jtXLLKxfNFG/YWHR
         L7XtaqZOLPksGO3mt9QN1mJDHikQRDwUx3rzld4kIr4QfKOiy9NcKqygzoPRyzHwzI/M
         JQCx7dRkReQ0jEH5Iiffps1VYAleQdg1nKdcEN6V+kGz2fAHpjOjIMccUW9Z/pMDwsJc
         Ev1EnWMl68OpAKJ2Ahp0bcCe6/1Uj+zshkO/5igTV1DCjD3/NjX2EPui2m5yFwuK1L+m
         OLf+9gRPnyOTIlrgcabUxkNKesVHaOP6IJxm1LYET4lj8YTi8nhtYxHO6VRMm2BhYfDp
         l6GQ==
X-Gm-Message-State: AOJu0YynSyF+u4zqGpUjjE4QxfLdTThEYPR2IYU8kJC/WS8w+LJH2ezA
	kk80N+pNWt8g46/YytFEEBTlQg237jB6CnRKw40lmy3jqr/rA0cpqMlAzcWPYszZYTzM/Yi/Dou
	Ox9xEe1HvXzku884ZQID1VBqQ2iFq8MVypQoVS5RB4jfh
X-Gm-Gg: AeBDietZVInf/VknXBXeWmf5lt/WE707SS1u+DWLn8UQCoQ00YjmGBfYZp9zMi7yqrW
	U0YtB5d0iCiUpWiW/uz1aFcXHIEcSFluyTEfYw/hNYhvYiRAKBh9yEZSGgLdZw6aTDVdnDbGILR
	ErULHIHGCMLSRxiuc1xsmJ38m5JLbzvxF1lT5MzyjnJRes/ZgM0tcJb2ALL99f/mpD6Cahb5JMo
	jz2XnSwlJIpwczVo80UNHKfjTTv5dMPNYeClaCINabpMSJ3ry78G8HHWIiooBpwMXNMoXzWF4TY
	3R42RX/JGjNKVdXcBvusLbXQxGUII75BzbOx76vfjoUf2NRv3SySryA8BlYNo4Mv3tjrFL5D5sC
	lVlJm2BIxDJ6Jxitkz9VJsCnti0dWK8d6xumL5goIeg/XENqj4+fuBlaH9H8ajLgJpVFjlvUfjP
	qF1x8kMjW4ajaitw==
X-Received: by 2002:a05:600c:3483:b0:486:fba7:b150 with SMTP id
 5b1f17b1804b1-488fb7787d7mr183191005e9.15.1776698871577; Mon, 20 Apr 2026
 08:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418171701.610025-1-memxor@gmail.com> <20260418171701.610025-3-memxor@gmail.com>
 <e8fa6144-b295-46a8-8cec-72e84579a98e@gmail.com>
In-Reply-To: <e8fa6144-b295-46a8-8cec-72e84579a98e@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 20 Apr 2026 17:27:15 +0200
X-Gm-Features: AQROBzAIxRrLE1tNbQXpLoUGoSdZOOxRAY-AKV0JTd-uHIMg7wBuHGbRms-m_R4
Message-ID: <CAP01T771Qv2Gkv=4qtGGHmxFrmNG6kDXK7EV661yi4sWO=hDHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Introduce __bpf_kfunc_mark_deprecated
 annotation
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, Vineet Gupta <vineet.gupta@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Apr 2026 at 16:21, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 4/18/26 6:16 PM, Kumar Kartikeya Dwivedi wrote:
> > Documentation for KF_DEPRECATED documents the expectations and
> > recommendations for deprecating existing kfuncs. Until now, such a flag
> > never materialized. Unlike other kfunc flags, more context needs to be
> > carried with such a flag, thus we introduce __bpf_kfunc_mark_deprecated
> > as a replacement for the (non-existent) kfunc flag which takes a
> > replacement kfunc to provide recommendations to the user.
> >
> > Apply it to all existing impl-suffixed kfuncs that are preserved for
> > backwards compatibility for a few kernel releases, after we introduced
> > versions with KF_IMPLICIT_ARGS.
> >
> > Note that this is only supported by LLVM-compiled kernels as of writing,
> > since GCC does not support for BTF declaration tags.
> >
> > Cc: Vineet Gupta <vineet.gupta@linux.dev>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >   Documentation/bpf/kfuncs.rst                  | 42 ++++++++++---------
> >   include/linux/bpf_verifier.h                  |  1 +
> >   include/linux/btf.h                           |  5 +++
> >   include/linux/compiler_types.h                | 14 ++++++-
> >   kernel/bpf/helpers.c                          |  8 ++++
> >   kernel/bpf/verifier.c                         | 41 ++++++++++++++++++
> >   .../selftests/bpf/test_kmods/bpf_testmod.c    |  1 +
> >   7 files changed, 90 insertions(+), 22 deletions(-)
> >
> ...
> > +static void warn_for_deprecated_kfuncs(struct bpf_verifier_env *env,
> > +                                    struct bpf_kfunc_call_arg_meta *meta,
> > +                                    int insn_idx, s16 offset)
> > +{
> > +     const struct bpf_line_info *linfo;
> > +     const char *replacement;
> > +     const struct btf_type *t;
> > +     struct bpf_kfunc_desc *desc;
> > +     const char *file;
> > +     int line_num;
> > +
> > +     if (!env->prog->aux->btf)
> > +             return;
> > +
> > +     t = btf_type_by_id(meta->btf, meta->func_id);
> > +     replacement = btf_find_decl_tag_value(meta->btf, t, -1, BPF_KFUNC_DECL_TAG_DEPRECATED);
> > +     if (IS_ERR(replacement) || str_is_empty(replacement))
> > +             return;
> > +
> > +     desc = find_kfunc_desc(env->prog, meta->func_id, offset);
> > +     if (!desc || desc->warned_deprecated)
> > +             return;
> > +
> > +     linfo = bpf_find_linfo(env->prog, insn_idx);
> > +     if (linfo) {
> > +             bpf_get_linfo_file_line(env->prog->aux->btf, linfo, &file, NULL, &line_num);
> > +             warn(env, "%s:%d (insn #%d) uses deprecated kfunc %s(), which will be removed.\n",
> > +                  file, line_num, insn_idx, meta->func_name);
> > +     } else {
> > +             warn(env, "(insn #%d) uses deprecated kfunc %s(), which will be removed.\n",
> > +                  insn_idx, meta->func_name);
> > +     }
> > +
> > +     warn(env, "Switch to kfunc %s() instead.\n", replacement);
> > +     warn(env, "For older kernels, choose the correct kfunc using bpf_ksym_exists().\n");
>
> Is it right to reference bpf_ksym_exists() macro from the verifier log,
> what if user does not use bpf_helpers.h header?
>

I was hoping it's discoverable if people google around etc., the first
result (https://docs.ebpf.io/ebpf-library/libbpf/ebpf/bpf_ksym_exists)
also has a nice example.
