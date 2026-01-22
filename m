Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6C035D60F;
	Thu, 22 Jan 2026 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102431; cv=none; b=tDQJyQJFyr5T45PIDZao+N+WF3XU+yv7i7pMgc2YAg2TCrT1OK1xs3spCAWo2HJNUx96KDCojLdsGY8vMolRQv19mBcB2UOJzEvJiifaqwA+uIKnSJN3hnZrkpiH4YeZCaOOPluCKmTw+yZQaVgBE5ej0oCQniTY+JyDWdI9+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102431; c=relaxed/simple;
	bh=R+AGZOzKvwQpWoujXGlEYoRGINMghLh8EMK9qhENUb0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jRR96waQ6Qf4YntlgiyxQaG5cnRiOW0HenkMfUvDA3Tf2aXb3WomILrALQLluJx2FiMS43B20TiG+z6cYuxD1yPCHV7M1IpEwVOdwbEx2U8wpRP2oHqvPFvaVT3rLfBqdYTuN5QQRkPCC7Z5wF0lIJOXDc19wtwroV9yn/bO0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOrQwU6g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOrQwU6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371E5C19422;
	Thu, 22 Jan 2026 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769102430;
	bh=R+AGZOzKvwQpWoujXGlEYoRGINMghLh8EMK9qhENUb0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fOrQwU6g/8TPH/MEIGQUiwAk8+YsdtosCaHYpgbU6ewCVffXDBX+ef6F2o3ov/cX7
	 PINGn1QOi+UNjqGhY7olv8XWiiLEVwLtjfoff9u6l7pq7pKmSorFReBz28iHW028Dp
	 QelHEjqmUMtHJ8yRJHkbbuZccnL5qSoVrB+6NeC+tt++YoVaLh5WW42v01UYPMN6PB
	 BF2eVS7Y7/DOjqjLzuBrxO6PAJbmFlcqlo3r3HE7zqGs7r6Jg2h2SP9zG3h1UVY/wG
	 gs+bRON15SCQMHgMBd19XSxDja5BQwPbMgyoDBm0ioNUo8AbZJcXiUD3QH0zDGj0bp
	 wMxd6AmsV7ZRw==
Content-Type: multipart/mixed; boundary="===============1735738550655913399=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <55608f784fe006db8781a09b89717c4e80c5005b4d451e7e22bb95b956f8296e@mail.kernel.org>
In-Reply-To: <20260122165716.10508-2-adubey@linux.ibm.com>
References: <20260122165716.10508-2-adubey@linux.ibm.com>
Subject: Re: [PATCH v3 1/6] powerpc64/bpf : Moving tail_call_cnt to bottom of frame
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com,sachinpb@linux.ibm.com,venkat88@linux.ibm.com,andrii@kernel.org,eddyz87@gmail.com,mykolal@fb.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,christophe.leroy@csgroup.eu,naveen@kernel.org,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,memxor@gmail.com,iii@linux.ibm.com,shuah@kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 22 Jan 2026 17:20:30 +0000 (UTC)

--===============1735738550655913399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 8334cd667bba..9f6ec00bd02e 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -24,6 +24,7 @@
>
>  #define SZL			sizeof(unsigned long)
>  #define BPF_INSN_SAFETY		64
> +#define BPF_PPC_TAILCALL	8

[ ... ]

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 5e976730b2f5..d5757577f933 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -604,8 +604,8 @@ static void bpf_trampoline_setup_tail_call_cnt(u32 *image, struct codegen_contex
>  					       int func_frame_offset, int r4_off)
>  {
>  	if (IS_ENABLED(CONFIG_PPC64)) {
> -		/* See bpf_jit_stack_tailcallcnt() */
> -		int tailcallcnt_offset = 7 * 8;
> +		/* See Generated stack layout */
> +		int tailcallcnt_offset = BPF_PPC_TAILCALL;

Should bpf_trampoline_restore_tail_call_cnt() also be updated to use
BPF_PPC_TAILCALL?  That function still has:

    int tailcallcnt_offset = 7 * 8;

The setup function stores tail_call_cnt at offset -8 (BPF_PPC_TAILCALL),
but the restore function reads from offset -56 (7 * 8). This mismatch
would cause the restore to read from and write to incorrect stack
locations when BPF_TRAMP_F_TAIL_CALL_CTX is set.

I note that commit b18ae1c3dadf ("powerpc64/bpf: Avoid tailcall restore
from trampoline") later in this series removes the PPC64 path from
bpf_trampoline_restore_tail_call_cnt(), which would resolve this. However,
intermediate commits between this patch and that fix could have broken
tail call counting in trampolines if bisected to.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21257691486

--===============1735738550655913399==--
