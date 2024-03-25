Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5056673506
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384888; cv=none; b=dHgDIDNfyfeD1eWVlR9Y/VG97V7plM5/2zKYfEBPwlT1qdsBLdskVsPfspghbowQeAbzFSFHg+bZ3Eu+wlTwq1rQoTz3mv2LMDAZvHRnVd1YOqiobUvvE11Vl0epK418C9trNCSqug2eSbI5Gqh7kpkUMU/8dEQde7lNvtC5L1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384888; c=relaxed/simple;
	bh=1T9w3DXormCf+o1YL/Bod2kqxa7xAnTuUIK4uECpn6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQmDTgQRCbtx9HsNpfcBL8Hc5/SA7pjIeXzz5yLE6UyiJL/pbhnz94oXlg5cylzwex1U3RsDVM09ICcTbko/tdd1/Qmsg7YHY3fUdxGW5zbsogntb2injhqhd2qBEcvtS+W9quhVP02E9vYITF+iU+SAV6hOU/jFIxVVXhkcyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZN1WdieD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZN1WdieD"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ed7ef0ae8so3216261f8f.0
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711384884; x=1711989684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Umk9XThnTHyedoU/g11c6m9vYltjqXcMDxN5qxudwIc=;
        b=ZN1WdieDApTDQ0C5j/MfqvCwUTSNWEx6b2Fbg2RdP05QGBTxg71mhlk2TG4/cC1GOG
         1QuLEveO4g2vsq8uP56iIZ/nyUaLRWej80Qt/arTNKL3ujv0P0zyhLm9m6vFz9Oh2Toy
         3j/TRyt5DlLOvWkjVB3t7iQT5Z6dVNIw4ptjngWuU/amPV4sMat2UgIsV4tXpa8e93KC
         gI01g00n7cVc34YFc+yoBRUzpdC1jz8a67xhjskKVbsoR1C+J6YMSDkXyirTWEcLzJQ7
         a+sp17jhZVqpgKaFK9NqnkL+kHZU/EzcVN0V1FuIbp0sCegaoiPsaugKi4VFMTSOdXbF
         R5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384884; x=1711989684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Umk9XThnTHyedoU/g11c6m9vYltjqXcMDxN5qxudwIc=;
        b=Lj9//SNSgA6LZmsN4KU9wPGurC/2XmdbPzEWacC/lp0V1xmOOPFSmOi/7t0Cuc1s3y
         MK6hK0PNKS4hUQ5DBYCqGL3QeZNuux47mCQPHSnK0+9eQOOzh7aInWm+RcRGm8YDTEjc
         vhahO/m7uLJUo//1EIOAXd9yc8xSaMp8xcwQXX8OfLeqQhgA6zIhiY8oA3rhqUV3CCT3
         BqlnMz5mXEcWt9SAuhecLmB6l64oUD2JlBRyq2JsoCIlMHPCIktFR2fdA100CCClFqjk
         xBVxUAbAIj3L442fJ7mCU20uHxEBYeizevNc/0DdlrwXKBEZp3uNmYa1RbxCe/zJzU6O
         E9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvnKzVXDhLgssSZ659N947GeBC7Bbibcs4DWnzujmP8u59QF5oT92v3Pj+wwNPclxoNEvA52ii5/ZenQENaDRH8vhK
X-Gm-Message-State: AOJu0Yw3t8ae8KH6tm6hW3C9DKPXGbHyW62Ty/K+f9ySKSCqv9oIJGRK
	SplEeKBRw8U3RjruSEsMTuoSvyq0V37qX3eZPj42AffEY9Zl/YZ3us6Qg5PXKjMrE5s7DRk0zDc
	S7gES5xUF5UijTp2dIorrLHuqJQc=
X-Google-Smtp-Source: AGHT+IHYfHIL+QDixYDj7j6HXXKzIzSf1vS0yAKuTIoMO2MOMtS5HHC5rFr7awrgQKgKdwiGdBH0u9OEuVIbiKG+GVg=
X-Received: by 2002:a5d:4bc7:0:b0:33d:a190:f0c with SMTP id
 l7-20020a5d4bc7000000b0033da1900f0cmr6170751wrt.16.1711384884538; Mon, 25 Mar
 2024 09:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322102455.98558-1-alan.maguire@oracle.com>
 <20240322102455.98558-10-alan.maguire@oracle.com> <CAADnVQL+8cm10fg69nqnDKQaSfoFK7NPwa16CB7PQJAdCHsBKQ@mail.gmail.com>
 <96c014da-9ee5-4c54-99ab-bc0ad87f5390@oracle.com>
