Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795612243;
	b=iMSccH49pgrlYbZCrRpsR+dHOTquia0xCvwzTyJ96lBc2dNVfUoHT/LwUHRUjNrxad1Q
	 xm0w8yY7+2qmQDs03x5JFPJKk7E4p3NbiDncYfCz01WwWLPoOTXX3yV0IoDBlY27kZK0F
	 M24TYM1mV8Oc2URV3irgJXkV/9Q8p2pTpxcCt74LCHLzYiQ/SfCM/HaM2xwWljMumcLmV
	 zkf4tBVVawfg3hZgIYy5kxXaNIYz4osyFGPv//fMLqYU3WL5t7EGoveL/OzA/77AzDiRj
	 cuC+PdgaDnxa1i+hC6RIcahC/PoCRpYhBkwy/8zkON9Y2ZbGZa2JSazNtQzc7dsD4kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=aadOzpq05zgOnU/JWxnP7h3rgAEH7apsKIxgVnSShMg=;
	b=Fa1X6Y/uV6mgA64HBbjbHJS1be/gO+zAsJu9pbM71gyuqVmF+unxqX8GuxcnRUAMMS8z
	 9qDQ3kIAvNkn/aPgup3JdXMuOR4yo0ZdkyY6jhfrNaFKItsr9G17TTvVt5b6O2f3CmLQ2
	 XysIYfumBooTM/DMEQleh61iRl0jxdu7En64nUhdfY8kW6aLoYhdze7SFApCyaVfTU1Um
	 s4mZfSZdcLhN0B4XUE09VwtF3ccIjtSfNxDEXd+PxPDnXuGFeaLJxYveS2R0qHGl2i0tg
	 EyyNeVjvNi6AG6cI7bVncWnZU5ZgrXN9zdKLGhxTrRO+aQfIlepvaL8At6yHSladT+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="W1n7d/BU";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56D606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 13:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F56D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W1n7d/BU
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-677d35fd1d2so5820913d50.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:10:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795612242; cv=none;
        d=google.com; s=arc-20260327;
        b=FTzlq/1LCWoVjZnQ8j10+jdzNQHpomUkfVcEVbW6B3x0Sn6VKtENb4QIq3WrPdbyWD
         cuEidHuC3h0RVJvh9AzZQoln9wW3OeY5GoIQv6X+wsYAZvzzlm0GM0jtQazOha4zkYYh
         TZyrIO9/8RKqqxvf+oeEdMrKPRuACIFr4yYGTSkwo743zyXqg7omiOvL1H+gys21fJRR
         Aig2hNP3fXINCdodHMBnEf2YvkQ3tibnmT1dfHDLS0glT9Rwpgs8QQChpik0tu/Msne4
         wnEM0PHDXIZ1dnfKhJgpT+7+vcMvgdnxOT0iQgZJ3YJDlJpFs0yxmVQ8salrSWpHY4I3
         Z/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aadOzpq05zgOnU/JWxnP7h3rgAEH7apsKIxgVnSShMg=;
        fh=R8BU2yF4CrhD2szyM+OdVFJqHyACMniUSKqaOjdXodo=;
        b=MC/cnBN6Vieq7vuAQ/z+cGO8beas0PkFALTzJl8N7cubLiH+gs1WG0s2uProWKouKM
         SWcHdck8DHR6XSYsB2pd7NSPuWtm2emqYLofh0m1GMMIUAUAjPwfxfQJ6sgonY9kymQg
         25cXKDXUPLX5mTc5tBe4iKlxKkoRPtHc3Nt0eauCaLTs8b4nsamz8GSBJYBhrVTE0yyO
         rOVeSLDEyWnKuyRThkSqKuLHEQhqvRbBc/+n+GzUh/yv7qLZQzoNfkCu9CyONMmSL8xo
         Wu8LFq3/Y7ypaWrxXueaIv3r0/N5jv63HZzTPHedwOvftmdbrnozs7kDhFMOY3S6J7cG
         u19A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612242; x=1796217042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aadOzpq05zgOnU/JWxnP7h3rgAEH7apsKIxgVnSShMg=;
        b=W1n7d/BUlZCJ0Jbwyqf+i2h+I7Xwrd0Ekh1coulWhgMMzekgC4Sl9lFMjTbqexsIde
         oWGiYuiYBOAmMrIEL/P8il9eBKCIJyRFvFl+nbVeW20RJi5ZZITFTIqy6o6xXFsp4M8n
         bdAFlj5jxPdL2zV+0XeqrMJM1LHqFJolfnMxVK1b3FXxasqi4PzC8PFVADimgZoVoDbF
         Pi+mEfC6kBa2gH80wgxXYXlGY1QExluasPqfbNfVKeVrhukoUkKHg/j4Px6ZyiSiiZp0
         vkEXFcWGLB7vNAMD+U6KKBi1VZSQBfbGwI1P7sGNrsDNZLU+51xvrJLSDiG1JJuYWkaO
         MXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612242; x=1796217042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aadOzpq05zgOnU/JWxnP7h3rgAEH7apsKIxgVnSShMg=;
        b=zgew4Se7fPo3t964e7eovWC3m8F41VsnVNQXxr2pye9jXhczYKGR+rUnhcqDPskPCJ
         +1TJnkhSvNlgmKExhrJUBHWkwRyrkJJ+K0vpn28QTvD6BvsK/zNV5GiKSJM1xB1qiZUq
         s2RpoKWSXoC8DzuflYN8ENYWVsd10qhFPaEW6gWpSRnT+ME/5m1+RZ0BVXsRHVuhP6Tj
         FT8vEDbWzzqAo+GFwr/kywMSIpFVhhuRoL0YMoo4BsTKKuNaiBJ4oDdH+7DEvNSWgvbg
         uVxJ4rkpYV60xycxVkcCzV+Pj36qB6L1UHFmaltKQrcSH6YMfLAKFIm5sLoNcsr/8Iuj
         EtGg==
