Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42563368BF
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303651; cv=pass; b=HMlLpzTZerV+7N1wfxah6UiAhBF48Ukl1kjNbt/2r+QcWKOZtZ68AhZ/Iz1yCbRCsb0AL63A/4ZVzPIcp8GwhSHUcNUP36FIvv27vcfcvkIcfsavV6bfZoNTm7K/TGFelO2kDOu7ywppq3OZZGe+UbAV3e0X2eQqwsyqeMJYP+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303651; c=relaxed/simple;
	bh=CyWq8lzVTQnbyNyLsnJBEWEqt1LuimpGX7rKZ850W8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSxVO9POkH3PI2yhnCArIgl4ZQhj3mZ8Xf/XEbEGOFweFkWKoFy7Zkkzbc9DFXva9Lwg0JB9jVsxeCZh5IxNaUVG0U5l0NVx63pUYozxMcbbPCuNbI82Yy7hVDNUYu+5h/f86kW3gNToXF/J0JEDPEgA9CHOUT52xvHudv9q+P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MW8N4eGm; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW8N4eGm"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso96429055e9.3
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 08:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777303648; cv=none;
        d=google.com; s=arc-20240605;
        b=dXaSS2G0sbL6yUUAaIgwQQ/kmK9q61lMG4mizhrihteqrr4/iMwuhRQQFFKsfPfXLm
         4nDB7T1mvuS06YMUYmAeEsnBYTcE5PcGwcaMPrvjHFhV9wL8/ERUwnIPFRI++WRrlWyy
         5IYnSaT71P3hkK73nl0vSgSQz9VN9HtkvDKDCJxx12hV4Te6/m4gcTxYwxbCAehgZbY4
         5WnBcNqnlI5sOCjLKF0XbEi6V3wMq3OtzdNIHnZ6CLGZpbLOlrES1Atsz9stBLdQAquf
         63Gy2mW8f+pR49LHFd7I1qGMCt2yOKRuvwcomrMBSCs9HWc17iHajb5QM6LnDTaOEahw
         RdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2FRyQ/RyoABp4v/5IEB82Be0LFi6IsNcT/3z4X4HozI=;
        fh=bHut8uafaTwGSrH57QTQPo5zBOZzvEsBsnvWb7f/6Ko=;
        b=D0N/fW3EGvVJMMVGfghcmcJJ4LviTrhKsPnS5Njlp98Y5XwN7qUosBOwTkiDWljoYD
         pDU/LclOsQSHmanyloG9OddbE0lsMlWQGce6Hs9UCZ0xiPtj+zMe7qCjxqz85CQJ1ING
         TL9zZrnHFnq29VNCdWgQ4ZJRR9VMtH8lss6KEWFhgbEMttfZjBytInL4mAQL5noGPp75
         ErH28TC+y818+LexR6wGgR+C1u4zwZbsL14gTxpfPpy65P0Uz5zHk+e13WaZsDw3M0GW
         DaBs9luY/u3fvr38zJh0zC0kyokN2ByMHE9ACpndGneiRanbbB+/8O2if4yfHx/JcMM0
         y9qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777303648; x=1777908448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FRyQ/RyoABp4v/5IEB82Be0LFi6IsNcT/3z4X4HozI=;
        b=MW8N4eGmjmCpOE8QqvDhbI22HJhv1FNfSFIQP7p9wnoyiUJDgVtBruv33T8tE+mOh8
         CGDrrGfr4LsFcF3mPTxO2M5GRbTz+8iv4dI7H/FIKoky+msSI78owBcufxSlb3vjLicS
         BHfmMzK4WlF9Gy6QWbEkgufPXANWY2nzAYfB2z0IJsv+onq4Z3iTYptPviDtqhT3HFXw
         GMKlkF3z6u1qPVEGkhHHh5sGUC2gsnQSQiM/D9gZCoRZX7T5al/IYcIaxMFBvZHDcRcA
         JMboiCAio/XRYyJ4IqXGfIqK6pXqEp4vaHFNcWYaCDllWX1JuusKIcH6I1GAUWTTOxqG
         gCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777303648; x=1777908448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2FRyQ/RyoABp4v/5IEB82Be0LFi6IsNcT/3z4X4HozI=;
        b=qg4wLunuUnQ9b/zaFXHXhm5dGYmNQ1HMWabcWGQCI8l1QkXzpKqYi2b/KsNM2RX5Ma
         Lea9sc/QVgBCgf7fOR/PnpS70gCltuUUG6TfwXfoNuEhb4N20yNwzbHqZifHj/iWO1Jt
         Y9Ga3iTtohbj1xRtUnC02+jtaRr79HxIpb3seLHwnahxLlUMNUdKyYItYtuK/PErA7Go
         6v08M8U3eaDpAAkd2Hjs/X30kX4KsVU+RU52cLYykYxcXYx6HxdbC33ZRgGH1fpes2hO
         MO+rKZIEXz7vhdy4bcOh3SzON2A3MmW21uI96TyfxapaO7SskIxoTA9Ne5HC2wkA/Sm6
         5j3w==
