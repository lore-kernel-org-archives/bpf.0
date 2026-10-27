Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793122223;
	b=2JdXL2BGKGCeIoqRhrjGggPlwXdRw6jAHw0Yk1j1OugH/28y6kFvW6s5MmhpbPBgN5M0
	 VhIdDvzwlb/GLhQ6O8RKG+jyqgU3kI4Kmskz5j8tvSY75kobb6rNuyx/PW1iA3Kkhpz4Z
	 WRCG07Ah9D/zNq2HtweLSQ9kFh7PwHCdo9+P6uFj5XbFRnIx5HSK/o6OI1ma5i6uy4VF6
	 hwKZOoTiqkQ5wEjmXA81QuffRIzX4Wv00Y1JS6YKpA73GtrN0J2f0tfgZd/ymy0scxWTK
	 jF/iFnBGEls/5CxT0toS4xE2jI1YOyjMeCQFI5VraO2957ecZxc+pIDQNIOz2MqxMLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7gQ+97vReKa4toS9130cb0MEUCUe5fofr2ehSKz/dNw=;
	b=0sJ5ikGZUjR4mHIO8/KtvcoVH2VL3u9GOe0+79LcABFYEW4TCzAuiB2JQnn5zXJ9WsBv
	 zvgA5Kb0DldpNqtgjEY1mz3kWxEtmwUi4nqXPOdEhzGxEwuz8oHMUm5S84e6E6rwe3o8l
	 axGO1lxHUw5GEjudL4tEs3VE4qD9gFwStVNnaUbxg/mkVCeWwxw6GI4zmj8D8slUd1FC+
	 3mGlmFby0sYBoZXwIR5S1pxPHybngddZgkJbr7CNsiw69pvso1PNLhSBDgMMT9OI+WOYg
	 Op8CmpAJTsfuGshqwmfWC6d7YpRlWuJfaT0L4qxbs+H2mgC5eUupUiy8jP7/4oF1W7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AH5XVSYu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84906606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84906606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AH5XVSYu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c34bff61551so8948766b.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 10:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793122222; cv=none;
        d=google.com; s=arc-20260327;
        b=VoltTHOylIkgD26TK3m+dmn1/CyhNobqTc4zwxqoSdSV0LDl9JLurKx3vV/cE1XGUj
         vMFJAqO1pFkpP/0pw6pgh+d/wK44b+vspgkzVaMGrS+oFSmQ/YGePgcfuM8f5tp/fkEG
         C3GqntMC8/ilvlHbhHvak4BfMCfZK8GcjeSK2Hc2emvddoP9O7udn2cIXhzlecEMlRx9
         UcxWHPR/FOb7glaViqcS3e5LQpwCOwe79VApDrtZoDIjoSxgRVjwPDwLBIiTBMF38d4P
         kRbEZA+1BAudOodoOl79fxWaRtR1hC9DYmez1Y/oNrfz8oVcUBLDUcoVURUTqvwXbE1d
         mHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7gQ+97vReKa4toS9130cb0MEUCUe5fofr2ehSKz/dNw=;
        fh=4UXuEFK78E3+OCAS3ABlUfBUtZUCcBelDTFxYnMu7J0=;
        b=JzMUtVtzMGlLepiNy5wG0ZHkmzoP7Nk2xm1aijYA/AUswqQOz8O+DT8wZ6MsFCMwKS
         UxsL4eRtNdT0osZXsArmArCRBvIWTN6skEP9XOixaaqjC8EJeVIxpGbOv2fC5lON1uNe
         SaJiW6u01Fbj5ZVzKVDaRWly4bqH9a7FpZyeASmO6T7Jg7xtkhq/hnzWhCGhCu0HVlkm
         xaYU7KspJkPIAZdReAIivseQU11qyDH7rkiTZj07bKPFHRQUcPSALuUPYppTnfjiSqE0
         iz8/0AaVbfuFMBTfbk/YvHDfvr0ZBCFjVMGIGFvtM2DNhNZRYGx0vcg+N9B+dkIQvxon
         963g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122222; x=1793727022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7gQ+97vReKa4toS9130cb0MEUCUe5fofr2ehSKz/dNw=;
        b=AH5XVSYuq6HUx6QejcrLzJHXiZbWI9DboIxOz+yByNgh84gxZAIKBuzZHV99EG6rqB
         sL71z4Wm6MSPA3Nnza0i731ilrImuFj3jUTow6hkS/0r7bYzxQobbOzdeIyt6ASGeEbF
         yTa0PHt944q+HSgG6NrCVe3wZJYFAVwhpzaLqX011nHEVLqO4I7UJy1zd5cfMTXQHdaA
         BSUKBBxl7R08MamwKyO7Ss8mI2wGFLi7Y2RxS2XZ75lMQCOMaDZ6YNjy/Um35SI/BQEx
         H9A/IMXo16KCWMivgQdBOKUL0g+UWglSQzebhEs3U4Ckl7bH2Y72gGHNDHSXACje/sxH
         22yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122222; x=1793727022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7gQ+97vReKa4toS9130cb0MEUCUe5fofr2ehSKz/dNw=;
        b=PKe0TAd3D1hMsZQ/auM/IPBVneIMZCYF4NTTZbeAnhlCvQPsi9eJb1/9VqvaOdK6P+
         E4sGEz9vW536nz1jQJgEgDka6/w8+IJkR18P0F1To8Z7iiQk0NBOO5m7n+2G3rAjLCTm
         ku0Un2ltCTWXS964UkS9PuJKwGLDgUjiOjd4N1jXz+7IUk3cRtHO9sfb8phWJANC5uSu
         HphKPcfDsGfkUQt8nGaWkXBixtZBxNGOvRpWppcM+1ONGW6osLA2J6zXESjw3Z7ZubLI
         FXuJyb1NOA13aCYLnPiRFVMzzamtdFPJXaN+k4Wvbj9S8eNLIBB6TrpqnOopSoQoncO1
         ODOA==
