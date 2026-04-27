Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F23DDDDB
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309934; cv=pass; b=jUWjACOs0hKI6n3jLOipHNBkDpHz3xMcKfcJI19ATJBr08DpMnM7R0d593bEIHQcwrDaRwwMrTUErVquEUDOLkUdO6lvHzzELlGGcXW0XCz6Fxf2wcds7l+zo/fjrBQDASgLQuQup2oO+SRm6DM6/XckHfT/7w2IclblzdYTOuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309934; c=relaxed/simple;
	bh=VpoTm7WNmh2Cp/eL0Z47U7GiiZIpx/U658K9Pg3fo04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q00XZjLgnUwVMSMDbOs5+SPPeZGLEp7wTosQAq9xNmu1dMwAovkrjyBWAJ2sI4Msp+dW04RkVTt9DTqVMlG9rGMZMcdFinzF0hSggYFnaIA3ySn3gxHA6Bp1UJDc8VfwFg25wEWgal5wZsS61v1NbwTzbL+c4ojGJUiRN1nuxGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdDFYJoU; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdDFYJoU"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fe62837baso6159766f8f.3
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 10:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777309931; cv=none;
        d=google.com; s=arc-20240605;
        b=d08pM16Ru1MvPuHNX6rzmyCY1+bd/oMgU/3paU7FxgwwWhC/gs7Sj6uyTzCPKtLw69
         pOHgiafLKj2tvF2bDgLZ/efKjIp0a2Gw89Q0E1lXudowGnD8PxOF+IrVj7x4xTI2krHX
         5khDH7Turz7EhLtgFRGaaQ3cVRl+JSOfpVciO1UPQQPBXcazTWATEAPK64mi1SRdcYSp
         oo9EKywkO8UZ1hGuNOaaDAD4MzDJJlhLwuCiVoOgG7Kp+vGIFSNA4iEbW2V09CY5c91X
         3SYGnw9JsKVJuydwZazz1RvQgs8pPTNGWNqT394YNQjFnStP+XL5YjZ7xELCuSeifuhJ
         4vQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NS85EnFgeKT9n4Hg1aDB5w/EiklyGTmUPl3mnYjLnxM=;
        fh=bZ4ueBsgMWNjgFeI0vlTU+rjcTLXd6qj4J6WyAibW7A=;
        b=QgxGymEG6dkF+6jsenbYX69XLOpH/Du0bglGNgYlOF5FmnVPtCSS5A4l1IWsLgu1I9
         bwiuAaPJtXzZe9GdiNpNpCW89cIQu5/VXGZ7w6E54QU1zbAsuWFtKUc39nI68CyH78WO
         V0iS98/2mEWGyRejo3p5xkIaKaBev/FioVriWLiF/L4nHBIKwNwEidlJJy1l1VlPWl6k
         4WUit2Pp9YBsrGkM6dEAfgFmHCyucg3T4sWWn6ldGeAKMkxt7TBZrnZ5FE7ezZvgtlvV
         EiMGopKft90fjJsDGXeNIzs7XSqzmSIYWsygm30m9d2Ncio8jwXkbIgFwNAt3wM6qyT8
         jqPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777309931; x=1777914731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS85EnFgeKT9n4Hg1aDB5w/EiklyGTmUPl3mnYjLnxM=;
        b=XdDFYJoUhZbVbNba6++bDe7oUhpAb9W+lzKAx3v9sbDi8Zyk8rVtz/Loq+E2UU265n
         u/P/2OfqPLxpkLt9yrsDIat8Dq2pY8ZkTnX02LqF+hiNWj4WYyoMj65neAV4smKMQ2il
         +qeXZMKuoQv+2skaK368YHi0CbrIthw0Jq95I7yDCZjjeTCHV0jRBz16QKjjy0h4nII6
         mMpzTzRS50z5ENeBoA3V2rhYtA1NbsCBZPLaf01y9v4MUurdW7ZF1iRTmNs9mDho3Nz5
         KKuANG2oZjQIn6F2ld4WP4SbWykmMabQA8oadbpbHodFfMl2XSXSOTwUefO1gEyStv41
         SJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309931; x=1777914731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NS85EnFgeKT9n4Hg1aDB5w/EiklyGTmUPl3mnYjLnxM=;
        b=fEkCts5ZyDgyv0z8pbXKheRTY4b+8mE0P3kMT6hmf9n29eTSKokAVqlj6Tb7WiFIfQ
         vu/aeGKq9pWKKVuIlSrns65r/JRvy1bBNvWcAARyuBcGMIQSVjWjIgf+Hh7+qMOZikn+
         bay1m0/Px0tciklX/76eucekeeQdI5Ff+TX/Uc+00M29RSPnk394ho4eCXhrsbKjymjF
         2crUpaKMI/g0M8L3AGPMfmz35awObvrrL40ZuIS7PoN0p+xtqs+v70BlHLJYIGb06ahn
         D/UrkHBcwcLDHbS7u0zasH9wixS+E2XYw5e4w2MuEn8Z7guLmHwFcku43UT1tBz2RGt3
         bFQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/loGjZJf5mHR4L6ACzysyKNDjDSqMuwYmH7qwIz3IwCau99o1I+Qom17J4ep8iMtQpz50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZ0UlqddQiF63AJMlT8FNgIAKdiJQBt3cRPD8Tmjpv584UJ/I
	3CJQe6GyQ1llk56AQExTt/3M5KnzVXtPeFAkOT/B8ZZSrBTAb8jLKScOwA7OdJk3ag68ZkYIVB4
	QBdtnVM4knjxzRZQ03Sv2jWwhWC3HXhQ=
