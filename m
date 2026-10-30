Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385188;
	b=0vnR0heQl8tJsD8fLCmn0xmYMcbgHo/YVe2sZPwnJR1l2eeshWKxRHf7jWQhf2YQRAtC
	 bv9vyLILFstO3REdStsyZxTVFm0f5/d1UVRNVI5SzzT8J9qWhd+iJuCy872GWPKe50Nzk
	 KiQN3Fra5GL91cO5mQj2fjEP0LGcNXxaLA2sqnjdEtRcO2WAEiNgeABk7ukGkVBb2ha/x
	 l+zHmhqRBtB2IXNnB1ii7JY/P9IzBbjD6uKinBRePSnDomwF6Ns88ACf6dHAoYd7vPZfe
	 aNIBQ6oKNkbT9PXcCueyY56QQJi/kCfd75HvgfSMl4T7sOiFOUbHlyg74ewbUL2mEfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=LqwO/tbXEMHl9nOAdKfhCSfefmnSAVqYf2mSAzV9dbw=;
	b=r1Mg8rw/Dm7YPIdf8KxcscgFiPHpYsqw8PNDirteMtFdBvVgMjwWzgv9JimYYSP0mr4w
	 RlsM7rpCTUblMRjOUvabmvUp1DoNpCRm/1nvfxJNSPghjK/hf/GP4GamJdJirX3ak8eV2
	 /VOINtWsIstb0CspOHI2NdmBrEIuUkcVvlBIkWgqbzgLvQUBCsxGdo9pwdU2ZTsuEYB0m
	 QM2BCBFAyNHXpAc85xfH5N7ilfwQYn5Tkuk0VIB6laKCY8JJNM6mgXi5dacPVmkM+7CXV
	 +xdVCQevCmmiQ82uqGTqvU5F6U77a2FChevgBa2l54h1TTQWuMnhtpsBvnQnxMYrCAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xhYb4R9K;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543D606A31F
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 18:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2543D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xhYb4R9K
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso439086b3a.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793385187; x=1793989987; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LqwO/tbXEMHl9nOAdKfhCSfefmnSAVqYf2mSAzV9dbw=;
        b=xhYb4R9Ke1pTbYaBTbVPzyJbfQ75coDEa6uWXn6/sNo3GzqjzQKUd+RPmOwaU1Pchd
         9nvrvbd6PS/ug+Rjmsp0eojNT2kGZH48VrRb0EaRVtDJXVh98Mu8UcrFXr2QZEUiobyT
         Q/NgTTE2dK5NxejmA519jIBnqvIWmXWAtePFO3DhA934zR47V210H3H6JfE0Eq7c/bYT
         LhIM79VQi3YdewhRCSgcAbOLlSLvc/jj+w+vpKjx+qnRRYJs4Y2b54VgpS3zei/sStzd
         eGKvDygp4jzAZPeVNSc9uykE9p0BKQ0dgJOeOsDOvgbki0BjaDXaAXQMm84dTghXGs9D
         0soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385187; x=1793989987;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LqwO/tbXEMHl9nOAdKfhCSfefmnSAVqYf2mSAzV9dbw=;
        b=1TplWokVy0zWI/64FS7oe5UrZaHh3yZ1uwo2yojkESfN1nEL3MSp6FWPJHsg05JzNI
         LXA2y0oWFfklg2OrueSupZQYiKWzb5pUWylL8wgxJJyFoz4IU5M7o3ZA20IlifjkGdJ0
         rOEzIuB2ZmBUrR6XYcz0hNzA4Me0TCSkRtJUFctpv2dYMGuIvTnHYozjJL831ANM6RdI
         1E7gBudJ11+a9F+clckTctcEfyZddfIdz2JmERP3HE7TOXrkYg0W++xa8WyAquyZHb9P
         VqS8bT4oGdLW4+217zxpIYVk5B9zJiSYm0lLKaESv9ietLFvgpxMBka6CuATzqKJ9sZL
         CRlQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjzvCZF2zebN75r7C/hDo0XsTj1LcyuLgaW5Fxv5s3SGsYYpsaBm1MLlSJR24MwDxu21k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcgok9qrSgjfZACkgNYNT9f6Hx43Noe2SLlZr17jQJlvz2DYz1
	l1ch7KJEe3XzgPXB/i0hyhUajukSZ1uKNpxUg0pptP4wwskjGjjCsqLO
