Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C463F3C7DFA
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544582; cv=pass; b=eUBMtMml9JRS3kmORMPLx4PZ9ncgWW3WQVFFkxxdYQBTz+cdfXTPwHTLGduaRIlelGbuEa3ZiWKppa/33DTZ5Z6dHoQTMmZWrizbY8/5HHNj3at8jSvVGgrlRRYI4toEnDiNjiw0W+ryKkX/zX3rj5iOUCXV0tzUaVl+HJ6PpF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544582; c=relaxed/simple;
	bh=LE4SX80+/pcvjw5cGh11DHDijHyZaE+JSHrRUibRHlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUXRqtvhTrC0AZE8SkX0MkODAO+oAsajwW7CgC2Axrx/Qob/3jEVrC9XgMAm05sR9Y09eNptVhUe1m6GSu84irHKmem1xW6lsEDReqkr5IBleDvfwEkNJpiFoZ2xgi1mrJclL3je1wAyqsXzS9gokTjPuzZzmCJvA0L4u3VnIP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7+dQ8lt; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7+dQ8lt"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f97c626aaso201581066b.2
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 10:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774544579; cv=none;
        d=google.com; s=arc-20240605;
        b=CD0ZFCGFOGcnfP6os+VutMBJq9zYGBL6B/JFmYX9p3M+ldiqetdPtuJJiVpdfB+hpY
         xMtufEv2tSIziCHsPxhFTupB09dprB71jkHEmbCv3+7UXYOD/j8meQbt4Ee5SBSMoRuY
         yBL+0YQwD76cgmjdoiwirOy6qkfNvo97Rsm0VxPM7JWEmszKio+nBt2mhiAmDvRT40vm
         Gdz8UlD7Dy2ffn3d8yJK5gZ2Xrt5+Cv6DD/W0ihq//g3lH1QPYbRpKWCjHESf9JyHtDz
         f/XVGm2Dy9xfImu7GXStaKImwPx/UVXG3ZYnLzuWuLy1mBQa52EFT6q40LlQajVYirS4
         u/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sYBPgojaaKvYmQKhiDRzrsGmLAPEawLtY8ezJ39nqQ4=;
        fh=/Yqiw6tj7mq1+h874UGDXyG98Xm/b5ehBWX2wG9g/Fc=;
        b=LZkiU4eyjMe9p0J4NHIE2uUQxJMdm9XCYFwuJKMpb6Y1z+bzLMU835bkpaEUVq7T6D
         Mj5PH3pdyQnvpZ+Z1vL9lKL0IkBUbRd1b7cmZY+/TB4q3RFWNiptM6I3m+PTfFrD4z14
         oNubW4dRhAMiBdn215P5AcLU+GgQfq36gN5EGNQGlRkmaLOwIu8r70WP1WGXt4BHRlhi
         iqmGhFHK3tCYUgGILXONmLhiSi40t5tCHZ+rZtBIAj5pj5KEf/GWuI7hVJPGKjz1QoQk
         JyJ7CdZEZOd7u6NWR4P9H/ka1926jtg+Vkf6egFUh+5K5+CcjtMih9K0O8K4xTPu7hGA
         jlug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544579; x=1775149379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYBPgojaaKvYmQKhiDRzrsGmLAPEawLtY8ezJ39nqQ4=;
        b=V7+dQ8ltT74D0QeEn/KX5d2N7Qi3jTGt2sYQ/BJTorW4WGieaLfprSDGIiE5KeluBw
         6+BjnmFMKSR2m+bCY88DEYRdJREA2+lbxqzHW2TovDAC9CRCtnc18fw2ks9+Ou0kQaes
         VUUPLZzak9EINwUyrpKDTR0ygx9h6aBoB+yMNF9AhJ2wOo+vEvi2Nh7bWgkZLgpBk8hn
         EsoawHsBbBns9WvJrKkL51bs2qbWLQEnnQwP9AdAh6i8na5S0Uje1aFcu/S26Gau/bFG
         r9XWY2Z8t4Bcc/K20uwcTlSqLULzqokJt66DcNpMnripRZWNH1EEd8hKHxbY3lV0wkH8
         lKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544579; x=1775149379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sYBPgojaaKvYmQKhiDRzrsGmLAPEawLtY8ezJ39nqQ4=;
        b=kVr+U3ozrFvntwR0FHja5fUv0/8SnB1u2H56yPTM2rNcbYzhL3UaBqhTrAvIIb0Xd9
         JVsA3CsY0mE6F7NliXfr83zk2i9BN4sMz8ZlGFfL6la3QcPs+4e5AbQ940VQFmytVxsR
         omLVDBzoI45foK+ZwzDk0+eIOdAFWzMW4757yv+iT9UjgfCMldjbBT9eG4RdwjRzxuuO
         J+Eckoz23vFcMSSYNbel4OzsFwfYfSti3ETBfArsOBN34TO8L74jF5W4m6+8KV8uwTM0
         e91MxaY8WVcd76SBOk51f2tsoL9zkYMwRT4L1CSyqXd/0cxcBGJXt2yAevnxFdhDcThV
         BzQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQDYbf0jnv4UYbSL0CMswKYhwzAh4tx/YgQvhoQvYVDJGPrfPOPbP/fptqeBXCr7ViK5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZC5edggJoD+LOASXj8kq+o3iPQpDXJUh7u1hN0RyN1nyYXdR
	AvPxF4evrUJdZXdzyJRQZjJeAt0T0/yzDhqeaq9SkS7M1OaP9krasQPilFNiKfyL/V2EfvKBohq
	An4FiCVtaYGv3x8PdIv5fpsw2q2yqGxA=
