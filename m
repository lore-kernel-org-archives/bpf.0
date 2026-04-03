Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF834676D
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775182158; cv=pass; b=q93z9iU7ZJ+KkMc/tK3Llv6wKhVpD8eQq2AnJZfPBKVR4w68/N/1YXSjZganpCw4fZ1hQoZiHEM3u/6NsGDieA6jMWn9PGCKVBvTD60X6i7dB/zKVYPTHHj0pw4WxE2w9/EMvbSm/OfiMpeaIjM8FwQvDbMeO34nfuyXrNEvRkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775182158; c=relaxed/simple;
	bh=veA5I1Ywj0JpITQtwvjxNk/PeTJOqs0dgYJ9T2uJuJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT6ZT303jHLVTusv3gL9SK+mri96hEaEUH3AHdwryfwZ7iQUASWVW9sut9ZwuKrjGVJaQfeS6eMOuuw0IA5lwR3UFs63lfAi0b1YlPvoF/x1OpbEBSxmpjWWe22qPsUE6b20eXcCnL4iVi2dfezpwSBKq3aV3k9OHVzFeZXVT0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5wQw8Mu; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5wQw8Mu"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4889b34fb23so2455155e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775182155; cv=none;
        d=google.com; s=arc-20240605;
        b=ChGzvR4VcjHjXpk3Sd1IGHU1K+TFhzuUN0qupBe7CAcFtaErF70aO/I7L80dyTQRDG
         Koqwe1iv6wM47zDU/7GXrIHzOAWbNcG/9VbUkuHXS2aeV/BvtxlYEnxyfpaQhhdsUjna
         K191bVm3MscJngHsSLmPXVWDQnRxo+/dxomJneNLdAgjzDbViDoK/bLZ5DToJswQLcMz
         8k5VgcmX+EMStDdNEQsQJQerHg54wMKGRFz/Nd+EB3o3j39sLW9wpkUg6ne+UOBO44pd
         ESSwJB5fRRfiJr8IWzkmFrkUWEk367vv1bFuPFnfhT4HI1rrgLEOk+QdbXN3To7Usl3A
         uStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5b6zav8fCn7OmwzCnVSNZeQpQdwDyzYRfxbkvcKOoTw=;
        fh=bwsfTOpjZ71RvEql7Y2Sdl2SZkYQBwStIjjtSo/7ipI=;
        b=EfiPP8+x6f3s487TOZ1hbOCkSPMDw7mzb/ANi59kxdc1S3e/4PAI3hqfHFLMVgYGYG
         xGVZnnZZCMIUzIy19LTQtLZheSAY3Oy7GYFO7bJSL7grnWVCtR7cYfuyucORVIWQ89yA
         UB0hNfsPzzaYrazX471BTgQCEtqvdRxEVkxn/uvSG7ViSq/G9vf6dcim3WcnSlx+N0qo
         mSTO3zNi0cgPG9Ec7WDOr5cjkr6+x1td+exVq20oxThkDiAVVf+g8A1gLXNjzNT0y6lK
         SGh29qLwre487AkXRNGRRDojNf5jaehUw4yCNdgidYWJoNqSy+c2g1Ft1w3dx0ajbVMC
         jXyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775182155; x=1775786955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5b6zav8fCn7OmwzCnVSNZeQpQdwDyzYRfxbkvcKOoTw=;
        b=e5wQw8MusKsWqEO999vuzgEEWJnBVHrqVUOrG9jKM+FGLs3QwnjXalgmKoTSl8prlW
         zSBWetUVgOfRWAxRVne5TlC/iCjuN3REG3mJzPRQl3eWQ7cT/4v20854h/K+euyKwnpU
         QGQxISE77ZAU+sSFdYlQhcOg5T69uA+flYm1ad6V1eiekE4DfkVtjMEVzTAUEh/M/4Tr
         QS00iifluxZoxr0jTHydVnzNDzCFemYFbZYE5Hd68X8cRUMsQNdgdnR+EmZbBoCjyJ8Q
         fpk0WTxu6uaaYrIzTPeCbQHoCqX/mQe7w4sL1IJs2xdnCx0K24xZjr42DkAGRJd32vl+
         rmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775182155; x=1775786955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5b6zav8fCn7OmwzCnVSNZeQpQdwDyzYRfxbkvcKOoTw=;
        b=cEUBw3tEOQS4U9RS8TnRW0aewOYOklhHsPtYzGj+OZmtl8IPcWegwZOGiANVa5KCT4
         8c1qy7qcte04Upwb3WAB2FLPauHedURVcYqc0r3Dyy8iJAGtxF/N/S37UqOZgfRI2W0J
         XUoeNsKrE17hRV1ahz+KpUA9q/p+Gco5EUV6znjsX6JdPTndWnHHwu0W2KNAZ4y8z7pS
         3e82eCDPiu1nb/adTxgAYjAY8N7G4pvdLoARErfU+edbkpcMjuLRBcTAufMf0q0PSywL
         jYBd2aa09CEx5uu7W8D8PBaHa+GDJWYTRGUBk1wvYJn2RhKGQx5CcIMjuz/8CDasi98j
         5JPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF6X9oUIled4Z2ZiLLt4NvqWdyJ3yjGnixUbDUrAKQD4InF973UFJ+mHkp9xDH/+fMxNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyttE1TQvGbx0AVplwjvXh1ffaw9upxjO6si3GWV28SgIyVfzJs
	WxQlYQAIAb/xbDLt5l+ldM+bQtn6cVcv+KjWZiLqiXRguiH/o2HlOQGnaoB+984SDOKOesGYWbr
	+/jEqQXNnrlHxwTpRqO+LbJj11KoPFZ0=
