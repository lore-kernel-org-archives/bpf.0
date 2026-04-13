Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE70393DDA
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776112715; cv=pass; b=e/I4h7uANGvBiOItQG0U5KoYj+6TSa78wOMylYhKYizj2RU+OJnvX3k4oJKl5AUSKF3YQGsd18rbJK/Ysf91Qi/eaWWiq3hsEF0hxXv3+uI0tkCtpAx4iMfnSsNfJXuGv47dQXkoZECHoY5C1zhTanTWWGbHFFmPMq+mTQUo1Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776112715; c=relaxed/simple;
	bh=8n4kLiVKyCVRhAMq/pk899LlPHVAZpxQc5CaVXu0iCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiMIygJvQCoOHWcTHhoihgqwuIdIf0G9tk91PkdlsQCNcx9/lhwQ581dE2qxStXltGFGAWUZiJh5AQ+UFKF8M92A/HnVFxrXwwrv7A0pzHRwC2pzOABo0CI6Za+uPTczjtgxeiwYv8uso3P7xSBFJdCxyY5Rq7OcO2RBZvVivk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGQafk0E; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGQafk0E"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d7650202fso1239535f8f.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 13:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776112712; cv=none;
        d=google.com; s=arc-20240605;
        b=F0i22Qq2VAK/JQVBPABP0ZacBulKbBRsJSsCPP36A/eLQvgWr/XqsE5GNd3WnDnLsu
         yu192MxIbwmMYY0icOPKXCacPsANTb9qQazv9v378sxFcqxOOgCYVd58wDeGBRLQjqGL
         C8j2pPZJGfDrfPfRsfnNEUAzqkC9JnyjXPnORkOsYR5qDbRfa7xmFo+ibBvvdnWNtnxU
         MGYr4+7zNw434nIt/oDnTK1Z8d+J4Pg2FRRkswKfhrHoZAsDmMGx09EXGYA0psPaxWnk
         HL7k5Y5p74ZAuTRN+M9lME2om5P+Os9ayT778W4Pphi9YNn47WTN+M4b5uSU9v5DQ0dX
         7Nng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XxZXIVSkn3sA6NKTNq/i763qS6ugJlc9AyzlSqlaQmg=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=axgNYx28xyEijKJI3/eOu3NBE6uSNzMxLI46tIgFWA14blvYfKugoC7gY4rOwVJnHA
         iwpOduxWKHNal0I1sLf197BYKB2GXk6qOkBaJW/wstlGT6npiHaB8Ax5dTdwSrHjH9yC
         uWAgAsR/b9pnDUg/h0q9f2drtEeNKFnlESnV0d84nIgUntYZyJ6kx7x7M/jT9iQWo2yk
         5oY5mLhGvvaQfaPHmxRV/PGKWLXUoTnaXT/guZ+elxxVplelW8qNPYkKhjMuVTG50yHn
         3hwcWTyAVc56jDQ5rYrjOnqJvHLWCXUGhpdP9N4vGsfdUCeBPuNuXnmpGDpIeTIi5CpN
         jR/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776112712; x=1776717512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxZXIVSkn3sA6NKTNq/i763qS6ugJlc9AyzlSqlaQmg=;
        b=aGQafk0ExTCXIfxqV1j3lIBAlq8Oe+1OEtyVe5DZQj6GFy8SQQSMUznR3uWKrKU6NR
         IkP9d1IBgqJ21quKfCzzcp4y43h0ULzBFqKU0qjg/wUbYA0ZvybtR4rxZCbhc3SxHsCj
         hQ1ogor4Re7/vaVEaevAkYJ9PvfP3L6pHKNJQE4dTBqw9/ht6oTbfdS7I5NVjMM40j8O
         h+6kIE9agyyT4y/MwCtR8lZbSXzw5sCHloZ8mVjpSEcwK5adfOU1YgDYPNpcU1cubrNV
         u0df62eL1H8DDVsyke2LKpazMC9BAjL83brvr+wgV3TYglo8TkR3NzukqK8G/vyyiJhf
         hZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776112712; x=1776717512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XxZXIVSkn3sA6NKTNq/i763qS6ugJlc9AyzlSqlaQmg=;
        b=Tf4eIQ9sK4tsxTZ/zC16/slOYo6zO5gYc7HeECohBYiRlnp5dvNSZfD6JkZIp/KQCk
         vspQz6zAL1hxH1FT3ywVrrex758ZZySqpML5VM4cLYbK+maK1LaUpgcaXPQ1FBiPA8mx
         ufeFTAOnMiNNoK6rDR19/JbMgzsglznGZ5h4RNsxGFQ8VDnmtwpyppbBSwLIfXLmFulJ
         kyv4YgAifYBGvj+ouWCpq6pdBkq+p67XecMeYfIlA8nzGs+EreHB3mA2MG6V6W2LQYsg
         TglMqMkhCxVGsr0L0IxMOXSCqM5D3KUvzttz3APdl6GgxWt595zVoBMC8Rhs5UHKBkva
         tMRA==
