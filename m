Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517836;
	b=a4QKssEHXM4kEfttRPsrpVImfIYps4OE+dxcqDHEQZhZgQj/Yv4N23WGgEVWfvBqlJz2
	 JgQGU9JL8leLMkMkaeZxX7aC6yYajGsRBpS0kTGbyd5iAPgj27bmTxVE9LCL9lFj6uIod
	 jnTd9LpZRuN1PHC7XDlVpyZePJy1ieK2X/+yFuPzcUxMi2bbVCiJP6ifthl/qMYHSHVbB
	 fdENtPYwsPgTqrbrFx1bGGxgJ2V0wroQDqAHb92HRU7n6Oq/ranx97lsS2+yvvKFL2iGw
	 dRQmbLkTyqNbuBRZLneYHMCyn0mggb2iIRh3ExJC76CxD3UdPpwc2tRMqz5kNhvOx5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517836;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5fkSfLaeVzOxHCGTLgV2rcfLR1uzal0xGnFN54iZh0o=;
	b=2D2OY1LSnNb3H32Ed8rK0mcCOHqv6knVjyNyhU52Si8u84Izg3B2w5YCV6TxuL1Ilclb
	 aEr35MVp8oaKMHC/x94LPMaIUV/pt9EcFE5XqIsEsWX3qZSyuJYf9EtrcRNj4pvL0KOIm
	 D3eZ711eDZDejy4P+9dVfiCNPWDIR1VACKDkUzW+7n8oPGg7cSXGKZJxg6MrIqm//QDO/
	 +Zl3SoN42OZrqxQJPuJ2je/A8pIAr2WdmMk3lLbDKyJP+m+74fPFgTpZfai7lbYP7NjpW
	 BdOAbALCxN2UbGO6JnZH5kFwO44PEl182CXkWHSbAol2A0UQvz3NuJMLf7TY+biYJ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W7fd3uez;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20D60A2620
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W7fd3uez
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F801F000C9
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792517836;
	bh=5fkSfLaeVzOxHCGTLgV2rcfLR1uzal0xGnFN54iZh0o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W7fd3uezY5AjpQ8rbGLfkhuoXwBCYtn7lBSIXKYLFdozb45cabBQWxzN8P69NWVnb
	 qFn/f9+CQhTPAyrgr9acWMteCAMdiVVJ4fEPejdIriRV2EjG5J4MDJnGMhxBThtL85
	 EK//x+KseTcqHAQ3gRLe8ZJuQ/+11v44amEvArS06YwuJHgQT0lu5aYiDU2UR2rOlH
	 6s24bbPDApL4LsZc0sngdKkrqp65ia9FGSWzEO1EHMEU9rhju95T15wCkFJb/wmk4s
	 jZpK7PJ4yJgjMj9uiLEygL1KjNApzI4jV23+pP5lpymv4a8g5yqbxFjcS7/yQcEWFB
	 bwXDe2B+/kZ/Q==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91befbcad6dso44320626d6.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:37:16 -0700 (PDT)
X-Gm-Message-State: AFq9FYKGcIpC3ldrjwTzzCBmmj8HON6csf6gLyRYZ169GXWWZPgD8uwZ
	cIR6YdS1KqOqzWJxn7gEC33FCG5xzGbiyhvP7tELQJsfrIoCty20FrG5LMADyi5PGsQeukwpB+j
	GBV4hZVc1NsqwObaprLfWZYCxxqbQB3Q=
X-Received: by 2002:a05:620a:4491:b0:93e:c12c:9b6f with SMTP id
 af79cd13be357-93f29df45admr1849134685a.74.1792517813956; Tue, 20 Oct 2026
 10:36:53 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020105014.97985-1-matt@bobrowski.net> <20261020105014.97985-2-matt@bobrowski.net>
In-Reply-To: <20261020105014.97985-2-matt@bobrowski.net>
From: Song Liu <song@kernel.org>
Date: Tue, 20 Oct 2026 10:36:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5LcmQkANg1hzz0U0HskrJ-9NzN+7e8RmxBhvb+kHv+=w@mail.gmail.com>
X-Gm-Features: AclHuK899YpzPcxp4mjqjQL7lgr3tszVq5e23B_cgGOF0EjYuXaU87fb6LLw5SY
Message-ID: <CAPhsuW5LcmQkANg1hzz0U0HskrJ-9NzN+7e8RmxBhvb+kHv+=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for
 exiting tasks
To: Matt Bobrowski <matt@bobrowski.net>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:50=E2=80=AFAM Matt Bobrowski <matt@bobrowski.net>=
 wrote:
>
[...]
>
> With lockdep enabled the fault is taken in lock_acquire(), from the
> seqcount read in get_fs_root_rcu(); without it, on the read of
> fs->seq itself.
>
> Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> cannot race with that.
>
> Fixes: d08e2045ebf0 ("bpf: introduce new VFS based BPF kfuncs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Bobrowski <matt@bobrowski.net>

Acked-by: Song Liu <song@kernel.org>
