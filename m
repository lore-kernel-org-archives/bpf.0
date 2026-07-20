Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2BB31D372
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573235; cv=none; b=gw1//MK+M9W8abYz/eLZQqSlKzku9WwCYjLj4RSK0BNTLN64ImUdtaxBOsxvEOqxVacqSMgiL/DMUymq3pIDjgWBZzTUdY20XRWAbb4oLsB8zKBR39tuWj5wJWeRy7tO6ydOkrnHu/1ZtNHoiaNwEQ8JZvYI1VvWRjhgLLVISOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573235; c=relaxed/simple;
	bh=2JEVIKRjuogw3CiJj97/97MbKmbSMBHFdJ8CWOymg3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rl+vclgoY0mvRyDl3eV7BSUtsZVKyro71/pJZjjqdKNE/qFsp0jG4dl2PRnnvS5pn7GSQJ8MHIE/2VJjVQd8PO2V7m3679HFhOcjgSrqE/PAFXaznFAQxBBBIiRy8AzBIlHSEK9sUY7o6D5ijTpYy5FPXBxX1v1lxqm1Vho6uoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7WTa0jS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7WTa0jS"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381b831d535so8312217a91.0
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784573234; x=1785178034; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wYNGagPb4YA1YB5zrq43PT6RJzgokAlH9V1waITYWGM=;
        b=c7WTa0jSJR7YlJdgNC5nm4+tQSXpI3lu1p674oiopBy5vkAthEwpX/hH5CP0vE8HPW
         SPnGb4KXxZuTugL4haC8tpOQ5aPxyf3pqdtkX9V/Q9rAdCMYfW3feUCPpWdxbc5WYh0x
         ncrWQllHFUkyA2ppWLkVZvsm6FctdSyBI8ArViSnNbtcW0ycF5a144UesLedIOLgSPSy
         seZTeLZAzZRvUtonNZaOw12r4NO3zBiLzQ25M612efnFuWMahcIziRBUsmi4Z+ITn1BD
         38Sp88OZHrGIa+fFB27UI0QSkxK9tP1YEcEP+xpTbAW1I0aXtkC0QkmyCFBh1VH3tMGp
         s6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784573234; x=1785178034;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wYNGagPb4YA1YB5zrq43PT6RJzgokAlH9V1waITYWGM=;
        b=aU3s5VsoZ4WHrF/QOdwXZFnoJ9rGLdu8GhfDET3HRJiaEH5ZpUxoO/sRROnJbyli0Z
         H8oEkj1q2zBooU/n5hnmcD3HhqIDSG+NTKdUSMr2rOPfbun6Eq4+sf8c3s6b4hbKP9eX
         LvzKcJgCtJKprfXxun2SZT/defDupYtD/T33Ib/e1X5zncwY8Dz2cr6+Z0vXCWrneNWX
         WafTHBQt+oNSzZFPErbEmIpE1jEpjSjkFSb2c6im/ROOkDJ2uvrbdhIEwUaZzSN5m6t4
         nALi0SKJ+ijtyDL2f8M3CQb3uzlQoAovXlqX9FCdvA2X++uqSGTRsGuukdX8QSP8rbrF
         vVWA==
X-Forwarded-Encrypted: i=1; AHgh+RqJwQfd7hhFP2/j+9kDIs6J6/zmnIHjxfp3/EJynKMhwBHp7SqoscI13qANk8Czqpm+9S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYOt739woc35k/NN40f+4ytzHlI/70nVVU7yyIbM6ekHFynjy
	ALTcVt+Ni31oB/+DFYCY0KoFYB4/Qj9DEqqBkajI3KJKK0AeggI8v9JM
