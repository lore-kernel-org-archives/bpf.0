Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2B51A74C
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763501; cv=pass; b=uO8/AiVXI+P3GktdNIeRN9xp+IcHuqFnzNNr5/Avny1q41Hw3N/dr8gLemKe8f4y5KnPe4toH9CHuyaCHT4RTFmg8etY0PVv9Ihm/RT4DIWQKH+7vZuI6kkdK373ggnr0ioeOyq53YamoDufl3xtNR2jf/l6GZiFrwunZB0h9Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763501; c=relaxed/simple;
	bh=B8p7ihCHzGvnzup/C6y6XYLlWrQRIq7YUbOlQS6xj3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1oFOHqZOe4LotCvDPGQXjnPAavmSItrh5J8moOo+oO9r/ehgeWMW5yCXfX5c7hMEO0i0xE73GeLsLRUbbFqRcS60bRKt3PBkfdlycFKQKKRbLxE7iclg/1uBYAAppIYp2OsYEx1v5b9An15rN9bLkZyaROgnevk9RIbhxxUwdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UU0wjojH; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UU0wjojH"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53113d72966so9421cf.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 13:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789763498; cv=none;
        d=google.com; s=arc-20260327;
        b=BvL3m/tMTfCT7Q53BWyAUNyqQGtdjmrzZ6HHv1DBR2PnPY90cm+JPjdvCekTkCR7F0
         B3NhlGINpHjUXW4LpBHrukUTaCyhkq1ippY+w6MNeuSajH3UZmRkQMnQZorpxUoNwjZA
         4FrJIi+rjMTL+iSvqrrEWIOhdYJ21uOu6DsvMX5C2hbZ1PkVAtNKMS/kjVhqJxOZc3Vy
         8ujHQFGhzmsFZNaawEPEZJP97+Nd/9xZJP7graWV0jVUjPPs/iAnfLW9uG4lHI3FMWHV
         GcQm9VVZinjdZDq6hAsliZTDDR/ZDgHOJsv8qxsJqKv7/NLJr9zB9AIxXfCnhZBix1jE
         +1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rakr0DVeS6w19WPN+xiAqZEbcFGWWdpHaQBH8HXSGgc=;
        fh=uyxMyE9hwQtbVLhBned9Pr2icF7uEIkJTf2HX6Cqx/A=;
        b=EeNKt/9dyp6aUQQLtBhfKH++FkcE880zH8oSDUpKrJYSAU7mE5DuSLWRsB1Xeh5yNn
         Vn6DtYymmasVd6vk90QULtx64LGFYofkHhYoz2WzFDW1RxBl41q/YQbjeMwDlGY8XYIv
         ly0dZ/zSq9h994kCvDQkhsGRdRMJAEY7YIFqgEZ26JBK4sdOblYtHvPzrOcuy3fL+jnc
         K0BuzrVv/sGAykXDW6IpKmFOpZIShEwx1fU2/7PJ0pF4SdphhJLXQmDqzZrunFPBuvKL
         JaWic9gPw83S66KiY9mfgOzfxj9XVoei4J8/fcLRYQEUNrxy1hlG2sOvLP099XNSl9jG
         nEOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789763498; x=1790368298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rakr0DVeS6w19WPN+xiAqZEbcFGWWdpHaQBH8HXSGgc=;
        b=UU0wjojHMZJdEefbV+oe7n3/1SeoG/dOO8hNK7Tj8QvphQy34bQ/TtZfJPFMbLM7Dz
         Y/YVWKsh9GRn1f4QL5Y0tAv574p+Z233A80/H7Il2x+C3qiCdyydEpXhoIeUomNkSzt1
         u26uedB4a+lTAzO3+lsk9SL/2xRHXFuNtkCjCNLqhT5/eS3sAp8P6KWPemR4yNW03+/t
         Y8eKGMCmYLtIa9slPbZ5/d3cujTWZUj7oR6ZaFLAEvvN8VjRm9Zsvsy20ZCKhB4uDz4q
         NgoOUOU2qI60k2fnz6n/kBaIH6Wtw6G2RqENciuFm00/6+5swPRTI5zkRENNInuJF/fH
         XfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789763498; x=1790368298;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rakr0DVeS6w19WPN+xiAqZEbcFGWWdpHaQBH8HXSGgc=;
        b=K4KhLGr5jdVVrEdMRqf49MFdpgZ+uKfTqq5fqL4X5z6WaCx+kd3AoGswNgGVTOpuVX
         GocYSO58NKHq3qOc+NDIEkxFHU6VxZAwClDRPUB+qTgsxM0+fmQf5Offu0yp8cb2gRUd
         4Uf1cZW80gLg0F/rh/ucR7OAWUkRUa83azstFK5F868mdoSwUUCMFt4ZcVLWwxEdp5at
         HuvreGNQJpbUG2K2YHcrO6d+2/Gjzu50IVtnI14hOjBoC8jPFAXVP/VA/lDDgHQ7ZPsH
         CJyDhGwYHXEM6XlzatH6dvPJ3+gV0Rlzt46b4hdE76VVAJS2zkVkyTA5Tl5/t6gZPah+
         XO/g==
