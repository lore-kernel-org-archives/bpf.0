Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58C3358C4
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 23:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770249150; cv=none; b=acOAyjTzBbMWgnQSCWFanbg49vcJ5WNnNUj2YACQ3Nw3C65PaMPiyct6nZZLh+lq9RzR5Q1IthU4dtE3GWY1JYZhVgHXpNLptsBVRdTZFjcac4S9lJw5RHnKRBPMnU02lwpvwt/52ytSGunK+G6eeN0XKyu6zzrLu/XnIfJjBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770249150; c=relaxed/simple;
	bh=FTtXKXZ4GD0ZpUHSRS2eNmWFvyglSZStTQE1prKSVYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfnGflZgBKIUAA3TWcQ+hZUqHs3NBP6HPLvb93sW1Hw89y4/pIrVpeDDEGtSwzkaASXO5lcPuf7+KathIH14OUNqkUH0FM2hAdOoVvY+4iCwsCQ5i0KDDdVXicK/ZhQ328itd2/CE9+DxhBICLyD5bptT1XO1H+3Fl4aU/1LHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGXXHJLv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGXXHJLv"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so50015366b.1
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 15:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770249149; x=1770853949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vydobbPXrZrzizZdxwwfY84vYBgm5hoA9LpOro1zZVU=;
        b=QGXXHJLvsqkwmmen7dCGYZQ9dLBO5kA6SFwGCSUyOYjk1yZRi+UvtMgCmGhom/rKU5
         5hc4Srdv/Q5lNLFg7QQfYBz97aXlJEs8OGN66MaW1Z5PVjrX+EUbKSkqMN8bzV9a/U58
         JtkdD93MGNafPbaU3D4+Ss4pWy/1m9kJHdy53FEzpnLmjD7NqkmqCe+EGu3cZp2JlBeL
         UScRAO8kXXPzZOST3hn/lNFHldWtNNHglekzEcpUEgbvVmA+GzBbFNCSR8H878nB6u3B
         lfUy2LZV7FORs9hBytGT9fhalhlPsKsf2v9pc6V64fGnxJ+3OAyL5XaW61mFLewIL91Q
         ruDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770249149; x=1770853949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vydobbPXrZrzizZdxwwfY84vYBgm5hoA9LpOro1zZVU=;
        b=JCBrI93HyAZjAQTtA8VrYjNIuU5v13GE57HRW5YpnJt+/WW19PLjXrQFjB2KYCwy6w
         EHt8OzF1peTBYjASjM2V6b7IcpIefgNAYEUcdXxfdGUXyIWTs2AprKp6U+W2smP8p6Go
         AZlSTy2hc1QJfPrAcdot1FACfwv3sOMRKCf7tIuLUbHs0fIbQYgD3ybbjVTigs4XMCGA
         054iX87rYHIQVAs08ZrBR5G+NvdDsh31Qnh2j/cr2fsJxTOH1I0bzazwKEW5K+s6DHfq
         XODyl+zqs2kKg0KoeRhNTjLCEVM86QPMy/Fp+bnDV6O6atXdeHu61ZwmIZmAuyHbGAu3
         VRGg==
X-Forwarded-Encrypted: i=1; AJvYcCWwZdVNNbFz6e2NHauax9kEqnxaaX8wrH+/+fbfaK7Fx8EmsAb3VpV39yd8Pkd9t81lVpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLP+ewV/RqypJJ6MEuaprO9o7pUfq+zLIa1AR3EWyDrLx0432V
	IYi0XLnI6viRa1kuVZqEJ9nBhuZt577Q6mU7rMxkaTEubawlEq8DUgUtCt8bQjmtVQ==
X-Gm-Gg: AZuq6aKItYadIoJ1vwDfBomkh2gGP8EEetd1ERFooyVO8CKPz9Ui6Jza4+Vr3kS/DES
	irJ5mKlrV1d9hkkNvVCdNZKv8BwAs/FBSP3In1VYnzVoP40jojIX/LSnKGBS5d4WIVPzSas6C7b
	ietrK6rzIEnG3/NzMrPDPqddpjGDkjUjkoQTTPmDqlbPVUTALZa+X8ziZ/zEqRmQ5DOEvbgxQw+
	xBVFGBxyFgkjslgfPMzeb3Av/BnyVXI0IZl6V6hi3nmXY7OjtNxMDJvbPhOGa+16slY0tG/STNS
	XFSPY1gcmdrOv80p6Y+9PV9fnBahARRgfG5hceTBDs8w8rWGtDjZ9jBMfaH5kjHmo5urN+aRDcS
	NP4va4o9XOJ7pJlntu5NpGLiCWIrQAClwgqMto59K7XD4rarwZIavb2MQOHne8qxM38Cj9PD3lx
	cC2Y7xKI6mUb1+edZjrKgMvQRtA3mb3/dAHG1HPDsRn/SuD/sOWQQ=
