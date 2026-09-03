Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5164CC27F;
	Thu,  3 Sep 2026 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448706; cv=none; b=TpkrNics8lUrIB5ENKE9dJLCabKH5EFHTBIVnKTmJ8Xhio5bs9u5A0NBvGm4/7L06wpCSvfdb7Fb6Fruldr5QqnB+kTZYYTHh9shWJaHBTpbxvqWZJUTpSznVBal/+LuosR7xdG9qOd9IxCk5wanjtoJFwfFCQnPuNgr1YXd6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448706; c=relaxed/simple;
	bh=bEKtXx9OUqjEwVwEzohBdmrLiazRn3QxjMQ31hyxE5Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MtMYt0ahRXFRdNzXt5eTSueT+WHx4pKS9zbazUZbHw2hOnEwBENFL8822VnUwZ+AnUq3fJc03QRESuEJyCGzR8q5q1Xz4dHYuAxqiIFbOFm8N5Ki2NY2mMJPk8hsZ56S1sVQmQ74XDJE3NTaWGerjbqaCKPFXvLKvjFZXDJSYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgOW64sT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgOW64sT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892AF1F00A3A;
	Thu,  3 Sep 2026 15:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788448705;
	bh=Zz5JeZMZtEinzF7vyEFYOf9R0LKpZtqames5Z5JRqWo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JgOW64sTBX4Chma/cINgsPQph2eiA7lRXjABeD+Dk8AaqIjmmTUO5+NCHckKodxik
	 CwDV5l4IASJScAPHlA3KzdOVZr0mtbJ/zJiYhEA5V7JNz37NjrJjqB+CAwXk3d1TVo
	 9Z5px9+3MdFfGCBs8a+fWk1ZOIYB4NLW8CzFudxo3plPYn0cPpYWRLxE7ukzMeHPuK
	 sXHy6+JupFIIVWqTAfsgJqvnskue7QwZzzPSmrGTeolHusDay1r6xhzp8pUT2Zqjv3
	 bwbroUUH5qZ14y0y6QrSRCCdSXwXKYHuKpya7fIlva1neRgxEFrVNb1XV5MpcHkUY5
	 vh03mTMJ8T01g==
Content-Type: multipart/mixed; boundary="===============6975600420986325753=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a7574349d8f15510aea8acfcd95bee2b5fc18c3bf6c27ac9362f0090011b6c17@mail.kernel.org>
In-Reply-To: <20260903-kasan-v9-1-2407fe99255a@bootlin.com>
References: <20260903-kasan-v9-1-2407fe99255a@bootlin.com>
Subject: Re: [PATCH bpf-next v9 1/8] bpf: mark instructions accessing program stack
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,tglx@kernel.org,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mingo@redhat.com,andreyknvl@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,laoar.shao@gmail.com
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 15:18:23 +0000 (UTC)

--===============6975600420986325753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 65b441e4a3517..73fb3ffc18e33 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -213,7 +213,8 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
>   * [0, off) and [off, end) to new locations, so the patched range stays zero
>   */
>  static void adjust_insn_aux_data(struct bpf_verifier_env *env,
> -				 struct bpf_prog *new_prog, u32 off, u32 cnt)
> +				 struct bpf_prog *new_prog, u32 off, u32 cnt,
> +				 struct bpf_insn *original_insn)
>  {
>  	struct bpf_insn_aux_data *data = env->insn_aux_data;
>  	struct bpf_insn *insn = new_prog->insnsi;
> @@ -227,8 +228,15 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
>  	 */
>  	data[off].zext_dst = bpf_insn_def32(new_prog, insn + off + cnt - 1) >= 0;
>
> -	if (cnt == 1)
> +	if (cnt == 1) {
> +		/*
> +		 * A non-memory accessing insn could have been replaced by a
> +		 * memory accessing insn, systematically mark it for non-stack
> +		 * access
> +		 */
> +		data[off].non_stack_access = bpf_is_mem_insn(insn + off);
>  		return;
> +	}

This isn't a bug, but does the comment explain why the marking needs to be
unconditionally reset here? The statement is an assignment that both sets
and clears the flag depending on the result, but the comment only mentions
the setting direction.

>  	prog_len = new_prog->len;
>  	env->insn_aux_data_len = prog_len;
>
> @@ -239,8 +247,25 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
>  		/* Expand insni[off]'s seen count to the patched range. */
>  		data[i].seen = old_seen;
>  		data[i].zext_dst = bpf_insn_def32(new_prog, insn + i) >= 0;
> +		if (!memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
> +			data[i].non_stack_access =
> +				data[off + cnt - 1].non_stack_access;
> +			data[off + cnt - 1].non_stack_access = false;
> +		} else if (bpf_is_mem_insn(insn + i)) {
> +			data[i].non_stack_access = true;
> +		}

This isn't a bug, but could off + cnt - 1 be hoisted into a local here?
It appears eight times in this function now, and the two-line wrapped
assignment above exists only because the index expression is long.

>  	}
>
> +	/*
> +	 * Last slot instruction could be a newly generated
> +	 * BPF_ST/BPF_LDX/BPF_STX, systematically mark it for non-stack access
> +	 * if it is not the original instruction, otherwise keep the
> +	 * original marking
> +	 */
> +	if (bpf_is_mem_insn(insn + off + cnt - 1) &&
> +	    memcmp(insn + off + cnt - 1, original_insn, sizeof(struct bpf_insn)))
> +		data[off + cnt - 1].non_stack_access = true;

This isn't a bug, but does this comment add information beyond the if
condition below it? The comment reads as a prose transcription of the
conditional.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33766012402
--===============6975600420986325753==--
