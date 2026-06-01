Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD525B082
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339031; cv=pass; b=ObDV5QH5gNepRVO/onlEYIAFSxqmwT6vA+gDlXiPrGcGcIe2elYVNDDmX9AAt1Xcs8P16QaW0Oj0UkXpGTjwC1Sei+WBtaZrNrWXnw4zhU7pghIHAiACX2BKyavwyR+583LlH0n5vuTKavTYgCgtzHDz5dAR5YR9R0yhb9d/MEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339031; c=relaxed/simple;
	bh=BcYRpq671NSY068+BbMd+Lz28HJcQwg2rs1w9g7BNTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ancMRZUJJJB8pVGRK3BNycz2aYzOF7m11Ll9MDl4zPsMKvxDT1XL57bXmy1vKmeRo6n4byPhAqR9Cn0K7likM77wjAEv/qGFc2WE4RVMh2kWkBRnSaPFNNQBBeVnWnnQDD0w0YQlU44vQKxeJ2GAcfdI9VFzB2D+g5qYupUGnJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1yMLhS0; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1yMLhS0"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dee6b76a73so31229517b3.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 11:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780339028; cv=none;
        d=google.com; s=arc-20240605;
        b=CmfZLUFaH2Kn9/NfpYWzRssu+NmTCqUOB53iBoyF/dhiiq5bdEbV8DTj8NNb7bJ88T
         hqr61rAeIZEf7VBs/dgN8yaknOi79T+ei6xQ7RYYaDDRQRqJhLFBV1UhKts4y3Ek6MMh
         CWo+dxje9+JQckoDvmcqMS0/dlvYAuK/IkPXZXdDa2tBzZTei/EN81hEBNCK2ZXVCJHm
         B9lEb2NXgXDcAW6x6xwUqYI5n6a1CHVvcWUu8Qco4FcpPprw6dQ9pDtccVfQs3C8OK6G
         Jcqjnf7ZO0tU++OILAScj0sxActJJ2ZfAzny+mPI1Mvg0ZP/KjYYuwa1BzztxG2VJpbL
         Dwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GotfCq9kR7UkZKVQl6oMniUEgKCNQcaIoodJS7a89mg=;
        fh=bCoLUvtAu1D3hCyKghQ3VLRStVvdR9Sgh3Xhk/87lZg=;
        b=eYxHxujULp6te/pMKJC6NXWWt75H/EesUPVqr6Bj0RyWMd90J4OhFON0Wqd6oxxlXl
         +5MA3GjfxfUgslYUc/PQ6Z2PbjoWn4B2RCXfNSj66fKM46xN1467Z8WvCJ73Ceqt76/0
         jfXJuzmofzPmB6kY/gCV7V+P184TtKlhdwUIamsM7cyPNpgQG9sxbhllV404tPy+5LN/
         TkLxTJ3Q8XBjRrtcVWVp7c85ztt3fA/FsMzpVQh499a2pfifKmIS7+NTiRNsnU8WatGs
         oEgOy8Er5G0Rw3qHz2U1x5ZMNl2ajFws6vZS/kmHnaWmoTjJDXm37Zs4Uuv2qjBX/nQv
         SN4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780339028; x=1780943828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GotfCq9kR7UkZKVQl6oMniUEgKCNQcaIoodJS7a89mg=;
        b=K1yMLhS0fO/LbH2RA62jv63658f7Fr/NgpGcdq3kFJbP+BswnjR9E9FHBOZ4pdlUQX
         Mox9//4US7PF0oxNr8BoJ3eFzzMcu8LdemAZ63PeHyMMOGkSbWNLBawofn3a9tYPrQtZ
         dQfkMBKysB2MkZMvoSbSXjWnBTUKk6mfiH3ga11k3Kd9bHvj7bg/sl+x0dXcYeX2U0TE
         WndcKXwsOZ0G0Y/m6VvpZ5les0lY6AImFDk9MB+2pCoQn7y19Bp5RURExnItBExdAvQL
         6OUzYRjKVOGIV62CNwjfKECB9rHvLKREDiSuSlLPCpsNSSKC4M/YefhsvEpfiBTkogvR
         qjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339028; x=1780943828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GotfCq9kR7UkZKVQl6oMniUEgKCNQcaIoodJS7a89mg=;
        b=cJv5UTnxUZKnfayjZIi4Yof2n+oysWU74L+ebE9dhD5qVLWzId0YLjcGC1U0YpRyki
         uPPWXyJ92ovzRPeMcjwebvpp5c/nzCyi2VqWLVJefrVXnOIsC438wHRRVwB8FtfFR2rM
         2kuJuBi9KD45sYpyQam1+B6YgTavIQznzpawlOoOnBFEndxi9gGmTMmddR6+Z48JzJ7Z
         iimwRZelBk2eOrrlqEVda7F0VUuOM0F8amUIbuDyuB/JxXIDIeU8uNUBXMvw2VMpqP4t
         rWtjlTS/BfC3JQ3zZzwkykvLw4979HnN/NeK05XHHdyAnJbSsVTZH6z5Ecl/W06/7Sya
         vCwg==
