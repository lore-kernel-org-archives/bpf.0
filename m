Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63FE2DAFAF
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 05:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782710707; cv=none; b=p4N7aKSiwENtda8cQp1mLcvdmudxq9TPrppDOUji7Z/x4RR3Sqd0uq5WMuwjXzXeckPDvro7bcrzHxMjh34XNHIpxazxF93QENqwfCsU+JjK4p3jLc+RJ0eBPaFW28npho68uVX0/RVzvMzEMe7PTVT+52c1MUYPdexL3DfT4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782710707; c=relaxed/simple;
	bh=2Yvy6Hco5S+elcrglIBBx4oEhLifzv19iCs8IkOEVjo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=BU5PPqGFcITy8y6t05nPscNBCLYjUk2vccvvH5KNj2JIvXSFFX39qNlIoujECTwBSw61YdxgY6/lBuESBf25yqk9YA0NAFdBFyGjdtGnPwBuZiTe9L8s0NFeblAtMyllCPU/TL/1UcSx1X2PbYFquaPsN4VqiLpwGwxUIx6cDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=s2R2C17t; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="s2R2C17t"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8efb708b1a0so10018906d6.3
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 22:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782710705; x=1783315505; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GY5h3xDvejex2uja5LFOAqy+UvjSo3KJdahPhXJCNg=;
        b=s2R2C17t6AX3UUw7Zlk242m1XQtiUpmintwLSM4voUk4AiAw/EBWdINseU8WzrR5vD
         pdqVRWtx6An6uZUjALFQZjPHsShVj7Ng2hX6sOosmGGLzQo5/4MxV1aSpJwbMn3PAzsC
         Y2hA1zEowfmvnCtDLhWVtj0n6ljHv6HlcrtLztzVy8qp9OF+veP3icngE013PvLTwjJZ
         Peq8zddGmo+anEaUpq7c+r8Da015qU/KOfENeNWjHi6HVFAekb1OS37Vw8P6+bqDcFjo
         w9PJ1jrr+Rt2CAv4coQCAIXyMODPlQ78XMSze1wPZXhg6vTX74TcF4Yx0hMsfzwZDYzo
         CTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782710705; x=1783315505;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GY5h3xDvejex2uja5LFOAqy+UvjSo3KJdahPhXJCNg=;
        b=in0ixZb6ZaB//3FLK71FIU78UFQ4bPwKS8AsEPBm631VstqA157htqVoVGRbkYrYdX
         9+41HKsqTQhEyHsOIi90woBNTVq/yJvgldZn8puuKZU5ERdSMZxNG8aD/5mpi2LHxoGx
         WFwgSboNkx19E4JcxYZVkXhOPBB7jjQtzszd88tm9t9jpg5Weh1Fw5RggHhfZ3uOCxdG
         L7sluWmm0qOMXFxawsRU/mrdQ798TSlMQlOSFq4RavIWB0pdWbvP4mRzSyiCCbnxKVOD
         A5ykBtgoP5jv9RwNkUzK5pioZGv/X3mcloGOwZ7RChBrcP9A777JLiyJcXvvFlIb2K0x
         Q4aA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9gACHYN0YESe/gCyoqamwDPJazTk5ZYI/spCGwMiOmDjYyAtZxPFZRvVSg7z6GNansmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGWClf3vl1LNehPTy+VimNsORs+67d1YpOpnfBbqvUADLmpYS
	3Ror6CKtg/49ZsFYBqa9ULE+K6+yRtFHuheVwkYOjSWKvq0eeZo1A4JVQb2sopptBn0=