X-Gm-Message-State: APuU4Z+c1NsHCjgKyZDKmWrPnnn/9zBMmZaJexUezZdpg7zxrj1iqMq/
	KEHmlVY515F8pUVGzy7sCguoSG7OQ7FExqCoJJuf+xN3NTQOBjqQESls7OJd6Kk1pSwR6jIs8To
	XSvEP0wPtOd+2uvVMo4yq2Bs7+a3P4Rs=
X-Gm-Gg: AZFdTZejdVe9J/hq8/pzk+NqurksGvk5likRCruCXnl52To3J9sVKKVV9mK527/4dlQ
	sbkbVIqCpqckj8XgZk4K0tLWYkr4PzA2PFoeynatciAK+oBrh7UbfpmSXh5QzT548RjQ7CHenK1
	jEj2LhtSsHYFByhf88OmfHZ/52lW9pS2W967BOcLpjTdQvPTgIg9pZPmCwA/ibLTqK5+mh4M0Ss
	YXSR204EOrVhFyVDeiOZQROTpAOVbNS7ObFX8R71Xhln+u8yrWJjg2vyBJl8EAgLVmRgct3CczS
	7kqMg72OwBh3gr/51y6JDzQppK5/+Z5QUszMdGAUZPhb2vJ027+ODun/d6nPDwF02a8beaIgR8d
	Kb3iuxqVO3n2kRmT5j9OshDat/13gRLWR9hfw6MY5IoPnbHVtzsx3DwlXBHrMcTVJSJg=
X-Received: by 2002:a05:690e:191c:b0:67d:bb89:acba with SMTP id
 956f58d0204a3-67df44c1bf1mr5627227d50.74.1795612242335; Wed, 25 Nov 2026
 05:10:42 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com> <20261125032938.670542-6-alexei.starovoitov@gmail.com>
