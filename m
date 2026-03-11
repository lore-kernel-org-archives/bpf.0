Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6898F31A55B
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257948; cv=pass; b=JS/5vl0ygfN7wpRiweT5R3Ud3HVbLZiOONEQG/DBiZMBtT0L1xkJxzH84PH2ng3M9IYDrUm/E9AsxmaOVJa1WV6AiPUuTy8G2+j87UMWUSZTpo76fuNUob2oDFG+0xwSMioyaZ0tRjbGZ9NPr33R3cAnEYys1jqJYrCf1wmXkMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257948; c=relaxed/simple;
	bh=mLyJKX0z0UnD26/fVrqGAyrbVvIvKVQWy3TTCO3UDic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkGWnQ9x8euoFoNTi9renk0R7jGQYc5pqK0t9K6eEBD7fYLDf7C8p9+d83cJ/vyjozd9CycxzwtFcjRG2ih+MEdwGj8BkFm/maQRAuLKf+B5FdE5qEwm0JqcYhsRC3zG5EIRYPmxP7mp80tCq3RzTXrvchHht7JIaBVD/GzzwV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brcFPstz; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brcFPstz"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-829abaaa92bso164852b3a.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773257944; cv=none;
        d=google.com; s=arc-20240605;
        b=dOCuwpZSpvGfaipWx/sjIVHzJEJ/bI8PnG91gAljm45jenBzOAv0XAjTFSmrywZvTR
         qytD7DIoRLMhIED263bm/Sg2a8+f+FW2POs+1VXptcCoxd3q7uQDEIC9SmkqPzsJ0f0X
         qdl6J6tYWV2k2CwYX/TRDhuXlO24l3kBVDA36V+6KgbGNYR95dEHBTNqJ0SpPmH5Uvjz
         8ptMr9VGzTsbzRR6c18xIZ95L2eBnLNGVwctnrsS46DJi0RGYyT2bclPHpVQLQS6y9hO
         j/Ly564+U8n6e4ro6yJ2WfE3Drpv68agQkNzGVGo/GMZismj8zyjzNcW/L/nx+zZaAgy
         bkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oGo8IaRI6nSCWA6TsgbfmpupCTd4jSfs0Q7c1ociq6k=;
        fh=HFezYODqB0dHS8ZckTal1iiWnuisbLhk4gui7Bi0T/g=;
        b=V1LBy0qos7zGoId4CocgPyYSf1fhd0QnVe9C0bkwTsHOoPGU1bobo7vH1ejaERPE03
         G6MXRiiTcmebFLBI45EdduE+gdfNAHzNExr0MliFfyIEjME5DxQYBxdXETQ3yJLA4LAB
         9FJXnxOZLByJqeCJQ01ZOGcaJuPd0RvX1uoWcZX0FuJgyh9ZZva87o46/yB1dJc44UqM
         +EWEvvD5NUgIQkUdGTfm1PFP7clbZcpoAGiQklBvdscyX75sCOwDkVtx55hGT1oCULhZ
         gJCdZvq+aJ+ymB2D1rem5F5xgri7oFls+VzDZPwZItqOtudJVrT2k1elQm61kzV0+bPV
         3fkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773257944; x=1773862744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGo8IaRI6nSCWA6TsgbfmpupCTd4jSfs0Q7c1ociq6k=;
        b=brcFPstzzD55BjbN/zufg2Xia8eWLJxvmbbkjJZMp8Kwux7f/bDarKRoS0frYjLA4G
         lsiPHCRQujuJwzni34hPQuIQmf2BXgzsBf2fRtH51/VXguUvf2Fp5h9bXEs00jqo3Bl9
         XhQyF3OusaCAJ54uEvVF9qOMvxWnZOskoJv3n2OXieQKE6OnGCay2B5t6R/IQMY7hyUe
         vmBIi1YAfeomK/x1idBZP57K+xfLZM1d0yFJeBWJHQtB/z+1rx05VOcSNtfhT6OUUaHo
         XIYEwdI+mmgrstptSDKDmVgloS8fICobrJo7L9H2XaonfrJeVmxyB9NEMQ/tK2Gj2eQQ
         Fw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773257944; x=1773862744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oGo8IaRI6nSCWA6TsgbfmpupCTd4jSfs0Q7c1ociq6k=;
        b=K0kH1hCaQAb6Gc0GC8hA3ddQ2huO1O9aVTiwdmGA0NUOeS8BerWJSidK4nk4buj638
         1ToKZXOsYxGCvyTvRNb8aOnCiZyCY0iVvwrctemnSTP7XcZUV6C8pP6ZowMHXhD3gHLN
         QSZQTKXBLr6d4b6hVvjF8v6EO32H/6zGL9S7aPVMy5poviZDkWux1VWPGQETg5t6yymd
         +yXEyStNVl0IciF4vsayQyxB5wCjQuPPRJIvtSI5VFvu8PT5XsDAT6GaTz5gRW64SA1t
         hvr2nWK90jx2goEPirBvQWHB4bJlF8gSY8j1FVeltigR48+AD5CNH10usAMt/PxQ0O/V
         +uOA==
X-Gm-Message-State: AOJu0Ywrs1WerbeA0WVuhLbGB9/5dd+oZI2pzMBs2pYNL+HPMZwuDneW
	A3cyXRf7/LaLHxbcD0QcSLVxPCCEhYfjxxVugtekbiQGOqeQpJvq7piLtkp3XT7gFjISo6ADHnz
	YIIGXwSWYgZSJ6fQImkCnhGYI8NjtlVw=
