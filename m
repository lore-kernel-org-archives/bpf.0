Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6800F4DAF88
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008826; cv=pass; b=MYl/FUEL/bqh2EElqaueHv1aExj6DQdmiFU5JnyO2lrwTvwrvivBFh3dIRFqTK4joLVVqatoHjPXmmFSXaFN+Jn4aSzEpPGteIwRuYy0/ZpA7R7Inbu4LnYU5u5y+/28J+OTKBrLPEFNbDLemhRUu7mMP2I/qri6hdGqwLHGF9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008826; c=relaxed/simple;
	bh=5Be34nQAzZfx7EoJzQieDRwSrmNJWfYgzYOdriGhY8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y11rEyxzKz/CgFSkWKEzGZ5UO8FQrSJGAZJLPiflENk6QiRpSJufPZe368s3iKJc7bAoCT5Sw1zX0JZi7oI9MZCcy3Wzyh4Sog/g1Sexsdsq+vwmkqTvtcF9s3omDnKuuOOaNpoX1h1ZKnVwJXmOuvK4FG2Fpua5XgUgbm5fVh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oiI9/W3I; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oiI9/W3I"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-498012a61f6so76305e9.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 09:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790008822; cv=none;
        d=google.com; s=arc-20260327;
        b=XlqX+KSmZH8ANPf7IMI+nVXzQt0lPCJ3AiB5ckqzOhE5C7p0GJoIyoKsSVutg3AfhR
         zPafPy9skSJ8w4u1wWkMQqVnQEShZic9liBdFaqY29E3TsU+pXNoNcatS8ajEbhr16aD
         yo8hlyNZP7H8SRXn1/uuPxJiR9t0RfOcO7q/lqYUHwUqFmfEvPf4ifaNYqVWJnlKXu0v
         7KV1qMz5ZTjDmS1L/ds2BqIazjNshr7KDDDWTZjFBrz6k719J+lLtVvmxIDM1F3csHb1
         eRRwnNZgOxe0EefjwJ6BPR7n/LgbVNaXLmbxguqIZtLGVu8KhZFDZHyQczdpkgeay7UE
         hWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RtzXQFwnjNHYsoXZmKYlP+Kf2L9hheYVuKPWeaO1pHs=;
        fh=WKwBlbHojf9CdvFSM+PzF+XlvRwvnMy09r3yhqzY2YY=;
        b=XkApTFxl0+UnQ25V1TERzPlmvwFxYbrwLtfmvR6ZzmcHaTBZ4tCu29uy1i9rhCl7kN
         G+doRmZnQhVwz9T3SkmSpTIrA+XEnpszvG4jCmuZcXzhhPFVFm9kjm+FgVw1GA8Hxl0A
         x7mrSVYVwOGCPWBr6UciA68Nl7DAjEhbbQjhZX2JyERTpoR3kpxAnIj3te35rCAAiTLb
         g4xhh7Ywb/EztiQaM+gygF6YTEgCr/rrRCzdq1z0ZiDaWqJgTU/xTKjAa/cieiI1mnE+
         cnDqGQDKEwXY86DUtaJ2UzOXsoq6s/6yLht8ANtvMZ35/MLET/eJt/RGCZD/pqN6PO4r
         Ty8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790008822; x=1790613622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RtzXQFwnjNHYsoXZmKYlP+Kf2L9hheYVuKPWeaO1pHs=;
        b=oiI9/W3IUzmBmCava0nuE/rBjOk6E7NWujUShvPcMI0IWBItd6LsHTdRqfjKavnRs1
         idN3NBqYppXVXCWUJwzYpLhVgwaCh5+wGfEklakPuOocnilwBEOL5BjuTF4+li3x6qc1
         BnExb0fUGj7PI96Q7aaGZ+/slTEexNriwdvH6ICUMtrlWp/dDRkhaJT+lCBCjdtt5whJ
         GIQj1whsh1kiBHL1EEFybwXqYYJg9YTyLiWKRWDZNl1g7Ubor2UM9LL9QQGCkLJFj5EI
         sqTX/SP1LD0J1wQ9p9Fx9njgshpB5k9drNbH+nSJ5U/T+Y1Gv6tQFS4tXuGQYmlfMCu4
         XtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790008822; x=1790613622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RtzXQFwnjNHYsoXZmKYlP+Kf2L9hheYVuKPWeaO1pHs=;
        b=UycgPqS/0ggRhrgGig8bK/zNiAgPPojzMKf81c6loVshfsZGFDACb0WbS+fV5KRAQb
         yF59JdueunITrQpD//xwNKA7olCCJ1iD5LUKZj6bN3nTscsc52wL42ThxZO08SM1VsLJ
         QhQYsqkYlx0JA4PlSc9L3ohBDoud1IgS6phZEo+glKszwtx5gS2/WFy8MEsMSZ2tRgWN
         kpJlO5sKnm+iBOkPxXgF5y8NDOvdBu+R9/c+N2eoXC3CWIWUXniowDIF9TP9pBOc8pLH
         t7LaGc7VXZG8QmYAsiX6T+R+JHSsxvnjgq1RfMEZJoN1tUlGJsWbCO1iM3S84j2e1NDQ
         Vn2g==