X-Received: by 2002:a17:907:9625:b0:b88:71ec:e7a6 with SMTP id a640c23a62f3a-b8e9f04c989mr307018066b.17.1770249148604;
        Wed, 04 Feb 2026 15:52:28 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea0021b25sm164091166b.50.2026.02.04.15.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 15:52:27 -0800 (PST)
Date: Wed, 4 Feb 2026 23:52:25 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Don <joshdon@google.com>
Subject: Re: [PATCH bpf-next v3 00/17] mm: BPF OOM
Message-ID: <aYPbubIPIsfFiMhD@google.com>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <aXh_LpTzDhvv20uB@tiehlicka>
 <7ia44io6kbwj.fsf@castle.c.googlers.com>
 <aXnDdkYmtipGwSjK@tiehlicka>
 <CAADnVQ+ghTc5FtJCjm4ya3y3xVpSuJe-7ctdT-thowqWguc1pA@mail.gmail.com>
 <aYAZT-ZZSKdiChfd@google.com>
 <CAADnVQL3+huSAwoYRexoSDaLRK+nEsY6UUnVSmhk_sGYUYsO7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL3+huSAwoYRexoSDaLRK+nEsY6UUnVSmhk_sGYUYsO7Q@mail.gmail.com>

On Mon, Feb 02, 2026 at 09:50:05AM -0800, Alexei Starovoitov wrote:
> On Sun, Feb 1, 2026 at 7:26 PM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > On Wed, Jan 28, 2026 at 08:59:34AM -0800, Alexei Starovoitov wrote:
> > > On Wed, Jan 28, 2026 at 12:06 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > >
> > > > > Another viable idea (also suggested by Andrew Morton) is to develop
> > > > > a production ready memcg-aware OOM killer in BPF, put the source code
> > > > > into the kernel tree and make it loadable by default (obviously under a
> > > > > config option). Myself or one of my colleagues will try to explore it a
> > > > > bit later: the tricky part is this by-default loading because there are
> > > > > no existing precedents.
> > > >
> > > > It certainly makes sense to have trusted implementation of a commonly
> > > > requested oom policy that we couldn't implement due to specific nature
> > > > that doesn't really apply to many users. And have that in the tree. I am
> > > > not thrilled about auto-loading because this could be easily done by a
> > > > simple tooling.
> > >
> > > Production ready bpf-oom program(s) must be part of this set.
> > > We've seen enough attempts to add bpf st_ops in various parts of
> > > the kernel without providing realistic bpf progs that will drive
> > > those hooks. It's great to have flexibility and people need
> > > to have a freedom to develop their own bpf-oom policy, but
> > > the author of the patch set who's advocating for the new
> > > bpf hooks must provide their real production progs and
> > > share their real use case with the community.
> > > It's not cool to hide it.
> > > In that sense enabling auto-loading without requiring an end user
> > > to install the toolchain and build bpf programs/rust/whatnot
> > > is necessary too.
> > > bpf-oom can be a self contained part of vmlinux binary.
> > > We already have a mechanism to do that.
> > > This way the end user doesn't need to be a bpf expert, doesn't need
> > > to install clang, build the tools, etc.
> > > They can just enable fancy new bpf-oom policy and see whether
> > > it's helping their apps or not while knowing nothing about bpf.
> >
> > For the auto-loading capability you speak of here, I'm currently
> > interpreting it as being some form of conceptually similar extension
> > to the BPF preload functionality. Have I understood this correctly? If
> > so, I feel as though something like this would be a completely
> > independent stream of work, orthogonal to this BPF OOM feature, right?
> > Or, is that you'd like this new auto-loading capability completed as a
> > hard prerequisite before pulling in the BPF OOM feature?
> 
> It's not a hard prerequisite, but it has to be thought through.
> bpf side is ready today. bpf preload is an example of it.
> The oom side needs to design an interface to do it.
> sysctl to enable builtin bpf-oom policy is probably too rigid.
> Maybe a file in cgroupfs? Writing a name of bpf-oom policy would
> trigger load and attach to that cgroup.
> Or you can plug it exactly like bpf preload:
> when bpffs is mounted all builtin bpf progs get loaded and create
> ".debug" files in bpffs.
> 
> I recall we discussed an ability to create files in bpffs from
> tracepoints. This way bpffs can replicate cgroupfs directory
> structure without user space involvement. New cgroup -> new directory
> in cgroupfs -> tracepoint -> bpf prog -> new directory in bpffs
> -> create "enable_bpf_oom.debug" file in there.
> Writing to that file we trigger bpf prog that will attach bpf-oom
> prog to that cgroup.
> Could be any combination of the above or something else,
> but needs to be designed and agreed upon.
> Otherwise, I'm afraid, we will have bpf-oom progs in selftests
> and users who want to experiment with it would need kernel source
> code, clang, etc to try it. We need to lower the barrier to use it.

OK, I see what you're saying here. I'll have a chat to Roman about
this and see what his thoughts are on it.