X-Gm-Gg: ATEYQzyRUFDslqVrXMih91hoikl46ZT6gY/DaJkwmknGOKZfgau/aCXohviML1sSKhM
	+kcJeUiHf5cprRPXYPUfODphY7/msoMSR3zrdsWZebfwvPPUhuyh0/h4lOLcYDpVu+MmjzZ6/6C
	i4xc4F2xOarX9qWgJBoMWB0Hr4DK2SxMbcE8SgoaY3uitAcIjwa7Ihpl2d45Kx52x5IsS4j7Doo
	dV+nENMfOarHhZEFXkgChP3JGx00vmBHCDF+ljsTE5GjfDph7WUnjPOc8d3V/oTGU8am6Pvp6AS
	MBWg+9lXqUOmyPsQN34beHxDM+OrW8P67R/m03tlDA==
X-Received: by 2002:a17:906:134d:b0:b97:9099:7b3 with SMTP id
 a640c23a62f3a-b9a5429fdadmr403096266b.44.1774544578621; Thu, 26 Mar 2026
 10:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
In-Reply-To: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Mar 2026 18:02:47 +0100
X-Gm-Features: AQROBzCxQ7LTWEHJc61oO6lXBkCBYyHWnkzwlNxMnle4MieOI_dPRQ2jeYsmgHk
Message-ID: <CAOQ4uxgQgv7W=92kR017PG-AZSLKsUoYjnZoVHCoQwXRitgMuw@mail.gmail.com>
Subject: Re: [PATCH] bpf: add bpf_real_inode() kfunc
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 5:53=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Add a sleepable BPF kfunc that resolves the real inode backing a dentry
> via d_real_inode(). On overlay/union filesystems the inode attached to
> the dentry is the overlay inode which does not carry the underlying
> device information. d_real_inode() resolves through the overlay and
> returns the inode from the lower, real filesystem.
>
> This is needed by the dm-verity based execution policy implemented in
> systemd [1] where BPF LSM hooks must resolve a file's backing block
> device via inode->i_sb->s_dev. Without looking through overlayfs the
> device lookup would return the overlay's anonymous device number instead
> of the actual dm-verity block device, causing all overlayfs-hosted
> binaries to be incorrectly denied.
>
> Link: https://github.com/systemd/systemd/pull/41340 [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/bpf_fs_kfuncs.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index e4e51a1d0de2..fc30aa906b8c 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -353,6 +353,21 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup =
*cgroup, const char *name__s
>  }
>  #endif /* CONFIG_CGROUPS */
>
> +/**
> + * bpf_real_inode - get the real inode backing a dentry
> + * @dentry: dentry to resolve
> + *
> + * If the dentry is on a union/overlay filesystem, return the underlying=
, real
> + * inode that hosts the data.  Otherwise return the inode attached to th=
e
> + * dentry itself.
> + *
> + * Return: The real inode backing the dentry.
> + */
> +__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
> +{
> +       return d_real_inode(dentry);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> @@ -363,6 +378,7 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE=
)
>  BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
>
> ---
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> change-id: 20260326-work-bpf-verity-a43f28baa242
>
