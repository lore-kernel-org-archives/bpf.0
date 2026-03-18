Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFDA1C3BF7
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801284; cv=none; b=ucnU6CLBdxYbQGdbkj1XSSn4WWc9FY9nE41zKwyScw/60SlkvDz0db0T+TZ85BaxKixW4xJcZk2Z+pgG81NUgcMBO0DMS7Azvfnz6nxFZ2vYA0glB1aM5suWTnQwkVs25y37knOD1BpINZBS6dbuq3trfa801WWalo2I9kOYx1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801284; c=relaxed/simple;
	bh=zV69aMcXOvSADKKZTxljW4C4LLz49Wh88XkWyg8RkR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psQ8RvddFldaLbLQe26IKu07wFcDFfaMp81nSVaWikpc1p5Trity6UFVqnn3HNPR6zuTo0w+j8sr2iELAVME+2WGzBi5Z7jy2QuSygngvZeiiPyg2PD/nlWwCJ75ZwXI6UDrpd0HiWpJ3GeIclppIDlAMCqQihNqJM8QtktL5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ruzUnl/K; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ruzUnl/K"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773801280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWz8CXgS1+7ltcO6zUqBfIhOoKRgeQeJA/7r7XG9R28=;
	b=ruzUnl/KJ9SLyBAwp7clj5eCNwe1UTeYSOXjeVsVPBbkt8iU8kpRUU0mG5JBVelgpbd1kf
	aCivIT8PD0y2yLyZY0KSy6F6ZFqt3c5RGAUkqeyNlmcCaUMGFtuxv8wx32CgRkXfb3D5Aa
	CDiySzadMuooz1diH0IPux4Ss29ngrY=
From: Menglong Dong <menglong.dong@linux.dev>
To: Ibrahim Zein <zeroxjacks@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 gregkh@linuxfoundation.org, jolsa@kernel.org, kpsingh@kernel.org,
 haoluo@google.com, john.fastabend@gmail.com, sdf@fomichev.me,
 martin.lau@linux.dev, andrii@kernel.org, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, shung-hsi.yu@suse.com,
 menglong8.dong@gmail.com, Ibrahim Zein <zeroxjacks@gmail.com>
Subject:
 Re: [PATCH bpf-next v3] bpf: verifier: fix integer wrap in
 regs_refine_cond_op() BPF_JNE case
Date: Wed, 18 Mar 2026 10:34:23 +0800
Message-ID: <4719858.LvFx2qVVIh@7940hx>
In-Reply-To: <20260318004118.1780755-1-ZeroXJacks@gmail.com>
References: <20260318004118.1780755-1-ZeroXJacks@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/3/18 08:41 Ibrahim Zein <zeroxjacks@gmail.com> write:
> From: Ibrahim Zein <zeroxjacks@gmail.com>
> 
> In regs_refine_cond_op(), the BPF_JNE case narrows register bounds
> without guarding against wrap-around at type boundaries. When
> umin_value equals U64_MAX, incrementing it wraps to 0, producing
> an inconsistent bounds state (umin=0, umax=U64_MAX-1).
> 
> This can be triggered by constructing a register state where:
>   r1 = unknown_byte | 0xFFFFFFFFFFFFFFFE
>   -> var_off = (value=U64_MAX-1, mask=1)
>   -> constrain with JGE U64_MAX -> umin=umax=U64_MAX, tnum non-const
>   -> compare with BPF_JNE const=U64_MAX -> wrap occurs
> 
> The comment above these checks incorrectly claims this boundary
> condition is impossible. However, is_reg_const() uses tnum_is_const()
> which requires mask == 0, so a register can have umin == umax while
> tnum is non-const (mask != 0). Remove the misleading comment and add
> explicit boundary guards to prevent wrap-around in all
> {u,s}{min,max}{32,64} variants.

Hi, Ibrahim. As Alexei said, your patch is incorrect, and you should
generate it with:
    git format-patch --subject-prefix="PATCH bpf-next" -1

How did you find this issue? By AI? I ask this because I don't think
this is a issue that can be triggered. As you said, the key problem
is that r1 is "umin=umax=U64_MAX, tnum non-const", so it's a
known value. Therefore, the return value of is_branch_taken()
should always be 0 or 1 in check_cond_jmp_op, as r2 is a const in this
case. Then, reg_set_min_max() won't be called, as we don't need to
adjust the min/max for a known register. Right?

Thanks!
Menglong Dong

> 
> Fixes: d028f87517d6 ("bpf: make the verifier tracks the "not equal" for regs")
> Reported-by: Ibrahim Zein <zeroxjacks@gmail.com>
> Signed-off-by: Ibrahim Zein <zeroxjacks@gmail.com>
> ---
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17046,31 +17046,30 @@
>  		 */
>  		val = reg_const_value(reg2, is_jmp32);
>  		if (is_jmp32) {
> -			/* u32_min_value is not equal to 0xffffffff at this point,
> -			 * because otherwise u32_max_value is 0xffffffff as well,
> -			 * in such a case both reg1 and reg2 would be constants,
> -			 * jump would be predicted and reg_set_min_max() won't
> -			 * be called.
> -			 *
> -			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
> -			 * below.
> -			 */
> -			if (reg1->u32_min_value == (u32)val)
> +			if (reg1->u32_min_value == (u32)val &&
> +			    reg1->u32_min_value != U32_MAX)
>  				reg1->u32_min_value++;
> -			if (reg1->u32_max_value == (u32)val)
> +			if (reg1->u32_max_value == (u32)val &&
> +			    reg1->u32_max_value != 0)
>  				reg1->u32_max_value--;
> -			if (reg1->s32_min_value == (s32)val)
> +			if (reg1->s32_min_value == (s32)val &&
> +			    reg1->s32_min_value != S32_MAX)
>  				reg1->s32_min_value++;
> -			if (reg1->s32_max_value == (s32)val)
> +			if (reg1->s32_max_value == (s32)val &&
> +			    reg1->s32_max_value != S32_MIN)
>  				reg1->s32_max_value--;
>  		} else {
> -			if (reg1->umin_value == (u64)val)
> +			if (reg1->umin_value == (u64)val &&
> +			    reg1->umin_value != U64_MAX)
>  				reg1->umin_value++;
> -			if (reg1->umax_value == (u64)val)
> +			if (reg1->umax_value == (u64)val &&
> +			    reg1->umax_value != 0)
>  				reg1->umax_value--;
> -			if (reg1->smin_value == (s64)val)
> +			if (reg1->smin_value == (s64)val &&
> +			    reg1->smin_value != S64_MAX)
>  				reg1->smin_value++;
> -			if (reg1->smax_value == (s64)val)
> +			if (reg1->smax_value == (s64)val &&
> +			    reg1->smax_value != S64_MIN)
>  				reg1->smax_value--;
>  		}
>  		break;
> 
> 




