Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795639771;
	b=mhWUkBRchEJPEoXSgKbYn9N5Os03SRCejQh16dmjHHdHKP4GIpSg00kMLk/eMEoYN5X9
	 m3UfPH8UWWcJQVtLylb5Qi8rWFgmQCCQxdXnjxZFrw1XNpdX0GS1LcIM7LPit1nzY6q8/
	 RTwiJ70ctGe98RclutivqaVGOWo67KJL9ffE1QenyAvapwOOSeyuGttuI9W7CKBhpkMUF
	 GmfpttKwmBuZGHuwfhiMBnC/AQi+G062wGeAvo243Es9K/cmHOhYAT+eR/vFSoE2i6tMn
	 nAtMGX3ETrIGEAoDFh2D2NRwk5sEVRRp6ZM9Aphvu/buFcMhNsVayzPPmLNzBOq0eRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hFtwAX/NA1T5ogsYuSHbpPYADTB9ptovL7hEStnmfUE=;
	b=oc/wGQdT1Gn6vhN/QF5eFLH9Knw8iPv/gr93JLKlRb65n+xgKrNDHO05/24/KcqyMEiI
	 99Kao8Zcg1g0F44p07Lyq8eBPdYJJU9rGK01dRmt38aVkgXFj3bCHvy+5TXgsrzaMMSTV
	 v/qFJCPAAq1e9hmEXvhiuKyRbSlJcJN/B5L4QBSV2bSIRtPOKPuvPxCGNPVAziHEST484
	 u0W2NS8OqLhSOiLcvAyZzfvfCT33TLR4ENc1/kP4Y4YqTcz/4f7ruPyX/dyOonD78TTu+
	 khm1je/d9qkzEX8Tt8ecfgfX8M1C8qgZ8BUs+YcAOFghWzz3Y92ohM3S9pzSu2b6GHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rqCgeCTd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757D606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 20:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9757D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rqCgeCTd
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-492f0a1b685so4381244f8f.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 12:49:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795639769; cv=none;
        d=google.com; s=arc-20260327;
        b=Uq/xip1/tQQOVEonF1D1xdVCi8uMXd2Sd/cDfQMx4ReesYg63gJ73ZPTc5YzRpO5DZ
         HKy1c8d3EioxcAsk1oOOWfVYR5zEQuH78y3L1qFzR25usSQwHvPQ1dMHA1c6zRB7PaBa
         JKkbAjs99oObe4L/zX6116nvTAGjTVb7oT3lGDx6unbrt6LnOgy+FcMiUeK3HoEBMBbs
         chJ80r0vLy2Jx2XmgbfFAM77Pp0Zh4+ftCGmA9yf26nzleaW2QFiovLwRG8KcQwvAKT/
         iSeZ1kVwP7W5EY/w1Hp9uuVHeuhbhICRsaYIei9G57PpLJJxVLA6wzrDW20MgvOci3d1
         VJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hFtwAX/NA1T5ogsYuSHbpPYADTB9ptovL7hEStnmfUE=;
        fh=J3ZOLc4nBKm9RaZivu8o194HBzTqADsih29R+8KE/Ok=;
        b=M4SAP9tPv9EQzl5JrTay7n6Fw7skFswHp/N8ASBt1Yxmmq7OvO0ScMZiHQT7Abv1ky
         TezvzhmvrCWhiki3FynPsY8Oa0bXUt3OlPuLOAT/WaRdgyq8D04b/m5tZZc7wL/SzWNJ
         hXknOjEq26l78hf7fV7PPACzNBiT554InVGknS+ZAe0tKcM2km00Wohd/SbZR7RESwph
         /M3mp+zoSGhiT6y4gXyjBiJAdS+43bPEONRmw8p0ooeBnLhrQm268mqRmXqNPRCk9iuI
         YkqX7LPgIQFCfTlps3gh5L6ooivZlcNENMx7wzZsUfCgJnQtdGp2wAcQbu0va/dXWN48
         XlYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795639769; x=1796244569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hFtwAX/NA1T5ogsYuSHbpPYADTB9ptovL7hEStnmfUE=;
        b=rqCgeCTdCAuhGfAqwyhpFIOUu1o/NAt1enJQu5uBJrjWPdvNPPL6piojcHUlqsd+Ap
         I3iDsT7JNm+N30vlChT1mhgHyjAeN2NOJTNtwOYF4vBxlyxBXhEKq3+oFL1Pjc3OLnMh
         YeSiByn9KQQLz/S5QsXmnbHGUZpbjsC+NvbogrTvWKv0APKDxCUZZ9XpeefbM8P4lZOV
         LbHZ2P6KJETJoSuIPiizeMxcZxNXZVHjrz5eYYhNVona+HWaF/oLSV9MFzg2Bj535plu
         ReYzPGKSPGZMOKxJBr1Ik6YHUdc6ZGMw+WjpEUBsQfLyWwmYvQ+VQVdgxrLV1WLz3UzV
         1x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795639769; x=1796244569;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hFtwAX/NA1T5ogsYuSHbpPYADTB9ptovL7hEStnmfUE=;
        b=IIUv7PHr7VaBrXoBz+AdK58HOX0FE8AwobXa8FzXTGAVpLhJqMDxEz16+5li18jrtS
         PWLi9s+cpVQ2UvOLklxV9JS5LFpprja64lsMJVkARWovd+pt2Rkyb/4MehgWhRDaCC4b
         oH3SV2BSj6nbgp3qiIPLESnomFRSN0MrpQ9SBcwTXnURdhkKeCGhVNKfDdXNQb/1a63L
         u8svpUZeWrT2OtiOCJOksD42dZfxQNUuRdj11tpntYXmL2NC9mrNErbOLqT+E4bZMUh4
         cQuYj6h7qPS/PZ7OFc/JaqcOWbkEPlQU0f2hyHtPr2sRBIMph9rrUgFic5IFxf5onB+P
         Fmew==
