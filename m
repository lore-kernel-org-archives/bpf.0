Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795542569;
	b=elMlCyHICXI9c7J6U8mDZivr2NJTf4Qpj8ROFotZDlIksZ7sjiauQKSk5GZXVMs9fyjO
	 UJN0MypOc+EEJ6mqsFZjRJK+UaCtlXHl3IMlcbGudwMiQl7YXK+wymcmRnP+yrzbWqJWk
	 IA+N44PPzfNdrSrJSaK6EwfGHm1e29PS4bpMFX20HR2H9zjPu/hwJkoPh/c5PPinKMYmE
	 xydYAcOJ6HEMLFQ/DbvyzVULm8Sj0bjcvCDnKxIGnk2KXwlCfFJgLbBTf2SON9wFxhy6T
	 QvPb0lSU5s3DN5PFdpVyVpcJPC39PgqMZ2KAAqH8D10+pIKaH0CAGsKGKzh2ZE5TjjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rZpsKsMasCu0VG55k4IFjBDsARDNBPmeWnpoFmnC3rQ=;
	b=L9YtdM+Llo8r9HDHvJ5KhphQqeh1VI7XRIiiQZLV0oAJlODAXzeXd2n8S88yyCZ8Kwk6
	 P5HXWJCdsCaICDoE3dx9FyjSLwCOSxspX7yA8vJTA0BOiKXRJUN/2hltsLwdy2jG+BqPA
	 LGtkRC2fpIUBU1wEBGT7b8/HvYAB2NWduhaFAHTpCMxMqGcmqMwyCWk9pyh3EHIVDfUTs
	 77LD6tVoYvVNA9wrfiX27Opc8f8YpK0diNfUS6LhnCxnktTFp8oftD4U2MzRFueXMrdHh
	 GYsBkKWfD+mGpNV4e/y08HtcXcNfqgsBDTFU7uv9XjLJrL4G/DaRNgprWj8ufzG92pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e7UYrUF4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C06606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17C06606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e7UYrUF4
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-533202fe429so983121cf.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:49:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795542567; cv=none;
        d=google.com; s=arc-20260327;
        b=Ddh+/82rnV8zGqgr/71lpXsr5OYtLbwDXO18b04k6UXG2XAyPJPohbC2T+yrMTTysC
         TiEWxehDLtENFiL/w0Z2CN7/eaylHAs//4OOfLDsWGp4MHB3AJxpoCitiuhrpBnWfjQP
         ztQ/KV6nthw7qdS9bs+Y4W5TaVYlpmjLIq0Bl59Bk9fTTnDJtfmy6r8luHhY6cEKL1BD
         7P55bgKRegrvdaUZbCo1fFBWX54ImMeuJ0gn+Nwr23ysgLpKVDWI4KvB7QzArFhK/B2d
         EobwKhh7lyKlJrkVQT4IcjHkoafIDyWDuNWS8PDasLJsNCKd8C5IqwHVR2tlbwDgVS2Y
         aHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZpsKsMasCu0VG55k4IFjBDsARDNBPmeWnpoFmnC3rQ=;
        fh=dTPXIyzbB3BK+8S0OGzIg9RXIlfe7Z/OZMJQ4L0Z9BE=;
        b=S9/X7+vxvvAjMjVqm6GEPF19rcdQWUklScWlimBviGQJwgq6EFZC7mY9Nkd/MFOqZe
         OW2ZeN6qPzgaRdNQbx1eftv0fFn5NmCNMq4vcajI7fuOSGH7skpp/uWy4ppTi7HCkhOf
         /7EIdTKZSIUEa8Q3Y31dltQsVR9YoadeY2/ZVdEtVlqcoP7g9Au1IzMNrCrwgoZ0YzD0
         cqUHxXO87XEzsR1+IssMsqi5MccLO255GlDkHUZiJfQpvzSw/OuQako8tTPMArRKsGl9
         cWdArWRj+iWJGIKO2ELthBXzfwWVNH0hQI0sQYNv+aSrPtnAjjHQ/eo5AgSoiwOi6Q7f
         rIzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795542567; x=1796147367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rZpsKsMasCu0VG55k4IFjBDsARDNBPmeWnpoFmnC3rQ=;
        b=e7UYrUF4nKBxaC4jgXXgDe3ZHrbdY4HWtnith9cwWZ5pPz2rLq2vrIC1LAn7Bqtsn+
         qRPXxsQL6IUeSY4EqKzAPkao+gInkgCliPsaW6eapl7cul2FUcBTg/EkOYIKRYDSj4P6
         M0w2/jLe0ObjVWu9Vp569S59fawsJ6IhiF+k1yRM1qhp6QRb1EGhBuNgrjdYc4IJ3nys
         n30s4RRkTEzz0BLshm2yaYf9HGiI12deEVOMMk/qcTkCr6vxyvy+ajm/2kcPSMgGpiAz
         x9uFRLvarokBWXFGSJ6NWWFAY57w03jxyEo90ZmKtqp+G1R9VhLof92MbJKOi4LuM17q
         lN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542567; x=1796147367;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZpsKsMasCu0VG55k4IFjBDsARDNBPmeWnpoFmnC3rQ=;
        b=mBDYqrwYnXrCDo7G5iL3YPXn1eix6fVlSYjY0qX+RuFBkbRJN/swpqpYrFDIBvMLmY
         LwsQPNcPnYgDlrmV5vK9nG1iBkRdlZztYY4ZWSYiUOdut3DXeyx0DfUSGH5egNlkY11R
         hK/IK9EkEUwZjN4h35mta6Lvbz46eSVlkSl5tin55DCFIW0hXY5v2jTNOOrzGCBeIWms
         EoURXw5UNFjLEmACfv1jNKpk1CpKgRY30WJ92kHHWT559kT6PGOSVItcnc+HwsjFr9PT
         9D0n+IQTRzi62p2lSypzdEF3y7XxfHY+f+sZkri1XK5nfX/mmiCKqFRg7OROLuwwcoW7
         BA9Q==