In-Reply-To: <96c014da-9ee5-4c54-99ab-bc0ad87f5390@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Mar 2024 09:41:13 -0700
Message-ID: <CAADnVQJzCGohcg437Zv1-yA=OPTRAVKTHVkaw5p5HD=7O2updw@mail.gmail.com>
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

On Mon, Mar 25, 2024 at 2:51=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 23/03/2024 02:50, Alexei Starovoitov wrote:
> > On Fri, Mar 22, 2024 at 3:26=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> Support creation of module BTF along with base reference BTF;
> >> the latter is stored in a .BTF.base_ref ELF section and supplements
> >> split BTF references to base BTF with information about base types,
> >> allowing for later reconciliation of split BTF with a (possibly
> >> changed) base.  resolve_btfids uses the "-r" option to specify
> >> that the BTF.ids section should be populated with split BTF
> >> relative to the added .BTF.base_ref section rather than relative
> >> to the vmlinux base.
> >>
> >> Modules using base reference BTF can be built via
> >>
> >> BTF_BASE_REF=3D1 make -C. -M=3Dpath2/module
> >>
> >> The default is still to use split BTF relative to vmlinux.
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  scripts/Makefile.btf      | 7 +++++++
> >>  scripts/Makefile.modfinal | 4 ++--
> >>  2 files changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> >> index 9694ca3c5252..c8212b2ab7ca 100644
> >> --- a/scripts/Makefile.btf
> >> +++ b/scripts/Makefile.btf
> >> @@ -19,4 +19,11 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)   =
  =3D -j --btf_features=3Dencode_forc
> >>
> >>  pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_ex=
clude=3Drust
> >>
> >> +ifeq ($(BTF_BASE_REF),1)
> >> +module-pahole-flags-$(call test-ge, $(pahole-ver), 126)        +=3D -=
-btf_features=3Dbase_ref
> >> +module-resolve-btfids-flags-$(call test-ge, $(pahole-ver), 126) =3D -=
r
> >> +endif
> >
> > The patch set looks great to me.
> > I wonder whether we should drop this extra BTF_BASE_REF flag
> > and do it unconditionally.
> > Currently btf_parse_module() doesn't have any real checks
> > whether module's btf matches base_btf.
> > All the btf_check_*() might succeed by luck even if vmlinux btf
> > is different.
> > Since .BTF.base_ref is small we can always emit it and
> > during module load the btf_reconcile() step will be that safety check.
> > Less build options, less moving pieces and doing it all the time
> > will make the whole process robust.
> > Conditional BTF_BASE_REF=3D1 will likely mean that there will be
> > bugs that only few folks will hit.
>
> We could certainly do it unconditionally for out-of-tree module builds
> (the KBUILD_EXTMOD case); so anytime a user does "make -C.
> M=3Dpath/2/module", they would get base reference BTF. With this series,
> that would just mean applying this change:
>
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index c8212b2ab7ca..0322f8450a89 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)
> =3D -j --btf_features=3Dencode_forc
>
>  pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D
> --lang_exclude=3Drust
>
> -ifeq ($(BTF_BASE_REF),1)
> +ifneq ($(KBUILD_EXTMOD),)
>  module-pahole-flags-$(call test-ge, $(pahole-ver), 126)        +=3D
> --btf_features=3Dbase_ref
>  module-resolve-btfids-flags-$(call test-ge, $(pahole-ver), 126) =3D -r
>  endif
>
> So with this approach, in-tree modules don't add base reference BTF
> since they don't need it, while out-of-tree module builds always do.
> We could arrange for bpf_testmod to be built both ways perhaps to ensure
> both approaches get tested in selftests along with kfunc addition etc.
>
> For adding base reference BTF in all cases, I ran the numbers on adding
> base reference BTF across all kernel modules and for x86_64 with 2667
> modules. Base reference BTF adds around 4MB in total. Not huge, but for
> in-tree builds, the only cases we've seen that triggered BTF mismatches
> have been broken cases where vmlinux got built twice during kernel
> build. So my suggestion would be to limit base reference BTF addition to
> the KBUILD_EXTMOD case, and make it unconditional for that case only.

So 4M across 2667 modules is ~1.5Kbyte per module ?
And how many modules out of 2667 will be loaded?
Even for 100 loaded modules it's just 150Kbyte of extra memory.

But I'm fine with sticking to KBUILD_EXTMOD only.
Let's make bpf_testmod with it though unconditionally.
No need to build it twice.
