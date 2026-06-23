Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1913955EC
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247447; cv=pass; b=ir8GWjBRpfAjkQwkdkuAMyK8khxbRKK/QPmmZ32/a0fsdawLnQP5x3V2ozrUCydtqkCCHhUhQyD8ec99uWJlLo60vl5kt92o1vnw2K1Laq8b9YPTiPsoE9t0FtihSZzDQ43CBWM5Jm+5dd8iY2fYpYceDdn3V2hiRLrf6TY0eFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247447; c=relaxed/simple;
	bh=2+bCy8WMLYBy2K5evhnnQ9DQFULPcH5j6bXsh3kvxIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRADB9In8GeZJkt+XLdasWCqdSyv4Y7nS/5FFia9oIdemk8vtvlpUKisjd9peSJ0zDynPBBvJJ4W5IXx2wVbwVn9d9J7zXFqt/ovyXKGkccglTE1TAq4YT6hqeeXWTafruS4aaIpbrIboHFR5vheS5xsoMHPvXQy+Fg4pbPDIL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C53gQdd1; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C53gQdd1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c6fcfcdb2bso1942795ad.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782247445; cv=none;
        d=google.com; s=arc-20240605;
        b=idf66ByJJYDo7eNG9jksHagogXI6WAr1QM1ZThGMItl/M70RKTPcbRKtbwGdcx3x0z
         kPUB7gM6KuI5TN2m1yDUNNReKQKkiZLm5+f1/RGlh4sFkn1BbZYjJURVf5LATss62vkW
         pRi0Cbch6bpmz1t8dMscoq8P1foxEWU5UJGAJg3wwEY1H80lfYdO9KLEktpaciSGX11B
         lu9svy6Iwb1jdHfB3NF2Ou3+ljxSG0cTiHIulQPVZaKZAD/KWO0KmDnWrYJ0MT+ZDvq8
         waCwQOKKxREv8phlO5u/mMSybPIqbHvDmc5LOTXv8hNx6LzksU2ooEbnAAR4HbuRrVt5
         SVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GWelqqGfdNZfuisp3MWIx16VvZ5+19H4TZw7UN5h+9Y=;
        fh=+QC29UjC2J+GJN3V1xCqyq3vUDVqtmteUbv12xBmqXM=;
        b=iKqjlczjKbQo7h9Tlsqt6yTXVgRui98xd4dAn95Q58ECx1ryFB7ZegqqyOZiCo+o7D
         3A1u32PJxIjzNYGoz1OQ0/Dbdu0+hOpZN4CzpjJb2f8abohY8nyAx+XCDdL/dipYiCN8
         nRRbZLikjD9b1i0x2MkK4fJ3pPRTqKrdssNKbiI1jrJrAJTzijyqUqFehekPUFniJ4JA
         HRbkC8hAHutl93JMMv4VE3yPCklOO5WczhMaym10YNBVSiea8bUfp45bOF6HFobX0PQt
         3TY597BvBwigOE2U8FidB8nJyBrjv2GRzzILzIhFsYGxl5/upkjjABQ5bKy66WU8h+lb
         MKtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782247445; x=1782852245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWelqqGfdNZfuisp3MWIx16VvZ5+19H4TZw7UN5h+9Y=;
        b=C53gQdd1uqd3+vDTCOY+066NRTnJ2bCNofBadKGCtTStwHc3WDiBrJKcrIEYdhbyTl
         4OAZVtflGCRSvtCM+RPZxcD1mNFrM9ELmxXglG8wyxQon2cb4FQ9xqiuRe0mpcsKmFrr
         Qv5V77YainHDaZlBA3lL2MoFOsMPRfIPVHyXJqZFgDxs2EsJEmhBBcrTk5wdt6Q63Nji
         KsfB9ASc+2I08xrO33ylJz/Dx5e4W8tTXlrM7kJb/HLDEiY58CGO+AyrZRZq4AUrZXR2
         HyJIoRV3DQbks+BknxxrSRWiBarc9vQiZ+cXi+oHly8SVVodQsyxA2sZgAgvfIb05h12
         gb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782247445; x=1782852245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWelqqGfdNZfuisp3MWIx16VvZ5+19H4TZw7UN5h+9Y=;
        b=KNquXxq31o49YmhOJ1b7R47dml4FYA73X+icB4ydAYoSN0PzJ5PruhzrMuwcrCQgaH
         nypQYvuy19Jl31abds46BFgrsszgS+KFC+Ge77Nx37hy9GUoBSxrmYQlLjElxQrAXllf
         kmsolGqYlRrkHm1cZWVPs2F5UZRAzSqVfXHkhRDJQ5tQIqQdQYnVJNMWSIIWLUwb9b6x
         zkM/tCmaWeE+SYiIGSc9Yto1RZ3TwKaI3znx3QdaEjOj+7zJiG8/g+68ynZG/5dQHt+9
         ShquL+5VjvezEFWjgZOkZ8Kz87RZ/2da8TngGngIXkA6cFl9fOg5HhME3JlKaS6yVbg4
         QYQQ==
