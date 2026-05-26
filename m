Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907E3FDBE8
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804208; cv=pass; b=HCgey+fRN/P9D6Czmc5oodNAl1m1skNK+Cvg6CfcV2jARoIx5Z4u7DehO8gso8HVumxu30TGL1+/P44i33ryRPgRTdy/7X3MIYxGEIedBK74ZxBCz/ZNMpT4gfMTdSCC68TnERCrmkVPls17lWsvaNyDkKOKufP8+FIfcjtkmVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804208; c=relaxed/simple;
	bh=j1GKwUDpWvhOZBhkaO+rpncrchzuft3RI84XNRPNJsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkRfgR5tnWiGnmp8KQt7gYJBcOBOxUuHPIIfcBMKsaqtgg59V4ttP/mieSgctb37Byd2uIT+hyeEufkkr/f/7NWYzCU97HwyWC5N3QQWECth8FF+Jy5pPG7l2Bv52JAql15l3oz2yCjyyFQsY68th5s46714FIXdXhavVHRTSH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+i3Dc2l; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+i3Dc2l"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6804e24803bso5335992a12.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 07:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779804205; cv=none;
        d=google.com; s=arc-20240605;
        b=ApkPL2SIhhp0tefVqbsGuYzuVzdVUN/1TEJf9XNadCsyRXaVxD/fzhAQEwKh+VH5XX
         dCWbJeletxb+49J0Cgdc1+hhwrQIn1b+LDD2624sDa1405QYMs4Jbdihs1EsLvgKVdOZ
         kkfCIWysm/dPyiCOxDXMpU4HdZL93wjf6NMxP0QNnBcLVTsc4O18Ukhc5rOd2Fg0ZXdR
         HR0ho7las4XwfJm+RyyvFNsXrI4A/nz3pJbC45BnEQMBXPhtCgQ3HY56DrtyyaeMLuTu
         qOirat1szAGVGATwgfdZTNdhf8hcS+4SsUGx9PJ/UdfiQShYEvoQR7NHBZA9SW1q3Iei
         kJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9XDZuMXc2hNe1igpILUdvrH8nE+95WDHTRv7db2FxhA=;
        fh=C7lb0pOfkB7xmN4skGIst6hroPrdOuJe8IMPPO6o9as=;
        b=hITHHxdpr0cq0IHiRdcsXIriTe+KIRt/MT393zL0oxBbBI2BAkd+CI9/R2JGyb6p73
         oE2Nah/akitm5ZB7PS479NzK6RG88HfBe8497FsdHiGNxaWnoEikqTm1O4Gi8ix4zgd7
         ePi/orgjM/KDp5xV6s+ub/2m4zNu2FEDsZkHhl5Ja2m3TpNdify/Yp1ht/5LOz60KTzx
         iLa+XH8tWnPmYSzBmf/6xjBlclB+mA431FaZi2DV4UkVz64LsX12DjUH/PVbBauqRFNi
         pg5GHFCKJd6D0YdbPkIXQo+HzuatU/MGyEKDXpjkECfiqPZU9DnbjCDTvn58vP0TMboN
         Sr+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779804205; x=1780409005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XDZuMXc2hNe1igpILUdvrH8nE+95WDHTRv7db2FxhA=;
        b=N+i3Dc2lep5K6Vg2xRkndhF54piZR1D92s/ceOdvMaBFKuHaI5iY3uD57/915aHbq2
         NFxrSUry1sQZL2nxxj+osdTrCS0XjzTuIkMpP/t247TiaFpUoJJr6IXU9kWwmzCB+sb/
         qGmRiq3LKVR8q1pGMsmT/QIek/KUF7gGuNfYa2zXrdPRGX9pknJRcMu8mVEZ0jl0sOhs
         pBt+OVqNBMAK7Z/xPkRGE5MXcwkJmFA/ruXDvbDU/Wk8YCq3OYq7mymVoEPm4dAIom2X
         q8E2Wuw1ffRZXCt+EH9iWLutoxpp/BNNPWMiuYr0/TfoFZGxQ+HUOTRWKbwMylTxyTa4
         iicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804205; x=1780409005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9XDZuMXc2hNe1igpILUdvrH8nE+95WDHTRv7db2FxhA=;
        b=D0BfkPKOVzjhr66DUe8jaZGE3o31sTqn8irYeKFV3vXxYzuBmuYfQyvJmVxxTZtlar
         +busvEFVJ7Epv1l+gJ/9GMsna/my84vpOm0V4+cfn2fx988RJRSHuhpM94WtH83+08h6
         hxrN2xqy2gM1/6md6QmKRxdrx3lTSLnid6bzy1IlujiNBa+hHvOK4NH3zsZ/kUETr6jm
         pQGQ5zzINHewmtrS17Q7EkmlHpKjtADDLXpM5N4za6zNWuv4QMq0Fq1Cuz3fcHtTAa5X
         /AUq5Ql6YHyYzfBRBNQaxeSMYm5NkVIgWowdCmXvJZMIPYMNz0K25ZWGYIV2AKSE7h+b
         +D6w==
