Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C35478847
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689648; cv=pass; b=kvKGtoazRzFB+gTOQW/7bjkuP7mQBtozyQVBkc9aIcgjxftfAhNBqQ4PjOh8erkIO7Gba6CRUJUficMXE7NWJiK/mlRF3yeAtpfZYzmP0Rl7rogYkph+uVDpoc2j9U4bmZ7EOiIckfajhii9mKXlrSTksYnT4PFX8mcRGITZY4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689648; c=relaxed/simple;
	bh=ektH2c5D33OuR/izjHIh6IA7RnYCMEtUMQ662f1cwVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJbRf/XDSvcYPc2dVdWkHlPcKEuYE6e+RpKrlLFCsN+1NPJeq6rRuksf684soLcbFdKwpjeKSUav04xQsmxDZmhNKmhNMR/JbBYhNNjrzZfo9tjK3pR2ka/m1mU1Epl6Kt3PgYuNGas3/rVVoMnHjD4p9kG9E83kTriBZ6b5YBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vimxz1A8; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vimxz1A8"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7dfceeaf168so23170887b3.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 13:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689647; cv=none;
        d=google.com; s=arc-20240605;
        b=O4p2H6ZcbtLfS2TsnuD/aWrr/V3KDug6UDVr2uvYvMvYmjxW5J2XU+xXazKA/asPYq
         4yySpJxAdbgJYgB/2AEXpatbzyYB1a1a09N5iZS3hkTr5Oliz5UMBq8SNTxuxZCtU7wO
         wTMuayLovQ+sf0cCOqxi6ia7i6yNeuWAj4MUAeo6Z5XDks6WYjXa3OX/uk+wMBUIRtql
         30BGluZoZ5j/Z/F+xDAvmlZl9KPE6ZVSdn1ErwG9FLt5g9Hr2B7pMGgQRfFUIVBAOzPD
         DxiqYvbU6DV40cYahJ6ce6A2VJNhmjfsDTNGOM36UDk5IgFbNo0exLkdkulYxLbs6WQj
         UjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=anKJ8pGmWaZxfuJHLMfCz6KAXzqmGVAH8Sm2THG/C5I=;
        fh=SS7tT0KC3jLZdfo/Ptau2hbovOS8lxj95BG5rgPZ6kI=;
        b=NmbA2X+BumuSKSWXzSBP5WeoAvD8DOXy5KOia28qTKPL4sqyP+/IeTXBnJXFrAxbNb
         QdkB8eXugbcnoozsWzdw8UHtAK9ADiyZBjxuFasCHSFkItJk58FwkPhxKhdtPZamnMIr
         VKRo2IdlbqJJU/hVuROKzASfeJnbROQmhKjtby93HTxwR0H5NdGAtqegCbWqyjjcYljx
         xpLpN+ml1RPbK2JkRrBx14f98hABvY/wUgoms/BO+EM/Yx1dgclZ9hsCjoh2nhb4Qty6
         5mLmZxl7bBob6bY7n8AqNkwrqAld9jOu/phRz/MTknqomrSM9cgwnyeCEZhGqaFTfz7G
         yfyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780689647; x=1781294447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anKJ8pGmWaZxfuJHLMfCz6KAXzqmGVAH8Sm2THG/C5I=;
        b=Vimxz1A8w3BLGVA+d1BCEV4pcBDqwPcijrIx67kCCTSNVXjUoar//E0JZwVMt7pBIL
         vAQafVKFCt+AGcB5joJLZ7P4VdPTmgh7DE5DofucSph56oVMo4QBsD7t4Bp7q70UvzvA
         CgaJekO5MpYJJ5LPDibwsxluUE33fiWOAcEOemPVXL6Zsq2gdHuXsZqluWLQawJpbmbT
         8M2qq0YtF/HQ0w39WsIcdlDGvwLvTw9Aw3/NXo9Dd4aZrpdtMVWfEKu+gw03xhFkxt0z
         RciREOXz2ljs1jsY5jn9L9mjUFVxtbTG54Wl+An5hJRGXKJVz2+IvNDZxeE1W1tes6I0
         geZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689647; x=1781294447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=anKJ8pGmWaZxfuJHLMfCz6KAXzqmGVAH8Sm2THG/C5I=;
        b=ojhJm9flLpoV7nMiOBdJ6BeUHL7MqUeDpfbsdklXUbEPvnsY3ClIkHjsLjzirUNWWY
         QL/zp2w3yPMQPSFgC+Gl4VF0BsfUfa+JI2dmZqIBuWXznb1EtEZFJU4sPcjwFn3dvObd
         DXawiKSZ6wNRy16S7owINtvZ5J7kjWBA2+X5Aw5edp4PZMLctw87Oq/frfnmEgNKaBdz
         0rbLka1czPpgF1jODZKhr0o9c2qmjJvf6yXbQa7tT2Gt8qimBy51VPbHJkmkq5PxuXj+
         Pm/pCnLMDgY0eP65iuqkU9+FJnRTfsAb9oJMSxJvf5Ipu5Ft2QwUYsU8WmBNykx7srA/
         zrSw==