X-Forwarded-Encrypted: i=1; AKwUvBwTDV6SN9Cbw5Rt5N7sIfyRkFCctAQf92W5zveReWKW4Emj+mzz7KPE0Do/jZYuVxxZXTE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzQao2N5Ie7Ead57NpoF2oQi5ble4RDXl60oyP6yezMM6tkJS8
	IpOlMO+WVCE6MRNRQODj6DZBh/RlKJ/rHl5D+i3P4vtOTsCt+IdmP5apxMY5NBL04T1TqyIbU0E
	8pkdtIK07UWOES2fqq7lz6kCv+ettUXaK/WWRIh+v
X-Gm-Gg: AYBFou0FAbsfy2PQqa4+q/Uq9nn+bItulWvC4DSfU6VbD5agpKyQg+o/D6zAQoZ4Tnu
	cRZnrmL+DGhd50JGcgF8WX+vs8oeOKgTMuVdbrM0MR0QEGMo1+DS/mX8t0biq1wHd4NDlKWKYVA
	FrkKd3XcRH3WDHVAik3e6mfh3a0gnz6Ak+HLgDqzlTs2p3Uo1Msg8N3des4/SWaYvBVI2eyzmQQ
	I7fyjuzDUxqUUDptnFUCw5DYPZ8e3zS/6Rz84V4h5NOroXrCS6DhD3CsncYdOQQPoLo30kDFu+w
	F3TGNCwHK0OgiddVod1XNNtOYSbn54roIktoHI6/tZ4lpfjg1WT8uyeiCbcookcx3sd9xE3dZZA
	vABQfYsZ5tt6hg3P22WYJr4nsi3POqz102enUERByZdWuNJOu0PS6W+GSwS7xKSgrtP5mgB/DIs
	QCMXTIddQRaLi6sSQOxwvWex6qHgM8op/Di7njaWhy+pDEQtO5jT8is61LGmmNf02s+E08UJQYW
	VgYSwEnVz/WO/uF7nusf9Fk4TwgQ63vVg==