In-Reply-To: <20261125032938.670542-6-alexei.starovoitov@gmail.com>
From: Anton Protopopov <aspsk2@gmail.com>
Date: Wed, 25 Nov 2026 14:10:29 +0100
X-Gm-Features: Aa3M54qdlYHDUvi5N68N-JJMKKAN2Q9PQmjGm5AR93QbqVLIeJ9TRxW6IHle7Uc
Message-ID: <CAGn_itzVVPFuxq7XPYBCmY6Ltp3=CorsY0n0OsfiE-X6GvXa7A@mail.gmail.com>
Subject: Re: [PATCH bpf 05/47] bpf: Check that an extension fits the hook of
 its target
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 4:30=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> An extension runs in the hook of its target, and the checks for the hook
> do not see it.
>
> Tracing, LSM and struct_ops programs are checked against the BTF of
> their hook. An extension takes the type of its target, but it has no
> attach_btf and no st_ops, and attach_btf_id and the prototype are those
> of the function that it replaces:
>
> - tp_btf: it can read more arguments than the tracepoint has.
> - LSM: the range of bpf_get_retval() and bpf_set_retval(), and the
>   helpers that only some hooks have, are looked up by a wrong id.
> - tp_btf and struct_ops: the load can oops.
>
> fentry, fexit, fsession and iterators cannot be extended already. Refuse
> the rest. freplace of global functions of tp_btf, fmod_ret and LSM
> programs goes away. Targets of other types load with any
> expected_attach_type. Do not take their extension for tp_btf or for an
> iterator.
>
> Some properties of a program are looked at when it is attached or run.
> Nobody looks at those of an extension:
>
> - bpf_get_local_storage() returns the storage of the attached program,
>   the extension is verified against its own map.
> - bpf_override_return() needs a function that allows error injection.
> - skb->cb is saved, cleared and restored only for programs that access
>   it.
>
> Ask for the storage map of the target, at load and at attach. Refuse the
> attach when the target does not call bpf_override_return() itself, or
> does not access skb->cb. A tail call counts as an access to skb->cb.
>
> Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/syscall.c  | 18 ++++++++++++++++++
>  kernel/bpf/verifier.c | 38 +++++++++++++++++++++++++-------------
>  2 files changed, 43 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 48ed0944f31d..3f2bc772e297 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3847,6 +3847,24 @@ static int bpf_tracing_prog_attach(struct bpf_prog=
 *prog,
>                 err =3D -EINVAL;
>                 goto out_unlock;
>         }
> +       /* Where the return can be overridden is checked for the target o=
nly */
> +       if (prog->type =3D=3D BPF_PROG_TYPE_EXT &&
> +           prog->kprobe_override && !tgt_prog->kprobe_override) {
> +               err =3D -EINVAL;
> +               goto out_unlock;
> +       }
> +       /* bpf_prog_run_save_cb() and bpf_prog_run_clear_cb() look at the=
 target only */
> +       if (prog->type =3D=3D BPF_PROG_TYPE_EXT &&
> +           (tgt_prog->type =3D=3D BPF_PROG_TYPE_SOCKET_FILTER ||
> +            tgt_prog->type =3D=3D BPF_PROG_TYPE_CGROUP_SKB ||
> +            tgt_prog->type =3D=3D BPF_PROG_TYPE_LWT_IN ||
> +            tgt_prog->type =3D=3D BPF_PROG_TYPE_LWT_OUT ||
> +            tgt_prog->type =3D=3D BPF_PROG_TYPE_LWT_XMIT ||
> +            tgt_prog->type =3D=3D BPF_PROG_TYPE_LWT_SEG6LOCAL) &&
> +           prog->cb_access && !tgt_prog->cb_access) {
> +               err =3D -EINVAL;
> +               goto out_unlock;
> +       }
>         /*
>          * The size of these contexts depends on what the program is atta=
ched
>          * to, or run with. That is compared with max_ctx_offset of the p=
rogram,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 311c9f19b781..4cc9a210cb25 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22675,6 +22675,7 @@ int bpf_check_attach_target(struct bpf_verifier_l=
og *log,
>         }
>         if (tgt_prog) {
>                 struct bpf_prog_aux *aux =3D tgt_prog->aux;
> +               enum bpf_cgroup_storage_type stype;
>                 bool tgt_changes_pkt_data;
>                 bool tgt_might_sleep;
>                 bool tgt_can_unwind;
> @@ -22729,6 +22730,16 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
>                                         "Extension programs should be JIT=
ed\n");
>                                 return -EINVAL;
>                         }
> +                       /* bpf_get_local_storage() returns the storage of=
 the target */
