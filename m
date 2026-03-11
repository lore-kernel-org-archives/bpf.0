Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084783E6DF9
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252993; cv=pass; b=MV1V73qROcWvJMLfsoQMzL5ZgAWA/7wJkDBf2w4QqNdCehOIReIsvNf0sb41oUK+BPaL2xVecTb+fh1cAVHAxma5voJwb3Q2pFxKoBaU8iR5+IoSxOYrXoIbE54/2N/Bgcc7JRil+I6nfob+ihxvAg0zqFad8knJucBkLZDudHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252993; c=relaxed/simple;
	bh=v721buQXWScEiaXqHXI3JT2zcbjQc4Gfo8mCNU9j1Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfM3OQxCo0awphf6wMgoglk1IDwCvzLwf858Nk1EmToOz4wtjqNBtgWLdnHTEgMqrIBiTjcwF0NbMuKQQuOzOsPLLyclRzmbk/AbFVkuCFQpFJZvP5H8FOdyE85oCSq5JtE2x+jnjYQj7nuCgOGghGsagc4l1pT2OpW09hgE5Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8aYreAZ; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8aYreAZ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c739e680bebso406596a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 11:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773252991; cv=none;
        d=google.com; s=arc-20240605;
        b=kvZ7TBJUy2ELkfuAp1tCKwy42modxuaFma/dgQCWZ9S9zXjUAPaMDmI4o5QD7/bGgV
         ZPuSwLHY/wqapGu/ukWBsOm2sqxB3th1EKrhvNBo4b/+yacek7nk3vcI7jsXfKyYZXES
         i/IFDI+CwqVy30D3QJU/rWuccPrgAj0Tzny+EDxLVj6Zj3KwA/4HC3Y1jpKZt1iWC/V7
         rUlgxv1FNK6PLGAoR8shPN9Qf3c764MeMz377vEvuDVAasH4qhw27Do2k4zhiW1Wp2ae
         Y4fW2QfA/fgN3T/LOcnaY5drWq+YkDbE6Q7Lzguk88zOsHX7H0JvIwrvJ7SsvY7tOLOZ
         tviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rkLIZH9/W21TFY+KxjMBI5W7jWpQrcpS5BGZj1HFBDA=;
        fh=L5xPNRsURXmETLlNZrg53536HPxxn911HZ2bY2AjG7Y=;
        b=S0MPKHfE6AwtSc1VnZikOvIbm7crkQS452VK1YtzE5W/Pe02OpYLERXv4yHVTSHMlN
         +LR4ZMIt9zw0D3KhRM5ugYerWbZKm1j33uGoBjHf+q+XrW1CPNWIkh/A8fheQm2K8ODV
         kWCj5ZZwx8VxieFJiNWXRhhkCARGqYluzgENROHdwVac0LAV+vNqDCLSI5fwHFUPgZZn
         YyFPLJ15+bUlJGOTOEaSTQm7JwzuyHySOetYHWCiNYJkfMbqYCRgwD6s3N+qXtJJWI9b
         ABeHL/H7PDaT0wsNq44VwBPQRVoymOgBnSTJauKlYoYcn17TOP0aSq120oUyxg8Iy40H
         aTIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773252991; x=1773857791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkLIZH9/W21TFY+KxjMBI5W7jWpQrcpS5BGZj1HFBDA=;
        b=G8aYreAZ+snF0n+z2JdRxaYTRpVfLx851rFVao9HMW5uHfkdrQpYMmzOawqn3sn36z
         FGD8ea35hqJS2phbAoG+5NggXjQl/5gpyNvmbpjkow48C5/XK7a7Og2O1EZVtGTniQio
         s4X7hEU4nSlIFRYyEVrD4AJzvnsXahyu/kfZVRD/r6g10mCWhXc/eEziFRldcyyrHgES
         qnIfax4PdiV9x7FI3SAQZ9v8rtxpu2aob81l2+f5ENT3ZvI11H7tgOPmi0ga8SHDIRIb
         Yt/yP0irFL6K2IFXe/dq5x8aHrm6EtGMvn83Kr0FcESLyEhbmqbXUdj9DH6OuQ7U7Xqj
         qkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773252991; x=1773857791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkLIZH9/W21TFY+KxjMBI5W7jWpQrcpS5BGZj1HFBDA=;
        b=B4VcnNLirP6f/alOOkEHSBZvR63RxzW9aTcYJLjyoIhUoTHvG1kZ0hW4NsnZmzzmy6
         3OSzWKEyLmBdeEcxE3Gq1o6WZCHMC5KwVnBDSuoOmx/Gh85s5t8lZdcnB+tbEcK20tvl
         ajBWpCvNHP2FKDBhOhMwxGvU1H7knqv01ZSr36QpOE4fE6oNQ86tzhaPFJINpsImJjdX
         DKwWFkG1jrpfCRlViiPTckUtRI8XVFvcnhwaWkwczHkJxXmbawBZLDrtnCYZoJcc/YnJ
         hk9uqsVXEOES8GG2rdLuuqoLRQqdu4KXVhXg07am8iPIb9D+iqvcRtSHEk2PXklcESCJ
         8Cxw==
