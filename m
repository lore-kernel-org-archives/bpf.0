Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B23EF0C6
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773693136; cv=none; b=J4k4qJex+wjK2WSStWS2OXxaVFgJtNRb2DajR9IgjKza3pup+XHKxYWa+QMfcWI/fNjbogDHZxC65pMjr+nsLaG6Z8J3/OJZ42wIj9WCWgAyJe5pagRMVPha9wHo4tRmjMnH6AVbUCzw12yPfa7zCunT+V06c5e4s7ESF6iS8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773693136; c=relaxed/simple;
	bh=05TO+nKXrXJ+LfVf9JRfWSVe2609nEASBxqSdve1fNE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=nw4CRHC1cKfFgdJ9YbFXxR7FqTrHbblaH3sZ9BZMBmoyQ6ZY3Ad6YG4s1342b4gesfzDvKgw9q9hGBt7tKrt8BtRj6+oVi3Tw7O2y3bmExkcaZh2Gn3GYdRm1oDPFSmZtLnwCGllUPL66sKHwqHrXP+NJ51egb/hmy6wSj5dqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=qW0b8dXh; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="qW0b8dXh"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899fac9caabso65942376d6.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773693132; x=1774297932; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VI1obgRr3/nQjxB1ypi6HCLWSnM+/qXQ8OIllHuk4L0=;
        b=qW0b8dXhlw427VXEk0Gd3PYStEPnEylWALNSSoDQuWZYjvQBlDlLpk03thc7YlzhKi
         Pwq2yhITT3kM3z1cT/aTCEwqgWx0DoEOOVRVy0pfiTTxuaPcW6z3sUZzKsl43qLAOy3B
         W9YfKXHFGfXQl7Z2itm/DaGf6kaw0SQ50kzEuA5dW6rxqR862Z1SHhOxwE+zqEvi9QPx
         gp2H5JaHRzzCgGVsq6/W2gZWiT6a4sWgXB+YG7HkGaXV3zwmVHO/+cIn/8daU62n7dT+
         QvKZfdFV3XtVlsSwr+uLZv+ByLfWtiioW0swmN29w9iylSGTjnOwyy4RLCZj/6F5/yPU
         554g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773693132; x=1774297932;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VI1obgRr3/nQjxB1ypi6HCLWSnM+/qXQ8OIllHuk4L0=;
        b=g7C1z9MmA8pNlGDNPYLEe/VFvipylnCVmLOMgkXEFsYsbZ/PLCF6Ifj6bIPa5rXJQ9
         yQm94ZmKGEHau9KzPjtJR1FVQjbCJ2nGJBUcPftrjBme+/SOqu2u55QbUwbd8aRhbvRJ
         q/JxQ1g+FKtmyz9xBqyCxWTiPFtDCKn695WThjgD2XlUATlHVeqvsK0P9Bzx+NgSSRo/
         fjCTM7RvHtsXs+dsy3iOCFlfXJgazLCQ/b8llOQ0dEl+8CVYSDBPcohLUJyu6/d+EChX
         61yPmc53Oa8kNIAQyc8Fj6N7RvMYO1uxFgsMmmwnRNbJqFB0WKwqmKv8vj7E2JKJTLTt
         tOtg==
X-Forwarded-Encrypted: i=1; AJvYcCXbrIWsIQyr+0ozmxu1bMEl1sIK6HscMsIV3sAhxIfDenYyvKbX/3HSXm7LZD+5++c/Alk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzlgvpovwqPTmObkOouaHtNhw0rSq7h0o3bWq5Y/CzXC/UCoj8
	q41wFaVEBCkbjBxRM86INGeFKO7AGBMV66osMqfS3ZjjUqsoThQJZg+iIbPYsdZYoPc=
X-Gm-Gg: ATEYQzzimIYwJmFP+3xQMqaUtw4ByzvgNCZLBtSKv7SMa5v/bDPfwp0M2/QWxMqQ7Bx
	1+EVDq8z5pA+z8tACOvFthhwsSLCL7qgrbB6Azzz79mEZxlvdMs6E+sGPmqq3HbG0cYtnCU9emg
	Yi3xrwYHLvC8ftii634Dm6UKYG1PpjOAWqxXH7wlWzQOeGyuscSxBB+JmHRfJ/MHKLPrbxMD6nI
	qLlGzKDzrK2GiIDMVc7gqNAm/hIfnZ6m0evBBs7J9u2Fup3xD+5KsFkDqp+lCXeJUdDJfqmohzS
	dcDEMPF4zWiN6IBDE8HpymEskyT364Xw4O3n7iZBAhlWRFPWI2wgx08XWY7XlSgzCCS5IO4QSWo
	UfNvrnyY1Cf8DycyakOznWO9mmmbvFNIPo40tPkstA6XnvTPdzCeCLWUhvt10AojzuossCuPV5t
	/swPhqxE4O4UDpkU62zz21Cel091rMURJc0A==
