Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D429395273
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542365; cv=pass; b=Gg/U26iCz6EHn41o//XTpjiVxyIZTXooPeO+fopc5xzzsghbd5rzxOCDSz4Uvqpp6qoUtf9YjR9/PiR331CV6yutI7BgxflQl9toOVjHDxpDJgc17UA5bMiwjR+Hqd9ogHkPeueavtjQ+iemOTZAEhV1gT7+xMDP9EwvY2qJuWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542365; c=relaxed/simple;
	bh=+1VIbwYlD5P6U8aunjd8muf/Soz0/OQ+HB4vCQY8XcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFxenCoFNcBQya1VFtLpNKrgkAK5ftk5Z+RcCRinDL/WnGGxRDl+do1NdU0PZYRbKQZsRVXIKxgnSykbReyi1U6ZlW8pa7Npf6fxR6NZ6y83+Qlz1OMe3xz3EgjCjQnlDw5bY6ge9gOTgMXgbXyuMG7PNv5OTnAcjVvmKHmyvqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=byQbkAp2; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byQbkAp2"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66a33f61d80so2092462a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542361; cv=none;
        d=google.com; s=arc-20240605;
        b=kN5IxzzjMGlqJrOGkCp+Sh5muydbAXiobxklGHPJeBI4cJCVFxyNHDnI82jlQ8np1Y
         9EFAPbJck90CHxO43qwRCK/g9eoH6bHJFqamTJiZT2utKPLyYM2V/ztg2eWYBhHexQwf
         /3LzbFQVjZ9qlXFW3Ms5Bs3ma91g1SfMe5bYQG6B2AnlDO8s7fiUrbjt47Vos2pdsVXx
         IsTeEiDEZDSp0WX7ZWN/MWoBHhwkQfYHAr6kGc5ze0tB3bJlWTdTnCdg64sUsaEkSGWZ
         2reLH33zs+/cp3v++Z0FH6ix8hvvZoQjFPZid3BOGm/aUakSK96o/+FprgkLfWvVqqnr
         u3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8weEZ4/v1Q8ThZTOa9v3bW52mEvoKROcLFNZAFrpZyo=;
        fh=pJYHPmmb1JL9YbRG1Na1X1KehmxEfKNB7WXP8Ozt498=;
        b=lbqCH6LOrgL8KM+wTVPE7CVvPh6h6gJ7X6V8bAH3uu29Ln5+k1THfuPZZlCJjvvVFr
         VUv0jQiRIJOsQEWiDvhKyNMmccV05FmjutCnvS7BFbOrh54L+YLwkKZRuwrvled8q5T7
         KUz3spkuNe9rQv12z7VsE631f0AQe40c0TGICAmHS6myf226JpAMaQMSjq9ednBsnYKL
         KVMIXhwqStDPzhpznKivzwSwpjBfxgqXeovCRg78eTw3Uv7EGlKAVBh6/84K/IlvI5sl
         AfvNykQBWOC2/a9+jGBkALlPbzynlWmVP8v8W7x8kJiuVDP0S4+Wc1Wq/2mdarmBBqH3
         +gmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774542361; x=1775147161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8weEZ4/v1Q8ThZTOa9v3bW52mEvoKROcLFNZAFrpZyo=;
        b=byQbkAp2gXL9dtnx9R3g30En9cn9BNM2StZcVwrvid8YtA0Odn9evNZIGedXdDX0B+
         t2YNfmaTfMU5sBsKn8nkiO5QYRkN6P8mxI/rvIqgDCK3acg1ppiVcDGNS/JwSoWUjIrD
         3+qtygp3cFtUcsvPjPOEKiHOdZ58WgMXyC5+r2cK9F6kFbsjd9CGQ8K/mpvb6R7JxGHX
         APWBQbvKfydnPskVWm+v0L9amIdmQwif/HvEMaISJZNVyX5OIg3MvdhrD9y6jxRUSRhc
         Rfvt6LW01w+vev9+NMtTtWVEiiHjiW3LI46DIFgp+Beydm/5SLDyix9E84NZdi19sTAo
         gVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542361; x=1775147161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8weEZ4/v1Q8ThZTOa9v3bW52mEvoKROcLFNZAFrpZyo=;
        b=cnsDwO3Zs24cHohDuMqYss6JyiU95yQGa6Q7pAz0WW0sQGek0jAW4Kb986GMYLmIGq
         KBJr1aQHkdTt8KFdAVIG8VFbWCZFfUCRgPUvFliX3KAd1WmVVrxenVFZrhIoOPTRjO3p
         es02EjCPWDcQRA7hYd34IpA0uWc/h7KAVMOt0pIixg9hD/drOoxj1CK5TZ4taYORjjI1
         pxKystUKz5a04MjA8NT5SSKDN58qb2wOc19q6Ush05xwJGWJWshae3F9r8+xxDewKaib
         nBhted0VP5QUTlm9sdcZRbHlbgE5VEsPIFL4BSWiq9wIBj/zYrzdn5aB3o0BGpyljxET
         VYgg==
X-Forwarded-Encrypted: i=1; AJvYcCX3zBCK/eC4+Xw63AIi3yRo/trcDP7N7uxeYNYjREQHm/6ieCBp1hPjxdD6jxnM+mymEDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEoBYOWLOvOocoAID3C4pAVALb8wX7Crsfmq4WjC/FWSifzT0q
	J41oPKQy8sRCyEDzOIxko6EO+p9rSlDWWr3q6wU8HUk2AvqJNfPt14fQomvKGau9VDnEyq7+6in
	bF8QovpRS+D39bnynJK/Lh9lx8xsZccZkGkxp53Ff