X-Gm-Gg: AR+sD127q93bHSPZ5nKTq2I7LSRnzFL+pWByynIISRGbWJIUeQ+jrkrWu4Lxywk/d+e
	ics7gWhFcWMrD/OEgkT/TiGE5aHDb4khHr7EjCFBxKac2uyRef43bLBhqAcl3Q8/SdP0FA5kyNo
	HLESi0321wEKD/lEQhTZsRpXoIPhsulPfzCr+jCUPHT3NaDKr1TbSz+dFjjhuF3zv0n66NnzZaI
	/QDK8qROVqNDW6WOQFHuDWEtkyse+Esf/rv9N/0ijJzRK8vbWca4e+Kqa9pK/fPlrQLKY1niC1Q
	ZY+1MMkawa2B5CU9zzE4sHIJO/7bG45+M3EEpC3TOSd9hXH8ycILFcGo142F08yYwgjp0v0lx+e
	byHdXlMxHaFVv/IWvgfnBEQ2QdGzaDy0wu9BcHrrB3n5iq3jG4UqLymMEuQ6Vqt7Eqqe8IQUM6x
	aGoemVSOT2/kiPzaL+VRtvPHO2z6afTQ==
X-Received: by 2002:a17:90b:2691:b0:387:e0db:3fb2 with SMTP id 98e67ed59e1d1-38e4b602948mr16389172a91.43.1784573233855;
        Mon, 20 Jul 2026 11:47:13 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e92396445sm158611a91.17.2026.07.20.11.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:47:13 -0700 (PDT)
Message-ID: <a469d5344126d38b5151b9bd044ce83320875517.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Preserve stack frame number for
 commuted arithmetic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan	
 <shuah@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 bpf@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 20 Jul 2026 11:47:09 -0700
In-Reply-To: <fee8d44c3c792e29b8898951a68c8313d9d2da53.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
	 <fee8d44c3c792e29b8898951a68c8313d9d2da53.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-20 at 16:37 +0000, Yiyang Chen wrote:
> When scalar +=3D pointer is handled in adjust_ptr_min_max_vals(), the
> destination register inherits the pointer type and id from the source
> pointer. For PTR_TO_STACK, the inherited pointer state also has to carry
> the stack frame number.
>=20
> Without the frame number copy, a stack pointer derived inside a callee
> through scalar +=3D fp can be recorded as pointing to frame 0. Stack read=
s
> and writes through that register can then update or consult the caller
> frame while the actual instruction uses the callee frame.
>=20
> Copy the frame number when PTR_TO_STACK state is inherited by the
> commuted arithmetic form.

Could you please infer a "Fixes" tag?

> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
> =C2=A0kernel/bpf/verifier.c | 7 +++++--
> =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 52be0a118cce0..58017141d52b7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13796,11 +13796,14 @@ static int adjust_ptr_min_max_vals(struct bpf_v=
erifier_env *env,
> =C2=A0		return -EACCES;
> =C2=A0	}
> =C2=A0
> -	/* In case of 'scalar +=3D pointer', dst_reg inherits pointer type and =
id.
> -	 * The id may be overwritten later if we create a new variable offset.
> +	/* In case of 'scalar +=3D pointer', dst_reg inherits pointer type, id,
> +	 * and for stack pointers also the frame number. The id may be overwrit=
ten
> +	 * later if we create a new variable offset.
> =C2=A0	 */
> =C2=A0	dst_reg->type =3D ptr_reg->type;
> =C2=A0	dst_reg->id =3D ptr_reg->id;
> +	if (base_type(ptr_reg->type) =3D=3D PTR_TO_STACK)
> +		dst_reg->frameno =3D ptr_reg->frameno;

This patch fixes a real issue and this a surprisingly buggy piece of
code. Looking at other fields defined in bpf_reg_state, it appears
that several additional modifications are necessary:
- dst_reg->delta =3D 0
- dst_reg->parent_id =3D ptr_reg->parent_id

Given such an error prone nature, I think it would be better to:
- stash the value of the off_reg in a temporary variable and adjust
  off_reg pointer accordingly (see bpf_verifier_env for a collection
  of similar temporaries).
- do *dst_reg =3D *ptr_reg instead of the fixup.

Wdyt?

> =C2=A0
> =C2=A0	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
> =C2=A0	=C2=A0=C2=A0=C2=A0 !check_reg_sane_offset_ptr(env, ptr_reg, ptr_re=
g->type))