X-Gm-Gg: AYBFou0ih716YDd46PSNfcbxDoRxAmT1fq/B7TmT8fGu3eg1Y6id57nAm0awNeZ7/Dm
	zV7QH4K55r0zuguLqSTMV3ZbMNSf+b2MwJNdAW7o6LZ8NTIygqQf0fUDxpfgoVx1bH+0zcjSjd+
	y7AMAZTz/wmh3yseKlTDrJ8sYh6kcDYGrNuczJo36G1XhjO2jRjU+w+VahgqmTSpUk0fxSxzj3/
	9iryfXmxRugbq86voHwvQppZ5uL9g8IrnMxpuiGQkqRROQsDg2uL3pj4etg+saCye5k5cdTMxbW
	SB/eiWoQdPLKxWKKcK8EI15YAFdEwuF2K6npSA04wnotn9v/fZ/cB5jmR8cFO66n8eaWNamq0d+
	mZ7oHQ+JOHX/XBOOE6gReWGHaoXw5OkqqSuyFXJqcu0zE9EtLl8nUaIkKCZEIS6nejufEmuxTa9
	0Jh3Iw4+vJkPoKJoGm2XzEN6VEYmyuEGwcSRX0d+5IcJpbuEeDDaVBPJO1lzlYkei1Q3Lfu1sq6
	W2k6X57/BXISBossuqoFXlL6HN6TJYawiq9n4Ja447iKFLkPNT5uyM5PgSldURrYgl8UWQ0UJeU
	ScxHfQ1DBkoVbm/flZHakasZ9+Fa4iKqjopFt8qzE6hTnXVvTAZcDbpdIq40Ox0nUVNb7CgWTkL
	aLKjlfLoEj+w=
X-Received: by 2002:a05:6a21:2212:b0:3e1:d43e:367f with SMTP id adf61e73a8af0-3e9290ff9f2mr3005488637.73.1793385187421;
        Fri, 30 Oct 2026 11:33:07 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5d10:1794:f0d8:db5b? ([2620:10d:c090:500::4:1201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aadaf86e6dsm336098b3a.57.2026.10.30.11.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:33:07 -0700 (PDT)
Message-ID: <727459335119599b851b7a1ed72dbe6220e14571.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 11/12] [do not merge] bpf: Track low-32
 scalar equality across narrowing stack spills
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Fri, 30 Oct 2026 11:33:04 -0700
In-Reply-To: <20261020161907.2115379-12-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
	 <20261020161907.2115379-12-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-10-20 at 09:19 -0700, Vineet Gupta wrote:
> A spill narrower than its source stores the source's low 32 bits, so the
> slot is their zero-extension -- the mov relation, in the store direction:
>=20
>   r6 =3D ...                  /* full 64-bit unknown */
>   *(u32 *)(r10 - 8) =3D r6;   /* slot holds r6's low 32 bits */
>   if w6 !=3D 0 goto ...       /* not taken: r6's low 32 bits are 0 */
>   r2 =3D *(u32 *)(r10 - 8);
>   if r2 =3D=3D 0 goto ...       /* not deduced today */
>=20
> A store never sign-extends, so BPF_REG_LINK_ZEXT is the only kind that
> arises. save_register_state() copies the source whole, including bounds
> for bits the store did not write, so the slot must be truncated before
> the kind goes on it -- otherwise the first sync_linked_regs() intersects
> the correctly rebuilt low half against those stale bounds and empties
> the slot.
>=20
> Only one order pays. sync_linked_regs() walks spilled slots, so narrowing
> while the value is still on the stack narrows the slot and the fill copie=
s
> an already narrowed value. Filling first does not benefit: the fill is a
> mov, and a mov drops a zero-extending link.
>=20
> Posted, not proposed. This is the direction asked for, implemented and
> measured, and the measurement says do not take it. Against the ten patche=
s
> before it, on 441 cilium/katran/fb/sched_ext objects, 1467 programs:
>=20
>   verdicts      no change at all
>   total_insns   102 changed, 63 worse, +84,450 (+0.34%)
>                   +59,616 (+57.2%)  104,160 -> 163,776  test_file_open
>                   +19,784 (+89.7%)   22,053 ->  41,837  rusty_enqueue
>                    +2,688 (+40.6%)    6,626 ->   9,314  layered_enqueue
>   total_states   64 changed, 63 worse

I'd still prefer to keep things symmetric.
Instruction budget should be less of a concert for 7.5,
as far as I understand.

...
