Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999871632E7
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 01:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167064; cv=pass; b=Gxx1XQR00y6ue+1jR0cLR65nFz4dFVGMdxM8uRcaYPfAUqQQbr9rLEUavJCz3MSmIPbmRynkiXl1NUKWMbccel5+lg04h5skMS0bd2QNpKt4vM2FnhpASE/LuVWATFycxIBzbEfl3sgyV9b+Mo1LKAtYkQXaYmYpe9j0eXGpOao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167064; c=relaxed/simple;
	bh=8vUaBBwTCIdWVbcN2h9CveZhe4Gaj3kOlnBmiEdJ9pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAhHkdoVfjjdm10vFiKSs/8/qFuP4Z/wmK7KAM3Puf/cGY2uZkk6T3hZwfap+c/sOsvbmEIvXAzpLPh/xCYjlUa6zhyH+eYFTSVBkpM1QO7/F4ngEOYrgAPvegEAaR93fpz3HfHmR7jdf9ZT6OFU7d6PoxYLzAr2vVpKXLVjuZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=veFsPZlP; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veFsPZlP"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014b5d8551so99261cf.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 17:04:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770167061; cv=none;
        d=google.com; s=arc-20240605;
        b=bPXs7P+MUBzV/dKDfvzDeuHkgvM9B2IS2Fwp1saFUDzl2XHTpzmbi9tJE9w5PKukXc
         21lUwZ25jn/nV36FhaA9wpiTKt/NsrU1NkxC6ADcYy9iAgRUngGUkGwA8tXYzvmzeQ7H
         69U2ATxD6Jbr0e4LU7WOk1alu1h6+SMI6K8pwmgAQ+Nlz92d4eu+Lx80pKN3OeeEOAQB
         fRipVY6wrLOqQtEDCWF/hQ9ygpj8EwUryfLA5itL3OWtLWjrq7utME5A0ao/aDAVWN0y
         bXR4pKpVYtmL1ipuSBedv706uhEoYJZH+RUeKuwzwJuoQo5ZJURd/56A7JCz5pj6POWU
         WgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8vUaBBwTCIdWVbcN2h9CveZhe4Gaj3kOlnBmiEdJ9pU=;
        fh=K++rw65FTKp0DBLePa3KjgtMphwRdJb6kMW5pqaMVdI=;
        b=hwsnezcR4kagMkrKrAEkIooks1f9+88ta2Jei9YNWycTXMw4ECElwis/kCJ/D+OYkZ
         vNdxZQdKC2Q8X6AV27VqpCMwmJpuu0y156KO13MXVR5KaL/isf/lNY0Z4ZWdDzSe7RWY
         q/FnDAdnegwIsKfmSM57ZgD48UWeUL097vrxTZkBib4S5QJydvnNQyjQiAh9VqoIa9C4
         La1nZZTBHQWuQNUjDDpY6gdfqWVMrWTev8kb4I0/No7XBl7+Bxiyi3NuLhjGcyMmV33p
         wlrmHC9rQTWpsu/ITwyK6O6BsHNUH6Ezte4P7lHDf9HgQm/8WMrdx050He20KxGOsEds
         95dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770167061; x=1770771861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vUaBBwTCIdWVbcN2h9CveZhe4Gaj3kOlnBmiEdJ9pU=;
        b=veFsPZlPCXW2tsON7GTDlnfqPEzIWeQ/gOEPApyZwNXTwyRXLdvHrsc9rLoGUVCqSf
         46gRFe+4P1BtlUVyICHFNuNAj07jMbqN/f3vZvMMYBgOIPuOA/SXr+C1Ipy4XcadPbzu
         WpdPOzmQ5+ABlFFqIxsyuxVyjVPe+OYTXYuOGc5kvY+RnXuYsng377lnsdm8gFyM6IOm
         suZKjL/iis7asgbnQHKWr58OnMVGkvkAVdwHEAq59JxPej72OxzjXD+Hhin08Gn2jgLY
         sj5T/w/pMWcGMC7YCTMM6CPcBo6iN0JAHUjGNQUWNm1Ov1QG1dPm9DmqX4oN3TNVADu/
         2P/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770167061; x=1770771861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vUaBBwTCIdWVbcN2h9CveZhe4Gaj3kOlnBmiEdJ9pU=;
        b=kSC6inZWZsXHRiie+pEzzLV3jqgDBCF7lDCINngeBz+ttKosBhvKUwlXifKsjZqh6s
         So9245hx9pTlaT7qGN9+4EUh5Cae8oiK6Q6x4TC0sqWalxyW5hbaDhilnghqzRkKH7Tq
         KV9qd+39J2opPH2IApubljDAaQXfTixK9Pe0uG4FVhIbxmFu+od6fYjTkUhG8mEBFash
         UIVVCtwbpVVx6w46wafX+2haIB+NtwRz281bBH2/ulHF1I7OZLM4u9P+azu9NCOyRrpM
         QEAqP4+r34x1UItFiWFxAxJVg/EVQ6YYofxvQ/u/knT1GSbLbytcKejuEyCDhK5XnJ89
         iPpA==
