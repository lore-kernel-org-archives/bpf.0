Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D61B78F3
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770005200; cv=none; b=FNMBayTvhJvYTifqzzZgcCeiV7RVhS8zbW9kMOQYf0TA3t0y4rifIl3TxWRPDGFBEqnYlUz4beVi/tdRqt+ShosYSqk2A4L3t3Izgzo6pbGXQBXa7VZ9EtwBtB9VewAPhVzCjlWLZdfPLHl1MyXpAOVNRdoMeEns/A7Q110sGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770005200; c=relaxed/simple;
	bh=6ZOsJLFF/K4OUe0FvDNHIlVC+p0N7PXMZnb+q4i6yqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwguQ34bX04GDaGO02SDHpsrK4bIB5/UzadULchXuYBg6pv1MC/EQZOZyWw1TCsNQuemRzxmjEx+ES4Xp87GVerXeY8Cz0G8akqADytIMvDKneB5fip5sIqRcjwbAq1RDOgb02nLMdxWoxohIXviLWDwDH40YWsJYQoWy7G1JV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hvQw6McV; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvQw6McV"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso5931250a12.2
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 20:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770005197; x=1770609997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NDqFnN3Ud68GoysowUDYBirFmO+BcmQLVFrXirUD0A=;
        b=hvQw6McV/sr56BtqLq+t77mp+b9Z0N7CeIx5HxxrBSjSra9m79kSq3Md/cZ8+0VRwb
         QUwhGQ/9S4pbn5rc2AOXBCOFpQ6IV4ZlC597LWvIkr4TNH6PtfHquuijtR3rdGDHhUJf
         Tg11FXJXdbBmu3XNO5SeeUip+bpPumNPBerZBqDBIj/2rOTgAqxCKWMPSy8GOHllRb7x
         hqRXvUVPE3BYK+SpRAzvfrWwPYmFzpV5ePLuwW8hQGNKcyl9c2+N3oZR++X2cR3tzuXL
         pxk5i01FR7FkVNk/oft35Eu6EWynrcpANJDit/sZ1hbq1BtgGRFml/WWISXsfXayAvMK
         lHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770005197; x=1770609997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NDqFnN3Ud68GoysowUDYBirFmO+BcmQLVFrXirUD0A=;
        b=aaSW4OBA+k7A8qj0M8BZaFPuwb+WYIr2ePYYbPb5AFIn2Brieb/R95z23s6rmFSw+F
         1apO6jzspp8UgNLC3n6ipAXxgpWWAkWO6lsMdeWXLmg/0F6hQE3/R0TjlzDeQR1KsCca
         x88B2iYwu5as3T3+drT6EBSpARY5Al517wKPPZPVPaTddURkiSfBQzDUTUdLcr0gc5tF
         YANNjllQyMfOy7mDofRzcC2Fww97KbxPvzmsq7GCiYKW8OKuHiM7T3Z0YDLuDKIbGkRu
         k57eZqZ53iPSIPFnJE99L3P5i1xwEx1ifGioIglvhE5f56mPDVeWxfKUvo85yDezdpiE
         RFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0IYSzSQgRzkWmWkJcrhH4E8GlNPCGGrAi72DqXPjKLBVRqQWD8Hjsw7Wyr+gGSPzG5AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPx4btOb6vRr7gWayEY0oDGVsDPk95YjaTnK29k6M3mNaUUF1s
	/yPg9oGPRKPT+g4eD+JUcXxWBNxrf/xOUHlbFjl2tp9KtdUtLWtFfZ0GdGYwwG5k3vu+M6YtRMn
	9YQTjxA==
