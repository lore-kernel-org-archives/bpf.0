Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16353A0E9A
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708062; cv=pass; b=o0/PAXEevLhdMBXh8AON5AZsFHqSLNG68rviPYtPNDz7xqCgQFZTmri2Wi96/aw8OgBdqlfC5gZ6+kEOPpwQKiZh5at+lZoyxCJxM8OEPEaC/fGpROHX1WBYdY4lnlNphbPwbMgEaV07FN4QzRmkkt0jLWHMNlFSwNDFA8DsD7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708062; c=relaxed/simple;
	bh=JdCZN5QgzbU3g6qizeeFvWJ5u9BDqitxe6RYxvW02e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dn+wEwBEp8gjQ09/xj+WKiP7eT/aH7ysNXfaFv171IimSZwDik1p8sdh+AwyCR+HhDtqETrhUnQZS47zXILFkwZIuJ/QBaKO8GJ3VTZOwiI+20bSTAIWnqJPqrzEcd93GoZPZTD1c5LcrBVxkPHb0EYlsqCFUHBesOpjRqFlKhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJNM9OAs; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJNM9OAs"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43fe8bda8e9so1664761f8f.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 11:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776708055; cv=none;
        d=google.com; s=arc-20240605;
        b=Nf4VMIS+TQfIXtRoOBMSjJq+FB3/SZQqbUWGxy8Du6wbfcJWLLwzSfcSn4aAz1texq
         XKMsWJp51Iez8veELCa0BpIlra7O9JudvPskdrJHM/p3btHUF76jFoBgwvTcFHh4SjWn
         VovJmOXMlRTEwUqkfXUpvvJMGa4DHmdyioEkyDJjqMdlaBLn2Os+Cuej3mLEQYzp3Oxy
         QPPn0ODXm/knzQU0EgrKpU6pCE9A6p3Ht+D+uvjaNbxgpIJERIn/eW5ap+ExrCK2MXOL
         B4tI75sIufOVtzQPppKVxpEm39p5JNvih0HU76OTsTiKicLIxZsgPn/FarggMzSL6MNr
         prLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8XMim55nfAh6wENs2zJnMWkclvU3KAH+Vpxc2I+Vt7k=;
        fh=b5lFR02WfY5tWWvTHAkBON8FS6H8OAUg6DPQSBGbjw8=;
        b=FmkcPAe9XseTjUXNA4sR0nCzLqSx8p1CUbu1wOs/jsVOt52uzl2iwmqpvl64Wg3Sz5
         fFOvMqWOcIPpDanSkyOHm6l4X+I66cm/KJuDxlf5G6gC9lfgJaGHlKIuyVWROl5x6coP
         hYJMtPT77xSui3+88pBWncjhwnLl9ItYrIySnHDql5EnHRc3n8D0YqItzmmnZjTe2y65
         HgQeM4rTGBu7De1uJ/MyD8bW4mn/548FhKcLGJ49EdtwhevmFQavRiUFtiNw/+WJt7E3
         bdpp51VUMoSPG4Jg8lo0uKJq0BYCOdhRi/+l9CHrLt0g4KZqcpz8mbtJslNaqPQpDk69
         m8hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776708055; x=1777312855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XMim55nfAh6wENs2zJnMWkclvU3KAH+Vpxc2I+Vt7k=;
        b=ZJNM9OAsLUKStNZ4fkNJFboNLvPXY3SeURnuCUONDZ0y02ukP6Qye1D1H4GgIIQxkg
         UA8KAHMd8Ww7M8JxMGfV5A9MtEz2ca2P9Uki70Hd0cye0gzUQpvdIf0VjdPq9xup5aXG
         PeSAv8oANbE2fprpaKYWAWkrIcskUZ3jZGtFazPuKMqGV2AWfeT55+CASV5Yt6BwR11m
         rZ0WMTZ2L0CpeE3dhUESRepLt2pJa0WLGsH8igOPgutk2CXT6te8oWwy2LVTR82BD8S6
         3TiM6MdSieCvw6jE18h0knFnIrM9fWbiGMiFk/Ggo/l+vIfrSEJC8jFNgMaO+aZZ/Npf
         qB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776708055; x=1777312855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8XMim55nfAh6wENs2zJnMWkclvU3KAH+Vpxc2I+Vt7k=;
        b=n8zI/0gqX4ZEtcLlKzEtjij2n1nC7mm+bTbK+u6dJSdnIoL0dAgmZci3HN6E0Gvx9A
         V/zmN8mEKQgB6UhPwydcLyJN6v5W5CTTAfICaSm60uJbW79E2Xj9eDtHZ4xpZAdwwxQI
         J+nmu/IqhuA8A/SLKLFbBpuqFJAxwWPqAcbWPvg4HF5m7mRcEvhYw+KivHRiDxNzYpbf
         qe/D3jPxfTKjjVhWKsVR7V434jbuAgAXeXA7mHMSxeOo3haa35wbvdc8elLvxcpsBYDw
         kxo1RsD8xloTNlQpfeKX6+/zeNTH0IVZMNGaNILujmDUK1TFQjFHyqD9cHUqZ+4TWLr+
         LAKA==
X-Forwarded-Encrypted: i=1; AFNElJ+x8Rk2fb7Qo+WVP7Q0CjOO9hzkeBiBLDnsSgJAeEBebLZnnj09Efqclaos8Jt3FEzq9EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzNKsce2Y57UukChYWHbdJbumh/lkKn/7Jqoeu1zlIStP07AnH
	Y07HKfWbKeUKmXYQYxJ/K/y0hJLwoU/i/XxJJWfI71uLeAW5KbmkQcofdildXjxrVMAuTXPmLGM
	I2WCen93F2OjyioOJNxGEY09VK5t6pNY=
