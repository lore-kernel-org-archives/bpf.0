Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538094;
	b=ZF4ufFo3gd2UspGyrzmH0qGuMtgSnYlJGp/wgebN5kGf0Ath1Btyn8nF/l5YQ4wKmPBv
	 6lL10EKTiBFt+uMYcrO77JjuIOVWEUiFkbAC5OxgiC+kSZRYJQefDiO6u2X7aaHe6FjI4
	 fXvyOopLHxRcXbZdKGGLOSdNpMg7s32Y8y3Cx4k03lDM2eWv9zrOOCDEglz2tron6sCAU
	 gFGJIQzQLghttELN3mjRTuvVziIjKT8H6Ziq9zMvgga8m+PH5VSWPuY6dSk/28biWuZt5
	 VpNDcdM/7Yl1Rc3ESDcOXDDf6QhqkcY5AtSz366ZrGl2N19Lc9I4zxiTj3fOHummd+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Kl1lMLuqhZH+LLqHtJT6QI0oIm+dpJplZfZi0YBu//s=;
	b=OjE/SgrXfhSfgKVZsl2Eq0wTPEQy9Zv5kJi/hB0oHoeBMm7jkBCuI+DN7aJZOYU9RKB2
	 m7vYIifWu0MH+6aZBvs1c5yrIIIYDubqXa9SMWrLm8vFxYp5Zi+9DGIusAWMtDkniAfOi
	 034/GFtsV0FLXu+ER3T+kxVcT7yQ8MOyZ/1nxSCqdwagyFZLXar3INCBYBGyNFlbJy+vz
	 JjqRmyLe5H4DSzCJ4S3DEIjO+4B23yt6ojujJtD0SigRF0TT4ZlzOY26o3w3iwz1OhrJ5
	 pcyds53sUxnlGXNqllLw8NIHpmfeQ57oVaYcUsZ91icZgJuyaGubzaTPJrWizHtDsGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TTfD3o0B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091B606A323
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 16:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F091B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TTfD3o0B
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533202fe429so948411cf.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 08:34:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795538093; cv=none;
        d=google.com; s=arc-20260327;
        b=MvOxtDG/Hyh6jfLyVQEETiY5YeMwz3taRAjPkwk3qOzAk1ADrCxybDAa76Mr3J6NVH
         RbC1ntZxt6Rwn+1Luho8s2Nz0waXnkNO2+XozJ7xAF0EfvzxXDMO542ysRunAVjF4HnQ
         X1HwSGGfXEWxBBiCjojyKjtNTcb89cTjt19Dh2b9R6Aqjnwh5CmYrMvSbA/QkIgzUUqu
         picp6pX9xTX/6Yj+2ADZf1psiIOBq8ZgB8px2/1Cu6rqOOZeB6L9+tXGClV3Vh8gH1YY
         E3SFtPhpILfSSQNp7QEeriEZXznVEw7Bfx/KHRSXS0oiA2A+9WcbO7A38cLHYR1WmiaX
         lMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kl1lMLuqhZH+LLqHtJT6QI0oIm+dpJplZfZi0YBu//s=;
        fh=Zvr3pbt75tb+eAsq09QFBaRCSsAqZnbSLLzWt8RRUio=;
        b=SMU7SiNJyqcagDT7ZX2IWA9BpYQD8Xchev2Fnyoyh4RrLmFztv5zeLLXAyi1Lg7604
         1nggyugSLraf/IeVDsTUli6vqcTuW0MI5nUlvpjx5Z8M5hfxW+A0+0wLh9AesXO0QHtz
         C8ptxe5qxzE43gu252oEOTyPq8txBjP24PzMRc/zeRmBvTA1RsInE6OGDBKUl4nFuK9t
         90zSRltiWft48mXfYZV5ZjDgS5hE0enszKF9Y7a18nqmXioxXikhGNL9nn2cvLto8JJY
         WiBTFP9KgPrXkwYC2q90s2wrlWueq+ay+0MA+j3I6xt/Qbp/kBzl2SbPbRaDIrIilqbL
         0PRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795538093; x=1796142893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kl1lMLuqhZH+LLqHtJT6QI0oIm+dpJplZfZi0YBu//s=;
        b=TTfD3o0BLhOt6X12nwfcIRGVYb9Tg6G0UpEGPt06nCVhs3EsfF9sZRAiyiYtMmlDXs
         va/lM5ylYAkLE9JrjT9aBh8u9um5C/Aiabv/RVXBEvh4Ry6uz+n/mZKLchIW0wUwUKJf
         S9lnaf8ctnqeRyWRpCOysIX/jW/XAWDNMPOVjhTASxwjsn2JDkamO6yA+In3FFPD3s4t
         z8mybQii4457OpqE1phzL3POgdHqbEuIgmYlDo3X5wbXm4mzhtOQCV3r3AeXrvd8P0Dp
         +jkirTLgTpgytyL9hge009KHT5Sd3nlecoLqnplQ4NsT9QWnl5SZEi4TZ3KbNaYdUqX5
         GJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538093; x=1796142893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kl1lMLuqhZH+LLqHtJT6QI0oIm+dpJplZfZi0YBu//s=;
        b=2ZXVQSQpKKFFTuuGqIhOAmlOAeIc8TnskUrzkXjbiDLr1H/EyCL+MYms9EpIz7o4FT
         Mdpo2Q2rJiM0YeVoYOwiS+At9Zg5FhwwFU+BjlwbuZVBeDthE1e6NhM4H+AGbIMSzCPg
         +W6I3kcos8wPfxYgEEfJfo9k7PpdDq0sCEj5eQsK10mhOkDzcjoCtgOIPiXTQM2suYbH
         oMnHzhJCP0GEKp8K3Pl/npxVaa9AFSvzKNLSyEttv2+ogMAdojp+kbt20qM6ttIQ2gUi
         vcPquFWgbdBqSSvJg5d723rbIMvkeTr2sAO+znUuTxA9aX+Wttw6gELLslgmc+zrE7jI
         mswg==
