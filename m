Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098E4A3417
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024473; cv=none; b=IF3BoRdjQydZDp0/ZAR4l/ZUMk8yvD/+AsHhXKporLwxmFDBdfoJINYWh6HIsWjFxjar9CWdOmLb8cKvgjoLHD/+gQmqVyrdD0sT1QvW/X/2xMiptSyK5iMnPNfW1kwaZ71GYp3RTJW7UEZGXAHvX/A2lAVEx5ol3luZyY6K2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024473; c=relaxed/simple;
	bh=WDmcAROiZzPtamIVySVJ0+BibdW1AO8nRjbT9ZEyGoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qWzvyJQwjEIOpVYzZhKMROarbo6YSXYViO6IsR0gwhIZhoiyQ9YJXvrw6e0C+ya96myBR/wjtYT2soS/jAfEia93S0xAVYrhEzPM4r7fn683RNbPRqZ1vyqbElujz6lPxJIvbXjnqWhZn9khDPp3znbVgtVwsw/2czeVcFRG0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE1KJOEi; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE1KJOEi"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30759632453so8624786eec.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781024470; x=1781629270; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nN5MW2PnNv4yAQd89c4hNRm4nd60DU2qj0yVzLTHfgQ=;
        b=JE1KJOEieOOlKJGRgX8eiMzTvNK+/DFOwma9VrfuMe1zXZ6xoa94jINYcgeBaghl+Z
         xwq38GjAvk3k42bxWycQVSF9XDh6u/Mi0YbE2sDoXWnPgYxcfEeQEAgpGhuxzY9O6oMG
         evJn4b3p6EueErSsuo+fRG4L0HGpY5zSPrl5UnJ+X6hjWkbeX4QoGD/GoYPge+6sD7BU
         jC5I6VGeA0o+PfRWCON9itDnpNUQgXqEH6td4lgMckEkK5v20B4Jq1CUmhJnHE7uX2mh
         v2kzXmE4SNyhDeRH6FN7eutwdAQg9VG13fi//W7rtLFqUh75CXaF0HjdQ9wCycShyZto
         qWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024470; x=1781629270;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nN5MW2PnNv4yAQd89c4hNRm4nd60DU2qj0yVzLTHfgQ=;
        b=cDQ1L8B8KNh9zHMi5NAWsaOJVfP+c33DYASJeqmkcPS85mOO6Gqc3V/jNV96GCUThD
         dMKvn3LgBtwns3HLAjDPVzgDsGm/USRR1ymoN2/bUQv57F8hWe3OmrhdmNaI3xGfj4lR
         V1qg+UZn9cXGAfi1Snk7IjVtvfzQWzTN6oJTFfZi72z1mhcm4dymDykJuC8l068AqM1T
         htEIMU8WOpJrWwXotQNoaw/cuylOzKQzfiOM5NZwOqkNYxJTEc8lp17MclBTAf9f0iL0
         +IOxvpgk6RZYpEgNzqcrB3a2HCS5nHfNpo51NIT2Gtp1urVZY6uRPyd0AJ1/QPQfiC2O
         Mgmg==
X-Forwarded-Encrypted: i=1; AFNElJ/ukwsf+ns6tUyOxqiC7eTqVUcg8fgfy+6Mp1jTRZ7B5PbgCKlb5WbJPcPopcCrvMui4WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OyoOCyTc8dfHhkthUr5gsKE0ooy9kLXp9eRyD0JmFuYsfRMq
	S/04O0lLLk7icw3L/g9P4VBqV4TK1uoNuCPZ2+Y9z8MutqC+82LrAZG8
