Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85002EC0A2
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325913; cv=pass; b=DvjQc+mkkk7Kez47kW2rs8iLwgkOY13AnJpNtunprB3hqy8/DLy1q0XHpySm+MfjRXl+QTmQ2RIv0jygIIknFJmmFnKg5HYHdHXAu1GiCHWnZzV1dskd4aXpZuMh0qKBEj3lTUeJGyPOkNXIY+g5N8ctQnjPiIMYd0Spa78RPUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325913; c=relaxed/simple;
	bh=YGFUuabLhboE2TpWlFjYOpLZxbVhUV9ZG2G0W6iTEeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQBbHRcV1Lyzv3jZ1Zlj21VxbubdhsIbRqw/Yli4o+DTfcG2L0rl8zVG7LFXkNEAuWlK4BeqkT2bxu864gUb4BKS3gM4tqvzvnNw/C1IdrL7UifivEG0jcWkr1/6qVVoJW+iwgUqYm3Uy15PBeQhFkcf9PFPDRiifuO6WW/nb74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZLAvI1O; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZLAvI1O"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488d2079582so126728815e9.2
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 14:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777325909; cv=none;
        d=google.com; s=arc-20240605;
        b=jNdZUBHU7JR+SfsU1rP2NyISt6CdEhq9TkPCSRhnth73KgLF6irGoAa78mD/MVzAg5
         FWIKo66c7v6H/EijBxXXyAbFJVJzESs608nINTKT0qMhRy96yEPtXfOewgqUfO3GCEqe
         oTvekEx7rE+JvqXwJM6goH278sanG4nBBezJXt1tFdTen/FDaUqeCNKmOnfU5OHgbGUj
         5AE6rKDKJNbK8YyhhntwTqyUP1UclSucKzDBXvTDzIcf5Bpges9/VcdJw8SY6YRt0eCd
         OYkim/t0R9Z5lMLFSlSBRXY8/70e0LdPpI0+O94YX9GTgOxez4Q9imC7wtVvYluI9EyO
         CQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/TVU4nsu4bcRfWhQiDtREc5LpuHyEjGWAmgNF/qgKo0=;
        fh=QflCMvBHxyDyu/YZMhGtwzKYIsyZeWWi2XRzfhSehsw=;
        b=Aq7Hm10F3+sy9Zaj7spNEEO9Yv1PywkY3oY7kCMeUOZH1sZXgg0MtatstEyLJZGRs5
         Yj8H3CVR2U89Yyy8JkthVFR4QDcLpCmJQ0ToNZ+U7Jzsca5bMHmybU1VK1aKAVHHXdwC
         cvgz7hUgyuJqz3ir94O0vtdFHDkjFWld56O2V/XgYetWBPzQjV7AeqmYOPJFxNiMHYBP
         jw6Ttju7WSY7ON7wCPLG+dlUAb4wxDeoUsJQqNeX+KrJj1pwcU6nAGmvUG4agxYdZZun
         W9oaDO8760/r3rgJa6vqtxn1ZQa5tGPZS/IuwG6hkRJfjHTufNtW3i/gloeWwWAANPUv
         NWJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777325909; x=1777930709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TVU4nsu4bcRfWhQiDtREc5LpuHyEjGWAmgNF/qgKo0=;
        b=eZLAvI1Oq8CW2yG0+ocwCvLVIdwPDKW9ZY0JuD1AY86CkRPdPjbphpKp4UwgFM82+D
         6cIWiv4zm4pueOyj/HMuMpJmZIqAAaR0HA1R05NCNIyKVNRPmsL3SEaeP4ZK/1mtDIyk
         gRs+W8RXHm2/azXRk61wDBuNGjlm6rcT9DbM7CI29Dxtubc5ntjI+UxGv9gjKMXvIqI7
         2tf2wyikZLTlrIDFY8ykAmWoymwwSdmZksTWonzJf9oWK2luSr5cLx3IiyL+VScrLWl+
         CCi+I4VByR7rr8i8PQ1c19a7yz2HcNO+MeSpY0Dt767hR4PCJp4C7mhu8jH742T3ghKH
         4fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325909; x=1777930709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/TVU4nsu4bcRfWhQiDtREc5LpuHyEjGWAmgNF/qgKo0=;
        b=akgyLaI7fcP3l9H7llREdmhxvGxnvdOGzBaG9LuooAUlXvhkWDylOt0FnfOtpEo1AS
         EWb10hDsx+vNgLuK7i4tetxJNHUcuMMSqJq22v8flMANsjncJu769hgXk4/4bWRkB/FF
         lIdqRMdvSGoBA7aYz9oRLV8/AbzgzI0Da4SVtVaDmWMXS3Y4GIU+d2dlx+JDqFoIIYel
         rELZIUjpXPBz1AngCNIIicNhSLsuNaYo62UdDV00nnDzJanh4sXupxkX/w76Ku1icb1V
         izWPmFe9i+HwD1/ESltGNt8BZMO6NOgA4+bA7Atf2hVXI0NnoQV9/eD05EAWQLLriJOq
         97Tg==
