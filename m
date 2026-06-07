Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD61DE8AE
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780816341; cv=pass; b=HX4/lKyaragDSaaaMkxGKjDd8mo5D9Fbt+D4XzH69z2rdF6OO1N/YzNnpX0F2AjpJlXDHjHkex4ppG/PVU45T01JpJymrNWdWu5YpLJHU9GeJ8NTQviGkfH37TGsf5nfOKSDZ1CXyeUEpapkUb5WiiaUKrH6K8fcBrh9CNeieho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780816341; c=relaxed/simple;
	bh=G7luavM/r2nql26XEifNX/X2mZPj9YNSfOeR7LbWUBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRdW5I4yjvOsSbIM+J0W5aBKhMiFAXFVMfpxzOt5/JdB4u7brr5ni0nZsMDcCCZ7J0cjK2jTsB8S0//HA2vtHsSR9iwW/65pr5SnTqO6QyPUIBsV1GdLcKLUU3jkC3RpfdV/FubBMD19dHROmUvSrWHFD+BGY0a1m35Lv/7YkkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPCchFCy; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPCchFCy"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bec354815b9so333951266b.3
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 00:12:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780816338; cv=none;
        d=google.com; s=arc-20240605;
        b=ASmF2Cbmerg4ekngbNxN3WEpqyLxApJ/g/IKPaOc4yC8/rnvmo5VjIoy6IvZixBpzg
         CIJmLjhlDx1U3Md+EQZf6JcEnHc7lMKB4dU9qhKUl0E8zz6Gf6ehL9qUPGtmqua8+sNO
         JMS+sabG/pXmq+0wF9iPzJCXrRueJL7wahs7l2azYzQ9WXAqMdCUqbXZKM8h0Cz5Uj2W
         w++/wUN/lqLlk35bzwbP0zp9OU+5k3e0C6IP+C6T02ascQzIx82eYZB2HoC0cyczWwPB
         13UwaFnkuHbP18cKL+mCF0UkmQY2Wf/37qtNa/foKG93hJZQvsFG0vK1BG+jF+OL7VIU
         wG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B0ckcyoETbXT0qw1CXSwY+Cor9uhDO3R8JWwhYej1Us=;
        fh=78L2agMsSesHOvC78om5KEJtFFOfp01JVxLjVZJw7CQ=;
        b=UMRawy8ZDYDvRnRa06UyrKuZzeN9FYEDKGBheqtyEG2qT0pazfiCJRNd2hrZltD7l8
         bIH6o5D4S1nye2hSSogmrJeLfJtqho0wwBI4+TNl3PYvVUikR9EM0nE6C37qlGNVptsF
         M9WUQcclBhrPjngW8oXA/Sa1q5UWBOZX2yWdfnurOzlE0Gmv0bfu1f5wLJv8hTf8xO4r
         jNoWW8Yy5NJFsx3iZrdhg7cwljvDFaBWv6ZMDM8AZH7p4ovXRWp2kQuopBxUsFmIFglV
         zL5N9s+LyyYUmDgXBYXjMaMym2IPjHP622qLcG4yOFheIwDIBgZqaBeP3wr3EspD0DWs
         b7Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780816338; x=1781421138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0ckcyoETbXT0qw1CXSwY+Cor9uhDO3R8JWwhYej1Us=;
        b=CPCchFCyFWWTVeOWxXH9U/QSUsLMnpJd/IzNTYyLJmN2Hp382AZmfgDUkiLGGfaziD
         7zURK2yfL7e6cN1p1J5nzcKKo6DRss4cOBwIehyX3jW3rGfzxkJkj2MSV0xqd4tKfr0K
         RZ6Xz0sPRxFf7GkXQxZcpsQSTSBQ5AHszXCsHELpZvYimxWPTZLhy8iEB3qNBMcnr+M0
         HozJU2Iplzldpp7PxxQR6GBm2GZGB0u8olOdaevD0Gh/aIfnYN7OIniYjLhfLDmusaWU
         0SAqCdqWHC+hUvN5DumxID4qTY9r+9+cXV1q48Uy4XC/BCDHAjbVQYpAVCqKvHFYmrP2
         dIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780816338; x=1781421138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B0ckcyoETbXT0qw1CXSwY+Cor9uhDO3R8JWwhYej1Us=;
        b=TF2FiYooBUyvw96VgMHh+QJFpktFJnVfAARGg2Lpk6Tj9dj7fr2/Cd3kmqDi61+Iq0
         sGhtAdKuhC3B8wlPKDaY5ShAoQDTkgd8ghuXx7IwHSTqd4No8zXuSpYdrle4omzsIJku
         xu6lz7MdBSZA2hB8gp/Jxfy70lDIcSoyJqQcZxpI9WAhEmh+6zZDpTY8BL14XKOGvq7o
         BUB9MZ/WGrRNvKZH0dvxdAv3DcgGGC/KTOTRw7SuLHUjkuZYVpd9QH5KclJi3DC7F/wj
         jjOBW+toQ5F3bdz7xO7HfHWxcHAoVBcWlRGhUwsVlNPDLKuotblUZrFTlBzKhAoQzIkw
         mq4w==
