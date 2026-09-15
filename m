Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449BD370D43
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458685; cv=none; b=XOt6mIycz6nEIr27/Mp1XgAFjOFBJaX3KgZ7b/uGvHwNvk6/MbOZeU7rK9w0PSssnfjFXGWzEGUHboD9YyY1htbT3VLhWUpixvgMCBjDhzeVFYHgN609B5Hux6VMv0t+LylZ+1D4QLnPlahwMIlyWWAUJonnQk5t37tA+SM2uMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458685; c=relaxed/simple;
	bh=GDUBZD6Fkzuze5OX213usXW7jyZKZ8hUSdP8f2Ayq60=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jj/7TRRDpEGwZsDhxsipKDMe+h9VaSJvK6d7pzvKH+qm8QAvA4+1vUtqOhQHCjNVG8qB+5h3/JpTNS/wUDExsbbcS2OV1JNEQz/9lXoyV0rrqPJ/A8GYf0DWTc7jWFzv1eZVNslnMcJCZEKUf/HGU9xjy+XMvuyEFRctC24TSCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTtZRaFA; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTtZRaFA"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so2551596a91.3
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 00:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789458683; x=1790063483; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GDUBZD6Fkzuze5OX213usXW7jyZKZ8hUSdP8f2Ayq60=;
        b=gTtZRaFAagKIWYa56NTRiDbCn6IdAJIh7z23z1Gs8H0Ucf4Epzu6tAj9ju7Dcc01w8
         I5DAC0kO9x+SBMsPyPid7cI4ZtEjsx/1XFdYpqJ7OwPliC0WHArxI3STwvBVMtbEYv7u
         f/akAWeFHeGEzZxPdHjQIRiTs0glOcLudVTMp7Tmdqgxate+V2ZiSwj3lYsHEEpO04gC
         wOYnmzQR+lJ87DMBj9IGLZF8/N+SQX5UJEh1KS6x+QAPiOSwTdKSR5P4QfbExFXvf1dx
         GmfjLZABmyXRrgLI8vjYqTbq0bDmgBkVFMHIyqge+ojY2StaIYwwXYKKRLXQpjByGh/z
         1eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789458683; x=1790063483;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GDUBZD6Fkzuze5OX213usXW7jyZKZ8hUSdP8f2Ayq60=;
        b=wT5ba0lX+t499dOtzLawTwy3MD3QqmF5RHR/T83beV/A23bFqbyXkU/MI+JkOdORmT
         lJjD3XmdxMR+w9GjAUrdw+gNmAbFHPjgLi3D6aukuTuXllgscUHN3ZRd5MJ7LN1Yb9zr
         /pYG07S9jaEEdSuY9rYPjNVbVxF7YBxqPxrvrBLzH2srCW8ZGltr8NZVKcu4VTRYSkxV
         iaIDg1Fqv5KiihkT4AcINTKxYAQqnxpCxZMLgaIv3yJe+gklmOtSCvBPuNXzgzG/s5VI
         OymFQFMyv8cnm5Ls9elSpEy21NYkdXC7rq+wmRd7n17rKXjjCSdRZw328sZy6Enk3z8u
         JpYA==
X-Forwarded-Encrypted: i=1; AKwUvBw/iXG4Hw8mZEtCJyJisLWiiO88AkaO6aRy+JhUR6IRTgVwv4/I7O5A3twZW8kQHmWVYg4=@vger.kernel.org
X-Gm-Message-State: AFuF++mRKNupxESoJMjMj7alYZZ/HElCGxB+PwfwV9uuSw3h1fnB6w/l
	KCbOB5WLAkrvBZd1S7R7BhLNELHp7YbaHswHrbtaiuckLpQGqwE4lpDg
X-Gm-Gg: AYBFou3cWiCZyw2EqluDIYBbnCHzj/PLyZrYkmv5JwhS6BV2LBWmaEhR9xGLM18bQYl
	nAj0QsJfkjWc6zIhC6tK/I9dkE9XBNF5U9fqUqCJzl5TuFBoyPZfZ9mPXLbgmjKTGyff92HxkK7
	wiJioYm5qGYyjb1A4u3HI2nnYjc6Oxr6s3TDPQM0F9xyi2jXjZurhQW3wA6GvUI6DX2JcBudZGF
	JFZFaSKK18jjQEMTND12QJYnQh+7Tgn9T0EbZCbp+LO91Ja3UyevMuau0m3uEX7VhJSBPaMelwR
	0/tCn+q5bj0vYG0sohWg02/8OPsar4ykDpKn/7+iCV/M5rXq2Unf1tiLtOdeAWEenu54m/NbES5
	k+i0O+Euw/hMZGWfy7IPymbr3oL0kg2QSlDS237/nQZ5boSO9cQnY3OjGiDv75wY+MwWRBQpkBc
	iCH2viOx0dRA08hH0dpysqfd9pQBlU1QEkSNvLCZzBobnIwYIrFvDLLFHWeubFaQEB3KLctbjP3
	+mBG1GLT4IFSbSlatndEdBaAxU=
X-Received: by 2002:a17:90a:6d97:b0:39d:ec43:df74 with SMTP id 98e67ed59e1d1-39dec43dfbbmr8315851a91.12.1789458683554;
        Tue, 15 Sep 2026 00:51:23 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfd6b9687sm3840555a91.0.2026.09.15.00.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:51:23 -0700 (PDT)
Message-ID: <e82dfcb535313ba346680f8636d25b5f6b199bfc.camel@gmail.com>
Subject: Re: [PATCH bpf v3 0/2] Fix global subprog verification context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Tue, 15 Sep 2026 00:51:20 -0700
In-Reply-To: <DLF2OAEKW80O.1BVYORL67XIKU@gmail.com>
References: <20260914131923.2544250-1-memxor@gmail.com>
	 <DLF2OAEKW80O.1BVYORL67XIKU@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 15:27 +0200, Kumar Kartikeya Dwivedi wrote:
> On Mon Sep 14, 2026 at 3:19 PM CEST, Kumar Kartikeya Dwivedi wrote:
> > Global subprogs can be invoked in both sleepable and non-sleepable
> > contexts, but are verified based on context assumptions for the program
> > type as a whole and not the precise context in which they are invoked.
> > Nicholas identified that this can violate verifier safety assumptions.
> > Verify global subprogs once for each observed sleepability context and =
add
> > workqueue callback regression tests.
> >=20
>=20
> By mistake, I tagged bpf tree for this one, sorry. I can respin again aft=
er a
> round of feedback or let someone else decide to apply it to either tree, =
if this
> version is landable.

It applies and builds cleanly, I'd just land it in bpf.
