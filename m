Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D554AB3A6
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052046; cv=pass; b=g3y5xzUWuTumY6hR4IH0dXJUHNquJWN2Jdf8mqODbkGUitxsxcnoEDHnaoqGci8zlOADPV+qU4lMeXwfOyOKvgCdzVLIObkTrV+lHUgNOqqGz8jDfe9/jDfmHJRN0vsN4nvPlSFt3jpjEa/3yxiBxHeuYRB6z2tXjyLfI6wrjgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052046; c=relaxed/simple;
	bh=8iAiwpwW47OVOJnhscj/GgCmChXaZGHipRfTymOcxfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuNXBJX3YOemTTrieFFmBwDaWgVx5mMRCCcAXoLRcC8vhf2nryaVcwAVOpwHluFyi19+QjQPydswvsloFClTWKdTFj1UnYaQVPt84AvkMXmA21U0ufEylkMUhxYaphtNn/fO4Jb5VN5qCW9pXOCWOxftPyrdNb5V8RlF6b2MO+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=oQ/rgLpV; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="oQ/rgLpV"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e95b3b52f2so2814685ad.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 01:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792052044; cv=none;
        d=google.com; s=arc-20260327;
        b=srnw01vGO1uggXnrn7kk64L5BaEKxDvjEDMpcW6LTc3zMwr+VtU/DOEd3iUzTxlqDT
         Br6iyRBtgPWirjA0Ua5mAEdTuvB9EbNEYWK3l49N010jPtoWbpSQrsmMYPpzvIfdLBZk
         ILCZRKnnGvv2/RPTezLN4ZaK2URvEc58oMbxSJD7NTpNgadE0LVSlb1Fh+A17SKFLWKo
         UG76STXWwphiXvI5BN1y7xrll8tLkKWQzbLgzawKfNvOMQOZl4lcCfROMCGx6vqQ1V5S
         Y0YHblx2aG78/1G+OLNXF9r0ElLyqiz9+JmS/D8hPfMP5uaQk19SEXs30I9en9NvMD8d
         6FUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/xXmvRy3j+cmgGMPixggwBzzW8lSFiwFQMa8Y9E1dK4=;
        fh=bq17KkjapcywuAg3EAK7LIaYwkGeWPZnnyPCXTSiXyA=;
        b=hsNi/eJsTNMD+AVM/F4CaHpzvuWvXwZDbYb1zjgpfVIV1JRd1kKhe7iskIkqODvae9
         NNrKvLZqcciMTBhfexu+F63KGIrGfE+po8za2r0uYuCxsUGiNYygUFFwZYjvLRYZAvTN
         ePyK0WZM697ahVq8GuabDfqLIRN19ksjxquJZZz5xALf61BEaEzOP7Fhh6ZZ2/KifK1H
         7Mmok09dTHwVvBOip8OMDz187EuEw1IGLiOGVxFef1cE7Etwk/Ueb6pVSkPdFtBLWLEh
         Q5Lqposh5L7OqeQ23Nj8zExjOHZPeeLUXhnxfaqZIYki7h6ld1yJVD/CXgYniXX91Uq0
         QJtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792052044; x=1792656844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/xXmvRy3j+cmgGMPixggwBzzW8lSFiwFQMa8Y9E1dK4=;
        b=oQ/rgLpVAqkQ00hyZCCHcr2u8Fc1bkOhGEUXNivHmFYZ+ogsmRvgwmwiBHkudzHX33
         aC1h28n94hpesxnKyPCk6yzZr7qmz0JrhVaPmfgAr8R0/PSWBnJvtgUJHYh2rGQedcQN
         +XH8noVEFLhRlrKkNao6dwggAe1NXn6n3h8tJQtziujmKgnAICa9XGyOkx/VplF+aBGI
         WwwYWOvLhPOMZsY0HU2t4bLF3dMzjB+AbXNesyj9i0HsbIleyldtxwLtn46T3smhzgnH
         owqhxURXw8fyCBKLbC3cXdSVh2mxex5obNm/b7nKa+/f4IMF1BfjxPuwI+b1zF9skN5p
         Jdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052044; x=1792656844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/xXmvRy3j+cmgGMPixggwBzzW8lSFiwFQMa8Y9E1dK4=;
        b=g1/dNKTU+E8IgKJoVYlPvRH9P0XntFf+/uSjcFXs9fTpPlXD1wtJrld5PnTmSDCpP5
         ryAXwfzULJXJmu9XvNj5Im5CgQUBhgG325saotn5bfY4TRmGSig6Rhlv8vkUz/fXsPSZ
         Lc1TR18pxEyvqMapfpT2lKK5B0Vbe9U7a19YmCdx8L6LZb6XSoVN5+ZfEetgekLzOZRA
         98oBZg51Y0R5t698CgFSz3LFn1lPL00gZRtrQEj5iNx5XDjL+DBYjq1UbT+49YXvxrsm
         NySdaPv//+qYpKAa3HCxTj6PFs9BisE8iT03pnDh+iFBtasNozb9ec5cHE6ON0tg9ofa
         FMvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxELBXp9iSKt/LRKgQmpSFdxQ0IW06w2FqVptkUpt5QCZw+8gmRBpxw/b0a6QcWl/xp4sc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJd3mIyhVvHVFDs/Te6WvfwOw9X1Qo/y+S/3PtYmfMY663dT+HQ
	pSW9V0uXVnKzL1EB/xSzQp4oLcQr+QXHXjlyYVRFjCYUU6YrnrW/tIYCxXgB6GG0zJHBCxOt2E0
	48wT+l1+/BxYaOq1eoB84SuyJTw7eJiiwtOgs0bCz5vA=
