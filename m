Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2BD3783BE
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 04:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570936; cv=pass; b=IyM3Nh5JBgOFfepuZXWL1yjkJa8GSikrQ/+l6vrD4sauTTo1WJx96EOPXewtBl98eUqqDLA5+kvOaazGePOkjbxrKBTH5ojuX2EBmckfaG+4zXc1U9eK6OfW0m25tRK1sElvgtt4L473wxthHb1bVAD32JmpTclAYziTp6qFTds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570936; c=relaxed/simple;
	bh=ShtFsIzcQW6LU25rK/SMgQYWlKXhLcaIcx8z4rpTKEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7d5v7hKiD20cDTggl2SBDnO6RCv4kUZGn4nzXNXOY2O3t0MSi9/+HUcYoRWFnR55vOXuK1oO0Cl3kKQYuTBJCD/YVaRMrQAxNXPqvXg9NSQ9UsT5467jKf4TCK1xsuhAAwH0MfHMgGJxyBtbjLYiGoq1vfHX68iuJQFGSIY0LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAzRk7PJ; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAzRk7PJ"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4b1ba286f6bso2216425b6e.1
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 21:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790570933; cv=none;
        d=google.com; s=arc-20260327;
        b=b1YuYJy09ugHXOkC2Rywxkb5ZVS2Fp3ZTA9Re0ki+hMM50rJyBxerxskjKJKXjK6xV
         UssCLyBBC988YdmaUF4Zb0RLvERQibbBYgyOf7IhjzOODXVaWiiogsR0EunrR9dFML6c
         IaZqP/Px0LKB1NeN2+oVj5w5/F/yMQyaQPG13A0ESEIvBMXfGi+QdbnPhNX9DRJBHpwX
         wDA5CAWrkd9yKm7zaaZ2LI/uqtrEGnZznR3968hGCYA2Tc1P5XLCnbfQTmVDMm5taKwn
         2G3U0sAYR/MxbDPXC9YrSA99VDDHuBGpE0fc8gyoh7UIRhKq0mpuyYX3Yi/vyCzYMTcJ
         AWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pRzCiW2e5K6UigHoLKFR+Dux2mulR7dAK3hhzWftHbU=;
        fh=Mn4Kp/tm7wGzuMnNO6K1cvcBgh/rlyOQShpIgHQn+LA=;
        b=AChOTfZWf8jb57hq2qcVtxqm1ubC1+BmfcOsSpeHYehhLbMgOdR9ggztqVp+6v1Kgi
         +tg3n0JGl0uOamxtigFxa9ntadJDugIj2TfTBOXbkFwgzlslgRwZ2aLIoX6OYLL/UDuD
         6+SVl8Cq/rsqH8NrFj6EenUMfyDQrvgj7i31Uc7VljbzNm9bZ0TCQ/ZMBmHa7x157QXb
         RB3uy9vqV4qRJ8Cqh9UT/DWMS/H59dVwxEPD8chSlenxNmTvd/A8tEhhR9sCdGDozFVR
         lDw4ConDnu7PLjSBseAGbuVlPb1Ijc+l5jekBx1UiGUQniqTsPuvyPP3PY6RsCoggn8D
         auSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790570933; x=1791175733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pRzCiW2e5K6UigHoLKFR+Dux2mulR7dAK3hhzWftHbU=;
        b=oAzRk7PJYH+4SgPZlmqbCJczxrEzFuq6LaBXs7aOl6NkOtNzwD4FH0coZBIhi99fwQ
         dP6OTCPqRmbdXYddoi8ywY8UXdiw8I7ZH0VXi5ZzWT8Lzm5mmDUgO7PD2nRJpYF1hox7
         c9l/4sOKxfM6r9qe0gi87x9/NFsvM6EKEZvPjMAQFYBsYlR0Gioq4r13RIYvtCsWudw3
         nA0UfMEF89PzA7TEcbDsVgv539EfFpnwrrKcQtZ8LOU1UZ2c9pMQfNr4fbt3M5+xatMo
         wQNHE/WNfFe9hC7CYKsxs82UA2w5CT49QBTxYr40i09Jn04/RpN0VDkm/mFF6QUnD63E
         mwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790570933; x=1791175733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pRzCiW2e5K6UigHoLKFR+Dux2mulR7dAK3hhzWftHbU=;
        b=h3PidSsRWOTQF+QxBkgXJ7wCe1jTxqCKgio3iObT8UjpudmBxhvKNngBRXbgKsYJoR
         AwycIF2zlmEm6AtDpyeIaHIKUBo30Isi4j4uSYmDZYqf8OtTAcnPljsZ/smSmarjOqEy
         bjFlaKDfcuLje83Wz/ez2zKcQAy2iCQTd1Een4KOvspTAJop6NfVSmO3EZOeTH3cy97y
         9a4XbHUPjSFnpgMB8v6lMwSn09C0UdP8CjQOvkH1vbTTPnL+csnAX3s5E9oIm+tfyvBt
         hMHsjBvPFNOQQBQnlaDVIvC5St0pii6sD57fCuagCIqpwugtsxBpxF4piAwYChffzNPN
         kW5A==
