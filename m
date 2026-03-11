Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE04E140E5F
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190634; cv=none; b=SQ4vVx4wQIrNp6bcg9yaEmLWZGfvUabu6ixslcEAlaFrCOa5oTqMpPZsB2iHZUPIYehxu5c+CHPw1oAyycS2r2+sf/41K6DmKALku3sM6AqYaw1tQIvwO/b6ESsZBZqbtadMv1M8iT3A/QyVmagTlaBRTH1irjCYWOzJfTitwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190634; c=relaxed/simple;
	bh=yxTYOJXlDitPRAx4pudUadtKagYoy6RXPAGAZrNBfCk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/nCS1eBaRsEAajzLohQD99Uopr7pfyQngQu8p2Dlora4MLUHJjKiWkFKbONBL0DFu950EYXJC/SZFi8jYrV3NTi4vOtlACtVQUQeHRoHz6G5Qroh3VxX0LNm5DtwcQZUGxOL2y9srgh8ljHLpodF5w1+KPDEK/MG1v6z5Qw9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAoHC7Kz; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAoHC7Kz"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2be1ab1fa7dso389411eec.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 17:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773190632; x=1773795432; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pUiaJrVf7BIxdJm9GQ4cSAcCoBbThRTHXbU8BNyPpHk=;
        b=dAoHC7Kzx9W1SmLxhP3Ggwgc7nfZuvCX2yn+PEV8zEMTE7PHj1yW0s6i1VEgXlSvpP
         Hdpn5qNcSaL0b5/CVeu8UCYwfZPWiEh8vxuOIeKjMtyDtV9wBvSxyWU7TzMXEx0wKW05
         1yNs33b0wMORE3xzL6ThcIiKu4E55TcacpYbFjqblmkmh+kjtVg+y7gt80Rfsi0G9/ZN
         kCjU2Pkb3KzjmH8CkvHf1JjhyGPO8aE5gttlJkPUZy6XZ+Q0HR2mfnMnPumZzMoOF3Wl
         TdJeqCGGB3z3Umn9B1XdIKv0IuLIfryn0LjFFsHW+hvk004ZTTAMtXbV8gySZ8wAnGM3
         ytyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773190632; x=1773795432;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUiaJrVf7BIxdJm9GQ4cSAcCoBbThRTHXbU8BNyPpHk=;
        b=kZ4H4ZjsT6eYE9qnSjzpCVNgcXX9Nc/xE08QjfAWW8SK+zhLJY+lHYkpo7zoHOwD/z
         g2a3rGO3erHNbBS5Rlg2Vv+OenBYop3tR5hx/uffr3GRJ8xg+y1tDSHprxjEZdVVAPWV
         r8xk0VY3eLpeVrq0ls2sdvAH2m7lL1NGEH2pFIlPbxbZvdn4dajkpPFojpd63nMb8I6+
         dSfaibzvhIA4X/S7vJLdjHYqXvD5j/y/ML+SfO3SUKZOMJ8LhL9tkes4QQCqQmD5G+LX
         uwlZuhykCM11kMVGE1A/n36uX/8sEySXMtbEq2K56kzxTdzb6lDMU3QKK2h+O8I6cNdh
         b/mg==
X-Forwarded-Encrypted: i=1; AJvYcCW4/wM7YlIw3FSkKTEZDzKbOAT7OcpHh9qdTvIxgaWgmwCKzSkmOgxwbu9+Icz004mj9Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YygXBTFaYhGuSFsnlkQZzn7z1U2RswBsljb5Ovj7UafdUHW65zp
	GM65XMe3deqhSmg3ze2zrEw0JidAsrlKj1UbY3cAThrrZXHRGzVqIXAx7Sym6dcf
X-Gm-Gg: ATEYQzwujpFcJ2fsVfr0Do9HPyAvsr/5TkiHKyxnHP0Q4Y2o9jC7OUw9eP0vh03arSx
	jfFg0FQ9ip5eLG0kYeUXb8ixOeaU1+fR58zSg9Gv9Nq2YhB8ohRvzFyhu96yDHZQKza9C/8x+dj
	N6ehnykw7TsEI8w3p9U0n3QDss4cQvWsbYvKpfHskw/jBpzbbGixShJxg/Nyan5nrS4IJ5rJrOO
	tRbRWDHTJUbkVM/sBC62e62HvNlmj2fI9mmTADRQ+MQv7bP0SKhB/jmb5D1xmSNrfUf0Lp9E7sT
	Wz37CI+iEu6INoooJImeliVi1CoHqjCNXSnFfoAMzpro751mrjSGulqeKAATq4X5E3uvn1uOeqY
	iX03WjQ1PS/lQ1YX+11tbtNLO4jiyCznyOdeC2WtoboX1EsPtFDBU5RjzK/GFTmJHAlzPe15/fn
	OxRhAp3KbjVNRGwvnM5mZQn2DICuuzk/iHhs7kZ52Hk53c4iwtlFuNs5rBXHTJ6Opxr5Jw91ywi
	Z6vyIe8
X-Received: by 2002:a05:7300:5726:b0:2b7:fdb6:ccf2 with SMTP id 5a478bee46e88-2be8a23db9emr340989eec.13.1773190631824;
        Tue, 10 Mar 2026 17:57:11 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9dd5:5c94:8add:da1f? ([2620:10d:c090:500::1:641b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa4ff66sm569223eec.19.2026.03.10.17.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:57:11 -0700 (PDT)
Message-ID: <186af6aa5189782f9975d6572751f0099bd167db.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix unsound scalar forking in
 maybe_fork_scalars() for BPF_OR
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Wade <danjwade95@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net
Date: Tue, 10 Mar 2026 17:57:10 -0700
In-Reply-To: <20260310133504.94871-2-danjwade95@gmail.com>
References: <20260310133504.94871-1-danjwade95@gmail.com>
	 <20260310133504.94871-2-danjwade95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-11 at 00:35 +1100, Daniel Wade wrote:
> maybe_fork_scalars() is called for both BPF_AND and BPF_OR when the
> source operand is a constant.  When dst has signed range [-1, 0], it
> forks the verifier state, setting the pushed path dst to 0 and the
> current path dst to -1.
>=20
> For BPF_AND this is correct: 0 & K =3D=3D 0.
> For BPF_OR this is wrong:    0 | K =3D=3D K, not 0.
>=20
> The pushed path therefore tracks dst as 0 when the runtime value is K,
> producing an exploitable verifier/runtime divergence that allows
> out-of-bounds map access.
>=20
> Fix this by passing the opcode into maybe_fork_scalars() so it can set
> the correct value for the pushed state:
>   - BPF_AND: pushed dst =3D 0         (unchanged)
>   - BPF_OR:  pushed dst =3D insn->imm (the constant K)
>=20
> The bug was introduced by commit bffacdb80b93 ("bpf: Recognize special
> arithmetic shift in the verifier").
>=20
> Fixes: bffacdb80b93 ("bpf: Recognize special arithmetic shift in the veri=
fier")
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>
> ---

Uh-oh, what a bug... Thank you for spotting this.
Let's, maybe, go for a smaller fix:

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15999,7 +15999,7 @@ static int maybe_fork_scalars(struct bpf_verifier_e=
nv *env, struct bpf_insn *ins
        else
                return 0;
=20
-       branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, false)=
;
+       branch =3D push_stack(env, env->insn_idx, env->insn_idx, false);
        if (IS_ERR(branch))
                return PTR_ERR(branch);

Just to keep maybe_fork_scalars() more generic for potential future uses?

[...]
