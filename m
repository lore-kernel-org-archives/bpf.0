Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED09371D1F
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185493; cv=none; b=Bg8ytv92/E6uLXpHh98uZGFz8UqB8dTg/M+bIA+8Ae4Fzgilmnkw3p829WtMxd2PIv12g/xqqNbV+qDjp8jgs3DSXuvpp6H59UCZjJqY55IMfaLkeKE4JQqWxRXUNwP3q/XDwrihtL9JjxCFdfD97X7s8PyIEEIZUoBZqDYKPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185493; c=relaxed/simple;
	bh=HnlMjgeKlSmJf1OusZ3j7REzSzqVhpFG/j0J0soEIX8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eOvHsLfz0EspV9ESLH5ZoQ8ORezaEbTJtxyHKVMrZDhgdCTiG97QiHAhZMhXbhYsn5dTRlHXao0de8oPjU1xOKsSvgKguQIV8ifK1Pn2j2A9MiIGnhTXWmVXujds90XnMGIUwa3urgV/3hP8HMl7CYwFtDlg5Jjruvngr3HF6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGXBwODQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGXBwODQ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caced6038eso4885715ad.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 13:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785185492; x=1785790292; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OH91rh70BGMTf62e9cgP6ZlkmrwqNsr6Fh4M57MPEhw=;
        b=CGXBwODQw6iA/8cCf9MXcsmmXmNKk1yVwvMM7Clt94Rsb3lqslrJX6smTVilXwdHxN
         CTkD2ezYZx4pnkAA3Uv2xRNTE6XbCbrosw9Sgj763fM5GD2lg/4KI7JRRUP7QSkwNa8h
         O4ly8JBXYBN8k3RZXbssXlO/nJQjNV2RugD/7OhXimkII7EUSG1UEwtyfGmi/tso7tYZ
         y3TvNmkOBEQsax4OePJBAJ6oucwGt75CKLRdW/e9OaVql6e5QhRfCM8tPgXJ4L2k4OTi
         QC/AJd/f4rjiJAroe9sxrMcn9zfz/r6bVxtdfHt5j8dQEBQ4qpju8L3P1LvtsZ5pUyvg
         HcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785185492; x=1785790292;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OH91rh70BGMTf62e9cgP6ZlkmrwqNsr6Fh4M57MPEhw=;
        b=C/2HuY9PGXjw/rfpeukhXfflyFyrMzcy4PspnrDT4hrL3/7uUdNNEmjWdj6lnMqX1E
         Tgv1kQCxc9bjUog1kAXD25Z8NraoBBHs4oTBnKVFQMsQ4b45jPfWcKKNTXPtMqjrHNb0
         IcXEWzkdxhK099GN7T8hge7egN+qiNSwaL+hOXM4lTbI37TX23ChKyfIQUVOuxpTjNI8
         RwoU7dtGmyOZLtGAEX9yHYukKtocU7SGkEaNHov7yGtw8RlwE6pOqXjddT0DIpw3xI7j
         BhoLcHxUfv4e2a9AQGgoCZBwn+agcrYcg04Kwm+OwdRh1gvFcvETqac+aa7+r7Jy4BhM
         ow8g==
X-Forwarded-Encrypted: i=1; AHgh+Rryt5bJrxh6Ls8NINisRzN5gsVj78n4tSpPvYEEa4cFxQbxg6FUrbkV7LIBEiIwH37HGGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ni3Hxcvd5DUBfuwhY7K1DhCUYDne71PXCbYDM3mwbJpVQqvZ
	Psm4FiHtI/eCJSJps05c7AFtFCiKBbh6Imjj9fy01lfVezLV1gwR05Az
