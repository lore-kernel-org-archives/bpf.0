Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F682D0615
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714653; cv=pass; b=qhIGI+0jgh+cVe3/pORw6BknC2f7A8K/+mK9tLgVFQX0G0DS98K1VMzsEdjd4ral2fCYx0RNP8+wvoiDUUCERs0yC4CYmva8WFJ/Hq50IUioN6VkQ0IkQ2WzbaTsSD9IZK+5i9f2qOO5tzhZRqz03MY/BxCgHJjoVXgA1GZ/mRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714653; c=relaxed/simple;
	bh=Yh2GmLQHQfGIsF6kKCnlkZRXhN4K5Wjvj7p+60WwXHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5UeHnJCmPsfXgYmt6YjptN2JqubhSRmD44k+AOFaWWbuhGT3jxI/8f77vTOJVhRhxwmaLQK9tOiU/L2VxodCCIbZXCmk4bmtvumVhsro7ITvzQqDRp7eALN0+6KamBjGpF4i+6XcrdyUpJBo5nQGMcXsaC84SPFwbl4MzZH/uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y++EETQ5; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y++EETQ5"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664ee752958so95228d50.1
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 23:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782714651; cv=none;
        d=google.com; s=arc-20260327;
        b=nPhkLY44QMVrASPAqxNXVJAUW2uWstI8iyqDJmTSFGhRbwbR7Ai5ckjOrQTGyvcUlT
         VPrs9Z7drn/cKLdpew2rySAptMbS44SVvxIBWGePLnt5/esChKhqHQxan/JP+BAbNgTn
         1H8/wC6eWPX3h08GsdlVRJ3JlqedgExvK9oczsoihT8SKMXAbuWm6mn0JSewtUBI6/KR
         bBo15811l07u4dsCrah3E7zrJRAjvr50ttpivBOuwo/5MlWEEEnbw1Pank+sYKGM0Yvt
         wXvtlWvoHi8Ytd4SHm4hXNLrpKDf4SnGIr730UvylpUJIAldzYEq0uD5thTij2SR+7Ip
         Yyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wc1gXYp+xGTaSUZnzHKIS46+9gTB+iWgKfnEP0p5T9g=;
        fh=az0GnwzDTD5fcBq+j7RTzi2zesrPyXEVnqMPe17+lZs=;
        b=PfJXYp4TvUlJDko4JRZGDeU/O2QtcAnw45XBq8Jtf/XS7xkt3b4fAvlL/Qm2I7iXMM
         Q4lmBWkp3liiPlH4FMLlNGF8EcGHsc4YGB6KVJllz3QsnXiqGU9w2hur7vDPLGClR9Sy
         ZhvUjvykvinXU2/v1s5ZmDKjV4eGa8rxb4Hb3hFGNc1XArE8E0o1hcTpfN39fgcuYrEX
         qPsxTok4GDHbVwvHwOddnWhV81oOA00wgeDXvPUWjMFkcxli9w1ztB69mMMSf8hq6pZD
         Iar7My2sq5MbcpqsFDF+Xtsyt3btDlyLFNqcqDUK158Ukz4ku3T7UF7jY1WQH4sbUb+N
         VoGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782714651; x=1783319451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc1gXYp+xGTaSUZnzHKIS46+9gTB+iWgKfnEP0p5T9g=;
        b=Y++EETQ5szRKVlRbDRiR/W9JR6XxTrjgPrhRH3iWxEcSUyTdSy0jKnHw8fdOLfoPKW
         UX+QWUSowC82WxeIpz4nJel5q5nYRixwvvVk7HpPi2Kgi/Ks/m6YneaxtLtAAMc5jXeO
         sb49bUaxD53angfLD0YXa7vIBhSISVdTc9sQKsZ5Rx8dlF3f0PXTJ1OayvL8/+LsJvIp
         XW46IkMCOpFq1sv+LWz/9NYu6c+Uw2SJgFCNotMkYzevoRj2v9Ivwgkol3vAiTzB7/6f
         xHZIK8g3AXSFEosz6tBumG5eJeU4/bUUhgGauMqRF2IFkb5lEjYB++Nn6/v/HUXBORa6
         RqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782714651; x=1783319451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wc1gXYp+xGTaSUZnzHKIS46+9gTB+iWgKfnEP0p5T9g=;
        b=ZPQxFjO0yFrvNiRjSzGnTsEYW9YbVtEDLEkae8R3atPAv4lwUug3nlqnGIgOVxL5t6
         sx4Oeq8bYTK3WIeVC2uhr6mta9j2PMLXXncH1AdFcFm1NOZ7r35LUpEg6i1PIjDRVH4+
         HdolhhkoQv1k2yv3+BFLYcdYvtYui/vUVb8rRj4NtjVEyQ8z8yPuM6Pl94Cy6paGVCcK
         acZvnWRud75E9msGbzk6aJIWvkPNy50VhavxYff2z+0LI3pbM5th0MA6Co1+zzBTR+3U
         cbJ+6AentkWNo3irAYsDRXleUb0yPaie8w93SkLtXxoGPCmUezVMi+hXWE0+ucRSe3Ov
         sEew==
