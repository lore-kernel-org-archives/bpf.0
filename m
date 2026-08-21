Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C78383C6B
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334797; cv=none; b=HHAEmGTNjMFhKvAVJAY6l8L+sZo1t8HwzhpnhWW4pqDfwMaVFLZ7cfbAB7Ip/zvJPjEU6fhLy0UnG2ps1e4mp+dEbEfrdHNFxXO0GozIuTDFa7tLU5NMBZwFY42zcms/YsLz1dNaVsp5yfADe2UjjEFaHkbFPIgh07s2jRaxx/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334797; c=relaxed/simple;
	bh=rr1EVL+4iiksKyR165CGqWE5TxhSTv7lkS+ul8ltQUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tz9tcL8a0ZxYQzse2n/W1pIG5CxOJMTAyvPPOvaYmz/tbqMNoobAN7VpyyGn+7DqjDBYPZCiw+E40ABeBxLD3A9U2BfIRQrTzMy/z/cama+9gbc2xuo1AP6D7KJ83aAXrRouCyTVL2bYly4WBZmfq1SBrWdI7EUCHGDRPKXTtD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1xROrsx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1xROrsx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso16858055ad.2
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787334795; x=1787939595; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=x5X2EWJjIO+3uU6HNhskU6QdvAMpHnR+u9hjOMlkEYo=;
        b=V1xROrsx4VG5oSSqzk4wrn9/jfqg0G6yYIxNyuVC9MeIUOuoiAvhbOBH198817pArO
         c9XugsyE32pMCE6NPqN/6JkqwHlnsVEYMJPs8e7m8J70C7OCFdq8i5DEXEo7Hb5Zj3IB
         bPyYHKNhZM3WMePvewdzfGCkFncFVe1thcjGhXqK7OPgL8SkU/6Y7RqBdpAv30R8skqD
         90FZfB9A38uZpt72iuv4JkF7dBrMjPWxqHI/Zu3hdzqztxx/Orxet1/7wamQlDIM7BnY
         KWPUV0lNhwNTklFprLQdI7YOtiH/E/rMXfIR+yDtA56W9n/Oh15IuiOjN7JDOFf+QJoa
         ZoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787334795; x=1787939595;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x5X2EWJjIO+3uU6HNhskU6QdvAMpHnR+u9hjOMlkEYo=;
        b=n76QTsZxaqfH5MIOsq2qieZZRG7r9KC/K1MlzH5OH96HZnWnhSqlwdjL+3UjnG2/tw
         jVQHlFyF4DNRPA6wI020MToG78JCxhklbjSp1V1lvD7G8Nj+S/HANCldd79mk0aO8kMW
         tYtYee0SJAI9cIl7+9C2DMQdln2oQKgvT4x6+19ClHtSUqJMHIDX0fv6WKSvW5mQzYDU
         G3gkISia5xgt5JbRmyAfrdF2jygYrwCmFfaRTYQkb1ydafjEyrwL6WCanEW+JXg5rltX
         Q9E3j+hI7xtJEq/UtkOzbXN2Oyo40QBNlFm2GpDWO2i8ydWlJq2ElVuiJ5W9BkU8SiUm
         U4oA==
X-Gm-Message-State: AFuF++kCD/YwFrcHrLPhJYRNb5gEFYFNEMgiceeUUyQrkfqKtni5lfI6
	Vpk81gHXlRDm2BAQ7jliRtXEpvqmBaBr2XdLPsnPjdQ2U8/Wqkg3Iugf8JmfVXvrcAs=
X-Gm-Gg: AR+sD13fnfTnp/2GkQevzJ6/uucA/YFVpyuCDqxUObEgX/mCgktKfedDPW+zhmIuAXe
	eh9OosVgzjrx1lPMqH5oo6Psor6dpUVBsGPvmAvuFx3qROSMcOSxUn9pNL9lO8cLAXaOFpGAwon
	G8V7LoqEj4rup5L/W5Bi0qYNTeWxdiDHjlJY+uHmBrBC4txgeRfOlfp6pZCvdW31Gn8s8dTDRij
	eFThzmMrweGuNWvkbt0865TQXBveQaS4hQGX3hZl0R/O1U7UbxYmFPjANml9wycm8jQ86srWkDu
	p97G9/uluxIIGhKjrc5SSs3uMXMpW3ul1Yn5xP759s/Ggs/1p97HYFWYe1RTypsgnelNy1Pn8qj
	T35v5RySma4h8iyOmG8lnK0spNZM1OZud/YlXExWskLYH6KSJXthZqj7JCAhKPi5vHfBzpCPHvw
	DiCvnjZFCRuHpGYE1r5dfh8fUws6GX51ByNDHNQqpQOwii6hayCt02VSptYBZqAT6P/1en4e+yN
	l6bN5F68sxNmlze
X-Received: by 2002:a17:90b:2c87:b0:392:7f74:58c9 with SMTP id 98e67ed59e1d1-395c3a43766mr16440843a91.15.1787334794978;
        Fri, 21 Aug 2026 10:53:14 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4be47d7sm3987378a91.9.2026.08.21.10.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 10:53:14 -0700 (PDT)
Message-ID: <27b3997d5c1920db32650c554398feebeea6f0db.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 02/10] bpf: Add helpers to describe the
 R0:R2 return register pair
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Fri, 21 Aug 2026 10:53:11 -0700
In-Reply-To: <b6fbcaf1-295f-43de-a794-7fb546fd4785@linux.dev>
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
	 <20260819055249.3295283-1-yonghong.song@linux.dev>
	 <20260819061746.0DFE71F00A3A@smtp.kernel.org>
	 <b6fbcaf1-295f-43de-a794-7fb546fd4785@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-19 at 08:50 -0700, Yonghong Song wrote:

...

> > > +static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env=
)
> > > +{
> > > +	const struct btf *btf =3D env->prog->aux->btf;
> > > +	const struct btf_type *type;
> > > +	int subprog;
> > > +	u32 size;
> > > +
> > > +	if (!env->prog->jit_requested || bpf_prog_is_offloaded(env->prog->a=
ux))
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * Skip the main program: its return value is the program's exit co=
de,
> > > +	 * read out of R0, so it never uses the register pair. An extension=
 does
> > > +	 * have a real prototype for subprog 0, but bpf_check_attach_target=
()
> > > +	 * refuses to replace a function returning more than 8 bytes.
> > > +	 */
> > > +	for (subprog =3D 1; subprog < env->subprog_cnt; subprog++) {
> > [Severity: High]
> > Does this code mishandle extension programs (BPF_PROG_TYPE_EXT)?
> >=20
> > The comment mentions that bpf_check_attach_target() refuses to replace =
a
> > function returning more than 8 bytes. However, for extension programs,
> > prog->expected_attach_type is 0, so attach_uses_trampoline_retval(0) ev=
aluates
> > to false, bypassing the size check.
> >=20
> > If an extension program successfully attaches and replaces a subprogram
> > returning an __int128 (16 bytes), skipping subprog 0 here means ret_reg=
_pair
> > won't be set. Could this result in the verifier failing to enforce the
> > initialization of R2, potentially leaking uninitialized register conten=
ts to
> > the caller?
>=20
> But the comment needs update for this version.
> =C2=A0=C2=A0=C2=A0 bpf_check_attach_target() -> btf_check_func_type_match=
()

Fixed while applying.