X-Gm-Gg: Acq92OHhZ92R2MeNPllPRE6bQ2ACFe3aKVG55oizLxoau6lqO3ciCmtVOgi7xv36HQQ
	P8pyzLSCOVnQnFPrjXgwpZb/W7nzpRlIUvD6X0rSZ/xYRia39Z157pAJtW209HmXFI79ZyL0gd9
	mQMAQHVf5784cB+jMQPooFhZMZvyMWzUiDHPnTqUzk1eTAHw/L1AjMUEIvzv7U/OuUN4B15kzyG
	+KXj7x5czGkIWV3+RsaDFossWIQTwOTuD6GF8tVsGy19U3VvmtwwkpoQ7N9Vs3UHc8sce2LTCN8
	1B0WqcT0qDb4U3G08cU5hlqHokEmWBXNtW3Cu6f6sLjfRWc106iPvkHin1GgGP7DlrsQeQRsmHz
	nv9cyMhF/aMHY6UTLtqOtdRWOXbJjIAOTVW7JqrMtcr94Iw9sjfYQpJPM95AXsBKlkzF7YRAONQ
	dVJBk7694hPwMjDwWVxiHz6AJokiAgTVylTtM04C2JOZMnk6D+hzncxhHX9sh6X+OXwufD7Iv90
	QE+ojD/HdOeRPaYnxI=
X-Received: by 2002:a05:7301:1009:b0:2f2:32bc:787d with SMTP id 5a478bee46e88-3077b1f31f7mr11653007eec.23.1781024469439;
        Tue, 09 Jun 2026 10:01:09 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:bc91:a683:c279:a106? ([2620:10d:c090:500::3:1322])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df191d0sm31809976eec.21.2026.06.09.10.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:01:09 -0700 (PDT)
Message-ID: <c6cf40ef2957b6b2acf8820bce10becda20d9dfd.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject scalar addition from untrusted
 memory
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend	
 <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa	
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 09 Jun 2026 10:01:07 -0700
In-Reply-To: <20260609-f01-03-scalar-add-bpf-next-v1-1-e6212e274155@mails.tsinghua.edu.cn>
References: 
	<20260609-f01-03-scalar-add-bpf-next-v1-0-e6212e274155@mails.tsinghua.edu.cn>
	 <20260609-f01-03-scalar-add-bpf-next-v1-1-e6212e274155@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-09 at 22:55 +0800, Nuoqi Gui wrote:
> scalar +=3D rdonly_untrusted_mem reaches adjust_ptr_min_max_vals() with t=
he
> pointer as the source register. The untrusted PTR_TO_MEM case returns the=
re
> without updating the scalar destination, leaving stale verifier state.
>=20
> Reject that addition before the early return. Pointer +=3D scalar remains
> handled by the existing untrusted-memory rule.
>=20
> Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c8d980fdd709..c6b350f9585a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14823,6 +14823,14 @@ static int adjust_reg_min_max_vals(struct bpf_ve=
rifier_env *env,
>  				 * This is legal, but we have to reverse our
>  				 * src/dest handling in computing the range
>  				 */
> +				if (opcode =3D=3D BPF_ADD &&
> +				    base_type(src_reg->type) =3D=3D PTR_TO_MEM &&
> +				    (src_reg->type & PTR_UNTRUSTED)) {
> +					verbose(env, "R%d tried to add from %s to scalar\n",
> +						insn->dst_reg,
> +						reg_type_str(env, src_reg->type));
> +					return -EACCES;
> +				}
>  				err =3D mark_chain_precision(env, insn->dst_reg);
>  				if (err)
>  					return err;

Should the fix be like this:

  diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
  index 7d27ba396d32..9c85dd680a46 100644
  --- a/kernel/bpf/verifier.c
  +++ b/kernel/bpf/verifier.c
  @@ -13593,8 +13593,10 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env,
           * Accesses to untrusted PTR_TO_MEM are done through probe
           * instructions, hence no need to track offsets.
           */
  -       if (base_type(ptr_reg->type) =3D=3D PTR_TO_MEM && (ptr_reg->type =
& PTR_UNTRUSTED))
  +       if (base_type(ptr_reg->type) =3D=3D PTR_TO_MEM && (ptr_reg->type =
& PTR_UNTRUSTED)) {
  +               *dst_reg =3D *ptr_reg;
                  return 0;
  +       }
  =20
          switch (base_type(ptr_reg->type)) {
          case PTR_TO_CTX:

Instead?