X-Gm-Message-State: AOJu0YysDsLEdhTBG/0hxidd5vxUprYcr10chhaCUYXHvZLc5nA2ocEL
	/LR0jZjrhH6Z33ebSMI6af/EvXa09QdDvNfSfBLjUsYmm+SJXyRJvDwwnkL5P7hv+i1Xfct0s/9
	ReOdY8AP1SFqnCQEhb/wtdGYMNEv+mBc=
X-Gm-Gg: AfdE7cnQy7FOKHmsfbg7dLAselQ/ok9shjKPtVH+eYhWduXIGLoMiCm4pAZPd/eaQlG
	j1alHOpAsJgLazHgEta7lRK7Iq0Xtfhtxu7GucuL2JxKqqiYpNmOaPHTLbb5MkGJ9mkFbTsMYfN
	899F0SssxISbMK6YculMgDSpPu1bykoD5+w8Zx4ZApho+cVGfonv5L5vRM+aXnRuhEoL2IUHyrW
	b4CfOcYkAs1wbKz+ZHNUGH2AeKOmYBKcm+zC1Uzx20ODfGhOzgypshsIOCE6KIpottUvCjnORKX
	pdJm8PU=
X-Received: by 2002:a53:b0c8:0:b0:664:ae68:33b5 with SMTP id
 956f58d0204a3-664ae683a18mr6204799d50.17.1782714650763; Sun, 28 Jun 2026
 23:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628201103.3624525-1-mattbobrowski@google.com>