X-Gm-Gg: ATEYQzynoZo6SgdMeo1v3nRao7E+oovCt8F7+VRlIIOrmn2mGCQJP5e35WumjPCYR0w
	sY8HfmMj3ROdMKsooC3ScpRKz7W/QPoLupDaKEqrDgURaXLs8W1/ZIc5spoWOuiQCv3sixUn7aW
	UkW1aZhpQRrRtlujpe6iAKinpFkmL3QofoFB652xqX6s88dL8bTlfWLEAyvCLwYMpPo0psUc9UF
	CXfWKTZDCV8P7VLDFpzUAwD4m1O0qaCs5X++VMDqycuebEeNoHYIqrzVHbhUoZlG2R0qfoxI9si
	8px5z8k=
X-Received: by 2002:a05:6a00:3ccf:b0:829:8b1f:a3e1 with SMTP id
 d2e1a72fcca58-829f711ff45mr3517560b3a.63.1773257944550; Wed, 11 Mar 2026
 12:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com>
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 12:38:51 -0700
X-Gm-Features: AaiRm51lohapAmPtjK0MnVRFvwqN3yzgXqYTsFTHxMmpnr58SiY3v0-8oHya_NA
Message-ID: <CAEf4BzZab92hO9ERcfkkg2OHab9F4M9fmwc8yudDu7kjp_qu+A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 00/11] Dynptr cleanup and bugfixes
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> This patchset (1) cleans up dynptr handling (2) refactors object parent-
> child relationship tracking to make it more precise and (3) fixes dynptr
> UAF bug due to a missing link between dynptr and the parent referenced
> object in the verifier.
>
> This patchset will make dynptr tracks its parent object. In bpf qdisc
> programs, an skb may be freed through kfuncs. However, since dynptr
> currently does not track the parent referenced object (e.g., skb), the
> verifier will not invalidate the dynptr after the skb is freed,
> resulting in use-after-free. The similar issue also affects file dynptr.
> To solve the issue, we need to track the parent skb in the derived
> dynptr and slices.
>
> However, we need to refactor the verifier's object tracking mechanism
> first because id and ref_obj_id cannot easily express more than simple
> object relationship. To illustrate this, we use an example as shown in
> the figure below.
>
> Before: object (id,ref_obj_id,dynptr_id)
>   id         =3D id of the object (used for nullness tracking)
>   ref_obj_id =3D id of the underlying referenced object (used for lifetim=
e
>                tracking)
>   dynptr_id  =3D id of the parent dynptr of the slice (used for tracking
>                parent dynptr, only for PTR_TO_MEM)
>
>                       skb (0,1,0)
>                              ^ (try to link dynptr to parent ref_obj_id)
>                              +-------------------------------+
>                              |           bpf_dynptr_clone    |
>                  dynptr A (2,1,0)                dynptr C (4,1,0)
>                            ^                               ^
>         bpf_dynptr_slice   |                               |
>                            |                               |
>               slice B (3,1,2)                 slice D (5,1,4)
>                          ^
>     bpf_dynptr_from_mem  |
>     (NOT allowed yet)    |
>              dynptr E (6,1,0)

Ugh... This cover letter is... intimidating. It's good to have all
this information, but for someone who didn't whiteboard this with you,
I think it's a bit too hard and overwhelming to comprehend. You are
also intermingling both problem statements and possible/actual
solution (and problems with earlier possible solutions) all in the
same go.

May I suggest a bit of restructuring? This diagram you have here is a
great start. I'd use it to "set the scene" and explain an example we
are going to look at first. (Keep all the IDs, but mention that they
will be more relevant a bit later and reader shouldn't concentrate on
them just yet), and just explain that in BPF we have this potential
hierarchy of interdependent things that have related lifetimes. When
skb is released, all dynptrs and slices derived from those should be
released. But also mention that it can't be all-or-nothing, in the
sense that if dynptr A is "released", skb and dynptr C should still be
valid.

And it's currently not the case. That's the problem we are trying to
solve. At this point you might use those IDs to explain why we can't
solve the release problems with the way we use id and ref_obj_id.

Then explain the idea of parent_id and how it fixes this hierarchy
reconstruction problem.

But then, mention that socket casting problem which introduces shared
lifetime while objects are actually semi-independent (from verifier
POV) due to independent NULL-ness. Which makes parent_id not enough
and we still need ref_obj_id (maybe we should rename it to
lifetime_id, don't know).

In short, I think there is a clear logical story here, but your cover
letter hides it a bit behind the wall of dense text, which is hard to
get through initially.

>
> Lets first try to fix the bug by letting dynptr track the parent skb
> using ref_obj_id and propagating the ref_obj_id to slices so that when
> the skb goes away the derived dynptrs and slices will also be
> invalidated. However, if dynptr A is destroyed by overwriting the stack
> slot, release_reference(ref_obj_id=3D1) would be called and all nodes wil=
l
> be invaldiated. The correct handling should leave skb, dynptr C, and
> slice D intact since non-referenced dynptr clone's lifetime does not
> need to tie to the original dynptr. This is not a problem before since
> dynptr created from skb has ref_obj_id =3D 0. In the future if we start
> allowing creating dynptr from slice, the current design also cannot
> correctly handle the removal of dynptr E. All objects will be
> incorrectly invalidated instead of only invalidating childrens of
> dynptr E. While it is possible to solve the issue by adding more
> specialized handling in the dynptr paths [0], it creates more complexity.
>

[...]
