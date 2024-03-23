Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7AA372
	for <bpf@vger.kernel.org>; Sat, 23 Mar 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711162262; cv=none; b=tV4IpWNxBi0ry0d8ZoCHQkXr4putp8iMYNpZMwa8gzC4LJcLISaMgB3ZCMyAhERQ1k1rF+2ETKQOEEWmx/OrF5RtVUdMu2Wpj7xfxH5f/TxANA5xTvdsqRbRo2/t5JiK3Ci/FmfT0rCY7ZeV6hFDucyRDFjk7anm7ZS1RrokeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711162262; c=relaxed/simple;
	bh=f9lERx2Ct2zShmHbmeTmla4YH50WNtl4E4887p4wb4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlZtlouoG/9Eyvoc3LmL9AClqeammm9njntLqbewseNcsL+qbj5APm7h/3lC1l/jLBNAwYQJZasxdM53ufKKjsgHzndBJBjhC/dNE2DMQEtIO3NK8E+QKTaY/Eys5kFYU5JidAChK6QVw1IuFWdPNrAX1ygh+5Ig0/0MTn9kCOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw0tBrp2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw0tBrp2"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3416df43cabso1547211f8f.3
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 19:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711162259; x=1711767059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQUx2vE8BQ5jxguTm0onuzBdW40ZtfM/fCqcLcKTNyo=;
        b=lw0tBrp2cihIWCLK5aW33fcYoeLr2BvTgetQYbBrVkdrHienPE6TbLXV5QSlCfCWXm
         b1w+fwAax+e53j5qOd31w58glNP2nZfQUzrBEAdBzEL9R1xxWIi1bF1AEyF8Jm8RAG8m
         nEnWaB1cP16p1RdsL/1ZjoJ0Gxx+Y33nHevsCaZEpA2PPfrxOEqDCTnFryXqeakLHFQE
         uzKxhx92TsIDOO3+nu6/5fdSVzNhTWBdg90ig5FG0B4sb+AU3a+ouwG7cNHaPt0lfT1J
         kB0GY8KB1Vlli5OsOuewpOS36eetAZQ18jshootHpRGXXUMyJiYVq9K8s0sgJNYkX1Uz
         AbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711162259; x=1711767059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQUx2vE8BQ5jxguTm0onuzBdW40ZtfM/fCqcLcKTNyo=;
        b=BRzTpGLyphAy6udSBHncYPMdRn08hIP2QgSfAH/prApfrNo0g53qI7TA6iKBwSq7RE
         E5fSQaoABAA9hd56pnVK2JwBD3fAiifbHqPRPtcFP2Bk6MzKs1M/lww4Neu+4chGON8z
         qeh7phak3Q08we0U+9rYc6inlHIGW55ZCv11BrY3Ojy8XlnuzRq3Ok4zCm318o8KgQW8
         k3s2ZrWlBX5qWLh8ecnvPZ04Y7+DWBBTs+WsSWwAtpH+q8kyhBFFKK7T5yletOvWbXkg
         3iqZx2/NfbakWiPMQOwOqJHby4OZ+6C1I2rNOSRgyBPsT30DL/6kkLmKS89uRxbREt3T
         xnug==
X-Forwarded-Encrypted: i=1; AJvYcCXgT6kqktcHQw6dqpNka+RRGsl34zRHLIXvaM8gJAaI7UZvP1G1EixyRtsbT9DeQlXshcvt+eucm31vUbJ47rFyEPyR
X-Gm-Message-State: AOJu0YxGgWMKhDPYJexWludvsGBHrjM8/IpDD0I1LuWXXVcLYWub7RmM
	Hd8pcIKso95LWBROux5BuVRMrGEp1jOU2L4E8DGYkyq2Gu1Z5ewmOOGJmHrdmjdQ4wQjOPCynm2
	JVoHoZ528mhj0qYGjVSwYQUmepqc=
X-Google-Smtp-Source: AGHT+IGu4Iwwdz97oOTI04jkNs/KuEncsqhUT2/ybmUpJlWzDijZxI57b5DQE5MzzsQGPWrRCMVPvowoTZyNHI4rkSo=
X-Received: by 2002:a5d:528d:0:b0:33e:78c1:acfa with SMTP id
 c13-20020a5d528d000000b0033e78c1acfamr604248wrv.1.1711162258527; Fri, 22 Mar
 2024 19:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322102455.98558-1-alan.maguire@oracle.com> <20240322102455.98558-10-alan.maguire@oracle.com>
In-Reply-To: <20240322102455.98558-10-alan.maguire@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 22 Mar 2024 19:50:46 -0700
Message-ID: <CAADnVQL+8cm10fg69nqnDKQaSfoFK7NPwa16CB7PQJAdCHsBKQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 08/13] kbuild, bpf: add module-specific
 pahole/resolve_btfids flags for base reference BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Quentin Monnet <quentin@isovalent.com>, Eddy Z <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Hou Tao <houtao1@huawei.com>, bpf <bpf@vger.kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:26=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Support creation of module BTF along with base reference BTF;
> the latter is stored in a .BTF.base_ref ELF section and supplements
> split BTF references to base BTF with information about base types,
> allowing for later reconciliation of split BTF with a (possibly
> changed) base.  resolve_btfids uses the "-r" option to specify
> that the BTF.ids section should be populated with split BTF
> relative to the added .BTF.base_ref section rather than relative
> to the vmlinux base.
>
> Modules using base reference BTF can be built via
>
> BTF_BASE_REF=3D1 make -C. -M=3Dpath2/module
>
> The default is still to use split BTF relative to vmlinux.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  scripts/Makefile.btf      | 7 +++++++
>  scripts/Makefile.modfinal | 4 ++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index 9694ca3c5252..c8212b2ab7ca 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -19,4 +19,11 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)     =
=3D -j --btf_features=3Dencode_forc
>
>  pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_exclu=
de=3Drust
>
> +ifeq ($(BTF_BASE_REF),1)
> +module-pahole-flags-$(call test-ge, $(pahole-ver), 126)        +=3D --bt=
f_features=3Dbase_ref
> +module-resolve-btfids-flags-$(call test-ge, $(pahole-ver), 126) =3D -r
> +endif

The patch set looks great to me.
I wonder whether we should drop this extra BTF_BASE_REF flag
and do it unconditionally.
Currently btf_parse_module() doesn't have any real checks
whether module's btf matches base_btf.
All the btf_check_*() might succeed by luck even if vmlinux btf
is different.
Since .BTF.base_ref is small we can always emit it and
during module load the btf_reconcile() step will be that safety check.
Less build options, less moving pieces and doing it all the time
will make the whole process robust.
Conditional BTF_BASE_REF=3D1 will likely mean that there will be
bugs that only few folks will hit.
