Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B44014B8
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540676; cv=pass; b=WZmw7Y/UmhPcZ1DVsmtbrWnuTep8UDMHtwmRR/j+eM1uot3UuTa4PbOPcWbzPQbEmbK2OGWLqC9RWckSx9SkvlJ1iT+sM3BKEB4DMPJYKWKbCb1mm12m2qd62udmrYxgYHBXDnomqGfkb31HtNEWmIuPDUgHkozJMWCHYbDvGhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540676; c=relaxed/simple;
	bh=Efhur1PwShVcD/aN0lMTGKUH7QN80Ncns8BdFf1uL6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpGXyy4FCZtAmPJOmk6/bCAxDeN0V92BaXjo2pGrgFj3txhgGMfthRJJv93IbYZLDZSB8tN+p2DQSUt3j3fOYEgzheUyoaIhvTloxfcpuV+GV5RUcWFGX3wQpU80Bw10LdWk61OfFfQzLBa0UcDYRJ7XtPpB/JQwY26Fmqs/tQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qfWQ49D8; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfWQ49D8"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66abcbae8a2so990363a12.3
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 08:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774540673; cv=none;
        d=google.com; s=arc-20240605;
        b=aDqZDxylLOYRrYcgIz2fLBEeO4wtZ+a9YcyhhEA4lo+cSY5x1IawUxMApnDS35394S
         s5KRPQG190bdYSimnf0MZbSGUk26grsDQtpgUcZ2U8TSI1WWUlg67h7eyIMz2WaD6NSd
         dvOV6oq2OfSqJ70LMOTkpx4caszlKAGTJhl7i5xc81Po5CZ5Y0n099wE97MFB+tRDGjX
         f1BP5jCIgFCN6vYSLkZO+4JdFZ9WgF4rJvrKTlhlc4R8YAM0cgrGaQ5U9mkSHmaO/K4I
         H0WNQlOvMehkpiEgAu0QD3IeViPBr0a819nQYxez7nt8pNkLLaFllUOm76jMwD0+LPWs
         dsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FBRCtRKDJQZI+rc1isgeuA8oOX6FoZCivZKEfZOwGac=;
        fh=RZ1rmZsavDUtZTnQfqdRL3/KI32yiiVtN64kO9/i8G4=;
        b=lX8IjoQJrSqJXuCLkFIxqKnj80wYjKkCaIW58LRD+FqczjKS2jcL6anCFTu1iHxLyv
         tebtEWpWXUOQBCVYxuUYTMVzekqRLRHzdUqsldE3ZWeWy1bAZzYX7Fi50006S1RPXuEB
         4pyVCZyaaZTfJUZ/j8LL0+FvT9ODjljFI39KAyJxc2OlUNJ+wJuL9UViY9BsSrnY+eC2
         m3qe9D5FR2fBEJXAVXBWj4audclYQOo1yXqbyeGwuRdPKMTay6taRNPDWfJ7n1F5LNht
         mus9OTTAYtK9LFYT+OEMRD69Z7GC8qxcnwctr2mV0DBpmxUoy4ZD0avpHbE+RPTwdvNk
         Tcmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774540673; x=1775145473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBRCtRKDJQZI+rc1isgeuA8oOX6FoZCivZKEfZOwGac=;
        b=qfWQ49D8eOoIp3fZbQY1y66ziFjM2NwZHFsWt/Wd07bwm9YiCc7cojk70dz43KYMvB
         0roTZXcj1D9xKh7ZrcglaERF3vAdc1gycdZ6eR2EcsHWG/PVmjyqx9y1gISzZdyylMsq
         nMdI8yZykWwx1ujnbWB04c3cflRegN3B5ExsVuducPbiB+YMCHICZAYnjxDA7OhX6eMs
         OyCvPtVUnk6nD5gxlqJsHpCIAXui/hU4rzRbdMpX4dThG3yYLxv9qzVQLImEyJDpoy3f
         x3RmD7A2M+kqMHEBPHkNENYFxd3A/fc8iKWLDGpT7cl2/inXfFxUiWgafwphk8NIAYq+
         HFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774540673; x=1775145473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FBRCtRKDJQZI+rc1isgeuA8oOX6FoZCivZKEfZOwGac=;
        b=fVX3GsVPkBA42qJaoPGPn3BLZbTjnPYyMDnrHqe1odSoEm9CVONRrKyeVlWTUKwYmn
         LMe+2GPtzhOCa4Ozb7cViunV/a/KGaHUchTysaTlXBc12TyOLXVT/YtnxRfsVY8k4RMF
         0Z64MICIL7xTWUsB67756c96fGYIbuTKQQpLqEVWvFY4Rc1ZWO75vkA0cJ5MIv2SQIiL
         hpbUe0mdccnswsImeKJ+v/wcCLNk2Yv0yBUrPw6Xj+6k/mD3OOcrmB3UUxVBcvgn3G61
         r1dKFetCk2DhZfy/oKU16ukvw5ozlqnKh3FFYqvhrrogfnF6nh04Lw7pC1eHFi1p7OQk
         hHeg==
