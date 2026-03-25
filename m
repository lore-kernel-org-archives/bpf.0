Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98883BADB1
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446744; cv=none; b=e3/wYkxaXbWSwvhx/K0pqN6ZEjEgfanzVOqeH1e+TJ+DnGxAe+2+FGfeCqqq/at8hdZBCpTnJA5icq7lKjAmptnL3e9+BvaW6x/qzWJIwh6Yp8A0Y4Dv9a31Fo5wFHCn5FC3iugQqQGh5B0dOSHHYDuRlsaM590Zvq1GXfLRBkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446744; c=relaxed/simple;
	bh=trCkqZ+AKqMwBw2+4y2i5Y+On1vYUKuzF21aX8WZoPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nW61XniGiarU2cJ4aPemSK2TulKivCP3jVnydydksinh33pD40wra+jso2EGiBZTZu7qzDYlgDGmFwEH+89PcOKzyCK9HEfrIJlRyPl3kTtukirPeFvdoBwEgSJ1rDO4GlaUF/x1xalwNKFYoiL+y1NpSyoQ7itxS3K3mfwZUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihf7oe71; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihf7oe71"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so48072525e9.1
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774446741; x=1775051541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAGjP+5Q6YZHuoHgYCjNJ0BKiUfjBEOkFy74Is07gp0=;
        b=ihf7oe718bQc2SpWLEq9OdxjlssA+fBIZxxTs4tVqU7L4zMx6AQUgpvfLKKHlVgb3X
         Ty0aacj9/x0LeoZTcT2NSsk+NAZaobPzTSy8JA6TDugMgIjL1RWOImYW3NLKkmVA1yO9
         mQSsYhFRuWV9XtkMHx2WHLPxnAdBtaZfUaVpToPbHtaSH5VzkxWEbw21ftftgoZatYpe
         2bsxjIpxG0owoV2uUZ0fFmcBSbTCRm5atq7NKAK0S31t2MUu06e/MJzCIjHZJdFJNnLI
         B/LxPvtxpADWOTWsFUg8JPiW1PeU2yCsf4jQ1wqfbiNJNiCkP3jf/7IjgPyCfmBOEa+l
         CXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774446741; x=1775051541;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HAGjP+5Q6YZHuoHgYCjNJ0BKiUfjBEOkFy74Is07gp0=;
        b=JjwzXQFHC1IRkgjnYpas2yP1PTE5tDyfqjkt07SDign8qWs8cyDnaN7VdYCY7df66Q
         r+vpb4Ncfzp4WZtcoDuXH92YeKqxQFsMZMWLD3lLCmueBWc0rA09L5s7Vz5W24R+cqOE
         MzdXijinGwo/P6D1k30JZ92ZPfiCbhjrFDvqKo8UW146qQetwF5aFaGSFdfff49x7NG8
         T5XVTgpMpC5W9F3oM3JkZ3t7mHNmi7P26IYu5+9QObKgkmC6oecxy/L0eo3d3Gdm/3ZQ
         C2gCJv8uu/V5xAzgWUghVgus4WiN2O/ykHbJ3w6BzWPnCT0y9pCT8wnNmCQGWGNTw6tq
         HFDw==
X-Forwarded-Encrypted: i=1; AJvYcCVHZ51b0pljTjVEXV3A+yNVWjx3/YR1BsIBjypj+NLzksPBX29HNOge63UJwfYhJByp09E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvebRcNfDyw4hpy/bTCL4KzYOaXxr63X/OttFtvDVFDombJkDh
	lAzw5KaNyKshoM93DLC6usjuneKxpHuvNMy0ETRYy0hJyHs+BiaFmiMJ
X-Gm-Gg: ATEYQzzMEjCR7HLPLfpQSi2KRIyp/d5AjJTVr2mgdLuu3TY8MRrAenW/uw6W8qmMBBX
	mMVCFJMIS3m9IX3Oh+JiHfx59WOmihGiebSHCg+eq/H6BN9lhJMNyEXA/6W7aR4N//U4E8IhBMA
	CwLwYal4t9xE5FwKIuZ7/jhmUgusIQxzlUvse4aVoRXVeaX9HPAjQmUdwgMRjEkbv2yP/XknhqA
	ueeRH2V7zMQhfLVud4zmIZ6FEIvP9+Ly4fq7yy8qbzLhF0Ty54JqvcM/HZ1y8K0rPlRJbv2aipN
	lppKr0J3p4te+BwfCb5MToPhtolLIVlNYwJQFrpiA7lbvuksKQAJ0K3ZUWKRJLVRMVFzaQ67ey8
	z+oSVmtc6l6bG6FSIF3Mo2leLWrzWnQuVON7cZs98PsuypI0iqwlSypncPzdwz1fTx38YWPwll2
	j19FD2SdWJleNR61G8IfK+P2CKww==
