Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E4202963
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 03:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779594516; cv=pass; b=YFwHzB2kLqYvPBpzRY961+temmxb5tRlAoLShTnn+FdJWtndEyebzeZr8O6tEzW0rYte4GgivR6U621C1qWiwa+6E0t3b0iAx8fPMFpi/4cqFF0ECFlXZoU7Fwbwz94uNVGlGuv6ORWlNdvRbqvZtQ7UDtTKIVlngCj03lG1NvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779594516; c=relaxed/simple;
	bh=AtZ2MaZHaoO9EKMTNvZUyn4h95EmBDbv5Lrlyy6W5DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmjvM0XPhUFVNVUFASatotlJdKOTClspK0E0s74meZXOGScSM+4tkC6tLuSRSuumQUAkpT9aXnvoxy2y92lEJkpKvO3x1BNh8M9Z6B16Akywox9IH+7CgJ8Qg7K029LBfpVoBxIe1SwNTQb4tQDeKBt7DxcXMOJ02e49EEtaO+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pytGL30g; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pytGL30g"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69d994bfde4so511620eaf.1
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 20:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779594514; cv=none;
        d=google.com; s=arc-20240605;
        b=kasAoF5Ae/G5xa3upSdkXkoUat7pgjJnow5z24QCfA5X/d8KVRlPUs8UPjpZsXiOps
         fSlez6QJY4CYsiPgAQXPAhKVTTUnny6BVIpGo90H/P6J3+q+foS1bWblaXAGfy0Ew5K4
         3EI2KQquoBgPE+HBgSRxd+grSez115FnMffHfRpB40f5EkDUkkcRuBvnbIg+ThwLkoVQ
         HHSh3cTnFRw8edSo2TefBYJArgcK5mV3NVDT7qtna3W9I/nVez7Uw//EyDDPD3M7EDmO
         1LkUZKKCUtbysLhVEyfgJ4bZTe+hFkJ6W2thvVU+9Urrtx40bIpEJu8fJQ0ePZrzHbcT
         y5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4po9w5TOulpuknOUfePNahpl/Kq8KqTYSA25XKFO99A=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=UhaYIIzi6KQgBzCtIo+gEw1eQYM9SvgP8xDVBEaeokqYIrdgLdg2lpu5DRdbibovyL
         55d9xVC37W9jyEywjykGWKbbzZ0rbdkxTAJpkBrm3ygRrYOWtJ3PDvccQ6QW8wEksTcd
         sGwYNp4F9P4d/i0qrDKzvvvGH6BN55UHIaEKbgzX/MhiCwuhKWbKlsQ7J9zEIazlV9RF
         Ujq2ND+Rp8uNud8c1qANJ7IMpYm83VmzF6tqLm6xeC0TOaGafVekPoMn/awsRSSqqMyf
         NLP04mIvwLOu3DdVzTT5Bp0UCTbKDyhZ/cecxE5QxKwHGxpXJFaHnLZvGfoZRdXC6BKv
         SX3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779594514; x=1780199314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4po9w5TOulpuknOUfePNahpl/Kq8KqTYSA25XKFO99A=;
        b=pytGL30gTCdNRRRw+2pjMLjNECmnfHE/CX51qGMDC8C87L5hfc2HyMF/S/0HS9xJE6
         nfJqxydH0aiJr7QE8Nr/LO5/uf/ehwdm0rZtGUOCO/URRIe1dqrVrqFIMDyBuF726osn
         NEAd3QsXsMJ8s52auj85gepUQm6HwGnoE+nKKYZ6n1oUFVgBkgy7GJBKXZHIhNDqMPQZ
         3KycA5/WbW6yMdybgztjUyhdn5/7iGT7Axs5GFYEDd1Uu6oSFUC/pznfTvn/ZSU7lvlp
         5NdmMKgBvAGFDmYqY2g68HYkiBiaSr3X8ModWLTOR7NMGUO74xt4Aolyr1hHVfQeSRei
         r1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779594514; x=1780199314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4po9w5TOulpuknOUfePNahpl/Kq8KqTYSA25XKFO99A=;
        b=q7l59QRZhx9hcPXa5HKgQUEYkOenR3qCp2EuI/82vNFwLA+TrH23+YGCnWs3onHfSg
         l/eclRUp8Ik1+3/HHrAxdthcBsgndILaDlgpTPgrTJp0204FG2mab1oP7eVUhV9x8FlK
         2tvQYgS6X6rLttg47gk7uKiABeiq0AoHQO8ZyqIjK7B2zwcjdZkrbYlK4Daw4DjVYbw9
         OoLOkrrJ9R/0qz2ddw3n4jsfvzcGlkGPpQ3wfdrtEVmzhvObKb8RO2fY+08tt0tbqb0E
         8bSh11NMkN2juycSe3A4xAgxdv0607dqJjbQd3aZxwru9SFTItSSwVuJGlyGx8dgU36O
         RoCw==
