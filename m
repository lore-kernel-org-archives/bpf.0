Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D4D29BDBD
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054620; cv=pass; b=topQ2JGMyRa6xeO7FhlgJNGiuAijxzbR3rpFx7Fo55DNCUY6y6GGGpyNWuAiOZ+ShIO2LBuLj/00i28Rp/EfZyVrys1YdNy3QQ1Jg04NHe01xA2V76chS+61W/Q6hcJsiVhry+/qr3t0KJuRVXwRMaXOsh18HSNu++lrA5ny594=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054620; c=relaxed/simple;
	bh=SqHEa2lIJ8aAbOSZMjCmc3C/32OqZQFOZt8cIZMm4X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fnz02ODzh/MaiMxJg7LjxfmZX5EzQijxZkNqTLZYRtkQ/ZVjqhcwEbu/WZKalrL8WDfUwzSm98grBZWKsC6eeuzLUlRzXJmi7B2820MMrtNqs3f6JZXXoGtO4ktjYkGNQiuSO2+fQObomWTYebat5jfE9wKuyOb+wahP+o9etCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl6ms8+i; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl6ms8+i"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso49161995e9.2
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 09:50:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770054617; cv=none;
        d=google.com; s=arc-20240605;
        b=Qc4S/v2s/b4zoI6OvP1n6HgUioIP3TAhiTQdjLv54eiUP3CynDxilGVDwg4XA3V8Yp
         STI4p88JN/MGo2hix4ylMrgTPZXtQrwy/164FDJWNjcDd6z2yIHjv95sLBVtVJwoo7NR
         bDpatMJtlQN2vJV9dsgUsYJmjrR0QT0OdBaIPGk220JfW/uOP6QUB9chGu07iwUkym44
         hJGY/5OcZex+M1rvIWioMcY7/SB+IAeqJCQCi3krVWoIuQXZHhanQql6RDZS0exf3gJq
         pU1gByWUkwXI1+eARKiO27fW1QHOxtn473oexBmzuDmUKVqGfTk1TOjDawSYjf2jiPhn
         lRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SqHEa2lIJ8aAbOSZMjCmc3C/32OqZQFOZt8cIZMm4X0=;
        fh=QBPwjK9ECNp9Z9TP5rhIR5KzAaEd4bV1PA3gpIoKm4g=;
        b=L9JBEe89OiZ/cPAFFRdnZn/lu8R/SHsQPN0VDy5mJrlc0ZzIro/GuTi/prpxz2YU6h
         0OZQ+dhsCA2bUJJsUxvGZlAaQ2Zb9Fd/NPeI1LAoshD4IZluyGaEwa5JEaV5n9U4Ei7J
         51VFGuy7HjtLQ87YXs5MljkCBA9vYk+YJmKKdhVz636zgSNcH5nDreogp+pVd0Pe3sE6
         JZyHFeMHl+4jiQrDLksDjbvF4J66vdDq1WGoqNW+TJSycuZvWky3SbonDvG+iXy7u9tj
         OC2vD7bRCrMXQgD42m+gPceEfTaBFstmmG3G0LYk59kP2H+vUyoGdm71IS1O9shwipbh
         f95Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770054617; x=1770659417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqHEa2lIJ8aAbOSZMjCmc3C/32OqZQFOZt8cIZMm4X0=;
        b=Kl6ms8+ieIfOJHVILdYVSng6HW2ekkocAH0r3uxN/PmWklG0pqtse3/XlQcIQ3OIqE
         86DSr8IMdKAj//wWVNifHoeC7fpjXS8rWLEyhiY/tM5tO1myGePRiZ7j4yfH3nHRYzi6
         ANmGvZqxWbDgVYDMX/+gLAiUhqIq0Vv2+tftU/tEjnPGKyErC8NIQMjEE+C18JoTTdFO
         ou9h2AEZSdbwtelfPXOCzJs5ZkhQORdvT5PRwGN4LUQr12E+x3h5GB5mXTpvMI6cfomu
         x0AZRG/cwnadiHI5NQh7IqVJHVt3wQvLnj//oRnpvQTc+AVP0GlubE4BCmexuPiMhNev
         FjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770054617; x=1770659417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SqHEa2lIJ8aAbOSZMjCmc3C/32OqZQFOZt8cIZMm4X0=;
        b=iGr7JW3yJtrFVL/wGvWtlZiH7SaScL/ApMF9I/1TGK0w+n+bft7yuXfyBWWRhmNIaU
         Kz+c6rh6TrFMtsBmoiV0Sq1bE8pQGE5SZuDdy18b3ooA8nyMTgI1dJqptU94i1tM5GxC
         9FcD9vQhVk804l/g6PlAF4u3/TKzyOBPBi8hXfH+XexokZZiuPwefy34gn956BI28+Mn
         SEWK6+k2fWh5g5dgtpkpcoxyUyNBt/TY7j3wd1WGFP0xhL/fB6MKfZl49hxQixrk7oIJ
         JhCbjXQUQYQoQmG0TLVqO2vKzPVQ79VMfkpBSmSdDqCemBB2vjM3PddyWdu1+6cK6Wj5
         +EAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0J/Z7LJG87Eox3dNG51GxVCAau7I1rEloPIDWwrJ67eIyr1/x18ahTb8pA0EDI1OxpnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHbD8J2wmxkTmbFGZNLboCw9QlhoxW6l5/gsfdcDCuo5gXQriJ
	XcTgs4BWzLc9ra8mQbJcjvIuOZxJjA+559m3xnWC8zgmQHsJA7TH7cIjTOCI/T6rG8Hcx5GxBop
	IaRLPcZSbC+f89iyX6wCEum802OTxjqc=