X-Gm-Message-State: AOJu0YwSiq1ok9dEJKb9ZyhkaS5kh2cq1OYgCrOn1EUmTFEC/IjUDDL2
	tiB6wjjUprrMfn1UvNealjQ/yBo3KPiPCoWSQYS0i5BtnogwNbfBXm6a28abOCMzTJjc4oB92S1
	/VhoeDJn6eG5t5orwuezd1ZH9Fk7KBcm3OCPuPRTFp4QK
X-Gm-Gg: Acq92OGfS+S1IoJrFUCPM1E4UFPW6n+Htrv4sTUhMTjFjH21tpiC5drrVAhPGIUy/Vw
	/xJq4sHY3fFQKFk8o9ajzo0c91giih36MISsk9rHkVDuanh63nxm3JqKQ2sFn11leFtAwoZbryk
	Gx6xHwHysmla95+HtR2OCs/WMFNxEVgQZhmiDWULi75VSJFKg99OE+Uc7Y9yEkCZjCGJcXqEDyS
	Gp2FgqYsM8N32vMzjG9Ua1xWAfVvPpJ5Yq5WEcL89SihjboWFP+sctzWgBoiZPtreo/ppVe3E8z
	XpV/YMOxKbdgkK1tRw7nnXDMhz91Pa/sUq7Beyh/vTxXFMrOuhSdcnxdSkLhCA==
X-Received: by 2002:a17:907:971b:b0:bee:bbaa:f19d with SMTP id
 a640c23a62f3a-bf37057b43bmr467387166b.14.1780816338088; Sun, 07 Jun 2026
 00:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604134019.39161-1-yimingqian591@gmail.com> <20260605134041.623E31F00893@smtp.kernel.org>
In-Reply-To: <20260605134041.623E31F00893@smtp.kernel.org>
From: =?UTF-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Date: Sun, 7 Jun 2026 15:12:06 +0800
X-Gm-Features: AVVi8CeiV3ArOCRHeHEGu_Jx0-sEP06IN1T27ooceEn3WQ_RqB_prKHofa4QHtM
Message-ID: <CAL_bE8JcBEg37HDj7ri7b9g=VMS662PFGWCzA6J0msCA4oHZBQ@mail.gmail.com>
Subject: Re: [PATCH net] net/tls: preserve sk_msg sg.copy when splitting records
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Keenan Dong <keenanat2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review.

  The sk_msg_shift_left/right issue is the related pre-existing sk_msg
  sg.copy bug that I explicitly separated in the report. This patch does
  not attempt to fix that helper/shift transform site.

  This patch is limited to a different transform site in kTLS:
  tls_split_open_record() copies SG entries into a new sk_msg but failed to
  copy the corresponding sg.copy bitmap state. The fix preserves that
  metadata only for the entries copied by tls_split_open_record().

  The other findings appear pre-existing and independent. They should not
  block this focused fix, and can be investigated or fixed separately if
  needed.

<sashiko-bot@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=885=E6=97=A5=E5=91=
=A8=E4=BA=94 21:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] tls_merge_open_record incorrectly merges naturally contiguou=
s scatterlist elements, leading to a page double-free.
> - [Critical] tls_split_open_record() ignores the split_point argument, le=
ading to an out-of-bounds write in the crypto layer.
> - [High] sk_msg element shifting functions fail to shift the msg->sg.copy=
 bitmap, allowing BPF to overwrite externally owned page cache memory.
