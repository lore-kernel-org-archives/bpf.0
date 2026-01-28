Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E3116DC28
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769624636; cv=none; b=cj20VoQcbppHE7jygs+yvNhjnW4A8qdDQkk9d1m3Apgu6VOMEpKCyfRsUG2ubfC6S4Hebs5E2QbDoW2rlvI/F5Vb/+z09S/XkbfZImP8UzHHYDSQclRtmYy6AiBU2atP7OeHhr6Mj3VNdSPp6mwd1yGb7yooNl8aT6lPRFTnKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769624636; c=relaxed/simple;
	bh=Dks1n+tLn9aMw/JnuP0H2rQMs66fm3ChmT9gGdwBgv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VKr3KA+tC4h6vf6NiLTx2URvbAuogIdRzAvqtEtS69bNv4eJj4SVj3FnIBtWqpK11j9QThnjQDYigZMvHCsmLB/40gSym/xQ9vXdik6WBc38g8XeyZ/1qamuYE+y4TW6tlebO8Bq+qC6DVvZLtyObRMRmlR/PJUFU2j2Hed2XKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T/TKcIBB; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T/TKcIBB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769624622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dks1n+tLn9aMw/JnuP0H2rQMs66fm3ChmT9gGdwBgv8=;
	b=T/TKcIBBphm5L5F1YLVql/At3jjPNegsOzmM1WMurTi7yjSmsV2Y9xwPoMRDFqjcOfKsRh
	8AiAMlGX1VQVdl5A3uXFHwubzIUTIs7jIhK4tkO+fjPvOGixtvzt82coITpwonDzRMOJ15
	/fSTu/hou6lTRkk6Om9Cv9fjNhEMbWI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>,  bpf <bpf@vger.kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Matt Bobrowski <mattbobrowski@google.com>,
  Shakeel Butt <shakeel.butt@linux.dev>,  JP Kobryn
 <inwardvessel@gmail.com>,  LKML <linux-kernel@vger.kernel.org>,  linux-mm
 <linux-mm@kvack.org>,  Suren Baghdasaryan <surenb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 00/17] mm: BPF OOM
In-Reply-To: <CAADnVQ+ghTc5FtJCjm4ya3y3xVpSuJe-7ctdT-thowqWguc1pA@mail.gmail.com>
	(Alexei Starovoitov's message of "Wed, 28 Jan 2026 08:59:34 -0800")
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
	<aXh_LpTzDhvv20uB@tiehlicka> <7ia44io6kbwj.fsf@castle.c.googlers.com>
	<aXnDdkYmtipGwSjK@tiehlicka>
	<CAADnVQ+ghTc5FtJCjm4ya3y3xVpSuJe-7ctdT-thowqWguc1pA@mail.gmail.com>
Date: Wed, 28 Jan 2026 10:23:34 -0800
Message-ID: <87zf5x1tqx.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Jan 28, 2026 at 12:06=E2=80=AFAM Michal Hocko <mhocko@suse.com> w=
rote:
>>
>>
>> > Another viable idea (also suggested by Andrew Morton) is to develop
>> > a production ready memcg-aware OOM killer in BPF, put the source code
>> > into the kernel tree and make it loadable by default (obviously under a
>> > config option). Myself or one of my colleagues will try to explore it a
>> > bit later: the tricky part is this by-default loading because there are
>> > no existing precedents.
>>
>> It certainly makes sense to have trusted implementation of a commonly
>> requested oom policy that we couldn't implement due to specific nature
>> that doesn't really apply to many users. And have that in the tree. I am
>> not thrilled about auto-loading because this could be easily done by a
>> simple tooling.
>
> Production ready bpf-oom program(s) must be part of this set.
> We've seen enough attempts to add bpf st_ops in various parts of
> the kernel without providing realistic bpf progs that will drive
> those hooks. It's great to have flexibility and people need
> to have a freedom to develop their own bpf-oom policy, but
> the author of the patch set who's advocating for the new
> bpf hooks must provide their real production progs and
> share their real use case with the community.
> It's not cool to hide it.

In my case it's not about hiding, it's a chicken and egg problem:
the upstream first model contradicts with the idea to include the
production results into the patchset. In other words, I want to settle
down the interface before shipping something to prod.

I guess the compromise here is to initially include a bpf oom policy
inspired by what systemd-oomd does and what is proven to work for a
broad range of users. Policies suited for large datacenters can be
added later, but also their generic usefulness might be limited by the
need of proprietary userspace orchestration engines.

> In that sense enabling auto-loading without requiring an end user
> to install the toolchain and build bpf programs/rust/whatnot
> is necessary too.
> bpf-oom can be a self contained part of vmlinux binary.
> We already have a mechanism to do that.
> This way the end user doesn't need to be a bpf expert, doesn't need
> to install clang, build the tools, etc.
> They can just enable fancy new bpf-oom policy and see whether
> it's helping their apps or not while knowing nothing about bpf.

Fully agree here. Will implement in v4.

Thanks!