X-Received: by 2002:a17:907:80c:b0:c46:6a50:40c2 with SMTP id
 a640c23a62f3a-c46bdee2675mr1178260566b.39.1793122221137; Tue, 27 Oct 2026
 10:30:21 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com> <14f5f919-55bd-47c6-a1c8-6f1445cce733@app.fastmail.com>
In-Reply-To: <14f5f919-55bd-47c6-a1c8-6f1445cce733@app.fastmail.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 10:29:43 -0700
X-Gm-Features: AclHuK_V7ZmMdE83iy-wOvaliSqHMUcbKVcnfqQwnRgRgjPYRFDHKTZOMwXOk5E
Message-ID: <CADrL8HXQdzcroeGN-ACjyy-jSAdBNHiT1_BCVVe0P+Y8ZueiyA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] uaccess: Refuse and warn on user accesses when
 current->mm is NULL
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Oct 26, 2026, at 22:52, James Houghton wrote:
> >
> > This series comes out of a set of bugs that were found in KVM where the
> > kernel can sometimes write to a random process's user memory[1]. The KV=
M
> > fixes at [1] are still required, even with this uaccess series, as note=
d
> > by Sean here[2] and below in this cover letter. The beginning of this
> > series includes fixes for similar bugs found through static analysis
> > with Claude Opus 5.5. I don't think any of these bugs are more severe
> > than the KVM bugs[1].
> >
> > We hit one of the KVM bugs in production, and it was challenging to
> > debug. This series makes such bugs, where the kernel is doing uaccess
> > without an mm, much more obvious.
>
> Nice work!

Thanks!

> > Such an access does not reliably fail. The user portion of the address
> > space belongs to whatever mm happens to be lazily loaded, if any. If
> > the access faults, the fault handler refuses to handle it and the copy
> > fails, but if the page is already mapped, the access silently reads or
> > writes another task's memory.
>
> This sounds like the problem depends a lot on the architecture,
> and to what degree they implement lazy mm switching. If an architecture
> makes all user pointers invalid for a kernel thread, this does not
> actually happen, right?
>
> E.g. on arm64 with CONFIG_ARM64_SW_TTBR0_PAN, the page table base for
> the current process is only set in user_access_begin() and would
> not point to any task here. Without ttbr0_pan, it should be
> covered by cpu_set_reserved_ttbr0() turning off all user space access
> for kernel threads.
>
> Should this perhaps be addressed in architecture specific code
> instead of in a common place?

You're right that whether corruption can actually occur depends on the
architecture and config. I'll write a note about this in the v2 cover
letter.

That being said, I still think the right thing to do is to have the
new check(s) in common code. Instances of improper uaccesses are still
bugs, even if no corruption occurs.

> > =3D=3D The New WARN =3D=3D
> >
> > The rest of the series makes the generic uaccess helpers WARN_ON_ONCE()
> > and refuse the access when current->mm is NULL:
> >
> >  - Patch 6 adds uaccess_should_fail(), which combines the existing
> >    should_fail_usercopy() fault injection check with the NULL mm check,
> >    and uses it in place of should_fail_usercopy(). This covers
> >    copy_{to,from}_user() on all architectures (including the masked
> >    user access paths, which never call access_ok()), the
> >    __copy_{to,from}_user() variants used by KVM's guest memory
> >    accessors, the user-backed iov_iter copy routines and
> >    strncpy_from_user().
> ...
> > The checks are deliberately limited to generic code. Accesses
> > implemented entirely by architectures (get_user(), put_user(),
> > clear_user(), and direct users of user_access_begin() or
> > masked_user_access_begin()) are not covered. Please let me know if the
> > new check should be placed elsewhere.
>
> I would think that user_access_begin() is a more natural place
> for the added checks, as this should be called exactly once for
> any function that accesses user space and also stays out of the
> way of the copy_from_kernel_nofault() etc.

user_access_begin() isn't used in a lot of places that I want to
catch, including the KVM case. Roughly:

  kvm_write_guest_cached() --> __copy_to_user() --> raw_copy_to_user()

There's no user_access_begin() in there. :/

I do think user_access_begin() should have the new check though, so
I've added it in the v2.

Thanks for the feedback, Arnd. :)
