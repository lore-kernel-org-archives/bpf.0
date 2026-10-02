Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D376468C1A
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940545; cv=none; b=e7gX2CK1L6rEvos8xiA3fFCqjK/AiJj7KVKMexSi4zyLwCEzrl5UfWjfO0BfQ/Xkqe9ktB2Og5OwLTAwLHblNq9aKp7xLA/fkyJqVMkYwCPCyNNN4Br46O4/WXDCXtZnlFm9fUEdqI5H9mD14ALQ0/Uwds5vgHV68JTQ2QkCEzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940545; c=relaxed/simple;
	bh=miQaVkhfy15WPjlNMEK7df5BGO459Gh45dOQytijptI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=adnQeRKMO95lwg8eHqyVJw6My5CzkiShPxmNwqkNBBz1k5oL7aWSRd2Dii5koNy8hfU4BN2jqbLznR55IdQ/cvIGDBHxTTkHDw3Q/qGh9t4On79R5s/Bu9aN1MfxU3t9hpDYJH3uJh4Nfn/wi/MgSdEz9AcYFs45wLOVLshfR1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz6IA25r; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz6IA25r"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb751so3659652a91.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790940544; x=1791545344; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/Ys8X3SiA4hPv33N4Pnk0KGv9PSTrJ+NAk42Cw4+hHM=;
        b=Lz6IA25rPFFSX8rgfwoChPTxhiu1kceDH5+LzbpAcESp9lQvwx/Uo8nQDj8vK5hLTL
         GPkZU35m8FDwGcpLzLQB20HIjtCa6d13AOkksKV8R5YdlPTfLdO+/EapoLZkcFtST10I
         ggGNbvitgsodnPBGhag6w9SNUXqr0OKkVpQtUbw9p6aneYDkl8CKUFxveSbqkphyU+z7
         GLZcOiTae72Ol3JGW5UFP6eRDlhmhEttEef4TIhmG0alBkfXjNugEdXT1CsWGDU4ksRB
         hlQ62p8r4VS4QbAqUDX7jRCpauRO4ARCOUB5ltTg9thPgoA99fqdFBzbX8nRcYFvE/ch
         0+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790940544; x=1791545344;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Ys8X3SiA4hPv33N4Pnk0KGv9PSTrJ+NAk42Cw4+hHM=;
        b=QQTVu8JjTXlIjfP8AoWOdvQI7X62YKsVIjxuyYkr4yQVsvM06qZt8YdtOFRErubLtZ
         J/MJZK0OKWF5nC4ciU6df+o/Rh+RNmHrESdkv7OYh7St9QIVR+laCEMx/gS59wFPHs3U
         y27pG1ax2bhYzp9ikNeNyYAGW89tlFOwjdpbpcXw5O03qFYDH3UzIwshsTnti0X72kcB
         8mkeH/lbCBttll7spEqibUH/ty3RvyIDlNBbEEsoFOxUCKP+JiUTGec4QI2PuSG5pHHF
         wdyyfyTuGJADOZGkyjUHYYsdqEX6G5cpM8TYFdCV+DumTjYrNHVOVva88Iw6cK9z0Cx/
         Q0PQ==
X-Gm-Message-State: AFq9FYIEpAv84KHi/aMnp5IGj6F1XoJtWesb8XxK6vlPM1BQZ4MD7BPx
	TCtlNiFlgluAuqUxRx05SD4DnmWzFseBsUgYfZapyB97rfxDV93/w0ex
X-Gm-Gg: AYBFou2GB+tQG5u3/5sscdCjsUPPaDHSZ9xlGedn1V1EFCJhaxf6eQTurq42alvRp/u
	WbuLruT4N4ltoWgjkS3SAMd2FtL9IO/eeRkiX5hWRq7CNA4F7FgZ9NpeLdhV0yEYgeliULBHaKd
	xDRbEw2TJ36lybs8NkuCYUowpEQKdt9YOMnDkdFbgPXPjCutS8HrvBaEVxCdHbwdKhmLxW3+KQy
	W4dxb4DGvA/aB3a1ADExdSVe2LNEaOo2cU1xBMf02XrzH0md8ZxU4/IU9qerp+5HYqrffrB2rN1
	Kow9dDQdEjC0gV0S0iDjF3CHKnRiVSAqmXu8obaMBEL4bblFQ9O2MrUKRMQfZOmE/MQmRDUl8hg
	rTB9TydUIvZe5qSE+NCseTOKpjFA0LX2P0c311TWC3MwywQA93z1s7v50C5a8B9yeft3ZTxUDHp
	j0wiOWZOp3hXm7vo+nU398tb3fa7RY4HEtNbw+ceUS1ZAzm8ie8G4THWvvu4J8IYriSjTz3RIQj
	aL9bF3suJyRDdbKSqThbGfOmKrQs3AtaiVKEVltP2WOS/t+WFyoa/HrF7FF+Ex0Eca8dllXLQmg
	LnQ=