X-Received: by 2002:a05:6214:f0a:b0:89c:5ab0:858d with SMTP id 6a1803df08f44-89c5ab0870dmr37558616d6.58.1773693132436;
        Mon, 16 Mar 2026 13:32:12 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c4ca138e5sm36540626d6.17.2026.03.16.13.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 13:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 16:32:09 -0400
Message-Id: <DH4HQN1GYK0L.ZK38Z2ZS0RPO@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
 <andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
 <sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>,
 <tangyazhou518@outlook.com>, <shenghaoyuan0928@163.com>, <ziye@zju.edu.cn>
Subject: Re: [PATCH bpf 1/2] bpf: reject bpf-to-bpf call with large offset
 in interpreter
X-Mailer: aerc 0.20.1
References: <20260316190220.113417-1-tangyazhou@zju.edu.cn>
 <20260316190220.113417-2-tangyazhou@zju.edu.cn>
In-Reply-To: <20260316190220.113417-2-tangyazhou@zju.edu.cn>

On Mon Mar 16, 2026 at 3:02 PM EDT, Yazhou Tang wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
>
> Currently, the BPF instruction set allows bpf-to-bpf call (or internal ca=
ll,
> pseudo call) to use a 32-bit `imm` field to represent the relative jump o=
ffset.
>
> However, when JIT is disabled or falls back to interpreter, the verifier
> invokes `bpf_patch_call_args()` to rewrite the call instruction. In this
> function, the 32-bit `imm` is downcasted to s16 and stored in the `off` f=
ield.
>
> ```c
> void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
> {
> 	stack_depth =3D max_t(u32, stack_depth, 1);
> 	insn->off =3D (s16) insn->imm;
> 	insn->imm =3D interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
> 		__bpf_call_base_args;
> 	insn->code =3D BPF_JMP | BPF_CALL_ARGS;
> }
> ```
>
> If the original `imm` exceeds the s16 range (i.e., jump offset > 32KB),
> this downcast silently truncates the offset, resulting in an incorrect
> call target.
>
> Fix this by explicitly checking the offset boundary in `fixup_call_args()=
`.
> If the offset is out of range, reject the program with -EINVAL and emit
> a clear verifier log message.
>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---
>
> We also evaluated a potentially more fundamental fix: patching the instru=
ction
> stream in `do_misc_fixups()` to mov the 32-bit `imm` into an auxiliary re=
gister
> (`BPF_REG_AX`) prior to the call, and then utilizing `BPF_REG_AX` to reso=
lve
> the jump target in the interpreter.
>
> To avoid degrading performance, this patching must be strictly confined t=
o
> cases where JIT is disabled. However, reliably determining the final JIT
> execution status during the verification stage is not easy. Therefore, we
> opted for the simplest and safest fix for now.
>
>  kernel/bpf/verifier.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index df22bfc572e2..0ee8a3333193 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23109,6 +23109,12 @@ static int fixup_call_args(struct bpf_verifier_e=
nv *env)
> =20
>  		if (!bpf_pseudo_call(insn))
>  			continue;
> +
> +		if (insn->imm < S16_MIN || insn->imm > S16_MAX) {
> +			verbose(env, "bpf-to-bpf call offset out of range for interpreter\n")=
;
> +			return -EINVAL;
> +		}
> +

Can we maybe move the check within bpf_patch_call_args? That way, the new g=
uard is
right next to the typecast that necessitates it in the first place.

So basically:

bpf_patch_call_args()
{
	if (insn->imm < S16_MIN || insn->imm > S16_MAX) {
		return -EINVAL;
	insn->off =3D (s16) insn->imm;
	...
}

fixup_call_args()
{
	...
	err =3D bpf_patch_call_args(insn, depth);
	if (err) {
		verbose(env, "bpf-to-bpf call offset out of range for interpreter\n");
		return err;
	}
}

Provided this is addressed (or people have objections to the change):

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>


>  		depth =3D get_callee_stack_depth(env, insn, i);
>  		if (depth < 0)
>  			return depth;