> +                       for_each_cgroup_storage_type(stype) {
> +                               struct bpf_map *storage =3D prog->aux->cg=
roup_storage[stype];
> +
> +                               if (storage && storage !=3D aux->cgroup_s=
torage[stype]) {
> +                                       bpf_log(log,
> +                                               "Extension program has an=
other cgroup storage than original\n");
> +                                       return -EINVAL;
> +                               }
> +                       }
>                         /*
>                          * How much of the buffer of the tracepoint is us=
ed
>                          * is checked for the program that is attached to=
 it.
> @@ -22793,16 +22804,14 @@ int bpf_check_attach_target(struct bpf_verifier=
_log *log,
>                         bpf_log(log, "Cannot recursively attach\n");
>                         return -EINVAL;
>                 }
> -               if (tgt_prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> -                   prog_extension &&
> -                   (tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FENT=
RY ||
> -                    tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FEXI=
T ||
> -                    tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FENT=
RY_MULTI ||
> -                    tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FEXI=
T_MULTI ||
> -                    tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FSES=
SION ||
> -                    tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FSES=
SION_MULTI)) {
> -                       /* Program extensions can extend all program type=
s
> -                        * except fentry/fexit. The reason is the followi=
ng.
> +               if (prog_extension &&
> +                   (tgt_prog->type =3D=3D BPF_PROG_TYPE_TRACING ||
> +                    tgt_prog->type =3D=3D BPF_PROG_TYPE_LSM ||
> +                    tgt_prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS)) {
> +                       /*
> +                        * These types are checked against the BTF of the=
ir hook,
> +                        * and an extension has the BTF of its target ins=
tead.
> +                        * There is one more reason for fentry/fexit.
>                          * The fentry/fexit programs are used for perform=
ance
>                          * analysis, stats and can be attached to any pro=
gram
>                          * type. When extension program is replacing XDP =
function
> @@ -22815,7 +22824,7 @@ int bpf_check_attach_target(struct bpf_verifier_l=
og *log,
>                          * beyond reasonable stack size. Hence extending =
fentry
>                          * is not allowed.
>                          */
> -                       bpf_log(log, "Cannot extend fentry/fexit/fsession=
\n");
> +                       bpf_log(log, "Cannot extend tracing, LSM and stru=
ct_ops programs\n");
>                         return -EINVAL;
>                 }
>         } else {
> @@ -23163,10 +23172,13 @@ static int check_attach_btf_id(struct bpf_verif=
ier_env *env)
>                 prog->aux->saved_dst_attach_type =3D tgt_prog->expected_a=
ttach_type;
>         }
>
> -       if (prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP) {
> +       /* An extension has expected_attach_type of its target, it can be=
 any value */
> +       if (prog->type !=3D BPF_PROG_TYPE_EXT &&
> +           prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP) {
>                 prog->aux->attach_btf_trace =3D true;
>                 return 0;
> -       } else if (prog->expected_attach_type =3D=3D BPF_TRACE_ITER) {
> +       } else if (prog->type !=3D BPF_PROG_TYPE_EXT &&
> +                  prog->expected_attach_type =3D=3D BPF_TRACE_ITER) {
>                 return bpf_iter_prog_supported(prog);
>         }
>
> --
> 2.55.0
>

This came right in time to reply to bot's complain in my series

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
