Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87021FF7C7
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599516; cv=pass; b=e19KDKTdZiAd3U9+wmz//dWHYZUDhrIW5iCzlGRRQnpjhv8ZM1y1Tg2F2pO057RG+zUUGdvekNbKzxu7HkKyO0modRJnGlTchlcyIynnx1TFVDAPPhddH9ADD+2oWYAR/gmoVY15q0G7Idv3jK6U5bKt+0zcVpJbFxiTrHvTSKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599516; c=relaxed/simple;
	bh=ftZcV7D8Ek057KXt0Oty0jKypxQgXC3ue2II96u+Ceo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUIobK6hjRAN7CNvwECe/z1mC1KFSoh3RUU5W3vx1NOjCKiIiCSD2qFlYbxmP9l+Up8zYAkeaqtYOBFg4fts2K0PVh1SvFerVAobbweeneHyKv/NHdS6qLIDXd+fRXUjwvfpMaQ+1EpRThsq+FFXXhjLbKOi6dgqLHCQr0vI6aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCP8lPq4; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCP8lPq4"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6507a7d2eccso1488571d50.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 15:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775599514; cv=none;
        d=google.com; s=arc-20240605;
        b=GmMlg7KxwaDoONIrrCOUqZGHYwfZbC2JEzJ0j2O9aOTpRcO8y0w3a3Ebqdd0+YG8cg
         /0dS2k7tofvHiGYOTqQ9+RRcuJnaFQ39j79lXwFnXsj+Vn5wjP4T5pSR80IXgrDnILVQ
         ssPdRiN2XdMcrCjGK9F4os35RTpyJIaNpG2THC6ovzx7wneMV7nFV6BKsZcbseqg9F0A
         Xjat40vPortKN02UySTMbBxf+UCtl2PH/3sQouHeXyPh/eH5gKctmLhXcEwkJpDDjlBy
         UK/fyv4V1LKU7pLAbR26n9DlRte4Du5lBDUXClyeO5q7HZGnVxNWgadCztp8CkzAmCKr
         QqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y8Ze6clvoOTtMLHA0Sdwn9CeMweK46HxENJfnBo0yGc=;
        fh=7urYeYDoZGf91sk50ANv6VVORwCwzZWZ0tRKLdy/zLE=;
        b=lzjd5MBeIHNNjOZNF///qAN81WyQOfpsOhyQGi2HUSXgq5GqMelpnTUTKVw1n6I09/
         qnx341X8i2QYmC79jbiGvQ8J5jDw57yLnUKSUa/PSky3jU8DnIdDFoLAhC7qvw3wmYwJ
         Nxqgu+nYfURNURYsfaLEaMvmRteo3cUrxvg6l1d0FR/pPAVrHyuLgDoRDkxxX9GkjXg/
         x37Mp5qkR1cRyR84DSDhP/pyurRfz4tC5xhfsLT963qNm2sihr2VQaw+Ur9alwEL2clT
         tY1qI0VTnax1ezoeKbNNluKFp9cMfT6eVYUl898o8Qh/3D66MgrBz2oFNZTpvn6blR/o
         Cnfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775599514; x=1776204314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8Ze6clvoOTtMLHA0Sdwn9CeMweK46HxENJfnBo0yGc=;
        b=sCP8lPq4dYZrG252OUG1Ua4HkaB5SqnEDbavB+WphqySjHUEJn/dD7TT/fKjx1hqOV
         TaMV+mKfbzzQ/6MHVJzYIhPHgttk16p34HNEavoEIGPeXEPCgCTsIL0iInDHEuhGo37k
         F1PykiS8QEbPb5b2wh9trMbZq/oBgpx8E9G6JpLf64riAv9vVhsKVTlD+gsC5G8C0kDR
         wXENmLKiZLOxteLCM3JU1WQBTYfoDFSwCPatIzjjI8SeXm06EnhPRpgfkD4hPkCFEZwe
         FqTd7gIzAcPTewYJdm2pGbaj6OisEYpRqpEhs5TNZVrMZPtEgiw7KtAgIEA+UVsTkVFI
         lqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599514; x=1776204314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y8Ze6clvoOTtMLHA0Sdwn9CeMweK46HxENJfnBo0yGc=;
        b=pytcYgHwFqQI2iuNjF1DOEC7r/aa5XPbQCVTS924XNV86MuznSOMXi1f2YI3BQS/ub
         uxctzE0j8kABxzABwliDMGxjFHf2GHx7+G7EnZDVBPv7qYLl1N2x0d6iYmW2s52lfzar
         NZ3nIZNShRuFc8b8i9x6l20vKCFMX6tGsjGcIp0UDGGIFB23GpYTcGr965qJ9c+Ip10c
         PFGRnfS6qO9kzPloAPEssNC7BtZo5EGCW3K1oEUyyA/PAKajxzITHP3S7BJ3M9IZdR9b
         DGCovcyVUhlp3ve+YW92qQUgjHQEmKieJ6HX0fvJm6VUFO4lud0R8B0UYfO16S5gmUxN
         GvQQ==
