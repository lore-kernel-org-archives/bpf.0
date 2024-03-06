Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887D138489
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745028; cv=none; b=GIQk5SerI5RRhHeIzhsfVzrNeBxMOJQEheAcRWzbRUSStXlZ6S2MGjMNPwbd65maUwZ7RsaAiGzkDJj15O9/lJuSNNrZrlY9W4UZMmw56OpHaxgh+ZKzLccHCwMAZRYd0ICRQ2TUUMMAk9/iMDJDb33O+dPKjBCtCIhVNTOIeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745028; c=relaxed/simple;
	bh=6OBT5bXPkoyKLfYbddxD+ROvxBpl2W6PqRGiln/kPZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIk2ZTpbUqeZNE1TvTMpOsMC1BOal0ZwTf0pgdIlb7iCdJPiZj6OEES30ACqsDVfMQhk909lXiJae7WE1NwyVSVAjqRc0+6HvBfxxJ9rlf+aYjvJxvz/J8EmUYwfjGcybwyA8r4hA+fcs8r2SKBgF6PFSpuqlsl1A8phUwlkgI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSHyBqxM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSHyBqxM"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d118a181fso4565997f8f.1
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 09:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709745025; x=1710349825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OBT5bXPkoyKLfYbddxD+ROvxBpl2W6PqRGiln/kPZA=;
        b=OSHyBqxMGQ9Y+ohW9OvocwfwpQ/0um/ojObI1IMpFidUK0JIjufsJSUl76a6ZY3ljL
         F8Z8KBtr0QOUwwFVu3XxtBmFQbZ157GzGc7RfXmOJ8lGsOYJDCF9nEIXOiEUDrEYo2Y0
         M4A5y7sesxyJj+A0Am3nDcr6M5ptjCjLvwlCWPKjQQ+g5feny07djuEBxgQ5lunQaufa
         3DJSX7tj2/GZ6L4V3r7tLpm1VI40qPwm40prsaCiJIdSvdZdwJ4zV95m5u9M7gHfBRvK
         0VwFaWR8zgACVjmwpgyeUaxbsCYK2BGB0Ve9A1d+7ynXsJqyNkMzvu5HM+n5ZbN5SVNR
         N+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709745025; x=1710349825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OBT5bXPkoyKLfYbddxD+ROvxBpl2W6PqRGiln/kPZA=;
        b=mWRHeuVB20qtHRGoLDWIpLQ08jasd/4XfVZFKTtNIxGdbPkN69QmHgEKvO2RnuIFv2
         ADhOxlxSXDzgVISzbJiLfvlFACaYfyIF9LQ9V4RixwHeVHPm/Du20QHjhvZ8PyxIDQxb
         Rru4I4XwOO1Y9Mjqhag28H5YEMZerHSYpcjQLyLEhSvSQXs31Vb7MBrr/kUYPlG8a8zX
         fl4HhfPKj1fdn82rP/0S+tRkgFtTJuTWCScRsMs7ok8Sgo5mwTRnMvVhZnT1h+hkPn7o
         7bfA3raGChJgBdV+jAVuFWCfRlrrs7gWzoKh9iLlqPsAcNzQUGLxQTmY93AomJrcQmfY
         SSfg==
X-Gm-Message-State: AOJu0YxqyctZDcQVr8+Lq+5NaIxFUomzsCuyyLcyExGLYoY3gRQLiopc
	HC7wQ2SYNFwGCICBm62iD1gxY0/geJvxVYTY7WcBE9/vE+i9hS0u6560OYmvPLNTLtlMQwLO7v7
	0fP0fRNUzz6w3ndgAXUJ4Yt+NWXI=
X-Google-Smtp-Source: AGHT+IHaHVgqaJ3Ya0z3ySAjTfGHID85e3oHDABmYYIqlhem3rnxGpjGokEsyeU7EVdhOrO/Ul5MOUMj1O2grGSJe8Q=
X-Received: by 2002:adf:f74d:0:b0:33e:cc6:a998 with SMTP id
 z13-20020adff74d000000b0033e0cc6a998mr10007258wrp.6.1709745024405; Wed, 06
 Mar 2024 09:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
 <20240305030516.41519-3-alexei.starovoitov@gmail.com> <Zeh7bTYotfaKoCVD@infradead.org>
In-Reply-To: <Zeh7bTYotfaKoCVD@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Mar 2024 09:10:13 -0800
Message-ID: <CAADnVQ+-+LHbNgKv_MTOkM307BD0U2OfnjqAnKCL7wFiGuge9g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
To: Christoph Hellwig <hch@infradead.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, sstabellini@kernel.org, 
	Juergen Gross <jgross@suse.com>, linux-mm <linux-mm@kvack.org>, xen-devel@lists.xenproject.org, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:19=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> I'd still prefer to hide the vm_area, but for now:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you.
I will think of a way to move get_vm_area() to mm/internal.h and
propose a plan by lsf/mm/bpf in May.