X-Forwarded-Encrypted: i=1; AKwUvBzTpc1vJ5Z7KVvXLhwTO30whkkmqg9AyJUSqyEkixel0wDpRzj1hzfiqgaFGvdvu4GnGyk=@vger.kernel.org
X-Gm-Message-State: AFuF++lio4X1T71w1tDyFjcPJUpcFycUlH6157evcNUc9C1QBnHGzEMl
	hHWVWEOn7tvpyI/IBKqxNxe+GBypt8n/S2k9G6ufsX5200IY4KFQQ9PhwWw7frZZhYufO5xNW2S
	MKWxC3MoM8QhfmQE4BbBRYX5U0hNsXLNHEIahl0QF
X-Gm-Gg: AYBFou21FZD+S/yGiRB9AlL9lqeKySWt83O8MgqL+9txYKMq78wjKmeGVTvkn5ieswQ
	CmnXKVroSLqHzKFsWEjsZv5oPgu/uZEHAA5XMSG6ZQaxfX9fiwSXHsaImsu8Kc2Tlg7hHFwqd8b
	6gjdO5OnjSFZNPkr+Je6BRwANrbcNf9EEgA1D+uwcO3KLteG1uqebuMQTtkwaH+kLJJWvl6TDe1
	M6lB7SxbH6qt5X4n1XB8X5zomFo6aXZPrOhYlPcNxOO8woj7QFpAHxYiOd0HgvJ0N/9+N6qge2i
	80e0q//RZEvcqFQUmRC58uWgrX0S/XQZdbQyhOoDaOGOKe0NgP/FnoTnXsLkj0OE3Vxtazz0nsB
	bxFD0IT9Foq8=
X-Received: by 2002:a05:600c:8a09:10b0:49c:fee1:5095 with SMTP id
 5b1f17b1804b1-49fcd445631mr1323105e9.16.1790008822204; Mon, 21 Sep 2026
 09:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921002206.184660-1-tjmercier@google.com> <20260921002206.184660-2-tjmercier@google.com>
 <DLKKZEHWGP2Y.2C0DPQW74COKW@gmail.com>
In-Reply-To: <DLKKZEHWGP2Y.2C0DPQW74COKW@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 21 Sep 2026 09:40:08 -0700
X-Gm-Features: AcwNN1WcCwaNQ6LsTFn0mdCbRZGKeLUuNw1COTZgAc7X0Ka-SteJgzcq3awIPR8
Message-ID: <CABdmKX1tUodTCcr2bi1eSdWiGOOBPaE98jYOVz8BkCa-ZSjA2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: htab: Split htab_elem_lru and
 htab_elem_pcpu off of htab_elem
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 5:51=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Sep 20, 2026 at 05:22 PM T.J. Mercier <tjmercier@google.com> wrot=
e:
> > -     if ((u64)attr->key_size + attr->value_size >=3D KMALLOC_MAX_SIZE =
-
> > -        sizeof(struct htab_elem))
> > +     if (round_up((u64)attr->key_size, 8) + round_up((u64)attr->value_=
size, 8) >=3D
> > +         KMALLOC_MAX_SIZE - sizeof(union htab_elem_all))
>
> sizeof(union htab_elem_all) is the same 48 bytes as before.
> The round_up() part is an unrelated change in what map_create accepts.
> Drop it from this patch.

Ok, but I should do something here. I'll drop the round_up() change
and use sizeof(struct htab_elem_lru) here since it becomes the largest
variant. htab_elem_all was only meant to guard against a future struct
becoming even larger, and without the BUILD_BUG_ON below, union
htab_elem_all isn't guaranteed to have the largest element in it.

> [...]
>
> > +     if (htab_is_lru(htab))
> > +             elem_offset =3D offsetof(struct htab_elem_lru, elem);
> > +     else if (percpu && !prealloc)
> > +             elem_offset =3D offsetof(struct htab_elem_pcpu, elem);
> > +
> > +     BUILD_BUG_ON(elem_offset + sizeof(struct htab_elem) >
> > +                  sizeof(union htab_elem_all));
>
> elem_offset is a run-time value. BUILD_BUG_ON() works here only when
> the compiler manages to fold it, and it cannot trigger by construction
> of the union. Drop it.

Yes, it was intentional. Dropping this means we can't have
htab_elem_all in hunk above, so I'll drop the union too.
