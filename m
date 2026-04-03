Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74681625
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775174728; cv=pass; b=qvK79FgBSBPLK2tXc/tVi1KjUZdChpRLd8ghnLQAc04AQBVANDyvO06VgAt84XQAhk3ChU6WsMnxg0uGaOuozekcdnUBHMHOgFaYz8po6RSnAusGykV2ZQWbblQdn2J4bnw4bT4cBvQUfLGxVBwXCmzyX6UgXjbyULpaOmJWfvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775174728; c=relaxed/simple;
	bh=sffvTFsGYWv3VIqosLyDabvdFqSFos/5UAUPY006zC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Af4E4IEwvia8CUwPdrBj1ojb6WOGD2RozlgR5QGqv3de8uDpfEX2aY2EeyiDGQ0IkukhbE4HySzhmaCMEyzlIUX5Ik9zro4k3SQWq1ZRLXT2ubHjmJolmjoKprpNFnZIFvrmffpNUGi54niHiL9U94WgZhzwnAvi/MLOmn4/GCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ4o+J2z; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ4o+J2z"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d23305225so915856f8f.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 17:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775174726; cv=none;
        d=google.com; s=arc-20240605;
        b=kHTO7eH9I65qBSvums1NQcmFCKo8HB1MfJLHaiu7vcJMAo6hhYL9dWji8EljhO/eVU
         1ekx3jhUVAPNE9ogXwR9TElS0ySvbuvJOrJ9uLEC3FCDhPMm6UryvSGJQcBkn5MJ1U1l
         v3m//rLQET0jMpWzVLIeKTgBeeO6JL4ajqiHOLEoLFLHzUPD2pfZXAnXoaC+rS8cwGj5
         ZAvR7pdBFFIa4vbUtMBnVBnENhykgP8rbE+ULt2jGM0X56jJHdmJHffixVvd03Ev+sDV
         +NdkmGy3A2GC7ejjWrPjlClFu4PkvjqNrm9SAicFntVVaAioV79dHoEvMnqzlS8LUrZa
         NU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iVSpQ8bUaG4Oz9XFYD2ByiHow/TcQ+ZmMiwiKlfUBro=;
        fh=wlVha2yx9wPgJ1Vxuih5kzv/QQcR/zvQ10NeSGzfo3s=;
        b=BWRDIWX+U5SX7YmAndAXAY7VExMWpIYlsusi8NC0xhkxo9j3mNLXtZzt0bNjb0FhTl
         0rx+M2iAHd5186jO55K4mIDalxf0mg/siy8J0d6LkKd4Yd4Yq9Qp6Aj5TSbiGgs+sC6j
         2U75u2LrfKzNI1B7i3dRNLIOtqneMW3hItWqDZiRuFZbkoMzvXZzTe5raIHNUv1eNc1O
         DoejHTcYLPA4Y+QcbgTdBDVM/soadsws+kDEN5zETFXogc5TELH7vrRrFGLHOf+kKRJ0
         bET2F7gfq5eRb69T54j7ufJ0h8zPoamlt9xV+Vm1pYUw3jNAip/N5YRGPD1hyxC3zlHD
         fv7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775174726; x=1775779526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVSpQ8bUaG4Oz9XFYD2ByiHow/TcQ+ZmMiwiKlfUBro=;
        b=jZ4o+J2ztfwdCKwcvkSvXUaZZMRcLLDsNg1EZdD6mJqrbPD7dZqNj97izvNDmnN/NH
         oVzlkKSqdxMbw6TeoptGzJm9rVZMUDeo6vCUAqrdbR3NngYG4ORmabYjAkVBOfTp2nCF
         iCrXriiIDmS0lI5WSKY5G6XUAuEJCYC0WhkwTO1BMBCUhqYq8UEzpYbtnSQwQg+GMdPQ
         wnbFYF4kSPP43qCjJXYHQFrJHJvIylhcIVD7eW2pSxjSUvs8YX1c6GtbjE/iezGF1mNc
         h60v2vFmqyTljMwyEstesC8P9A4/PZa7lij15yYYWh24cAEjtS4D+zVxdCTctnEe3Mm0
         he8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775174726; x=1775779526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iVSpQ8bUaG4Oz9XFYD2ByiHow/TcQ+ZmMiwiKlfUBro=;
        b=LSA+FCXgGIAIg4WBrCmZ41WM29GTSDbcP0MqSkEWJ8Fy39O/WDa2Q4fLMwHVfhatgg
         bLX5ZjJ9CAHVpDUgw4p3fd8+hqWjr/4WWTR947r14t+L77BJf2cJDGeCXa+iCBIRaqnP
         eVPdTn0S7WuNzhT0j6je/dAE4QNp/q2iSWSZj74Mv4AIwaYveLQnzR2K1cH5BSTCdZw3
         nwtkKhTiQlwU/+EOyCXnVZQsw1P47lIlWfnB0CfnZI9NldCFeL/jwa1EvM0EMKU4sZFS
         fbwrACRR+hccZszbKPZd/wAs7aLqce9nEzfWrNvbWRDRmCvrUQR8nBBa/jkZ/rJOgdeF
         CQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQIC1bS3/uC3MfpqGRwFypjDx7H8As+w0eWxGqJKn1ehZ+4CYA9R8xPIzxVhpRSIJaeMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9UiPIHbF83M5Bw8+j+pQRUlhxNtlCAtcGzhEw5+Q24t0kBg5B
	ZJnqpM8R5XvAg3PgDtOPQ9I/kfVnZo9BUflabkEgNyX3+cl2PqMYix5eW0liNPmiYT6ZOzBStvR
	JDaiMY59SaWqTh+4+pxyhy7x7Up8thg0=
