Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EADA303C93
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957248; cv=none; b=pA0q/+YQc5oF+A2SAZf5ZeM0jyJ4EHnozvA5k8gt3yBtFrUs5uQsr+s6q4ZQSkxgSHoDBe8+D7uJvaq2/MTa2UEEcl9lKj/+3NUyJPCrPdbf/UnTDEAUEAd6bJTF63zlD6iJv96Hiaqbu774qsvF2oUo5X0IZroygLeQbtV34B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957248; c=relaxed/simple;
	bh=bEAXLHjrbyI+vH8X1PWS4YoNcek5dCcQ2wiQbhrv/kw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fGzELQ0moiSrNFtyL3GEH3L8TWP8KBxIkpTPElhTbcSFIp7tlhsXMN9z4Ejkc8lJLT9LT3c3uo/ogU0X5vlHchxMHgPt1V8scVW2CiG1s2dNuIahnF+6VZBYE2qH7r6lU3ViCpaY00qbBzSnfeCtWLgkGoqBy+GDeIINlB7qjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mCs0knGl; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mCs0knGl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768957243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNDZ0YcgsphnASj0dH5rPX+3ShYjNypul//o6Q7KEVc=;
	b=mCs0knGlq+qnWB2WtngosIe6rpFJBW7DsEzT3GMhNaX3ZdlG0b1fZOUNw1cm1+6PQAuhEn
	G10+ohZdoibtS+bz9jUWTWIoqvalobBuRgdNK6pVdCGUd14CDgoIkcgRxjzfUWRa7thm8/
	VkpmvX2Ks10S7Cf/62STJQUatOrcFxY=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Andrii
 Nakryiko <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,
  Yonghong Song <yonghong.song@linux.dev>,  ohn Fastabend
 <john.fastabend@gmail.com>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Jiri Olsa <jolsa@kernel.org>,  Kumar
 Kartikeya Dwivedi <memxor@gmail.com>,  bpf <bpf@vger.kernel.org>
Subject: Re: Subject: [PATCH bpf-next 2/3] bpf: drop KF_ACQUIRE flag on BPF
 kfunc bpf_get_root_mem_cgroup()
In-Reply-To: <CAADnVQ+iKDvHxg_bEd6Knp3dNb9cr+FiemFSCR=NBnyt1UdYig@mail.gmail.com>
	(Alexei Starovoitov's message of "Mon, 19 Jan 2026 17:29:52 -0800")
References: <20260113083949.2502978-2-mattbobrowski@google.com>
	<87y0lyxilp.fsf@linux.dev> <aWnu-b0dlm0xZFDS@google.com>
	<CAADnVQKd-yu=bZjx+3=QKLq+26wcGJtJSrZoQh8b8ByKSPEXcQ@mail.gmail.com>
	<CAADnVQ+45MorO=pODKOEVXhpY1skVy1tPkkABPAxDJGx4vOijg@mail.gmail.com>
	<878qdx6yut.fsf@linux.dev>
	<CAADnVQ+iKDvHxg_bEd6Knp3dNb9cr+FiemFSCR=NBnyt1UdYig@mail.gmail.com>
Date: Tue, 20 Jan 2026 17:00:31 -0800
Message-ID: <877btbu6ds.fsf@linux.dev>
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

> On Fri, Jan 16, 2026 at 1:18=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
>>
>>
>> E.g. in my bpfoom case:
>>
>> SEC("struct_ops.s/handle_out_of_memory")
>> int BPF_PROG(test_out_of_memory, struct oom_control *oc, struct bpf_stru=
ct_ops_link *link)
>> {
>>         struct task_struct *task;
>>         struct mem_cgroup *root_memcg =3D oc->memcg;
>
> And you'll annotate oom_control->memcg with
> BTF_TYPE_SAFE_TRUSTED_OR_NULL ?

Yes.

>
>>         struct mem_cgroup *memcg, *victim =3D NULL;
>>         struct cgroup_subsys_state *css_pos, *css;
>>         unsigned long usage, max_usage =3D 0;
>>         unsigned long pagecache =3D 0;
>>         int ret =3D 0;
>>
>>         if (root_memcg)
>>                 root_memcg =3D bpf_get_mem_cgroup(&root_memcg->css);
>
> similar for mem_cgroup and css types ?
> or as BTF_TYPE_SAFE_RCU_OR_NULL ?

css is embedded into memcg, so in theory it doesn't require it.
also bpf_get_mem_cgroup() has acquire semantics, so in my understanding,
it can take non-trusted arguments.

>
>>         else
>>                 root_memcg =3D bpf_get_root_mem_cgroup();
>>
>>         if (!root_memcg)
>>                 return 0;
>>
>>         css =3D &root_memcg->css;
>>         if (css && css->cgroup =3D=3D link->cgroup)
>>                 goto exit;
>>
>>         bpf_rcu_read_lock();
>
> then this is a bug ? and rcu_read_lock needs to move up?

No, rcu read lock is required to protect the iterator within the for
each loop. root_memcg is protected by a bumped ref counter.

>
>>         bpf_for_each(css, css_pos, &root_memcg->css, BPF_CGROUP_ITER_DES=
CENDANTS_POST) {
>>                 if (css_pos->cgroup->nr_descendants + css_pos->cgroup->n=
r_dying_descendants)
>>                         continue;
>>
>>                 memcg =3D bpf_get_mem_cgroup(css_pos);
>>                 if (!memcg)
>>                         continue;
>>
>>                 < ... >
>>
>>                 bpf_put_mem_cgroup(memcg);
>>         }
>>         bpf_rcu_read_unlock();
>>
>>         < ... >
>>
>>         bpf_put_mem_cgroup(victim);
>> exit:
>>         bpf_put_mem_cgroup(root_memcg);
>
> Fair enough.
> Looks like quite a few pieces are still missing for this to work end-to-e=
nd,
> but, sure, let's revert back to acquire semantics.

It's close, I hope to send out v3 in few days.
I was rebasing to the latest bpf-next and then noticed that the test is
not working anymore because of this change.

>
> Matt,
> please come with a way to fix a selftest. Introduce test kfunc or
> something.

Thanks!
