Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DBF33F9
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710452511; cv=none; b=T14LSPFm6+EkXZnUnF5iwAysRnrxDjBPVY8ZI3jSiWFnzuj/jp+mirgTthm39PcVoCxAiDZ/PbVS3ejqlxoET6iu17GborLNThbHN22RaWOVmV4Gphtgfgf2o4WEoqFFq3tuQTWLcT6FKd7dwyfdbcqUmh3EX5q0p4UOvJ4VyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710452511; c=relaxed/simple;
	bh=U40BaVsbyZtgZPjKR4JwpAN/kvS2sKwNyOF6/MufqXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F221KGWjSfyvi0f/fR6YPLUvsfiROxLS9V3sFRpxD0QNeTBWCvufPvsymJgyL5N+H9fJ8HpNAFLotn9qqr89xy/S+FKXzsvafG/EZXXqCw6qBI6UBJ3q6EWIOOE3WOux5lFbLrpouobTrlo9mAEpj0IEonQFSa1T79s5/77a158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHlFUovF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHlFUovF"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e8f906f3dso1249658f8f.3
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710452508; x=1711057308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOVmAs82q9PkzvhOlwBbk7xf9blttvpKPrM++xBQXGI=;
        b=MHlFUovFBxWVrIGMWjcbiCwHM+K/vrk9NPgbTfwrIDxCmAYc8x+ku+MTTcHiza0rKz
         H3W8xrBDsKzdThyi77knBbVM8OwvSFh45ZBy0WHH8o53NjqlDh6GlkPKstCJYu//Qk93
         T2//zAb47xHNYn+DZj5u7BO8/HcQfCtg+nD69JhWeQehDLCj08p2cpC5RjtQ83NXPw6i
         Qr5Bvv7mm+2C46yJvkmJTUCMNY10a0eENdwOfLNO7wj9HyfJr0mXgrwq3ytH32BcZF24
         +Lpzlj2dJS5DNQmBWBtDtksxFvlR6VB68s40XaBr7CJzOia1GGYZONQtq7aNT9D95esk
         +aJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710452508; x=1711057308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOVmAs82q9PkzvhOlwBbk7xf9blttvpKPrM++xBQXGI=;
        b=jl7jaNOnpCv6PDe+5wPJTbbeqsD5ZC1QmJ9gEzvHbQRKgL0iZ7XBvOL8D0nY6UhP+C
         stK3n65zD5i0Wi1q0laZILIO+Xx3cNVJQeOgyFTRMbXF0c/vAuaSECh413fvC5KNJHiJ
         O4TUX/CxTjjRcfWyKyMQ1GJRKQmfVyjqE7vwMoRn2Piiec+KXaNH0OkEXmogxab6+lE/
         DS5Q4s0wQY9vuiAQUlSf423axBl/wMEkOwnTgbgm9KM1hv63MKiru+6qPHojihx4P9dv
         OY36xZWstjtKkf0pIs81wv3i+JJOd7knsOjyfWjb4AvM4BzR/CKWEfOZzE1omXcWbR8g
         5Cmw==
X-Forwarded-Encrypted: i=1; AJvYcCWyKxyV6sjvWg2yD+XlBXljTEdwNOx925QYBRSkKQ1BMWlNQXnT/0/afIU+E0kKHw8ZTsloiqnoJMUelgraAgiiU8wt
X-Gm-Message-State: AOJu0YzR/bXPuIeltrAE2ty2hrCeO2N9EXBQ3gB7qSs2bYplG8CjiqrU
	GqG6Hb+Y3aGtf7Ae2r/gK2StxxUaXZwuly/Vr9E02ViyrjcJ/sAHd8yLwtlQ4Wq+ifLdA/2sMA/
	7IQp1gdfpLIIPtM2GgLJEZf8hxys=
X-Google-Smtp-Source: AGHT+IFjj9wl9Ca3VH5IcpgkzYbod8gr0p7xKqBuKYlEVSdedPKorqMZc+J/KJ4eqH1ynhabVFGcZg0nKmt/sjaO+7w=
X-Received: by 2002:adf:cc02:0:b0:33e:c974:1290 with SMTP id
 x2-20020adfcc02000000b0033ec9741290mr904782wrh.18.1710452508149; Thu, 14 Mar
 2024 14:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202162813.4184616-4-aspsk@isovalent.com> <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com>
 <ZcIDqnXFjsWYyu1G@zh-lab-node-5> <CAADnVQLfidjTWa4+kyRH-qC29gbGvFsRJHu6smcaL0Yk0HqgmA@mail.gmail.com>
 <ZcS1ZruKKZ1euzlb@zh-lab-node-5> <CAADnVQKH1aitaADzCo__PfMJJA2SxAvYjTS8Z7A6Y01G2OWJgw@mail.gmail.com>
 <Zc9p4e1EccPkMnmY@zh-lab-node-5> <CAADnVQJ+_+ok_io1_W7e5z_dZhxSqhEFZQkumRgmY4AJRYwW7g@mail.gmail.com>
 <ZehJFP11vi5sv/eW@zh-lab-node-5> <CAADnVQJnh+j9etPYkst7hhnepvsoBuJY-ds-AF0fn3VqqJNXNg@mail.gmail.com>
 <ZfK9Y5c7RuOu0YiN@zh-lab-node-5> <CAADnVQLXok7niyyvpUaJxq4pNFFrBP5Vsk47NNxw1V4ipBdRrg@mail.gmail.com>
 <CAEf4BzbkkrFACwWQQQkESrdRKWUvJz=NyWdrtu4v6m2aOJKztw@mail.gmail.com>
In-Reply-To: <CAEf4BzbkkrFACwWQQQkESrdRKWUvJz=NyWdrtu4v6m2aOJKztw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Mar 2024 14:41:36 -0700
Message-ID: <CAADnVQKdvKqNt0GJ5+vJFEHHjRF_YGUR_htrs+QjQ0SgUV5woA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Anton Protopopov <aspsk@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 1:06=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> >
> > > What could work and what I am proposing is to pass a list of bound
> > > maps in prog_load attributes. Then such maps can be used during the
> > > verification. For normal maps
> > >
> > >   prog =3D prog_load(attr=3D{.bound_maps=3Dmaps})
> > >
> > > will be semantically the same as
> > >
> > >   prog =3D prog_load()
> > >   bpf_prog_bind_map(prog, maps)
> >
> > Instead of a whole new api, let's make libbpf insert
> > ld_imm64 r0, map
> > as the first insn for this case for now.
>
> This sounds like a big hack and unnecessary complication, tbh. I'd
> like to avoid having to do this in libbpf.
>
> But I think we almost have this already supported. In BPF_PROG_LOAD
> UAPI we have fd_array property, right? I think right now we lazily
> refcnt referenced maps. But I think it makes total sense to just
> define that bpf_prog will keep references to all BPF objects passed in
> through fd_array, WDYT? Verifier will just iterate all provided FDs,
> determine kind of BPF object it is (and reject unknown ones), and then
> just take refcnts on each of them once. On prog free we'll just do the
> same in reverse and be done with it.
>
> It also can be used as a batch and single-step (in the sense it will
> be done as part of program load instead of a separate command)
> alternative for bpf_prog_bind_map(), I suppose.

fd_array approach also works. There can be map and btf fds in there.
I would only bind maps this way.
