Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ED739EF3F
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789416841; cv=none; b=kp2Lhv6igvBSq2OFWE2RrZRoFt55zFR5w/57a+XVHP9hAc4FqEKuA0MtaG0myvPW/jjzUVXttV29gv6x5S3QPWTx/2pDaVJQM9pYTbDunRKNC+CR34kS6OYMudHc+10iH6Eir3pfIfrkTKohC9Njit7OSxFuHpqD8yroHeG4of0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789416841; c=relaxed/simple;
	bh=6bbcFncssDcc1dWubeJNBbjlci8zpQXOfFRKoSdlXPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jW+i0cuZzAoPaS5m/6avHQEBhXkeF0LXOmPo3LAQTEuV5qlZr9i6Nxc3GIXSXaF6KWzlphkbsh4FzKUVFWfz2ysc3EEE0ckE4GfXD6vqzC6UcsDQdTVvDuSXrf62QjQaA1j/LfhJ84jjRqg9HmvkbNhqCl5K7t/H41OzqTFW79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs/Ab6Ci; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs/Ab6Ci"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91a931f66so13934745ad.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789416839; x=1790021639; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IZa85Daqk9WlH3yEyJ5xW+nE0nV4JL1Bsd6TKEV5U/c=;
        b=Cs/Ab6Cicq2dBTcCEnTwsoCcxM/rlbapytKqtsZ+Ke5+JxtUem+z++VY3e/bJL7y6w
         4tWT4VA46GJlqVBs78Bg8AtezQZtuCP1CW9BkVRjTAMc0nns/18hlHjNca0fWHL6xMqd
         4qBc7cYFS7ebWISHFkT4bc450TspNPQ53JZxjDd7UKtFfEAlCXdH566K7pUnDHbkrSzZ
         lK2+0fViEng4czADICKlo9eOTr1hFxDw1Jzkf8rS3xMVXS3KHWM7YsP1+XV/ZyuO/1Rx
         rW4GedAv3qrT7+Irw6xBTn4A6GnoCGj+cbzf8gkCV/nPDjLRglr5RxqXIfJTZydIuRPn
         vKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789416839; x=1790021639;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZa85Daqk9WlH3yEyJ5xW+nE0nV4JL1Bsd6TKEV5U/c=;
        b=cIK/QekI7skEFY+6Ldl2tOUr2+RSbLUpfmSDVyw7HJ76T5lOxtEJRdxbMVG89E3aqL
         sfRNPNk+cZdYLZ4iUAexLM3stKWY5km2FASiU+XGMrk6hatEbY91UiKQH1IZwxHUlciM
         8qzhBOhHOF3o5NaLAd0Uvg0WdIZAIJ24/q+awtCnAbSjFw4EUDG6yGIP3knUnBDdY14C
         MskL9dIIb22jNNb4rNTCcpvlmVsnySuh+aiR7Q7bcdO3pJMDEVSEqlqfwb2TMmtuWqgZ
         ZcCGcca1AS+yxwzIu68qnRLjt3ljXDmK0xDezt///nm7YGbGinJwjQWwaJcJNG96/89o
         i+UQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbpy+UexilfyLqB7NpLeuOL2Bddz4FT7s1aSbNPYNPRBxNPTFarAMS8HFAnVOyusza+RA=@vger.kernel.org
X-Gm-Message-State: AFuF++kfiqUIH5EXYI7DFUrtPdEa8mpRPs1/SyMx7UfMaERs56fq5a+j
	j1ZMuvsNNtpFOmYCQbS/SWfx95Qz8i6nKUXYr8ln8xyJkiFnwV87V9Vr
X-Gm-Gg: AYBFou2GTndhN+p1/0h6jWNQVMKVbEgqkTjEuX4X4mJwTG+DXYEBcTTc5i4zYuPkCDe
	dIUS3zD+d5QTJXfVg71l1neAcPphOCSnb9yClaYO+pKTIq8dxsjPogrfLC9DFThQIlNoxHtJXaW
	Ko9Ei0p4pgXHhN9znf05VL03H3SxhPj9QYLKAJdyN/hV5VcCaQmzX9gDH1LPQ/tXEoGLcdm8LEK
	Sd4+9GS7BDTbGZQa9W8hjIFCBl/1C2Z1wh+2fvcFAxxkM/2jGXiSex+ZGPwPOy1CdcrzeQUbCj3
	qDLZycF6v+6mODG7ZpBm5Eaq9hpLupJR98cGIOUi9yeaLDqqVzCs15JGZHRri5Kb51hHCSL8WtU
	2biCavImvv/KD+914Bhuvxj7WBSos5XCKkImcTY2zR7Irigu83eto20J9Y2vQ/MjjEVveHv+uYY
	vo6uzbApl59Bfud+pLWRobYMEu4haW1qA2jokxtCthAiQkImBNbzmBWkFPJ7xoZ9hSdgIt3Ksor
	5JMgpFE+1By/jBbFQe/P8F5AMI=
X-Received: by 2002:a17:903:19e8:b0:2d9:32ee:7b83 with SMTP id d9443c01a7336-2dd6c5f4ed7mr82850285ad.8.1789416839419;
        Mon, 14 Sep 2026 13:13:59 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd76479fa1sm3085795ad.46.2026.09.14.13.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:13:58 -0700 (PDT)
Message-ID: <430c4b68e4508f61d8d4651feeb268ef7e3d5afe.camel@gmail.com>
Subject: Re: [PATCH bpf v3 4/7] bpf: Restrict CO-RE poisoning to relocatable
 instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, memxor@gmail.com, bpf@vger.kernel.org
Cc: npc@anthropic.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com, martin.lau@kernel.org, 	yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 13:13:55 -0700
In-Reply-To: <e5f571dcc350b1f28f4058988abe4a0b8d90efc1eeb6e83100f34a21953cbdfa@mail.kernel.org>
References: <20260914131701.2529725-5-memxor@gmail.com>
	 <e5f571dcc350b1f28f4058988abe4a0b8d90efc1eeb6e83100f34a21953cbdfa@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 14:15 +0000, bot+bpf-ci@kernel.org wrote:

...

> > @@ -1066,6 +1055,8 @@ int bpf_core_patch_insn(const char *prog_name, st=
ruct bpf_insn *insn,
> > =C2=A0	case BPF_ALU64:
> > =C2=A0		if (BPF_SRC(insn->code) !=3D BPF_K)
> > =C2=A0			return -EINVAL;
> > +		if (res->poison)
> > +			goto poison;
>=20
> Moving the poison handling after the class/operand-form checks makes the
> silent return -EINVAL reachable for unresolved relocations. Would adding =
a
> pr_warn() on this path help with debugging?
>=20
> Before this change, relocations with res->poison set jumped to the poison
> label at the top of the function and always returned 0 without reaching
> the BPF_SRC check. Now an unresolved relocation targeting a register-sour=
ce
> ALU or ALU64 instruction (BPF_MOV32_REG, BPF_MOV64_REG, or
> BPF_ALU|BPF_END|BPF_TO_BE which encodes BPF_SRC =3D=3D BPF_X) fails progr=
am
> load with -EINVAL and nothing in the verifier or libbpf log explaining wh=
y.

Ok, this might be a legit nit.
Add a goto default switch branch instead of `return -EINVAL;`
in the BPF_ALU64 case?

...
