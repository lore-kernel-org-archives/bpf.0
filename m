Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E22C0296
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148566; cv=pass; b=neH4LPkJZ0yvJIsY6qvsL0YINRnf1FqxPDyFBYjZtgvrNWoB4LjvWEUX7WkABHl1ig6gnO2iCK4I9QUlb6iW5sEherWsDWsEmrb44XwkIM6Doszt40OAJmwSaXMllviYpvz7rtJMUhm8G2ySXyvhEua4NwilrvZlVv10zLwVUpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148566; c=relaxed/simple;
	bh=VWTc9i2eMckx3nD8rqmrFjjK7XQcPakZvpS8iypxNkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXAoUYlwLUsqBMkqSNFhZAoM/uqq44IQR5FWSehnf/OgozcF8gz4l6TXd8CGtdLS+mqfN7Vs3pZOkRNAaUikKR2HI2EZdvsmDfYI5NpkKczsw2plMcR6xKl64xENeQr29iAeT1lxiE0pHuxpPIshlyFQ/0c77QgpDMorTQBwfh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3+Kjwm9; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3+Kjwm9"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-697b8540279so1535540a12.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 10:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782148563; cv=none;
        d=google.com; s=arc-20240605;
        b=adVXRpV0CDD7KyaulXMdDiJofYINmYnXEuxAkstBqpQxcahT5rqvMDYlMFlVgsrjWV
         Jl0f8mT1Ks7vivtoVeNaPhnIrY4oo0ij/TkQu3Dsnbtujg/bplNpCHzntVyJqk4W0QXc
         A9qXZx73e3hWQ5UqamKB9moDXviFOkxSZSKHESJTtEYGXbgqZTBySKPtmqC+a2oXXqr5
         pOO6j3wrYVjoIm9m1TFW0R0B6zUcl/pGfSTttD76HWGUpTfn8KVYNOe6bpEhg97Osgd+
         lZL0KQ1q+HxE3c0gnqBI0ljEEOfyGCvHvyEuwYTw9M9RmYOlhIm3W0T6vIQkuN9srAUt
         1bWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cFeJG8pc1VJ0tkXqG1ecAN+uRU0QARHjaUDG2/HiEsI=;
        fh=0nxFPUitAqquvLml8D5fd9JTUxLO86+AIYZWsz1VLrQ=;
        b=ihxVCWC4/FNnxwezM7DAEtNdp0IRyVvuwlnh7lCzLhZeiKAfeSmFoPCpUxWHL5jxjb
         dnNzuB4Thiw5q1xo5IiB2CigizJk4BmMzW2yJ0tiSVzsqSR8+FXVbxcPvBpVUmUrmxYB
         8R2CqLh+A8OIWcdVQTeBgpTZ2p6but0hhm7ci8slSO3W2lnSPhoYA8q8zFy0SGa8a1Bj
         mZT3EPlug2RvE7PXYRlzXAmBw5VICMaGZAPYU+hXepR01wPvHVah65YnDU6+drUPxZSi
         pfO/lyCMXk2XMr9Y76ZNaTCc9qEy8cQue0OWvn8NkJ1+JoynzCJ7qjI6E9ofhZeXVzc7
         d13A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782148563; x=1782753363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFeJG8pc1VJ0tkXqG1ecAN+uRU0QARHjaUDG2/HiEsI=;
        b=Q3+Kjwm9h/YwuQUaz9tEvkdIa28qfT0c+zamx2VoRTDGmI6zti1wo0+4jAnl8agNkQ
         t4A7odJv5RLjVUmgRiCUgomHSGDpht2XkffckuAcCGMQ3hXTVWeI2Gwm5a6oofdDBoQB
         qBPXhPLHvvjbnx66UjsuKa8nXhW3VEmB3LpHQWK7ncR2dZlYTWU10JsbAhIUqTWM+MI9
         e0Qbsv73aQfaV0Wn1jB45zw8YajHhl6De0AsG3Erq9RvWRsswdE/MDISuZsQ1mO3BgjH
         DD5MFwDksU9sLN/ndn4i/WDKZSY+EUjr2FeLh/JZKcVHKcFvgFrHEH6Bll/OxfZdljf5
         iN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782148563; x=1782753363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFeJG8pc1VJ0tkXqG1ecAN+uRU0QARHjaUDG2/HiEsI=;
        b=lfl7HqHD6oE3JehgUGhU/7g6Iy8VBmbD0eimUxmTQL6ae1OfYHJuqK2VTvE/nIUPk7
         SFFj5E7jXKQs8RNbiKX+0JFPJL4OYtSilO8wkVhXMD6KT9L8fX25mGRtgkduH4dWK572
         /iY0V5RGPV8eih1EjrKXrNqPkixjskaYP5Y3gkhbCxuTEOb6X24Bsqh3lVjPhi9lP/Zw
         IBrsGm+oQ1T2xUN2xhVq8+LY5KxkhMsUyEZGeZB4NxMSDLwHgQEjYdITWUl38vXC7mk2
         bPmA943HiGiUPDy5nappw587llTtVjRKQjqFsRR80QZ5RYim0+SgQDTPPuKWI6exK25l
         ODvQ==
