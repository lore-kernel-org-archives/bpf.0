Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4608333434
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626336; cv=none; b=uva0fEc2FDWi/1rfMM9q0cE84hENHl3tFDK6ITbaKZix5VTRg+4tBTERndtVVaanYyfLIlocunIyyjci4+j+HGsyDeMdNXXJSZtuwtxFxwdNjN5CY1Xf8Tcp8pe4l7yTo9Ja14Zdm2LIk5i+ouvVba/r+9xOIQmG0gOE+lQP1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626336; c=relaxed/simple;
	bh=gnq4lmI/pJy7C8NYpS6772PW/VU+c7UmjMnkzqpVUO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OeL9kHgBqVrMVym/lR9GLa7IQmQ2s3KOc0gNxWxRbo98yUe7QR2jjgPv5XOLRQvKJjooD11Fkgta+1dgoP6q0lSOC4cEiAHfXUKVvgGUP7ulFTto/3hZflvdzr1Bqs2WPf3QcFvDegEQ3a8XjE18pCSrxXPcFVinMpxwcJ4XKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ty4s7Yoo; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ty4s7Yoo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769626331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CfgweDiPW3wgT8f/jWDWaNU2yLUPwXceZe08po6uplY=;
	b=ty4s7YoohM67YP8T9nnixgYuzM2FfMNOijhQULCX0p68d1BLFELww25talGKOrg3n9J0dB
	wEZxDRBMN+5Hew/a8UYrJPkcKADMy5vRbbgfurnAeqg6w479aYDM9rMJx1Qs6I9AEkfOjN
	luA28aNrV3DSup1lweSqg9XprkhkqxY=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Josh Don <joshdon@google.com>
Cc: bpf@vger.kernel.org,  Michal Hocko <mhocko@suse.com>,  Alexei
 Starovoitov <ast@kernel.org>,  Matt Bobrowski <mattbobrowski@google.com>,
  Shakeel Butt <shakeel.butt@linux.dev>,  JP Kobryn
 <inwardvessel@gmail.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Suren Baghdasaryan <surenb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 02/17] bpf: allow attaching struct_ops to
 cgroups
In-Reply-To: <CABk29NvS+4F-a=Z7Jp27OUZCJ2YUWR3LJcwT-NBoWYAK8JeCEg@mail.gmail.com>
	(Josh Don's message of "Tue, 27 Jan 2026 19:10:35 -0800")
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
	<20260127024421.494929-3-roman.gushchin@linux.dev>
	<CABk29NvS+4F-a=Z7Jp27OUZCJ2YUWR3LJcwT-NBoWYAK8JeCEg@mail.gmail.com>
Date: Wed, 28 Jan 2026 10:52:05 -0800
Message-ID: <87a4xx1sfe.fsf@linux.dev>
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

> Hi Roman,
>
> On Mon, Jan 26, 2026 at 6:50=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
>>
>> Introduce an ability to attach bpf struct_ops'es to cgroups.
>>
> [snip]
>>  struct bpf_struct_ops_value {
>>         struct bpf_struct_ops_common_value common;
>> @@ -1220,6 +1222,10 @@ static void bpf_struct_ops_map_link_dealloc(struc=
t bpf_link *link)
>>                 st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data,=
 link);
>>                 bpf_map_put(&st_map->map);
>>         }
>> +
>> +       if (st_link->cgroup)
>> +               cgroup_bpf_detach_struct_ops(st_link->cgroup, st_link);
>> +

Hi Josh!

>
> I was worried about concurrency with cgroup ops until I saw
> cgroup_bpf_detach_struct_ops() takes cgroup_lock() internally (since
> you take it inline sometimes below I falsely assumed it wasn't
> present). In any case, I'm wondering why you need to pass in the
> cgroup pointer to cgroup_bpf_detach_struct_ops() at all, rather than
> just the link?

Sure, good point.

>> @@ -1357,8 +1386,12 @@ int bpf_struct_ops_link_create(union bpf_attr *at=
tr)
>>         struct bpf_link_primer link_primer;
>>         struct bpf_struct_ops_map *st_map;
>>         struct bpf_map *map;
>> +       struct cgroup *cgrp;
>>         int err;
>>
>> +       if (attr->link_create.flags & ~BPF_F_CGROUP_FD)
>> +               return -EINVAL;
>> +
>>         map =3D bpf_map_get(attr->link_create.map_fd);
>>         if (IS_ERR(map))
>>                 return PTR_ERR(map);
>> @@ -1378,11 +1411,26 @@ int bpf_struct_ops_link_create(union bpf_attr *a=
ttr)
>>         bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct=
_ops_map_lops, NULL,
>>                       attr->link_create.attach_type);
>>
>> +       init_waitqueue_head(&link->wait_hup);
>> +
>> +       if (attr->link_create.flags & BPF_F_CGROUP_FD) {
>> +               cgrp =3D cgroup_get_from_fd(attr->link_create.target_fd);
>> +               if (IS_ERR(cgrp)) {
>> +                       err =3D PTR_ERR(cgrp);
>> +                       goto err_out;
>> +               }
>> +               link->cgroup =3D cgrp;
>> +               err =3D cgroup_bpf_attach_struct_ops(cgrp, link);
>
> We have to be careful at this point. cgroup release could now occur
> concurrently which would clear link->cgroup. Maybe worth a comment
> here since this is a bit subtle.

Agree, will add.

Thanks!
