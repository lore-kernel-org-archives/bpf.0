Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA6D1A6804
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 01:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500972; cv=pass; b=EIjjYvFpf9niK1gWMu4xa+k31j1gDNRaSf5U+epgWLZxyngoQ6qMfmv+HPo03rhDt3Lo/hcd4bP9s1bC2gFvJjlrny9f75eH/mB/KcwgLaIGS90XFExa54WocD5Sqyt5oHIhCtIDXq5c3dN5D6K+dzwKj9Shk8/wcesFiNfsYdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500972; c=relaxed/simple;
	bh=gbgQ8CGwYBaGpra6BJW0UGovLFJFUbkHN9kIy60ugm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrpxP+BMBbIO8KnAXzOxST2CD52z1060GhzX9VS/IH8x9b//2k14ARnheSBJ20sWB7VdRRBit8vMYvH8xSKrgBrTWFvm59lY7ZrfAetXhtft7chTglxg+I6hScpmi3hZ3jHW0PYOYL9+ldBDQhBBsOj1yIXt9Mxcul2pxSuqY5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFuB91TJ; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFuB91TJ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b6d9c981so1140334f8f.1
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 17:22:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772500969; cv=none;
        d=google.com; s=arc-20240605;
        b=FuyoYfOSqa3YBs8HysE7EVQzBcGULfi0nqPPkRrb3IpqLWdDzktKB8h9reCOIYaWkD
         UsrihP34ZDFhChi/mZWqEbJF3+rx7h9P1FvUmG7z7XIqQLwT7laLLG0cO4SFsvGGiktT
         fq3kDWSHSYclX51GXHn/ZWCfe/druK8r/t/GOhMkI/z79ViuGRESNKWXakqLqKjGdN4y
         uCh4QCouQiV8pZVTtYOPkLX3GhjTGoc289NxASgUoq2144pHxKqEAX8Orkg//KE5norQ
         2CL1CjgEbE2817VBfYYfSJlxawqYZLig1NUPDI8MomieOd4DRq9i96yJs7awtg+6YrqP
         k8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ciwfr7qohbSek7074R+vfsZPxDWv/6ffbabolDxuJOU=;
        fh=Tlxc/zaZxOP2F6dafQ0SCBjI1WJJrRPtBZ3l1Vistls=;
        b=B5oBBfONGkS6auFcKdEeP4atRwxGlqLn8Ot6Z3TZG7PZAad/h+cbibfe1n+Dhc1cXY
         y2pFobciDgkgV5PzvgINXoUCG6EVczCuh2bWMoHBQtjvuBJVoBs03uHFbPxJe7PnJW5/
         G+ylJcWy8Jeph6ZU6BeDwYVtP7mX5/5MZnmbmtakVQpuGLFHOxIyVDYyJnqpyyJJzN06
         0ioJQfq1rE8AryonuZDetXGATZPF/SB9jsm/Su4m7T/1jI0z4A8RMFmAPfnrjFe5QwrH
         gLAD+vFSVVMXegAVsEUrj3qZSORad+f35lBc03IbnGIm8TvmVpGKOiaLmyDXxCq3RODb
         ALwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772500969; x=1773105769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciwfr7qohbSek7074R+vfsZPxDWv/6ffbabolDxuJOU=;
        b=gFuB91TJTXS0fsRp4onB1ZtQS2MT7d6i/e+AAzvnqZGfJAHDAoH8W3MwkPzuZf4O4a
         IzOLNw9wtjkV9uUoqqxqp/N4hfjURZROs/ipl6lI+wuLSLoLV4XE1JvG2iAX1cNovZcV
         Ptd28o9RYjfVuzi4DhPKYW6VAwUgXNiZ0jS7YqZGPjHeqdcmXAfEV0igUlTmE5OWBpG1
         PLcrFvlAupaq/7zSWdZ9uid8mh/XFejPsbZXYAEOLsbuhqyjgXnWH4LebC6CJDISRMku
         iHBKXvfyeTmBO+0G5zFIIkzQzorM9IRipU1TPglIYV5GBnDfMZms9YrtF8MeIFiyxCu4
         dboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772500969; x=1773105769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ciwfr7qohbSek7074R+vfsZPxDWv/6ffbabolDxuJOU=;
        b=aUGkxSfuNUpex6kdpQYxMVTRYHoZVrozkNd/GpwJ8Rowh0uo9Ztc6gU6zuiQT8Hv4t
         oQdd26ebZkfc7ByC6Ru8E9Dw3Wu2HM9WhgcuspfjcPxUSpjipBia/MjsLwwuJ6hiVTk2
         tEvpZJEeou+FH/UuvnxVUZUhsrL3lNcoiirl8Ih9SB6UuQ7tSn1zrbHAK72xfdn9Xz3q
         zQ3/BsUTOX/f1FGffldh4RqCZOWd7LhCTA83lrBDeOj0msJPxtyERhjnwA/ZDBZ8z0Lq
         4uySN74AW7lPJ9HIa2PlfrUqTdVESccREBwuz3+qlmaNsnLHw+qnfCnpOZyykawN7XoF
         KFXg==
