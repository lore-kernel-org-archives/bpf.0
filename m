Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E6285CA4
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775929233; cv=pass; b=u7Mu+YTZBkZUdKoyTUQ0OkIL4F8UtdwhlPV+/4VObgghr7Ce+BeOVYJVz4Ww1OjNniJI5L/c8jOjDn1sw2vCxy9cHQxWNMHL+ys+K8fYJwjwOt5sc+oEZ4goOJvRe1azkoMCf33hbrChGezzfusrb+m8owoxbQJ6pGBjiPhTkEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775929233; c=relaxed/simple;
	bh=Tw/u5oUZtot/hTNDcsveB9ekvgdwkxo8ZCcekiGgSYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bjwpk4PAK24jQxptqwHfnGfzvq5MIBVVmK95vhJDb9XmOc7hCVH/kNlR2/+JHc2kjXfO72pWz3VOQKbr0e6I/Eg6zpULZXPddTIG/k17lPn2TLdjfWJ6rsb7YvLvK3PLqbiCHPdr7t6/BOhlccTPKeANF+rSSsZkXvShjSbKpdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0Dvz0Pa; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0Dvz0Pa"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso46665415e9.3
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 10:40:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775929230; cv=none;
        d=google.com; s=arc-20240605;
        b=IbJ6JpCVUpNj0mW8JvhPe/ffN0hNessasQv9Xis/V5a6p4SF0vmgBf6TR0jVUsMXFq
         uOwD33k+kqa8vq/WkBO7GG1DMMBNLNisE6SFiTkY4JoDdZsbKSdH5ibCKDrS5rofkbre
         pWJLJQ+idQHzYonCdQsVzPh5FtQCHF/C+/7EdE9AdfWMptCBEzQbVK67mfWmoGpmq16t
         w3lCMdUWc+4Z/D+pQDM6dz6yFf8aRzpLIfBJ9es2hfAYsVWmeiCQwTfd/PUj0MTPPmr7
         I6Ha8EOg6byNTaXYd3DFKPG7Gu3wYwEhKZMQiwmI3xUIuXPpkGW72zUjim4bkwZ9m3HM
         0qUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lqmr4eWyWQ13XcEc+A05muMZUDdgHIlyuz1WByeFfPg=;
        fh=s1Ti3SkLciWk7EfKrMC5VJiTJj3bx161sWV7jb1u8Dg=;
        b=UiiKXtR8Uz7CTUzN842C+vHT0U5Nqidz+dT5SDjlh73fhqJOp9wNJLbUi9k8371ap+
         6fQODjrweNRp+NGW+lRWyp/yqwkMn8CtP+S4wZTFsWH72u+Q+MX+oeJxWhh9ZzbiqE7a
         2Uw5V93XTR0txjDwgNzGLfgX+USx9FCDaTnFpQFfbNDUnhjoJjskFR8RDm/zp8JbQeRg
         RYSLtRZLQhkM/FrIhlKzTiRTyqltDR9lNYaknNwoiXfEYlPqHzT1PSdR4vmwbbTwLw6Y
         vOWYZ8xQ6TJ+nn7LUjlis0tpHkUQWIWebgby3EyJUw3PExmrNR2klderr19Fp76c20Cg
         fzaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775929230; x=1776534030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lqmr4eWyWQ13XcEc+A05muMZUDdgHIlyuz1WByeFfPg=;
        b=Y0Dvz0PaJ1inV7NKLvO8eQ1Yx/fRj2YubhcCai7u/lpHcRzBtBM/X+hbDuCO8FGKBW
         WBE11+w3z0/dd4KrLnT8x3UNq2ah/Grb7Ha+NfKLaiCwFEB7kOH7/6W3NfbpG/d7IMbv
         Nee4w9z/OktoSZ7TK/+S5n24Hm+LGZ3ZhgvDH+JSeKUScs8lHnjCrScQHCgrmYYWJn4f
         349lq1xwlq+VmfIbMeD8C6dcX2oZsrBHEz9RXMA0hUzugnbXfn8AFiU7eU+kbjLCjpyc
         zguri3ayHDM2m/47lb2v0Ur7/7t2ZTGDSFO82t7Rz76wI8adl9CT9kUxwWcYF6mH5KUe
         qPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775929230; x=1776534030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lqmr4eWyWQ13XcEc+A05muMZUDdgHIlyuz1WByeFfPg=;
        b=ZTSPYh77j7KwUKQLkKp47hwFOW1QIgvBYTFcxlq9CFcOELgQfq9jalF3LUGuWEtLEc
         9TWNPKq3axvyy7loF3e9Y8pQ5ibayMGlEUw8y5a2+/HsozGtukNwo8mjZu+z3dLPgvjn
         JGQLLBg8KitEmxYmFxqwYxd0u9DyApv/k2puY2d5D8GOrCaZ3yhW++Vkje5nOy29ppab
         xDKjiLorLLy7dqqQfRwS1jsSW9obvFKa4oPTScTzu0nVRHiqTb9QoW06srgQmKiVxNGI
         ZXLS5x1nQbCsIyEVPJIdj3HAu5LBSgKzsHxlfcMXShypasShH2N4vA4ibUjMRcHAKiQk
         PSnA==
