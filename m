Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280942571A9
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 05:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785217848; cv=none; b=bYz8DXc7RdXLnfRMY6Gq7dWCfGM1fAYvthaS+YF+o8tqfZJgEN4kEMbGwDs5Ct+ddAwJ5wIhiVrz1RrSOvobybmwydCOpxAnqExbGD2l51ufMdmKSNaEH+YD5pu/jaHc1U9RHqUosgOplbNZRgsKLQhggAJ34n78CvlHAPn0b9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785217848; c=relaxed/simple;
	bh=smWJMje3RRC3SVX8ncpicTcnCo46n/WQf/QLH/8zO0w=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=YymME6m1S4v0OASK0BVSMnejPVO36AIJaZyTbH6jRE51sXYKVCcI9AmT6Y9Zx7AdySSgMx45mFwZwviaXymoBEP/t6hC2ALpqA+24vHlA0ebqyW+bc9iSkdRxi6uXBChtCb5vphwenUuH3RLTPYjV8MZgOvvwYxKEMzXmqMeYO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=YHVun4nm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="YHVun4nm"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cca0c5799eso32710465ad.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 22:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785217844; x=1785822644; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P+6mDwIN8vWNKXysrGGkwLYYsgdebLUaVqjddYQeHMw=;
        b=YHVun4nmouQlXirn0gPgPfhaJF6eYSRWLrqOMVD7XqQve7xfd0mfRhE+hyj1G3Be2G
         BeHMXLX0JO6NJWv8+EZ6quzl+ajOcpEIWMovvg+LDB9a9bzeVseCEbEyWhopcYPQV18V
         p4CAhXKiMw1F4yBRqC4slGevpYYPMTjk67QMIQRN78E73RsfUf+WO0/3iJnI8OYAzkpM
         pFUC3y2moPwMI2yn4L0aaG25cD9zSRPsyUHg+cAMrZFi6gWBkdopR2+EW9PDgwZvVR9p
         c0uh5IR8uIoTuPpcc0gfMRPCILEGNEOKg1Eri4WlArreiALVC5stJH8UlvDoCy1GQypP
         toCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785217844; x=1785822644;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+6mDwIN8vWNKXysrGGkwLYYsgdebLUaVqjddYQeHMw=;
        b=Ac3ooZYHmBffmgj4jbxjxfuO/swxwUTE9+zNaJUpMyEUVH2WpSb+YqJYZsUEbXRtYx
         Zz2TtSBHF6IRItuN1kHBwCQAYI6CkqmceWNCm5ENn53a9BFfJuvgII3dguQdUoMjktlY
         l9FsoAOoMUEx6gRcitl3xXq7x1fczvBXoTrcTJ8LVNsvJGtZa9aRqQDUtn+2DzNDjBag
         487REjN+VGHqYHiEtHsTaeWvijmKPEeDpButmM5CVBqmWJRVgxjvWhoNh7SbUjt3hUXb
         reO/IzSsC8/OKb6V5nbHl9B7fjIjluoergOWSORZee1vNAMJbjlMQULjlgKkKaJ2d2xf
         tCQA==
X-Forwarded-Encrypted: i=1; AHgh+Ro2I7gnpIScH0X4iYsbIs0NHkCCoG9o/okInBtN0JweLRMeFnPKMwXk4k4/ffCkAPZIQj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrFeWIW6Oy9l6AtgGibGpvL2TmzaVPmQYBB5iAi/1IweSjx9NC
	loU2fpYtV3umrlVFTdHc+V8dzHcFzKz3HCrJFGZpOSSVqwSIoTELeX5QxAjnHStura8=
X-Gm-Gg: AR+sD13pfaZYJb5jqcKgj5Ktj6zgq71dpa7qZx1SqjpZna80jPLpj0B8nYoN4PCdXDf
	4b8zxs/BxGWuFEM5oEziOQue6PM+/RTUkyyYqL11t6leWRGEIbxIB5gOrqwVN4qB6+ekNZ6X8bX
	OGTevRMNAyiEkI7rmo8Vd0ITYrPPcXbrUWUfbTWo0WlQzGEqVak60kUlSNH2TEdWeAXDLu4elE2
	tfGY+R3ajBkjgX3cMCEECd+UktGlQqVWDCG2hh7PGJ1rH5+7IqbNRZcgQ/p58XYHLAqaOpvhAhq
	bDQGCzj4bHbs8tfmXvF3el/nH7dnbKqF2+KtI/ESuoe+g5lV+/eMfvPrrDRzgpFwQ7QLq9RY+yC
	57zYYynF0brDeAkVlUgzmhgSs105fpz1Gn37KIXtWgNLtsxWSt8/nD03Q3hzdF/z36/AxSwk9sr
	luyJT06qjsv0YZ9ynjCKeaOmay5jgEOms=
