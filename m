Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BDE40DFDC
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280970; cv=pass; b=FsYzC+eD2abt5hKZm1yKha68ob40yRKU1nEWzsVRo7J+6hC6iuQYnc7vYB+gMUbDtalz6Low/pl1QeYU51nfXeIb4F35yzav+Jew8OyWWWWVPpSWGmRb9kWkrv+umSv52UoW0BQ35IGqa6/rKo+ueotuIF4z3p+SfJeucyLvlNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280970; c=relaxed/simple;
	bh=eD9Gm900Z5a9PUDrOmqopWeHYJogEu8ArE7AzIHmAAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnScp58mJEfjDhP7T+U3O/oZvq1vo8VmPm0XKxbedRU2OMyCYZkvWXbNBllkrjFWnoQZMUMw4p/fhOzjfS7fYqecwMLkor9TO+QYfp0d+r5I4Pu8TzHBqxUcuMabWR792qibLO0WK2K8s2dUDKoanpRHVypH/cD9OPECP0Belkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqAUsOng; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqAUsOng"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso70743495e9.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 12:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776280967; cv=none;
        d=google.com; s=arc-20240605;
        b=ignoLne/A/WRDlkNmtZT7nIMd7hBRtGfO3zGpHFqAPG7BXwDFILfNx11pt9JjkDb8r
         0BUdHJ6D/u6WFtjgYTjDWOMJZ3/zBZJbqnGmd9nx0mx+BeornBE7e1Xs+wiAOKyfjXpT
         TlNX2OFyQPItWyPhJXlxPpzesaJzWKxBbLorMiREmL/ppJeiiaYVDteccqfe7i1XmKB5
         HF96PEHVfX7VxEfB6I/v1/tFwl/3tj8SkNvEu/0Zw49Oa/5x0JrqkGEYiK97mtqP4L41
         kI5/K/SwDuhAHG4vy0qZ0PqI/Egyc+6Ce0Vnqps4LhUu3xqGdtzxTf3C5lNSmKBIcTiU
         UgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eD9Gm900Z5a9PUDrOmqopWeHYJogEu8ArE7AzIHmAAE=;
        fh=WvRAaTiXz7//4I0Q3OkM+K4LZVFgLDd+6sxMJg8k7ZQ=;
        b=eTv7eLziOqCqafVHpW2PIsko4c6Ed3UAt6UC0Ac/rrcsMwm34gWp7Bd5SuA0iKwl9y
         MREbZYmmuB3XZL91FUKHFpaHRf2LhDrRT48lVeQ2AEHocxBgaNK/uhK1F0BYEuWDz0Gv
         HCPpQUFWNURSzkUuiq/hCqWoK6Y5L6YgjiWmHw8IDvMZDJUj6pwSXTRXHDpoQ/cgvWXj
         u2RzVVpn/fWzpmTt5326cSFCfTe5AXklImsx06fPsus/4q9SidnBUlnXCWscO0ZG4M4R
         1j6MQATV77UY9ZfIM2JbYwn6Aqw8IkwGs6HCQ54u5Mw5Tg707M7NuGzxe86Pc5mniXBW
         mTFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776280967; x=1776885767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eD9Gm900Z5a9PUDrOmqopWeHYJogEu8ArE7AzIHmAAE=;
        b=cqAUsOng3yLzGPiOuPMO1K9hCGWFimTeIXFAPOaZhE4AUDE9WUIBGnnUPLJs8hkIeB
         TOmjrXAoSMaG7o+66XEyE8OEF7BSx70SYSVV1AjJtmSY6dE71tHoXDdZyB69nw9juRvC
         JyhMKTeba0Pbfnqe+h3CLYUaEAiwXEzGmUvEaspJQyqunwqb7rgqO3+sHp+LQpZHkxya
         6EE0sihZMJv0Vn3TrYzOq0G5+UgwzLyx8x70FqbRqsUtvDO8NhiS9SMfxNLN8iFrntVL
         NvXIzqedU/DzvvcfGTJcfCvSgNNTfPh1qwNWZfSj3z1OD7evVJ6X/2Cn6Aiw6x9ZBdwb
         I2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776280967; x=1776885767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eD9Gm900Z5a9PUDrOmqopWeHYJogEu8ArE7AzIHmAAE=;
        b=Bm/NkH8I4D7alYFNswCWKvAq1OZa8IGbGrOhNLzsJMaxDa47E988HdMhuUGc0z0a5c
         tVVFFRhFWdL9zUacQQisRXVnI9KTQ5zLLu+3cOHJRHC9dc1n/aG4f7KpJ3bsV1ELHkXW
         9B23NT2mloJ0czaZ3HS4VO3SPwW1mM92SBcAX4xTKNzpoLl4i3HGYRk/3Vcga/YRoQur
         Q+08NXKimHDK0S8hBICM2mboewH7a7pZ3922dfXnS6Xkod+qAd6EAQYGopvN4txBSXbf
         RsYie/79U/hhHrwryn3GCWf7zn4AJLUoUK6ys/7mPn+puOvICpjqxn1C18NzhhQbXutv
         mBog==