In-Reply-To: <20260628201103.3624525-1-mattbobrowski@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 28 Jun 2026 23:30:38 -0700
X-Gm-Features: AVVi8CdR2QkQ2JIXHjOSnHplL5uGO3pBFVyJy022RkglMcMQwCrE_jthuoaMa2k
Message-ID: <CAMB2axOQhmm-eyEqSU-FHzw3P36XMW9RyU5--LRewZNUcfd_BA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: reject BPF_MAP_TYPE_INODE_STORAGE creation
 if BPF LSM is uninitialized
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Paul Moore <paul@paul-moore.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, oxsignal <awo@kakao.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2026 at 1:11=E2=80=AFPM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> When CONFIG_BPF_LSM=3Dy is set, BPF inode storage maps
> (BPF_MAP_TYPE_INODE_STORAGE) are compiled into the kernel. However,
> if the BPF LSM is not explicitly enabled at boot time (e.g. omitted
> from the "lsm=3D" boot parameter), lsm_prepare() is never executed for
> the BPF LSM.
>
> Consequently, the BPF inode security blob offset
> (bpf_lsm_blob_sizes.lbs_inode) is never initialized and remains at its
> default compiled size of 8 bytes instead of being updated to a valid
> offset past the reserved struct rcu_head (typically 16 bytes or more).
>
> When a privileged user creates and updates a
> BPF_MAP_TYPE_INODE_STORAGE map, bpf_inode() evaluates
> inode->i_security + 8. This erroneously aliases the struct
> rcu_head.func callback pointer at the beginning of the
> inode->i_security blob. During subsequent map element cleanup or inode
> destruction, writing NULL to owner_storage clears the queued RCU
> callback pointer. When rcu_do_batch() later executes the queued
> callback, it attempts an instruction fetch at address 0x0, triggering
> an immediate kernel panic.
>
> Fix this by introducing a global bpf_lsm_initialized boolean flag
> marked with __ro_after_init. Set this flag to true inside
> bpf_lsm_init() when the LSM framework successfully registers the BPF
> LSM. Gate map allocation in inode_storage_map_alloc() on this flag,
> returning -EOPNOTSUPP if the BPF LSM is in turn uninitialized.
>
> This fail-fast approach prevents userspace from allocating inode
> storage maps when the supporting BPF LSM infrastructure is absent,
> avoiding zombie map states.
>
> Fixes: 8ea636848aca ("bpf: Implement bpf_local_storage for inodes")
> Reported-by: oxsignal <awo@kakao.com>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  include/linux/bpf_lsm.h        | 4 ++++
>  kernel/bpf/bpf_inode_storage.c | 9 +++++++++
>  security/bpf/hooks.c           | 3 +++
>  3 files changed, 16 insertions(+)
>
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 143775a27a2a..dda272d78f01 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -14,6 +14,8 @@
>
>  #ifdef CONFIG_BPF_LSM
>
> +extern bool bpf_lsm_initialized __ro_after_init;
> +
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>         RET bpf_lsm_##NAME(__VA_ARGS__);
>  #include <linux/lsm_hook_defs.h>
> @@ -56,6 +58,8 @@ bool bpf_lsm_hook_returns_errno(u32 btf_id);
>
>  #else /* !CONFIG_BPF_LSM */
>
> +#define bpf_lsm_initialized false
> +
>  static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
>  {
>         return false;
> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storag=
e.c
> index 0da8d923e39d..f9e81060c1f4 100644
> --- a/kernel/bpf/bpf_inode_storage.c
> +++ b/kernel/bpf/bpf_inode_storage.c
> @@ -178,6 +178,15 @@ static int notsupp_get_next_key(struct bpf_map *map,=
 void *key,
>
>  static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
>  {
> +       /*
> +        * Do not allow allocation of BPF_MAP_TYPE_INODE_STORAGE if the B=
PF LSM
> +        * was not initialized by the LSM framework at boot. Without prop=
er
> +        * initialization, the BPF inode security blob offset remains unp=
repared,
> +        * causing bpf_inode() to calculate an invalid memory offset and =
corrupt
> +        * inode->i_security.
> +        */
> +       if (!bpf_lsm_initialized)
> +               return ERR_PTR(-EOPNOTSUPP);
>         return bpf_local_storage_map_alloc(attr, &inode_cache);
>  }
>
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index 40efde233f3a..7b98f5d1e2be 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -7,6 +7,8 @@
>  #include <linux/bpf_lsm.h>
>  #include <uapi/linux/lsm.h>
>
> +bool bpf_lsm_initialized __ro_after_init;
> +
>  static struct security_hook_list bpf_lsm_hooks[] __ro_after_init =3D {
>         #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>         LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
> @@ -24,6 +26,7 @@ static int __init bpf_lsm_init(void)
>  {
>         security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
>                            &bpf_lsmid);
> +       bpf_lsm_initialized =3D true;
>         pr_info("LSM support for eBPF active\n");
>         return 0;
>  }
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>
>
