Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172933537C8
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729486; cv=none; b=pCaU7cvYhIwGGHEMjGqNBCEZWjDt/qAlOi1/JTwSKIVTk7umyvdfVRlVZI7w5gxaQ9WZuJqnQx/j1/O9elNq0Dnh/gIeaqWTfjZk1klUwDsdpj4Ub8BbYoanvfmy5VV5//nj7lCNi7mnwCPMUgMDecC7hs8fGZ7XUmsQp1ETUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729486; c=relaxed/simple;
	bh=xJHyJH7ma0DQEh0SA7I79wX3GcW8WLBDcukIzYSdCA0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=S1VTx+HkKwwAb4OlEha4UKMFx196h1jHqLE7HkuNtxuECvuInQgS1z/qDgsbULd5B73X0lrdv+1pUv0esCJQmNHw37IEF87T7lN/nWmDXzEvOr/8EfJAXJa9G+JAPFDSNJUhh8vwvbl71SY1mbD9CfnoTNFBB0S2nRDK0B7puuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUcyU5M/; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUcyU5M/"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dbe437b072so2129894a34.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 16:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776729483; x=1777334283; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7dl2t/iIUy0BQf+6DEI64I2IQsLcyrdhN9keipl/4g=;
        b=XUcyU5M/ixrUJxlyzqJHhHfBQR+GRSTIBarpKnirOWOfVDDyEm7XmNXkbQ0aSVV8ij
         Khvtog90AIRzLFqrCtbleQ/UdzCd97ZdjUZ60UVYBzpx6tipjTpfLYjzFxBXXRnGADzP
         nHcqnThPegvpTffyAOvw79Ynhhilm50cX+QbjGO0+4JNHali6IIcstWidlbHZGORbrfa
         JExta64xTDd0e5Vbn30GBSdEgX10t8TXMurvb9zqJdduvV/RAy1lIMd2GueJoAS2si0v
         /OexDUoG/w4JCiVgFw7ttMZ5q+1f/OjgNEG7yvWgkFQjAmkqqvOgozO7p6LxURqK57s7
         zFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776729483; x=1777334283;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7dl2t/iIUy0BQf+6DEI64I2IQsLcyrdhN9keipl/4g=;
        b=LhilsrZ261/1PpCPF5JbIZhccqG8VGKRYthXQP0bvRV3Utr0yOPf05ME8SxybCpv8M
         y1Ey82WTOLDBNWVoRw2MrLDZ7VpPHXrxmOPyCrxpntrMt53WYZV+vYrU4ex/72bU/gJf
         h1AxeAJfbsYGD4uNc7AqbSMmo26qWiMp0S1/Q81IicSgWIh5B1RoTKrt1/n6alwyDZTe
         Rvc5+TzqLhSvv8Gi7gVWvDm/N2Z4U5TPXvUBkj8HloiCuvCBWVqTp1NTHQTZ43YNQLOr
         H/yQ+rxPNmCvKtIlhSiExm+kdl+lx8f+p9wgnc3kRTQa7ut2aa/+EuvS35xE/n7z0us2
         37vg==
X-Forwarded-Encrypted: i=1; AFNElJ/ohaoXY18GBMJfIXxHbiKp5xCsrpJhgoI959F4Pi8SMO8U9hhi0Y9c0KsYiUcEljguDCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnj2oDNcDzCDRGxzvpZjSQRgZf899Mc4d0U4FXZYZ691g/5zs
	+JaBqm00xdPTX8WveUL6SFvCRrox9rsYEsPJqxckPv4a21/TT+Nr0VuNSBSd1g==
X-Gm-Gg: AeBDievkK5bbPXfOeWzohXODVVuOQJUgrhFxlz/nnhvTBC7lV/446wxA31jJcdX9k71
	l2GmzEdRyeqKdxva7blZuNRNVtdsrHWP4PkpUmwshjFl2x+LYgH6WAd+3JNMGTxCIkYO91ny/q1
	DSAJ8u1qaT58k4Zs7isDN/qYu9d8XfRRsjVERvOL4u8JZEiau/AcIE55O8zv8USeABi14EM8LW4
	bxSZQ6o7CBNiZAsulI11QMf5t4GzIYQ/KyF9gjjEMV5KAbFkHTkPey4+D1b8LafeBF2e8qPJxlk
	6cNDoz9sM1Cv4v3fJuLu9/NBkGsABgpBNEMUcW1WLc+LRAtMrXC5nCE3CFhqrjsQv4ubCr7xVEF
	pe6yn89vO7BE0i+wbpo2kOfCfzCRYQY+cn+Z3UFqBx7+JEGvdvq7vob+yePZNqDOlPyjmnREiPn
	hstdati1iKJi9Sd8VrQFXmP78dDj7TRpPCbr0/9v7SfXwfeDIjqEsx1mxEddfYgkiGp/9szFUt9
	EJLQtgPlKM1sl2utxRnsyl11mo=
