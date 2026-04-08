Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C883BD251
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649236; cv=none; b=oaJL0ymVuEPZimcmGnZUBRKMp7aGZpXP7GH0TgvI2P+ZC5vAA1agHnettFr8v6TQwG+9IsFM5v+wBUApEGPLIS6c8t7BFMLN/ZYNgoB5hbGzEED81tfwQzVAjs/6063a1pm8cWL/LaLA9h5Yj044Qa/XrWJJk2cq3ZP04z1MUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649236; c=relaxed/simple;
	bh=CQsEQLH5qHG/lDul0Ae9yEArVvaia1RSyItQdsB9NQo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giYx5FmJp1Fz8dPufni0XT3dBikPX0EqR78xwqqmNMwjs1irjKVEt4PX4BRjAYNPplMKJ6M9BEOnYrPF3vnxeRZUgCRN86KvvAgLPn6lOtvRsP0gr3D2ZDllgSeElirdsEiwPQiVrbPHlLuzOcGCSvbgn49+rvdCJkaefrieDEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0YZFuU2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0YZFuU2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso80466995e9.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 04:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649233; x=1776254033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xXZDiwhCdmWkvrYCnBqaU49r/zBTU6QoX8sbEdHAVw=;
        b=h0YZFuU2afwtVIIun2a1r0QFrohwkDJj/RR65XsrlT2CxpWT3noOss7+wJPyhR8Cl8
         kdBkQEbIJejbiKKMVUezo5LLKy1CVMmHnkWUTIBHAUruf7g1RtpT/1e4mKZUJIqvhHsK
         t9yn3UDauM1YXMDbgHVIe/GI7xV61p0wGol3cv6E3gl+xhA3JQzJYopM5J0FEcQPz7ib
         TD8YvfCngt1v1NWOUBCIIOeqKx7246yUk/GJf+D+dQCZdadSl9Ns20DL4iVsPt4+h6sQ
         aeb1RQxjrSUoYfBRQt+GZF5lC9MKCi3hFah0dbs0hNRrQtGZM6TQwT22FVIjrZazCH4Y
         plIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649233; x=1776254033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xXZDiwhCdmWkvrYCnBqaU49r/zBTU6QoX8sbEdHAVw=;
        b=lfQmAJ8NfJhG0xzwJOcD7ywFeq6u5AnUVqT7wuJdinkcz6E7dsv38VrpDSRGvJRtsm
         2ZzXBz4nyTIPaKvgVKh49zBk2xvmoapaZsWmgZ5N5keLkuqeCq5aTL1DeDh3ww2mY/x3
         CziYDgSMi0hhtN90ic9tK8Kk9Nd7CpFevc2+/3LX5E3STJ+foANdGn4d1KnJ3spMgiBM
         yJAZrffDDR/b4BW3diAz18Mc45q2BTUUmstC2Ri/LnBXZJRp5FKjId6O7lni8KlH9vog
         v2sfUh9EvtT31jDGfpowrx77Ben6mtdOEF8hTnDyoK8GwSfbmQgyAZA1GZ38G0nRL+vL
         Kinw==
X-Forwarded-Encrypted: i=1; AJvYcCVeudb4ITG0Qn0dsgwZvYKrB9zOw5b813XVh2sP8w3cIm7DWA1uipVQK5KmRwaYEz0G84w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAQvV1Yon25gynK+PxDBCc/og115TjNG8NJcJfrQ7U+v+BLdd
	w+YL9mIcr8F9F+vWkzsgA4CmIxA9HkI7E7AEzayypRxItbnLaMHpVj3a
X-Gm-Gg: AeBDievvxFH0bITr5sTp/MDWl+J3bQrTS8ME+VkKt6sS7ee06uAfn14yKMZj0UxJsHC
	SG+PmMbG+APhL/k/tJoGU9D2iYn2FBuhsjib5MefsUHx+JQoPxaLPUwyQs/ouw9Bo29pgdZWhyc
	LOrDdIPD4NDPMRmOfGtF03/PSPdTaEAYZfnN+Ps1oPikmhHCReXZUYvg8fHSpGdlXGn7d9uALLt
	69eJRXsqk1o2nLXL8DTPMMw3VZhbpIO1yA9SmAFlOBU19RupBahy8fO0UZagAreMV/HPRSJiagN
	091lJftUCQag2CK3bZEwq7TFGT9j5Z3UmW8wJMnfBNgZGh61l+qO4JKPhoWjiE3573jhgf2YPi0
	M0zQN7rP3jTyDqoYQStjaC8ix0m1fedRIK8RpyXQXYXvlGDEKG021cVW7+yFsrEGtACPMUzhb
