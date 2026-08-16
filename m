Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E1432ED24
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 02:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786848341; cv=none; b=Bd502ym9eCh3kU4AzFedw3BtS6+W+PYZOeQiFEX/OUFWfKTKlrvGIKVMGUTzZBY2pSTJRkrxjOG7kH5/xGCbS5A21kWzJFAo3I6QYJNkogVWs2+etJVTNMPdpxUuF5i2dfhThjhnNCh8yH35ZVYnxR2/Dwofw1+9z6ESLZQkEfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786848341; c=relaxed/simple;
	bh=/oF5hiyrldQMatUt1gdzKVrDIKaIL2WHyuOyElhJ82c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JFeuarnH0q1vW85jHKJF0+DSdP4msJG3r36p154y6tZF1Yh2UscEBVF6Un6qZ6OvXYIpEb9hN8gAZRuNWFQmvn4FEsec0v01BEV4ZMD+bK4gKD5H8v2iRS8/V/xFAuFh/rNvdGeH0TJkPMC8vnfeGknuxLh4EA+2iSlEvVWwIgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er2CwSEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er2CwSEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681B41F000E9;
	Sun, 16 Aug 2026 02:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786848340;
	bh=EWBCYejvfPr4RHkdLAIKOCpGUpbni9xpG80Xy2uLivs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Er2CwSEJ/hCYZXU+ArrXLkGBXHn2JWgwuWEp+fxDd+sdraBx9UJztrwPNIvMzOHAe
	 9lCA6lVbaNPh/3/WL86VHzAoe8GeEkTAGcJZgmBt187/Spo+aFFH+va47QxnoktvlS
	 7TldacLWM0WVWB/x+OQbCrcVvP15u/MOHXyZuGyBLox6Oet8ouGVHg5tyqBjM+fBYc
	 yT6B98QRJKMnEG1RxXcFOk/pPFKjq7zbZumeOnYxF8lM5mh60ZlQULNfUaJgwTS829
	 M3xQYSjrXyuv/7BOkiP1SYRn3RcPKJNZnygkOYEvIae41GKe3Var3w9AE4sas6fvt6
	 z+DJwB6GwwPIg==
Content-Type: multipart/mixed; boundary="===============3411331124248842310=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bc71b9e364a0d43c49d26f9547a1e757e8a6a38e1c378a6fbea21aa8835dc31d@mail.kernel.org>
In-Reply-To: <20260816015746.2632990-7-memxor@gmail.com>
References: <20260816015746.2632990-7-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 06/14] bpf: Correct kfunc argument diagnostics
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 16 Aug 2026 02:45:39 +0000 (UTC)

--===============3411331124248842310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git kernel/bpf/verifier.c kernel/bpf/verifier.c
> index 7ef324e384f4..da2ec0655b17 100644
> --- kernel/bpf/verifier.c
> +++ kernel/bpf/verifier.c

[ ... ]

> @@ -12653,12 +12653,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>  		    !type_may_be_null(kf_arg_type)) {
>  			const char *expected_type;
>
> -			expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
> +			expected_type = bpf_diag_fmt_btf_type(env, btf, args[i].type);
>  			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
>  				reg_arg_name(env, argno));
>  			bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
>  					      "Add a NULL check and call the kfunc only on the non-NULL path.",
> -					      "the pointer may be NULL, but this kfunc requires a non-NULL pointer to %s",
> +					      "the pointer may be NULL, but this kfunc requires a non-NULL value of type %s",
>  					      expected_type);
>  			return -EACCES;
>  		}

Switching from ref_id to args[i].type renders function pointer
parameters incorrectly. For kfuncs like bpf_task_work_schedule_signal()
that take a bpf_task_work_callback_t (which is itself a typedef to a
function pointer), btf_show_name() walks TYPEDEF -> PTR -> FUNC_PROTO,
collects the typedef name and adds one level of pointer indirection,
producing "bpf_task_work_callback_t *" instead of the correct parameter
type "bpf_task_work_callback_t".

For kfuncs like bpf_wq_set_callback() that take an unnamed function
pointer directly (PTR -> FUNC_PROTO), the FUNC_PROTO has no name, so
btf_show_name() produces the malformed "( *)".

Would it make sense to restrict the args[i].type formatting to object
pointers, or teach btf_show_name() not to add "*" for pointer typedefs
and unnamed FUNC_PROTO types? The other ref_id call sites later in the
same loop still use the pointee id, so the two conventions now coexist.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31921026518
--===============3411331124248842310==--
