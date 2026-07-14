Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169A524F
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 00:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783987685; cv=none; b=LHPDLW8Pv6qzSNOQDDyk+Xmykj70tDRn2zxWsdNq5MZqBNIPdzJ2hGWlg5lVZer5UIwfaehLtxHGaWqJZRIypJniXv4e3Xd6P4nyh/Iz+nSc/KAuTvFvZjBw0JSjoH8JgEo94L8PyTLG6S6Q2svMV/B7s2XiQ55vvi5upvw4DZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783987685; c=relaxed/simple;
	bh=p5v75FYFg8fQi/zot/K1Uqp9RKAm3slfcFGrzSh5B+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H3o9yYYxg841wuOMwTNYoyD8l+d368JIb/wpc3KFxdEWCq6Ujplu5RGi3snnIGLg7dljSEXnlYq/MlkFTSWrb5We5adUlrvDaII0EFaNVx27L5pH0O63K5I/AvyOAqM00WuHZ+yTcJM7tAqXrcAB6QsTx/h0SGhFmgQCRAjtmmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNeleY9A; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNeleY9A"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso3994541a91.2
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 17:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783987683; x=1784592483; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LQrGRJhuVx9EtFFGyua02T5e+utPyQAQkQINb9hPoVU=;
        b=YNeleY9AUN8KGWuFFUm4KF/+TLVM9Tprbby28qYxVw9iKdg/SNbrHRyUc+LiJvF2P0
         3EQAyLMTGEs4f8tRoauhapnYpCJ42JQ3/wT9p98fDy2Be0QMunfl3M0OHGirvC8leXj0
         yzEIkH7LDBcZBvDRqGTuLwsBEdwv3N7rRXfN+9NG/WxXBlYT3zFLGeCqEJQiZ5CAr2ZL
         UfwXOgLzRRL5krOzairglyvAfJN66VVP9iYwiVHxiibLLCkbsNcEFksgsJcaJZhtkvAu
         gz8UFEdTxic5n6YxgAM2rsO/SFm8WOH5/dzXhNvNl6jsM3I9Cms0O/3XPrgFb4B9SVg2
         cw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783987683; x=1784592483;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQrGRJhuVx9EtFFGyua02T5e+utPyQAQkQINb9hPoVU=;
        b=f5swYz6M30A8SCWVCLC+wfsTWSLjtfcCH3MApf6g7bZCxca9XBS4HzbXmbZa0WOBsh
         Lyj6Z/dqzXBzZn7pZdYvzYP9vzhVMD+GC+7wE/pPTAEau0IvKQaEntEuH3/Phx4lw7b6
         rwdgzXXcuZ9bS9eXUwhIGi/yabzmLFeL/ZNDlQ8Dxf/qSVFfYYhqAf2pvPhr5tvdG6oT
         G4LMgEKElB9KPpIbxMLtC+gESzqBRdpF4lzd4TSuogYxB6mjY6NoYOplceJ3lZaZHCwa
         sgMzu+oQh1fqZPd6SAaqn3y+3wFIyaA2nm9/DvFpDKWzgPunG0wfq4AF/eG4GUkgGhFU
         2vnA==
X-Forwarded-Encrypted: i=1; AHgh+Rpv06dQNl5KpRTgZ2xsqiOeYbT56+bgoA76LT//k0FJSzM9dTG9Qd6W0Dr2lh9ynCRteVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymY3AL4ralITYwiegGvpt64sLuukXMF6wwWb9DaJTd0PopiYaM
	0CcCzWfPDwRTJkYrA82kXaGJ6r8KH21LT0M8IBdwICTO6N2ozXcYX0yu
