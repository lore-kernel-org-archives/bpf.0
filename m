Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27D3451CF
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626444; cv=pass; b=RkbknkluMFpDMCXTLZxfQjw8qgDSK+ZVzdl/OT7nKZCHkcC9Zd8eMvUP56XGOnyGg2ndBJiNJmMFbgCMZ9gm/6AF3VJC7vI4AxlHzy3spi4o8t+BZg3tIJS+Lgi+2zYnGn1wjkKi1sFlDd+8lgWRZjv6aGdasyhpHHmZBQZy+xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626444; c=relaxed/simple;
	bh=LDXvP5WKDhQN8oAnNb90witoZNuPCkybcm+/Z1oKNmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWX68/fzJJMGDrpc9kh7eDeE3zVrvYemadxXzbiovknvgiinmfhJAufoez/9R6MDIqmhmeYLMe1pbNBarH2fGM39bX/bU8hQou88/xS5jjuIxFWdzQuaj9WKtWMjAi+aR/eEA42Kkt1quLkv685IEmfr4ANvngkb1MaLVpxf/YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDeY7lRu; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDeY7lRu"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4327790c4e9so124815f8f.2
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 10:54:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769626442; cv=none;
        d=google.com; s=arc-20240605;
        b=fwnH9jbN+F82mTCAIx3PBY6zrpPI+gE9zIC7GfjvqnoqvB+jKgybn7W7vhJGBLWGRh
         wRlmMzCGc03/DQd58yyjdESsHqY2uhggwkUJ2Ws69mTTGeGt9Tpl+wm2pWLr6NW6JOAZ
         jZCmoyyC0AFn8vrVE8U2XrHsIvJZPnBzGqsCNzOXUv/5leBvV6a+6vSxcKWRBTkpLm7w
         pM/BBYxTu2Cv550tWWPfXUrH5ys8riHskDBrPV4ojFxjHo8b65s9M2yfyyMg9sLydvcL
         ASGPYjXjK1Dk1MrUCIrmCJqSnnHcEoHrEYbXN5/7DDSqYU/Kk/Gt1CBhvB93fhangtij
         IqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LDXvP5WKDhQN8oAnNb90witoZNuPCkybcm+/Z1oKNmM=;
        fh=BlB/3jAKGjYOnONIekUkuduvPtp9jfh3tTdmipkTu3Y=;
        b=VYoX9gs/jXOoU29hBQvlvyV4c+5qz6s8YrqNv4EwKnUX8rYuEyOVPMJ9iVOeeNIduM
         ijdYlNxW4QLKeyiVw1fgpdH3mN92Cnd9gA+qYWJ5tb6jI0igipJqkQqN7twD022k/7+T
         ms3NQcordSOxVHy4kysSg+Yals5clnIjkqI+dWGTof2nbGW4RdY5CrdPJe0I5C5cwEJ3
         JxDY7/vkTH4clJ6iGKGniDoyuVTPIq6avEFpPu0wRNT2AyzNXdJZf3J3aa3xesF3xSu4
         TeTc0NkqEw4F7tU06saVbKlOk7LvJqRYEtODZOohM34PtU+3re3xzKyG0LxEl+hDsb0N
         gqEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769626442; x=1770231242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDXvP5WKDhQN8oAnNb90witoZNuPCkybcm+/Z1oKNmM=;
        b=PDeY7lRuPxbzMj54KzpI1j5F+gWSa/pm751Zl9BLbpreNpqLzGjVp2ONEXsEdXGcNW
         N9aSFW4NLtPeeXmYm0WW5wlddAYJapfjs+zMU6x45l8gEHlzmz4bvIu/DDNu1TV2x54N
         O1vEKgH4AJRPzT0Vq5gQ7YqPM+cIwYvauH5f7JFSN3YpUuEmt3eA0FM7J0T/aiRLdOUt
         +cEvUD/pwDp3bToAg1XudX1oO6wrNilMWD+cQN4K9WBvX3ZEYaw/MTdMmnop6DnEuStj
         ovQkg1rWX0Y9Wx6NUX7pLnV+9t5YzpSsQLPqSIBydNakUmaymKe7SqyHYz5VxZAduatl
         Qzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626442; x=1770231242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LDXvP5WKDhQN8oAnNb90witoZNuPCkybcm+/Z1oKNmM=;
        b=NXo4KennmL5mUwgkCRrMAZARRjz9T2tPvqjGgPkz0x09CZOfEPBtWMK+rT6bSvNeMZ
         +MJOIpXX5dTLNYIgLDy9VfZnTZy4muOYVa3rUQ5rHie75StHHQpT7EcTFn7Sp0z+Ibjx
         WMyko3Ht7E02gAuhjm0ndsR7Jxehiqx3zGk3YQtts1oLGkjSwj9aBVTK9i9IlphOZ1W1
         +AXPrjhwfzoBPgJRO25JHttq/zm3iGZI8GJgqeZGyWygv+B6pZ8LdXb4aEU+jmyJNw91
         0QbxqgIhrRz4ttb6oLCus/FU+dO4YJ8d798DOyG4dp0M5g7OA3cBrfcPQ9tZUP7exqdi
         WOFw==
