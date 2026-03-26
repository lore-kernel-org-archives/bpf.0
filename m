Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFC3176FD
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533632; cv=pass; b=fV283igEHxQrgYu/rhNNvdnmpW6Z62h2afo19iZfw6tmeetGNKOSuwLDUqtJUrdV2c0OZV4RjF8OezQIjS7a81b9LjY/0Wl8xSHeuje0ikiAQ7BTm+YSbcW2wlo2hWOTN84o6IJnQPRF+SwEHn5G4iouDuIRl14huA1ym4b3H2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533632; c=relaxed/simple;
	bh=C3BFU+HgMFsTvSFVOzF12PUefRg7K7DU4x5ITqanPXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtMT9XjURB1+F8d3rzuH0aTFB5HlKjV2FHjn1ICMP4cKAyGVWKwzFT59CuWbUH2jzOt4Q6iUXOJ7tpnvadhYgMEoRjNLcVqT4PDakr8LsEIzQzCI16gK0xQ2gAyagqZAsMegoPX2RDsQkFSHU1+grheqFJtdf6V5m3xztH2hWgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BN5ux+Ed; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN5ux+Ed"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66132b22182so1335458a12.2
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 07:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774533627; cv=none;
        d=google.com; s=arc-20240605;
        b=bgnT0OygZdKi/0JBKO8/kg77dwxZ97AMiHs2yZ6M57dXg93shpSdh0kUZUfNdTjbpn
         w7D7NzgoI+r4XH5WLA9Hewkg1nYluIakcF6EXNUiu+UI/JaCEvrjAialHrAY/zSV1CMW
         kjhVpXuRm4lwGTfUriJUFsBo2wK5zgF+ir4nghXildcLTAXekG+z4f2NauwpjjCKj5oi
         WssyZs9sUAk0MZoFVbKqzh0qD7rGETUpr0xjG1S/LeE2CL+tBd5wqaR1xieqgA1BPLx9
         fUI1eGVblUNcTNmBUDtSLW1PtzNAMRtzP02njPb6DjxZNrtlhI3ClNCuh0WVjQHFhODF
         eJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bRRNnHVRKJleP9fk5kO+DqTF75Ip/UYPKvqL2dl6z1k=;
        fh=FUScmttBB4fYGSclmY3R/1hjO6zG8gHHbhX2/AdRmYA=;
        b=DXGAduAmA/GI9Fsws0y2L3ahCmskPPXZkIkN8ouYi1Z8C1PCO+lFMsO9Ax3VTDhSYW
         ZC37cnzPsUTyl5Yecb9KAzGKYyBoAmYyHNKBjuQQrqPSWPw9R7YXvTHgXB1xhqx+9jLl
         341hi+gQaH3yP9Tys2L9hK2ondwf1H4jdKXtAUbS6wWEtAws6hWHHkzRG7cSWKE3dt0h
         +zYma2M7N+L9KLlbEmK3obEaDoUzJpNODPNhFeEifyYv9NP67Tk6TGlfo9/nEQ6BwLxj
         5bGqJg5ZDFfvld5TQvTMVV2BsxXPv6SBxq3sYsyJI45IG4idLL3pL2gH1vdyDdcOBFsW
         J1sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774533627; x=1775138427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRRNnHVRKJleP9fk5kO+DqTF75Ip/UYPKvqL2dl6z1k=;
        b=BN5ux+EdZgbhdOuAN6ZmUtGgnjwN8Fg+evbQqIviy2FxHLRbJYmgLxmbqXKL7HLgzi
         cHuhyjBHqWEZGnAc0jZT+41PEwY8UBPcC6nwgXnhAA9ePM4BNbUDIjjQwq6bhpk56dnD
         5tK+/OfC6quk3Q+/Dea8Y8UCB8xd3Kg2egU5kksj51R/utlDxXcBZWW3Arq8UUz5phDu
         ZfF4H+BXwaZuXbbF64ypzGrSmAv1V9agsCHoTurAxnuDelUOIMn8L0AWt1ykCTY+XFOx
         4d5gIH/dt9xUDSt8XrbihkBYh9iEondfufQgszj1kKKkSBB2IFMhWZ/w7HpzPqg+6VPV
         6w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774533627; x=1775138427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRRNnHVRKJleP9fk5kO+DqTF75Ip/UYPKvqL2dl6z1k=;
        b=dDbyQieMZSwlLjLSdBXLOHLepniRz0tI2PdcI9aNPdYjiGaX0l3ZX3OnT7KtFgjEy+
         gUBzakFL+9/v3Jd/qTQdBtI6k9beYb4hHXU59Lbx39nxppQNEBXgwRaAIe+J94CqqVkq
         1C7Tv+YQrnu3vpl5vQaJAkH7+X2Tx0WCtg3PwTK4GT7Fehn6/gq/YI1u/yLdeMF9N9PW
         zRLVVUrZDoqjCbtqu9qsXp2WHDKdOHnZomDmWkRJrRyMFnVivx349xKEurM7sgCg4sJX
         01pMyYdBAGSIW24kzZlLF/oJu3k0ra2jBJScj6LASwlJ1WTsxAyJX19wvgAax8C1cTNG
         gqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUywrpinprQkqLkI1LcWN2DGvBlBUe50fwxzquQ1/8IDWSzneARiGMr6SCdyHkY/cTxtYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4E74wU/w1lB1A7LO8UrgRzjlXQVwXSBmW852odsu0Z7/4+UDV
	OCmURQyf0CPmBlC3tmNokWx2TCxfuOig0XirZdQ60MRJse407LGKC0Krtacj6KH0WafhpioIELU
	ak7jr+PoXvF305MfqlvUawVYBt+KeywA=