X-Gm-Gg: AeBDietVkALfZacFdH6Y2WQBk2JJuKQrLTUUhZQ+1b1sDPLzuCR6YKHvoaGr/+9Aago
	tVx7mpfTB+CLwWgxKPr3Pf1kiEduUOgT1RUbiJsYl7FeZYqbE5T2D3Z780fbgflB8Vfbf58BTwP
	T+iZaxueOr3Qoju4g0nKLyhtigTWuyqeGyVdYGIvUI1IeUDYuIDs5GswT7xprZ1IqG2IZc2GUBL
	zH+PoXUkfWECXJeFZ7L5rB8sNCgeQPp1OKagkZ7LQ5HOEpfc1haXT7Pb4gpuakQ+QfFXdxADJRV
	sxLUISVR6OfFRzveGL6OMhPayOXwd3KGDDVoj2DCNcsY9GiaRUGWF1Ix2gpkgXEs29CdvgkyvfK
	zcfs=
X-Received: by 2002:a05:6000:2088:b0:441:36b7:7262 with SMTP id
 ffacd0b85a97d-44136b773aemr20757563f8f.13.1777309930960; Mon, 27 Apr 2026
 10:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427112205.1346733-1-alan.maguire@oracle.com>
 <686d51d3081a3c34ce644ac6d52c8b8e41864192.camel@gmail.com> <81b78478b1345151539578cd486b7c656249b441.camel@gmail.com>
In-Reply-To: <81b78478b1345151539578cd486b7c656249b441.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Apr 2026 18:11:57 +0100
X-Gm-Features: AVHnY4IfsNQgQ-UcjO0LXOc53x4FxlfaNlG22rAjfAx1EMU-86v27Pqm--BxIBA
Message-ID: <CAADnVQKuCr-w0d34vPyU=G8NHHiV7GkEY+=QPUSQmSm_nkWv+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Fix undefined symbol references for module build
 post cnum changes
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kaitao Cheng <pilgrimtao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 6:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2026-04-27 at 09:44 -0700, Eduard Zingerman wrote:
> > On Mon, 2026-04-27 at 12:22 +0100, Alan Maguire wrote:
> > > Seeing the following on bpf-next:
> > >
> > >  DESCEND objtool
> > >   DESCEND bpf/resolve_btfids
> > >   INSTALL libsubcmd_headers
> > >   INSTALL libsubcmd_headers
> > >   MODPOST Module.symvers
> > > ERROR: modpost: "cnum64_umin" [drivers/net/ethernet/netronome/nfp/nfp=
.ko] undefined!
> > > ERROR: modpost: "cnum64_umax" [drivers/net/ethernet/netronome/nfp/nfp=
.ko] undefined!
> > > make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > > make[1]: *** [bpf-next/Makefile:2089: modpost] Error 2
> > > make: *** [Makefile:248: __sub-make] Error 2
> > >
> > > Further investigation suggests nfp indeed does pull in those symbols,
> > > likely due to references in include/linux/bpf_verifier.h:
> > >
> > > static inline s64 reg_smax(const struct bpf_reg_state *reg)
> > > {
> > >         return cnum64_smax(reg->r64);
> > > }
> > >
> > > static inline u64 reg_umin(const struct bpf_reg_state *reg)
> > > {
> > >         return cnum64_umin(reg->r64);
> > > }
> > >
> > > ...
> > >
> > > Export symbols for these references.
> > >
> > > Reported-by: Kaitao Cheng <pilgrimtao@gmail.com>
> > > Fixes: bbc631085503 ("bpf: replace min/max fields with struct cnum{32=
,64}")
> > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > ---
> >
> > Hi Alan,
> >
> > thank you for the fix, apologies for breaking this.
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> However, Alexei raises a valid question.
> Netronome code uses the following accessors:
> - cnum{32,64}_reg_umin
> - cnum{32,64}_reg_umax
>
> However, this patch also exports the following on top:
> - cnum{32,64}_from_{urange,srange}
> - cnum{32,64}_reg_smin
> - cnum{32,64}_reg_smax
>
> Why export extra accessors?

I left only 2 while applying and rewrote commit log.
