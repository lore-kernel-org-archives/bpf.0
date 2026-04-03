Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8711F230BDB;
	Fri,  3 Apr 2026 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231677; cv=none; b=Xz/K6iGtinskl55KhH9fSyZT/PzJTWUde1u+FlT2sLFTL6uWM8dtUtW+TZLvmAGuvZZ1JkBOqM8VqFCQ5dHSn91i8ETq4AubViEirTa/Jk2KcK7bsbxu3bDkLZG9LPe8uqGL1V++9nqXiCkcOjEdA+mBkaPxFfD4AqQd1Zp4YP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231677; c=relaxed/simple;
	bh=taGDzVaqhYmXMFPSKm+ArXZcDQIHGJL6OcwO+HcC9cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp8ppExI2nOxljS9pZMK9lRmHyyF2bfMSHh7RYO7xnANDS2FOHWOszNk5ZAbjtR3Ddg4iXDExfq/r6sdgb7EfD1TeV2MUXHT3dXIYfcO72PRnHpP+PxusiAWfh8IGXG3Tvo7tkrT/IXbk3FWOd1d6Z789Prt8Y8sv0g5Duyc+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFvEZeOZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFvEZeOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D367C4CEF7;
	Fri,  3 Apr 2026 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775231677;
	bh=taGDzVaqhYmXMFPSKm+ArXZcDQIHGJL6OcwO+HcC9cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFvEZeOZ6WpNK2LXAoHgivcU4CpGINBjQe6IAf1Pmd1musmmohUGu/eKNb+ujo24v
	 tTHxVGAR9KQR9M1pj9W1w/eX4xMI0bxXGQAiKY5l6vBMes1CNTHjAP2L5QGfaFAdUn
	 2+f75VOAMfHEf/Aj45LkKZ9W575ozPUvtN1C/Nqzvfe0jmK7TqTFUtpDa0UiS0AzFj
	 nr2qMC67NdY78pQ9Or/h/RjGQCITzoQ4vchaiDqPuI/9Icp+V8Ej/mTJ0gZb/KnsMd
	 PPREzvainXb9MdfTAA5f+pjq7q9nuqnF1hFjpVNzhwRAdBjmH6gsgqlJclUovHFkgA
	 kpKmLZkujBacw==
Date: Fri, 3 Apr 2026 08:54:36 -0700
From: Kees Cook <kees@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Sun Jian <sun.jian.kdev@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] libbpf: Replace strncpy() with strnlen()+memcpy() in
 skel_map_create()
Message-ID: <202604030852.D0F31E6@keescook>
References: <20260401001130.it.781-kees@kernel.org>
 <CAADnVQJ+uSCvtpv4A33YeRi=_LCnZRaxB_ejVgdxPDO5u3+oeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ+uSCvtpv4A33YeRi=_LCnZRaxB_ejVgdxPDO5u3+oeg@mail.gmail.com>

On Thu, Apr 02, 2026 at 11:14:58AM -0700, Alexei Starovoitov wrote:
> On Tue, Mar 31, 2026 at 5:11 PM Kees Cook <kees@kernel.org> wrote:
> >
> > BPF is the last user of the deprecated[1] strncpy() in the kernel.
> > Replace it with a length check via strnlen() on the source followed
> > by memcpy(). Normally strscpy() would be used in this case, but
> > skel_internal.h is shared between kernel and userspace tools, and
> > strscpy() is not available in the userspace build context.
> >
> > The source map_name is a NUL-terminated C string (the only caller
> > passes the "__loader.map" 12 character string literal). The destination
> > attr.map_name is char[BPF_OBJ_NAME_LEN] (16 bytes) in union bpf_attr,
> > ultimately passed to the bpf() syscall.
> >
> > The bpf(BPF_MAP_CREATE) syscall, through bpf_obj_name_cpy(), requires a
> > NUL terminator within this 16-byte array, rejecting names that use all 16
> > bytes. Valid names are therefore at most 15 characters, but this wasn't
> > being checked via the skel_map_create() path. Add a matching check and
> > refuse 16+ character strings early, as they would be refused later by
> > bpf_obj_name_cpy().
> >
> > The attr is pre-zeroed with memset() at the top of the function, so
> > the last byte of attr.map_name is always NUL, meaning the memcpy()
> > of just the non-NUL characters from the source will always produce a
> > NUL-terminated destination string.
> >
> > Link: https://github.com/KSPP/linux/issues/90 [1]
> > Suggested-by: Sun Jian <sun.jian.kdev@gmail.com>
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >  v4: Reformat commit log slightly, confirm last user of strnlen in -next
> >  v3: https://lore.kernel.org/lkml/20260324161605.make.168-kees@kernel.org/
> >  v2: https://lore.kernel.org/lkml/20260324053036.it.906-kees@kernel.org/
> >  v1: https://lore.kernel.org/lkml/20260324040535.work.851-kees@kernel.org/
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: sun jian <sun.jian.kdev@gmail.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yonghong.song@linux.dev>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: <bpf@vger.kernel.org>
> > ---
> >  tools/lib/bpf/skel_internal.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
> > index 6a8f5c7a02eb..2d38c387f43c 100644
> > --- a/tools/lib/bpf/skel_internal.h
> > +++ b/tools/lib/bpf/skel_internal.h
> > @@ -236,6 +236,7 @@ static inline int skel_map_create(enum bpf_map_type map_type,
> >  {
> >         const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
> >         union bpf_attr attr;
> > +       size_t map_name_len;
> >
> >         memset(&attr, 0, attr_sz);
> >
> > @@ -243,7 +244,12 @@ static inline int skel_map_create(enum bpf_map_type map_type,
> >         attr.excl_prog_hash = (unsigned long) excl_prog_hash;
> >         attr.excl_prog_hash_size = excl_prog_hash_sz;
> >
> > -       strncpy(attr.map_name, map_name, sizeof(attr.map_name));
> > +       /* attr.map_name must be NUL-terminated, like bpf_obj_name_cpy() */
> > +       map_name_len = strnlen(map_name, sizeof(attr.map_name));
> > +       if (map_name_len == sizeof(attr.map_name))
> > +               return -EINVAL;
> > +       memcpy(attr.map_name, map_name, map_name_len);
> 
> this is plain ugly and inefficient.
> Just #ifdef kernel and use strscpy in that branch.

I think you're asking for:

#ifdef __KERNEL__
	if (strscpy(attr.map_name, map_name) < 0)
		return -EINVAL;
#else
	strncpy(attr.map_name, map_name, sizeof(attr.map_name));
#endif

Is that right?

-- 
Kees Cook