X-Forwarded-Encrypted: i=1; AL+hErGAusIjFN/LG51PVo47Imtre81OW1H468OT4ObsCjMy/LSsTcZ0LmOXHTubgRrStE+6SRw=@vger.kernel.org
X-Gm-Message-State: APuU4Z84Ga361MJeuGn4Bk0I55mwCBTWtxlDUgvbux6it8hTrIKrlens
	D4L22eyLWTHWZCKjBqkDUAAo2CxrTm+R/cf4PaSuqvTpJbOy2yZjTO6AKCeNXNvb4totr7gcEwQ
	/WWFT2Uz8HvtXDLDpC9ZqDgV9xQT2xx4=
X-Gm-Gg: AZFdTZcOqipRIrqQmI4oSV2oCDp909qwRkpNsjv4esq7Cj/LCHRZc04J7MmGYEslZAI
	pAPwO67LyLJgrsfjj7hET9l85je4a12TnPfUbnty6lEmtpOAdKAkqSNCCRPyE+Hgk6l5NjX+rjl
	EiIU+JwvVUY7/2yWOwQyZismFYb36pFEwiuRLh+DEFmu9mnS+GCM6wqv4rjb8FWbIjH/H7rEYA1
	1O0d+vm9xMvNjZkzNjmeFsi/IGPOK6Vuk/fLs54SYl2vwVoJ3zNv6P5iRXdbqXWKZKm+jpG1mRh
	HqHDgx3P92mlZTOoETwbB5Ta4DQinbaCvBhjm2/B3Y503OqrKdZHNwSNhpqlx9Y46zQRUwQtVeg
	LFCVY6aF5xzOa61BkqlB7r4Q3fJTHFxMwaiNNHPSVdCGkFaBBhyoaNVZq+zs0cANQfquKYmHuF2
	u/BsSnB3iZ3soB4OwzRA==
X-Received: by 2002:a05:6000:4013:b0:4a7:d4c9:ea03 with SMTP id
 ffacd0b85a97d-4abaac57bb5mr35474466f8f.6.1795639768772; Wed, 25 Nov 2026
 12:49:28 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795467315.git.memxor@gmail.com> <853ef5deb34f53b2007ab47699c889b730d87805.1795467315.git.memxor@gmail.com>
 <179554225568.72201.8708250684463465883.b4-review@b4>
In-Reply-To: <179554225568.72201.8708250684463465883.b4-review@b4>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Nov 2026 12:49:17 -0800
X-Gm-Features: Aa3M54qzjev26hb5Nca2jCK4Sa5QD0mvyh0W1pFmyhWTO6F_6YJP81Sa3qIqWOQ
Message-ID: <CAEf4BzamvEFCr4mQ9Dp1_MzVEp34zDy2ZfUQWU4CJnnku-P2MQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 04/10] libbpf: Account for the overwrite
 position in ring__avail_data_size()
To: Tamir Duberstein <tamird@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 9:44=E2=80=AFAM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> > In overwrite mode the kernel overwrites the oldest records when the rin=
g
> > buffer is full, and keeps the position of the oldest record that is sti=
ll
> > there in overwrite_pos. The records between consumer_pos and overwrite_=
pos
> > are gone, but ring__avail_data_size() still counts them.
> >
> > Read overwrite_pos, which is the third unsigned long in the producer pa=
ge,
> > and return min(producer_pos - consumer_pos, producer_pos - overwrite_po=
s),
> > like ringbuf_avail_data_sz() does in the kernel.
> >
> > A 32-bit libbpf can't tell whether the kernel is 64-bit, in which case
> > overwrite_pos is at a different offset, so it keeps returning producer_=
pos -
> > consumer_pos.
>
> This is pretty unfortunate.
>
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  tools/lib/bpf/ringbuf.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > index 78fcb3df243f..271c6b9b130d 100644
> > --- a/tools/lib/bpf/ringbuf.c
> > +++ b/tools/lib/bpf/ringbuf.c
> > @@ -28,6 +28,7 @@ struct ring {
> >       void *data;
> >       unsigned long *consumer_pos;
> >       unsigned long *producer_pos;
> > +     unsigned long *overwrite_pos;
> >       unsigned long mask;
> >       int map_fd;
> >       bool overwrite;
> > @@ -150,6 +151,13 @@ int ring_buffer__add(struct ring_buffer *rb, int m=
ap_fd,
> >       }
> >       r->producer_pos =3D tmp;
> >       r->data =3D tmp + rb->page_size;
> > +     /*
> > +      * overwrite_pos comes after producer_pos and pending_pos. Its of=
fset
> > +      * depends on the size of the kernel's unsigned long, which 32-bi=
t libbpf
> > +      * can't know.
> > +      */
>
> This is because 64-bit libbpf is running on a 64-bit kernel - took me a
> few moments to grok. Is a less obtuse spelling of this comment possible?

I think it's because of 32-bit libbpf on the 64-bit kernel. I replied
on another patch that we probably can try to detect this rare
condition, so that we don't have these arbitrary limitations.

It's unfortunate that we didn't think about this problem and at least
didn't put overwrite_pos at 8 byte aligned position. oh well :(


>
> --
> Tamir Duberstein <tamird@kernel.org>