X-Gm-Message-State: AOJu0YzTcsKZkjDvygk8toKFDeKyPEMGx95pjOnRfUwWNGySqjPr1N3b
	nRFM5mG8BAWF5OOV2uVcIGQmumg3NuaqnI6LwQM2oP0JGb3yCdKI4FxOaCk6mKi7alAp/u99lYF
	f4QnagD/EKBbaAgB7wYE7knB9zCveY4mpq8V1
X-Gm-Gg: Acq92OEN5p7dcd2Negn7DDTjkoblwCuqjFw7h+Y4oIZfuMt34tKzzQ9n9jwlrp/7gYt
	wNRmQ4VXCtBxxnzaB408vIv63dyfSU9zfzgNRdt3hkE8SSX/FSk6Jm+mqFC9StBfzqTFSQ15m6m
	dfuLT5ZqRzcv3S05y4QZVfaGuqTkkdcIZ2kKXHY6anYefh8jgdjn8O81QSirTYq/fJ5l4X0seW2
	0ZU9F+ZZRfmRzQQ6s3IezyqBMvVO/lZ5ZA3Twu3JqOJ0Gn4nKYQaESfanqoVQ0ZjuUHk/YpGR0X
	a1KXeNLr
X-Received: by 2002:a05:6820:c95:b0:695:a638:c6ba with SMTP id
 006d021491bc7-69d7eafdf79mr5207259eaf.7.1779594513698; Sat, 23 May 2026
 20:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524025853.13786-1-suchitkarunakaran@gmail.com> <20260524033039.963AE1F000E9@smtp.kernel.org>
In-Reply-To: <20260524033039.963AE1F000E9@smtp.kernel.org>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Sun, 24 May 2026 09:18:22 +0530
X-Gm-Features: AVHnY4IjCNkEPTXrJZAeO7hZb87dCg501XN800sFjeXZaLpJSsD8-beFNxmuwjk
Message-ID: <CAO9wTFhix-Qgpm4EW7Eh9GxPgHnqoQ0bN5_v+GCmHbF0VSXK3g@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: replace pop/push emptiness check with bpf_list_empty()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 24 May 2026 at 09:00, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The patch introduces a call to `bpf_list_empty()`, which is an un=
declared function, resulting in a build failure.
> --
>
> commit 9fb6024323da084c2713bff3f8a0e6018dc6bd72
> Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
>
> bpf: replace pop/push emptiness check with bpf_list_empty()
>
> This commit simplifies fq_flows_is_empty() by replacing a pop/push check =
with
> a direct call to bpf_list_empty(). The intention is to avoid unnecessary =
list
> mutation and simplify the code.
>
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/t=
esting/selftests/bpf/progs/bpf_qdisc_fq.c
> > index 1a3233a275c7e..8107f5934d2d7 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> > +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> > @@ -196,18 +196,13 @@ fq_flows_remove_front(struct bpf_list_head *head,=
 struct bpf_spin_lock *lock,
> >  static bool
> >  fq_flows_is_empty(struct bpf_list_head *head, struct bpf_spin_lock *lo=
ck)
> >  {
> > -     struct bpf_list_node *node;
> > +     bool empty;
> >
> >       bpf_spin_lock(lock);
> > -     node =3D bpf_list_pop_front(head);
> > -     if (node) {
> > -             bpf_list_push_front(head, node);
> > -             bpf_spin_unlock(lock);
> > -             return false;
> > -     }
> > +     empty =3D bpf_list_empty(head);
>
> [Severity: Low]
> Does bpf_list_empty() exist? A search of the codebase doesn't show this
> function being defined as a BPF helper, kfunc, or macro anywhere in the k=
ernel
> source or BPF headers.
>
> Since BPF list structures are opaque, their access must be mediated by
> verifier-recognized kfuncs. Will this cause a build failure due to an imp=
licit
> declaration?
>
> Could the existing bpf_list_front() kfunc be used instead to check list
> emptiness without mutation?
>
> >       bpf_spin_unlock(lock);
> >
> > -     return true;
> > +     return empty;
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524025853.13=
786-1-suchitkarunakaran@gmail.com?part=3D1


bpf_list_empty() is available in the current bpf-next and linux-next
trees, which is what this patch was based on. It has not yet been
merged into mainline or the current rc tree.
