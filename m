Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.130
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793034014;
	b=pwskjCQYSTfszy2MA6LqFfi7X3Echxcx6hprMvyKuDjb2lMD/UJMMg+4L57ZEfmHHwuH
	 Z+xcR+d2HQ1JVH5uGwbXCkLbWTwZPUnm8uuD5Fp0vnsVOT+u7m2X8IBYcuSg05G2MQCia
	 0x1OwjqoM7Y6B3amGO9q0Qovy9VUDzW8PT+81cQEy2QyXSmf/gpcSFfx5c76x7aaz5lZI
	 EKzHm/KeE90XOUDB8W/uhA2ITqSWSRf6mnZwoVLct4bPl9DQZHjtOndFt9YUqN3PoJR1I
	 Jd0COxNnsBX2zMoYsU2oYbdqjzg11z9J7yUGIWzhVgQxVcATS3dds8+owXN1xS2Fwcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dpMp/a+YXT4EPeN/ycyUgWnGt0iwKGVxLkTNqZEGg2o=;
	b=MLr8tWo17/lu5xbMbehWNYxdoEG7oA79DKMarRWXih95o/YlhWj7C+LYophElfvhFeuw
	 qe+Z33DBr+sd79IjfUIXYXaZ+kTE47hN6+Vogw1QQlh9uhUCw7d8OSmXDjLYMZXDLCQ95
	 GvbWM1JHLBQGEJAM/e2xVIMZqtGd0mHfEe8n+tRYYdK95Eg07dVHbbMpf8R0bCwHrCzAh
	 JDofX3NIqb9IyR4bnCzz3oIZTl4kQHyMJE0D4eLbCgfAIZr5xDYkEqLta7xbpU7mmHyA2
	 jVexG5AAXYWOrZHvjuk/l3nY/2j2RSu3E8HlmTsjHRAP7Os2U9S0LCmVpjZUAsmbdDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BPPpA7pe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.130
Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E79606A323
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 17:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6E79606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BPPpA7pe
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4a210b0d5c3so11907055e9.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 10:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793034012; cv=none;
        d=google.com; s=arc-20260327;
        b=fkFferI2za7y5oSQCBDlx+GYSALEJ9bhksTDkwHhqoxvLGuBBZrW1E8EEALBLbb2Qb
         4L7s8vWdarWU9su4yMmxSvmNsTssbGtqMOpsL/HvcjRc0wHw3EHnbGGTYeNoKAdOzZwV
         iHjM+mDn4bCskKDwFT29EO8UxTiSQeopjd3LLpnu9GVHVI/B+HMZ+bGMwWbQeqCuA20M
         2azpb7YX1puELLyenUjYa+/T2xg/N/IMIpG1Dc/bxeexFStIPbY45kZni20FZ/LIPgf/
         hBAHhrjKA5x7f9u2ciSKEOM+PYaLKVLCmP11rS8SfH5RyQ5vOX2zhhoTu+k+rq0Dc01Z
         cINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dpMp/a+YXT4EPeN/ycyUgWnGt0iwKGVxLkTNqZEGg2o=;
        fh=au0KsrUU+id6iTucuQWKxShsVg4K6h1H8ypdNa7+U54=;
        b=dUpkZrcB4dVdXLq2W4hK2TU4jGdBpZVQwDOdDh8hAcw3F/CycFivZdSIpBcMzhDRgX
         GCG5aqDVFiv8cVhO7ZrcA+UpgTXuj9KCGpyRbh7im4dmQEUnH/vxSYpbNOApuH9gI1D6
         P4X3SZEsKRvl7UMKk8IEJSRu2V0UmCiHp3GZm2XwDRnKE1YyEWcDU/9ujDKwAzKo7LO+
         yHm1scrhiIycfbPKSocKA3D5JiUPh05RHXfZMmWDpk/73M6fNKBTj4yTLS2K/shSZKro
         Gvf3YQRTNB4Vwx/qNF5QCueQbXwfIdsd/bdwT1vhNn41hRYXPumkqk64kXXou80ijTmA
         LNqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793034012; x=1793638812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dpMp/a+YXT4EPeN/ycyUgWnGt0iwKGVxLkTNqZEGg2o=;
        b=BPPpA7peRXdALTjy9vUkITwGMccq9wDdAov2Nplh29iTgsYyGeG5483PBd3S99LqyD
         CviD4TqrR9yqe28XS/w7eoa0qcvD778bwwQX3r2Tu/ZRWrf7a7hUiARPykqeUUmW4Oic
         uVAIBg/3awd5N+BQD3JaHumRt86pR8L7BdmbuOyFQoIgtNkJBfJB2WuUBvTqzjZEFNfn
         J0mLWTC88VHEdBbILZfMtfeGO9r4z/7K+lvel0rcCjVUbOK1iiODC73xUkAcEFgOo7Rt
         jHQQEck2GgVrfsDVYUkIn+XMpgErOw0RsLe3PMsbwMPdyWrgwPfhKsybIKvJjUyrKUf/
         vh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793034012; x=1793638812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dpMp/a+YXT4EPeN/ycyUgWnGt0iwKGVxLkTNqZEGg2o=;
        b=SGfNqax1FH9FJLJuP51wmawpj7R7U/R4Cy0uFHnttYll71u+sz0KFwveQ0fjhLSjzb
         8qVFWQ6ThjsIxFYT6wVWdmeFJSnXpS+pMMZpTOO7r22Z16h2GfLsSXJIz/J2v36zm4vY
         xnTVsauzw8SXvBQ+A4tBKc/LhrzgOMzjknhBdNB3SPBajtEqBuq5PLkaKeaAzSq7uizm
         qQ/Ridd0xd96Q0s5XuU/sZizp3Rc+fmNPn1Ko50oUqKpOxmkC4XsttaauwlUrmS1ozew
         YX9f0ZwmrV7Ct9QwxfNXzMV1iX+OeFIa4ZTbVv67jtrN04KnOs4p9OC7+WHxdY/9fFFv
         pvMw==
