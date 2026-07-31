Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936836A34F
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496323; cv=pass; b=GETwdM+97qfYiaGhC68s359ybByKaGMdBRs0Ce7Yg2mklM9j0CQjnyRWllyuqbnNb00ustD9imLHTBlO7JyojK0KAfATWDw9Fc2Txk1ohAEE8pL10et+I9NH+IoX/zW40whcweFOCVOUnsZZ6kZBtNXyElzy7DgyDyBtsekJwkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496323; c=relaxed/simple;
	bh=GaDzXFtfihQ/z5HATF8t67Y3zZbev/3uNuuYK2MsaUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ookg06fNknL4KoBVE91XIwVtVdJTMM1lZDrMU+eCFExmRPje1Ur/hAFnz7IUhWVM6L8j8UT7d9U+4b+A53DcEKMIyEimMmqPYvk2iMslxOgxoh/DP5fxNmlx1ucJf29Gs/wmbxwcdmiUBBkS74b2Fd1Z75KIyJqH7kztA96kZBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=none smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b=LzI354A9; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b="LzI354A9"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-73720e58dafso397225137.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 04:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785496321; cv=none;
        d=google.com; s=arc-20260327;
        b=GGhSDdLJjElsIn3W1OjhC4MU7GMr4rYlJQoC9RYFaYrS0RqXf7IIq/k2q87LNj49+1
         f2dpRB+GM0wkFZHnG8k3nGssZjNWV5smQ28JmdoDJN9Me/X7KGYlHvshit6dQY8s8hOz
         itMdHlwIOuo1Aoii9NZJsH4eF2S2/opb1WbJe8hx78atRuT+ai4knEL/RNXgcUGzrNlO
         Sioj1l571tq4Gi41ocjQH7ZrUKu1xLbJWVDU/eyi46wgnRQpe48WobX0ZMRC2f3wR8yP
         oz20Ry8MzgSimI1aDRR+hLjRmpDt1+hcmoTQdoRZ8cd3I9ZpxFAiI5a1AQTpsOaN2var
         3ERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ej9GV30+BCqZMeRlC3tn+HUH0chPghFY3P2/QiZciOA=;
        fh=zItVDO6YSWOvBiDv8qRTc2wlRGtmp8UHlRMwZhRaXZ4=;
        b=QjW5Bt+5vSu5XA+mtl7zLntzRAc/K+8fDNBUfwiRsvLPReXXBJuVcbM5oz5JhKQayK
         Y6hSqr5q0SrIpQ2eOHpCRxh7x6zudPgcW8FgmjsmRY3PU+fRnPLdmHe1ZWRxqWNjH7jH
         agKF0uNWrCG/z4SjIZ/HNXxyqN7RfcfE7d4/oCOvitFt8KVMfhFKhBFmELjqPLW+3aI3
         Y8a4CLz1tz1MsZYy0Qlw+6vQ8I0jxIaL42eA5DaFvyGuEp3LbFW3kq2ORdVec0mTfRnd
         p2Cjp3wJ9pm/C71in3cqDr+XCbkt2V5S6gLwqP9LwEiXDqdvs9zRaEiasWElJaeuKmTn
         bDOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20251104.gappssmtp.com; s=20251104; t=1785496321; x=1786101121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ej9GV30+BCqZMeRlC3tn+HUH0chPghFY3P2/QiZciOA=;
        b=LzI354A9GhQyR2BYAKtnZcFbAXdvQRUnQCMm6Wq7wUki5HtFKFyMRLR3C1wnBuCzId
         a4H1/pNnSzQyCd8TtHxobQXsEMDhGF9d4DiCpUAiIoB1P+Yc+bSF9AWNIpSpwG8RYKIP
         jnsvHzq3lB2BSmo/Kq6m1YbO69j5mudUMv0R7erRjvgDksgOVH3G7D9uaVlPILY+kbBh
         IOYZ0MzFqYbl2yCA6uJiyU7maYBCX6UXC2zuCC4UDy6DbMuXDG1e9vEoH+KzvSIktMfG
         m1ds6Yi3wWJDdZ/Qj/yMrw9oMwsjz+BwcXGr8boHgNkdzwtl17itFG4mmaN8+6JnKBp3
         x/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785496321; x=1786101121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ej9GV30+BCqZMeRlC3tn+HUH0chPghFY3P2/QiZciOA=;
        b=YzO/9+gKBL0xnqsf+snybNvBbmrB2KmgPWVW8fe/uZlwEWy6U1nKrdBGrDnBjn7oFE
         PpyVYcfwMSz0ONp/jZnWtP2QCHpDJ725y2bsnAReNsVJbc9b+WEDQGZJwQACFjGA6cdk
         fS8YoEleMH86Y5Wes34FF1iINsfp44xZo0OFSfnATM67i3y+PBc4FwARqRn0cd/Ny4xs
         daqkCbmRbbGgX8kuoCU4qJ7wuYgUTg+3nCPH+dTs1KPHOXEWg71lV1CWW774vXxmZynC
         XPgS1KSjM8pV8iUuZ0MSqoXvK0DgX2yWKNXOc173vXRBEmXAc7G3KLoxmKYqQBi5WcjP
         PLwA==
