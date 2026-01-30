Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C501BD9D0
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806055; cv=pass; b=FEXAvgu1YIqRbsAE/u5rLdzrGV72iymhAWOMLID0azVltAlZHas9poXXr/aO+v1mpYlb+c4kRBJIP0LHGFy0RKQBi1N5mN+e6Wx1LdG19EYfa+I/A7XyXIrJ5d+/HtHTJNNGNzvraj75V+aTFv52Y7wpRO1AK9bfWKoeSgcgCPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806055; c=relaxed/simple;
	bh=Sq7qKh7EMk48dHWt/Qluz1/8qTKafxCHaQEna2Tz7fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/f20cBZhCQsNKnS5QGKU9RvyqLjVXXaEAZTprAXCb15ZEdifYp66Yrw/9a8TcLBgFItrSgmrf4UvmKvwgiIDn/zE+RCvl8LV4VqpakpjKID14/5+wP4ZR/o7POPCas19nq4pj1tFLPl0FgdpXMtRgeuKCH9bMf4yKMtjTeII+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZW7zuZXa; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW7zuZXa"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso1467347a12.2
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 12:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769806053; cv=none;
        d=google.com; s=arc-20240605;
        b=XBJ+R9CVgXlIYRRRc1hXVbhIubi7U4971wM3I9WDASS1M5n2ox0HwAWc4W9jw9FeQ8
         YKySrLtq7rMwFirp9487Ws2dja7IgKm1TVcG54B67/UiMXcXAvZpPi/5vWMC3/oESTfo
         HbB0gZcMDfbyoY9py4mlRyW4lNJUE7gOSwkxp2Z6EBhk7l9RYaJhNfR1rZ9ErOuTBN4M
         luceam2pR2E2u5oAuUfWuWX+VA6CNvjaQZIl73nXfiZgJS1/BOFE5wJ+lKFrBrueCUZC
         GQEtPhneeNvvN4f13B4Qx47XRThGHelkZZQGRd5QW37poPcEaUmj+AgpZ/8n5vGsFP3P
         cmqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kDkPuGg5sHwz7KAxPzT1A9rLAgVe4LnrIU8HnzBCVHo=;
        fh=FWBWcGcUcvUwKDmAO1SSAbrmAtPVK/iZsqmQKjw2l20=;
        b=k8jvg/acdpcHX+PUjsJE6FkUGpFnGo8+5jbua1I6ltw7n8T0mNEkT4mmKdelhIadS+
         K/vI4GsMyk4oTy8w9aHQBnZ6NK7EPpwLN0GdHcYxdPu7OxwyUH+C+KHklBpjAex2uOAY
         Sx+Bx7C4sc68xhuejkelfCmPPiyAcKiJmuJXvXxhl5qLeHIoxvPzoi09ej3/WqYLnbXd
         5N16wB5+qpU/dKTvccYLxBd16wBnyDIN6D1Vg3FOSQORZICarocN7afXGpqqaFchKhpH
         VmUyEtxT77lsInYuStJ0Fy3FWEJQTqDv7Ql+H9ZvmRNT6hGAu/j4I1+whUJA20cpNcQR
         u2Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769806053; x=1770410853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDkPuGg5sHwz7KAxPzT1A9rLAgVe4LnrIU8HnzBCVHo=;
        b=ZW7zuZXaerMAKqlEwyiV49VfHQTqzaI4wFv/cI4f+O8/EYZc+YrvBtb1LAYNXDunz3
         /7Sm1YDyZk5mCZjF2Q058tHA+YSzIFg9LEFAnT6B1f4LHp5M3yOmgrr6VVmKACLljD1l
         vP/1zoAnC/Wamazdcul1S7VJfwUn9A7nWfRTWRSQj/nPXQj54Py/uxttN14vBWFpQswf
         ZFh7wyF2vRRCK1E/EIyJ3IMkgfUKG0oKDrDl85i5TGU58wwaO8sCmeXjS6iSHjIwItxb
         Www0gKW+NDFTbaA1+aM+ff9jwC/oblmxo7hPhMSWN8llhS+xZBpdDaXu7J9jJMaIJRMs
         rs+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806053; x=1770410853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kDkPuGg5sHwz7KAxPzT1A9rLAgVe4LnrIU8HnzBCVHo=;
        b=AMBqM/a9LwsH5sfbVMbvUbBmHnMsS5Dn9XIVEDeDx/NxopRtBfPOyi98Aa9ljzZnvv
         Bk0EHNkIv74PBtDMEeM317BEv+XNWFMmWTVUB91T8ljfgtuVwHabIN2BOLE2MvW7BCpU
         WdrYR6JHB76nODaRv8bHEZvjUyUskyDufkpHFI2lmBV4nNbNDOmBmcON+ByZXXzhxM5+
         vP8g/zuHJpJdTdUDvr4J3mbJtxKK2T4D9M81N9MAxc57rEN4yMAPI9Twb24f9lKgKu0k
         oI9ZU999Kpcu1NjbXbSs5i2Rl76wXNpztGzlNIMARQOavVNgFHOJu/z+StLAQQnw2GBz
         XMqA==
