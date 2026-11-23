Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463169;
	b=sxE7gAsWAQ4Q7rpqxIV+eMPipg4r9JwRnR9TjX7gnenStSD8LSRqV7KoKAl2p7fFbZ0O
	 q6PwXBCsrW7M+R/UaxFX5p8EOiIxn3g25BmlYVS7R58mpa6QAD8vKteMZZpDerJk2Fqm4
	 NKqYmt1iBFDNE4+8UCLFPZ95n3hC9L6+uT68s8YxNkcj6UAW2UkUJEBE5HTepmodoOR85
	 Mrs+Z1GGoE6D6j0wVhJfkTJZMCfg0GOhYRXt2JR8eMkTYsWtZfhSrk5eJO6LGWHDJDvn9
	 GHFJReQMFv44FXQOVKgNrYYRdyupeO5wrorTC5Lymv7TU0XsF2iLhd4H0nL7WBo8jRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=+oTeWEIZYvGUzs7OiSyKKI+4MzSKO59unTd0y8MRQwU=;
	b=SiSybBSfwjGFcEGRseRJZY1UhIfMv/Jz6Ih6myfUU1I+qLjtvARDU1jBnYDfvRjMMwOE
	 h8cfAv6BP1Ych+4CVBH4BVLp7vdCVpkK02zaFU/9slYdhLDv1Me2vzQ9PWqkoB53wX1rd
	 PEXeAKJq+ZOY8IleUMe1OJ4Ze5rMQ8PSKrQBtIkup1+ofqv/Ed12qXWqzbIuBU1AEZEKJ
	 hdnvL6aps7XN9avvSPWiVWcNmyqnlI0nMj6u9A2YPYF755A8y7d8gMY18CkNk+xDWVEsG
	 sLklcQOTiz9FQPXb+qAmh4yx4QWn4t84ouDXRsRDv9lrO50vSWiIvwANcwVMifTUfUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MFzc9cdS;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0622606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 19:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0622606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MFzc9cdS
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso1840854a91.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 11:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795463168; x=1796067968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+oTeWEIZYvGUzs7OiSyKKI+4MzSKO59unTd0y8MRQwU=;
        b=MFzc9cdSeIc0xnvgDnyqVFhMq30gHLI7/3oyOhAJjhYeG6gz6DN2eJ4EyCT3haueLx
         dU9Znxsvkq5EJVI80krRc5xWijRQZNLAJVMxAyFuppFn4v417RwHFl04eYmcBjwCpJuD
         I3eQmog2RnPLzGHtM8mM7EcRmyzZkwklWoo5JBY6Jbiojq3cjkE913agY/dRu49M3FCx
         momiJB5lfK+o8lGgyGnD8vBhEPZXi0rgAd8mQkP9XuMBLZsFZ96KJSj9uN8KM9rxrl64
         jbbyAMoerKr/0AySbwvpolPu96gOJ2fcvgDLHmsBdyYXWbp8epfYjtZEgpAa9YyE7G3b
         wkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463168; x=1796067968;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+oTeWEIZYvGUzs7OiSyKKI+4MzSKO59unTd0y8MRQwU=;
        b=RkjqK9iTJs3XEbtLuonOTHqDGcfMh4fWyELd3PKOYzDWip0jOj2I/8jNGJ0QJSbpMX
         fBLrNsc9oGYLFxH50709/UCexHpB63zzGnY6USHLxgIAvvAAR4iNYyGo57nEXACl8DLD
         aBxFSpPs2FM1A2fNiSWTYhE3vjxhlNObBsBUOsUSbJV5iWKUx0D+F29ZoxXWwLu7/5G1
         MblEQvaGM+DZhheHH3ani8NGsTAtWA+zr6WF7bTcnnJh2ooqPzb8Pm/wFTBVlKxqwp1f
         qI3eJsUBmS9j9MeTVRDroeiE6QWc5T8yYuS7mDLzeq9qMYyxjCq947Zrk6SoQSJ8s64J
         y4IA==
X-Forwarded-Encrypted: i=1; AL+hErGkE8ZQCk6IXuJ2egbWB3+UUABgeKW8h+VDDLxeDbiOK2f1ZyjuP9Stnuy8wR9piDYHswk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Tp/GY50q+ZE5XmZxNIk0MEOM249WtD1I8qNpwBZmVkstrYgVm
	zMV9q8uGcFd3RZot1fhoSC8cbiMuTNzCGXn/+AIwp/HJXJYuWnzJTneF
