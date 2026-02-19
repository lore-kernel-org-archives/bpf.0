Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701E42F8BEE
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527675; cv=pass; b=ewQTVQz1SantDlHfx1dIZxm6W2mp6jp4Awml8asajmrwWsWQ4unBOL0202jYGNVmzrMQujNj99IKcvXJPcdqVhaCKfhmFIofnxzFJ0H0ZTpitBrIPzpPuCdFCIwLbdvFev9skZ1JgoKWkf/4IL/iar7fIiGSUhc4mAWssV8/McM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527675; c=relaxed/simple;
	bh=tquMu6jYPhyKiV1i8LjJLyLv/MbogEbCgjm7Io9nkKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azDQ5vTnNPGW2amboPKnGBWd4fkp0LaMfx7NPXLM1nQk55uQmiF9jgmNDT/LzgBnjkQoZ1IxnHeNJ9+NofeNu9hiyWaV7s1RUyBLQcnhWxeQiY9QjEkv4orTtOjXb7w6S5CjjL3VSKaOVgsJIBrx835+9upMSUCXs9hJsR4rvKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuNXci6o; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuNXci6o"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48371bb515eso17102775e9.1
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 11:01:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771527671; cv=none;
        d=google.com; s=arc-20240605;
        b=BQ1ZDRUJpE/dbyMixV1S/CK4msD2YDVhhfhLECWj1joPTj8m66eKjMTbQ6c5QShaJx
         EJrBObaG8u4pzPx9MeavB+ag7BQn4udmzDKTTu1XX/Ar97lB8D/5Bsx/tgHOE1jcYXCg
         imeVLtdgwKbEPrihVXtPdqehqRL4Sd+WIXiY8AwREjzUIxmsxl7pwsN7903b0FshzmCb
         TdfVSaN0ASwgN8aWfUb/j4ANAmp1OxU4D200HWJ/1CTUNcUH8fmICR4SmnHpSTrUHKOu
         ynhYmgRLD51toQgxF64eXfTf5MlMnSOS8xBWopn2KHu3zn8FsPHt2piqoAHNWtsgo+8/
         2sTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jfcXHM8vdeHdLJ0TPx+8IcJlGEwAdq3TJvZNt0rkyx8=;
        fh=XwGciU4R2575puGPagD/LyKBHnuLIZP4bC+2LFeMsUU=;
        b=LdKD642fPN/5j3h6noi17bLYbCV6iAfRL12Itsqbml2/5tbAhvImtuFJ2acOgdEtAg
         CKlFz/IOcQGs1AZHIRgg1xibunp51ryGFbQyoN/9Kgp6EGp3uE7enhGQDFQ9xmMspLG1
         NazDczKN5PY4vVrU9aKNbkMg+jWQw9/CH0qEzez3m+NBHfo4VMaR9e6FRnOfGo+0haEb
         bDk2CfD+nfP/GXm+WmSMfXTVvPaUxaW2ZT42oN7EKO9Wsvr58CcOInQ46cjYH0S4L9tW
         GxrlekkhCnUdFxB2qQH5c+C21049tpWSvd44LkRt/qhclY7r942hO5nJpJcVSS2nNtND
         YG9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771527671; x=1772132471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfcXHM8vdeHdLJ0TPx+8IcJlGEwAdq3TJvZNt0rkyx8=;
        b=QuNXci6onMnS/dus66FiRDgQd9ioInjcmqzg/w8D9kZBxRxyxRE30XI0RQA9t0UfoK
         aIUz800PMYN77/nDdloie2fg6W1nsd2yjV1P/xHuIHnxR5Zw1L3oV+uhpcU3zs6koZUV
         DlGxH+m+Scnbh2GrTiI9GI0wN6ua58aXAyPeI1zLBmOsJeiGywdhKKKJ4LLwlhQNgll1
         0G3T7SaWnMdu9GQDiUDSwQlQiPv/p5tjoCtf0T58q9BV4YhB/cIq3LOSNZYK/0/frsum
         RKXI+fRgnwRdsFuSH6FfeY/XaP+wmAl3y5TRFkK9+7lYUhC5tYsT0cEl6Oyi/XtAS1hZ
         ewLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771527671; x=1772132471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jfcXHM8vdeHdLJ0TPx+8IcJlGEwAdq3TJvZNt0rkyx8=;
        b=hxfJuZO6zDUqloAfHASGBnePxzKupgQp7lVSm6qBwZ/Zwl9Zh4Q62fWj1dTwU5IaO9
         5plQLsKnyfe5kndViI3/SAlOoB7L+1iKoJWwKgdYOnLZsp4xX+cDc9fpA1PiuWJb4Ut3
         LKIBq+izrXX/U8aTnKI/AzRP9qg48DL19qXkIcbuzC+/JufKeSpGWJNtOfOA/4VVpMHn
         wmZLANdD5pWDQRaubV9VoK2hzPON0zf/4zjYHE+FkoGas0v2IFTtV1XU0RuTC0nvTooP
         qcXWbSD7Xzk1I+sd9RMSUrBBLzPx1g5iSgyX0ydPcbiXEzUdDFZxEIEOmUGhpq8cXX9Q
         iJJg==