X-Gm-Gg: ATEYQzy0c20SlNvnOyMNbLlfn1cCA+VxYdQxxculxKuCC35k45z9bsltlfgdaBWV3FL
	fpyK8m1IVdwh/1Fa93dJAvhp1GyIMyLl1aRUyx52AVColsfgzs8Fip1+Zc3/Vo0uUDW2wYJ+/BC
	1mw/5BA5s7dyR1QdO87Nw4BkXlzg5v+eSpcZu32Ow0qiQq4stNoOzYW1M2uxr0OqVIq02N3FuoX
	H5C1C07SSsWgLjqCyklvB5p9HOpvqsmglcExbNY0mJk4IXY9pKKGF8hSWEjz1AMb1RXty1PUizW
	nNtHs77CanhClMwIjb+amWWGQD6G7MX+HVNH
X-Received: by 2002:a17:907:7fa9:b0:b87:173f:61b with SMTP id
 a640c23a62f3a-b9b348a060emr151018566b.9.1774542361098; Thu, 26 Mar 2026
 09:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326112521.2827500-1-wusamuel@google.com> <m2v7eig4ue.fsf@kernel.org>
 <CAP01T74KNVT2SVRR+XPbFb1vy85W=Jkp4_yD6xvTSg2avQo8AQ@mail.gmail.com> <CAADnVQK252XxmxM3enS4wPREshTEawQKbChgN-teX3+wmxgdBQ@mail.gmail.com>
In-Reply-To: <CAADnVQK252XxmxM3enS4wPREshTEawQKbChgN-teX3+wmxgdBQ@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 26 Mar 2026 09:25:49 -0700
X-Gm-Features: AQROBzDpxR80sNDZIp7I-1jwQ56Npkte6GZeWCLG3T-hio_UtCQbkOqHje_ZuUg
Message-ID: <CAG2Kctqd4p4pJtH=tSfKT57qfecQrpcoYu3SsAzJ-zGEiYVSQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Support BPF traversal of wakeup sources
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Android Kernel Team <kernel-team@android.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 8:02=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 26, 2026 at 7:54=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Thu, 26 Mar 2026 at 13:20, Puranjay Mohan <puranjay@kernel.org> wrot=
e:
> > >
> > > Samuel Wu <wusamuel@google.com> writes:
> > >
> > > > This patchset adds requisite kfuncs for BPF programs to safely trav=
erse
> > > > wakeup_sources, and puts a config flag around the sysfs interface.
> > > >
> > > > Currently, a traversal of wakeup sources require going through
> > > > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls t=
o query
> > > > sysfs is inefficient, as there can be hundreds of wakeup_sources, w=
ith each
> > > > wakeup source also having multiple attributes. debugfs is unstable =
and
> > > > insecure.
> > > >
> > > > Adding kfuncs to lock/unlock wakeup sources allows BPF program to s=
afely
> > > > traverse the wakeup sources list. The head address of wakeup_source=
s can
> > > > safely be resolved through BPF helper functions or variable attribu=
tes.
> > > >
> > > > On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~=
34x
> > > > speedup (sampled 75 times in table below). For a device under load,=
 the
> > > > speedup is greater.
> > > > +-------+----+----------+----------+
> > > > |       | n  | AVG (ms) | STD (ms) |
> > > > +-------+----+----------+----------+
> > > > | sysfs | 75 | 44.9     | 12.6     |
> > > > +-------+----+----------+----------+
> > > > | BPF   | 75 | 1.3      | 0.7      |
> > > > +-------+----+----------+----------+
> > > >
> > > > The initial attempts for BPF traversal of wakeup_sources was with B=
PF
> > > > iterators [1]. However, BPF already allows for traversing of a simp=
le list
> > > > with bpf_for(), and this current patchset has the added benefit of =
being
> > > > ~2-3x more performant than BPF iterators.
> > >
> > > I left some inline comments on patch 1, but the high level concern is
> > > that encoding the SRCU index into a fake pointer to get KF_ACQUIRE/
> > > KF_RELEASE tracking is working against the verifier rather than with =
it.
> > > Nothing actually prevents a BPF program from walking the list without
> > > the lock, and the whole pointer encoding trick goes away if this is d=
one
> > > as an open-coded iterator instead.
> >
> > Which is fine, the critical section is only doing CO-RE accesses, and
> > the SRCU lock is just to be able to read things in a valid state while
> > walking the list. It is all best-effort.
> > Open coded iterators was already explored as an option in earlier
> > iterations of the series and discarded as no-go.
>
> kinda best-effort...
> the way it's written bpf_wakeup_sources_get_head() returns
> trusted list_head. It's then core-read-ed anyway.
> Ideally it should be trusted only within that srcu CS
> and invalidated by the verifier similar to KF_RCU_PROTECTED,
> but that's bigger task.
> Instead let's make bpf_wakeup_sources_get_head() return 'void *',
> so it's clearly untrusted.

Thanks all for the fruitful discussion; this is more rigorous. I'll
update v3 so that `bpf_wakeup_sources_get_head()`'s return type is
`void *` and I can add a corresponding selftest that directly
dereferences the head and expects a verifier failure.