X-Forwarded-Encrypted: i=1; AL+hErHA2rmOEfE5+s3ucx3Xcotcn0sn0IXEJ5lYTe0pq4n0zPv5nSf0eSgBmCD4eYnIcN074Gw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+X+0CLh7YAq4ban4A5+kqCW927/wtZfteaGC457u3naXSYFBwE
	ddmg82BXNXAgB4ZSMDUCzqwgjryE2M26iEoE6VmQJ79eBQa6YkT2u1VJRiHkON4Org1uSPgxUul
	2aeEdbLtFtP+CUWlUp8Kd8n760TM+jN6hRV5vltEa8LJIw+2wyeY6xJLtHHY=
X-Gm-Gg: AZFdTZeLbo5lJngiyq5yYRo2X+7jHDgMMm3xtCpfn5rex0n03SoYHMgvoOWHEqMuuJV
	M5DdMalUYTmvKxtOkJJNAkooJi6AC4o7yclvzai+URdPB7dCKhDUjJ2ev9Z5kfC2izEHxqQDOg9
	KJ2eeNwqkleZ4PfUgQ6KOF/fhMiBt4tiAbLDRD40Be0t7tbhaiHh0LY4yu2YQrxGWKRZjAKq8FX
	m8AsxvoL9mvdyMnyAi7WplhgQmMpWnXEWfK9Md/yQ5UzfrNcpvhlNw3xl1V9m4EKQhfixXHEh3i
	svH2teMnVXiUNKGMSPwWSmJNHKopy0nlyXXem61Bz01haBRb+Jv5nwrJqCDJDbtIaGeOsaGyUQ3
	05epEn3gkMiawoYhzL18alux11PilsHfmpXkpb/Gwjps5TBmS1Qqm5D5a225JrrWDZMv11buOSV
	Gw4suglQcfTqsl+7o9GKY+O0k0ha6/wHg3gEoDSBT/9+uPOxeB