X-Received: by 2002:a17:903:37c3:b0:2ca:6514:9201 with SMTP id d9443c01a7336-2d015b07cbcmr11199955ad.15.1785217844367;
        Mon, 27 Jul 2026 22:50:44 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7f4b01sm45909195ad.71.2026.07.27.22.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 22:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 01:50:42 -0400
Message-Id: <DK9YWR4YEPX7.2UGL6XEWO767Q@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Pu Lehui" <pulehui@huawei.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Pu Lehui" <pulehui@huaweicloud.com>, "Amery Hung"
 <ameryhung@gmail.com>, "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Subject: Re: [PATCH bpf v6 2/4] bpf: Fix UAF due to missing link type check
 in mprog
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260722072326.1545677-1-pulehui@huaweicloud.com>
 <20260722072326.1545677-3-pulehui@huaweicloud.com>
 <DK58NPCIRLIH.SMOILLVYTZ1Q@etsalapatis.com>
 <3c41af85-0dc2-4c84-8745-b7d37b7b37f5@huaweicloud.com>
 <02ab6310-8457-43f9-81f2-642a1e3f6e58@huawei.com>
In-Reply-To: <02ab6310-8457-43f9-81f2-642a1e3f6e58@huawei.com>

On Mon Jul 27, 2026 at 9:56 PM EDT, Pu Lehui wrote:
> Hi Emil,
>
> Gentle ping~, is that acceptable to you?

Hi Pu,