X-Gm-Message-State: AOJu0Yzk/8hxKVsHftmYrq5mJ/dA90Kn3yL3AVrg0GCxrIFxzxayT9SU
	5YIpGRW+i94zsCxy8z5E+xigwzvHYvAO2FP1yrhkDHII9sFWKqn0V0naF+zgGHIAoYaPCP+tcFi
	Li+18NnZMHK1kdFkZPqr9F6T5fyglfLU/ybRQ
X-Gm-Gg: AfdE7ckKyjIqCM/fczTtA8SsjCNKcnwROUkbSNkWO+CNGB44qnlOWaK+2rvu+ACdaCA
	eKO2E7DQFqCItHae0xEWNpcUWv+547ERFMUJuS+XZUivxkkmwwkBQbGofNVzo0phqNLTRrWjnkj
	ZLPNQbwhu6WY+hVXy8gcHepGUN72frmFRM8lc/Xan8MlDJwwiCHJzHO5SnUuJgD1xHDFPFxbzzh
	4kW9CWHdCxTa72xkeD7ji996hlsuuI1hxqjtDiCRYcaqTKVoVNDQ0d95xcyqcIXk6KYmV4PFnxV
	KHQlTS6IGbwsPqPZNtPP8ulwuaCq/H7WAzzFxdL36w3zAUdeuOYVpCaFhjll+/vw67uxYA==
X-Received: by 2002:a17:903:2b07:b0:2bd:8395:fed8 with SMTP id
 d9443c01a7336-2c7c76d2fb9mr54053295ad.27.1782247445391; Tue, 23 Jun 2026
 13:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178220124597.31744.3595561672327420327@digiscrypt.com>
In-Reply-To: <178220124597.31744.3595561672327420327@digiscrypt.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 13:43:49 -0700
X-Gm-Features: AVVi8CesTJxa97EA_0FWNV-pDChVuTt_SuUzhgM29ZPbxL18RkDOyJ31nMpCte0
Message-ID: <CAEf4BzaxKLJAEaZR7VBjT5N_jeWVJ=bRviP19viGaSGQ=44dRg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: bounds-check float size in btf_dump_float_data()
To: Naveed Khan <naveed@digiscrypt.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 12:56=E2=80=AFAM Naveed Khan <naveed@digiscrypt.com=
> wrote:
>
> btf_dump_float_data() copies t->size bytes from the object being dumped
> into a fixed-size 16-byte on-stack union float_data whenever the source
> data is not naturally aligned:
>
>         union float_data fl;
>         int sz =3D t->size;
>         ...
>         if (!ptr_is_aligned(d->btf, type_id, data)) {
>                 memcpy(&fl, data, sz);
>                 flp =3D &fl;
>         }
>
> sz comes straight from the BTF type and is never bounded. libbpf does not
> validate the size of a BTF_KIND_FLOAT type while parsing BTF
> (btf_validate_type() just breaks for it), and
> btf_dump_type_data_check_overflow() accepts any size below INT_MAX. A BTF
> blob describing a FLOAT larger than sizeof(union float_data) therefore
> makes the memcpy() write past fl and smash the stack when such a value is
> formatted via btf_dump__dump_type_data().
>
> btf_dump_int_data() already rejects out-of-range sizes before its copy;
> add the same check to the float path.
>
> Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
> ---
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index cc1ba65bb6..922c8ce32c 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1983,6 +1983,11 @@ static int btf_dump_float_data(struct btf_dump *d,
>         union float_data fl;
>         int sz =3D t->size;
>
> +       if (sz < 0 || sz > sizeof(fl)) {
> +               pr_warn("unexpected size %d for id [%u]\n", sz, type_id);
> +               return -EINVAL;
> +       }
> +

earlier btf_dump_type_data_check_overflow() should prevent memcpy
below from reading below data boundaries, so there is no need to
protect from that. And then subsequent switch will validate one of
expected/supported float sizes. This logic seems to be fine as is.

pw-bot: cr


>         /* handle unaligned data; copy to local union */
>         if (!ptr_is_aligned(d->btf, type_id, data)) {
>                 memcpy(&fl, data, sz);
> --
> 2.52.0
>
