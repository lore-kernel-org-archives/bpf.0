Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE7E4A49BC
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468408; cv=none; b=cn8116+O68T+zuQHl0EJbiC5+prrZXTmwjEaDGzhHJZgj+A9+T56c8xkOrboSx/lHjrJPNLSS1iZe8iVDbKylgNdQZiTgEO52ZbYVn+vTj6bUhX+U+/jns/acgxTmPCjBq0Idk/fmjdtOH17fRtMJaGPSdSmBZl+1ev0a8MQc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468408; c=relaxed/simple;
	bh=MJwTrP4CVwGddIK6J5OAaQDSOlc0mGdIiD8769a/zNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oscl9BC7ATrIXy19qva0Cz97FXZL5C033n7YuiPIQ0Jxv5iX8Gc+uJbdU606JJjsNnSzMddsei2kj7d/5pPLmM3vnjl2spOPZWpBnETyZB0ZscFnpHWyaYGi285iSiWXaqcAZrS2/YUuhnr2JrmoFACTWxqpQjKwtsl5/a2oR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu29/OW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu29/OW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA5E1F000FF
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 14:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791468406;
	bh=O36gv6hlKGTB1dGwK8PnWmjb6kQ34dtwDZu/ftfPJIA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cu29/OW7yBFgcAR95EsRV7YGzc9DnRl1mlSYfyC9QVHZ4/M+a6AQgHFckDLJN0uKX
	 8lGAbZavHhhW0ExeGIOwXyKpS/5DT5dJeHHVKJInwCsxrEIrlBO5QxKcXyQEYLyk3p
	 GvKSbxCphBouO8xi2mgShvi9+9JkRb/m7AUbgc88zEtMLk7syu0ANf/r/t7/nTwHVh
	 bCIKj3Vdw5IP1MBYi4xoMtCB6/EOgKuH3f+vE928N8Ui4dTqn3x51JMcW1UN9MVrPX
	 Pyh2DGD2VQdDkYjLsCleCLH8VoKlhAarghilTWcSJ+Fy14fEdFZ0FDL/Fu94zLtqRR
	 BiLD5wzquPYFg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c262f1186f0so417064366b.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 07:06:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx/9xYf+dsNPx/2jtrm0A7dMAtFipin2gIrJFzPL5tFc/WXRU4yji+L4Ln8Lj8IfDfun4c=@vger.kernel.org
X-Gm-Message-State: AFuF++kVKWxvHkDSE5oKyBGRhqgNAYB92/AreDKoApctZAm5rG/gNiyR
	MZ0dNf3blRmQ6g2on3TRWMGysONpMgrwRcQ8wWEcfWUHhpm13Hwhckl3X8k2AYDeJ0LWm+lbill
	BJGLjWEsK5YQzBkWeOu3n8ve3i048ozc=
X-Received: by 2002:a17:906:dc8d:b0:c2e:378c:8cee with SMTP id
 a640c23a62f3a-c317bf5bc3dmr595588366b.34.1791468405551; Thu, 08 Oct 2026
 07:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-selftests-bpf-cgroup-stats-bpffs-v1-0-76b9a6d1be34@gmail.com>
 <20261008-selftests-bpf-cgroup-stats-bpffs-v1-1-76b9a6d1be34@gmail.com>
In-Reply-To: <20261008-selftests-bpf-cgroup-stats-bpffs-v1-1-76b9a6d1be34@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 8 Oct 2026 07:06:31 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM86_kXTpAdsOAFvesvB-yenCMLSGYa7sS1uLVDQUH_fg@mail.gmail.com>
X-Gm-Features: AclHuK80zBKuPr-w8TV96q0Wje7e_GRnQyZXP68dEjes43wo6RtpVGexSq9898Q
Message-ID: <CAO9r8zM86_kXTpAdsOAFvesvB-yenCMLSGYa7sS1uLVDQUH_fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Unmount the bpffs that
 cgroup_hierarchical_stats mounted
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, Hao Luo <haoluo@google.com>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 7:03=E2=80=AFAM Qiliang Yuan <odys.yuan@gmail.com> w=
rote:
>
> setup_bpffs() mounts a bpffs on /sys/fs/bpf and records in mounted_bpffs
> whether it did, so that cleanup_bpffs() unmounts only a bpffs that the
> test mounted itself.
>
> cleanup_bpffs() checks the flag the other way around. As mounting on
> /sys/fs/bpf succeeds even when a bpffs is already there, the test never
> unmounts the bpffs it mounted, and every run leaves another one stacked
> on /sys/fs/bpf.
>
> Unmount the bpffs only when setup_bpffs() mounted it.
>
> Fixes: 88886309d2e8 ("selftests/bpf: add a selftest for cgroup hierarchic=
al stats collection")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

> ---
>  tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c | 2 +=
-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_s=
tats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> index 3bd27d2ea668c..a93b16ed629e9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> @@ -110,7 +110,7 @@ static void cleanup_bpffs(void)
>         ASSERT_OK(rmdir(BPFFS_ATTACH_COUNTERS), "rmdir "BPFFS_ATTACH_COUN=
TERS);
>
>         /* Unmount bpffs, if it wasn't already mounted when we started */
> -       if (mounted_bpffs)
> +       if (!mounted_bpffs)
>                 return;
>
>         ASSERT_OK(umount(BPFFS_ROOT), "unmount bpffs");
>
> --
> 2.43.0
>