X-Received: by 2002:a05:6000:4201:b0:43c:fed2:bb72 with SMTP id ffacd0b85a97d-43d29294691mr28353175f8f.19.1775649232561;
        Wed, 08 Apr 2026 04:53:52 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e1fe0b0sm59500777f8f.0.2026.04.08.04.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 04:53:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 8 Apr 2026 13:53:50 +0200
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, mattbobrowski@google.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Fix Null-Pointer Dereference in kernel_clone()
 via BPF fmod_ret on security_task_alloc
Message-ID: <adZBzjB8bcX344LY@krava>
References: <20260408094816.228322-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408094816.228322-1-yangfeng59949@163.com>

On Wed, Apr 08, 2026 at 05:48:16PM +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Using the following BPF program will cause a kernel panic:
> SEC("fmod_ret/security_task_alloc")
> int fmod_task_alloc(void *ctx)
> {
>         return 1;
> }
> 
> [  383.899321] BUG: kernel NULL pointer dereference, address: 0000000000000b99
> [  383.899327] #PF: supervisor read access in kernel mode
> [  383.899330] #PF: error_code(0x0000) - not-present page
> [  383.899332] PGD 8000000108a60067 P4D 8000000108a60067 PUD 104550067 PMD 0
> [  383.899341] Oops: Oops: 0000 [#1] SMP PTI
> [  383.899346] CPU: 1 UID: 0 PID: 12925 Comm: test Kdump: loaded Not tainted 7.0.0-rc6+ #1 PREEMPT(lazy)
> [  383.899349] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [  383.899351] RIP: 0010:get_task_pid+0x20/0x80
> [  383.899358] Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 55 89 f5 53 48 89 fb e8 0b 98 0a 00 85 ed 75 32 48 81 c3 98 0b 00 00 <48> 8b 1b 48 85 db 74 14 b8 01 00 00 00 f0 0f c1 03 85 c0 74 27 8d
> [  383.899362] RSP: 0018:ffffd3ca0ab13b38 EFLAGS: 00010206
> [  383.899367] RAX: 0000000000000001 RBX: 0000000000000b99 RCX: 0000000000000008
> [  383.899371] RDX: ffff8b2c85860000 RSI: 0000000000000000 RDI: 0000000000000001
> [  383.899374] RBP: 0000000000000000 R08: 0000010754cf50c8 R09: 0000010754cf50c8
> [  383.899377] R10: ffffffff95a6c000 R11: 0000000000000024 R12: 0000000000000000
> [  383.899380] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000001200000
> [  383.899384] FS:  00007f3eae907740(0000) GS:ffff8b2d05e5c000(0000) knlGS:0000000000000000
> [  383.899388] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  383.899390] CR2: 0000000000000b99 CR3: 0000000106a94003 CR4: 00000000000706f0
> [  383.899393] Call Trace:
> [  383.899397]  <TASK>
> [  383.899401]  kernel_clone+0xe8/0x480
> [  383.899406]  __do_sys_clone+0x65/0x90
> [  383.899410]  do_syscall_64+0xca/0x860
> [  383.899421]  ? next_uptodate_folio+0x85/0x2a0
> [  383.899427]  ? percpu_counter_add_batch+0x4c/0x90
> [  383.899434]  ? filemap_map_pages+0x3b7/0x4d0
> [  383.899437]  ? do_read_fault+0x107/0x210
> [  383.899442]  ? do_fault+0x1b2/0x330
> [  383.899445]  ? __handle_mm_fault+0x49b/0x7a0
> [  383.899448]  ? count_memcg_events+0xc4/0x160
> [  383.899453]  ? handle_mm_fault+0xbb/0x370
> [  383.899456]  ? do_user_addr_fault+0x209/0x680
> [  383.899459]  ? irqentry_exit+0x7a/0x660
> [  383.899462]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  383.899466] RIP: 0033:0x7f3eaeb426e7
> [  383.899470] Code: 5d c3 90 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 39 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
> [  383.899472] RSP: 002b:00007fff23a2c838 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> [  383.899477] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3eaeb426e7
> [  383.899479] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> [  383.899481] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [  383.899483] R10: 00007f3eae907a10 R11: 0000000000000246 R12: 0000000000000001
> [  383.899485] R13: 00007fff23a2dbe8 R14: 0000000000403de0 R15: 00007f3eaecf5000
> [  383.899488]  </TASK>
> [  383.899489] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set rfkill nf_tables sunrpc intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core pmt_telemetry snd_intel8x0 pmt_discovery pmt_class snd_ac97_codec intel_pmc_ssram_telemetry ac97_bus intel_vsec snd_pcm snd_timer snd rapl soundcore joydev sg i2c_piix4 pcspkr vboxguest i2c_smbus nfnetlink sr_mod cdrom sd_mod ata_generic vmwgfx ahci libahci ata_piix drm_ttm_helper ghash_clmulni_intel video ttm e1000 wmi libata serio_raw dm_mirror dm_region_hash dm_log dm_multipath dm_mod fuse i2c_dev autofs4
> [  383.899624] CR2: 0000000000000b99
> 
> This is because
> 1. The BPF program is designed to override the normal behavior of
> `security_task_alloc` and forcibly return a non-zero error value (e.g.,
> `-ENOMEM` or `1`).
> 2. User space triggers a process creation syscall (like `fork` or
> `clone`). The kernel invokes `copy_process` to allocate and initialize a
> new `task_struct` for the child process.
> 3. `copy_process` invokes `security_task_alloc`. Due to the attached BPF
> program, it returns the positive value `1`.
> 4. `copy_process` treats any non-zero return from `security_task_alloc`
> as a failure. It aborts initialization, cleans up, and returns the error
> code cast to a pointer via `ERR_PTR(1)` (which evaluates to the memory
> address `0x1`).
> 5. In `kernel_clone()`, the kernel uses the `IS_ERR()` macro to check if
> the returned `task_struct *p` is an error pointer. However, `IS_ERR()`
> only checks for negative error codes in the range `[-MAX_ERRNO, -1]`.
> Since `0x1` is not in this range, the check `IS_ERR(p)` evaluates to
> `false`.
> 6. The kernel incorrectly assumes `p` is a valid `task_struct` pointer
> and proceeds to call `get_task_pid(p, PIDTYPE_PID)`. This dereferences
> the invalid address `0x1` (plus the offset of the `thread_pid` field),
> triggering a general protection fault or null-pointer dereference.
> 
> Currently, fmod_ret does not validate return values.
> Such validation should be similar to that of BPF_LSM,
> so we implement the same changes by referencing `bpf_lsm_get_retval_range` to fix this issue.
> 
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/973a1b7b-8ee7-407a-890a-11455d9cc5bf@std.uestc.edu.cn/
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  include/linux/bpf_lsm.h |  8 ++++++++
>  kernel/bpf/bpf_lsm.c    | 26 ++++++++++++++++++++++++++
>  kernel/bpf/verifier.c   |  4 +++-
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 643809cc78c3..434ae335b188 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -48,6 +48,8 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
>  
>  int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>  			     struct bpf_retval_range *range);
> +void bpf_security_get_retval_range(const struct bpf_prog *prog,
> +				   struct bpf_retval_range *range);
>  int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
>  				const struct bpf_dynptr *value_p, int flags);
>  int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
> @@ -91,6 +93,12 @@ static inline int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline void bpf_security_get_retval_range(const struct bpf_prog *prog,
> +						 struct bpf_retval_range *range)
> +{
> +}
> +
>  static inline int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
>  					      const struct bpf_dynptr *value_p, int flags)
>  {
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index c5c925f00202..537af87b3d5d 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -448,3 +448,29 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>  	}
>  	return 0;
>  }
> +
> +/* hooks return 0 or 1 */
> +BTF_SET_START(bool_security_hooks)
> +#ifdef CONFIG_SECURITY_NETWORK_XFRM
> +BTF_ID(func, security_xfrm_state_pol_flow_match)
> +#endif
> +#ifdef CONFIG_AUDIT
> +BTF_ID(func, security_audit_rule_known)
> +#endif
> +BTF_ID(func, security_inode_xattr_skipcap)
> +BTF_SET_END(bool_security_hooks)
> +
> +/* Similar to bpf_lsm_get_retval_range,
> + * ensure that the return values of fmod_ret are valid.
> + */
> +void bpf_security_get_retval_range(const struct bpf_prog *prog,
> +				   struct bpf_retval_range *retval_range)
> +{
> +	if (btf_id_set_contains(&bool_security_hooks, prog->aux->attach_btf_id)) {
> +		retval_range->minval = 0;
> +		retval_range->maxval = 1;
> +	} else {
> +		retval_range->minval = -MAX_ERRNO;
> +		retval_range->maxval = 0;
> +	}
> +}

ai has a point that fmod_ret can attach to other than security functions 

https://sashiko.dev/#/patchset/20260408094816.228322-1-yangfeng59949%40163.com

most of them seem to return errno (ERRNO), but there's also few with
'TRUE' and one with 'NULL' ..  we could check if the function is on
the injection list and check the return value accordingly?

jirka


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 594260c1f382..3bfc67983e12 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18413,8 +18413,10 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
>  			*range = retval_range(0, 0);
>  			break;
>  		case BPF_TRACE_RAW_TP:
> -		case BPF_MODIFY_RETURN:
>  			return false;
> +		case BPF_MODIFY_RETURN:
> +			bpf_security_get_retval_range(env->prog, range);
> +			break;
>  		case BPF_TRACE_ITER:
>  		default:
>  			break;
> -- 
> 2.27.0
> 