X-Gm-Gg: ATEYQzxeckWnREqhfBV4N1MxtRFrY9SzQezvgJ2qQt8OujeyudtLr3Ot/Rao9ygCPbw
	yNoqXJvJNUD5jIdCas7oyir+GK5fpwSeF/Qg8WrLl7d9/DJ8qmQRadIDHrVLARiZfY+V+LCuwN7
	ZnCfKIVH6yru/3Co3y8co0eD5JX75vR/1OdinYcrh1K9xo/yhTjEnOMwRhiTQW990gWKhMFFiDZ
	KcNSJ87nFTfWL56B+eRR97b+KTZB0d/KVqxlBNueso7QXuWMFc6me+pbpnzvLrvVf827adpKgRm
	6JCGqaWreU7rAFNOtxvThfs=
X-Received: by 2002:a05:6402:3587:b0:668:732a:edb8 with SMTP id
 4fb4d7f45d1cf-66a826737bbmr4984070a12.16.1774533627115; Thu, 26 Mar 2026
 07:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
 <20260326090133.221957-4-tangyazhou@zju.edu.cn> <e6b07a39-c2d6-4adc-bc6e-0d31472f9550@huaweicloud.com>
In-Reply-To: <e6b07a39-c2d6-4adc-bc6e-0d31472f9550@huaweicloud.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 26 Mar 2026 14:00:07 +0000
X-Gm-Features: AQROBzDpoe-naF5EsgmUGroorqCnj4jonjecJLoiT3qF86bkSXQNv8N_M_lrKak
Message-ID: <CANk7y0iUYYHTQLoS7uTj5+puP_p5QjqyTVkconV84VWYCwirQA@mail.gmail.com>
Subject: Re: [PATCH bpf v5 3/3] bpf: Fix incorrect subprog ID in dumped
 bpf_pseudo_call instructions
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, 
	shenghaoyuan0928@163.com, ziye@zju.edu.cn, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:55=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 3/26/2026 5:01 PM, Yazhou Tang wrote:
> > From: Yazhou Tang <tangyazhou518@outlook.com>
> >
> > In jit_subprogs(), restoring bpf_pseudo_call instructions truncates
> > the 32-bit call_imm into the 16-bit insn->off. For large BPF programs
> > (e.g., call_imm > 32767), this silent truncation causes find_subprog()
> > to return an incorrect subprog ID, which is then stored in insn->imm.
> >
> > Consequently, "bpftool prog dump xlated" reads the corrupted insn->imm,
> > fails to resolve the subprogram name, and incorrectly displays a raw
> > kernel pointer.
> >
> > For example, dumping the xlated bytecode of the JIT-loaded selftest
> > introduced in patch 2/3 (call_imm =3D=3D 32768, i.e., 0x00008000) shows
> > that it is truncated to 0x8000 and reinterpreted as -32768 in s16:
> >
> > Before this patch (with call_imm > 32767):
> >     4: (85) call pc+2#bpf_prog_71cfe20590be813a_padding_subprog
> >     5: (85) call pc-32768#0xffffffff814aed4e
> >
> > After this patch:
> >     4: (85) call pc+2#bpf_prog_71cfe20590be813a_padding_subprog
> >     5: (85) call pc-32768#bpf_prog_5dccd3f669bbe4e4_target_subprog
> >
> > This patch fixes the issue by passing the un-truncated 32-bit
> > env->insn_aux_data[i].call_imm directly to find_subprog().
> >
> > Note that the assignment to insn->off is retained. Although it still
> > truncates for large jumps, it remains correct for the vast majority
> > of BPF programs where the offset fits within s16 bounds. Keeping it
> > ensures backward compatibility for existing user-space tools that rely
> > on insn->off to display the relative offset. A comment is added to
> > explicitly clarify this truncation behavior.
> >
> > Suggested-by: Puranjay Mohan <puranjay@kernel.org>
> > Fixes: 7105e828c087 ("bpf: allow for correlation of maps and helpers in=
 dump")
> > Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> > Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> > Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> > Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> > Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> >   kernel/bpf/verifier.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 702579f56f7d..e87fedb09e1b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23017,8 +23017,12 @@ static int jit_subprogs(struct bpf_verifier_en=
v *env)
> >               }
> >               if (!bpf_pseudo_call(insn))
> >                       continue;
> > +             /*
> > +              * Note: If the original insn->imm is out of s16 bounds,
> > +              * insn->off here will be a truncated value.
> > +              */
> >               insn->off =3D env->insn_aux_data[i].call_imm;
>
> seems we can just set insn->off to 0, right?

If the insn->off is valid (not truncated) then it is useful when
dumping assembly using bpftool. But maybe we can set it to 0 rather
than some random truncated value when it is out of bounds.