X-Gm-Gg: AfdE7cn4oBh962datEZOgXjBMPYOuL4A7o+JjHwLJu8ZzFWqtYsqVcZG0NCx2eTXOdB
	s55lCa2b4SSmwT6/JbaeDYqOiP6zMdlZbbNP7iiO+P3w0kBpDOKooZ876lE7GjsEXhQ/dh3wjEX
	Wu7i6tCRkG3xDBV4JOQHP4yLEI1au/P79tnXWqs+Xd7/eRGAxG7+dYdygn0p8u/Nrvf2gQwYuJ4
	CldOPhy7KXm0+enV8fw0ZXsBfAbatu+BBMDX3/XI03U3gtxCU1TXTIiZORaCRGpuFTUTBtpqca5
	tlyGTS8IUZbbYJHISmOQ4AINjh/dJl/Ht8LKfR5jJq93a3G19k8qABqngXTNICth/G1XE0/0/mB
	tkkW9X/Rnl5TydabsD1TmPF0tj94dhrK3igB8uuLD+tYe4i4B4F9L9fw/bOy2lCd1yIhNbRoxIh
	+man5+UtE0xlM=
X-Received: by 2002:a05:6214:d6b:b0:8eb:103:c343 with SMTP id 6a1803df08f44-8eb0103c985mr122826416d6.10.1782710704571;
        Sun, 28 Jun 2026 22:25:04 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f015805sm297881116d6.1.2026.06.28.22.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 22:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 01:25:03 -0400
Message-Id: <DJLA7B56ET76.M6YCMTTMHXCZ@etsalapatis.com>
Subject: Re: [PATCH bpf-next] bpf: reject BPF_MAP_TYPE_INODE_STORAGE
 creation if BPF LSM is uninitialized
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Matt Bobrowski" <mattbobrowski@google.com>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Paul Moore" <paul@paul-moore.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "oxsignal" <awo@kakao.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260628201103.3624525-1-mattbobrowski@google.com>
In-Reply-To: <20260628201103.3624525-1-mattbobrowski@google.com>

On Sun Jun 28, 2026 at 4:11 PM EDT, Matt Bobrowski wrote:
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

It makes sense for since the only users of inode-local storage are
related to LSM (case in point, this whole bug is due to storing the
storage map in the inode's ->security in the first place).

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
> =20
>  #ifdef CONFIG_BPF_LSM
> =20
> +extern bool bpf_lsm_initialized __ro_after_init;
> +
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>  	RET bpf_lsm_##NAME(__VA_ARGS__);
>  #include <linux/lsm_hook_defs.h>
> @@ -56,6 +58,8 @@ bool bpf_lsm_hook_returns_errno(u32 btf_id);
> =20
>  #else /* !CONFIG_BPF_LSM */
> =20
> +#define bpf_lsm_initialized false
> +
>  static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
>  {
>  	return false;
> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storag=
e.c
> index 0da8d923e39d..f9e81060c1f4 100644
> --- a/kernel/bpf/bpf_inode_storage.c
> +++ b/kernel/bpf/bpf_inode_storage.c
> @@ -178,6 +178,15 @@ static int notsupp_get_next_key(struct bpf_map *map,=
 void *key,
> =20
>  static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
>  {
> +	/*
> +	 * Do not allow allocation of BPF_MAP_TYPE_INODE_STORAGE if the BPF LSM
> +	 * was not initialized by the LSM framework at boot. Without proper
> +	 * initialization, the BPF inode security blob offset remains unprepare=
d,
> +	 * causing bpf_inode() to calculate an invalid memory offset and corrup=
t
> +	 * inode->i_security.
> +	 */
> +	if (!bpf_lsm_initialized)
> +		return ERR_PTR(-EOPNOTSUPP);
>  	return bpf_local_storage_map_alloc(attr, &inode_cache);
>  }
> =20
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index 40efde233f3a..7b98f5d1e2be 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -7,6 +7,8 @@
>  #include <linux/bpf_lsm.h>
>  #include <uapi/linux/lsm.h>
> =20
> +bool bpf_lsm_initialized __ro_after_init;
> +
>  static struct security_hook_list bpf_lsm_hooks[] __ro_after_init =3D {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>  	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
> @@ -24,6 +26,7 @@ static int __init bpf_lsm_init(void)
>  {
>  	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
>  			   &bpf_lsmid);
> +	bpf_lsm_initialized =3D true;
>  	pr_info("LSM support for eBPF active\n");
>  	return 0;
>  }

