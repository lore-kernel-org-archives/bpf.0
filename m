Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125C3CDBD6
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228386; cv=pass; b=QRP0xgTZipddDIBZr+61vN87ZieLNR+OzzhWeflJPRJsibCAv2F3kmGjkcpmkLNBPsWHy6u0Kn2HK9eMdlfd7zK3M9OgnZiWi99KmHqqYvH8cLn+RwQiLs/RJlotz+EKPODMSlLF7ypJLk1xcRgFiV/HMhOlqoOI2+0RS+llTBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228386; c=relaxed/simple;
	bh=YbRh6514ZU2RL6NtnUKsdEeupviuG3XLTy064lm8j7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IONCkufGjxPmqQUxQETWVmF0gbJd3ZiU8M3ZkkDrbTELQd83T3czvndsNTPOTT8F/mfO1BsGFIlPe73kOy5NuADRxErIeC89y89eqOO8/dg//ppfFz/zPdSasD5LbEqZKgJ79B9Tz8TlYVwI8D/1GND6ejq4mLSgOxRkpQONkzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIC8KhNR; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIC8KhNR"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6977dc206afso6769358a12.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 08:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782228383; cv=none;
        d=google.com; s=arc-20240605;
        b=AI5p/5RsHbO4q1fGUIufSeuiPa66nO4VX6QxELHXmIk+jG7QWxjl/PIsW+EIe44l8w
         VGrcRpTeoIqOQGIwyX+/gRzoxP26Fh5+Yc0EA66XC7pPjbs7/S1U4Mfnx3Suj39IrJk6
         QM7W0i13sbAzCK5ogMI0x1g+yJ0hC5VmfqGRSM6Y+oO40j3a6/RcrMXCUyjopVOUJrIs
         WTdI4LPGZl56C/Q7xhcWMJSyadEI8M0Dr6cqAsNckmdPeHJyEGIfRWVzx605CEQ+brsy
         Wetk3ObpqaKb9v+QEJ2oeDTArIuftehgDsEm0TP5XluRII3ktegBdvtRkF0zcSjZCZ9m
         IC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r/cZXqF8tr2DhWW1MyXGMQoZN3ZKgmdfxneLAbvm50Y=;
        fh=0nxFPUitAqquvLml8D5fd9JTUxLO86+AIYZWsz1VLrQ=;
        b=OdFe07OYMIoqnAH5HhyAF8GUt7ugiKgATnHij4aNcSkI+FAzSnNtBUaktMb1U/ueP3
         7BcbWHOo4fy5eGzkLiu8eo6zygyk+bGBthW3PV02nbqiUlrXUMzBOjYS3ACsTDMZzqFm
         mz7mwD/RFxqb65g9/kMcIu9DL/AB3yB/iHJN2TaF2efFIH8u9VlijD7vg8JZxteJ/5h/
         082T/3WYWYyWHGf4rwuiuAC2c4+BAYNFTWUEpIlNQOWXsO8HMlSX5XpTPtS3+H3jEyZh
         +aA+vUez9DJsjfPLzGOjqmuZZ0j90XirmGBi+jATCDf7+p063VxYGFI64yrAl7e9V4RN
         mJCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782228383; x=1782833183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/cZXqF8tr2DhWW1MyXGMQoZN3ZKgmdfxneLAbvm50Y=;
        b=jIC8KhNRJWeyVOXyowMQyyv0sGI4eZsMG0SioOIkbDqcYAAS7YMOKbF+F/BrVVJy6A
         R8gEfCrX9s6GrM/o8dYDCvfnP96TaRusFNBOoHYDTY0MaKGkM6M34rsWf5taVD+/tDeN
         5IBkR0ANibK1gQXtB1Yd3kX7niCaqkD8Qi/JjvFYb6fNQNbwxtYwtX9V0dl8O4FpLOy7
         JIixH4ZpwRvB3Bm8J4JDHYHyAOzm5lmG7VZOv4uiLX6SAjXwN05QV2RErB8VYb9H5qNc
         cLzbUlkYEHdpq2dLSx9eKgJCkqjtergDC/BadwEWU8V3EjhUf0Ivaj+MVptO5Fz2tf2l
         Iltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782228383; x=1782833183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r/cZXqF8tr2DhWW1MyXGMQoZN3ZKgmdfxneLAbvm50Y=;
        b=JRneWT657slXfwkZBg5O0aq5NBu2bsesB/KzWCcAMDIQxjfygNoZJeUWvgEVuDGE58
         KzO0uy6P6El9cV1zF7uDEU++AhU7WaXU0OVL19ZtHwd3NFLpe/rYNLYKISdvjMpuiwK2
         P65hmIuIPTgtMuUjtybXlfFYedsNjPePten+1vq5i6tJC7HyH68vFh5hIlHKMgM4GrAh
         ucyyT3EmQe36G0IxsEy7ULR9WXPByc62BGFfHF/aO+LM2b3W242dts/3dMojylA3td5t
         EC9c1Y7hUc+uelhll5kXjK99Dvx/1BXJoZewsruPUPL2y35kDJzv9DLOpgviU+DN1j5M
         uEjQ==
