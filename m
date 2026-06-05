Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94E3BA249
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695656; cv=none; b=gPRYydmzt/jqqxkF53DDzHtH8zTRmxBcDm0ezfU8kdTkQ4zyq3TwHBg0s8IPPtdDU0FgMr6EF0+YsqR9e2/Fooq1Otv1ih3M7vEeYT6m+dtAp3ZoY0epfWBfBRy+Nq4dl88RD3UxXlAOcRL7Vwq81LAQcOyxxdw5cc0S9aGZazM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695656; c=relaxed/simple;
	bh=UqsFkrBWma5r6ydJxqxQwHvXZ+luru7g9lNeZWG4SqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8eAuxP4vT9seypE2BKUzOrWmbRryWGk4WtEl3MnOySWjoeFuOOFjagBgED+k4PiAMH6Jc0B1vo6C9FK/BGca/n0Og8YSacEF93VpCy51T67mJG6cj7omRHIlOwiJh18MilcjqerUw+lM4gyzpgsINVA/iAldE7blaAAFqGrg+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6YX5w4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6YX5w4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952291F00899
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 21:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780695655;
	bh=lC+RsC0RsBgJ8YinQMuT1AG3v5DHbJdy0fnuMw4n/wE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X6YX5w4f/OFNKWudS8eHkWL7tuZTYBiTlKd5keO1MoXWaFcjlWuU4GQvVvPM8P36V
	 riM5eJm/nH+u7WaDKxMsjUtTGh0HovXA5G4kgVNH7SlFvRzGml28FOBHGTvfGXtF7u
	 RXUlMESg9mVrSYTz/RNKqt5z0+rFNUFfY8MEp+m6Kgc3ANuO8qPXZxSCPNSUQXViZg
	 0wj5YDrLxWRjGhQyJYcRgmr8HTzaYgG1yxaD1aQgZoTTyW/shUykG7MafWSd94S+GY
	 CxQ+gHApmauW/6dWZIkz8+LFGpEz8wYfy98+kNLj8T9yLrqWzdMH/DDT09rvT8M3jC
	 S494/JazCZJsw==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-91591f19c30so373408885a.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 14:40:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YwNVZa60fvpWSEtluATbIznd/VQ4YBGDXj/O44XRDiAJgiqjE/j
	4L6g2Bff0UYR9XkVjx3iGd9KqQqDhAkUnw6G4UrNGcT5fSkfXUe14e94t8Zg7bQsKmRqDqFW2F2
	OIqiDmq/8IkHP96x1rna2krYMbAjdmeM=
X-Received: by 2002:a05:620a:270d:b0:911:89d0:fb5e with SMTP id
 af79cd13be357-915a9ceb953mr967872685a.27.1780695654942; Fri, 05 Jun 2026
 14:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605145707.608579-1-dwindsor@gmail.com>
In-Reply-To: <20260605145707.608579-1-dwindsor@gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 5 Jun 2026 14:40:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7jSxHF1sH2jMYf9Px0iuMadt0bX13ABF4D=og-hQuq_g@mail.gmail.com>
X-Gm-Features: AVHnY4LpUysg1cS6mpjV48bBXchouYWjwrk7Xac1RLxwMzeDiEMqvUtn8rr2K5M
Message-ID: <CAPhsuW7jSxHF1sH2jMYf9Px0iuMadt0bX13ABF4D=og-hQuq_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: reject sleepable BPF_LSM_CGROUP programs at
 load time
To: David Windsor <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 7:57=E2=80=AFAM David Windsor <dwindsor@gmail.com> w=
rote:
>
> The cgroup shim runs under rcu_read_lock_dont_migrate(), so we should
> not attach any sleepable BPF programs there. Add support to the verifier
> to explicitly reject attempts to load sleepable BPF programs destined
> for LSM cgroup attachment.
>
> Without this, we get the following splat from a BPF_LSM_CGROUP
> program marked BPF_F_SLEEPABLE attached to file_open when it calls
> bpf_get_dentry_xattr():
>
>   BUG: sleeping function called from invalid context at kernel/locking/rw=
sem.c:1567
>   in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 34317, name: loa=
d
>   preempt_count: 0, expected: 0
>   RCU nest depth: 2, expected: 0
>   Call Trace:
>    down_read+0x76/0x480
>    ext4_xattr_get+0x11f/0x700
>    __vfs_getxattr+0xf0/0x150
>    bpf_get_dentry_xattr+0xbb/0xf0
>    bpf_prog_e76a298dac9218c6_test_open+0x6a/0x85
>    __cgroup_bpf_run_lsm_current+0x326/0x840
>    bpf_trampoline_6442534646+0x62/0x14d
>    security_file_open+0x34/0x60
>    do_dentry_open+0x340/0x1260
>    vfs_open+0x7a/0x440
>    path_openat+0x1bac/0x30a0
>
> libbpf provides a .s named section variant for every sleepable
> program type except lsm_cgroup, reflecting that per-cgroup LSM programs
> are intended to only run in a non-sleepable context.
>
> The above splat was obtained by bypassing libbpf by using bpf(2)
> directly.
>
> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> Signed-off-by: David Windsor <dwindsor@gmail.com>

We should add a "__failure __msg(...)" selftest for the reject case.

Other than this:

Acked-by: Song Liu <song@kernel.org>