Sorry for the late reply. The updated patch looks way nicer,
imo we should go with it:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
> On 2026/7/23 11:14, Pu Lehui wrote:
>>=20
>> On 2026/7/23 0:25, Emil Tsalapatis wrote:
>>> On Wed Jul 22, 2026 at 3:23 AM EDT, Pu Lehui wrote:
>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>
>>>> In bpf_mprog_link, the code does not check the link->type first before
>>>> dereferencing link->prog->type. This missing validation allows a user =
to
>>>> pass an abnormal non-netkit or non-tcx link via relative_fd. If doing
>>>> BPF_LINK_UPDATE on the abnormal link, it can trigger a UAF issue.
>>>>
>>>> CPU0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 CPU1
>>>> netkit_link_prog_attach
>>>> bpf_mprog_attach
>>>> bpf_mprog_tuple_relative
>>>> bpf_mprog_link
>>>> =C2=A0=C2=A0 /* non-netkit or non-tcx link */
>>>> =C2=A0=C2=A0 link =3D bpf_link_get_from_fd(id_or_fd);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF_LINK_UPDATE on=20
>>>> relative link
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_prog =3D=20
>>>> xchg(&link->link.prog, new_prog);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_prog_put(old_prog);
>>>> =C2=A0=C2=A0 if (type && link->prog->type !=3D type) <-- trigger UAF
>>>>
>>>> The reason for the UAF is that each subsystem provides its own
>>>> protection for link->prog. Since there is no cross subsystem protectio=
n
>>>> (if not considering the RCU of prog tear down), dereferencing the prog
>>>> of an anchor link that does not belong to the current subsystem is not
>>>> safe: it may have been freed. Therefore, we need to validate link->typ=
e
>>>> to reject foreign anchors.
>>>>
>>>> Fix this by strictly validating link->type in bpf_mprog_link against t=
he
>>>> expected link type. mprog APIs is also adjusted to accept and pass dow=
n
>>>> the expected link type. Meanwhile, add a comment explaining that when
>>>> ptype =3D=3D UNSPEC in bpf_mprog_detach, it acts as a wildcard.
>>>>
>>>> Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for=20
>>>> multi-progs")
>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>> Reviewed-by: Amery Hung <ameryhung@gmail.com>
>>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>>
>>> Unless I'm missing something, at the very least there's no need for the
>>> extra argument in detach() since we pass UNSPEC to bpf_mprog_link() and
>>> never use it otherwise.
>>>
>>> Even for the attach case, aren't we required to provide a new link
>>> for attachment, and so already have the ltype available to test
>>> against?
>>>
>> Hi Emil,
>>=20
>> The BPF_F_LINK flag only indicates that relative_fd refers to an anchor=
=20
>> link or prog; it is independent of whether the object being attached or=
=20
>> detached is a bare prog or a link. This means that when attaching or=20
>> detaching a bare prog relative to an anchor link, we cannot obtain the=
=20
>> expected_link_type because the link parameter passed in is NULL.
>>=20
>> Furthermore, as you mentioned, we should support unconditional=20
>> detachment. But in the current version, because we strictly check=20
>> expected_link_type, the detach operation will fail if the relative link=
=20
>> type does not match.
>>=20
>> Therefore, we can simplify the approach to fix this UAF=E2=80=94similar =
to patch=20
>> 3=E2=80=94by relying on RCU protection when accessing the prog type of a=
=20
>> relative link. When attaching or detaching a bare prog or a link=20
>> relative to an anchor link, we simply verify that=20
>> relative_link->prog->type matches the bare prog->type or=20
>> link->prog->type. This logic also naturally applies to unconditional=20
>> detachment with relative link, such as when the bare prog or link->prog=
=20
>> being detached is NULL.
>>=20
>> And the patch will be follow, wdyt?
>>=20
>> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
>> index 1394168062e8..512821c21aa6 100644
>> --- a/kernel/bpf/mprog.c
>> +++ b/kernel/bpf/mprog.c
>> @@ -10,6 +10,8 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>>  =C2=A0{
>>  =C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_link *link =3D ERR_PTR(-EINVAL);
>>  =C2=A0=C2=A0=C2=A0=C2=A0 bool id =3D flags & BPF_F_ID;
>> +=C2=A0=C2=A0=C2=A0 bool type_mismatch =3D false;
>> +=C2=A0=C2=A0=C2=A0 struct bpf_prog *prog;
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0 if (id)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link =3D bpf_link_by_i=
d(id_or_fd);
>> @@ -17,13 +19,20 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link =3D bpf_link_get_=
from_fd(id_or_fd);
>>  =C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(link))
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(link);
>> -=C2=A0=C2=A0=C2=A0 if (type && link->prog->type !=3D type) {
>> +
>> +=C2=A0=C2=A0=C2=A0 rcu_read_lock();
>> +=C2=A0=C2=A0=C2=A0 prog =3D READ_ONCE(link->prog); <-- relative_link->p=
rog
>> +=C2=A0=C2=A0=C2=A0 if (!prog || (type && prog->type !=3D type))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type_mismatch =3D true;
>> +=C2=A0=C2=A0=C2=A0 rcu_read_unlock();
>> +
>> +=C2=A0=C2=A0=C2=A0 if (type_mismatch) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_link_put(link);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0 tuple->link =3D link;
>> -=C2=A0=C2=A0=C2=A0 tuple->prog =3D link->prog;
>> +=C2=A0=C2=A0=C2=A0 tuple->prog =3D prog;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>  =C2=A0}
>>=20
>>>> ---
>>>> =C2=A0 drivers/net/netkit.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 ++++++-=
------
>>>> =C2=A0 include/linux/bpf_mprog.h |=C2=A0 6 ++++--
>>>> =C2=A0 kernel/bpf/mprog.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
23 ++++++++++++++---------
>>>> =C2=A0 kernel/bpf/tcx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 13 ++++++-------
>>>> =C2=A0 4 files changed, 30 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
>>>> index a3931cd82132..99ddf2befb23 100644
>>>> --- a/drivers/net/netkit.c
>>>> +++ b/drivers/net/netkit.c
>>>> @@ -768,7 +768,7 @@ int netkit_prog_attach(const union bpf_attr=20
>>>> *attr, struct bpf_prog *prog)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_attach(entry, &entry_=
new, prog, NULL,=20
>>>> replace_prog,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->attach_flags, att=
r->relative_fd,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->expected_revision);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->expected_revision, BPF_LINK_T=
YPE_NETKIT);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (entry !=3D =
entry_new) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 netkit_entry_update(dev, entry_new);
>>>> @@ -802,7 +802,7 @@ int netkit_prog_detach(const union bpf_attr=20
>>>> *attr, struct bpf_prog *prog)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_detach(entry, &entry_=
new, prog, NULL,=20
>>>> attr->attach_flags,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->relative_fd, attr->expected_r=
evision);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->relative_fd, attr->expected_r=
evision,=20
>>>> BPF_LINK_TYPE_NETKIT);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bpf_mprog_=
total(entry_new))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 entry_new =3D NULL;
>>>> @@ -850,7 +850,7 @@ static int netkit_link_prog_attach(struct=20
>>>> bpf_link *link, u32 flags,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT_RTNL();
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry =3D netkit_entry_fetch(dev, true)=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_attach(entry, &entry_=
new, link->prog, link,=20
>>>> NULL, flags,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id_or_fd, revision);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id_or_fd, revision, BPF_LINK_TYPE_N=
ETKIT);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (entry !=3D =
entry_new) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 netkit_entry_update(dev, entry_new);
>>>> @@ -877,7 +877,7 @@ static void netkit_link_release(struct bpf_link=20
>>>> *link)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOENT=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_detach(entry, &entry_new, link->=
prog, link, 0,=20
>>>> 0, 0);
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_detach(entry, &entry_new, link->=
prog, link, 0,=20
>>>> 0, 0, BPF_LINK_TYPE_NETKIT);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bpf_mprog_=
total(entry_new))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 entry_new =3D NULL;
>>>> @@ -919,9 +919,8 @@ static int netkit_link_update(struct bpf_link=20
>>>> *link, struct bpf_prog *nprog,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOENT=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_attach(entry, &entry_new, nprog,=
 link, oprog,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF_F_REPLACE | BPF_F_ID,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->prog->aux->id, 0);
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_attach(entry, &entry_new, nprog,=
 link, oprog,=20
>>>> BPF_F_REPLACE | BPF_F_ID,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->prog->aux->id, 0, BPF_LINK_TY=
PE_NETKIT);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(en=
try !=3D entry_new);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oprog =3D xchg(=
&link->prog, nprog);
>>>> diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
>>>> index 0b9f4caeeb0a..1fbe1a923968 100644
>>>> --- a/include/linux/bpf_mprog.h
>>>> +++ b/include/linux/bpf_mprog.h
>>>> @@ -321,12 +321,14 @@ int bpf_mprog_attach(struct bpf_mprog_entry=20
>>>> *entry,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct bpf_mprog_entry **entry_new,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct bpf_prog *prog_new, struct bpf_link *link,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct bpf_prog *prog_old,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u32 flags, u32 id_or_fd, u64 revision);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u32 flags, u32 id_or_fd, u64 revision,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 enum bpf_link_type expected_link_type);
>>>> =C2=A0 int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct bpf_mprog_entry **entry_new,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct bpf_prog *prog, struct bpf_link *link,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u32 flags, u32 id_or_fd, u64 revision);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u32 flags, u32 id_or_fd, u64 revision,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 enum bpf_link_type expected_link_type);
>>>> =C2=A0 int bpf_mprog_query(const union bpf_attr *attr, union bpf_attr=
=20
>>>> __user *uattr,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct bpf_mprog_entry *entry);
>>>> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
>>>> index 1394168062e8..b4a1b35ff569 100644
>>>> --- a/kernel/bpf/mprog.c
>>>> +++ b/kernel/bpf/mprog.c
>>>> @@ -6,7 +6,7 @@
>>>> =C2=A0 static int bpf_mprog_link(struct bpf_tuple *tuple,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u32 id_or_fd, u32 flags,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 enum bpf_prog_type type)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 enum bpf_link_type type)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_link *link =3D ERR_PTR(-EINV=
AL);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool id =3D flags & BPF_F_ID;
>>>> @@ -17,7 +17,7 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link =3D bpf_li=
nk_get_from_fd(id_or_fd);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(link))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(=
link);
>>>> -=C2=A0=C2=A0=C2=A0 if (type && link->prog->type !=3D type) {
>>>> +=C2=A0=C2=A0=C2=A0 if (type && link->type !=3D type) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_link_put(li=
nk);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> @@ -52,21 +52,22 @@ static int bpf_mprog_prog(struct bpf_tuple *tuple,
>>>> =C2=A0 static int bpf_mprog_tuple_relative(struct bpf_tuple *tuple,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 id_or_fd, u32=
 flags,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum bpf_prog_type type)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum bpf_link_type ltype,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum bpf_prog_type ptype)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool link =3D flags & BPF_F_LINK;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool id =3D flags & BPF_F_ID;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(tuple, 0, sizeof(*tuple));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (link)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bpf_mprog_link(tupl=
e, id_or_fd, flags, type);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bpf_mprog_link(tupl=
e, id_or_fd, flags, ltype);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If no relevant flag is set and no id=
_or_fd was passed, then
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * tuple link/prog is just NULLed.=
 This is the case when before/
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * after selects first/last positi=
on without passing fd.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!id && !id_or_fd)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> -=C2=A0=C2=A0=C2=A0 return bpf_mprog_prog(tuple, id_or_fd, flags, type=
);
>>>> +=C2=A0=C2=A0=C2=A0 return bpf_mprog_prog(tuple, id_or_fd, flags, ptyp=
e);
>>>> =C2=A0 }
>>>> =C2=A0 static void bpf_mprog_tuple_put(struct bpf_tuple *tuple)
>>>> @@ -226,7 +227,8 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry=
,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct bpf_mprog_entry **entry_new,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct bpf_prog *prog_new, struct bpf_link *link,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct bpf_prog *prog_old,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u32 flags, u32 id_or_fd, u64 revision)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u32 flags, u32 id_or_fd, u64 revision,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 enum bpf_link_type expected_link_type)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_tuple rtuple, ntuple =3D {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .prog =3D prog_=
new,
>>>> @@ -243,6 +245,7 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry=
,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EEXIST;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_tuple_relative(&rtupl=
e, id_or_fd,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 flags & ~BPF_F_REPLACE,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expected_li=
nk_type,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 prog_new->type);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> @@ -328,7 +331,8 @@ static int bpf_mprog_fetch(struct bpf_mprog_entry=
=20
>>>> *entry,
>>>> =C2=A0 int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct bpf_mprog_entry **entry_new,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct bpf_prog *prog, struct bpf_link *link,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u32 flags, u32 id_or_fd, u64 revision)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u32 flags, u32 id_or_fd, u64 revision,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 enum bpf_link_type expected_link_type)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_tuple rtuple, dtuple =3D {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .prog =3D prog,
>>>> @@ -343,8 +347,9 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry=
,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bpf_mprog_total(entry))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOENT;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_tuple_relative(&rtupl=
e, id_or_fd, flags,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prog ? prog=
->type :
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF_PROG_TY=
PE_UNSPEC);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expected_li=
nk_type,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Use UNSP=
EC as wildcard when prog is NULL */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prog ? prog=
->type : BPF_PROG_TYPE_UNSPEC);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dtuple.prog) {
>>>> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
>>>> index 02db0113b8e7..f208cef13a98 100644
>>>> --- a/kernel/bpf/tcx.c
>>>> +++ b/kernel/bpf/tcx.c
>>>> @@ -38,7 +38,7 @@ int tcx_prog_attach(const union bpf_attr *attr,=20
>>>> struct bpf_prog *prog)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_attach(entry, &entry_=
new, prog, NULL,=20
>>>> replace_prog,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->attach_flags, att=
r->relative_fd,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->expected_revision);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->expected_revision, BPF_LINK_T=
YPE_TCX);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (entry !=3D =
entry_new) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 tcx_entry_update(dev, entry_new, ingress);
>>>> @@ -76,7 +76,7 @@ int tcx_prog_detach(const union bpf_attr *attr,=20
>>>> struct bpf_prog *prog)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_detach(entry, &entry_=
new, prog, NULL,=20
>>>> attr->attach_flags,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->relative_fd, attr->expected_r=
evision);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->relative_fd, attr->expected_r=
evision,=20
>>>> BPF_LINK_TYPE_TCX);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!tcx_entry_=
is_active(entry_new))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 entry_new =3D NULL;
>>>> @@ -152,7 +152,7 @@ static int tcx_link_prog_attach(struct bpf_link=20
>>>> *link, u32 flags, u32 id_or_fd,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!entry)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_attach(entry, &entry_=
new, link->prog, link,=20
>>>> NULL, flags,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id_or_fd, revision);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id_or_fd, revision, BPF_LINK_TYPE_T=
CX);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (entry !=3D =
entry_new) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 tcx_entry_update(dev, entry_new, ingress);
>>>> @@ -183,7 +183,7 @@ static void tcx_link_release(struct bpf_link *link=
)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOENT=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_detach(entry, &entry_new, link->=
prog, link, 0,=20
>>>> 0, 0);
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_detach(entry, &entry_new, link->=
prog, link, 0,=20
>>>> 0, 0, BPF_LINK_TYPE_TCX);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!tcx_entry_=
is_active(entry_new))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 entry_new =3D NULL;
>>>> @@ -229,9 +229,8 @@ static int tcx_link_update(struct bpf_link *link,=
=20
>>>> struct bpf_prog *nprog,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOENT=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_attach(entry, &entry_new, nprog,=
 link, oprog,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF_F_REPLACE | BPF_F_ID,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->prog->aux->id, 0);
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D bpf_mprog_attach(entry, &entry_new, nprog,=
 link, oprog,=20
>>>> BPF_F_REPLACE | BPF_F_ID,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->prog->aux->id, 0, BPF_LINK_TY=
PE_TCX);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(en=
try !=3D entry_new);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oprog =3D xchg(=
&link->prog, nprog);
>>=20