X-Forwarded-Encrypted: i=1; AJvYcCUipoPGB7vmC0n2omYVuT98IaHR3dfae0hu4YU82yxi0/fG699tWCN5KjIjHZp5iy/wlZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyawIUmimSHzXMJEFXJbDGQZESz8gOM3Aa0QNK3Xxf8lGwO7jGI
	negxXcDlz08J46XBw3E1ZMf8JDtHB+QRemNG/ftSMgbVEALR2DL1JSuwMnrkB6qGVwr9OSp27XW
	m3fBeXQuEHslXkKcyD8ouNGzLsw59NYI=
X-Gm-Gg: AZuq6aL1eBghWWcB59u0o/L7A83fBEMm4Qak5RrykKZnlNCOezJozGaaTOIsA6dcSWN
	bQfNcf1Yg+xsG0+fdKZblmbxiEZ9wi1rasf1z27uc19jmJl6aJr0KgSokvvsQB3KB8sLCl6V+hE
	yAF8lbb7ZtO4+COYzYk72KjGa3eRTJ5dmX9mjjfY8+1jToFj8mArBz7tbYGmm/aLbam6cSpK5pT
	UIx2t5CR6V0toepXt4zA0kBFlz0TOY/7AO+BXffBCV37EB4y20T8xmF8m18C7E2iQIX657hIlzF
	VWFgeEiJ4x+HM4QQCP+H8XvaDL+fEdp05xAhyOtIiozPj3CN6Yqy6oKk8g4/Kz8OkBgHIjKVzW1
	XJkuTd4LLZy8fCg==
X-Received: by 2002:a05:6000:4023:b0:431:a33:d87c with SMTP id
 ffacd0b85a97d-435dd02da7dmr9821021f8f.11.1769626441887; Wed, 28 Jan 2026
 10:54:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <aXh_LpTzDhvv20uB@tiehlicka> <7ia44io6kbwj.fsf@castle.c.googlers.com>
 <aXnDdkYmtipGwSjK@tiehlicka> <CAADnVQ+ghTc5FtJCjm4ya3y3xVpSuJe-7ctdT-thowqWguc1pA@mail.gmail.com>
 <87zf5x1tqx.fsf@linux.dev>
In-Reply-To: <87zf5x1tqx.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Jan 2026 10:53:50 -0800
X-Gm-Features: AZwV_Qht682-qa0CwwhMy_omOTG7GEYdXbcd_NxkHoacsbR6UpkvnSNThpQfUGk
Message-ID: <CAADnVQ+vQFndDdgDBwLSRcdqrsyE_gU1Wx7STy0Qa=6MFnHSHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/17] mm: BPF OOM
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 10:23=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Wed, Jan 28, 2026 at 12:06=E2=80=AFAM Michal Hocko <mhocko@suse.com>=
 wrote:
> >>
> >>
> >> > Another viable idea (also suggested by Andrew Morton) is to develop
> >> > a production ready memcg-aware OOM killer in BPF, put the source cod=
e
> >> > into the kernel tree and make it loadable by default (obviously unde=
r a
> >> > config option). Myself or one of my colleagues will try to explore i=
t a
> >> > bit later: the tricky part is this by-default loading because there =
are
> >> > no existing precedents.
> >>
> >> It certainly makes sense to have trusted implementation of a commonly
> >> requested oom policy that we couldn't implement due to specific nature
> >> that doesn't really apply to many users. And have that in the tree. I =
am
> >> not thrilled about auto-loading because this could be easily done by a
> >> simple tooling.
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
>
> In my case it's not about hiding, it's a chicken and egg problem:
> the upstream first model contradicts with the idea to include the
> production results into the patchset. In other words, I want to settle
> down the interface before shipping something to prod.
>
> I guess the compromise here is to initially include a bpf oom policy
> inspired by what systemd-oomd does and what is proven to work for a
> broad range of users.

Works for me.

> Policies suited for large datacenters can be
> added later, but also their generic usefulness might be limited by the
> need of proprietary userspace orchestration engines.

Agree. That's the flexibility part that makes the whole thing worth
while and the reason to do such oom policy as bpf progs.
But something tangible and useful needs to be there from day one.
systmed-oomd-like sounds very reasonable.