X-Gm-Message-State: AFuF++n38c+/6fUof/FnSKZij2obPdjTu5abKBRsBzcnTpX6IhLIRN7n
	Pawby9jG+7nkU0bkikPRDMVL1/elXQ7Jpc9RrHYTcF/LpUBAPxq/oCkydvSP0tPNCdA+woa8t60
	3x7XSUv3709SUr8P0SbovaoaepOTGMhw=
X-Gm-Gg: AYBFou3VzHnPm54rNI8h17XOitIqaLVzXx25LeygmsW9cKGcHjqkwO1IEaXZSSG9GZB
	rz19dTIlhQXlFWAgAIktiTJYmFKgsqN9qg1fPOQLWOIFp190KAQhJEvFzPRNKbTrHvhAlczjoE8
	Bzh6oJNIJlHJp8bsoEMM4RUmuc1gEFAXXgea8dTtoFQtT4XT3ppRlnUDXg8Ii0cAdQ1XxBRUfXq
	Tr5Az6DzIRYtRbXwRfRxVKNwbolc8FWol2lPVansWeaWVKagRR93xhE+dHMVI3w//NTZBz7MSfS
	xOHvxFLT5pLWEqb1iVF0KfCC5TQHvyNO2ze+GlXUtEpWLCaMsLgEIi4=
X-Received: by 2002:a05:6808:1928:b0:4c2:a601:23bc with SMTP id
 5614622812f47-4d72a34cef6mr9699418b6e.7.1790570933206; Sun, 27 Sep 2026
 21:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927120422.1042107-1-xyx2021@mail.ustc.edu.cn> <20260927120422.1042107-2-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260927120422.1042107-2-xyx2021@mail.ustc.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 27 Sep 2026 21:48:42 -0700
X-Gm-Features: AclHuK9O8yWQkzfp3EH0LjiFCBmvDVSCCX3Ipsph-UZR8EoD6dVV_SDaQPXvYAo
Message-ID: <CAMB2axPnwisOQtXymBA5jBTFNEhhummfU7xamvkMBSVC-HssJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Destroy callee-local dynptrs on
 subprog return
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 5:04=E2=80=AFAM Xu Yunxiang <xyx2021@mail.ustc.edu.=
cn> wrote:
>
> A data slice is valid only while the specific dynptr that produced it
> remains valid. prepare_func_exit() copies a subprogram return value into
> the caller and then frees the callee state without applying the normal
> destruction semantics to dynptrs in the callee stack.
>
> A callee can therefore derive a slice from a local dynptr, return or spil=
l
> the slice into its caller, and then let the dynptr disappear with the
> callee frame. The slice retains the id of a dynptr that is no longer in t=
he
> verifier state, so the verifier continues to accept accesses through it.
>
> Before the object relationship refactor, bpf_dynptr_data() slices from
> referenced dynptrs also carried the shared reference id, allowing a later
> release to catch some of these escaped slices. The refactor made those
> slices precise children of their source dynptr and exposed the missing
> teardown as an accepted stale access even after the shared resource is
> released.
>
> Add destroy_dynptrs_in_stack_slots() to apply the existing dynptr teardow=
n
> to an inclusive range of stack slots. Reuse it for dynptr initialization,
> variable-offset stack writes, and the entire callee stack before freeing
> the frame. The teardown rejects losing the last dynptr for a referenced
> resource and invalidates the dynptr and all its descendants, including
> slices held in the caller. Propagate errors through prepare_func_exit().
>
> Reuse the existing teardown API and diagnostic. Update the affected
> callback test expectation in this change so the commit remains test-clean=
.
>
> Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix =
dynptr UAF bug")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260829040712.B1B511F000E9@smtp.kernel=
.org
> Suggested-by: Amery Hung <ameryhung@gmail.com>
> Link: https://lore.kernel.org/r/CAMB2axOmdHwSrHihSRskDywkCmEGQOX+6dZPN_A9=
u-HhxY3UDA@mail.gmail.com
> Link: https://lore.kernel.org/r/CAMB2axMmrTb+UZ84UD48MwMtXbk1s9bWtreU3AOf=
jzU0fPT0BA@mail.gmail.com
> Assisted-by: LLM
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

Just a note: this series addresses a related but distinct problem from
Ihor=E2=80=99s work [0]. This series handles descendants escaping from
callee-local stack dynptrs, while Ihor=E2=80=99s handles helper-owned callb=
ack
arguments whose lifetime ends when the callback returns.

[...]

> @@ -11675,6 +11683,12 @@ static int prepare_func_exit(struct bpf_verifier=
_env *env, int *insn_idx)
>                 }
>         }
>
> +       /* Invalidate callee-local dynptrs and their slices before the fr=
ame goes away. */
> +       err =3D destroy_dynptrs_in_stack_slots(env, callee, 0,
> +                                            callee->allocated_stack / BP=
F_REG_SIZE - 1);
> +       if (err)
> +               return err;
> +

Conceptually, Ihor=E2=80=99s frame-reference mechanism could subsume this
cleanup if every local dynptr had a separate frame-ownership
relationship. The current parent_id cannot express that directly
because dynptrs already use it for object and shared-resource
ancestry.
Supporting both would require another ownership edge or field, rather
than simply assigning parent_id to the REF_TYPE_FRAME id.

[0] https://lore.kernel.org/r/20260922010333.1226537-1-ihor.solodrai@linux.=
dev