X-Forwarded-Encrypted: i=1; AFNElJ/bdsFU+Zx4RDLY5Ke5/NZpURqefvmwpUBDwdJn9xj5P6TQcHCc3QO4j6GdZIDa8yTBOc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4ks3SZkoqXhBXYh04c1nB1VfmHA4/IvHSPWbgJWFdM3AfKG3
	t+7zaMPXqykuPsJN/whhD1hvxL1swYM3ABe+5lFwStaCZDHJybKVXcYXenWlYBwEFYTqp8g774W
	Egx/9LwbvUWCrVJ1kE2C+iFZ/3SkI9JKvBS/I+RI=
X-Gm-Gg: Acq92OEWg5G4oPeck5CO9P+J7/cuDe8CEfRz9HsHG029nB9YxYMkHTze4PrcjPhHZOx
	g45SdGBx3ClPgU7ARMCQ6DuAQT2ff1zAg5msBV3+zjZnc7QsuVHcOVI/Oa668hz8PHBv7AQP0KJ
	FOqqgeP0WvoHIK9C6vTZSKNjO+WTWYFQXa/c2DFvsroLM9pmN9ekQXie3+WbZJsOJgIY2IbOrDh
	SfKSUzCIQMHFyfxUc0tfD0VC+UTTr8MOT482TDrHy7axbXS9cBvh6iqn8hCaM+ks8R01+teirCj
	WsKMsO9qyaKMEu6syyAywUAQflmGLtIZFDSskXBfUcoKmziU5zw=
X-Received: by 2002:a05:6402:f1d:b0:689:5b3d:6271 with SMTP id
 4fb4d7f45d1cf-6895b3d667fmr4391044a12.25.1779804204973; Tue, 26 May 2026
 07:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-work-bpf-verity-v2-1-cd0b1850d31b@kernel.org>
In-Reply-To: <20260526-work-bpf-verity-v2-1-cd0b1850d31b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 26 May 2026 16:03:13 +0200
X-Gm-Features: AVHnY4IFVP6dOFBmyLUEMMTjP_A2wIhTbvkrPjBzeZTBVJavqwOPIBXZ03drNDw
Message-ID: <CAOQ4uxgz0O+iC8rB_PrsA-zSJDXwMMNk9ND556HueedsUOzRzQ@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: add bpf_real_inode() kfunc
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 2:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Add a sleepable BPF kfunc that resolves the real inode backing a dentry
> via d_real_inode(). On overlay/union filesystems the inode attached to
> the dentry is the overlay inode which does not carry the underlying
> device information. d_real_inode() resolves through the overlay and
> returns the inode from the lower, real filesystem.
>
> This is used in the RestrictFilesytemAccess bpf program that has been
> merged into systemd a little while ago.
>
> Link: https://github.com/systemd/systemd/pull/41340 [1]
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Changes in v2:
> - Tag bpf_real_inode() with KF_RET_NULL and document that it returns
>   NULL for negative dentries; LSM hooks such as security_inode_create()
>   pass negative dentries, and without the flag the verifier marks the
>   return as PTR_TRUSTED and skips the NULL check.
> - Link to v1: https://patch.msgid.link/20260326-work-bpf-verity-v1-1-efe9=
edc46ddc@kernel.org
> ---
>  fs/bpf_fs_kfuncs.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index e4e51a1d0de2..761fbe0fec5d 100644
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
> + * Return: The real inode backing the dentry, or NULL for a negative den=
try.
> + */
> +__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
> +{
> +       return d_real_inode(dentry);
> +}
> +

Sorry for noticing late, but pause to consider.

I see that both EVM and IMA open code the would be helper
d_real_metadata_inode()
while for d_real_inode(), d_real_data_inode() would have been a more
descriptive name.

The name d_real_inode() is from before the introduction of the D_REAL_
types.

Perhaps for the kfunc we want to use the more descriptive name
bpf_real_data_inode().
Could also add d_real_data_inode() wrapper or rename all the vfs call sites=
.

Up to you. Anyway feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
