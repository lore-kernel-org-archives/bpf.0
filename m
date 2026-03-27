Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9916139D6D5
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774647574; cv=none; b=urqLZwiaTVVBrg9s9BZdGRNrFWHcNxMOD5u5NYQu/jcMob/8YyyPTGI93ntDrBU29YS/xxlCP91ANDo6RT4JqZcDJg+ANbPwIoK2AqtuvX3c192OumnW1l12P35m34v1M5TsQFW78bGvzf2q3c7eXUQ89HGz7qduWJOI1JYmz7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774647574; c=relaxed/simple;
	bh=Id3H55MVtR4iq07CBTe/XfBCAe2oN5vCIStNLrlYUr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJVgxUXWhP254MxYBWjz58ChBPnlO6itmCUIzihbhBTuA5fflDMbp+VZF+Do+AxxNYf+Wavpl6cEMKTEQJ2uDtv7VUzjYCbU4E0mHOzTHlLmHpcEeRVO1aql9ggMa3TIo/Jwxd1DwB075gLBUv6fEn6N7toQdGqWbKeRbFyJyJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2CpCVo+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2CpCVo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51086C2BCB7
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 21:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774647574;
	bh=Id3H55MVtR4iq07CBTe/XfBCAe2oN5vCIStNLrlYUr0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o2CpCVo+AFvmKDIlWOXOaXuL6+K0wfyx/HQ9RMWkkxyemU8XweU1TZmmJIjH5qrDr
	 QAjHgY8WbUvrRCVddYiWu0TPJGtS3V3M7/xz962lr1paYNucUFI0qxGGB0Z0oaiEm6
	 zoFTozHeGlX5WkTsQwen9zUiX4yTJXaOQ/RYs8h+XAinLS7/uLASEp6yzpUjJdLTlv
	 fMFQrvNwSvVXI+ujih5lA0AhOD9Xjbx/ddn/zUEZ4iH7tp1z7PnB/SM1Z24H1k3fFT
	 35fVWaiVBQFo0PHGum2Sx5/tKAkPZvTgRJUuqocn7ctLVYambmO8XvyKoqpGNl9Zx5
	 tOFjJrJ4otEuQ==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899fb2b94c1so29178376d6.3
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 14:39:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzky8i5xvToD7NuKjhSgfCtQOfTX9stFFAZM+LjqWd93CMdB85d
	SLkkAY1qAy9gLy08wLC1KlbFFCPYv8pG46Lsn3vOR6EbmQY9RxfQSleTGcTpp5BsPKZZDPreb7J
	VLzvY0KWQoo9arEKkwGE0piVNyANsvkU=
X-Received: by 2002:a05:6214:5b0f:b0:89c:cf83:5849 with SMTP id
 6a1803df08f44-89ce8ee07e2mr58406696d6.32.1774647573217; Fri, 27 Mar 2026
 14:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326141718.17731-1-leon.hwang@linux.dev> <20260326141718.17731-2-leon.hwang@linux.dev>
In-Reply-To: <20260326141718.17731-2-leon.hwang@linux.dev>
From: Song Liu <song@kernel.org>
Date: Fri, 27 Mar 2026 14:39:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7vwp6pW5RntKC+Gbn5gTcVg3vsm6LVc-y2ssTeauZayA@mail.gmail.com>
X-Gm-Features: AQROBzB1wWGIDjriED2x8JQpjflfKyv4U2KAfR28YLOq8DxbUg2UoDazcM05c_0
Message-ID: <CAPhsuW7vwp6pW5RntKC+Gbn5gTcVg3vsm6LVc-y2ssTeauZayA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix abuse of kprobe_write_ctx via freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	Toke Hoiland-Jorgensen <toke@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 7:17=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> uprobe programs are allowed to modify struct pt_regs.
>
> Since the actual program type of uprobe is KPROBE, it can be abused to
> modify struct pt_regs via kprobe+freplace when the kprobe attaches to
> kernel functions.
>
> For example,
>
> SEC("?kprobe")
> int kprobe(struct pt_regs *regs)
> {
>         return 0;
> }
>
> SEC("?freplace")
> int freplace_kprobe(struct pt_regs *regs)
> {
>         regs->di =3D 0;
>         return 0;
> }
>
> freplace_kprobe prog will attach to kprobe prog.
> kprobe prog will attach to a kernel function.
>
> Without this patch, when the kernel function runs, its first arg will
> always be set as 0 via the freplace_kprobe prog.
>
> To fix the abuse of kprobe_write_ctx=3Dtrue via kprobe+freplace, disallow
> attaching freplace programs on kprobe programs with different
> kprobe_write_ctx values.
>
> Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registe=
rs")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/syscall.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 51ade3cde8bb..1dd2ea076d8b 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3733,6 +3733,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog=
 *prog,
>                 tr =3D prog->aux->dst_trampoline;
>                 tgt_prog =3D prog->aux->dst_prog;
>         }
> +       if (prog->type =3D=3D BPF_PROG_TYPE_EXT &&
> +           prog->aux->kprobe_write_ctx !=3D tgt_prog->aux->kprobe_write_=
ctx) {
> +               err =3D -EINVAL;
> +               goto out_unlock;
> +       }

This also blocks uprobe+freplace when prog and tgt_prog have different
kprobe_write_ctx, right? Is this the expected behavior?

Thanks,
Song
