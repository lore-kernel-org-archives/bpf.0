Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090C1F30BB
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468696; cv=none; b=RzMUyyjXnETrWJXVuLm9z0MI9uelv2jIDvyvpQAUcBN/tHFe9Q5olojN3Jqz6Zy7hTEnPZ/1SocUYiTV6EZiZJpNQ/y8zqJFNDOmpqamTz2wEoAmVvbCgh5/UNBtQTRYlw4dGtu7JOaN0z0+HyTj4Xm2HFik5xXXKD7wIj++PfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468696; c=relaxed/simple;
	bh=uV1ISNsf76cltfLh/o1kW0+W32CtPdo6Wesa9Lel6Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPohAOAu9yiip5IqLBsi1S/sNtA7RPo/HFy9f6j38JmQ+oJD5+9keLNANdm/fPyBVIa3Q6LoeAflfrRwqh47XtBuHAyvtJGUlOkbec8APL/8aQIElrT9pTKm9dixI7opU760IlWBokMJ3bLCX+GKddpOJNZAE/TBFJ7uWQ5r3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zzl8qVMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zzl8qVMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D09D1F0089D
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791468695;
	bh=XizYEBrLIrSOkcxxEQ6z756AMwf212Lu8FYTxJPBGuU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Zzl8qVMiw/p6DERRiuXbGUGeGfLtICFLZGLkHAuc57x1tagz5+sHlCk40AtEXEhn3
	 kDAfVHdpxbI1auSzdfo4oednIuQVkBCk1DBqFuuskuLJk3G8e8+W0FBC8EajCAyUwz
	 7Bkk2HNg7I0nxI9BMfeeT2hVvduuKdmM0bl0PoaDfdjudrhVWPKqPRX8/WU1bml7io
	 rxGHc55il9q3siIdYTTal1fGIAFvNab/jdBdbukYRDFSZ6my2PjWC/6euIsl5okgSo
	 3i8Q/53QwQsB6KhZPuJiASfCLeI4Fbn/k5WO4MLksKCotUZYaJX1m6ID4M9YvupFMy
	 ehqHuquLW7T6w==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1670dad7a8so965551166b.3
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 07:11:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw2Qe8VkfVwxrQGxCo/va1M+sowz/X6o569d5Z+bZ+XLcgC5x6jcihZeYYZ6xpVU9p/ipU=@vger.kernel.org
X-Gm-Message-State: AFuF++k/KBYMssRL7rQ71C/0khoUtUUjCswUBP+xLu5KfEE4fGujr1ie
	EvtJaNn9TG9bkEZdStvBCrx0XHUTHspVQYze1kMgwEpS5PkMhiuJ+Nff73AXqTM2vomo62VZikH
	4FbPTqWa6fj22HOp7Qkg7qnbfowEclGM=
X-Received: by 2002:a17:907:868a:b0:c2a:fd39:f23b with SMTP id
 a640c23a62f3a-c317c08dfa9mr568535066b.24.1791468694153; Thu, 08 Oct 2026
 07:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-selftests-bpf-cgroup-stats-bpffs-v1-0-76b9a6d1be34@gmail.com>
 <20261008-selftests-bpf-cgroup-stats-bpffs-v1-2-76b9a6d1be34@gmail.com>
In-Reply-To: <20261008-selftests-bpf-cgroup-stats-bpffs-v1-2-76b9a6d1be34@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 8 Oct 2026 07:11:21 -0700
X-Gmail-Original-Message-ID: <CAO9r8zORCY-3W1eLmc7ZmEjTujuHRMNxsP1=i4gg6y4Pe-WedA@mail.gmail.com>
X-Gm-Features: AclHuK99zqsS7a3Blztb5G1oVsFTdGk6_aPODN_TJEUcyx014sLN4O1TlTaW5CY
Message-ID: <CAO9r8zORCY-3W1eLmc7ZmEjTujuHRMNxsP1=i4gg6y4Pe-WedA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Don't stack a bpffs in cgroup_hierarchical_stats
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
> setup_bpffs() mounts a bpffs on /sys/fs/bpf even when one is already
> there, while test_progs runs other tests that pin objects in /sys/fs/bpf
> in parallel.
>
> The new, empty bpffs hides the old one until the test ends, so those
> tests lose what they pinned or the directories they pin into.
> bpftool_maps_access then fails to pin an iterator because
> /sys/fs/bpf/test_bpftool_map doesn't exist anymore, and bpftool_metadata
> can't find the program it pinned in /sys/fs/bpf/test_metadata.

Seems like both of these tests do not mount bpffs, but rely on its
existence. If it's generally expected that bpffs is mounted when the
tests are run, should we drop the mounting code here instead?

Alternatively, should we have a common helper for creating directories
in bpffs that mounts it if it isn't already there?

>
> Mount a bpffs only if /sys/fs/bpf isn't one already.
>
> Fixes: 88886309d2e8 ("selftests/bpf: add a selftest for cgroup hierarchic=
al stats collection")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>  .../bpf/prog_tests/cgroup_hierarchical_stats.c        | 19 +++++++++++++=
++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_s=
tats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> index a93b16ed629e9..8e0b67df700bf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> @@ -23,8 +23,10 @@
>  #include <asm-generic/errno.h>
>  #include <errno.h>
>  #include <sys/types.h>
> +#include <linux/magic.h>
>  #include <sys/mount.h>
>  #include <sys/stat.h>
> +#include <sys/vfs.h>
>  #include <unistd.h>
>
>  #include <test_progs.h>
> @@ -88,13 +90,22 @@ static int read_from_file(const char *path, char *buf=
, size_t size)
>  /* mounts bpffs and mkdir for reading stats, returns 0 on success. */
>  static int setup_bpffs(void)
>  {
> +       struct statfs st;
>         int err;
>
> -       /* Mount bpffs */
> -       err =3D mount("bpf", BPFFS_ROOT, "bpf", 0, NULL);
> -       mounted_bpffs =3D !err;
> -       if (ASSERT_FALSE(err && errno !=3D EBUSY, "mount"))
> +       /*
> +        * Mount bpffs unless it is already there. Mounting another one o=
n top
> +        * would hide what other tests running in parallel pin in it.
> +        */
> +       err =3D statfs(BPFFS_ROOT, &st);
> +       if (!ASSERT_OK(err, "statfs " BPFFS_ROOT))
>                 return err;
> +       if (st.f_type !=3D BPF_FS_MAGIC) {
> +               err =3D mount("bpf", BPFFS_ROOT, "bpf", 0, NULL);
> +               if (!ASSERT_OK(err, "mount"))
> +                       return err;
> +               mounted_bpffs =3D true;
> +       }
>
>         /* Create a directory to contain stat files in bpffs */
>         err =3D mkdir(BPFFS_ATTACH_COUNTERS, 0755);
>
> --
> 2.43.0
>