X-Forwarded-Encrypted: i=1; AJvYcCULT3aUKaKMGanuLqNH31NtrfX5zjGXo7RwRNfPQh5nkmyuj94uq62w2aQpVKdYJFPhp9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv3KfcnyBoSG9iPSmw2sbCRlH204II5vwM51TaAImOakpSYkzI
	jDfizev7Yy4y4NSHX/RCTLlq8/Ttg2WA3XSlc4u03y1r6gMeriv7e9/+9rmA8qL79zvB3dXHmPP
	ete2xzpudQKIaGgQ9z5/WrmELshYn4yc=
X-Gm-Gg: AeBDiesr02pUJm23yTuEaYL8kRExFhp239+yXpBpAnIEYGHN+z0nwIJkR6Pvf0IvdNt
	80Tj95X5EJ4BmbIpn6lD4+VdwiEZJc0o6JcC7PxJdGrDhxq13AoLQm3Y7aMveXyVLGwpfjr6GLJ
	zrMK7z5zBniOdzCUV8m1McwDdjEVcTBZlaRTb0GJnnLtI9869vH1p5FjMwojcp+53koXiG0kIiD
	znxnReDbLsChVf62viUE8Br5JrVNsJKv4NS2vysBoPiLL1kE3CvOF4AkddCb4LUpNlf1v7ZKlkq
	I+9PlmDyjVhaBasRR5qbenxUiUMibeLgcHveq1MGGpg8+ePd4qC6+/8JI8o/NQoXR4Ox86iMOTd
	kcqWOLpmHgNmMwfdaPYYD3AcaDA==
X-Received: by 2002:a05:6000:2dc1:b0:43c:f8a7:3b09 with SMTP id
 ffacd0b85a97d-43d642da703mr11188838f8f.23.1775929230153; Sat, 11 Apr 2026
 10:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQKXio6nh+3OLkJb3C5FyGS404ZAQEPpwxVD6Bsr444ahQ@mail.gmail.com>
 <20260406203950.2669356-1-jmeng@fb.com>
In-Reply-To: <20260406203950.2669356-1-jmeng@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 11 Apr 2026 10:40:18 -0700
X-Gm-Features: AQROBzCN9U9z9SJ-cvZBbCW8wwhj55-MxFdr7ypSG25E1nnwyX4EtfAXs6Kv330
Message-ID: <CAADnVQLH09DxPWF5f8+sx4XTN=7NqehRUGieDPoAkDz5HXdkGg@mail.gmail.com>
Subject: Re: [PATCH v2] bpf/tests: Exhaustive test coverage for signed
 division and modulo
To: Jie Meng <jmeng@fb.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 1:40=E2=80=AFPM Jie Meng <jmeng@fb.com> wrote:
>
>
>  /* ALU result computation used in tests */
> -static bool __bpf_alu_result(u64 *res, u64 v1, u64 v2, u8 op)
> +enum { F_ALU32 =3D 1, F_SIGNED =3D 2 };
> +
> +static bool __bpf_alu_result(u64 *res, u64 v1, u64 v2, u8 op, bool is_si=
gned)

why? Use u32 flags here too and avoid..

>
> -       __bpf_alu_result(&res, dst, imm, op);
> +       if ((flags & F_ALU32) && (flags & F_SIGNED))
> +               __bpf_alu_result(&res, (u64)(s32)dst, (u64)(s32)imm, op, =
true);
> +       else if (flags & F_ALU32)
> +               __bpf_alu_result(&res, (u32)dst, (u32)imm, op, false);
> +       else
> +               __bpf_alu_result(&res, dst, imm, op, flags & F_SIGNED);

this convolution.
It will be just single line
__bpf_alu_result(&res, dst, imm, op, flags);

pw-bot: cr