X-Forwarded-Encrypted: i=1; AFNElJ/juu2uSn4qbxlqK4jJ4M/Yk46yfdjtzgIKzWPVs5WBsXUa8aFxObJalfrPb2B8etCSXbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBROzR+Nhbnq83ADfz1C2QPfExov4hAXVRH+Olloq+RQTF6Gp1
	o6bmhdjlK8uR/RP4s8UOgZrZlUfRG2tgmNKwZZ2lHA/85YuFpVmZareMDkUdU0fj1GqTH7AfQS9
	ICQcqd2KrvZLaznxjwTQJjcOk9XoVpz8=
X-Gm-Gg: AeBDieuHwgNcYlXnFP4wzG9tU4mANBtUx3oCTK7VIA6hywkZFbXveRmQeqlgxA+GIBN
	m0ySdndE199F+GikiQmwpTxAlRT0KtW1LUiZIthNexIebzTGfcv15BTnm7S1DIz+g1sQMDj4L1r
	1cxdw1kD0biZCNUhPoXNYckiOkMqvCgD/SmFfEO3bXiBDRIwJxQeXOIGDEmyOFV6cqmZAF+8Orr
	GZdBMETN5V9BaFgBx3D3n2NmQH7QNgEU/O3/6ZTrPeWh62N4GNs77dNtb3h+Xmc+m9TTLfvIP9v
	rcZWVR2x/hKTQSv7pilu6Leb3uUGW/QaRsmzoQ0q70R8eeHy0ZGZkPdRLyRuZbcZoBhJ3978NoB
	5jPw=
X-Received: by 2002:a05:600c:34c6:b0:488:8840:e5ae with SMTP id
 5b1f17b1804b1-48a77b25335mr5030135e9.24.1777325909037; Mon, 27 Apr 2026
 14:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org> <97192ac3-643d-4393-87ef-53a9f3ddaf95@kernel.org>
In-Reply-To: <97192ac3-643d-4393-87ef-53a9f3ddaf95@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Apr 2026 22:38:17 +0100
X-Gm-Features: AVHnY4II_oIb8C3aVippcvmoyZheListN6_PokHgWDygL-8vIswX205VDGz9ilg
Message-ID: <CAADnVQ+t549-aWEXq=ZUN79H-M=std3-Q8w3fU+dyNhF7mNjyA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm: remove page_mapped()
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam@infradead.org>, linux-sh@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 9:59=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 4/27/26 13:43, David Hildenbrand (Arm) wrote:
> > While preparing my slides for an LSF/MM talk, I realized that I did not
> > yet remove page_mapped().
> >
> > So let's do that. In the BPF arena code it's unclear which memdesc we
> > would want to allocate in the future: certainly something with a
> > refcount, but likely none with a mapcount. So let's just rely on
> > the page refcount instead to decide whether we want to try zapping the
> > page from user page tables.
> >
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > ---
>
> I scanned AI review and I think it founds something that is not related t=
o this
> patch.
>
> We use the page_mapped()->page_ref_count() check as an optimization to av=
oid
> calling zap_vma_range(). We must be able to call it even without that opt=
imization.
>
> Just like the bulk zap call earlier
>
>         if (page_cnt > 1)
>                 /* bulk zap if multiple pages being freed */
>                 zap_pages(arena, full_uaddr, page_cnt);
>
> It talks about concurrent "munmap(), unmap_region() executes unmap_vmas()=
"
> racing with our zap_vma_range().
>
> Looking into the details, arena_map_mmap() calls remember_vma(). We rejec=
t
> mremap and VMA split. arena_vm_close() removes the VMA from the list. The
> arena->lock protects our VMA list.
>
> So in zap_pages, the VMA cannot go away. If we find a VMA, ->close could =
not
> have been called yet.
>
> In vma.c, we call remove_vma() after vms_clear_pte(). So after unmapping =
the
> pages and freeing the page tables.
>
> So munmap() can indeed race with zap_vma_range(), and the page_mapped() c=
heck
> would not have changed anything about that really.
>
>
> @BPF folks: does BPF take anywhere the mmap lock in read mode before call=
ing
> zap_vma_range()? It should do that.

Yes, but do NOT. As I explained to Andrew.
It's a git mess. I don't want any more changes that cross trees.
