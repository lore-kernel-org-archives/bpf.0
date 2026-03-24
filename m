Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96163A3810;
	Tue, 24 Mar 2026 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379375; cv=none; b=rk7tJij4kPeXWR1HFM381AukPVJal/txEUJbL8uewz+ydS6YOoTIUpromyRrlQDkcB5YffEqulyelWnKf36cp6BG9s1BvwI28lUG1G27ZoWiRNTCdMs/r/LtxXnEjYFvnlQHptdaKUZ46yvbNb3APhMN3//5cgIAeP/D8rOA+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379375; c=relaxed/simple;
	bh=HvDIKDZOlydf2prVH96BDaY5a3aikgF0T0HQ0Bo2uMY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RqHX+UHUuqeCoQwI0N3fHsU4mtmN7fU8P++ytaRF3IqXYzR6+njdy15OEDw2LmLLGT3bLVU0XXkpnPDfNRVQLV800OVIfG8blQxmrZMXXPZN90m/k96FRJnCnmBV+VgA3WYBWiwzzajFM+cbssZmfmPCdrDNK7Z5CnRj3jJ7euM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzByaaAZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzByaaAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50EDC19424;
	Tue, 24 Mar 2026 19:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774379374;
	bh=HvDIKDZOlydf2prVH96BDaY5a3aikgF0T0HQ0Bo2uMY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NzByaaAZkngMGpcw6UZTzZ+zLVHWO74+K6pKWy+HoxZvvF7q94+4XtLo7xPb4y7I4
	 xulj7eZ0o3Yjhx7oxsHaK90nj/nxqkzcpM7YsNRKTqfOab93/UrxUVHRnJqBh9sLht
	 YG4qlK/9A0/swVMBu3vd+zn7jMN3QTepVamyblvVNyb1oflQeb1I5iy6RyMAlPLz1/
	 1OI8IgREXA55oxhw87AFMSFH4u/uC171lxZ9sqnXogIKLAD3sYziAXuPYBl+1oSZWt
	 F/ZXeUYtBECVSgMsTZ3d40TnEVxQ/KTJ8HH2dbAOk8V6gQf4ZA7le08BuMlOoqLMNE
	 laXf5+AqUHKIA==
Content-Type: multipart/mixed; boundary="===============5868570892331209961=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ed36be8ab3fd8dc38efe3fe4c5846d1f315fbeef0782ab56550e279960e57ce8@mail.kernel.org>
In-Reply-To: <20260324-vmscape-bhb-v8-8-68bb524b3ab9@linux.intel.com>
References: <20260324-vmscape-bhb-v8-8-68bb524b3ab9@linux.intel.com>
Subject: Re: [PATCH v8 08/10] x86/vmscape: Deploy BHB clearing mitigation
From: bot+bpf-ci@kernel.org
To: pawan.kumar.gupta@linux.intel.com,x86@kernel.org,jon@nutanix.com,nik.borisov@suse.com,hpa@zytor.com,jpoimboe@kernel.org,david.kaplan@amd.com,seanjc@google.com,bp@alien8.de,dave.hansen@linux.intel.com,peterz@infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,jolsa@kernel.org,davem@davemloft.net,david.laight.linux@gmail.com,luto@kernel.org,tglx@kernel.org,mingo@redhat.com,dsahern@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,haoluo@google.com,pbonzini@redhat.com,corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,kvm@vger.kernel.org,asit.k.mallick@intel.com,tao1.zhang@intel.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-doc@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Mar 2026 19:09:33 +0000 (UTC)

--===============5868570892331209961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index a7dee7ec6ea39..8cacd9474fdf0 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c

[ ... ]

> @@ -3136,6 +3149,8 @@ static void __init vmscape_apply_mitigation(void)
>  {
>  	if (vmscape_mitigation == VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER)
>  		static_call_update(vmscape_predictor_flush, write_ibpb);
> +	else if (vmscape_mitigation == VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER)
> +		static_call_update(vmscape_predictor_flush, clear_bhb_loop_nofence);
>  }

When vmscape_predictor_flush is set to clear_bhb_loop_nofence, the
call site in arch_exit_to_user_mode_prepare() becomes:

    static_call_cond(vmscape_predictor_flush)();
    this_cpu_write(x86_predictor_flush_exit_to_user, false);

The comment above clear_bhb_loop_nofence() in entry_64.S says:

    Note, callers should use a speculation barrier like LFENCE
    immediately after a call to this function to ensure BHB is
    cleared before indirect branches.

Every other callsite follows this requirement, e.g. in
CLEAR_BRANCH_HISTORY and CLEAR_BRANCH_HISTORY_VMEXIT:

    call clear_bhb_loop_nofence; lfence

The previous static_call target, write_ibpb(), uses wrmsr which is
serializing and inherently acts as a speculation barrier. But
clear_bhb_loop_nofence() is just a loop that fills the BHB -- it is
not serializing.

Without an lfence after the static_call, is there a speculative
window where indirect branches could execute using stale
(guest-controlled) branch history before the BHB clear takes
architectural effect?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23506000396
--===============5868570892331209961==--
