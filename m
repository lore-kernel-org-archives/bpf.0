Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2167A2472AE
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790300546; cv=none; b=rUpWwzVL548fCjKn24VJw3Jk0sGs1hbbSE7hJq1Z8km6K7tk4wgMJXGEmTQ59xiyoapiCu2OPrtcCcCBZT2IyzFakeuByCuBiKXdnHVLgxku52yUQXb1ETQ8LMG+cpF6InlfsRJsAvYBZqY/ro4O0FGY/02rgTktJQa91C2ICqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790300546; c=relaxed/simple;
	bh=bpcSArP0BakjNpkYgiedGHQ7QoN4N0x72zQhrjcVA2g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=gZXyiYvYD4EdzfaHaqgiXJcBFPuZQXTJWLW9idKva/sXhK1/6tjkpK+QtPfbaPD77CjWxvnh9pX+FiVLRnfz9cLBwYdsLNxAU/4qcIKouomN7u3XobVqDTe2FVYrq49yBH7hz2u/82a7XgxuBnuB6lJjgJjcPqqdTkFVkaTRUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfuqbQTN; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfuqbQTN"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc147d86bebso364556a12.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790300544; x=1790905344; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VZmHIVQt5MsqwcFSRkTf1mqGRLmUxrlijiy48OZpNkc=;
        b=kfuqbQTNSjtA99g6SjRyDWmshlv0EfPWvY6gOhLgkPtGczhLg5lhmM11dtxRUNHWFa
         lBIKGEXKxfd/3XTOI9RkbOgGUDc0WjE0MmlN0lyOUGOzisOLA9QSkYsNRR2dWOwhwcPw
         WNMM6dhYQsd19qajik60bQHj0xA/1zbNCFcgyAzNdcU7pjWcpVMYDBCJHX+TLAihJOqs
         i9puFM5HVQF7QK46DpC2GQGVdG/0lB0sfzejOPPt/CmmOOaDDqPCFDGrUEd0ucLoQT07
         iPko2xrzVmnlX1usyHC1E83iRJgcYdWEnT9YVutEq6Rco3ZK2Y+7tYVukWyfpco9oLeg
         i5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790300544; x=1790905344;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VZmHIVQt5MsqwcFSRkTf1mqGRLmUxrlijiy48OZpNkc=;
        b=NKt+OTk8MBMpz7Ehd8XsZMiK76KyYlwbSl9jjCwkBg/ZkwaBZsy7Nhc97F2xrkK2S0
         56VICiLKTH7OG6PpvtpX1zdN/4dzkVXm47E0alE9+JoUos7bKZ/SO4dEwgO5WtUq/xnI
         06ccpf39hw0P8jMS30eZE1HyFQJ3QcrbWVbSlzTBfWVJRiKraGzaNU4dn5zcnp36HlAQ
         gBPNEsG1wtYRpytFIOcw4nFikTisB3DuOqca+GG1s5dsWcblSc2QpIhEoda680VnG1BS
         TBqf/OJPErcCwXFywt2/f/cAX8Uh+locmlmRtPKyNBejeiA7+97NLSwpsiMJF92QsZnm
         ++1g==
X-Forwarded-Encrypted: i=1; AKwUvBylVxL4CbTKNf7v0BBqB1tSMGhFXbuJqtZs19eIvwbZXiZPHpYg/LYzHOabXlmwqMSwQCc=@vger.kernel.org
X-Gm-Message-State: AFuF++k6+gs3fiXQjn5PwCeR0kK7WWaalQY3TVev5LZdcc8rKh/ookKd
	dkaAUFQVi2KPL2IDukeVG++fIIDbiu6H9ao9rYNTqmXZVPildGGfAPlE
X-Gm-Gg: AYBFou0klZ1YX9TfJoKS/nVI2kBijihCN3KXqrw+VnR7+NbUG8Qy06ZGciERCe6pxv4
	EJ4iSj5W18SNUJ6OpU8r3T/9XPswXp2k44nMoD6J5K/4JOBJyEoMhNP3l/PxfHIYbHNFuAVeb1T
	VNGxvviR/2t8xyUOZzmWUoh0Fr/cokpnulNy9Gf96MxxeuI0heptrdUykyYSWv0a86MBJM2n2lh
	6rvXmLZ3fXCNNfYqn9HUhv/YYZPBasQrlCyRDiYRM3W9FNzLIoMMWxKbqj5itAg5hZ7smq/nvIj
	/oFt1NzwkFxCJ1iQMQ6oikl9miqH9gvtp7Pcr49T2BsNNtm4F8/dEfFfKMAB1kiOdxhwOqYo2A9
	glP/jYgXn4EqQ1XtBVONOg8DHKyAcBDrSgP+YVZ3CaVOAcbSMWax2EU10Q9wrtYHQRPLr99ANvH
	cDs5BQ4u2KG0X7A9HngEqLkC1N//qyoYV/TURGKP1LaQ2AktMOoJ07zpwW/GeA+U3e0nP9426er
	lyokFKRWFZggW30CwgqjZeALxlpA6gBxQjvUy1Q73p13UfFRlFdewm5g3Qaq7xGNBE4oLb5bEPw
	HNY=
X-Received: by 2002:a05:6a00:4208:b0:874:72b6:7da9 with SMTP id d2e1a72fcca58-87ea06d5f01mr2680271b3a.36.1790300544302;
        Thu, 24 Sep 2026 18:42:24 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea19800esm331255b3a.10.2026.09.24.18.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 18:42:23 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 01:42:23 +0000
Message-Id: <DLO0KRHXJ8QT.3EM3ED4EEZI0B@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <john.fastabend@gmail.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: add diagnostics for rejected memory and map
 accesses
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>
In-Reply-To: <CAO9wTFjNX18eynH7EJGjzMeE+yXx9XesLSW9gJCYXTSqNJMavQ@mail.gmail.com>
References: <20260921154650.130677-1-suchitkarunakaran@gmail.com> <DLL5PFJLT64M.1W82K71YXNT3A@gmail.com> <CAO9wTFjK+oRT-maca6A1UDBrgYTGB0Zr48UiLm2Ees835POOFg@mail.gmail.com> <DLL8564LZU8N.16W933Z547TYI@gmail.com> <CAO9wTFjNX18eynH7EJGjzMeE+yXx9XesLSW9gJCYXTSqNJMavQ@mail.gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 11:19 AM Suchit Karunakaran <suchitkarunakaran@gmail.com> wrote:
> Hi Alexei, thanks for the review. After some research, I found that
> the sign extending load instruction was introduced in BPF ISA V4.
> Given that, would the following diagnostic message be more helpful for
> users?
> bpf_diag_policy(env, i + delta,
> "sign-extending load from arena memory",
> "the current JIT backend doesn't implement sign-extending loads from
> arena memory",
> "Recompile the BPF program with Clang's -mcpu=v3 to avoid generating
> sign-extending load instructions.");

Yes. That's something the user can do.

But look at what bpf_diag_policy() prints with these strings:

  The sign-extending load from arena memory is not allowed: the current
  JIT backend doesn't implement sign-extending loads from arena memory.

The same thing twice.

The other messages in the patch need the same treatment.
Read every report the way the user will see it before sending v2.