X-Gm-Message-State: AOJu0YyAPm5LuJBQ8Gl2pg+qgawf0U2BKgPbDswPJq+N2ok+PcFOKIpv
	MEgRT0aXnJJgq1S3wevGa/D/S4/xr6IOV9UNdciWMD6kVDoNt3ODSAx+rwWcDOyZWgHtS7cWSdw
	JGSYd1Ru6e5ESeBq8eDtWTxZmp2HjAH52gZGYyZQ=
X-Gm-Gg: AfdE7cnztzB52fpzkURnHIDRf3IwZ3dQDTNZyo/IveUc36YsCpFNbbYjA0b5ECTyAJV
	p3WXDtoaDVqdaZUjCU2p+Nzw5eQyBi8zmDKDkUOnSOAVugPWAqz0AzXnNiDKvcYbfxE9asvi3zQ
	3anc5IeWK7gUdQYvXijLYg7wxpMw/XrZHASO1orK0Mx4wmZoilDYi1HpZRrHCBASm8nVBL0sywp
	N+jRgSsRPvbwha0So/3e5BEkd6gLaX5+msaBKFT83GuTzKwqmnEYTNTfC0GmkJv+OJ7s2qkm/dF
	NjGcICdNx2OjC6SkYeTlDS7TAty/FF0=
X-Received: by 2002:a05:6402:158b:b0:691:55d9:fff5 with SMTP id
 4fb4d7f45d1cf-6975681fc13mr5977545a12.10.1782148563322; Mon, 22 Jun 2026
 10:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-work-bpf-real_inode-v1-1-4014eb4cbefd@kernel.org>
In-Reply-To: <20260622-work-bpf-real_inode-v1-1-4014eb4cbefd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 22 Jun 2026 19:15:51 +0200
X-Gm-Features: AVVi8CdbPXHukBxq22dST9DVayoEkEf4SCjLmu4AI3jOv2CLp0y2j943xEfTOrU
Message-ID: <CAOQ4uxiaD3NnUDBCTYzjS-8+y8boxzwVs1p8QsWaC4AkVFPu5A@mail.gmail.com>
Subject: Re: [PATCH] bpf: have bpf_real_inode() take a struct file
To: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:58=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> bpf_real_inode() must be usable from the bprm_check_security, mmap_file
> and file_mprotect hooks for systemd's RestrictFilesystemAccess BPF LSM
> program. It should take a file instead. The kfunc landed this cycle so
> changing the signature is safe.
>
> Fixes: 9af8c8a54f6e ("bpf: add bpf_real_inode() kfunc")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f0..f941c29d26ef 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -360,18 +360,18 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup=
 *cgroup, const char *name__s
>  #endif /* CONFIG_CGROUPS */
>
>  /**
> - * bpf_real_inode - get the real inode backing a dentry
> - * @dentry: dentry to resolve
> + * bpf_real_inode - get the real inode backing a file
> + * @file: file to resolve
>   *
> - * If the dentry is on a union/overlay filesystem, return the underlying=
, real
> + * If the file is on a union/overlay filesystem, return the underlying, =
real
>   * inode that hosts the data.  Otherwise return the inode attached to th=
e
> - * dentry itself.
> + * file itself.
>   *
> - * Return: The real inode backing the dentry, or NULL for a negative den=
try.
> + * Return: The real inode backing the file, or NULL.
>   */
> -__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
> +__bpf_kfunc struct inode *bpf_real_inode(struct file *file)
>  {
> -       return d_real_inode(dentry);
> +       return d_real_inode(file_dentry(file));
>  }

The problem with this API is that for special files it is a bit ambiguous
to say "the real inode backing the file".
Is it d_real_inode(file_dentry(file))? or is it file_inode(file)?
The old API avoided this question.
BTW, did you notice that for non-regular files, this helper returns
the overlayfs inode?
This may be important information to document when exporting a kfunc.

If you take my suggestion from the previous round to name the kfunc
bpf_real_data_inode(struct file *file)
the intention becomes a little (bit) less ambiguous. huh?

Thanks,
Amir.