X-Forwarded-Encrypted: i=1; AJvYcCXQtB6/i87TRMi1+n8idp92bc/YYVY/MpmQ1PkmfiDWNPA7j4/ujGCxUPTRnUCcxlWd+/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YycK0WThEaAf/xHUEHzWA8asJRE8dPms5ZnxljuVZF7fg6muRzh
	kkiXFMWaotf4NIanWyRRQLWvJai70f7Qh/C7Rr/Q54GE8B2H7T2BcALpvvQwUxH+rDd2qtASd7J
	rtF54MUYmxEoHropA7qQUWkg09JbvXoA=
X-Gm-Gg: ATEYQzzmyMFy02ZZM6tvCmhAbsmnhcVkTIyVxwK0unRPszzQrIGas3PN7V9l+Zm/WCa
	yxc+KDOZM0RylUzioDw6G9HkGxMPssyMeFwPBEP/BBF8w7QsX6t0euYVAhmzyCxRXeucsk13uIE
	DQ2jPn3wKXAjDLB+ZCbJDt1ZLPTj3GxQPkl0sKDTAZe8trdI30OHhZrEx2OShiay+LaB41GoykR
	ZiaGOCzcrCYBfRzBpIxdmImkbV2J5F0TFEvOQk7omeEb4CElBS7wJtAuhxPc4U3CxlFuamr2EXn
	Z53TZ/gITsZcJrLN8xr5J/GdXEbiKvQdyfEpWfkcbe8BH3emWyn7jl0KoZYUOq2fHjg0uRT9+QY
	3P88gmK3MJ37WMiN3yZRxZP/q7A==
X-Received: by 2002:a05:6000:25c6:b0:435:96a1:ee4d with SMTP id
 ffacd0b85a97d-439c10bb54fmr521472f8f.14.1772500968599; Mon, 02 Mar 2026
 17:22:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302124028.82420-1-pilgrimtao@gmail.com> <20260302124028.82420-2-pilgrimtao@gmail.com>
 <87bjh6ntsr.fsf@gmail.com> <CAAWJmAa9_RcjbHzOmufL12gfoNY3eZtgWGjNTVR0sbCR9Simkw@mail.gmail.com>
In-Reply-To: <CAAWJmAa9_RcjbHzOmufL12gfoNY3eZtgWGjNTVR0sbCR9Simkw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Mar 2026 17:22:37 -0800
X-Gm-Features: AaiRm52tMbIqemK4kCPdgnjB1juWvykhx_WtqCh-GUkdSRl2-RTrJ0baVX3Hqg4
Message-ID: <CAADnVQJ1E5eJTOqAjX31nYheCY57XnVPyXXV7sOa4htNMhAdBA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] bpf: Introduce the bpf_list_del kfunc.
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Chengkaitao <chengkaitao@kylinos.cn>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 5:15=E2=80=AFPM Chengkaitao <pilgrimtao@gmail.com> w=
rote:
>
> On Mon, Mar 2, 2026 at 11:19=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > Chengkaitao <pilgrimtao@gmail.com> writes:
> >
> > > From: Kaitao Cheng <chengkaitao@kylinos.cn>
> > >
> > > If a user holds ownership of a node in the middle of a list, they
> > > can directly remove it from the list without strictly adhering to
> > > deletion rules from the head or tail.
> > >
> > > When a kfunc has only one bpf_list_node parameter, supplement the
> > > initialization of the corresponding btf_field. Add a new lock_rec
> > > member to struct bpf_reference_state for lock holding detection.
> > >
> > > This is typically paired with bpf_refcount. After calling
> > > bpf_list_del, it is generally necessary to drop the reference to
> > > the list node twice to prevent reference count leaks.
> > >
> > > Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> > > ---
> > >  include/linux/bpf_verifier.h |  4 +++
> > >  kernel/bpf/btf.c             | 33 +++++++++++++++++++---
> > >  kernel/bpf/helpers.c         | 17 ++++++++++++
> > >  kernel/bpf/verifier.c        | 54 ++++++++++++++++++++++++++++++++++=
--
> > >  4 files changed, 101 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index ef8e45a362d9..e1358b62d6cc 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -261,6 +261,10 @@ struct bpf_reference_state {
> > >        * it matches on unlock.
> > >        */
> > >       void *ptr;
> > > +     /* For REF_TYPE_LOCK_*: btf_record of the locked object, used f=
or lock
> > > +      * checking in kfuncs such as bpf_list_del.
> > > +      */
> > > +     struct btf_record *lock_rec;
> > As far as I understand this patch introduces a weaker type of
> > verification: we only check that there is some lock held by the
> > object of the same type as this node's head, but there is no guarantee
> > it's the same instance. Please confirm if I'm right.
> > What would it take to implement instance validation instead of
> > type-based lock check?
>
> Your understanding is correct. However, I haven=E2=80=99t come up
> with a better solution to obtain this node's head. Do you have
> any suggestions? Alternatively, shall we revert to version v1?
>
> https://lore.kernel.org/all/20260209025250.55750-2-pilgrimtao@gmail.com/

Let's revert to v1. Passing head just to avoid messing wit the verifier
is an ok trade off.
