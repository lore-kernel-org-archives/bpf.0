Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0337107C
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769627008; cv=none; b=aqaLvhV9zRp8Ibd88LoXuKz+I2R2FWOYQELVQ8xQ1o0Kk0oDz7U0VW86lYaE0ZT4OKzAkNREq5S5XyEFx8Szj0btrcAYnsEfaWnrsItEWAK6o2LUqiyb9gMu+1PvKsVgux2Wv5MnlI/oEwsXCgp4bpGL+G4Ib0S7GtJX3pADHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769627008; c=relaxed/simple;
	bh=k4fj+zI7nQkJZQ6PE8/AEWq1DD9fwwCHAdD0i/dHo2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eSbewYlA8RnwOVkR0ZtYiUlOYImN0cJIAiQ6OzKUTW+3Z6mu0/wTvJr+K131SMn/2ZbiB4H3BiCd5EImz6n55BIsCtsOEIxUKTB7IsdHvdWs7kRmAo8DpfN6t1RxhnSVwPWa1cUeW6IPKQvOF+05BldVWOSaFRkFmShb5ICQiS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C6gp1MPX; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C6gp1MPX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769627002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4NayTqK6ydu31eZz8Rz8GMezBVcxg1OL2qPKc9sxAYY=;
	b=C6gp1MPXOXBOyUaULt7xIiQQq9atvXBscBI7+zuY5sWgavBkmdnsEqBxaDsObhlyHb83Lf
	WinP/QWVMuQOC2Gl36aiP7atmDPAthGEuudtxX54DkJ1OB0wSE3drjvs9kgjhEzT7Sk6tE
	o2iKyHxpcm3KJzQ6GnzUspUbQXcBdT8=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Josh Don <joshdon@google.com>
Cc: bpf@vger.kernel.org,  Michal Hocko <mhocko@suse.com>,  Alexei
 Starovoitov <ast@kernel.org>,  Matt Bobrowski <mattbobrowski@google.com>,
  Shakeel Butt <shakeel.butt@linux.dev>,  JP Kobryn
 <inwardvessel@gmail.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Suren Baghdasaryan <surenb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 07/17] mm: introduce BPF OOM struct ops
In-Reply-To: <CABk29NvSku-zb5sodOYjWhW253EHGu52VNQ6+pQ8QuvEoVQYRA@mail.gmail.com>
	(Josh Don's message of "Tue, 27 Jan 2026 19:26:57 -0800")
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
	<20260127024421.494929-8-roman.gushchin@linux.dev>
	<CABk29NvSku-zb5sodOYjWhW253EHGu52VNQ6+pQ8QuvEoVQYRA@mail.gmail.com>
Date: Wed, 28 Jan 2026 11:03:16 -0800
Message-ID: <87jyx1zhjf.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Josh Don <joshdon@google.com> writes:

> Thanks Roman!
>
> On Mon, Jan 26, 2026 at 6:51=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
>>
>> Introduce a bpf struct ops for implementing custom OOM handling
>> policies.
>>
>> +bool bpf_handle_oom(struct oom_control *oc)
>> +{
>> +       struct bpf_struct_ops_link *st_link;
>> +       struct bpf_oom_ops *bpf_oom_ops;
>> +       struct mem_cgroup *memcg;
>> +       struct bpf_map *map;
>> +       int ret =3D 0;
>> +
>> +       /*
>> +        * System-wide OOMs are handled by the struct ops attached
>> +        * to the root memory cgroup
>> +        */
>> +       memcg =3D oc->memcg ? oc->memcg : root_mem_cgroup;
>> +
>> +       rcu_read_lock_trace();
>> +
>> +       /* Find the nearest bpf_oom_ops traversing the cgroup tree upwar=
ds */
>> +       for (; memcg; memcg =3D parent_mem_cgroup(memcg)) {
>> +               st_link =3D rcu_dereference_check(memcg->css.cgroup->bpf=
.bpf_oom_link,
>> +                                               rcu_read_lock_trace_held=
());
>> +               if (!st_link)
>> +                       continue;
>> +
>> +               map =3D rcu_dereference_check((st_link->map),
>> +                                           rcu_read_lock_trace_held());
>> +               if (!map)
>> +                       continue;
>> +
>> +               /* Call BPF OOM handler */
>> +               bpf_oom_ops =3D bpf_struct_ops_data(map);
>> +               ret =3D bpf_ops_handle_oom(bpf_oom_ops, st_link, oc);
>> +               if (ret && oc->bpf_memory_freed)
>> +                       break;
>> +               ret =3D 0;
>> +       }
>> +
>> +       rcu_read_unlock_trace();
>> +
>> +       return ret && oc->bpf_memory_freed;
>
> If bpf claims to have freed memory but didn't actually do so, that
> seems like something potentially worth alerting to. Perhaps something
> to add to the oom header output?

Michal pointed at a more fundamental problem: if a bpf handler performed
some actions (e.g. killed a program), how to safely allow other bpf
handlers to exit without performing redundant destructive operations?
Now it works on marking victim processes, so that subsequent kernel
oom handlers just bail out if they see a marked process.

I don't know to extend it to generic actions. E.g. we can have an atomic
counter attached to the bpf oom instance (link), we can bump it on
performing a destructive operation, but it's not clear when to clear it.

So maybe it's not worth it at all and it's better to drop this
protection mechanism altogether.

Thanks!