X-Forwarded-Encrypted: i=1; AJvYcCVw91PVep0TeLuSy1jMMijTyktd4aDSwZpPSi9UvY6JZEKBaFvjtnEVRcKWU5tQ8FfuGlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1x3DDMNTbCe5e823PcamgZxzW92tYKOq2CkBhDE/um4uecpB
	d8q+XEzZX8w8nrXrSG2myrBGoNe9NoK03/KNPZsiloObBm6Zck6mVo33HozqqmHk/2PnCfb5lLJ
	PSdmHFoIrcJjfv66lsdr8x4Lb3pkiaXqVJPsf
X-Gm-Gg: AZuq6aJ3PsJHnNhviRaqiew6kNoSl3+xhQFYjYAvlr3kjV7icqArSUIY/KYZrqvitW9
	+Nrux9HYokKJOTOp+UdTzNL+td2PYsF/T/J9l/OVYlU67rBFTAvV5RPy2ycBXjneYJ9vX8oYMlT
	kFOali3t/QFkK4T9kgqI217FyrRUoU9VlprN+HCGNf2HAoIUX34vmT5hh7atvwTGJ3szbK9DlKQ
	RnfF00d7w/oZqAk4v5V/KgobRZNyCS7EV4MtxIVZlNENgEi4NqyG4DR/bCQk4MZ6LkKiMLQf0MQ
	Rzo7CGdGUlrjGXlcWy0qrjrt6uY5FsMASgKwoDPsO2FdJ5iys971iQcnCi4pWEP9rEZ/nFAvFwr
	1+J/mIFYq
X-Received: by 2002:a05:600c:458a:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-48398a7e1e2mr111256305e9.10.1771527671269; Thu, 19 Feb 2026
 11:01:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771327059.git.asml.silence@gmail.com> <7cc147a959ac068c55dae4f540e38e9e4ab121e0.1771327059.git.asml.silence@gmail.com>
In-Reply-To: <7cc147a959ac068c55dae4f540e38e9e4ab121e0.1771327059.git.asml.silence@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Feb 2026 11:01:00 -0800
X-Gm-Features: AaiRm537YFUuP5smuHEyCnxqI_hW-J5HXpVLTTziLuOVjoC_dPmNvZaoVrYmNHE
Message-ID: <CAADnVQK0RaOA9ZYZdYyQxOzLde9MR8HpMM0SexcW59A9u7X2Jw@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] selftests/io_uring: add a bpf io_uring selftest
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring <io-uring@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 3:33=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 3);
> +       __type(key, u32);
> +       __type(value, s64);
> +} res_map SEC(".maps");
> +
> +#define t_min(a, b) ((a) < (b) ? (a) : (b))
> +
> +static inline void set_cq_wait(struct iou_loop_params *lp,
> +                              struct io_uring *cq_hdr, unsigned to_wait)
> +{
> +       lp->cq_wait_idx =3D cq_hdr->head + to_wait;
> +}
> +
> +static inline void write_result(int res)
> +{
> +       u32 key =3D SLOT_RES;
> +       u64 *val;
> +
> +       val =3D bpf_map_lookup_elem(&res_map, &key);
> +       if (val)
> +               *val =3D res;
> +}
> +
> +static inline void write_stats(int idx, unsigned int v)
> +{
> +       u32 key =3D idx;
> +       u64 *val;
> +
> +       val =3D bpf_map_lookup_elem(&res_map, &key);
> +       if (val)
> +               *val +=3D v;
> +}

Since these examples will be copied around, let's use
good coding practices. Use properly named global variables
for stats and counters, and drop this opaque array.

Also bpf_map_lookup_elem() doesn't need if (val) check
when key is a constant and lookup is from array map.

> +
> +SEC("struct_ops.s/nops_loop_step")
> +int BPF_PROG(nops_loop_step, struct io_ring_ctx *ring, struct iou_loop_p=
arams *ls)
> +{
> +       struct io_uring *sq_hdr, *cq_hdr;
> +       struct io_uring_sqe *sqes;
> +       struct io_uring_cqe *cqes;
> +       void *rings;
> +       int ret;
> +
> +       sqes =3D (void *)bpf_io_uring_get_region(ring, IOU_REGION_SQ,
> +                               SQ_ENTRIES * sizeof(struct io_uring_sqe))=
;
> +       rings =3D (void *)bpf_io_uring_get_region(ring, IOU_REGION_CQ,
> +                               cqes_offset + CQ_ENTRIES * sizeof(struct =
io_uring_cqe));
> +       if (!rings || !sqes) {
> +               write_result(-1);
> +               return IOU_LOOP_STOP;
> +       }
> +
> +       sq_hdr =3D rings + (sq_hdr_offset & 63);
> +       cq_hdr =3D rings + (cq_hdr_offset & 63);
> +       cqes =3D rings + cqes_offset;
> +
> +       unsigned to_wait =3D cq_hdr->tail - cq_hdr->head;
> +       to_wait =3D t_min(to_wait, CQ_ENTRIES);
> +       for (int i =3D 0; i < to_wait; i++) {
> +               struct io_uring_cqe *cqe =3D &cqes[cq_hdr->head & (CQ_ENT=
RIES - 1)];
> +
> +               if (cqe->user_data !=3D REQ_TOKEN) {
> +                       write_result(-3);
> +                       return IOU_LOOP_STOP;
> +               }
> +               cq_hdr->head++;
> +       }

CQ_ENTRIES is just 8.
Is it enough for real progs?
Does the above approach scale ?
I mean the above works as a bounded loop because loop
count is small, but for 100+ you want open coded iterators.

In general all progs seem to be toy progs.
Would be good to have something more realistic.
