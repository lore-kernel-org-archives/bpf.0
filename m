Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03747FB1A
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791137394; cv=pass; b=c8wMRpKzeu+xujZUX4vGEjkPOD0OLTxsLu5dICoH/KCV8sRmVeA0SstwEz6GVb98vb4GSVIBWkhqvH8NuoU2zNwBTXYIHtqrTJNS7pPeNO8IayrXw4WcLmIxpZqyUqQS8Gi8Kl05MREwg6WGen8Pq254qTzpJmTb4sSi0HfQWgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791137394; c=relaxed/simple;
	bh=p8mpZNJ/Ji/VmSUc1fEHKip1nG8b1aj7rE3YFXNPflA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDtZ7GRT9dUplOl6Zve4MbX91e9Cu4qfudZQ8PgiconF/0WRERqnEgyhh9HpLjAfQ9oYmVCTo5af3k8W+Y0twI18D/J+7+kt9HIBkHJ4Gm0KKbWDu8xxv7MakLfwWGlbWybUMckrOTNLmgpW1ocIFKuI04HjErptgAJgUn3oX10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQoHbZhO; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQoHbZhO"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5337fa12431so185461cf.1
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 11:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791137388; cv=none;
        d=google.com; s=arc-20260327;
        b=Xti2/EPzTM/A8R0rVzNw3Rva1uD1FpBz1H98uaPgam6CZeWed9pOZ45JuIgrbxKLLo
         3LxahvcwEIdI7Lirgzwx3Tz83R/7N+bVcNycaaQHrBZLRkTVWBTLFb3OCl7jvt+Yfb2y
         5xZIaNON2h3CltSzds+X0OedlCw8Y2AcVwfglxUaYGCfhP+iyz37C3miccazn8TNq7R4
         MBiNTyWSF+lPlkvsnCcbVV0X5xgThJvW8lS+UCnlEHbX8cAmizcgeXMRqArGKJp19CmH
         rELrZ1OczyDDSLXlD3uHG/yXpKoaERfQ6fCey/RL/SznpUwvmoWnz4GxzmKv8VGlpFIM
         Gazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLyJnDD7le8j0fwG4PV8CX7G4WYRHL5RcOgxsV2u/6k=;
        fh=0TZNMpxCrAYMCfGRWU6riAqYAtFIAzdUAMcNrayJWsg=;
        b=H10az9+hKnlpRHhZYYvFYl7RceGjPEIq6bk7Qh+279LVhh6mXarwcP8j0TCjJEz4xZ
         m+SgKD214+NVXEaXPS5kiGxdz6Z0VUlKWRhAWlkFpgjYTc/YNRGylC8vYu1GhbYyIUAx
         fIgZFvIw8M/1WF7hDCtobSOM+mUlkG5gci3VUrCqtUl/0d7P3PAEZsVtcsvKE0ygjMIH
         qdJpAMFrVVjUbCak4glAbc7SUPtUR5WgOgiYUaV5liswkfLgnbbFfxx1Kor+vseXDZj+
         jaTt4ewqgJYEwVeN/Dy0Y42RV586T2H1OxcqjK3jIHS4zt4InNjBcecVWgdRUeYNDlz+
         3BEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791137388; x=1791742188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XLyJnDD7le8j0fwG4PV8CX7G4WYRHL5RcOgxsV2u/6k=;
        b=AQoHbZhODLn2mfCrdgDwCEMvBeVlC8jwsdW9CFBBzksHdi8cJisqSDBV1Biz441g6t
         RKsMdunXPyZWUeKao/KKYd/4zHxkA2dUpaeXXnB2Ip0AHcvsOMFPsRNyzHt/Wr3ioOR6
         6ZY5MuGmw7FbCkHw0/CZZ84fUSlVxejj1L25qkU/Ghd3azp5WSdMknuiN/8Z3+C9+WwC
         EziiKHwyleRn1QhVYIzXkTWeGKKh8pXsIo34qE6gsJavYLVZ4yT2oqIR3/TYEWShb+Ws
         upnHFV9P0w2F0BQ+XY6AIk6ckEd86kOBrvPWP5ELT8iHJ4xJUKi7jaae96pWPriP0w3p
         1F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791137388; x=1791742188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLyJnDD7le8j0fwG4PV8CX7G4WYRHL5RcOgxsV2u/6k=;
        b=ZcbGuKNMvXLNRRR646hnmeRGN+dV5xn10+ngjrp28G77R7T2K5wvLWGKXZ9OlOOHpx
         dh9kgfxE9p8GrqqghA+xKIYG8GOSCgsCoeLJOwWI64Scpby+lUWU7ecU3dIQ7lqrr6Sa
         kDfgLML7pfeiRG65Hytf6Z1UpNyhXOuuegoDOrebWbCaP7J1uVb22PFuGVkvruBnH+zC
         uArAYvYODhmNRSyvA+DuUmSibochmYP6guyue0QNGd5GIhXyNZM6PCT3BQ0bejSG5JH9
         UJr9Wchx6clfhPIQ4iXOdladmU0C9aRrtePikHQbZLOotPaxoNqk0baotC7nRiRZREVz
         NUnQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6RWAk9A4qm/Z1dCa9D6+kEMKVBEbELBOTst97hOxy1RHFkrZtO4ByWQM14Lwbs3xq4Ac=@vger.kernel.org