X-Gm-Gg: ATEYQzzt/YWoK/okOjDI4+i+6vGSZcxVDhRyeec7kEp70ye0jtBnutMW95BCEBqDu1A
	ueqMSdE1kpciFnRDrXVkQ9napuQrkGxIH/LRLHDKMLkW9jzhK5dA9eiYZjG+0xt5p4qVrWppGZX
	aFJ/821k6qFJDRX32uggSFDUIwZHW0Jd5iStVpbHWzss5nFJlZU7cyXurPdndI7lue4okwueomx
	26wVBqo2lYCmEb6nlkvKfGInoKWxqLFPiL+bYv1e7SctihrYOP6WajQChqiWJcvAzpMBsJK7ReC
	kCFtIb8bLsQLVArz2Jsv8MHacEa5NIbtNJeZ89h1HAT306rzylnc5m6wyYnwX9sYUc4xknNTxqR
	HPjehxIXEDQD2zVw99LoI8lViBQ==
X-Received: by 2002:a05:600c:5294:b0:485:3aa1:a7f1 with SMTP id
 5b1f17b1804b1-4889973c63fmr21188235e9.7.1775182155072; Thu, 02 Apr 2026
 19:09:15 -0700 (PDT)
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
 <ac7Afa6_HDzyAxSt@devbig1721.ftw5.facebook.com> <CAADnVQJv5qNL+ssShZ043DVobO7ecfMuZxa-t-CGiGL-XyK=PA@mail.gmail.com>
 <ac8ODClxZ83KZf-V@devbig1721.ftw5.facebook.com>
In-Reply-To: <ac8ODClxZ83KZf-V@devbig1721.ftw5.facebook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 19:09:03 -0700
X-Gm-Features: AQROBzDYt9fMFVklCFRoxE2WuwaXVAh4dGAOYsXrlhEKXlNXL9DqLRKllS9S4aY
Message-ID: <CAADnVQJAYE9_KoNrWQhTz0UOX5dwmqKL-m6H0S_o2ZmdScVPfQ@mail.gmail.com>
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