X-Forwarded-Encrypted: i=1; AL+hErGwaBzlg1JLm38Ca9t63Pc2V9AN06FJEa7tCFUngo3SkdKxmYNjk0esYI5PJrQVCJYtp0I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8onhA09WkkgQuO3qOoVfdF+7DZIWzP7KEsz+Eldg8SupThenbZ
	mWroxabYMSYa5u/gJzUEoMqd/qjsqYnjiiHgrNT/Cyjc8wKCUlwGCKy3s4Y1/2HvxdNhcGDZCR7
	bJsu8LkPFeGlVjUsnmdYJbfm49XFi2mIc7SvP0Ast
X-Gm-Gg: AZFdTZclan9i51ob/kb9wGKomQFoxupVTXJdsSluxOT6QNKOJrhGE/v/OaShq80ClMI
	7AshFfxfIZHGG+aKbToDT92UZ1Da4Hb5dPpPgfQVlJxmJdzvpvyKFaSXl3ASutR07J3YNIz4ykP
	nnGmUEEdwKVl4hnE4VqWenfIt63/LBjSFZoyzeaxfVzif3P+iMePthX+WPesByJF5ZiZIOvkxep
	OgkmtRnXZhLOmt8ajGfzZ8Jny1SZNnqMI6R2K1ajUj8jQGOl+BoIOVH3StMRFAqe9uSBSE/85vs
	t/kvWCbtdkJ2RKj2Lsfi1DIOc/NoEkefKqCSO/Gok3KTYR45/xluvjyyJN4iEbomM8payLzN/lY
	bXK/z7DUUjBampLc0ikQ7BNma5qDq/8deo+n2xG4dt9lp2zkvx1/KswVVR6EQGvB5T9ahkolZ2Z
	7IlWipy+V9w+4kga61NnKKgkus0H8=
X-Received: by 2002:a05:622a:5c13:b0:535:30a:76c7 with SMTP id
 d75a77b69052e-55d88102d7dmr59797711cf.3.1795538092021; Tue, 24 Nov 2026
 08:34:52 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
 <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net> <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
 <CAJuCfpEd1rz3P7fB7W_mHkyzbpq9TscRE+QNwvHdYME=WJj6cw@mail.gmail.com>
 <awWz3nc_b8x3mIXq@gremlin> <CANk7y0gAxY18Ew+6j5YsqrOsf5Dx+v5M78r7_8JLXh5RHZj4qA@mail.gmail.com>
In-Reply-To: <CANk7y0gAxY18Ew+6j5YsqrOsf5Dx+v5M78r7_8JLXh5RHZj4qA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Nov 2026 08:34:40 -0800
X-Gm-Features: Aa3M54psUndAWw1N5lTEQVLz0Ca1-n1kspbSD8lWK-ihjsexo1mFnquPILpy9Cs
Message-ID: <CAJuCfpFuDCUPTUi3SuAhmbtw5tubRZ0+YEY3PotjyJ8Or8pdQQ@mail.gmail.com>
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Pedro Falcato <pfalcato@suse.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 8:06=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Tue, Nov 24, 2026 at 9:28=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel=
.org> wrote:
> >
> > On Tue, Nov 24, 2026 at 07:51:42AM -0800, Suren Baghdasaryan wrote:
> > > Actually, VMAs are allocated from a SLAB_TYPESAFE_BY_RCU slub. With
> > > that RCU unlocking move you don't need other_mm copy and the comment
> > > that comes with it. VMA won't be freed until RCU lock is dropped.
> >
> > Yeah but they can be reassigned? They won't be _freed_ until a grace pe=
riod but
> > they can go back to the slab and then allocated elsewhere  right?
> >
>
> Yes, they can go back to the slab and become a different VMA.

Yeah, you are right about that. So, we either have to keep the RCU
unlock in place to keep other_mm comment valid (my personal
preference) or update the comment next to other_mm to explain the new
reason it is needed. Either way is fine with me.
