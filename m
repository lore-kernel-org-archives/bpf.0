Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E92155C97
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777741405; cv=none; b=DL3HIZaFnDzyKRrGgNLWm9XftZYjii1AXSHlgBhDJPpm6lF7Lolf7WgiQT7P4t6rlTzpuf5s3Y9NvekBgwYh4pgcQPHZ1zECibHbBS96/DTaNEnMMjTjrfUk0DF2o/CIgN0FXe8gR6zjZzEtOnTWhi0pzB7i7srd8SyaT3pu/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777741405; c=relaxed/simple;
	bh=50SaXAJ5EsO7igu7WHyWFpLAoPpVRg4nKYinvVZUGTA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uZJi/S+sK5ELtSRWg96xj1ZBO2dUzAFhHzsYUlyRVB/JAhzyJ2T7DCINZ/uNfKcJj0h/oOEpWOHsEdfr2JZmKMYcBZbwG5LF36yi8sONIPcBHJeMr8xZLNSrxDrObIVJtz8VD4rlbYFIX3HqK+jEGL2wszLdTN8YMPmNb+i1d2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg+2V8UV; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg+2V8UV"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7de7c57b52cso2403922a34.3
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777741403; x=1778346203; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsDXyJe+iue9chJdcI7xrmbR/IebWMX+5ZCmubsnUyI=;
        b=fg+2V8UVzKtSnvcFccjlaeTBDEMJ7KGjv1eJCVtUSEpKpjA3+Gcmi1FJeiY28/g6dM
         6PCBvfCEC/KMukpyvAaVsiK1ksilNrCHQo8v1dFOEpM7MNjt0gkt36dvrEW9on3KDBBM
         DUqSMEBMRg2FxwXhofxnOsQaLUeV8juHOdzaCOxJ6Y+QXLZRFk5LGLfvzDCJyu4ZKs5y
         zPYlmt2sRPQizON80iY9z/YcS3XCfR7OD/dQh+wi9hJG4OFtgt9ySbdzMfXF0f4r6qUP
         tVqKo/gsxRLskNKgvMIgFjJsBbllZemieyZeDEv6veyXo/JRAWQfieKQE8XSApXbHKFL
         /c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777741403; x=1778346203;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gsDXyJe+iue9chJdcI7xrmbR/IebWMX+5ZCmubsnUyI=;
        b=mImig2b/msr0/TNMdTxZ//FwldJcNCcIiH1HvlwYq1ETzrebukhSKEOu1o24zaN6oy
         Y0pVqsiJYAksdL63QQZGV97EDv7WCW0QAxupbpUhtOx/w4tJRkPHvu975iWY+3iFbqlG
         mNkZN+We1OlXGBEu/cLXdc4U1Vi9bi2eEF3l5AMHWK7RtBMzD6/IlCLQCMkXYCvBlm2o
         M6dDPCP5lZOX+XxLpnltm/5cI0WXIc6GeO3XMBaBdBaTJwTIV8np15L33nXorbo4DvjE
         1MsGZKYrIsE04jtqvmgcoB0+iZbkoUcplqjmppnMUM4aeqShxZUKnu+V0zh+//OZ78Mk
         Yntg==
X-Forwarded-Encrypted: i=1; AFNElJ+46/U5jcIpsKgwGLlbo8xYGOZE2/JmRZd9DodOM4C4FFjrYVB+uPOJehYyvaXKX/b0+2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0BhrDkNwvhiaEogb6ptQJK3aO9JKqqsLCHj8KWyH7Yp+qByZc
	2FEKDYdqqVpTNWCZejdOUlNrjP0pcIaKsIacxs5JLWmzUkJPKVKlur1s
X-Gm-Gg: AeBDievbt8soPMtrX3u9SC7pS/ikKiAfOi0rgo0TbFk1ZRtvhbI/bwfkwwcIOgsJEju
	x+W2TZviCheb8gYHsZx2bEMgTCKj2m77mRIu2rvHwP2AbAqLLwc1JL2CnKuUN2LJHeE0I7eGVno
	I7KqWZZFJofya6jtHcpVq/XuhYTv8sqKW9z82pTj6UH5kQsni5yMEcHM3rRN3i7o+OHb4kK5oEA
	Gz+B4AJuWOq5Xo6nLFY9Sfks+e5HN4UfE25+ykhOrQqPFf1DBFrs57IPRINQQ9n0Hu5pkmFgoy/
	Nmnjffrt4BYqRhQZ+F/2ouN9KnMHBVqiZUEd5m81DVB0nTmnfx1MtwJ9g3+cI/JaB9zbDuKLcOg
	hW8nn3P/eskFGQXHVKXVhlU4AVnR2sTprGzlY5RoDuVKsCuJTgJWhVdS1vVX1Ld6aox36puTx0a
	R4xHt6/nWnoMBSMPGjw85xleKhrNstuzy5BqILVPZm8dppTwR2OxK4zOgY3tpGoCbh/Ls4H9Vxp
	NBdDGYdCs2Kt9rDEECTeoDfmL4ogMfBKp2V20k=
X-Received: by 2002:a05:6830:6615:b0:7d7:fb8c:3c29 with SMTP id 46e09a7af769-7dee13a715emr2337052a34.14.1777741402628;
        Sat, 02 May 2026 10:03:22 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7decadc350dsm4335406a34.22.2026.05.02.10.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 10:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 May 2026 10:03:21 -0700
Message-Id: <DI8CQDATE33J.30U4FNOVZY97R@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 01/18] bpf: Support stack arguments for bpf
 functions
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
 <20260424171438.2034741-1-yonghong.song@linux.dev>
In-Reply-To: <20260424171438.2034741-1-yonghong.song@linux.dev>

On Fri Apr 24, 2026 at 10:14 AM PDT, Yonghong Song wrote:
> @@ -1669,6 +1669,8 @@ struct bpf_prog_aux {
>  	u32 max_pkt_offset;
>  	u32 max_tp_access;
>  	u32 stack_depth;
> +	u16 incoming_stack_arg_depth;
> +	u16 stack_arg_depth; /* both incoming and max outgoing of stack argumen=
ts */
>  	u32 id;
>  	u32 func_cnt; /* used by non-func prog as the number of func progs */
>  	u32 real_func_cnt; /* includes hidden progs, only used for JIT and free=
ing progs */

...

> @@ -739,10 +759,13 @@ struct bpf_subprog_info {
>  	bool keep_fastcall_stack: 1;
>  	bool changes_pkt_data: 1;
>  	bool might_sleep: 1;
> -	u8 arg_cnt:3;
> +	u8 arg_cnt:4;
> =20
>  	enum priv_stack_mode priv_stack_mode;
> -	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> +	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
> +	u16 incoming_stack_arg_depth;
> +	u16 stack_arg_depth; /* incoming + max outgoing */
> +	u16 max_out_stack_arg_depth;
>  };

I asked before but if there was an answer it got lost in all emails.
So will ask again: why duplicate incoming_stack_arg_depth
and stack_arg_depth in two places? One should be enough.

And another question:
max_out_stack_arg_depth is computed only to error like this in bpf_fixup_ca=
ll_args().

+               u16 outgoing =3D subprog->stack_arg_depth - subprog->incomi=
ng_stack_arg_depth;
+
+               if (subprog->max_out_stack_arg_depth > outgoing) {
+                       verbose(env,
+                               "func#%d writes stack arg slot at depth %u,=
 but calls only require %u bytes\n",
+                               i, subprog->max_out_stack_arg_depth, outgoi=
ng);
+                       return -EINVAL;

why bother? What will go wrong if it's not there?
