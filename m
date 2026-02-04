Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F8E3D9041
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221226; cv=pass; b=doDzVOGKHTXxag99HAMtEFZZ8I3VCx9mBI4cB7FjBUECkOHY6wTo5S3afZ+mTgyJZ7V7NIfbwmY/9nrd7aZbAYarcTgIiPfqgae+b90vRLZZC7NPbuiGommm5FqATAnVucIaDjnHgw/oQXedTrmzVfwD9hZvds8GfHusT6d61YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221226; c=relaxed/simple;
	bh=VFCK34v1D422aldVA5ktiMUDtY/jZRvdezQa8B13quE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boKfH2R9lyw1kum8mpSjcf+BTgAoDYnVNEGR8v71Jf5MGNBDnJ9XH07dTBVTXx11Npru8NAQDpX59US0deTuUkZPyb7ck9Fi4AKRaZZ6uIdH4T10ezpTLqO3lRwUCi9rpr8E7/CLD/hwIWCtfwvsgRWTTLMDS6hKEdfeoiGtHak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFrmsTa+; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFrmsTa+"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fbc305914so29443f8f.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 08:07:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770221224; cv=none;
        d=google.com; s=arc-20240605;
        b=ZbJx2F2loJewQLFVvojRTycYuR7leDOQ8y7QKF6t2DmfBJYmbZVwAGnrNWrOCTNU++
         X+f+hxiAeQVD7kfk0iACbV0vNTZB6iScf5MhP82aTGyJxBXwvwkgKN7rESu/y23q0CZi
         rM/iLj9yyTYGP5Q40kUtwVaDkHqiWJcI18oM94PB4YzSPcejZT/tBebgHINU+9gSDVlk
         o55HUy6lNanq7HljHOLWXCvUyFY2pHiI++9uDhg6DFKbkLDJdlLqJPrQzi4sxxy4goMz
         HpFAuTMSD5MT8Y5jr4yrTns34ACNrbF3zQneEpW5Eoi5a2QBX6mYP+Iqc/xQ5MMhPtCV
         VW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g3KyJo8YATugesAfXcKf+1b+zK4Bs92mhLlJFwblWSM=;
        fh=pmT6OOCiuWPVQKUrqz8+xryBCBwuJe4NNthf+ZRY9dE=;
        b=jdSnmOVC7CCahK0MB1B9M78eYUq02Pdng30f4SZTKgh/OeIC9t4ertPHx33hKcPwdv
         5ahDbPRfGMCLUHpDIsKlSLk9GEucAJSLuOiF9yCxEdIrpn89VLX+/zhVv+8WP4P1F1Jc
         JqLHXC/hSUNuKeq0/DTI8wlkD1EDp+KcIuj7JRnGVwqLyEN2h1Klbd1SQn7y11k7gE+l
         koSDOJJAABU/YiZpOvbOrXAgmaKYk8Qv+637YlH4/at5fz6TwD1vgYOQUwOcsVMg8se5
         HeOdaeJjGi2EJ5mCYMoasA9jRBlG7gVe0gXdksUFr4WhXtleFTJqoTCtIVsXUvlHUlYS
         ZKiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770221224; x=1770826024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3KyJo8YATugesAfXcKf+1b+zK4Bs92mhLlJFwblWSM=;
        b=FFrmsTa+GCl3ztGEusr0qqHOuyzDce+1vvF0milYxsyRGgwUAFS7c1ecuGaRA0ptlI
         /0Xu6xXBNZlQdYXAl4K7XkvWxMPTQOL2y/H0iiANZJlPrOTcdWSufH4lh1F3glA/gHQX
         1nSFKMN2bGYgdH0cWctczjeq+zzytdvM8TqdvuQ1VQEhjzkt1f4lqzao1whcZ7As617f
         Et1Ik3eBF1Ny7XFgF4uJNC/hpomKiRWVxO5KozHZwH1vWBVTCYpbnBuoyuXNRI4G5hoc
         PNpiZV3T3EoqJn3HKqyEAIF/4lByIilzn7smpJwajLOKq5qXFL2DJYds4ulmLGcizC0d
         A4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770221224; x=1770826024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g3KyJo8YATugesAfXcKf+1b+zK4Bs92mhLlJFwblWSM=;
        b=uHWLN/sBWynxmRutogfa+EvCu3ZXJLcURR2T2eUZt5TEYs26KFY58K3uVvbsZQ2pTR
         DNp4uNAsBw7vYi69Yt2PWhqft9YYZBrX9yGkdOxq7j7ZSBqfc2n+W7pAHJqDUTxBDd8B
         PYG7niz03yjqYv9HikaruhXHRjKYPMrqCjgt/knvLShkDUyr7Wx+93jWxWemugnIoLaw
         G91MiT/AlPgW4be4II4hunIgU2Aw3LXduqarfgI6ayQzdLu2JCmWBG8HE8KlTwy33P1F
         tmZjUhvEk0A8qIfKbcXBKEi7zFeqfIr9oqNPasMlpROMYMKJqV3Jn5jIOJn7b2Vmqlat
         Ot6A==