X-Forwarded-Encrypted: i=1; AKwUvByXB2NQIRcEw61T51O7AkmNLS3voGwClpwo9UBBUxpEFuZ5vnSxOtB3T822liQlqFxQjYE=@vger.kernel.org
X-Gm-Message-State: AFuF++ngMpNj6xApYfu1awexGKExQwtH9EmLlFyJuIXOR8sHCvSNjbtD
	g33ovTI4J1EG6DI8J+RlDx1CB/ZKxjxWqbhIRD4ctln3eGtQiwkoSRBLsiPejPU2hMOswu+gRmS
	Tg+aTt1MQzcBv07e5tHod6AdQIcX/c3IiIbZbBTew
X-Gm-Gg: AYBFou02H82UwBXoqtsS3tmK1o3unITbzCK+1/uFidop562ck7dUVPfxz4e2ybtzwJj
	QGeryFGemXX3hJr6Gyg3zE1/aHcz/gilBJ788FsiqqnYC8wyoMYOHJpYLIMNDGbNoa2eT2PUaWl
	Gm6mTAlTLOccOuJpkSD2AhL6Ya8wCDZbN8230/I3pvIBlqaef9pgqTNP3f8DRXYZNoaYXlt8OoL
	Ox08WW5rKJJwsO3hFPSScWPkBLzetes8IJYFBUCp0ygI+LmjG6G5BiXjQxznq1YI/y4Zb+u5d4l
	cKztL5v2RZaABRVMwT03CyTTPZmjgns1o+Zz7pxI0nR/1N3vNVlqiQ==
X-Received: by 2002:ac8:5d08:0:b0:530:2f98:cebb with SMTP id
 d75a77b69052e-532b099561dmr605641cf.11.1789763497212; Fri, 18 Sep 2026
 13:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914180811.057cba8fcc48d6e0b53a2683@linux-foundation.org> <0b064fe6-ddb3-4f26-a1f2-2e9dd88d590f@kernel.org>
In-Reply-To: <0b064fe6-ddb3-4f26-a1f2-2e9dd88d590f@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 18 Sep 2026 13:31:24 -0700
X-Gm-Features: AcwNN1VqLTR47MatnNlBWbpWA8EMmoQNGykspJvqoxdaovPnF0EYfRCWZF-8zh0
Message-ID: <CAJuCfpFBichJH4OcmSHTb1rOuQBT6k5pXeua9_KgpWjDBKvsYw@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] mm: make VMA flag semantics explicit, eliminate VM_SPECIAL
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
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
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
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
	fuse-devel@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 1:21=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/15/26 03:08, Andrew Morton wrote:
> > On Mon, 14 Sep 2026 15:57:20 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.=
org> wrote:
> >
> >> The VM_SPECIAL / VMA_SPECIAL_FLAGS mask conflates several unrelated
> >> properties:
> >>
> >> ...
> >>
> >> It's all rather a mess.
> >>
> >> This series brings some order to things by both limiting what drivers =
can
> >> do with VMA flags and switching to using predicates that describe
> >> behaviour, not arbitrary flags.
> >
> > That's a lot of patches.
> >
> > Review is thin and I expect this won't improve a lot.  Lots of "no
> > functional changes" changes.
>
> I'll expect to go through all of them. Might just take a bit ;)

ditto

>
> --
> Cheers,
>
> David