X-Gm-Gg: AeBDievLkCN82jF7GY0kQi99XyzwiMgrYc0RbjVOnzGyVVjxJgTH0fa2f4NvUFHN2YF
	HI2+q6aPQbe0U2y6etU2+pm7dyxoPzrzDJMK2C6rKd9SqXpptRn2Q3/Q2qpRMMPR+1iOR1xJDkM
	YMBrSfCj62tqOrYqh/3R7lP1cSlsYIR8lGzKr5gBeHAx7RPbGl3ZVKDUq7Qi5IeFKx6evvCDkCx
	B/J+Va+vljEV63+/inrgHCMskj3yy6VtUoqSrgp+LUIwFhSgevJRfJ034/fWRQs+7//BJ7DeBcP
	U96EwThXwVt7V4a1WPw4eW48HVKKIWz2bmDLW75oXBIseTt5kelWZTNURwFta3PeTdhm3DpvKwS
	KQzg8mMBnlIedwylDiLhXug2uJjWDhSjA4TUa
X-Received: by 2002:a05:6000:240b:b0:439:ccd7:cdb6 with SMTP id
 ffacd0b85a97d-43d29276590mr1474394f8f.14.1775174725781; Thu, 02 Apr 2026
 17:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7653EEEC2BAB17DF+20260402073948.2185396-1-xulang@uniontech.com>
 <420FEEDDC768A4BE+20260402074236.2187154-1-xulang@uniontech.com>
 <CAADnVQJawYEk53kS9-w5EXU0GnUYWWW7AF_n02bUs-GPJ+4Raw@mail.gmail.com>
 <ac6ejZrcnfQfaTZS@devbig1721.ftw5.facebook.com> <CAADnVQLSUU8Yo1Wmym4B05jam6qqUPEXUDJpBH+00kjqkrYigw@mail.gmail.com>
 <ac7Afa6_HDzyAxSt@devbig1721.ftw5.facebook.com>
In-Reply-To: <ac7Afa6_HDzyAxSt@devbig1721.ftw5.facebook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 17:05:14 -0700
X-Gm-Features: AQROBzDvrl5SxoyMltgdhQ469U-1ELcBNzEqVAYKgGkTjp_E4kLZOV2Mqhux4Fs
Message-ID: <CAADnVQJv5qNL+ssShZ043DVobO7ecfMuZxa-t-CGiGL-XyK=PA@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix OOB in pcpu_init_value
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: xulang <xulang@uniontech.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dongliang Mu <dzm91@hust.edu.cn>, Eduard <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>, kernel@uniontech.com, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 12:59=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Thu, Apr 02, 2026 at 11:36:04AM -0700, Alexei Starovoitov wrote:
> > On Thu, Apr 2, 2026 at 10:01=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On Thu, Apr 02, 2026 at 07:17:17AM -0700, Alexei Starovoitov wrote:
> > > > On Thu, Apr 2, 2026 at 12:43=E2=80=AFAM xulang <xulang@uniontech.co=
m> wrote:
> > > > >
> > > > > From: Lang Xu <xulang@uniontech.com>
> > > > >
> > > > > An out-of-bounds read occurs when copying element from a
> > > > > BPF_MAP_TYPE_CGROUP_STORAGE map to another pcpu map with the
> > > > > same value_size that is not rounded up to 8 bytes.
> > > > >
> > > > > The issue happens when:
> > > > > 1. A CGROUP_STORAGE map is created with value_size not aligned to
> > > > >    8 bytes (e.g., 4 bytes)
> > > > > 2. A pcpu map is created with the same value_size (e.g., 4 bytes)
> > > > > 3. Update element in 2 with data in 1
> > > > >
> > > > > pcpu_init_value assumes that all sources are rounded up to 8 byte=
s,
> > > > > and invokes copy_map_value_long to make a data copy, However, the
> > > > > assumption doesn't stand since there are some cases where the sou=
rce
> > > > > may not be rounded up to 8 bytes, e.g., CGROUP_STORAGE,
> > > >
> > > > why? Just round it up there instead of penalizing perf everywhere.
> > > >
> > > > > skb->data.
> > > >
> > > > what that means?
> > > >
> > > > pcpu_init_value() can access skb->data ?
> > >
> > > After bound check, the skb->data can be used in
> > > bpf_map_update_elem(&percpu_lru_map, &key, skb_data, BPF_NOEXIST)
> > > which will call pcpu_init_value().
> >
> > I see, but if we round up on cgroup storage size the problem is gone,
> > right?
>
> Right, it will fix the problem tested in patch 2 which
> passes cgroup_storage_value as the source to
> pcpu_init_value(). The bug should only manifest with BPF_NOEXIST.
> For BPF_EXIST, pcpu_copy_value() will be used and it
> currently uses copy_map_value() instead of copy_map_value_long().
>
> > Doesn't matter what the source of the copy is.
>
> I think the source (PTR_TO_*) matters here because the bug is about
> reading beyond the boundary of the source. A few other map types
> were audited when their values were used as the source.
>
> For skb->data, using skb->data to reproduce is practically
> not possible because there should be at least shinfo beyond data_end,
> so some of shinfo may get copied to the pcpu map in the extreme case.

Yes, but also the verifier checks that ptr + value_size is accessible
in that source. In this case, that the value_size bytes are available in sk=
b.
So if we round up early at cgroup storage creation time there is no overrun=
.

I must be missing something.