X-Forwarded-Encrypted: i=1; AJvYcCVzyGTNT2cyS9TwsI9D5eZdcMig8PP87Xqn3ILVrOJXtlNavdApbWYVtm/BbpOLjUWj3cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEv7cwGygYjiSpPptiN30VLuOa7xeY6l5xdmVLjr4WZlxUTXCs
	FcSjGkHzBApjkN9KJ/fvs9io0jHqr423Yd6Jlb5++NSMbcT5RCZbM8JY0d8A8ZI60X7Dhco3ygv
	/zqpcNvjvvSOLK5MAdYEQA994/c/LxnI=
X-Gm-Gg: AZuq6aJev24Stx9lS8ELeIqRi/ewYpsl/b3eTFI3JDMJPI/nzFKBQXqfzwu5La+w0yq
	M0z0dO5gjG6ZkH80l8zMFNCbKZvZV7PkBcBTDckJ3EMa9avEX2WqxCUOe1DkJzgGxYnyxZDiUV4
	Y0HjdJOha7LZR7hEMlAXygLF1U2seyM9+MyR+dNVtHzAxrcZ9s4IhFcR/+9X5qs17kJmMJt9gKW
	DUR/g+itZTmuvQHBvaPXD0elHJ0rxNX5JC162Ohc8lwwFeEsc4sRpI/0ED9+w9cUrPognTo8z15
	/25PmpMhw8DY6tD3sH4t0MQGSBRiZxpldR7DB8RLRx2mEkO8chiYVqxHcaKWt2xs80YJWK5+AUx
	JZCDaDxcZs7DF2Q==
X-Received: by 2002:a05:6000:608:b0:436:1516:4faf with SMTP id
 ffacd0b85a97d-43617e30129mr5407282f8f.10.1770221223749; Wed, 04 Feb 2026
 08:07:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>
 <aYM9YUl6xf9I2x4c@krava>
In-Reply-To: <aYM9YUl6xf9I2x4c@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Feb 2026 08:06:50 -0800
X-Gm-Features: AZwV_QiYCIvOKIgNbC9t1KZ1fUnzpyrPVQ58tyi_XhyB3WAfGc73HFZJPGO5tzc
Message-ID: <CAADnVQJPbnVEDYAAy4mUP7NmsGkUmeV9B73V+Bc=LYb8r8Zrow@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/12] bpf: tracing_multi link
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 4:36=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Feb 03, 2026 at 03:17:05PM -0800, Alexei Starovoitov wrote:
> > On Tue, Feb 3, 2026 at 1:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wro=
te:
> > >
> > > hi,
> > > as an option to Meglong's change [1] I'm sending proposal for tracing=
_multi
> > > link that does not add static trampoline but attaches program to all =
needed
> > > trampolines.
> > >
> > > This approach keeps the same performance but has some drawbacks:
> > >
> > >  - when attaching 20k functions we allocate and attach 20k trampoline=
s
> > >  - during attachment we hold each trampoline mutex, so for above
> > >    20k functions we will hold 20k mutexes during the attachment,
> > >    should be very prone to deadlock, but haven't hit it yet
> >
> > If you check that it's sorted and always take them in the same order
> > then there will be no deadlock.
> > Or just grab one global mutex first and then grab trampolines mutexes
> > next in any order. The global one will serialize this attach operation.
> >
> > > It looks the trampoline allocations/generation might not be big a pro=
blem
> > > and I'll try to find a solution for holding that many mutexes. If the=
re's
> > > no better solution I think having one read/write mutex for tracing mu=
lti
> > > link attach/detach should work.
> >
> > If you mean to have one global mutex as I proposed above then I don't s=
ee
> > a downside. It only serializes multiple libbpf calls.
>
> we also need to serialize it with standard single trampoline attach,
> because the direct ftrace update is now done under trampoline->mutex:
>
>   bpf_trampoline_link_prog(tr)
>   {
>     mutex_lock(&tr->mutex);
>     ...
>     update_ftrace_direct_*
>     ...
>     mutex_unlock(&tr->mutex);
>   }
>
> for tracing_multi we would link the program first (with tr->mutex)
> and do the bulk ftrace update later (without tr->mutex)
>
>   {
>     for each involved trampoline:
>       bpf_trampoline_link_prog
>
>     --> and here we could race with some other thread doing single
>         trampoline attach
>
>     update_ftrace_direct_*
>   }
>
> note the current version locks all tr->mutex instances all the way
> through the update_ftrace_direct_* update
>
> I think we could use global rwsem and take read lock on single
> trampoline attach path and write lock on tracing_multi attach,
>
> I thought we could take direct_mutex early, but that would mean
> different order with trampoline mutex than we already have in
> single attach path

I feel we're talking past each other.
I meant:

For multi:
1. take some global mutex
2. take N tramp mutexes in any order

For single:
1. take that 1 specific tramp mutex.