X-Received: by 2002:a05:622a:1f14:b0:545:7949:80a5 with SMTP id
 d75a77b69052e-55d890663bamr62644371cf.12.1795542566115; Tue, 24 Nov 2026
 09:49:26 -0800 (PST)
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
 <CAJuCfpFuDCUPTUi3SuAhmbtw5tubRZ0+YEY3PotjyJ8Or8pdQQ@mail.gmail.com>
 <awXHR007d8MlhJUC@gremlin> <20261124093328.3ba2e066e5d5081c69e0e667@linux-foundation.org>
In-Reply-To: <20261124093328.3ba2e066e5d5081c69e0e667@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Nov 2026 09:49:13 -0800
X-Gm-Features: Aa3M54rJtgRgH_rcKNgpafDHAbKng8SpV3uhoRslOvIjTwkRWkSfaO8JY91K7G8
Message-ID: <CAJuCfpEmFEX5iqLw_c94a97rVrC+xBWpKnO4rVpeDgkUfAPq7Q@mail.gmail.com>
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Pedro Falcato <pfalcato@suse.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 9:33=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 24 Nov 2026 17:23:35 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.or=
g> wrote:
>
> > On Tue, Nov 24, 2026 at 08:34:40AM -0800, Suren Baghdasaryan wrote:
> > > On Tue, Nov 24, 2026 at 8:06=E2=80=AFAM Puranjay Mohan <puranjay12@gm=
ail.com> wrote:
> > > >
> > > > On Tue, Nov 24, 2026 at 9:28=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@=
kernel.org> wrote:
> > > > >
> > > > > On Tue, Nov 24, 2026 at 07:51:42AM -0800, Suren Baghdasaryan wrot=
e:
> > > > > > Actually, VMAs are allocated from a SLAB_TYPESAFE_BY_RCU slub. =
With
> > > > > > that RCU unlocking move you don't need other_mm copy and the co=
mment
> > > > > > that comes with it. VMA won't be freed until RCU lock is droppe=
d.
> > > > >
> > > > > Yeah but they can be reassigned? They won't be _freed_ until a gr=
ace period but
> > > > > they can go back to the slab and then allocated elsewhere  right?
> > > > >
> > > >
> > > > Yes, they can go back to the slab and become a different VMA.
> > >
> > > Yeah, you are right about that. So, we either have to keep the RCU
> > > unlock in place to keep other_mm comment valid (my personal
> > > preference) or update the comment next to other_mm to explain the new
> > > reason it is needed. Either way is fine with me.
> >
> > I think let's just change the comment?
> >
> > Andrew could you change:
> >
> >        * stable and can be freed in the narrow window after vma->vm_ref=
cnt
> >
> > ->
> >
> >        * stable and can be reused in the narrow window after vma->vm_re=
fcnt
> >                            ^
> >                            |
> >                            just this freed -> reused :)
> >
>
> np.
>
> --- a/mm/mmap_lock.c~mm-vma-drop-mm-asynchronously-in-vma_start_read-fix
> +++ a/mm/mmap_lock.c
> @@ -300,7 +300,7 @@ err:
>  err_unstable:
>         /*
>          * If vma got attached to another mm from under us, that mm is no=
t
> -        * stable and can be freed in the narrow window after vma->vm_ref=
cnt
> +        * stable and can be reused in the narrow window after vma->vm_re=
fcnt
>          * is dropped and before rcuwait_wake_up(mm) is called. Grab it b=
efore
>          * releasing vma->vm_refcnt.
>          */

Sorry for being pedantic :)
There is also this comment later on:

        other_mm =3D vma->vm_mm; /* use a copy as vma can be freed after
we drop vm_refcnt */

That should be replaced too with:

        other_mm =3D vma->vm_mm; /* use a copy as vma can be reused
after we drop vm_refcnt */

Again, just replacing "freed" to "reused".
Thanks!

> _
>