X-Gm-Message-State: AFuF++lQgeWn9uSov9JofiZBeEnn5vgbwC1fbLEiO9untv0zmv2njPpa
	v7W3oNqupUAKO5pE5+fvO5sUucCzdqbkvdLCJa9eJ+VfzYoNMnD8YmogA2ReFTXWKfmvcy8Fay4
	IXv3jVAGlQFGnHXYzuZYWT5dx2dtsKEC1Gbnf6Be+
X-Gm-Gg: AYBFou2ZEy0mpuRySF8z3lDmXhpr/jkWu/qyQ6khPgJkQVLF38OTGVXQLQiLkdAmpad
	4YhbtHF0ywdy45LT3eGRm2hvcZjwNzIhtP7Gn4B+GqpDqcGe2SGgy9SKclvreVdWxJ7aX7BTSCJ
	MVY6Vr8nvIq9B/PNWFDFQznmvsyU74ECkaHQq9k/lYBzszd0S1BmCtALVaKlkpaOSNyuTvk8X5i
	WNov0KrOodKqA26JYlFeMH3/DK6263vJw9lp0BMZaChTLaNrixtTfO8Tb9nJ2CwZ8UMIC5yexJY
	qnfryzr0zu5M67rRqFGACblu6txyHPBXIw16NguN/fxqFEFbmWDKFqlO
X-Received: by 2002:a05:622a:e159:10b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-535146449camr14146121cf.14.1791137386702; Sun, 04 Oct 2026
 11:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-19-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-19-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 11:09:35 -0700
X-Gm-Features: AclHuK-kwJ_Uo7kW-aV-ulJRzQPF_vjK2tdCaS-4gRgk6ACv9UztvH0OKE8MWEw
Message-ID: <CAJuCfpFKJ+31TZOWhwoTQTseOEy0AgAjz5eK9fdXmL40D0OY6Q@mail.gmail.com>
Subject: Re: [PATCH v4 19/38] HSI: cmt_speech: convert mmap hook to
 mmap_prepare, refactor
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:39=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Use the mmap_prepare in favour of the deprecated mmap hook as part of the
> work to convert one to another.
>
> Since this is simply a refcounted kernel page that has been allocated, it
> should not be marked VM_IO and should be inserted using the kernel page
> insertion mechanism, so convert it to do this instead.
>
> Use the VMA descriptor's private data field as a scratch buffer to store
> the page in - this stays valid throughout the kernel page mapping
> operation.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  drivers/hsi/clients/cmt_speech.c | 33 +++++++++------------------------
>  1 file changed, 9 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_s=
peech.c
> index 7226677ebde7..801697b74d4f 100644
> --- a/drivers/hsi/clients/cmt_speech.c
> +++ b/drivers/hsi/clients/cmt_speech.c
> @@ -1084,22 +1084,6 @@ static void cs_hsi_stop(struct cs_hsi_iface *hi)
>         kfree(hi);
>  }
>
> -static vm_fault_t cs_char_vma_fault(struct vm_fault *vmf)
> -{
> -       struct cs_char *csdata =3D vmf->vma->vm_private_data;
> -       struct page *page;
> -
> -       page =3D virt_to_page((void *)csdata->mmap_base);
> -       get_page(page);
> -       vmf->page =3D page;
> -
> -       return 0;
> -}
> -
> -static const struct vm_operations_struct cs_char_vm_ops =3D {
> -       .fault  =3D cs_char_vma_fault,
> -};
> -
>  static int cs_char_fasync(int fd, struct file *file, int on)
>  {
>         struct cs_char *csdata =3D file->private_data;
> @@ -1256,18 +1240,19 @@ static long cs_char_ioctl(struct file *file, unsi=
gned int cmd,
>         return r;
>  }
>
> -static int cs_char_mmap(struct file *file, struct vm_area_struct *vma)
> +static int cs_char_mmap_prepare(struct vm_area_desc *desc)
>  {
> -       if (vma->vm_end < vma->vm_start)
> -               return -EINVAL;
> +       struct file *file =3D desc->file;
> +       struct cs_char *csdata =3D file->private_data;
> +       struct page **pages =3D (struct page **)&desc->private_data;
>
> -       if (vma_pages(vma) !=3D 1)
> +       if (vma_desc_pages(desc) !=3D 1)
>                 return -EINVAL;
>
> -       vm_flags_set(vma, VM_IO | VM_DONTDUMP | VM_DONTEXPAND);
> -       vma->vm_ops =3D &cs_char_vm_ops;
> -       vma->vm_private_data =3D file->private_data;
> +       vma_desc_set_flags(desc, VMA_DONTDUMP_BIT, VMA_DONTEXPAND_BIT);
>
> +       *pages =3D virt_to_page((void *)csdata->mmap_base);
> +       mmap_action_map_kernel_pages_full(desc, pages);
>         return 0;
>  }
>
> @@ -1353,7 +1338,7 @@ static const struct file_operations cs_char_fops =
=3D {
>         .write          =3D cs_char_write,
>         .poll           =3D cs_char_poll,
>         .unlocked_ioctl =3D cs_char_ioctl,
> -       .mmap           =3D cs_char_mmap,
> +       .mmap_prepare   =3D cs_char_mmap_prepare,
>         .open           =3D cs_char_open,
>         .release        =3D cs_char_release,
>         .fasync         =3D cs_char_fasync,
>
> --
> 2.55.0
>