X-Forwarded-Encrypted: i=1; AKwUvBwf36+D3QrY56qIjMRj527OZyxtr+ntvhJ0WAT8KnxQNn9FgNBCF+U+cRRnpCm6Kuc9YOA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJD2Sih95KsYSDEB4XV/tLDEVyvCvTJgaJJ9BdazVFPqrFQs6sh
	5biEHiUnAb9jz+bQnAJ/x1rkF8OsGaDo2KNpcOpqsTcynsIo02peyBtPng3lCkf3F/pYSSy/efi
	fV6JyXFgRAC5y+8vrPnrUrJdIpjE+SoA=
X-Gm-Gg: AYBFou20MQX917XsenpG13Y6Nl/cn2lPXle/+sUka7LW71Cifk+PJnVMwDe/OWIBGhp
	KNnFNH8UtfYfmT6xWV+YXgnPqWahtdZR3yujj5NMLT649dvuJ7K6dl2Mlh+o8qjxRv0LezjQy6n
	AczVs6FB2pKzYpW/5gC7p02Taw8Rk55kQhCTzs1IjRdo+aD8pIFBynOiaCYqCEkpQCYc/nudagU
	VaoPDuTFB4viONNQE9ai8XLLwIzr078APSNx6YrikcjiHHI6VoGp2nm3iRD59nZXtFBTclR7nl9
	W2ZZHznvP9C+xE4EBaM+avQqo0ED7nPnQKJoXy+ZEJaaTsddgGz6CxoWB+WVHZwnDhqjr4ct9z0
	PPlgoI1Tgw4zLzbnz5gCc2Yfpt3ddCNSszHwTXTrzQm5sFBspfNuAZVuItiCp3Do4xl7/9vHpM1
	kuK/8/HUb+vlDq9mT4Ir8YQ+ZhHFBKkMR9Uuyfc2MHr+ARQQ0f1hN/yk80Ja0uGvF7Yyy982Ism
	WMZNnKl8O9RCmon
X-Received: by 2002:a05:600c:198e:b0:4a1:fcfa:2a07 with SMTP id
 5b1f17b1804b1-4a35acafde7mr135977925e9.30.1793034011977; Mon, 26 Oct 2026
 10:00:11 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <20261026025943.404450-17-alexei.starovoitov@gmail.com> <CAEf4BzYrpYHS1V=VXF0PTRXkXQo6FnseWirR-ka-O9wKTv_GcQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYrpYHS1V=VXF0PTRXkXQo6FnseWirR-ka-O9wKTv_GcQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 26 Oct 2026 17:59:33 +0100
X-Gm-Features: AclHuK_gXLdXjhKF9-cIHUlR9r2mDN7OWEuX6hOBoeurzQaruuU-p8s_2zs7U28
Message-ID: <CAP01T775XCUmtK97tBcWsvOvUsGxR7AKCGqfOCgebf+-_WfhkQ@mail.gmail.com>
Subject: Re: [PATCH bpf 16/81] libbpf: Make arena 1 Gbyte when max_entries is
 not set
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Oct 2026 at 17:54, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Sun, Oct 25, 2026 at 8:01=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > max_entries of an arena is its size in pages. The kernel rejects 0. Thu=
s
> > each prog must select a number, and the same number is a different size=
 on
> > a kernel with a different page size.
> >
> > A large arena has almost no cost. The kernel reserves 4 Gbyte of kernel
> > addresses for each arena, small or large. Only allocated pages use memo=
ry.
> >
> > When max_entries is not set, make the arena 1 Gbyte. libbpf calculates
> > max_entries from the page size.
>
> Why 1GB then, why not default to full 4GB size? And also why not teach
> kernel to accept max_entries =3D=3D 0 and treat it as "max allowed size"
> and set it to 4GB (as of today)?
>

I would prefer this too. Also, commit log is confusing, it's arguing
that there is not much additional cost for 4GB region, but then talks
about the 1GB limit instead...

> > [...]