X-Gm-Message-State: AOJu0Yw7B12q8zFfWJpxkvzK2GxS+jN2PJavMADmty7FtBMnxfiyv3s6
	a2qlIY8MYAzFWlnaxQXrGp9tY6zBxYFyQ75LByCNO/A0eQ/sj56ujhS3/6FngHw5vgU7DGeJImY
	aeRUU0x/BD8gQLRnUD9xCy1Y3/n93Odo=
X-Gm-Gg: Acq92OGRwsJeGEvcsVFyvPbmj6RPABt9563+cEju63I2/5hmuCHqgzk72lpBGb6Xrf8
	I7V5OAgtgT2/VCK3zOAbUgzouYYBuVkVYwOqE4ZGHxGzQdYhaivRkuYgfJHAd3XStsyDo7c3LfL
	sO2ZB0qXtg2Ul4d/p8+N67XA3wE20VhqUP8E+hIQzpKvO212y9rFHKi8zs4PmDxcNUK91zBTFxX
	hCSR6ocTaYCMc+3hgBUxTxDY4x5gb9qN+C68MYh2PBwHL5jvnzza10UiFNIerHogZaryP3xYSDe
	u8B4UqYAbaMr39RDo7Z0TFfFXrFAwFQHxw==
X-Received: by 2002:a05:690c:b92:b0:7de:795e:e9d7 with SMTP id
 00721157ae682-7e05d8d6a32mr116071367b3.39.1780339028165; Mon, 01 Jun 2026
 11:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529014936.2811085-1-ameryhung@gmail.com> <20260529014936.2811085-6-ameryhung@gmail.com>
 <1bf1a11fa5dcb38287384833dd77c748f3a766b7.camel@gmail.com>
In-Reply-To: <1bf1a11fa5dcb38287384833dd77c748f3a766b7.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 1 Jun 2026 11:36:55 -0700
X-Gm-Features: AVHnY4I9CBzKtblKLCUQevdJLh4pes8gAkfu0ieQIjxc5qQnQ3RAujzPIsyPi-s
Message-ID: <CAMB2axNK9rf12YyLjfeUHWUpGEf=UrCtdHcgd2Tq6KcFY1ergA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 05/13] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 11:00=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2026-05-28 at 18:49 -0700, Amery Hung wrote:
>
> I think refsafe() needs an update.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > index 877338136009..5945956a7573 100644
> > --- a/kernel/bpf/states.c
> > +++ b/kernel/bpf/states.c
>
> I think refsafe() needs an update as well.
> Something like:
>
>     --- a/kernel/bpf/states.c
>     +++ b/kernel/bpf/states.c
>     @@ -886,6 +886,7 @@ static bool refsafe(struct bpf_verifier_state *ol=
d, struct bpf_verifier_state *c
>
>             for (i =3D 0; i < old->acquired_refs; i++) {
>                     if (!check_ids(old->refs[i].id, cur->refs[i].id, idma=
p) ||
>     +                   !check_ids(old->refs[i].parent_id, cur->refs[i].p=
arent_id, idmap) ||
>                         old->refs[i].type !=3D cur->refs[i].type)
>                             return false;
>                     switch (old->refs[i].type) {
>
> Wdyt?

You are right. It needs to compare parent_id, but maybe only for
REF_TYPE_PTR like below.

        for (i =3D 0; i < old->acquired_refs; i++) {
                if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) ||
                    old->refs[i].type !=3D cur->refs[i].type)
                        return false;
                switch (old->refs[i].type) {
-               case REF_TYPE_PTR:
                case REF_TYPE_IRQ:
                        break;
+               case REF_TYPE_PTR:
+                       if (old->refs[i].parent_id !=3D cur->refs[i].parent=
_id)
+                               return false;
+                       break;


>
> [...]
