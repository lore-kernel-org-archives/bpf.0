Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517898;
	b=fjzYXy1237ruFcT0HZ8SshyRFTlUOBegqVkUBmN+a41Hroyy5Q9eoxoo6efCaasfX9cK
	 5EaJ1PU7Yc6WPRiVr9yO6P+kcCjxZF/k3dyR7dfvQdLbdY/2DBJr6IcwHf23QhKlvbObB
	 Jb4PvfmEA5DImnK1amMY4Rn8q9LFgujUgoS0DzzWA9Yf/vgygnys7F9QYTZyhU0AaIo5G
	 BaWnI9QSy7RVntnr8oTWoxXf5m6Qw5Ck8lmMMUVEkBNB07Pz4oCLgY+8iJTRo9YYwi2JG
	 CgkSlUHMvtJZpNeJ+olTUDBm+lFIqWITyamqhbkWY/the+CiULH2/jzwBFkIZjoY8RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517898;
	h=Received:Received:X-Gm-Message-State:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=v/3r8TNEKPTmA62qSgMmjkBfW6wA3NDTsnBMpgNm5gk=;
	b=hGmmy99wT3ndMmIX4+VpRsoLx3YXXBV7sPFd3uofD4qVzZ+1m51ceiok1ZFBPVp4jl4C
	 OzjLsjvZhLGarklunZyR4c5keu1/47wCfNUhQXdnybpdtzdWRFG/FwklsCQ0hrU/lzBA0
	 8T8eix8MvOvnNV3dqM3C0X7oLurDd26MNvXql1bQHU1GCDrWamJHsffxteST9a+yCzWk2
	 GblGj2/GBkqiiBzvAVIxIx8/CbESxFZ6vfabEW0G9rw9sEcIrweItaSEYosNw3M5N6R9g
	 VvjMaKJeQwXYFlMKJpg22yD+7ntee6cR+XDCvkOSVoeKqo7BaJVA7If3m9ZOfYlgIRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E460A4AEE
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4801F000C9
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:38:18 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e7ad9f78dso392441285a.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:38:18 -0700 (PDT)
X-Gm-Message-State: AFq9FYJGJ/aHRMDKPXBbqTaRUUeU1nqtTv/WPjBDvAqEwJFIxbSbuH56
	wXW673OKMTiHSFN0/VZIyalFooe9eRyf2xUxlbolBAwnG5Ow6kms2/MxJqHMaS/fHpy4gVdiOHx
	T0gQVhHi32RoUC9VElCJpdLd31o5DAys=
X-Received: by 2002:a05:620a:2609:b0:93f:2938:48ba with SMTP id
 af79cd13be357-93f29d9616dmr1909077885a.55.1792517867359; Tue, 20 Oct 2026
 10:37:47 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020105014.97985-1-matt@bobrowski.net> <20261020105014.97985-3-matt@bobrowski.net>
In-Reply-To: <20261020105014.97985-3-matt@bobrowski.net>
From: Song Liu <song@kernel.org>
Date: Tue, 20 Oct 2026 10:37:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7iB59uA4Nq=CsfsyrWSq9K856qQv8Q=e8SEZM0ggmMFg@mail.gmail.com>
X-Gm-Features: AclHuK9-NsxuAA831m7ol4gBimIkAE2CXBl-izBBZR0qJbIURqC8MwEK5TsVfws
Message-ID: <CAPhsuW7iB59uA4Nq=CsfsyrWSq9K856qQv8Q=e8SEZM0ggmMFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: test bpf_path_d_path() on a
 file released at task exit
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
> Add a fs_kfuncs subtest for the crash fixed by the previous commit. A
> child opens a file and exits without closing it, so exit_files() drops
> the last reference and the file is released from exit_task_work(),
> after exit_fs() has cleared the task's fs. A file_release program calls
> bpf_path_d_path() on that release, matched by the file's inode number,
> and records what it returned.
>
> Without the fix the subtest crashes the kernel in d_path(). With it,
> bpf_path_d_path() returns -EINVAL.
>
> Fixes: d08e2045ebf0 ("bpf: introduce new VFS based BPF kfuncs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Bobrowski <matt@bobrowski.net>

Acked-by: Song Liu <song@kernel.org>
