Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB03BBFCF
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789536558; cv=pass; b=BWd+DrQ5LXB+PDVnPYfxeKkJX2LjNqpwJZGu/1NoZtI5T7fBc80BlOqQn/Ews+w7rcrB/KYsW9iGdBq8eBHfVcA9fZIej2H3I3Wu7pESsh1MqAlJKoqls+DGLfS2NzpMegxp5+cJHlVtid9Xb7m84DuLhu50kRXGLefXV4Kjpgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789536558; c=relaxed/simple;
	bh=CXv4XcVzsFki/2eiawzhWx6Ex2lOhlOoQIZQNxAZHec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzpPkfpVgYxsKMppgB8NUfJhtriefOj6lxL1ucs9SABEul3n4sIA9jyv9UvmO+0f5PmAXEzhKTJwcGnZFn5Qb6WDJt2bKjshTUnxozDKk4zgbwLYWE1FGRFmNgZ4YgIlDlAm0+xdJdhuwrQkXCSvOMvyjuEeek/s3c1OQjbKlMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyN5NhzI; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyN5NhzI"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso493037a12.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789536557; cv=none;
        d=google.com; s=arc-20260327;
        b=RpuPlkqkajP6uNWpy0s2fU3Y3qGxyROG8uQhHIPwurDwzynlwRJTyJBwXiVrgkfKfN
         D0/dPLq+RstrB8wLCRrGn6dbSyGMq4K/IOREe1xMw79S081C15+FB/0a7gmuXzzUGKYS
         iNjHXisF85CMnMobUJBk/yiMTHGnpgJYF0ucoND7ijSOEjuybVNne0ip2ReGeRtC/hg5
         Ky/no6cRbUtatzF+GTz92shRkvxYjEVSpB9dpon000REb2TYiLzbizl6LO8gILECJcLP
         2zVJC+E5LTUqyms4Yi9+k3gGYO6kJ1CjBapsBFOHCXa0RRI83GA7kpWzltO0dKy4Hvrw
         9TDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CXv4XcVzsFki/2eiawzhWx6Ex2lOhlOoQIZQNxAZHec=;
        fh=R7m9NwWR6+Ds1Pnpi2xApk4HzRxmU9ezeAgGOFvEaQ0=;
        b=hpSBO+tK5WqgoIFE30psYhjmotTq0+ADeSZC7KwTUKZ5HPhFvWXlR5fwkuMWR5LM+v
         lW69TGt3IXBMfpJxh7MAGN8GLgDG21PGRMA+GfG9QxwbMBl28qICYS9ZyU0+gpoZXonG
         iROhA4jxvPJdTEwyYLNc616nvhnPahqRDuIifVuIdzcsmuFdKv3IwcKvT45MPsgO6chb
         f5KPZT3VZ+G5sGhRkmAFW6bhuhQzY31UmFJOfF1r/KbhN+m/RwjQYnaZz/f7CE6U1Vgy
         ZZOAtkyRYYPQnRFmqA3B2r9bRD9XkQ8nI1MaS6LB523CLPqeJtf9VlFgI1tDCB0PfNAz
         zdDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789536557; x=1790141357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CXv4XcVzsFki/2eiawzhWx6Ex2lOhlOoQIZQNxAZHec=;
        b=MyN5NhzITYCavQ1T64wVj6Hn4LpAWgTdVfgT0VkjwGx/hMhzPvVUaJ7/1fMyz4bkyS
         zNn+GhCv9F+TVFgUMDI4V1nb2nd4zkwEiMztVH9xTEBTTohCp/cdkbo8t/ANyIVO/w9y
         tDA8hRBf1spX3qbJf2dXvyLAReb0/KAIE8LX2ok2MCcUAft+USJn65aUkrFM4RPJlZR8
         Q0R2l11zH8ZEn1UwygfgsfUSrkn87CaiT7YemsRRZxUprAHty4YrPuDff+iCINr9+Otz
         VUJkifXIPao82fh1avU5D4RLCKV+O1gpD6NOUoaVJmylDtgSyE+UaboBKD10mM1QDAUC
         vmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789536557; x=1790141357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXv4XcVzsFki/2eiawzhWx6Ex2lOhlOoQIZQNxAZHec=;
        b=U7FXiQoKM7YxMN5uW508zSfFpopa978anTZ2qsNW3ZMBhe+Ed+79T7RLBc6YS1gi9+
         kLKEAJKVqFhtdOvewfto4INsJdl28EqUENquLkiLeLsIonQLbd0ZeAgEv41D1nUTUi9c
         AGUfEF7p9lCwazD2QjYRgy91ifdc6Oi1dq4qzelSWh9CiLizR+qTb245zkW1ugT0SHLZ
         7ufIFdSi27tM6U/NWlfRy/3LucK4hcVBgOvGA1fIDEKcGT7rKSFujszfSNsPpDvlb+hT
         ZbFuobmgifuMPxj0A+eBPOMDGdiL9+y3ClxF9eM4YE7Gv7BB/YgD23n+3vAGQq2uSj6E
         zL6g==
