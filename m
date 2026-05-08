Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177FC274B53
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778276000; cv=none; b=B19iNR4fXe5ELhKnGV4l3O19iihU8iIvMbXIpP8yTI3DgL0BLYVdDLDAdtJUa9bg67Odt8BCHCSTkLPNet8jeC/JH0wZsSfbavRUbLqYXxfYBPwnL+xVSpk17ju8qO0pCc3K0SxbzM8gOkLMDc36VhteEF4iATqFcZODY4j8ZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778276000; c=relaxed/simple;
	bh=Fpv8vqcTDP2OD325rdpzUCJg2tHK1JG8n9fGJE8gGjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vrfxqxzw8EfmREx0QsCkzSHiamXW0+tVIjwm1STaqaGtwMi27UxoseU957V19GXCx+Ddb0J/W7FP/D0R1T4VyqlZhy9HRv+KW4+D1+mCTzrhI8uL6UDs1qoT6jhOtGZBiFP6X9eLGCoGmMl60isW3XfLp1cssUWlRsenSEH7OT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw94ObXJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw94ObXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB479C2BCF6
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 21:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778275997;
	bh=Fpv8vqcTDP2OD325rdpzUCJg2tHK1JG8n9fGJE8gGjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fw94ObXJF64zyCYMhBC9f8t/4NKxlxnxfhaSJtOz1LgVoZYhm/R2irJI3jmmXBWg0
	 wIiXtgyzxWlpP7DzGVGoe3UwwppWEQdBQ2XNIFwy1NdWudM7xLi5jfvfcmaOoYQtz9
	 SXLeAzTu6zw0LHQnD3eN8ID8PBF6+8HLXGFnf1RfcYpk0q7NvToEzK+pjuoc2ThRIl
	 Ycy0l86JCAT9Z6tXFMxfLfLHJTu4FthUrBJACbCuQXen0QAwxBzIWZEIgFFXGHX54c
	 geuxXxt54z6ZAyMwZ08FGB2l8Kx3lOjkdUBF1Je2pA+j2T4rrVPH2Y7IZGAYRn5VLC
	 aKp15bcANxLGw==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b8e98fd885so21672086d6.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 14:33:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywg8hV/GYOChcNo+JTlB9PsTQivQKmCO2pCmGaE+zvcJJ/mrCgL
	9PqgxXNhRlNvNkQH8CMP2wQeWw9lVb+DHKgxcW41c4ckcBqEGjpThv63avoXivXrjgKpSPA2GEU
	rs3pYnn8y5oWVi0SHaNAx1cHuy9vcVCE=
X-Received: by 2002:a05:6214:3f88:b0:8bc:15b:aa6 with SMTP id
 6a1803df08f44-8bc46bc64d8mr211395376d6.44.1778275996984; Fri, 08 May 2026
 14:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108010728.207536-1-houtao@huaweicloud.com> <20250108010728.207536-2-houtao@huaweicloud.com>
In-Reply-To: <20250108010728.207536-2-houtao@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Fri, 8 May 2026 23:33:05 +0200
X-Gmail-Original-Message-ID: <CAPhsuW6hMX9LqnD-0tc=t+TDUFA7j8WUgNEshnYtUwwCDX-J5w@mail.gmail.com>
X-Gm-Features: AVHnY4Knk9WhdOnOaKS4fye1tq5_PhBoNxLXm78yAE1krFiPnKdL9lJR161UyE0
Message-ID: <CAPhsuW6hMX9LqnD-0tc=t+TDUFA7j8WUgNEshnYtUwwCDX-J5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/16] bpf: Remove migrate_{disable|enable}
 from LPM trie
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:55=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Both bpf program and bpf syscall may invoke ->update or ->delete
> operation for LPM trie. For bpf program, its running context has already
> disabled migration explicitly through (migrate_disable()) or implicitly
> through (preempt_disable() or disable irq). For bpf syscall, the
> migration is disabled through the use of bpf_disable_instrumentation()
> before invoking the corresponding map operation callback.
>
> Therefore, it is safe to remove the migrate_{disable|enable){} pair from
> LPM trie.

We got some ENOMEM from bpf_map_update_batch() on LPM_TRIE.
I suspect, this is the trigger, as we are missing
bpf_disable_instrumentation() in bpf_map_do_batch(). IOW, I think we
need something like the following.

Thanks,
Song

diff --git i/kernel/bpf/syscall.c w/kernel/bpf/syscall.c
index 3b1f0ba02f61..a8d5959a96bb 100644
--- i/kernel/bpf/syscall.c
+++ w/kernel/bpf/syscall.c
@@ -5686,6 +5686,7 @@ static int bpf_map_do_batch(const union bpf_attr *att=
r,
                goto err_put;
        }

+       bpf_disable_instrumentation();
        if (cmd =3D=3D BPF_MAP_LOOKUP_BATCH)
                BPF_DO_BATCH(map->ops->map_lookup_batch, map, attr, uattr);
        else if (cmd =3D=3D BPF_MAP_LOOKUP_AND_DELETE_BATCH)
@@ -5694,6 +5695,7 @@ static int bpf_map_do_batch(const union bpf_attr *att=
r,
                BPF_DO_BATCH(map->ops->map_update_batch, map,
fd_file(f), attr, uattr);
        else
                BPF_DO_BATCH(map->ops->map_delete_batch, map, attr, uattr);
+       bpf_enable_instrumentation();
 err_put:
        if (has_write) {
                maybe_wait_bpf_programs(map);
