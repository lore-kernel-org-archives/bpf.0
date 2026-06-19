Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B331E823
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781899528; cv=none; b=imvLWPpVZp+sKrhsEcbO6O7kDrjo1nvQaDlTFGGmF/h7q7qJqmp6rIqmf6RQuRUu132T2mqLcHQl5NgdIyQz7HWkpgmYk1g3HGS2WM7RyqfUJJlGhCYChG6C1c2p20mbdRHGce0hgOW0ioz0Tesklh3DYRjh6pvEs8qC0ZF2v/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781899528; c=relaxed/simple;
	bh=0T4Z7K/rb2nHa13lr/ex8NbDdCu91yZhRTr7Sid9GFM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hNAtc+qpESyODV06N1At67NqHuFVaLTEhxmuYZPgf9evCf+0Z45AG0RN7KdhwJ8Gj+pgJCDTngINb6dETgH+Dpvxv0rlnTN8bDEi46eA9VcRDzEg8JCgWsp650lzBqXlXTr4ucS0Wa6tgZJZJYfROrIUs9gTwGcfvoCr1MzYbxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4On/ejR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4On/ejR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c68190ade4so25559025ad.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781899527; x=1782504327; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zH4OXFXG3GUtu3xSOVczzw0mmgwnoj/HVff9AySNWfk=;
        b=O4On/ejRCxff79FXdpvy8qxPlHq67Q/v64j/KfEDq7ma+IR6aJSodNYEVpXxJp2z8/
         ZJTJCwJVzTAdv5HoCCVkTbdCDSw7XW6ukrd9rMm6sobdxTsmqHVQatZUPxqfqX9oZfXc
         BSAPxyFGSXe4dz+9iU8TaUHSc2kPL/zmoQEkHosdwXWgLxzXuo0SVxWGRFuCtDUeGazO
         WZQVrQska7zYxBkUBQXIDc+LIoa7A3sYc/YZ5o+SCcwKog58/5E2hQPhY5+19gplz+LU
         ORCQLy2MhqBUe/ZWEp84T2+tfj3WXGjBkNYhLPT4frlf7DL17UrAFLlh7F9JieHdfAKf
         JF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781899527; x=1782504327;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zH4OXFXG3GUtu3xSOVczzw0mmgwnoj/HVff9AySNWfk=;
        b=FTU7FOfoWUMNJ1mDwgqhsmS3HK4vcKAJ0btwh2FKwDOnXH1YlWTSJwpSgaBELJVbOH
         aKmh+9sgpQMkIqMthWyY3wu3qYQsEq1SGr/3FCxCh98ew4j3W6OjRe/y8swF7lEDJKwl
         Ma8wgEwP++CM3LLGokjjzxh/L7Fyghs8KT32gVuSPHq7ycfO2vTnunGgY1ILCVQBqHZw
         i8/aFMWlJJqBzjfYBU8VNLi57+2tyyyVhXqn6Ummjtuz/antpPYEmEFgoOHaoUh/Lp2R
         US6Fzuvn+hBmc3qIcBIkBZTJpf0n6HEg0XhrbqXsTBXGBplgfFadKqh1/QxEq8gz9CH6
         Qg9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9zqysDhSorN5Hmrkh4+iA4/PApotn9B2AwwTP4dOoBvnSUX53tVLOZ+JjnBYApaaYF5OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlL0xAz9KGedfbJmvli8InbgMCLH5mmYfBSEMfsJL13eXMx1bf
	Z1jJRcpcsBL7+yBRMLw1/fsrTzYNprYPGXJcu9VzBny62hY7qs1wZG9Z
X-Gm-Gg: AfdE7ckttixmxQviW2rGyef1TE6mWtYPKodqsSNiPw567WK4Whc0eBC9zmsVm6QLeGK
	7+ybcdTwuUJIomzzuW/Bw9ONVpXa2Aw6y+et8PgXjaewHEGVuQgH8bNDaZza1wC6VD1Crzj2pt3
	X2jAAWkvcRNVhx5pAnM9VJL7lmwg8KTif+ToFKUE/E5l7zESb+9I+gP6iG2gOWquncVBw79Y+1/
	v/BTZfSHlaivvM0LD+bbv1n05Z6fj88PooLeALoJLXLDcvdUjGDtP8ev5SeOhU10g+aAv875e+L
	fzik/XJ9udJazeAz+AfjmULZcskc6mLNSu/rPQ7VGBFQhEMIvAlAC8Ug+OeYgsXk08RsoPfi5eN
	+hMPCHM3+Yb9yEyOupinfJ34BA9y4FKAgP2Jpd4X3CgXxMQer7RBzLNwdVwQlmlerIB6GG4sHxT
	1mlOsv5GwBE5H8qmDZfS+tcT+fv9AU/v8uuqXr5nnOCg==
X-Received: by 2002:a17:902:c401:b0:2bc:ac76:c1d0 with SMTP id d9443c01a7336-2c719626ed0mr40699335ad.17.1781899526920;
        Fri, 19 Jun 2026 13:05:26 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8d1dsm2592035ad.51.2026.06.19.13.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:05:25 -0700 (PDT)
Message-ID: <a15079723c8834a2baf3f35c6a8ed52c63addeb9.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Require CAP_BPF for pseudo-BTF ksym
 loads
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis	 <emil@etsalapatis.com>, Hao Luo
 <haoluo@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 19 Jun 2026 13:05:22 -0700
In-Reply-To: <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-1-f950f69fe60c@mails.tsinghua.edu.cn>
References: 
	<20260620-f01-13-pseudo-btf-id-cap-bpf-v1-0-f950f69fe60c@mails.tsinghua.edu.cn>
	 <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-1-f950f69fe60c@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-06-20 at 00:04 +0800, Nuoqi Gui wrote:
> BPF_PSEUDO_BTF_ID is resolved before the main verifier pass. The resolver
> looks up the referenced kernel symbol through kallsyms and rewrites the
> ldimm64 immediate to the concrete address that later becomes verifier
> state.
>=20
> Require CAP_BPF before doing that materialization. This keeps typed ksym
> address resolution on the privileged side and prevents loaders without
> CAP_BPF from receiving a verifier log that contains the resolved address.
>=20
> Fixes: 4976b718c3551 ("bpf: Introduce pseudo_btf_id")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ed7ba0e6a9ce..dbf5df995fc2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17639,6 +17639,11 @@ static int check_pseudo_btf_id(struct bpf_verifi=
er_env *env,
>  	int btf_fd;
>  	int err;
> =20
> +	if (!env->bpf_capable) {
> +		verbose(env, "BPF_PSEUDO_BTF_ID loads require CAP_BPF\n");
> +		return -EACCES;
> +	}
> +

Thank you for identifying this issue.
I think the correct way to fix it is to extend the `is_ptr && !allow_ptr_le=
aks`
logic in kernel/bpf/disasm.c:print_bpf_insn().
Note that it seems there are additional cases that are not covered,
something like below seem warranted:


  bool is_ptr =3D insn->src_reg =3D=3D BPF_PSEUDO_MAP_FD    ||
                insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE  ||
                insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX    ||
                insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE ||
                insn->src_reg =3D=3D BPF_PSEUDO_BTF_ID;

Could you please double check?

>  	btf_fd =3D insn[1].imm;
>  	if (btf_fd) {
>  		btf =3D btf_get_by_fd(btf_fd);