> - [High] sk_msg_alloc reuses freed scatterlist indices without clearing t=
he msg->sg.copy bit, causing valid memory to be treated as read-only.
> --
>
> commit d2043cc374b476d5c2b7d9a3d811593ca2bebf5c
> Author: Yiming Qian <yimingqian591@gmail.com>
>
> net/tls: preserve sk_msg sg.copy when splitting records
>
> This patch modifies tls_split_open_record to correctly copy the sg.copy
> bit state from the original sk_msg into the new sk_msg when an open recor=
d
> is split. It introduces a helper sk_msg_sg_copy_one to facilitate this bi=
t
> copying for both partial and whole tail entries.
>
> > diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> > index 19f4f253b4f90..f3988ce2219db 100644
> > --- a/include/linux/skmsg.h
> > +++ b/include/linux/skmsg.h
> [ ... ]
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index 964ebc268ee46..434753de8aadd 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -623,6 +623,7 @@ static int tls_split_open_record(struct sock *sk, s=
truct tls_rec *from,
> >       struct scatterlist *sge, *osge, *nsge;
> >       u32 orig_size =3D msg_opl->sg.size;
> >       struct scatterlist tmp =3D { };
>
> [Severity: Critical]
> This is a pre-existing issue, but does tls_split_open_record ignore the
> split_point argument?
>
> When a BPF program uses bpf_msg_push_data to expand a payload beyond the
> pre-allocated encrypted buffer capacity, tls_push_record calculates a
> necessary split_point and calls tls_split_open_record.
>
> However, tls_split_open_record ignores the split_point argument entirely
> and unconditionally sets apply =3D msg_opl->apply_bytes.
>
> If apply_bytes is 0, the function effectively splits at 0 bytes, creating
> an empty msg_opl. The fallback logic in tls_push_record then merges them
> back together.
>
> Subsequently, sk_msg_trim silently fails because the size is larger than
> the target, and tls_do_encryption uses the undersized buffer to encrypt
> the oversized msg_pl. Can this cause an out-of-bounds write in the
> scatterlist array when constructing the crypto request?
>
> > +     u32 tmp_i =3D NR_MSG_FRAG_IDS;
> >       struct sk_msg *msg_npl;
> [ ... ]
>
> net/tls/tls_sw.c:tls_merge_open_record() {
>     ...
>     if (sg_page(osge) =3D=3D sg_page(nsge) &&
>         osge->offset + osge->length =3D=3D nsge->offset) {
>         osge->length +=3D nsge->length;
>         put_page(sg_page(nsge));
>     }
>     ...
> }
>
> [Severity: Critical]
> This isn't a bug introduced by this patch, but does tls_merge_open_record
> incorrectly merge naturally contiguous scatterlist elements?
>
> When tls_split_open_record splits an open record exactly on an element
> boundary, no extra page reference is acquired.
>
> If encryption subsequently fails, tls_merge_open_record attempts to merge
> the elements back. To detect a split element, it merely checks if the
> pages are the same and the offsets are contiguous.
>
> If the user originally provided two elements that were naturally contiguo=
us
> in memory, this condition falsely evaluates to true. tls_merge_open_recor=
d
> then adds their lengths and calls put_page on sg_page(nsge), improperly
> releasing a reference that was never taken.
>
> The element remains in the scatterlist, resulting in another put_page
> during destruction. Does this directly cause a double-free on the page?
>
> net/core/filter.c:sk_msg_shift_left() {
>     ...
>     do {
>         prev =3D i;
>         sk_msg_iter_var_next(i);
>         msg->sg.data[prev] =3D msg->sg.data[i];
>     } while (i !=3D msg->sg.end);
>     ...
> }
>
> net/core/filter.c:sk_msg_shift_right() {
>     ...
>     while (i !=3D msg->sg.end) {
>         msg->sg.data[i] =3D sge;
>         sk_msg_iter_var_next(i);
>         sge =3D tmp;
>         tmp =3D sk_msg_elem_cpy(msg, i);
>     }
>     ...
> }
>
> [Severity: High]
> This is a pre-existing issue, but do the sk_msg element shifting function=
s
> fail to shift the msg->sg.copy bitmap?
>
> BPF helpers manipulate sk_msg scatterlist arrays using sk_msg_shift_left
> and sk_msg_shift_right. These functions physically shift the msg->sg.data
> entries but fail to concurrently shift the corresponding msg->sg.copy
> bitmap.
>
> Consequently, shifted scatterlist elements incorrectly inherit the
> read-only states of their new indices.
>
> If a read-only element is shifted into an index where the copy bit is 0,
> sk_msg_compute_data_pointers will erroneously provide a writable data
> pointer to the BPF program. Could this allow an unprivileged BPF program
> to write to externally owned page cache pages?
>
> net/core/skmsg.c:sk_msg_alloc() {
>     ...
>         sge =3D &msg->sg.data[msg->sg.end];
>         sg_unmark_end(sge);
>         sg_set_page(sge, pfrag->page, use, orig_offset);
>         get_page(pfrag->page);
>         sk_msg_iter_next(msg, end);
>     ...
> }
>
> net/core/skmsg.c:sk_msg_free_elem() {
>     ...
>     memset(sge, 0, sizeof(*sge));
>     return len;
> }
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does sk_msg_alloc reuse
> freed scatterlist indices without clearing the msg->sg.copy bit?
>
> When sk_msg_free_elem or sk_msg_trim frees a scatterlist element, it zero=
es
> the sg.data entry but does not clear the corresponding bit in the
> msg->sg.copy bitmap.
>
> If sk_msg_alloc later allocates new memory and reuses that same index in
> the ring buffer, the stale copy bit remains set.
>
> Because of this, sk_msg_compute_data_pointers incorrectly assumes the new=
ly
> allocated, writable memory is read-only and sets msg->data to NULL. Does
> this abruptly break BPF programs that rely on writing to pushed data?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604134019.39=
161-1-yimingqian591@gmail.com?part=3D1