X-Gm-Message-State: AOJu0YyETsQlSeldtbsFI4iS/cQ+j5fHWp0pIFtn9uv1IqmVcc+4qAjz
	LHD2Nryyc2dQljv1U5U03fBwiA+uW0+Qs+JNM0Qb68h9d45XIY8QHZ4iLMuSVOugNZXsKNngpGu
	FjVboCmkK2fHp3/NGFrqkUpiVyFPAwD8=
X-Gm-Gg: AeBDiettIPFYdhDqdbl+r9BKlux85t2aWo2uYIndyEwlvDhEg1kEIyfIWVGiHqdR/s6
	CmwQ9PLIIwpiCWCcQv4GNJDu5v2y2Nz/ocPeIGfsN/0Z1+jHxdINnihlGAs87GFLWn5BQXzpJqa
	lXS+mCPXQFg5UHMjU44Ia/XNRt/dzfOrtQbFIB7rDBzGDm61trJY5qzxp+ir9GUwrHxWlcfrto3
	1MdAwEY9ugGdfqLmBcIpD0iyys25rt48XIAp2maAHpSB22o6yVALdNgHeO/DICcPapBqSTsICKV
	NiuN3D/DHmxvsSCQVnJmvtdGU+seQvEoNfUn1cFAheBtT0gY8CMHZ4bDXKhOSE0T1/PM+cUrk/x
	TULwqsAB9jyxw/lNbgHFnikAm/3rB3e1h4G7T
X-Received: by 2002:adf:e80d:0:b0:43d:69ff:6898 with SMTP id
 ffacd0b85a97d-43d69ff69c4mr11182862f8f.9.1776112712430; Mon, 13 Apr 2026
 13:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412045826.254200-1-yonghong.song@linux.dev>
 <20260412050033.267815-1-yonghong.song@linux.dev> <CAADnVQL462NnYNquWqJL8=CFZr6vJOxVzCPCpijV2MLAx0y67A@mail.gmail.com>
 <281485db-073e-45b6-8929-dad36fea5f87@linux.dev> <CAADnVQ+Xem-VErMn9f2MC52ugofFkA+XcUz4OqgvxJ9wTVz0JQ@mail.gmail.com>
 <8c205cc8-4c59-4c1d-a845-c647b2574d4e@linux.dev>
In-Reply-To: <8c205cc8-4c59-4c1d-a845-c647b2574d4e@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Apr 2026 13:38:21 -0700
X-Gm-Features: AQROBzAawor61I8liRJtWTuMpkwXGgycaB4utcxjdOLz7MDJFDDE7Dpws8WfvmM
Message-ID: <CAADnVQLPDdOxz+V6FO+CtEM5iA+QXey4BTtJTTtRHV4niZsizw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 15/18] bpf,x86: Implement JIT support for
 stack arguments
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 1:32=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 4/13/26 12:59 PM, Alexei Starovoitov wrote:
> > On Mon, Apr 13, 2026 at 10:26=E2=80=AFAM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >>
> >> Yes, we can do something like below:
> >>
> >>                   case BPF_ST | BPF_MEM | BPF_DW:
> >> -                       if (adjust_stack_arg_off && insn->off =3D=3D -=
outgoing_stack_arg_depth) {
> >> +                       if (dst_reg =3D=3D BPF_REG_STACK_ARG_BASE && i=
nsn->off =3D=3D -outgoing_stack_arg_depth) {
> > Something like that, but use BPF_REG_ARG_PTR name ?
> > here and in the verifier?
>
> We have a bunch of ARG_PTR_* (e.g. ARG_PTR_TO_MAP_VALUE, ...).
> So maybe BPF_REG_STACK_ARG_PTR to distinguish ARG_PTR_*?
> BPF_REG_STACK_ARG_BASE_PTR seems a better name as it does represents
> the base pointer for stack arguments of a particular function.
> But BPF_REG_STACK_ARG_BASE_PTR seems too long so BPF_REG_STACK_ARG_PTR?

both are too long.
I reacted to BPF_REG_STACK_ARG_BASE. Since it was already too long.
BPF_REG_PARAMS ?