X-Forwarded-Encrypted: i=1; AFNElJ8UnuuXrXPV0QxjKtQsl37Xj4OizQqsM7ZTXtR1ppwo0fYJzjKwkU7qAOUtr1S6s/OcOCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfWy0azmua4EeBKwCFIVX/6A+bYmsTR5UQ5jw/s92ZW5BLpDYf
	xkum57D5vUm5I/HxyegbxG5EliPkKzsV22cGHrPExNL1ItgA2BpSbRH5WVMMbDjBwd3D2kAsqyw
	3J3JP+w5TuFf2zp7XcT+wXTKmqvZSuUU=
X-Gm-Gg: AeBDiev0IW9N+tRUJ3YFhMJI+C0brLYPOWj3b4Quw+QiRc6ov8zHdKrOIlZzQESRA+s
	yFPwCi/oU1nPfKg9fSNr/9CIQjd4mWGIFdxq7m4RH3C8Pf0z3T9lCHOrclpeFhrjI5YAIxq2s2h
	lBaq+D96eUXgJms5MoPwZgwav1pU3Q1TZjyEnXXjR1/xJmlMdzLOgT2pIAtb+igu5CLONMlH9Mx
	ChKuK6238xIDQL2ZUc6H87ZZBSGDdNxOhoFh66ztdJcBMkbkToHO6Cd+t9PKACW3gPssTymlwlc
	7KQsK+wh2Wm3y364W/urV/XGNtxZuL1C1LF4EiOVgKIDbR6/BHsEoSaRjsf1U3Pp3Mlz3XJWz7a
	uCyk=
X-Received: by 2002:a05:6000:4210:b0:43f:e808:4ee2 with SMTP id
 ffacd0b85a97d-43fe8084f09mr59050768f8f.8.1777303647931; Mon, 27 Apr 2026
 08:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
 <20260427-page_mapped-v1-2-e89c3592c74c@kernel.org> <20260427051758.e1b714a4b567917971920eaa@linux-foundation.org>
 <CAADnVQJ9JXrtAnFgE8UFK=W1GDeT6T6Wi5zB7g0AfRjU8M4=bQ@mail.gmail.com> <20260427081547.4cdbb9a5cade734f143902f0@linux-foundation.org>
In-Reply-To: <20260427081547.4cdbb9a5cade734f143902f0@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Apr 2026 16:27:17 +0100
X-Gm-Features: AVHnY4LB0ND1Dxh4uexvvpYN_DjpDVF5ij1OjppIGQ47kx58EMkgeVIQzdtUyxE
Message-ID: <CAADnVQKN_6fCMnv2OC3at4X1v=vuah+_LrwW2PQUYkVXqqVGVQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] bpf: arena: use page_ref_count() instead of
 page_mapped() in arena_free_pages()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam@infradead.org>, linux-sh@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 4:15=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 27 Apr 2026 16:00:59 +0100 Alexei Starovoitov <alexei.starovoitov=
@gmail.com> wrote:
>
> > > >
> > > > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > > > ---
> > > >  kernel/bpf/arena.c | 2 +-
> > >
> > > BPF maintainers will probably want to carry this in the BPF tree.
> > > That's fine - please go ahead and add it.  I'll carry a duplicate in
> > > mm.git so it compiles.
> >
> > We cannot carry the same patch in 2 trees.
>
> Git is fine with that.
>
> > Sooner or later it will create problems for linux-next
> > and issues during merge window if more changes
> > are done in the same area.
> > The only way to share a patch between trees is to
> > create a stable branch and pull it into 2 trees
> > then sha will be the same,
>
> For a single one-line patch?

Number of changed lines is irrelevant.
If there will be a commit on top that moves this line
or lines within the hunk, git will be confused depending
on order of pulls.
We learned this lesson the hard way.
