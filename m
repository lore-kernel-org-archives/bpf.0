Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA9B2C688
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918531; cv=none; b=LSqZY8EEF5U1xsoqSb6ICoKv5OZC/ho2azrijgAPeKS0TI+ppNlforeK4ZzPEFixqXwLOt7A7M+CzakH017wqEYQrpU2APTu4Xw6OsC9Tw6zExdpNVirSAh5rJD+qjpcQRi+sh5NLVzcsEjTkp3fgPghFrKLvEylVnIGgkRPVok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918531; c=relaxed/simple;
	bh=jucViIz8xwJxIjrz/FZM/DDlB3DLqqBFRzm+RODn104=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9TDdRqjJSPX6FDI/WOyOdKX3ACaSW2zHd+zAIndCBn1eqJMuV7y/qKtDK5vYD3Z7jRJZFDBTwqz30DLhTNkyJQGWgwDl+K85J9agTZK1u+/Z8Fg2wbfKr0dl6cs5YWkKoj7PexfM6MEsoMhI5iS5ZQg0nSgPaakxvEdISqc6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEGHHeig; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEGHHeig"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e695d0614so657872f8f.0
        for <bpf@vger.kernel.org>; Fri, 08 Mar 2024 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709918528; x=1710523328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jucViIz8xwJxIjrz/FZM/DDlB3DLqqBFRzm+RODn104=;
        b=gEGHHeigCUNMAWiFKQs1UUoABsrLjLhRQfK8PzeWusd3ggsveQiRWpfgD0lqt5/26F
         B5QCTDRW4QwMmozKXeavtdo435+aDiUpQkyDiVtOkBV4fc6NbmfN+WS5FkXSwyD3CInm
         XQiOZeWdbHljefA6BBHnMUlXmo4TI8gggerTfzArjQoKT/gY7nUNIBD9BksGqw1ub7Ho
         mIhNBvLgz4lC+RGAvKTRUMBkWro4bZJjvnfI1buF9vjfG2QKRKzMCFwusff4APmePglZ
         GHe/eqLNWhj77uPU4qIqkakoM4Z/uwlA0KsZq9kE16C99lW2DS1G7/e+w91f5W/VmsRP
         OXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709918528; x=1710523328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jucViIz8xwJxIjrz/FZM/DDlB3DLqqBFRzm+RODn104=;
        b=CHQXPCMGMifRwvxV02yKV/LbjOAaY8Cd6Gd6GMSx7zGw4vzhK2BlbMgGNf7Xyn8ipJ
         x6wcBgRg8TgWMt3C7YvBjfkbYjLtwHRVDlU+IlkfZJncGFpHoemSzynwrzjsYJDbeW+6
         X+rb/CzvMB4BAGiSOKYvqjxPssM1P6m/Vx8cCwtIcUYXSLhzy5EUI5g0LS48UTE1gNDh
         2lBv2xb21tNdnhfASYaL87hh5uZkcFvSMCE6/dCJXfzOU5eEtBSTtT47O3/93iTxTOMI
         OOP62dOhNtaPnDw7egpB7HRbUar6C+zguj1/GfmahOlQdK8VLePEDFc6J2K+WG7UlVNb
         z4eQ==
X-Gm-Message-State: AOJu0Yx45FsotXJ6QB3jxNJL0YZP4xgBDld/jsU9rVM7UErdJ+SausMi
	cLf/A86Fv41l48MxM67ve25R1P3fP5lxfhRYQakPnJ6eH6VUd5ENuFULSbacQAwNMlwqmghebXX
	51l9nv6WlOCCZ/pEEn6YpQqc7bRA=
X-Google-Smtp-Source: AGHT+IEsyTvVxIZznYVc7DZoZGa2Ni1s/uRtj8TYmazDkx3DsdR9S3CA2W36uHp4bLl2A4XXQ6ZxfYXr1V2wkcErN0Q=
X-Received: by 2002:a5d:670a:0:b0:33e:7c19:dec8 with SMTP id
 o10-20020a5d670a000000b0033e7c19dec8mr208779wru.21.1709918527648; Fri, 08 Mar
 2024 09:22:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
 <CGME20240308171422eucas1p293895be469655aa618535cf199b0c43a@eucas1p2.samsung.com>
 <20240305030516.41519-2-alexei.starovoitov@gmail.com> <1f49d568-24f9-4003-b222-515f33a99cf2@samsung.com>
In-Reply-To: <1f49d568-24f9-4003-b222-515f33a99cf2@samsung.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Mar 2024 09:21:56 -0800
Message-ID: <CAADnVQJNjz5W+7-SA5n3R1_8Y2qtj1F4xvEU-zd-tk8mh7mXAw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, sstabellini@kernel.org, 
	Juergen Gross <jgross@suse.com>, linux-mm <linux-mm@kvack.org>, xen-devel@lists.xenproject.org, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 9:14=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 05.03.2024 04:05, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > There are various users of get_vm_area() + ioremap_page_range() APIs.
> > Enforce that get_vm_area() was requested as VM_IOREMAP type and range
> > passed to ioremap_page_range() matches created vm_area to avoid
> > accidentally ioremap-ing into wrong address range.
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> This patch landed in today's linux-next as commit 3e49a866c9dc ("mm:
> Enforce VM_IOREMAP flag and range in ioremap_page_range.").
> Unfortunately it triggers the following warning on all my test machines
> with PCI bridges. Here is an example reproduced with QEMU and ARM64
> 'virt' machine:

Sorry about the breakage.
Here is the thread where we're discussing the fix:
https://lore.kernel.org/bpf/CAADnVQLP=3DdxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=
=3DaRgCPQ@mail.gmail.com/