X-Forwarded-Encrypted: i=1; AJvYcCUOWWmqTIYqpVoMLrryNm4cxFwJ+PywLdFPrOpoGM7KtoWxXS9q2kiuHwvxdVcXCa0vj6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8TGFn+1lhi3iqCzVcDiBnnwttYbImlGZVSEo5sXPowjVVzwQ
	oZgioLYCds2ITihgiCfACB2VMryEt8tQ+WouWXtaGc8q81lHZtpdfyiiK4rQJlsSKm2tnCPFHuE
	jBzxnx0kiy7KsjHe2aEsc7++sntKTzI0=
X-Gm-Gg: ATEYQzyNzQGwIle+QGO5HJVK43Ilem7RHzxT0oKI9zpuHIjjF8DxKNKWuIBAREHL7VM
	/jY0mS9YYQWlsw1J+sXzwnHezIEc5h3q/+8xm+WuS8VVSH8+2/ogC516DMYK04Wa4LaCfmxNlcg
	cnIqQB4GggfFtpgbeKWmT3NoqL0b6Wuvr4FQYG8jarTcT8uFFJKUP3nGUJ2ozwAwpTU/hSrrAsu
	aJNQlhS1DWopVIbPBq9H9Aryp9TuFEBSirxz31qLPBTxM8aKBMngYSupZ5+XmAGjN6BzyiKRr2F
	/oh2P8NS81BfU6XmuJTVjJcGINbgEUNMaw==
X-Received: by 2002:a05:6402:4605:b0:664:68fb:bcc6 with SMTP id
 4fb4d7f45d1cf-66a8263c034mr4363227a12.12.1774540672617; Thu, 26 Mar 2026
 08:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com>
 <m2se9mg16x.fsf@kernel.org> <87qzp6ipc7.fsf@gmail.com> <CANk7y0jkEKYviXGG2je80Q26MK4nfE4p=wfb_ukDuHGKSy2Qiw@mail.gmail.com>
 <87o6kaioju.fsf@gmail.com> <87ldfeiodk.fsf@gmail.com>
In-Reply-To: <87ldfeiodk.fsf@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 26 Mar 2026 15:57:40 +0000
X-Gm-Features: AQROBzD-_492PgD5jCQu4_aaP608dgK9TP1u8UtDuwJfkScRD7hPgQmfrBmFmzg
Message-ID: <CANk7y0iXJ1sTn5eMrUosvbwnLrSwGtxyirgTpFwdDVWN0tHb5Q@mail.gmail.com>
Subject: Re: [BUG] bpf: use-after-free in hashtab BPF_F_LOCK in-place update path
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Aaron Esau <aaron1esau@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 3:47=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> writes:
>
> > Puranjay Mohan <puranjay12@gmail.com> writes:
> >
> >> On Thu, Mar 26, 2026 at 3:26=E2=80=AFPM Mykyta Yatsenko
> >> <mykyta.yatsenko5@gmail.com> wrote:
> >>>
> >>> Puranjay Mohan <puranjay@kernel.org> writes:
> >>>
> >>> > Aaron Esau <aaron1esau@gmail.com> writes:
> >>> >
> >>> >> Reported-by: Aaron Esau <aaron1esau@gmail.com>
> >>> >>
> >>> >> htab_map_update_elem() has a use-after-free when BPF_F_LOCK is use=
d
> >>> >> for in-place updates.
> >>> >>
> >>> >> The BPF_F_LOCK path calls lookup_nulls_elem_raw() without holding =
the
> >>> >> bucket lock, then dereferences the element via copy_map_value_lock=
ed().
> >>> >> A concurrent htab_map_delete_elem() can delete and free the elemen=
t
> >>> >> between these steps.
> >>> >>
> >>> >> free_htab_elem() uses bpf_mem_cache_free(), which immediately retu=
rns
> >>> >> the object to the per-CPU free list (not RCU-deferred). The memory=
 may
> >>> >> be reallocated before copy_map_value_locked() executes, leading to
> >>> >> writes into a different element.
> >>> >>
> >>> >> When lookup succeeds (l_old !=3D NULL), the in-place update path r=
eturns
> >>> >> early, so the =E2=80=9Cfull lookup under lock=E2=80=9D path is not=
 taken.
