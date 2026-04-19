Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA73321AA
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776576964; cv=pass; b=VM76AafAfeWqjEPi33XPiurpnBiAiiIMLAjn9fQdfA3WyDbGXkK8CUNMmQaRPqsnRpd9UATsxkxk8hNEr5UvHcz7LOjjijl3jwPu+De0E+Ejr4qYPN8fyEg9Gg8TDpwi+L/JMWQnRxgJalz4c7IGXv9sCnqjnKEdcglvI65onH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776576964; c=relaxed/simple;
	bh=0PBskP6TgtYiOFKbT2O2FYveO6PB5PTjFDfz3NAJLyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnSNKFkMrYI4ypGh0lT2Kn0pWKpIjquJ+AgpHIN+d43TsFHroArvRiwVF4E6dZ2INRberOUBUCWDuReFeVHm5m1dqHAwLuSI2ba0v7V6EzGErBkmq1XfVZSM+hgUH2RB6VcbuY9x7PRJxzccQoeEDDIMY6ysi+yyP34OoYIQlkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS85RwII; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS85RwII"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7b186dfc1d0so26853737b3.1
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 22:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776576962; cv=none;
        d=google.com; s=arc-20240605;
        b=kNQYyRuLscuLr/NzdYsf111AtT8aSwuOAG74xNcT2gy20OuJHZFDAvQ2hJKeQA3JAg
         +vzF1cqKB5/Q4a0xG+tGgwFfW5D4oXxLOpKLtC6DNcITt0oP7Qt283Bi2PmdSMuDcWCk
         SK/oPYviXMAa3lmXin7Z2UJNJpiBx+lFdAGDf6kQaPCHpjFs6svFhNfyX3t8riL5Fk3Q
         JWawjumZIPwZnAkYOGYiTAbN6JiZjbrq3w6Kxc5AwBHhsYPjOlTIRRHQZ8DI/N1IkyVA
         3sbarUjlO21mPMZfrSW0A4q6KD4UHkZMyqjyVGopprUZswVogwdg2c5zCidgUjHNaFM9
         sadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0PBskP6TgtYiOFKbT2O2FYveO6PB5PTjFDfz3NAJLyQ=;
        fh=Wvr+l1iQ3yGi2t7s3751/3F+oEtSTRx843ZNad+ZRR0=;
        b=d3pdx6E6k/UEbajBZnkaf/UcsT2nf088n1HR4n9EpPn/T3MwnRtC7mlKAyL9MhSmHr
         w31XUM9gtvbTRhR58MtT9Pt8Ru8z67jn4xHbKRP2ov3sati5ciVfc55zvdAnxMbZhg2O
         4Tjee0IGeLPGl7lNfW3iD3ToBB9kRv6FUcS46CwSzuEyLcgtRGKGlaLVU84/wHy9lktS
         k5Ty/GqejUX/0NNAFqJhdXtFHHOXJFGqgao2IRYo+7ltoWDVJGYja1JtvoeggoOem1Yy
         v2MpylWWXbT3T2DfpDVXEWKYURjgV4PDuSOx9p+L35fijlOBkVhO3k2A9n3h79QNUcnn
         Eoqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776576962; x=1777181762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PBskP6TgtYiOFKbT2O2FYveO6PB5PTjFDfz3NAJLyQ=;
        b=mS85RwIIqr4E+dPTf492oQyRXm5uVHMyZvekRdiLFC1oxtRQSd85yAyZgLDRnynqa0
         q3fo31CtTfEhqpfMT2sY4To+A+uFXsh7tA/FwGZj0mbhPjKeoBkIHDKvzWOdFL9SidMV
         oIxgONgMcGmMFocVv1XwV1pKDNFShL1AuLEIAAgUd4njl+1rTiNfFnm7D16F60bTjDsj
         CXQVgmIdMiVzZ+wYj9zicLPcA3ZBJBGqJVNBSpy8JAqkvFwVoRhSiyVub1esicNVDS4S
         xzrcLFQwWP9JrqedSX9XUlFJWG84bLDbY+43BocLTq3lxcuA1XsR1JqP9AonY7fbf8DS
         DMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776576962; x=1777181762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0PBskP6TgtYiOFKbT2O2FYveO6PB5PTjFDfz3NAJLyQ=;
        b=q1pumgczGmu4nTG3FcOlr+oz7d8GYSpHIXWgFZTv6R+X1Qxn8UsDX3Lb0iST4wCkEi
         QmoUFC9pbuCb+FdC90QwufD8UPZFpGmCv9Unve+Ggbg0kjiEAFUr+mKyhh+283aODaej
         ZdBzrsdm9+TFB69qwzeDpsMNqL9NM2I/KQHUdsp9ISVXTo+ldnOyK6bD1HhldGstLuoH
         XwBbhy9aMmkyeXM4Muwnn6atWXX5Possw2C7MY5hxy2ByNWvtYZm4fuMg5rZVjXG39zw
         8Po54Q/NVYa75TVnh8RtDSadz1TVCMNPb2CayM2jOX+sxiFWaX1j4TiAyQWK9r2IY8Jc
         fHlg==