X-Received: by 2002:a17:90b:33cc:b0:3a0:516d:9f88 with SMTP id 98e67ed59e1d1-3a6ceb054d6mr1279399a91.26.1790940543438;
        Fri, 02 Oct 2026 04:29:03 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6fc716b5esm819266a91.14.2026.10.02.04.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 04:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 11:29:02 +0000
Message-Id: <DLUBFR28IPJM.I3TIXG4RISTD@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Destroy callee-local dynptrs on
 subprog return
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, "Xu Yunxiang"
 <xyx2021@mail.ustc.edu.cn>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260927120422.1042107-1-xyx2021@mail.ustc.edu.cn>
 <20260927120422.1042107-2-xyx2021@mail.ustc.edu.cn>
 <CAMB2axPnwisOQtXymBA5jBTFNEhhummfU7xamvkMBSVC-HssJw@mail.gmail.com>
In-Reply-To: <CAMB2axPnwisOQtXymBA5jBTFNEhhummfU7xamvkMBSVC-HssJw@mail.gmail.com>

On Mon Sep 28, 2026 at 4:48 AM UTC, Amery Hung wrote:
> On Sun, Sep 27, 2026 at 5:04=E2=80=AFAM Xu Yunxiang <xyx2021@mail.ustc.ed=
u.cn> wrote:
>>
>> A data slice is valid only while the specific dynptr that produced it
>> remains valid. prepare_func_exit() copies a subprogram return value into
>> the caller and then frees the callee state without applying the normal
>> destruction semantics to dynptrs in the callee stack.
>>
>> A callee can therefore derive a slice from a local dynptr, return or spi=
ll
>> the slice into its caller, and then let the dynptr disappear with the
>> callee frame. The slice retains the id of a dynptr that is no longer in =
the
>> verifier state, so the verifier continues to accept accesses through it.
>>
>> Before the object relationship refactor, bpf_dynptr_data() slices from
>> referenced dynptrs also carried the shared reference id, allowing a late=
r
>> release to catch some of these escaped slices. The refactor made those
>> slices precise children of their source dynptr and exposed the missing
>> teardown as an accepted stale access even after the shared resource is
>> released.
>>
>> Add destroy_dynptrs_in_stack_slots() to apply the existing dynptr teardo=
wn
>> to an inclusive range of stack slots. Reuse it for dynptr initialization=
,
>> variable-offset stack writes, and the entire callee stack before freeing
>> the frame. The teardown rejects losing the last dynptr for a referenced
>> resource and invalidates the dynptr and all its descendants, including
>> slices held in the caller. Propagate errors through prepare_func_exit().
>>
>> Reuse the existing teardown API and diagnostic. Update the affected
>> callback test expectation in this change so the commit remains test-clea=
n.
>>
>> Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix=
 dynptr UAF bug")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://lore.kernel.org/r/20260829040712.B1B511F000E9@smtp.kerne=
l.org
>> Suggested-by: Amery Hung <ameryhung@gmail.com>
>> Link: https://lore.kernel.org/r/CAMB2axOmdHwSrHihSRskDywkCmEGQOX+6dZPN_A=
9u-HhxY3UDA@mail.gmail.com
>> Link: https://lore.kernel.org/r/CAMB2axMmrTb+UZ84UD48MwMtXbk1s9bWtreU3AO=
fjzU0fPT0BA@mail.gmail.com
>> Assisted-by: LLM
>> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>
>
> Just a note: this series addresses a related but distinct problem from
> Ihor=E2=80=99s work [0]. This series handles descendants escaping from
> callee-local stack dynptrs, while Ihor=E2=80=99s handles helper-owned cal=
lback
> arguments whose lifetime ends when the callback returns.
>
> [...]
>
>> @@ -11675,6 +11683,12 @@ static int prepare_func_exit(struct bpf_verifie=
r_env *env, int *insn_idx)
>>                 }
>>         }
>>
>> +       /* Invalidate callee-local dynptrs and their slices before the f=
rame goes away. */
>> +       err =3D destroy_dynptrs_in_stack_slots(env, callee, 0,
>> +                                            callee->allocated_stack / B=
PF_REG_SIZE - 1);
>> +       if (err)
>> +               return err;
>> +
>
> Conceptually, Ihor=E2=80=99s frame-reference mechanism could subsume this
> cleanup if every local dynptr had a separate frame-ownership
> relationship. The current parent_id cannot express that directly
> because dynptrs already use it for object and shared-resource
> ancestry.
> Supporting both would require another ownership edge or field, rather
> than simply assigning parent_id to the REF_TYPE_FRAME id.
>
> [0] https://lore.kernel.org/r/20260922010333.1226537-1-ihor.solodrai@linu=
x.dev


I feel it's ok to apply as-is or should we defer until Ihor's fix?

pw-bot: cr