X-Gm-Message-State: AOJu0Yx3CFuePA4DfC1PpN7tHUSyz0ekdT43ScXmo+Teieku9xRU5iFE
	+YqnfXukGTJu99HexwLfgF14s70IwfTwSOGTzZpFcEbDt/mQEZFQtGqcE4pXvjpGTtwbNj6j0XQ
	0Duz2X8ZX30MVO3Yq2dWNktCQ0RIk2Jw=
X-Gm-Gg: AfdE7clBnsbuHnefzbadqXQJ0dCf3BzQWFU1oizzSU6w+RW7iWMAsVcZO0vEk38dv8/
	UHs2Gs+uwFLFTDOZ41F5JZZP1dummyZSEHd6FCpD6kG9F/WIh2D8Of/vE3pnAByDR/G8oRwSwyn
	+PiAoGoByuoAqDhMJ4Kb0XFrQmhzknamjVWLBegtOW1ESkLO8mTUNaz910NjtyHGzNN04b4ffib
	IvJ3pyVhSuh4IUzPFuTnYW4H69qnoNfo95aRkz4GgZakFnNxg0m1pz5HnaG0dxtHb6yQtneDjlZ
	kp4nYFSKf1TbHN2j/nu3rQCCCPc/rrw=
X-Received: by 2002:a05:6402:3506:b0:697:e8c5:f6ce with SMTP id
 4fb4d7f45d1cf-697e8c5f85dmr1114322a12.0.1782228383503; Tue, 23 Jun 2026
 08:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-work-bpf-real_inode-v2-1-8e8b57dd25f7@kernel.org>
In-Reply-To: <20260623-work-bpf-real_inode-v2-1-8e8b57dd25f7@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 23 Jun 2026 17:26:11 +0200
X-Gm-Features: AVVi8CflCeyuhGgdY0pA4nGSNZyvvrxdUzij31TYdu4fgqAwW4JW8TWopRJ_jU8
Message-ID: <CAOQ4uxhQnB8kAwHTKhDsxZ51Jm=gwCs2UHs7UGYboy0SNzVN=Q@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: have bpf_real_data_inode() take a struct file
To: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 11:32=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> bpf_real_data_inode() must be usable from the bprm_check_security,
> mmap_file and file_mprotect hooks for systemd's RestrictFilesystemAccess
> BPF LSM program, so have it take a struct file instead of a dentry.
>
> Amir Goldstein <amir73il@gmail.com> suggests:
>
>   While doing so, rename it from bpf_real_inode() to
>   bpf_real_data_inode(). For a regular file on a union/overlay
>   filesystem it resolves to the underlying inode that hosts the data,
>   but for a non-regular file it returns the overlay inode. The new name
>   makes the "inode hosting the data" intent explicit and avoids the
>   ambiguity of "the real inode backing a file". Document the
>   non-regular-file behavior in the kfunc too.
>
> Both the signature change and the rename are safe because the kfunc
> landed this cycle and has no released users.
>
> Fixes: 9af8c8a54f6e ("bpf: add bpf_real_inode() kfunc")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes in v2:
> - Rename bpf_real_inode() -> bpf_real_data_inode() (Amir); the new name
>   makes the "inode hosting the data" intent explicit.
> - Document that the kfunc returns the overlay inode for non-regular files=
.
> - Link to v1: https://patch.msgid.link/20260622-work-bpf-real_inode-v1-1-=
4014eb4cbefd@kernel.org
> ---
>  fs/bpf_fs_kfuncs.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f0..f1863a891db6 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -360,18 +360,23 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup=
 *cgroup, const char *name__s
>  #endif /* CONFIG_CGROUPS */
>
>  /**
> - * bpf_real_inode - get the real inode backing a dentry
> - * @dentry: dentry to resolve
> + * bpf_real_data_inode - get the real inode hosting a file's data
> + * @file: file to resolve
>   *
> - * If the dentry is on a union/overlay filesystem, return the underlying=
, real
> - * inode that hosts the data.  Otherwise return the inode attached to th=
e
> - * dentry itself.
> + * Resolve @file to the inode that hosts its data. For a regular file on=
 a
> + * union/overlay filesystem this is the underlying (upper or lower) inod=
e that
> + * stores the data, not the overlay inode.
>   *
> - * Return: The real inode backing the dentry, or NULL for a negative den=
try.
> + * Data resolution only applies to regular files. For a non-regular file=
 (e.g.
> + * a device node, fifo or socket) on a union/overlay filesystem the over=
lay
> + * inode itself is returned; for any file on a non-union filesystem the =
inode
> + * attached to @file is returned.
> + *
> + * Return: The inode hosting @file's data, or NULL.
>   */
> -__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
> +__bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
>  {
> -       return d_real_inode(dentry);
> +       return d_real_inode(file_dentry(file));
>  }
>
>  __bpf_kfunc_end_defs();
> @@ -384,7 +389,7 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE=
)
>  BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
>
> ---
> base-commit: 5b33fc6492a7b7a62359157db0f92f5b6e9af690
> change-id: 20260622-work-bpf-real_inode-c3202dbaf0ab
>