X-Gm-Message-State: AFuF++mva27T+Zd5B+3EqQX8jYV0LdY2hLghw1dfQUdx8Y95/N4t5/0P
	9BrMoaYfwhv/KEnlElaMHuW+Y2etUr4v/NUlcs7qwOuQvfN+MbLQM/606TURKrvCX6G7JecxQYc
	4So/uSivrM9RkBOYGxupMsGKbfqdhzCU=
X-Gm-Gg: AYBFou335eWQtszBdHgIlVIEZr4FrNI1vilssOkp/Rftnf3CZ5KNRdz2UualPI6TgUk
	K1reZnNIOlhHUWsUo1JUIZ/sTjpWC9IBxYxLKHyILZTZiv8T0+JCiokXsfidUY6DW5Ib3VQqomm
	jq3yaj+aTfrOGeEAmfxD1Txlb9VVWbVKpROwXaMqXhRkiP+JRC0Cwen7miD48lWldv7kXEmybmG
	nyr8CwDmVfD7+z4i2awuE1QXdqv8MOvBvWAUxfd/jahgTCMyyQZSWF+kCjzpHE7Odmsy0F5xTTG
	x3aBwY2zKkbfD92XbcV6ImT5DMQaCLquB/UEbDS5IDVvAIMOV27KJEYHSAUofTJHl3tYLBz45cO
	+l99uWBBK6GeCkY8+5aVCpaoTJsq9qDaMR/KERFo=
X-Received: by 2002:a05:6a20:7d9d:b0:3d3:adad:f172 with SMTP id
 adf61e73a8af0-3dd5f72bc69mr3018415637.20.1789536556549; Tue, 15 Sep 2026
 22:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912095924.866254-1-florent.revest@linux.dev>
 <20260912095924.866254-2-florent.revest@linux.dev> <DLDHKKLCOAVR.3PHQ832S121Q2@gmail.com>
 <DLG3Y32QQ9JU.3LNSYXLJIGH17@linux.dev>
In-Reply-To: <DLG3Y32QQ9JU.3LNSYXLJIGH17@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Sep 2026 22:29:05 -0700
X-Gm-Features: AcwNN1VApFqHfiZtUBpFi7XpRtICUs_9AuNRI0X7lGIQvOJrfcWs4IpoTgHfoXA
Message-ID: <CAADnVQL=sW1-UOUbP_j98G2eY4MPzQd=HbP-7q5-sjqFQya=Rw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Skip detached progs in trampoline images
 that are still in use
To: Florent Revest <florent.revest@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Leon Hwang <leon.hwang@linux.dev>, Junseo Lim <zirajs7@gmail.com>, 
	Sechang Lim <rhkrqnwk98@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>, 
	Naveen N Rao <naveen@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Hengqi Chen <hengqi.chen@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 11:39=E2=80=AFAM Florent Revest
<florent.revest@linux.dev> wrote:
>
>
> Ah yeah, I tried to address that in the cover letter. Basically, if we pa=
tch
> all the nops, tasks running in the old image could skip some progs that a=
re
> still attached. For fexit, that's already what happens with ip_after_call=
 but
> for fmod_ret it would be new and this would cause for example an LSM prog=
's
> verdict to get skipped when another prog gets attached to the same hook. =
That's
> why I thought that patching only the detached prog's nop would be better =
and
> needed these extra pointers. But it's a bit of an edge case and I don't h=
ave a
> strong opinion on it.

Hmm. Not sure I agree with your reasoning.
fmod_ret progs are called _before_ orig_call.
So fentry+fmod_ret are in the same category.
Adding/removing a prog to the trampoline causes regeneration
of the trampoline.
So cpus may execute different numbers of progs already.
The race is inevitable.
With 'patch all nops in old tramp' approach the only
additional race is some of the fentry/fmod_ret progs
will get skipped in old tramp.

If the concern of a tiny window where old tramp is started
to be destroyed, then fentry prog is called and we patched
another fentry, but tramp will continue and execute orig_call,
then, yes, I see the issue, but it's a lot more subtle.
If I understood the concern correctly then let's add
another 'jump over the call' nop in addition to
'patch nops in front of all progs' and
let's patch 'jump over the call' _first_.
This way fentry/fmod_ret progs can never miss
execution of orig_call. They can be invoked "unncessarily".
They may execute though orig_call will not fire.
but that's an acceptable race. Better than not executing
fmod_ret while letting orig_call to go through.

This is still simpler implementation than link-list all all extra book keep=
ing.