X-Gm-Gg: AZFdTZf/oAVj3M76WKYgGvL0PBW/9PBWsaC+ZkdC1TdM3turT5tXe1kSu20eNzBKpAY
	PooWUezQWopaz7kypu3oeQSXgOiIHkDP7ZqAcKeidgTF9kIzexnex1cMeIyeA8Hn0xlNa3nsNPl
	2lZo3FLyfrKWKfWe43sFwpLdfHzLSqLX+SwkhXRXjkRkwagBd6CI8oDByahWWEcGevG/7t96Wt8
	IFLMGMjMFWodUz3B84OeJqbY9HUTcUBXlu93Y8LJ3EXP6L5auY0L9BxNFC4pq0efd7JDlWNbFmZ
	P7DaYOecJ46YMJTj4cgzSUdjWds+lJmdMIT4IuBMiPYeI2D+yfkqGlimhOMFxPjr+Fg3RB1NADt
	aij3k3MObTlTiS4N+hNxOhCG5TFWXCgYdSFLZmydTr7AbhnPeRYxB5GVMF/ci1LD+wTXTHRY1Wz
	FJ++OSp5ijtvy9TGgLL5mPHnHJl5HkptMX4CeNrfWbD8hbrNXGDWuXU7xAXJ+DDgbooQJr9VCma
	SfRyjF8DR+gRFV3uG1YhroR80qOSMLZoChqk8QnF++jv4g3V/7m/u/TWroM7P1gFICV55XkhoHB
	XCbdReWuhtl/r11rxhDWif07NTrslcXxAn7PKW+bX6IOBRqCdAwdJbo2KA==
X-Received: by 2002:a17:90b:4ec4:b0:3b3:bf8f:9ccb with SMTP id 98e67ed59e1d1-3b41c8ffa94mr9996644a91.18.1795463168019;
        Mon, 23 Nov 2026 11:46:08 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b3c71192sm2963167a91.5.2026.11.23.11.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:46:07 -0800 (PST)
Message-ID: <d678f6992169065c5f1e67b89d39ad6a463923c8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 0/3] libbpf: Fix CO-RE relocations of
 unsigned 32-bit enum values
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, vineet.gupta@linux.dev
Date: Mon, 23 Nov 2026 12:46:06 -0700
In-Reply-To: <8fdf1b51-7368-46e0-80f9-744b15845ad0@linux.dev>
References: <20261120214957.868409-1-yonghong.song@linux.dev>
	 <fc517c55e7060cf7c0da6e797a602488cea403fd.camel@gmail.com>
	 <8fdf1b51-7368-46e0-80f9-744b15845ad0@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-23 at 10:01 -0800, Yonghong Song wrote:
>=20
> On 11/23/26 9:45 AM, Eduard Zingerman wrote:
> > On Fri, 2026-11-20 at 13:49 -0800, Yonghong Song wrote:
> > > For a BPF_CORE_ENUMVAL_VALUE relocation, libbpf sign-extends the valu=
e
> > > of a 32-bit enumerator even if the enum is unsigned. A value in
> > > [0x80000000, 0xffffffff], e.g., DCACHE_PRIVATE of enum dentry_flags,
> > > then doesn't match the zero-extended value clang emits, and the whole
> > > object is refused. And a target value in that range is patched
> > > sign-extended.
> > >=20
> > > Patch 1 zero-extends the 32-bit values of unsigned enums, i.e., with
> > > the kflag 0, which is the form clang emits. The kernel builds the sam=
e
> > > relo_core.c, so it gets the fix too.
> > >=20
> > > GCC emits every 32-bit enum value sign-extended, since its
> > > __builtin_preserve_enum_value() returns int. So with the change above
> > > alone, GCC objects that load today would be refused. Patch 1 therefor=
e
> > > also accepts the sign-extended form of an unsigned value, and patches
> > > the target value in the same form.
> > Hi Yonghong,
> >=20
> > I checked LLVM and GCC definitions for __builtin_preserve_enum_value().
> > LLVM:
> >=20
> >    clang/include/clang/Basic/BuiltinsBPF.td:
> >=20
> >    def PreserveEnumValue : TargetBuiltin {
> >      let Spellings =3D ["__builtin_preserve_enum_value"];
> >      let Attributes =3D [CustomTypeChecking];
> >      let Prototype =3D "long int(...)";
> >    }
> >=20
> >    ---
> >=20
> >    gcc/config/bpf/bpf.cc:
> >=20
> >      def_builtin ("__builtin_preserve_enum_value",
> >                   BPF_BUILTIN_PRESERVE_ENUM_VALUE,
> >                   build_function_type_list (integer_type_node, ptr_type=
_node,
> >                                             integer_type_node, integer_=
type_node,
> >                                             0));
> >    gcc/tree.cc:
> >=20
> >      integer_type_node =3D make_signed_type (INT_TYPE_SIZE);
> >=20
> >=20
> > Meaning that the two indeed disagree. Given that GCC version can't
> > express 64-bit values, it appears that GCC side definition needs an
> > update. Would this allow to avoid GCC-specific workaround in libbpf?
>=20
> Yes, I am aware of this issue. See
>     https://lore.kernel.org/bpf/a4aec2b1-f754-48ed-a7d7-ef07bed43eb8@linu=
x.dev/
>=20
> I even suggested a solution:
>=20
> diff --git a/gcc/config/bpf/bpf.cc b/gcc/config/bpf/bpf.cc index=20
> 3ef93938222..45d5337bab6 100644 --- a/gcc/config/bpf/bpf.cc +++=20
> b/gcc/config/bpf/bpf.cc @@ -1048,7 +1048,7 @@ bpf_init_builtins (void)   =
                                        integer_type_node, 0));
>      def_builtin ("__builtin_preserve_enum_value",
>                  BPF_BUILTIN_PRESERVE_ENUM_VALUE,
> - build_function_type_list (integer_type_node, ptr_type_node, +=20
> build_function_type_list (ullt, ptr_type_node,                           =
                integer_type_node, integer_type_node,
>                                            0));
>=20
> diff --git a/gcc/config/bpf/core-builtins.cc=20
> b/gcc/config/bpf/core-builtins.cc index a5c973cd385..289d3e67d78 100644=
=20
> --- a/gcc/config/bpf/core-builtins.cc +++=20
> b/gcc/config/bpf/core-builtins.cc @@ -877,8 +877,12 @@=20
> pack_enum_value_fail:     else
>        {
>          ret.reloc_data.expr =3D tmp;
> + /* Extend the enumerator to 64 bits according to its own signedness, +=
=20
> as clang does, instead of expanding it as a sign-extended SImode +=20
> CONST_INT. */         if (kind =3D=3D BPF_RELO_ENUMVAL_VALUE)
> - ret.reloc_data.default_value =3D enum_value; +=20
> ret.reloc_data.default_value + =3D fold_convert=20
> (long_long_unsigned_type_node, enum_value);         else
>           ret.reloc_data.default_value =3D integer_one_node;
>        }
>=20
> Vineet Gupta will take a look.
>=20
> Discussed with Alexei earlier, the suggestion is to proceed as is for now=
.
> It is not clear when gcc will implement this.
>=20

Had a discussion with Andrii on this topic with the following conclusions:
- pahole 1.24 is 4 years old, it should be acceptable to bump minimal
  pahole version to get reliable signed/unsigned enum information.
- such a bump simplifies the fix, effectively moving it to:

  static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
				      const struct bpf_core_spec *spec,
				      __u64 *val)
  {
	const struct btf_type *t;

	switch (relo->kind) {
	case BPF_CORE_ENUMVAL_EXISTS:
		*val =3D spec ? 1 : 0;
		break;
	case BPF_CORE_ENUMVAL_VALUE:
		if (!spec)
			return -EUCLEAN; /* request instruction poisoning */
		t =3D btf_type_by_id(spec->btf, spec->spec[0].type_id);
		if (btf_is_enum(t))
			*val =3D btf_enum(t)[spec->spec[0].idx].val; // <------- take care of a =
sign flag here.
		else
			*val =3D btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
		break;
	default:
		return -EOPNOTSUPP;
	}

	return 0;
  }

- we don't want to workaround GCC bug on the libbpf side, let's assume
  that __builtin_preserve_enum_value() always return long.

Wdyt?