X-Forwarded-Encrypted: i=1; AJvYcCVodOcMoKVtuB7bRVXUcKYRd8/5Okf1BNe8xkFNCVZN3usP8xDkBp+zfcX30Y6d9aPlDQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCb5AOiC0PJZrFVqaYyX+zKM9IcVHie7Z73CEBcGy1JORmQFa7
	8MIJIVo0IOBXKUwHZI3m4CrjLxEOgBSaUu/zgwgaCliq29s+rH3qShtDzINvntA6lDdCGvKuRgC
	vu0xBXM3FjvtZcANV7PwZaXMAg1vcTyY=
X-Gm-Gg: ATEYQzzBtdaJY1Jk8Kzq+mJq9JrnWMmH/ppZpniQTxzSfolnB7TBRKNCdmrs1EpSBiJ
	5Q9lejeC++9i2NcM2XjF14u7cF77ee0DQ+Ywm+scvMWMSZi3u92lDh1h7F6rWS/QYJxS46L1JdV
	J5i3/X+cV5+QZC0klVj85yWj8W9BD7K656U7ol6rZ4QUgzw9Mp3x1Y1JIVbbYMXQdoXYZ9O/cPB
	29gJD1W9d8l6C6YN8J0SFFT6KcznS5SWYAoQDttPApP080NwqqerTTkbht+RWRuVQlRaoX747wc
	9cZvgx4=
X-Received: by 2002:a17:902:d54e:b0:2ae:4ad5:b76c with SMTP id
 d9443c01a7336-2aeba4753c8mr4403515ad.10.1773252991222; Wed, 11 Mar 2026
 11:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306113630.1281527-1-alan.maguire@oracle.com>
 <20260306113630.1281527-3-alan.maguire@oracle.com> <CAEf4Bza_kJowGmin4Hh2iOpwXZVgNoeGNniidSpZEjRjqWnVyA@mail.gmail.com>
 <128e9cac-c935-49ef-98df-30f3b6cd7822@oracle.com>
In-Reply-To: <128e9cac-c935-49ef-98df-30f3b6cd7822@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 11:16:18 -0700
X-Gm-Features: AaiRm53ugynNFDPuMYw-OIyz79aaybCfAwXypomT0BqpvKOno3TFHWMQoe6x_1o
Message-ID: <CAEf4BzZefR6qQwu1jENEMg15UCXXnfqfwHYRV5y4NAXWwuo4zw@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 2/8] libbpf: Support layout section handling
 in BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 11:10=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 11/03/2026 17:46, Andrii Nakryiko wrote:
> > On Fri, Mar 6, 2026 at 3:37=E2=80=AFAM Alan Maguire <alan.maguire@oracl=
e.com> wrote:
> >>
> >> Support reading in layout fixing endian issues on reading;
> >> also support writing layout section to raw BTF object.
> >> There is not yet an API to populate the layout with meaningful
> >> information.
> >>
> >> As part of this, we need to consider multiple valid BTF header
> >> sizes; the original or the layout-extended headers.
> >> So to support this, the "struct btf" representation is modified
> >> to contain a "struct btf_header" and we copy the valid
> >> portion from the raw data to it; this means we can always safely
> >> check fields like btf->hdr.layout_len
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  tools/lib/bpf/btf.c | 309 ++++++++++++++++++++++++++++---------------=
-
> >>  1 file changed, 200 insertions(+), 109 deletions(-)
> >>
> >
> > [...]
> >
> >>
> >> -       memcpy(p, hdr, hdr->hdr_len);
> >> +       memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->hdr_=
len));
> >
> > in all these cases where we have sizeof(struct btf_header), this
> > smells like a potential issue, tbh. We are silently truncating the
> > original header here, potentially. Which is ok for read-only case, but
> > do we error out if someone is trying to modify/write such BTF where we
> > don't really understand all of it? Should we?
> >
>
> The kernel enforces that any additional data in the header beyond fields
> we know how to deal with is zero. We don't enforce this here, but we
> get a similar effect since we only copy the fields we care about. In effe=
ct
> we wind up removing the aspects of the BTF we don't know about, so if we
> read in such BTF, writing it out would not preserve any additional header
> information (say a new section offset/length) beyond the current size of
> struct btf_header. So writing such BTF after reading it in converts it to
> the BTF representation libbpf knows about (header fields + sections).

I don't think we should be doing this. Let's error out when someone
tries to modify BTF where we don't understand *all* aspects of it.

And also you hinted at another missing part: BTF layout info
"sanitization". Check bpf_object__sanitize_btf(), I think that one has
to drop layout information if kernel doesn't support it (unless kernel
will ignore layout info).

Either way, can you please manually check that BPF object having BTF
with kind layout can be successfully loaded on old kernel that doesn't
yet know about BTF layout?

>
> That seems ok to me, but I guess the user might want to at least know thi=
s
> was happening; would a warning or similar when encountering additional
> non-zero fields be helpful maybe?
>
>
>
> >>         if (swap_endian)
> >> -               btf_bswap_hdr(p);
> >> +               btf_bswap_hdr(p, hdr->hdr_len);
> >>         p +=3D hdr->hdr_len;
> >>
> >>         memcpy(p, btf->types_data, hdr->type_len);
> >
> > [..]
>