X-Gm-Message-State: AOJu0YwH5R3FFiPz+4EaI6sdumglK5HIklo6pV2GG+BfRzGKyb7SaJtn
	xA3Snq8u2eyBf9AJt74AkQdQG1hhHr52iM5U+/7JmbBWstKuDUxgq9tI5YSOluhG7jq9Wcb8FRG
	ZCw+NyNwJe/1gEBZh2wx8f2mBR9rZ69I=
X-Gm-Gg: Acq92OGhbYLwh7FhKJ09Zq650EnTt8Go5kG8zEcXAa5D9YTUPRsljEXgjXitjFIieRi
	c79Px00jHD/ijYmf9GAvXH/JRAbkZrWz2ehjjqHX3YfL88ljm3GjyM+IkgsUJyywZEMBLrUVbED
	LKWNXI+BrLgQ+kr1Rd6kgSS1YM3gO4hpJnl/sjDLSrQ7E95+DFWa3W58v93b9wYsgAIJfYIujr/
	4xHfr0KKYrz7deta1+hjo5etkqmr+/gJxHcrObFck7hj9Ilss1AujNB2tjZu/5PMGeJMyPrMpqr
	UFw7HCxi3XX3jCi2FEfLOduLihlHWELaKQ==
X-Received: by 2002:a05:690c:260c:b0:7ec:592a:a75c with SMTP id
 00721157ae682-7ed11387deemr54155907b3.39.1780689646661; Fri, 05 Jun 2026
 13:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605183551.969144-4-ameryhung@gmail.com> <5bc665c5db9a7007304ff3a428a05712c818dd9909feefa9cf72c1b30909ee66@mail.kernel.org>
In-Reply-To: <5bc665c5db9a7007304ff3a428a05712c818dd9909feefa9cf72c1b30909ee66@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 13:00:33 -0700
X-Gm-Features: AVHnY4IPPBb1hFmWlzq8CwJBu7DDr9VcTmrkbL_hkArbssqCcYhMI20orHkNup4
Message-ID: <CAMB2axPLjHetacZK+nTRGvoE17+bgasPyhv9m1HkOQzJUM2Okw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 12:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > index 5945956a7573..06d9ae24f006 100644
> > --- a/kernel/bpf/states.c
> > +++ b/kernel/bpf/states.c
> > @@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *old,=
 struct bpf_verifier_state *c
> >                       return false;
> >               switch (old->refs[i].type) {
> >               case REF_TYPE_PTR:
> > +                     if (!check_ids(old->refs[i].parent_id, cur->refs[=
i].parent_id, idmap))
> > +                             return false;
> > +                     break;
> >               case REF_TYPE_IRQ:
> >                       break;
> >               case REF_TYPE_LOCK:
>
> This change now feeds parent_id values through check_ids() in addition to
> register and stack slot ids.
>
> In the v1 discussion, Eduard Zingerman noted that since not all ids
> correspond to register or stack slots anymore, the WARN_ON_ONCE(1) in
> check_ids() on idmap exhaustion should be removed:
>
> kernel/bpf/states.c:check_ids() {
>         ...
>         /* Reached the end of known mappings; haven't seen this id before=
 */
>         if (idmap->cnt < BPF_ID_MAP_SIZE) {
>                 map[idmap->cnt].old =3D old_id;
>                 map[idmap->cnt].cur =3D cur_id;
>                 idmap->cnt++;
>                 return true;
>         }
>
>         /* We ran out of idmap slots, which should be impossible */
>         WARN_ON_ONCE(1);
>         return false;
> }
>
> The concern raised by the CI and Sashiko bots was that a BPF program
> leaking many references could exhaust BPF_ID_MAP_SIZE and trigger this
> warning, which under panic_on_warn becomes a denial of service. Returning
> false on exhaustion was agreed to be acceptable; only the warning was
> questioned.
>
> The reply on the thread acknowledged this ("Ack. I will drop
> WARN_ON_ONCE(1)."), but the WARN_ON_ONCE(1) is still present in this comm=
it.
>
> Was the WARN_ON_ONCE(1) removal intended for a separate patch in the
> series, or should it be folded in here?

This is dropped in patch 4

>
> Reference:
> https://lore.kernel.org/bpf/6d86c2fae9be63eb110ebd5b3fc19bc4cf1de2dc.came=
l@gmail.com/
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/270340=
08594
