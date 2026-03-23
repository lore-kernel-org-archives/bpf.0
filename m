Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA4282F3A
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278154; cv=none; b=QU8/48cdVxk8dQtDLQ09CgBGcxFbfNOfCwev0uLI1x7hoV7QcOburEmXpULL9SwZ5Bc2k40+xeRNaes3TDgYhOy2wqfn8wuR2A/jLPB5tsp1lDHb3CzA2lgVxRXwRNpfsx4JSl6yGX2VDqVuPbxJM1fBwlx7B/ZZOwehIE9IMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278154; c=relaxed/simple;
	bh=gXfhl9lhcywYBxJG6LkAkyEKbR9RIj3HLf5+6lrBui4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FT+AoQ3L/+17t87ub7dhecwo7aa0Ei+hvyvmeppooo39PCerUIpgblc60xUAD50CTYpscyiBlVeizvaSxZ7SzMHf2bCTGSAcmzXtW4e1sFcmPCabmIw8n3sghLxXkW2+DDxrLGNikjGWcx3I7Lx0ammKiXYs8AlJKGqMa9JBjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=iaDBMesQ; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="iaDBMesQ"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-128b9b7e3edso6787443c88.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1774278152; x=1774882952; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEZSFroYeSHdlmwBQGznjgmllYZ0IeUu7fbFA/yec+E=;
        b=iaDBMesQuyiarGSQE2enbpfk+QNnfT1Hnyz0D6aEsSPWsz+CJgdd7H9ruacN7KKV3t
         fylUVyzcqBm+/OKGNXJkYer8AEMoGwiNKGsw8T0swGAMbtVueS7U2PxCfxMuOVKlMeS4
         k/usxRDFqVNT1QEZxWq7lrooZOoH6aw3w7jTRlgkCRwqlmt8a/OED8yJ5oXrGaTaL4+R
         +eDaO8ygDy6SKHjbQt+L+uDbbrjPRA/CDPqaak84h6AIEtbo58bR+iVcwzz02IlEmCUo
         RyNSCwCYY/k6A5WmEIdb77oWGsBUhkqypp3eijGhzBXJ7jZt7gMkzwe3OoWXt4S+/FBl
         jfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774278152; x=1774882952;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEZSFroYeSHdlmwBQGznjgmllYZ0IeUu7fbFA/yec+E=;
        b=Qav0LIzlu7wvT/pCP4Egk57Y3OfrZH5kwX47+wspJHiUBz8qkjQUzAbFz4tacKKNwE
         KYqRxW3iQDQZXt8V+s4Hh7/g8cTracsVw+o9gPt6XRD5+uq/DSfRX5oAt3YGN0/mmGeL
         fu8bSEZLJFj9nFJ3w77UcEPhI+uOeUHcBF6idwABBs8Pv4/++avm9G1oEqTOO9VmKEvh
         1JP0GGxn9z9vzUwkm5N8ZLzOqlhvF/BFqeT/yEGoC8M+QqSZDT6RuRfunnkKJva26tq3
         IRmriN3nhylEsQB+dmVB7KmijznuDqKthz0oUAiHwo/CUyD7b8d95CN692xC/h2WnMjF
         Q6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDDVodE+uKRZAxvU9kMm5ZxyPynk01huKe7pgYPCfz7quyXvmg5fzlbdAX8oOvU6fIzBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2iHn44J22A7ahAmrnJ+uPvEtFaB0ggTW+anlUumxi99X8fkg6
	qroqcxq191hRqILU5Er/CtHr2i1pGhYAmw8QX2/DaoX/NKwF/aN+f9Pbm90fLviygV0=
X-Gm-Gg: ATEYQzysJwu0s7lVu9gphyIrkjdZm/fFKrDBYhAvNXDyBi/UYKY+4HM4rhPpdWMjN7w
	YPvwPqMyFpRcYnZa/r+2joIW2sR7EH5nnkdEVE1/X3gUODQrGhvsoQEZBnFf/NffBdOIKAag4DL
	JPAMSWYMQoxZ33qqTFIbIWS30fz7r9rwya/F5zygNmKp6OQM75b/j+EoMv1fqwSB+D6yTn44cLK
	sfx/8THrVCF8KjC9e6NvwlPO6a1M9cvmjclTCdVA3svBxEX4DWZf/JB2Moz9t2RSSglMJu0wXwW
	apCcVRcTaj+0lP1trT8dhMVMqwdyuOqTzKyIYDdtIHqGf38FhQgF7lSoW41dpErFK4yaqOoyZ2x
	mdfqsD+U9DMrjz9yq1s7txbCAhKFpgjYH3n7IG6nf8hroNDulsY7mMnw4vCVEplhJxoRo/ZVtVF
	Q5jRXKFjqSbxlSGPSp12xEa70=