X-Gm-Message-State: AOJu0Yx9setvnc8ptvIr1SxZlMzg9RupIa/8h65Xg9htpTpPYZmuIx0K
	nHpbYVz5Uzdmpk2znVoFKlMRQFcO1PZRftnux1sGApVOhlE771iuXYuOscxLiMJ2dNWJt+kauWv
	YB/1RHF/BohsQK3CH2zBE3ZYa0IdoJZk=
X-Gm-Gg: AeBDiev+7mAwMQIf11inn3p/eudJ7xlfQXua0Itg4XRZ1nG4odqsOs/Emm0ayXUN6qS
	7ujG7OsJJIbBir6vOoK3Yn3QzNgMurPtJoaPVG29U36t6uYUmnQPCESTUqmIT5QVHEcID+h4Umi
	reb2m51HDW4LgpijlARKpxhdQLjHoZ7T1I5nzbHe38r1WWXJ2oepRf+f5gD0T0RbTa6YvzNwLy0
	6h0ZCsZqQ2Yy9wjHoqUj9Cud5dnhnkfgeb9p08Ok5B29LQae4Mr8cMcMw5Hq19q/fV1e8iZlqBH
	jgOuzFU=
X-Received: by 2002:a05:690c:7682:b0:79f:5904:767c with SMTP id
 00721157ae682-7a4d5860742mr139917377b3.32.1775599513759; Tue, 07 Apr 2026
 15:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406150548.1354271-1-ameryhung@gmail.com> <20260406150548.1354271-2-ameryhung@gmail.com>
 <CAADnVQKgKkyRfoFNSsCi3ykquzsO+-bZnvRO=V2LqyOMiB0ydQ@mail.gmail.com>
In-Reply-To: <CAADnVQKgKkyRfoFNSsCi3ykquzsO+-bZnvRO=V2LqyOMiB0ydQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 7 Apr 2026 15:05:02 -0700
X-Gm-Features: AQROBzDA4i8AiAgtekyR1hUboQAvhhWWiR9FkqkZdz9fdgQlWmcsn31pbP612wQ
Message-ID: <CAMB2axM=ocGBkJ=UB0kcE+4MfYLUroR8G=ehr+00215aeG3EOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Allow overwriting referenced dynptr
 when refcnt > 1
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 2:27=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 6, 2026 at 8:05=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> > The verifier currently does not allow overwriting a referenced dynptr's
> > stack slot to prevent resource leak. This is because referenced dynptr
> > holds additional resources that requires calling specific helpers to
> > release. This limitation can be relaxed when there are multiple copies
> > of the same dynptr. Whether it is the orignial dynptr or one of its
> > clones, as long as there exists at least one other dynptr with the same
> > ref_obj_id (to be used to release the reference), its stack slot should
> > be allowed to be overwritten.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
>
> Why ?
> I understand that it's ok to allow, but the features
> adds more verifier complexity and more things to worry
> about in the future?
> What's wrong with disallowing?

The current limitation seems a bit arbitrary and adds more complexity
to the mental model of dynptr object relation (some dynptr slots can
be overwritten but some cannot).

Actually I think about it again, the check here may not be necessary
at all (like below). Even if a referenced dynptr and all its clones'
stack slots are overwritten, the verifier should still reject the
program and report reference leak.

-        if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.ty=
pe))
{
-               verbose(env, "cannot overwrite referenced dynptr\n");
-               return -EINVAL;
-        }