X-Gm-Message-State: AOJu0Yy6ZEBuYWWPHtEvF31cFHwk+JnXOdRcikePC1XDiUlAV9mElKLW
	o+30nxdsuvsxi+PGHNxB9PunqI4f6DYfD2MaHpBctV8Y7jGEKDFV7hXO+ng9Qd5hIvh4C0pq+Iw
	8b7LH9znFs+6P8w7daeMJAdx76cG1ra8=
X-Gm-Gg: AeBDievLOLOskVsdqwqxc65gmdpd9gC1vFteC9WZiH0GPqEY2YQh8x8wpPPVVqvlfuA
	TqMMxcnJ9pSpCwDuZZi92bMU1Ftqx0O3akUWQ5CCditAivBQ1vUV3y8m21F+lLLv7mpETdS97LB
	GcMH4pBLdyo0DyrNZxdYkjhlqDKz8Fyiqgh39x2xdYRfpnHzVm/tGYSQouYwNWf4aHTMBZKrG68
	CnySrsX9SXnMdbWS3aDrZoFQ/eKwBgDVgiwH+tMbiE64AhVMwVfjAf56TsWZOcNTwYvnTdKW05k
	CLuTxCp0SI6U7+C4GoDVxHz/x3jJhKDRqg==
X-Received: by 2002:a05:690c:288:b0:79a:b440:5c8d with SMTP id
 00721157ae682-7b9ed307ebbmr65155657b3.11.1776576961893; Sat, 18 Apr 2026
 22:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417233631.1443199-1-ameryhung@gmail.com> <CAP01T75=4bpGvmyUjjkqPQ98RJm-YPfnVt5KFJfgce0t-An9GQ@mail.gmail.com>
In-Reply-To: <CAP01T75=4bpGvmyUjjkqPQ98RJm-YPfnVt5KFJfgce0t-An9GQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 18 Apr 2026 22:35:50 -0700
X-Gm-Features: AQROBzADRfQLeeZ_vJQNIQZQHNPYdSrDKtZ996iSffzGXkL-chir_7mF1g5Zmv0
Message-ID: <CAMB2axMC+haTFjmxmHK1kBBtBR4zGph1723su85bwHYLQihrOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/1] selftests/bpf: Trace bpf_local_storage_update
 to debug flaky local storage tests
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 2:07=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 18 Apr 2026 at 00:36, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > task_local_storage/sys_enter_exit and cgrp_local_storage/
> > cgroup_iter_sleepable occasionally fail in CI possibly because
> > bpf_{task,cgrp}_storage_get() returns NULL. Add a fexit probe on
> > bpf_local_storage_update() to capture the actual error code when this
> > happens. It will allow us to tell if it is trylock failure in
> > kmalloc_nolock(), timeout/deadlock in rqspinlock or something else.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> I assume this is to get signal on what goes wrong when we see a
> failure next time?

Right. Currently, these two tests fail occasionally in CI. The error
message is limited (shown below), but my theory is some failures in
bpf_{task,cgrp}_storage_get(). Since I could not reproduce locally, I
hope this patch will give us more insight once it fails in CI.

All error logs:
cgrp2_local_storage:PASS:join_cgroup /cgrp_local_storage 0 nsec
test_cgroup_iter_sleepable:PASS:skel_open 0 nsec
test_cgroup_iter_sleepable:PASS:skel_load 0 nsec
test_cgroup_iter_sleepable:PASS:attach_iter 0 nsec
test_cgroup_iter_sleepable:PASS:iter_create 0 nsec
test_cgroup_iter_sleepable:FAIL:cgroup_id unexpected cgroup_id: actual
0 !=3D expected 3841
#80/5 cgrp_local_storage/cgroup_iter_sleepable:FAIL
#80 cgrp_local_storage:FAIL
Summary: 703/6273 PASSED, 78 SKIPPED, 1 FAILED

test_sys_enter_exit:PASS:skel_open_and_load 0 nsec
test_sys_enter_exit:PASS:skel_attach 0 nsec
test_sys_enter_exit:FAIL:enter_cnt unexpected enter_cnt: actual 1 !=3D expe=
cted 2
test_sys_enter_exit:PASS:exit_cnt 0 nsec
test_sys_enter_exit:FAIL:mismatch_cnt unexpected mismatch_cnt: actual
2 !=3D expected 0
#463/1 task_local_storage/sys_enter_exit:FAIL
#463 task_local_storage:FAIL
Summary: 702/6263 PASSED, 85 SKIPPED, 1 FAILED

> LGTM though.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