X-Received: by 2002:a05:600c:8b88:b0:485:6bcc:87dc with SMTP id 5b1f17b1804b1-48715ff3634mr54409745e9.14.1774446740907;
        Wed, 25 Mar 2026 06:52:20 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:75a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871176391fsm121338525e9.12.2026.03.25.06.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 06:52:20 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>, Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 4/6] bpf: Simulate branches to prune based
 on range violations
In-Reply-To: <CAM=Ch066+XPxFJTN-QSFLBC0fgfpnvvEfkrGnjsdeTgfTzpWLw@mail.gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020.1774025082.git.paul.chaignon@gmail.com>
 <87ldfijz7n.fsf@gmail.com>
 <CAM=Ch066+XPxFJTN-QSFLBC0fgfpnvvEfkrGnjsdeTgfTzpWLw@mail.gmail.com>
Date: Wed, 25 Mar 2026 13:52:19 +0000
Message-ID: <87tsu4hv8s.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com> writes:

> On Mon, Mar 23, 2026 at 12:19=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> Paul Chaignon <paul.chaignon@gmail.com> writes:
>>
>> > From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
>> >
> [...]
>> > +static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bp=
f_reg_state *reg2,
>> > +                             u8 opcode, bool is_jmp32);
>> > +static u8 rev_opcode(u8 opcode);
>> > +
>> > +/* Learn more information about live branches by simulating both bran=
ches being
>> > + * taken using regs_refine_cond_op. Because regs_refine_cond_op is so=
und when
>> > + * the branch is taken, if it produces ill-formed register bounds, it=
 must mean
>> > + * that the branch is dead.
>> > + */
>> Sorry for being nit-picky, could you please use kernel style comment sty=
le +
>
> Thanks for the suggestion. To clarify, by kernel-style did you mean
> keeping the beginning line empty?
> Or something else that I might have missed.
Yes, first line just /*, then text goes next line.
>
>> maybe reword it a little bit, instead of:
>>
>> /*
>>  * Because regs_refine_cond_op is sound when
>>  * the branch is taken, if it produces ill-formed register bounds, it mu=
st mean
>>  * that the branch is dead.
>>  */
>> Something like:
>> /*
>>  * regs_refine_cond_op() is sound, so producing ill-formed register
>>  * bounds for the branch means that branch is dead.
>>  */
>>
> This sounds good.
>
>> > +static int simulate_both_branches_taken(struct bpf_verifier_env *env,=
 u8 opcode, bool is_jmp32)
>> > +{
>> > +     /* Fallthrough (FALSE) branch */
>> > +     regs_refine_cond_op(&env->false_reg1, &env->false_reg2, rev_opco=
de(opcode), is_jmp32);
>> > +     reg_bounds_sync(&env->false_reg1);
>> > +     reg_bounds_sync(&env->false_reg2);
>> This is probably more related to patch 2: is it necessary to have both
>> true/false_reg1/2 pairs, it looks like we process false branch before
>> the true branch and they never intersect, don't they? So it worth
>> removing a pair of bpf_reg_states from env?
>
> We do process the false branch before the true branch in
> is_branch_taken->simulate_both_branches. But when both branches are possi=
ble
> (we return -1), we need all the four env buffers to hold the updated resu=
lts
> of both branch simulations simultaneously.
>
> The new verifier state for other_branch hasn't been created at the time
> simulate_both_branches is called, so we cannot copy the results to their
> final destinations immediately. We must hold them in the buffers until
> after push_stack,
> after which we can copy them back into their corresponding register state=
s:
>
> copy_register_state(dst_reg, &env->false_reg1);
> copy_register_state(src_reg, &env->false_reg2);
> copy_register_state(&other_branch_regs[insn->dst_reg], &env->true_reg1);
> if (BPF_SRC(insn->code) =3D=3D BPF_X)
>         copy_register_state(&other_branch_regs[insn->src_reg], &env->true=
_reg2);
>
> [...]