X-Gm-Gg: AZuq6aKQ8BmBuWDCMJdH+idqU7mt/yd0I/YLKJUlqM0WMBKGKi4vgbcZfQbp+N2CvNU
	2yZe8EYOhfJ4RwiSGVVgo98J4XOh1b1M8mJaUweRyLPBFN1SXeKE/biEQpxFn5vYho/sX4anJi+
	a1mrLPicTAxZ/7rYes7PIrLI+6dGU5YOMK4Bm7lDCucAmmJR0LiqXtR1hZVAAiGfjtDtkmmngwz
	LJveI1QNjkqetye54Mn99o/8nt3LUNIsF6r1vXwOKOUQRP6dvFxbZ6emlHejBzJJiVk9rNEHyjo
	NUWFUKFsevHGsm7mPy9qqvX33H1XAAcAdThGN62pTe2S0ed9Q0rZfxW/3h8OSe9SmePtXQE6AYC
	oQPqHbvMTx/+UIAmT9OGo1+QaDSzTyowp6TWNWuE+HBN61zUuu7YdColShGkTyH4+dJvoRKmdFU
	BeiZoEN4Ag6MUdwogdsH+T6GZKTGFgCphAfBqpeB7/pT8d5+zsDEcMEf6NCvnHiw==
X-Received: by 2002:a17:907:9814:b0:b87:1590:d528 with SMTP id a640c23a62f3a-b8dff7225cemr576539466b.40.1770005196652;
        Sun, 01 Feb 2026 20:06:36 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf184e5dsm822058166b.43.2026.02.01.20.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 20:06:35 -0800 (PST)
Date: Mon, 2 Feb 2026 04:06:32 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 07/17] mm: introduce BPF OOM struct ops
Message-ID: <aYAiyKE-LWjQG3Se@google.com>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-8-roman.gushchin@linux.dev>
 <aXiHok-3SKqLncCf@tiehlicka>
 <7ia4tsw6hi93.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ia4tsw6hi93.fsf@castle.c.googlers.com>

On Tue, Jan 27, 2026 at 09:12:56PM +0000, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 26-01-26 18:44:10, Roman Gushchin wrote:
> >> Introduce a bpf struct ops for implementing custom OOM handling
> >> policies.
> >> 
> >> It's possible to load one bpf_oom_ops for the system and one
> >> bpf_oom_ops for every memory cgroup. In case of a memcg OOM, the
> >> cgroup tree is traversed from the OOM'ing memcg up to the root and
> >> corresponding BPF OOM handlers are executed until some memory is
> >> freed. If no memory is freed, the kernel OOM killer is invoked.
> >> 
> >> The struct ops provides the bpf_handle_out_of_memory() callback,
> >> which expected to return 1 if it was able to free some memory and 0
> >> otherwise. If 1 is returned, the kernel also checks the bpf_memory_freed
> >> field of the oom_control structure, which is expected to be set by
> >> kfuncs suitable for releasing memory (which will be introduced later
> >> in the patch series). If both are set, OOM is considered handled,
> >> otherwise the next OOM handler in the chain is executed: e.g. BPF OOM
> >> attached to the parent cgroup or the kernel OOM killer.
> >
> > I still find this dual reporting a bit confusing. I can see your
> > intention in having a pre-defined "releasers" of the memory to trust BPF
> > handlers more but they do have access to oc->bpf_memory_freed so they
> > can manipulate it. Therefore an additional level of protection is rather
> > weak.
> 
> No, they can't. They have only a read-only access.
> 
> > It is also not really clear to me how this works while there is OOM
> > victim on the way out. (i.e. tsk_is_oom_victim() -> abort case). This
> > will result in no killing therefore no bpf_memory_freed, right? Handler
> > itself should consider its work done. How exactly is this handled.
> 
> It's a good question, I see your point...
> Basically we want to give a handler an option to exit with "I promise,
> some memory will be freed soon" without doing anything destructive.
> But keeping it save at the same time.
> 
> I don't have a perfect answer out of my head, maybe some sort of a
> rate-limiter/counter might work? E.g. a handler can promise this N times
> before the kernel kicks in? Any ideas?
> 
> > Also is there any way to handle the oom by increasing the memcg limit?
> > I do not see a callback for that.
> 
> There is no kfunc yet, but it's a good idea (which we accidentally
> discussed few days ago). I'll implement it.

Yes, please, this is something that I had mentioned to you the other
day too. With this kind of BPF kfunc, we'll basically be able to
handle memcg scoped OOM events inline without necessarily being forced
to kill off anything.