X-Gm-Gg: AYBFou2FnBvzgROCxpfSaLkku4k6dKG6OcGTSQqNy2Sq2TbrZNeMEhpKmIdAO3GPvKg
	VHOr5xy2iVdCkZZ1Lc30dG+QboKvxqb0tTa6a8YYP2gSpW8eTXgfFrj0ylKYy8p00CJGGTOJP0r
	GHeHHuXsvStP4Y0D1RUjcEnJHokW2IFY4/MqxoN6P11jNHciE+pUNhJ88dv3EhnkAtim0s+p5kr
	hwQaUtYVa8NbJRUE/2OqVgUKgL9/Jvi0WaiucJDPJPItQy+y1hqwEvn/TueXZZzhyM1dG4jo1ms
	eLWboxPtKpzY5Mrn2lu4XiQpabxbemcQ9CeZWXDOLweC51wv4VcSFQLwK04dZMJRX3Xp/8vmXDL
	m6zg3dg6PqsI=
X-Received: by 2002:a17:902:ef07:b0:2e9:3395:cca8 with SMTP id
 d9443c01a7336-2e93395d1c7mr45816975ad.46.1792052043589; Thu, 15 Oct 2026
 01:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1792048855.git.zihanx@nebusec.ai> <1eca65f844ea4eaefa9ea4a852f1db27aacc10b9.1792048855.git.zihanx@nebusec.ai>
 <sashiko-outbox-172439@kernel.org>
In-Reply-To: <sashiko-outbox-172439@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Thu, 15 Oct 2026 16:13:48 +0800
X-Gm-Features: AclHuK-Od2hWn9HWhQZkM0X9wiI-VanPEIsuQFAjFuP9aKbDkjFi0zgaRUsjr9g
Message-ID: <CAANe3eTJcfGU8DcbrTLtOwM8tcDx5TkUrZDXXnUbT70m7X3+1Q@mail.gmail.com>
Subject: Re: [PATCH nf v8 1/3] netfilter: nf_dup: preserve guard across
 NFQUEUE reinjection
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, intel-wired-lan@lists.osuosl.org, 
	bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 3:56=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] netfilter: nf_queue synchronous bypass triggers false DEBUG_NET_=
WARN_ONCE
> --
>
> commit 6ab1ebe7cd71aef0c99fc87d28ca2657ffc20779
> Author: Zihan Xi <zihanx@nebusec.ai>
>
> netfilter: nf_dup: preserve guard across NFQUEUE reinjection
>
> This commit saves the task-local in_nf_duplicate guard into struct
> nf_queue_entry when queuing a packet and restores it during reinjection. =
It
> also adds a warning in nf_reinject() to ensure it is not called with the
> guard already set.
>
> > diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_=
queue.c
> > index 477fc632657f4..1ec9c1fbae843 100644
> > --- a/net/netfilter/nfnetlink_queue.c
> > +++ b/net/netfilter/nfnetlink_queue.c
> [ ... ]
> > @@ -369,17 +370,24 @@ static void nf_reinject(struct nf_queue_entry *en=
try, unsigned int verdict)
> >       unsigned int i;
> >       int err;
> >       u8 pf;
> > +     bool old_in_nf_duplicate;
> > +
> > +     DEBUG_NET_WARN_ONCE(current->in_nf_duplicate,
> > +                         "%s called with duplication guard set", __fun=
c__);
>
> [Severity: High]
> Does this warning falsely trigger when a packet is synchronously reinject=
ed
> during queue bypass?
>
> When an NFQUEUE rule is configured with queue-bypass (fail-open), packets
> are synchronously reinjected if the netlink queue is full. This synchrono=
us
> reinjection path (nfqnl_enqueue_packet() -> nfqnl_reinject() ->
> nf_reinject()) executes in the same task context as the original hook
> traversal.
>
> If the packet was originally duplicated via xt_TEE or nft_dup,
> current->in_nf_duplicate will already be true.
>
> Because this can be triggered by remote traffic intentionally filling a
> bypass-enabled queue with duplicated packets, could this introduce a remo=
tely
> triggerable regression on systems with panic_on_warn enabled?
>
> > +     local_bh_disable();
> > +     old_in_nf_duplicate =3D current->in_nf_duplicate;
> >
> >       net =3D entry->state.net;
> >       pf =3D entry->state.pf;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792048855.=
git.zihanx@nebusec.ai?part=3D1

Thanks for catching this. The warning can fire on synchronous NFQUEUE
fail-open reinjection, where both guard values
are set. I=E2=80=99ve narrowed the local check to warn only if the
current-task guard is set but the queue entry did not
record it. I=E2=80=99ll test the queue-full fail-open path before sending a=
n
updated series.