X-Forwarded-Encrypted: i=1; AHgh+RqV4+8HaOmFWO4/3+NK76eNleUp74scTRy6I4ZAIFljAsYwB5KkrIIhV3yBKa647Xuffkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4W7dDLMMxHiszxQ+73lMkx7ubIYsftaSK0JXbW36yX2XCMI/G
	RbGu1ALdJFkMzsnmconC8CKV0JKoFyxNk7jK8c+XYAeoFvT04KeI5HhKExRdbN1VAa6ogq2PEd2
	akMuQS/oxkFhtvmyMgdEFedyX1BozdSliSgQf0zYvvA==
X-Gm-Gg: AR+sD10hJa25VlPcrRom6bdzsy7DsBX8TLfUusCPudb52bJR7l1Ck3r4Dy42c+r1EgG
	VN9yDIvxgQUpAwOaXtwKQZkWsEjF+bAfKNjCxPz5RSDrJ7l2hwdNNtGyk9tl6SGnS4QP5AQldr5
	QOjoqkIp8KOY061hTCUCNOvSArCjkMAUCm99oUMyobOxMDTFo0wyk8n2QrZRkZ4ceFD9CfelCjC
	Jf2OEDANC3gdFlltYrUtpcg4tHvUruny4xQiRLDTPKn2VVmq2ebbACZOhZ/eUQAnmY+i/PHtjMA
	mfDOAC834DWBceqkEkNElWWFjeg7g5679JZZ093YAg97
X-Received: by 2002:a05:6102:3ed0:b0:739:a2d:9621 with SMTP id
 ada2fe7eead31-758fd904565mr729008137.13.1785496320808; Fri, 31 Jul 2026
 04:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729162931.2369353-1-main.kalliope@gmail.com> <20260729162931.2369353-3-main.kalliope@gmail.com>
In-Reply-To: <20260729162931.2369353-3-main.kalliope@gmail.com>
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date: Fri, 31 Jul 2026 13:11:48 +0200
X-Gm-Features: AUfX_mxGN1QiilF-Xg5FxW-6pbW5ca66fBUh4YARL74VZrPibHZ8mVvz9mZTewE
Message-ID: <CAM1=_QS79dDBfaaNQXnWd61AqHd1M4o9aDMMiftnoJveNr=FZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf, mips: Add support for BPF_SDIV and BPF_SMOD
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, tsbogend@alpha.franken.de, paulburton@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	philmd@oss.qualcomm.com, visitorckw@gmail.com, bpf@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 6:30=E2=80=AFPM Nicholas Dudar <main.kalliope@gmail=
.com> wrote:
>
> The MIPS JITs handle BPF_DIV and BPF_MOD without inspecting
> insn->off, which distinguishes BPF_SDIV and BPF_SMOD. Signed
> operations therefore use unsigned instructions, or unsigned helpers
> for ALU64 on 32-bit MIPS, and produce unsigned results for negative
> operands.

Thanks for the patch! In addition to your SDIV/SMOD fixes, I would
like to bring the MIPS JIT to full v4 compliance. All the tests in
test_bpf should be jit'ed and pass. Let me know if you are already
working on the remaining v4 support, otherwise I could look into it.

> arch/mips/include/asm/uasm.h   |  6 ++++
> arch/mips/mm/uasm-mips.c       | 10 ++++++
> arch/mips/mm/uasm.c            | 20 ++++++++----

Consider making the uasm additions a separate patch. It would be more clear=
 IMO.

> +static s64 jit_smod64(s64 a, s64 b)
> +{
> +       u64 quot =3D div64_s64(a, b);
> +
> +       return a - quot * b;

Should not "quot" be s64? It would be more clear to not rely on
implicit signed/unsigned promotions.

> @@ -650,6 +665,7 @@ int build_insn(const struct bpf_insn *insn, struct ji=
t_context *ctx)
>         u8 code =3D insn->code;
>         s16 off =3D insn->off;
>         s32 imm =3D insn->imm;
> +       bool is_signed =3D off =3D=3D 1;

The interpretation of the offset field is opcode-specific. The
SDIV/SMOD instructions are encoded as DIV/MOD with off =3D 1. MOVSX
instead use off to encode the width of the load.

Please propagate the raw offset value and do the interpretation in the
div/mod helpers instead. This also makes it easier to add the
remaining v4 instructions later.

Thanks,
Johan