X-Gm-Gg: AR+sD105RiiwBJ5vFnWs0WAwWCsYaaZa7eMyH8yhR7LXhulk8en1QP+ixZvpFr9Ilvr
	5yM881SIfsKsAZgNgB1HuyMi9OhdWyzG+PT6fv7CKspTbFBSRJhQ3FAFKfkL9Xcm/eY5aqLjEG7
	JoNAnByi1a4pAXgrZdonNGck9IJGb5ZqYsIhxhFhYdSLrcF/p2k0+G5XLiOopCcZ2dQyfERQr1f
	uZ176ZqzuIh8hCRHbMI23QAtZtovk4+ugAATri/ejMIvNkiC9ipUQHRPzfEZMKfdDrs2nKdM1wa
	oWY0yfYuML5oOLkWwF28ESO3/YcHe6COtzk6mRSwjt8mf2WInVVCTnfogAKTKcV6tbUgB0wN2qJ
	HaAcAlXfKqiOwQFZChxOLjMpKptuoionSp+7Pyv9K3lSsm12GyK9vVFYv7AG8mO4cspa5bbgI+5
	7FTe3sTCY20k51g1gDEts5NIX6Du/u6w==
X-Received: by 2002:a17:903:94b:b0:2ca:12aa:a390 with SMTP id d9443c01a7336-2d011a2f883mr3344955ad.0.1785185491698;
        Mon, 27 Jul 2026 13:51:31 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5c7deasm41101375ad.19.2026.07.27.13.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 13:51:30 -0700 (PDT)
Message-ID: <27739a12b7f7d5cd6e7fceeb389cff0072aefef2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/18] bpf: Check helper and kfunc mem+size
 arguments identically
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 27 Jul 2026 13:51:27 -0700
In-Reply-To: <20260724190813.1458271-6-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-6-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:07 -0700, Amery Hung wrote:

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 468702b09c50..2e56f726c12a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6873,7 +6873,14 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool zero_size_allowed,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_call_arg_meta *meta)
> =C2=A0{
> -	int err;
> +	bool may_be_null =3D type_may_be_null(mem_reg->type);
> +	struct bpf_reg_state saved_reg;
> +	int err =3D 0;
> +
> +	if (may_be_null) {
> +		saved_reg =3D *mem_reg;
> +		mark_ptr_not_null_reg(mem_reg);
> +	}

Also, this pre-existing hack with saved_reg and mark_ptr_not_null_reg()
is quite ugly. Consider mark_ptr_not_null_reg():

  static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
  {
	if (base_type(reg->type) =3D=3D PTR_TO_MAP_VALUE) {
		const struct bpf_map *map =3D reg->map_ptr;

		if (map->inner_map_meta) {
			reg->type =3D CONST_PTR_TO_MAP;
			reg->map_ptr =3D map->inner_map_meta;
			/* transfer reg's id which is unique for every map_lookup_elem
			 * as UID of the inner map.
			 */
			if (btf_record_has_field(map->inner_map_meta->record,
						 BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
				reg->map_uid =3D reg->id;
			}
		} else if (map->map_type =3D=3D BPF_MAP_TYPE_XSKMAP) {
			reg->type =3D PTR_TO_XDP_SOCK;
		} else if (map->map_type =3D=3D BPF_MAP_TYPE_SOCKMAP ||
			   map->map_type =3D=3D BPF_MAP_TYPE_SOCKHASH) {
			reg->type =3D PTR_TO_SOCKET;
		} else {
			reg->type =3D PTR_TO_MAP_VALUE;
		}
		return;
	}

	reg->type &=3D ~PTR_MAYBE_NULL;
  }

Note that the check_helper_mem_access() already calls base_type(mem_reg),
so the '&=3D ~PTR_MAYBE_NULL' part is irrelevant, what matters are the
following mutations:
- PTR_TO_MAP_VALUE -> CONST_PTR_TO_MAP (plus it's uid, type, ptr)
- BPF_MAP_TYPE_XSKMAP -> PTR_TO_XDP_SOCK
- BPF_MAP_TYPE_SOCKMAP -> PTR_TO_SOCKET
- BPF_MAP_TYPE_SOCKHASH -> PTR_TO_SOCKET

A better design compared to current temporary fixup for a helper/kfunc
call would be to deal with types CONST_PTR_TO_MAP | PTR_MAYBE_NULL,
PTR_TO_XDP_SOCK | PTR_MAYBE_NULL etc, instantiated at map lookup.
Wdyt?

...