X-Gm-Gg: AeBDieuZ6MsMMZYOP8nLXYLXNBaj0pwUBPdVCwpAFZYYsmInUU+meGDf3cXSgZ59ILK
	Ej23ROYlHPjQRSes3m/lFy9ee+9AviXYMIIy7lT1OXw5cMqZBFFFyuE7k7RZB0OtvVhwEvCWTL0
	z1LT+liWxCXjEB6MiRYR3SeMxbcw4FiJn4dCb2JPNYxH7uxEzelLIe/3GBRgLKHqJWrvTrwD7nD
	fF84CdQXEHAuGGsn2HK9pn9Sq1ytzviXCZxkiTHLqCzV4WO4qV+9JwUIcDt1FXRXifItJyrfEME
	MePAcZ9E5u/uWH0QpXlBG3pZDQuVXaXyjMexHCb9wofPtf6yUUv1gIjLuJIVWieMbL3fz7NHYvZ
	RuNZrSw==
X-Received: by 2002:a05:6000:2386:b0:43d:7261:8759 with SMTP id
 ffacd0b85a97d-43fe3dfd63emr23861523f8f.28.1776708054668; Mon, 20 Apr 2026
 11:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
 <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>
 <aeBxQn8ATaNuEF4X@gondor.apana.org.au> <DHUN1UJ0DLBC.3UC7SXBAV2FOW@gmail.com>
 <96b6f76e-1dc9-4d54-9f92-8586796ef607@gmail.com> <aeHZJUw-ZRA3ZWVE@gondor.apana.org.au>
 <4c0e73e1-43c3-48a3-ab89-239fed7e6c23@gmail.com> <aeLTlNbM1rH31D4L@gondor.apana.org.au>
 <af4b850f-ac88-4c99-8d66-00e40efbd4d7@gmail.com> <DHY3HII4WSJS.Z7A2V8PWG22W@gmail.com>
 <68e0580a-4002-4b9c-a003-7cf85560d791@gmail.com> <CAADnVQ+_gYx2AiqqtmyXhB8qgioKN3t1H-TgeMMWZzv15Jt14A@mail.gmail.com>
 <cf77ad2b-6ecb-4a0d-8ae9-75b62e253eb8@gmail.com>
In-Reply-To: <cf77ad2b-6ecb-4a0d-8ae9-75b62e253eb8@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Apr 2026 11:00:41 -0700
X-Gm-Features: AQROBzBpzfEQdpsRBI3oWRByzERgD-e5lJ4CQl6qQBMEIvSGe-TmCIxTk2yv0XE
Message-ID: <CAADnVQKLR4=jc2EC6+ixQTXMNtBzYiKCSGGFDVCtTTbyCsPFrQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 9:37=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 4/20/26 5:06 PM, Alexei Starovoitov wrote:
> > On Mon, Apr 20, 2026 at 8:50=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >>
> >>
> >> On 4/20/26 4:41 PM, Alexei Starovoitov wrote:
> >>> On Mon Apr 20, 2026 at 4:45 AM PDT, Mykyta Yatsenko wrote:
> >>>>
> >>>>
> >>>> On 4/18/26 1:43 AM, Herbert Xu wrote:
> >>>>> On Fri, Apr 17, 2026 at 04:16:34PM +0100, Mykyta Yatsenko wrote:
> >>>>>>
> >>>>>> Changing interface is practically not possible - this comes from t=
he bpf
> >>>>>> syscall.
> >>>>>> Linked list solution: we probably can't afford it performance-wise=
, it's not
> >>>>>> worth it to pay for the linked list maintenance in insert/delete o=
perations,
> >>>>>> to make traversals work well.
> >>>>>
> >>>>> What performance penalty? The linked list is just a pair of pointer=
s.
> >>>>>
> >>>>> Memory-wise it'll be two extra pointers per node.
> >>>>>
> >>>>> Cheers,
> >>>>
> >>>> I'm concerned about pointer chasing, when we inserting a new element=
 to
> >>>> the list or removing existing, we'll need to update pointers of the
> >>>> neighboring elements. It'll be nice to measure it, of course, let me=
 try
> >>>> to prototype it.
> >>>
> >>> hold on. let's not overcomplicate things.
> >>> We only need to notice that resize happened, right?
> >>> In such case just ad generation counter and let resize increment it.
> >>> If it changed in our iterator -> ERESTARTSYS.
> >>> EAGAIN doesn't quite fit, since it implies that immediate operation c=
an be
> >>> retried, while here the iterator need to be destroyed and recreated.
> >>
> >> I think that won't work with get_next_key() because we don't know what
> >> generation previous key was read (in API we just get prev_key and retu=
rn
> >> next key).
> >
> > The first one starts with key=3D=3DNULL.
>
> If we iterate entire map in one go, we can detect resize, agreed. But if
> user just randomly calls bpf_map_get_next_key(), we cannot really detect
> resizes, because we don't even know when iteration started - it may not
> even be an iteration, but just an odd bpf_map_get_next_key().
> I think we can handle resizes next way:
>   - map_get_next_key(): leave as is, can't detect resize or even if
> resize matters.

exactly. My understanding of the thread is that resize problematic
only for the whole map walk, since it may keep revisiting elements
potentially forever. Since get_next_key() is a loop through user space.
It's not an issue.

>   - map_for_each_callback(), iter_seq_info(): error out if resize takes
> place mid iteration.

right. here it would be good to prevent looping for a long time.

>   - batch ops: store generation counter in the bpf_attr, so on resuming,
> we can detect if there was resize.

I wouldn't bother. It's the same category as get_next_key().
It loops through user space. We already have this "infinite loop"
issue with this api with a normal hash map. If bpf prog deletes
an unlucky 'prev' element the while(get_next_key) loop will restart
from the first.