X-Gm-Gg: AfdE7cnkG518oem7hJsE6Xhi8En2jJ+rc0zhOpotVQNXkA6SHZoyC3DdTUp6I4v5je9
	U6tNXbXFpv1waHJYi1ZnUXzmo8JyvzrYqO2YAh/e6oqdWnnr0sNQzmnABLvc1CzWrnFaK4gddqu
	iIjD4tSHGev4wdq/fpcmgsuKjBRtEAadRJQD1bYJiUmSFon5No395MgaRixmsNa6T7eqSff6bg+
	FYP2BL0LAt2IeT3YKXNjZbaPu6HnutU8YmAw5vmZlXrBXEiHcNybYce59fRClUAivLKfichlzeE
	4zhz25/C54Q+dD9UITeQUon9EsPKNvX1iXcjMTSGXNgU8QUbLsYK8UwLCsKWnr7nGWg2jgDxEqp
	9re47wBwCTH7FQbAOr43Hm0HrzJS8Lpymc42533+32+tKpq0L7i3p/xLEQolhd8x/V74XJ9rs43
	kwPfDRlBq2SHPIMLcQYgM/to1rlsduxUTIIOmxf7w1
X-Received: by 2002:a17:90b:5827:b0:38d:84db:c5d7 with SMTP id 98e67ed59e1d1-38e17e8f370mr1132180a91.35.1783987683353;
        Mon, 13 Jul 2026 17:08:03 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172b6d58sm558896a91.1.2026.07.13.17.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 17:08:03 -0700 (PDT)
Message-ID: <47f61a7ec3c41bbe3503723cd24d9d78db9a913a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] bpf: Factor out raw_mode-related fields
 in bpf_call_arg_meta
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 13 Jul 2026 17:08:00 -0700
In-Reply-To: <20260709230242.2003459-3-ameryhung@gmail.com>
References: <20260709230242.2003459-1-ameryhung@gmail.com>
	 <20260709230242.2003459-3-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-09 at 16:02 -0700, Amery Hung wrote:
> To prepare for unifying the helper and kfunc call_arg_meta, group the
> scattered MEM_UNINIT ("raw") memory argument fields (raw_mode, regno and
> access_size) into a new struct arg_raw_mem_desc. The intention is to
> make it clear about when these are set and used instead of fields with
> overly generic names.
>=20
> Identify the raw argument once, up front, in check_raw_mode_ok() (
> like check_proto_release_reg() does for release_regno), recording its
> regno. check_stack_range_initialized() now recognizes the raw buffer by
> matching that regno, so the separate raw_mode flag is no longer needed.
>=20
> Also drop the bogus raw_mode assignment in the ARG_PTR_TO_MAP_VALUE case:
> arg_type_is_raw_mem() only matches ARG_PTR_TO_MEM | MEM_UNINIT, and a map
> value pointer is handled by check_map_access(), never reaching
> check_stack_range_initialized(), so tagging it raw mode had no effect.
>=20
> No functional change intended. This patch does not enable raw_mode
> memory access for kfunc (i.e., uninit stack will not be allowed to be
> passed to kfunc for unprivileged programs). Existing kfuncs with argument=
s
> tagged with __uninit are either priviledged or dynptr kfuncs, which take
> another path to make sure the access is checked by check_mem_access().
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> =C2=A0include/linux/bpf_verifier.h | 10 ++++++++
> =C2=A0kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5=
0 +++++++++++++++---------------------
> =C2=A02 files changed, 30 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 317e99b9acc0..056b99d26cca 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1464,6 +1464,15 @@ struct ref_obj_desc {
> =C2=A0	u8 cnt;
> =C2=A0};
> =C2=A0
> +/*
> + * A memory argument a call fills in. The verifier allows the stack to b=
e uninitialized if
> + * the range is a known constant. Stack slots are marked as STACK_MISC b=
y check_mem_access().
> + */
> +struct arg_raw_mem_desc {
> +	u8 regno;
> +	int size;
> +};
> +
> =C2=A0struct bpf_kfunc_call_arg_meta {
> =C2=A0	/* In parameters */
> =C2=A0	struct btf *btf;
> @@ -1510,6 +1519,7 @@ struct bpf_kfunc_call_arg_meta {
> =C2=A0	struct bpf_map_desc map;
> =C2=A0	struct bpf_dynptr_desc dynptr;
> =C2=A0	struct ref_obj_desc ref_obj;
> +	struct arg_raw_mem_desc arg_raw_mem;

Nit: this field is not used in patch #2 (this one).

> =C2=A0	u64 mem_size;
> =C2=A0};

[...]