X-Forwarded-Encrypted: i=1; AJvYcCW/g4FvsUusQIdPvZ8sHMymF1xm0L4iM3UpuT7YgWXH1WbZKCdprTIuOPiFXcA+E1z8ow8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrnFm0Haw+zlY9huaaA83D+Rivi05XrbGTZlp4CmrStq0jWO2F
	kwhv9O9WSo69KWmmTtgEtIz8MdWCmSMvArWeFUsMFSc45JbpxmcY0tUumI4FWAFZMlUq6HmPn2p
	P0uDI/VQSt72rQv4ZEkUkgQiWD+9hDMY=
X-Gm-Gg: AZuq6aLFoh77LlXJ/+nQgINeh6M+q9sXr5NZdZCP0ww9cqX8n0M6crE8mCG3SaJRqNk
	tG8ZtUqD+mrC93AFnKijRQUvjaLG1h84zcXF+qfWBIIfi6DAObPtWvWFDyhDVMWG5CC5Ttb4w4g
	558xIGHwXLGJzN3ir0eYo3ITVKqkzjdzuOHL1WusRkajN0HQUyFwP/M8iR6B/TXWDPDRYDf5xYt
	ek3zY6b3MClhEN2RT3ueSyUOhSgBTufd1cM61/BwxHkwlPeKZpNieaU+fFoKiMtM8+F5fZ1CB92
	u/8evBCDj8I=
X-Received: by 2002:a17:90b:37c6:b0:349:3fe8:e7df with SMTP id
 98e67ed59e1d1-3543b38bdbfmr3697730a91.22.1769806052962; Fri, 30 Jan 2026
 12:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129215340.3742283-1-andrii@kernel.org> <202601301121.zr5U6ixA-lkp@intel.com>
 <CAEf4BzZthAONGByqvk3pHRT3GaA8=fNbz+d1V1CY1N8sHEcsjA@mail.gmail.com> <20260130124242.dbb7946b3592ffddac7c316a@linux-foundation.org>
In-Reply-To: <20260130124242.dbb7946b3592ffddac7c316a@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jan 2026 12:47:20 -0800
X-Gm-Features: AZwV_Qg6qiEP4IMJhs-KyomvrbnJXpik5IjgslLpgoiiekMmR439uSsS3HxxEv8
Message-ID: <CAEf4BzatC6zi2vm=acg7949nBKpb6m+L4ubvLKn6JmRwy8o2Bg@mail.gmail.com>
Subject: Re: [PATCH v2 mm-stable] procfs: avoid fetching build ID while
 holding VMA lock
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org, 
	oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, surenb@google.com, shakeel.butt@linux.dev, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 12:42=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 30 Jan 2026 12:11:31 -0800 Andrii Nakryiko <andrii.nakryiko@gmail=
.com> wrote:
>
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202601301121.zr5U6ixA=
-lkp@intel.com/
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> Warning: lib/buildid.c:348 This comment starts with '/**', but isn=
't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
> > >     * Parse build ID of ELF file
> >
> > So AI tells me to be a proper kernel-doc comment this should have been:
> >
> > * build_id_parse_file() - Parse build ID of ELF file
> >
> > Andrew, should I send v3 or you can just patch it up in-place? Thanks!
>
> No probs.
>
> The preceding two functions are trying to be kerneldoc but failed.  How
> about this?
>
>

yep, LGTM, thanks!

> --- a/lib/buildid.c~procfs-avoid-fetching-build-id-while-holding-vma-lock=
-fix
> +++ a/lib/buildid.c
> @@ -315,8 +315,8 @@ out:
>         return ret;
>  }
>
> -/*
> - * Parse build ID of ELF file mapped to vma
> +/**
> + * build_id_parse_nofault() - Parse build ID of ELF file mapped to vma
>   * @vma:      vma object
>   * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
>   * @size:     returns actual build id size in case of success
> @@ -334,8 +334,8 @@ int build_id_parse_nofault(struct vm_are
>         return __build_id_parse(vma->vm_file, build_id, size, false /* !m=
ay_fault */);
>  }
>
> -/*
> - * Parse build ID of ELF file mapped to VMA
> +/**
> + * build_id_parse() - Parse build ID of ELF file mapped to VMA
>   * @vma:      vma object
>   * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
>   * @size:     returns actual build id size in case of success
> @@ -354,7 +354,7 @@ int build_id_parse(struct vm_area_struct
>  }
>
>  /**
> - * Parse build ID of ELF file
> + * build_id_parse_file() - Parse build ID of ELF file
>   * @file:      file object
>   * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
>   * @size:     returns actual build id size in case of success
> _
>