X-Forwarded-Encrypted: i=1; AJvYcCXTrj9Ku8PgfelsIiTBLp1YjP4q98iD+O0Om3DAsg1wXiKL2bF9NA1HLP7RmHey2liqeJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXIuRiedhWwWI7Ms3E9zmEINTnSiY6CzXbMGQn05aGyhE3YMnz
	t1b0tnIs/pyBLUKn0BkvNVL9/5wp5jqkM2UzffiB7I6STukHyzl5lnfP+OEiVMnt4Vs+aVeQPmM
	XT3t4WZCRP2QvOd9n+9Xu5M4OOeVROMviPiOUEYfS
X-Gm-Gg: AZuq6aI+GTTcl+E+bYn0GiHfe3YSl/s+6eF+9Q4nWhB9xKL4+xD7spPepEDhz/nQpjZ
	eeVNtPjIiF/nAfWzBppxKcRRFBquXiabve/MVAG+3GlVA8ewVBfNih3AB3ygLD9eC6p2KlLIjoG
	7zuKUVmXmk4TvI49zBffCYEy7KUrmsHPeTCeYXUiH3ruGPaDnicA08CW1ZmzZsmyh7gmuYg0cvm
	KvP7uJANeMZ1FOJL7fmS/oGFGQ10OlX0rsDr1Qonw73lMJutZ6DVjNNQclYmBDlNcGW5uMt
X-Received: by 2002:ac8:59ce:0:b0:501:3e46:6bd5 with SMTP id
 d75a77b69052e-5061d7ab74amr3195901cf.19.1770167061066; Tue, 03 Feb 2026
 17:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203102058.41030-1-rohanka@google.com> <aYJZ62BCwNIC1Q3f@slm.duckdns.org>
In-Reply-To: <aYJZ62BCwNIC1Q3f@slm.duckdns.org>
From: Josh Don <joshdon@google.com>
Date: Tue, 3 Feb 2026 17:04:09 -0800
X-Gm-Features: AZwV_QhUorJe2NM04DXpYlDuITG_1uWv4FHyCkkRmPFfb8oo4Kxg8_2sSlan_yY
Message-ID: <CABk29NuyzS_XSUQM3yA0a2rqpNXg6xaGP5pVGXJoJa-xaOBdOQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: ephemeral cgroup BPF control programs
To: Tejun Heo <tj@kernel.org>
Cc: Rohan Kakulawaram <rohanka@google.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

On Tue, Feb 3, 2026 at 12:26=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Rohan.
>
> On Tue, Feb 03, 2026 at 10:20:55AM +0000, Rohan Kakulawaram wrote:
> ...
> > One of the main gaps in achieving these ends, however, is that
> > there is no infrastructure that supports exposing per cgroup data
> > via file paths that mirror the cgroupfs hierarchy. This would
> > allow for a unified source of truth as it relates to accessing
> > various streams of data related to cgroups. It is important to
> > note that we would want the fate of these ephemeral files to be
> > tied to the manipulation of the cgroup tree, such as exposing/
> > deleting files when creating/removing cgroups respectively.
> > Cgroup iterators can mimic some of this functionality through
> > bpffs pins but lack the dynamism of the listed approach.
>
> On one hand, I think why not, but at the same time, I'm having a hard tim=
e
> why this would need to be on some file system. After all, we're talking
> about BPF, there are numerous way lower overhead ways to do bi-directiona=
l
> communication - shared pinned maps, BPF upcalls, BPF seqfile iterator, ri=
ng
> buffer based interface and so on.
>
> Can you elaborate why this *needs* to be a separate file interface? Note
> that this doesn't really expand what BPF progs can do with cgroups. The o=
nly
> thing being added is a different and not-particularly-efficient way to
> communicate with BPF progs.

Each of those existing communication mechanisms have advantages and
disadvantages, and my take is that none are really optimal for the use
case described/implied here.

For starters, I think it is important to have the interface be
synchronous. Stat collection and reporting for example makes much more
sense to do on a read() edge rather than arbitrarily dumping info
continuously into a map or ring buffer or something.

For the BPF iterators we already have, you could in theory pin and
unpin as cgroups are created and destroyed but that feels like a bit
of a hack; at that point you don't really care about it being an
iterator program, you're just piggy-backing off the fact that it
exposes a seqfile interface. Add to that the fact the trickiness of
keeping everything in sync as the cgroup tree is modified, plus there
will always be a latency between cgroups getting created and userspace
going to pin an iterator (especially if the jobs creating the cgroups
are not the ones caring to pin the program).

I also find the file based interface incredibly convenient. You don't
need to have code deal with making BPF upcalls or read() from an
iterator fd, instead you can use traditional file based APIs. Exposing
as a file-based interface also easily lets scripts and manual
observation/manipulation work easily as you can cat/grep/etc just as
any other file. I have to imagine the motivation for allowing file
based pinning of iterators shared similar motivations.

Typically cgroupfs interfaces are low bandwidth communication
mechanisms to occasionally set/get resource limits and stats. So, in
contrast to the APIs you describe, this is also about offering a more
flexible and convenient solution without needing to worry as much
about efficiency.

I also think this pairs pretty nicely with sched_ext as schedulers can
define custom tuning knobs that will be automatically exposed for
manipulation on a per-job (cgroup) basis.

Best,
Josh