On Thu, Apr 2, 2026 at 7:00=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On Thu, Apr 02, 2026 at 05:05:14PM -0700, Alexei Starovoitov wrote:
> > On Thu, Apr 2, 2026 at 12:59=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On Thu, Apr 02, 2026 at 11:36:04AM -0700, Alexei Starovoitov wrote:
> > > > On Thu, Apr 2, 2026 at 10:01=E2=80=AFAM Martin KaFai Lau <martin.la=
u@linux.dev> wrote:
> > > > >
> > > > > On Thu, Apr 02, 2026 at 07:17:17AM -0700, Alexei Starovoitov wrot=
e:
> > > > > > On Thu, Apr 2, 2026 at 12:43=E2=80=AFAM xulang <xulang@uniontec=
h.com> wrote:
> > > > > > >
> > > > > > > From: Lang Xu <xulang@uniontech.com>
> > > > > > >
> > > > > > > An out-of-bounds read occurs when copying element from a
> > > > > > > BPF_MAP_TYPE_CGROUP_STORAGE map to another pcpu map with the
> > > > > > > same value_size that is not rounded up to 8 bytes.
> > > > > > >
> > > > > > > The issue happens when:
> > > > > > > 1. A CGROUP_STORAGE map is created with value_size not aligne=
d to
> > > > > > >    8 bytes (e.g., 4 bytes)
> > > > > > > 2. A pcpu map is created with the same value_size (e.g., 4 by=
tes)
> > > > > > > 3. Update element in 2 with data in 1
> > > > > > >
> > > > > > > pcpu_init_value assumes that all sources are rounded up to 8 =
bytes,
> > > > > > > and invokes copy_map_value_long to make a data copy, However,=
 the
> > > > > > > assumption doesn't stand since there are some cases where the=
 source
> > > > > > > may not be rounded up to 8 bytes, e.g., CGROUP_STORAGE,
> > > > > >
> > > > > > why? Just round it up there instead of penalizing perf everywhe=
re.
> > > > > >
> > > > > > > skb->data.
> > > > > >
> > > > > > what that means?
> > > > > >
> > > > > > pcpu_init_value() can access skb->data ?
> > > > >
> > > > > After bound check, the skb->data can be used in
> > > > > bpf_map_update_elem(&percpu_lru_map, &key, skb_data, BPF_NOEXIST)
> > > > > which will call pcpu_init_value().
> > > >
> > > > I see, but if we round up on cgroup storage size the problem is gon=
e,
> > > > right?
> > >
> > > Right, it will fix the problem tested in patch 2 which
> > > passes cgroup_storage_value as the source to
> > > pcpu_init_value(). The bug should only manifest with BPF_NOEXIST.
> > > For BPF_EXIST, pcpu_copy_value() will be used and it
> > > currently uses copy_map_value() instead of copy_map_value_long().
> > >
> > > > Doesn't matter what the source of the copy is.
> > >
> > > I think the source (PTR_TO_*) matters here because the bug is about
> > > reading beyond the boundary of the source. A few other map types
> > > were audited when their values were used as the source.
> > >
> > > For skb->data, using skb->data to reproduce is practically
> > > not possible because there should be at least shinfo beyond data_end,
> > > so some of shinfo may get copied to the pcpu map in the extreme case.
> >
> > Yes, but also the verifier checks that ptr + value_size is accessible
> > in that source. In this case, that the value_size bytes are available i=
n skb.
> > So if we round up early at cgroup storage creation time there is no ove=
rrun.
>
> The verifier checks that src_ptr + value_size is accessible but the
> percpu's map->value_size is not rounded up to 8 bytes. If the percpu_map
> is created with 4 bytes value_size, the percpu_map->value_size will stay =
at 4
> and verifier only checks that src + 4 is accessible.

I meant that we can do:
map->value_size =3D round_up(map->value_size, 8);

there is no promise that value_size at creation time is equal to
the one that the verifier uses and what is reported back to user space.
We could do that for hashmap too. I think...
