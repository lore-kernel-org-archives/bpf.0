Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901A3B38AA
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459897; cv=none; b=EJFOsevjETDeL1zmMxDJEwODyed+jETKzXQ17pXpNWb12GHD2vSZNSnFrtvhDtmxw7k0KWwsj/Y0oKxB9emBfkNsmHG3FY77a2PcnWGhnx3sVei2G3aTO0AIi4gOEqcdIsjz+oCH48rhXGY6Dk/zkGcgCUsS4DkroX51OlhXHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459897; c=relaxed/simple;
	bh=P4+8edkAQzwJD3Kx9EgzDEqOwhLsODaY+W1/jTUT+FA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NUlqANQB25CdVsDGElbnVmYzZIuhwvctY59CWv8G8ArOcCuQnu8lxciIL+J13DwH5qyQzTKpwsoHc8lIX6crpEUK5l5isTpAG9Aw1ZloqmY1HGq4jffX072tF1ZuVL5EEscP9VdpEmSxQRWK3SEnRbshxPzcWMUluDV+N8dnHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmJz+lv/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmJz+lv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290EE1F000FF;
	Tue, 15 Sep 2026 08:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789459895;
	bh=v3SJs2LsABOWRWSGg5jmAOKM67JQGU4VOYfMudDKJME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mmJz+lv/E+1v1BpoWBdKS+/LekC+9bsdVRp9NWTRbmBwu8kS6o1rM856vAcKUNppp
	 I7lq6HFrDLxS5daAFM/FDKgtdCu6ufM+I1bHN0nswSSiwxmWw+wi+ByZrL39CerNr6
	 0VJHnJaGqgaHA8hLj+0rHFmlTgJi2l3gfywL1vz4/AxWFAyggVpQdN+ypF/Ycomg2p
	 u8FFo+TNKqN3llYsck6BSHFcg5K5FVYCD3SpkENBEYcXpNtrV3F6KZxFN2ld1EHq9F
	 PYT9fvbPPkQtOduogQVdSma4e6CARJvPvfbBSo/s3e7Y5On9b6VSWwSK4R7kXhb+Gc
	 JrnzLAALfkwTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 1/5] mm: Add copy_remote_mm_str()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260915080255.48929-2-tasos.papagiannnis@gmail.com>
References: <20260915080255.48929-1-tasos.papagiannnis@gmail.com>
 <20260915080255.48929-2-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 08:11:34 +0000
Message-Id: <20260915081135.290EE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm: conditional definition of unconditionally declared API copy_rem=
ote_mm_str
--

commit 046f2d358ae7593df6c056f6c498b844e89a44bc
Author: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

mm: Add copy_remote_mm_str()

This commit adds copy_remote_mm_str() to operate directly on an mm_struct
rather than requiring a task_struct. It also moves the public wrappers
for these functions into mm/util.c to share a common internal interface
between MMU and NOMMU builds.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
[ ... ]
> @@ -3325,10 +3325,10 @@ extern int access_process_vm(struct task_struct *=
tsk, unsigned long addr,
>  extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  		void *buf, int len, unsigned int gup_flags);
> =20
> -#ifdef CONFIG_BPF_SYSCALL
> -extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long add=
r,
> -			      void *buf, int len, unsigned int gup_flags);
> -#endif
> +int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +		void *buf, int len, unsigned int gup_flags);
> +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> +		void *buf, int len, unsigned int gup_flags);

[Severity: Low]
Are these functions intended to be available to all subsystems regardless of
configuration? The #ifdef CONFIG_BPF_SYSCALL guard was removed here, making
the declarations unconditional in the public header.

[ ... ]
> diff --git a/mm/util.c b/mm/util.c
> --- a/mm/util.c
> +++ b/mm/util.c
[ ... ]
> @@ -1061,6 +1061,68 @@ int get_cmdline(struct task_struct *task, char *bu=
ffer, int buflen)
>  	return res;
>  }
> =20
> +#ifdef CONFIG_BPF_SYSCALL
> +/**
> + * copy_remote_mm_str - copy a string from a remote address space.
> + * @mm:         the remote address space
[ ... ]
> +int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +		void *buf, int len, unsigned int gup_flags)
> +{
> +	if (unlikely(len =3D=3D 0))
> +		return 0;
> +
> +	return __copy_remote_mm_str(mm, addr, buf, len, gup_flags);
> +}

[Severity: Low]
Since the implementations of copy_remote_mm_str() and copy_remote_vm_str()
are strictly enclosed within an #ifdef CONFIG_BPF_SYSCALL block, doesn't th=
is
result in a link-time failure if code outside of BPF uses them in a
!CONFIG_BPF_SYSCALL build?

The underlying worker function __copy_remote_mm_str() in mm/memory.c appears
to have the same mismatch, where it is unconditionally declared in
mm/internal.h but defined conditionally here.=20

Could the #ifdef CONFIG_BPF_SYSCALL blocks be retained in the headers, or
dummy static inline implementations be provided for the !CONFIG_BPF_SYSCALL
case?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915080255.4892=
9-1-tasos.papagiannnis@gmail.com?part=3D1