X-Gm-Gg: AZuq6aIO+uhOV9PAqu8Mlq5iEtWwVCv7OPzEF9S2KTg6jA8jRD14Pm2ETt+h/WO7RIc
	kx9as7fGjzoZUWCru09jdypF/cQjqMDcEXZutFGHFvRUHH/pgC5Sl+Im4CoKesKqYuWuv1G+9PQ
	yC+UsiKnWdIC5BFEDx780DCFdny+W8BXEAguCwMrFTcCA+afMlXMOj889DEtIwtYnYVMGSJiuW6
	5wEpeP6rIjetYlRbyKUDtlHw7YqbgyLPANFyzkvSSlMaIIFxeI9/SM3U0aFQb3T0mYrj6o8o7oO
	ZFjqYjgGgecel9peFY1JyjpyxVZhHH6me5zCoiTuf/fgPE0Ynj2kTusTs10KelRuZnlY4nBf
X-Received: by 2002:a05:600c:628d:b0:480:1c75:407c with SMTP id
 5b1f17b1804b1-482db4577f3mr151208365e9.2.1770054616976; Mon, 02 Feb 2026
 09:50:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <aXh_LpTzDhvv20uB@tiehlicka> <7ia44io6kbwj.fsf@castle.c.googlers.com>
 <aXnDdkYmtipGwSjK@tiehlicka> <CAADnVQ+ghTc5FtJCjm4ya3y3xVpSuJe-7ctdT-thowqWguc1pA@mail.gmail.com>
 <aYAZT-ZZSKdiChfd@google.com>
In-Reply-To: <aYAZT-ZZSKdiChfd@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Feb 2026 09:50:05 -0800
X-Gm-Features: AZwV_QgWPO6tVqI8Q3ClAr2Pk2pa3uETsu08TgeuX6MtqSwq_qFHAQc7YZ591MI
Message-ID: <CAADnVQL3+huSAwoYRexoSDaLRK+nEsY6UUnVSmhk_sGYUYsO7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/17] mm: BPF OOM
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Suren Baghdasaryan <surenb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 7:26=E2=80=AFPM Matt Bobrowski <mattbobrowski@google=
.com> wrote:
>
> On Wed, Jan 28, 2026 at 08:59:34AM -0800, Alexei Starovoitov wrote:
> > On Wed, Jan 28, 2026 at 12:06=E2=80=AFAM Michal Hocko <mhocko@suse.com>=
 wrote:
> > >
> > >
> > > > Another viable idea (also suggested by Andrew Morton) is to develop
> > > > a production ready memcg-aware OOM killer in BPF, put the source co=
de
> > > > into the kernel tree and make it loadable by default (obviously und=
er a
> > > > config option). Myself or one of my colleagues will try to explore =
it a
> > > > bit later: the tricky part is this by-default loading because there=
 are
> > > > no existing precedents.
> > >
> > > It certainly makes sense to have trusted implementation of a commonly
> > > requested oom policy that we couldn't implement due to specific natur=
e
> > > that doesn't really apply to many users. And have that in the tree. I=
 am
> > > not thrilled about auto-loading because this could be easily done by =
a
> > > simple tooling.
> >
> > Production ready bpf-oom program(s) must be part of this set.
> > We've seen enough attempts to add bpf st_ops in various parts of
> > the kernel without providing realistic bpf progs that will drive
> > those hooks. It's great to have flexibility and people need
> > to have a freedom to develop their own bpf-oom policy, but
> > the author of the patch set who's advocating for the new
> > bpf hooks must provide their real production progs and
> > share their real use case with the community.
> > It's not cool to hide it.
> > In that sense enabling auto-loading without requiring an end user
> > to install the toolchain and build bpf programs/rust/whatnot
> > is necessary too.
> > bpf-oom can be a self contained part of vmlinux binary.
> > We already have a mechanism to do that.
> > This way the end user doesn't need to be a bpf expert, doesn't need
> > to install clang, build the tools, etc.
> > They can just enable fancy new bpf-oom policy and see whether
> > it's helping their apps or not while knowing nothing about bpf.
>
> For the auto-loading capability you speak of here, I'm currently
> interpreting it as being some form of conceptually similar extension
> to the BPF preload functionality. Have I understood this correctly? If
> so, I feel as though something like this would be a completely
> independent stream of work, orthogonal to this BPF OOM feature, right?
> Or, is that you'd like this new auto-loading capability completed as a
> hard prerequisite before pulling in the BPF OOM feature?

It's not a hard prerequisite, but it has to be thought through.
bpf side is ready today. bpf preload is an example of it.
The oom side needs to design an interface to do it.
sysctl to enable builtin bpf-oom policy is probably too rigid.
Maybe a file in cgroupfs? Writing a name of bpf-oom policy would
trigger load and attach to that cgroup.
Or you can plug it exactly like bpf preload:
when bpffs is mounted all builtin bpf progs get loaded and create
".debug" files in bpffs.

I recall we discussed an ability to create files in bpffs from
tracepoints. This way bpffs can replicate cgroupfs directory
structure without user space involvement. New cgroup -> new directory
in cgroupfs -> tracepoint -> bpf prog -> new directory in bpffs
-> create "enable_bpf_oom.debug" file in there.
Writing to that file we trigger bpf prog that will attach bpf-oom
prog to that cgroup.
Could be any combination of the above or something else,
but needs to be designed and agreed upon.
Otherwise, I'm afraid, we will have bpf-oom progs in selftests
and users who want to experiment with it would need kernel source
code, clang, etc to try it. We need to lower the barrier to use it.