> >>> >>
> >>> >> Race:
> >>> >>
> >>> >>   CPU 0: htab_map_update_elem (BPF_F_LOCK)
> >>> >>          lookup_nulls_elem_raw() =E2=86=92 E (no bucket lock)
> >>> >>          ...
> >>> >>   CPU 1: htab_map_delete_elem()
> >>> >>          htab_lock_bucket =E2=86=92 hlist_nulls_del_rcu =E2=86=92 =
htab_unlock_bucket
> >>> >>          free_htab_elem =E2=86=92 bpf_mem_cache_free (immediate fr=
ee)
> >>> >>   CPU 1: htab_map_update_elem (new key)
> >>> >>          alloc_htab_elem =E2=86=92 reuses E
> >>> >>   CPU 0: copy_map_value_locked(E, ...) =E2=86=92 writes into reuse=
d object
> >>> >>
> >>> >> Reproduction:
> >>> >>
> >>> >>   1. Create BPF_MAP_TYPE_HASH with a value containing bpf_spin_loc=
k
> >>> >>      (max_entries=3D64, 7 u64 fields + lock).
> >>> >>   2. Threads A: BPF_MAP_UPDATE_ELEM with BPF_F_LOCK (pattern 0xAAA=
A...)
> >>> >>   3. Threads B: DELETE + UPDATE (pattern 0xBBBB...) on same keys
> >>> >>   4. Threads C: same as A (pattern 0xCCCC...)
> >>> >>   5. Verifier threads: LOOKUP loop, detect mixed-pattern values
> >>> >>   6. Run 60s on >=3D4 CPUs
> >>> >>
> >>> >> Attached a POC. On 6.19.9 (4 vCPU QEMU, CONFIG_PREEMPT=3Dy),
> >>> >> I observed ~645 torn values in 2.5M checks (~0.026%).
> >>> >>
> >>> >> Fixes: 96049f3afd50 ("bpf: introduce BPF_F_LOCK flag")
> >>> >
> >>> > Although this is a real issue, your reproducer is not accurate, it =
will
> >>> > see torn writes even without the UAF issue, because the verifier th=
read
> >>> > is not taking the lock:
> >>> >
> >>> > So the torn write pattern CCCAAAA can mean:
> >>> >   1. Thread A finished writing AAAAAAA (while holding the lock)
> >>> >   2. Thread C acquired the lock and started writing: field[0]=3DC, =
field[1]=3DC, field[2]=3DC...
> >>> >   3. The verifier thread reads (no lock): sees field[0]=3DC, field[=
1]=3DC, field[2]=3DC, field[3]=3DA, field[4]=3DA, field[5]=3DA, field[6]=3D=
A
> >>> >   4. Thread C finishes: field[3]=3DC, field[4]=3DC, field[5]=3DC, f=
ield[6]=3DC, releases lock
> >>> >
> >>> > This race happens regardless of whether the element is freed/reused=
.  It
> >>> > would happen even without thread B (the delete+readd thread). The
> >>> > corruption source is the non-atomic read, not the UAF.
> >>> Have you confirmed torn reads even with BPF_F_LOCK flag on the
> >>> BPF_MAP_LOOKUP_ELEM_CMD? I understand there must not be any torn read=
s
> >>> with spinlock taken on the lookup path.
> >>>
> >>> The reproducer looks like a good selftest to have, but it needs to be
> >>> ported to use libbpf, currently it looks too complex.
> >>
> >> Yes, I have confirmed torn reads even with BPF_F_LOCK on
> >> BPF_MAP_LOOKUP_ELEM_CMD, the results given below are with BPF_F_LOCK.
> >> But this is expected behaviour, BPF_F_LOCK performs a lockless lookup
> >> and takes only the element's embedded spin_lock for in-place value
> >> updates. It does not synchronize against concurrent deletes.
> >>
> > It does not synchronize against concurrent deletes, yes, but with
> > BPF_F_LOCK on BPF_MAP_LOOKUP_ELEM_CMD, we still take the spinlock befor=
e
> > copying value from the map (syscall.c:354). Deletion does not mutate th=
e
> > element, so when the value is reused, it should still take the same loc=
k,
> > shouldn't it?
>
> Ok, I think this is just a wonky reproducer:
> fill_value(&val, PATTERN_B, seq++);
> map_update(g_map_fd, &g_key, &val, BPF_ANY);
>
> should have been BPF_ANY | BPF_F_LOCK

Yes, if all the users have BPF_F_LOCK then it will work because the
re-used element will have the same lock and everything is serialized.
But this reproducer is trying to show that the elements are being
re-used, which they are.