X-Received: by 2002:a05:7022:20f:b0:119:e569:fbb4 with SMTP id a92af1059eb24-12a726e6b10mr6084355c88.35.1774278151492;
        Mon, 23 Mar 2026 08:02:31 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85247071sm86622826d6.15.2026.03.23.08.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 08:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 11:02:29 -0400
Message-Id: <DHA941F6HVW3.RNGBXB3DVTC6@etsalapatis.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
 <andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
 <sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>,
 <tangyazhou518@outlook.com>, <shenghaoyuan0928@163.com>, <ziye@zju.edu.cn>,
 "Puranjay Mohan" <puranjay@kernel.org>
Subject: Re: [PATCH bpf v3 3/3] bpf: Fix incorrect subprog ID in dumped
 bpf_pseudo_call instructions
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260323122254.98540-1-tangyazhou@zju.edu.cn>
 <20260323122254.98540-4-tangyazhou@zju.edu.cn>
In-Reply-To: <20260323122254.98540-4-tangyazhou@zju.edu.cn>

On Mon Mar 23, 2026 at 8:22 AM EDT, Yazhou Tang wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
>
> In jit_subprogs(), restoring bpf_pseudo_call instructions truncates
> the 32-bit call_imm into the 16-bit insn->off. For large BPF programs
> (e.g., offsets > 32767), this silent truncation causes find_subprog()
> to return an incorrect subprog ID, which is then stored in insn->imm.
>
> Consequently, "bpftool prog dump xlated" reads the corrupted insn->imm,
> fails to resolve the subprogram name, and incorrectly displays a raw
> kernel pointer.
>
> For example, dumping the xlated bytecode of the JIT-loaded selftest
> introduced in patch 2/3 shows:
>
> Before this patch (with call_imm > 32767):
>   4: (85) call pc+2#bpf_prog_115951674716e036_padding_subprog
>   5: (85) call pc+3395#0xffffffff814aed4e
>
> After this patch:
>   4: (85) call pc+2#bpf_prog_115951674716e036_padding_subprog
>   5: (85) call pc+3395#bpf_prog_5dccd3f669bbe4e4_target_subprog
>
> This patch fixes the issue by passing the un-truncated 32-bit
> env->insn_aux_data[i].call_imm directly to find_subprog().
>
> Note that the assignment to insn->off is retained. Although it still
> truncates for large jumps, it remains correct for the vast majority
> of BPF programs where the offset fits within s16 bounds. Keeping it
> ensures backward compatibility for existing user-space tools that rely
> on insn->off to display the relative offset. A comment is added to
> explicitly clarify this truncation behavior.
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
> Fixes: 7105e828c087 ("bpf: allow for correlation of maps and helpers in d=
ump")
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---
> Hi Puranjay,
>
> As you mentioned in the last iteration, this still leaves insn->off wrong
> but is generally fine. To clarify this for future readers, I have added
> an inline comment explaining the truncation.
>
> I also debated whether to add a warning log when the truncation actually =
occurs.
> However, since the program will load and run perfectly fine after this fi=
x,
> I held off on adding it to avoid unnecessary log spam.
>
> Do you think a warning log is worth adding here, or is the code comment s=
ufficient?
>
>  kernel/bpf/verifier.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 809ac2325dcb..a45a393365b4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23027,8 +23027,12 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
>  		}
>  		if (!bpf_pseudo_call(insn))
>  			continue;
> +		/*
> +		 * Note: If the original insn->imm is out of s16 bounds,
> +		 * insn->off here will be a truncated value.
> +		 */
>  		insn->off =3D env->insn_aux_data[i].call_imm;
> -		subprog =3D find_subprog(env, i + insn->off + 1);
> +		subprog =3D find_subprog(env, i + env->insn_aux_data[i].call_imm + 1);
>  		insn->imm =3D subprog;
>  	}
> =20