X-Gm-Message-State: AOJu0Yzl2dZdvrUyu2JyeaBd+iHbwth9jiAjsk9tvqFJ5DaY9gbm1yfq
	QWf7t/2tSbqyAeKbrhvxniVKzQX/6OJaYCpSmPQvcLFsOWZUW3tP0WVHafr62mF82WGtEgYQE+l
	/A9plPBXbupO7u4WqWAbdHQky2piYMss=
X-Gm-Gg: AeBDietFfiCOlCGvoS/ZuyxXI30euTSPpYScK/OAJSu1g4bbKKro7L7/F2mgQlhPuvl
	LxYYt9O2leG4QGG31RMpqDch+S/9ZOzeYG63IUTgVlr8GZ5Sr7O/EE13vlqMc9Cu2MyFUkOzueQ
	1efJTc+GUeJERWLfdIlWUzG4A17k23YD3qLt/ZwjBP2L4HNawcIgTPU0n2UtHqAEvdxunPDVEqv
	g1cF0QFmpRQhFsa9ANR8TlKqtsNmmmKAC2GsAxF1kb59m3CxuNP+0bMK7D3Hk1g3hhOtIDt1/wv
	Q+4bIimuLbTB6LKYviNKx4mC0VsT3JfOafbAx9NXOi9LOj2bN8Ns72c6B01T75t65uCQAYp3I+f
	3Vgmjl7cR3BuJjQHcRljPoEQ21Wa96pciYam0
X-Received: by 2002:a05:600c:35c7:b0:483:64b4:79da with SMTP id
 5b1f17b1804b1-488d68b27d6mr348751095e9.26.1776280967394; Wed, 15 Apr 2026
 12:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776062885.git.xukuohai@hotmail.com>
In-Reply-To: <cover.1776062885.git.xukuohai@hotmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 Apr 2026 12:22:35 -0700
X-Gm-Features: AQROBzBljds-87hBFkRrWzupkoEriKaz8fyEyiiLRxFEYFG8-E2Vo_k1EhMb2k4
Message-ID: <CAADnVQ+ZZyhrMXYJeZ+HK=L8AWELmbRUOdtvtqPMokgAzFaXhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v14 0/5] emit ENDBR/BTI instructions for indirect
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	=?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Johan Almbladh <johan.almbladh@anyfinetworks.com>, Paul Burton <paulburton@kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>, 
	Naveen N Rao <naveen@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	"David S . Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 6:06=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@hotmail.com>
>
> On architectures with CFI protection enabled that require landing pad
> instructions at indirect jump targets, such as x86 with CET/IBT enabled
> and arm64 with BTI enabled, kernel panics when an indirect jump lands on
> a target without landing pad. Therefore, the JIT must emit landing pad
> instructions for indirect jump targets.
>
> The verifier already recognizes which instructions are indirect jump
> targets during the verification phase. So we can store this information
> in env->insn_aux_data and pass it to the JIT as new parameter, allowing
> the JIT to consult env->insn_aux_data to determine which instructions are
> indirect jump targets.
>
> During JIT, constants blinding is performed. It rewrites the private copy
> of instructions for the JITed program, but it does not adjust the global
> env->insn_aux_data array. As a result, after constants blinding, the
> instruction indexes used by JIT may no longer match the indexes in
> env->insn_aux_data, so the JIT can not use env->insn_aux_data directly.
>
> To avoid this mismatch, and given that all existing arch-specific JITs
> already implement constants blinding with largely duplicated code, move
> constants blinding from JIT to generic code.
>
> v14:
> - Rebase

Pls do one more rebase and target bpf tree.