X-Received: by 2002:a05:6820:2002:b0:694:9175:9d47 with SMTP id 006d021491bc7-6949175acafmr1937292eaf.18.1776729483559;
        Mon, 20 Apr 2026 16:58:03 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-694984114f5sm178255eaf.7.2026.04.20.16.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 16:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 16:58:00 -0700
Message-Id: <DHYE1BFZ7PIB.1ZNRQN7ZDK8EZ@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v6 03/17] bpf: Refactor to handle memory and
 size together
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260419163316.731019-1-yonghong.song@linux.dev>
 <20260419163331.733278-1-yonghong.song@linux.dev>
In-Reply-To: <20260419163331.733278-1-yonghong.song@linux.dev>

On Sun Apr 19, 2026 at 9:33 AM PDT, Yonghong Song wrote:
> + * @mem_regno is the register containing the pointer, mem_regno+1 is the=
 register
> + * containing the access size.

wrong comment. should probably say that size_reg is the register that conta=
ins size.

> =20
> -	WARN_ON_ONCE(regno < BPF_REG_2 || regno > BPF_REG_5);
> +	WARN_ON_ONCE(mem_regno > BPF_REG_4);

this warn is too late here. Can be removed.

> =20
>  	memset(&meta, 0, sizeof(meta));
> =20
> @@ -7129,8 +7130,8 @@ static int check_kfunc_mem_size_reg(struct bpf_veri=
fier_env *env, struct bpf_reg
>  		mark_ptr_not_null_reg(mem_reg);
>  	}
> =20
> -	err =3D check_mem_size_reg(env, reg, regno, BPF_READ, true, &meta);
> -	err =3D err ?: check_mem_size_reg(env, reg, regno, BPF_WRITE, true, &me=
ta);
> +	err =3D check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BPF_READ,=
 true, &meta);
> +	err =3D err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BP=
F_WRITE, true, &meta);
> =20
>  	if (may_be_null)
>  		*mem_reg =3D saved_reg;
> @@ -8594,7 +8595,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>  			return -EFAULT;
>  		}
>  		key_size =3D meta->map.ptr->key_size;
> -		err =3D check_helper_mem_access(env, regno, key_size, BPF_READ, false,=
 NULL);
> +		err =3D check_helper_mem_access(env, reg, regno, key_size, BPF_READ, f=
alse, NULL);
>  		if (err)
>  			return err;
>  		if (can_elide_value_nullness(meta->map.ptr->map_type)) {
> @@ -8621,7 +8622,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>  			return -EFAULT;
>  		}
>  		meta->raw_mode =3D arg_type & MEM_UNINIT;
> -		err =3D check_helper_mem_access(env, regno, meta->map.ptr->value_size,
> +		err =3D check_helper_mem_access(env, reg, regno, meta->map.ptr->value_=
size,
>  					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
>  					      false, meta);
>  		break;
> @@ -8665,7 +8666,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>  		 */
>  		meta->raw_mode =3D arg_type & MEM_UNINIT;
>  		if (arg_type & MEM_FIXED_SIZE) {
> -			err =3D check_helper_mem_access(env, regno, fn->arg_size[arg],
> +			err =3D check_helper_mem_access(env, reg, regno, fn->arg_size[arg],
>  						      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
>  						      false, meta);
>  			if (err)
> @@ -8675,13 +8676,13 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
>  		}
>  		break;
>  	case ARG_CONST_SIZE:
> -		err =3D check_mem_size_reg(env, reg, regno,
> +		err =3D check_mem_size_reg(env, reg_state(env, regno - 1), reg, regno =
- 1,

or moved here.
I would just remove it.


