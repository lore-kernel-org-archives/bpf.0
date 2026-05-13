Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037003876C7
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712936; cv=none; b=ljnBBJ0WJTVeQGbZV/rmXVzTIWak4aZdmK4+HjomondrBkheFIEiDP62C7JZFIcDzJMH+N0vzcTV7OQ9cvJ5fi+3+CZp6lRb2ysX+PD3faN0jC0bnfpyt4YcKb7UqzV4cMsI5p09svfzYLalerlYabp5vWYz2Y0Jp802vbsstzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712936; c=relaxed/simple;
	bh=Iaq3hF+DVkA5zlYIbzXnnu60gGVm3O/byi28Rs9qmws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qfhGTmlZnc9i/vTybN4J2c9FMdCNT1y+aYEZwmRJO78CTAw0KjjNIuoAvYySjB6WoawsMXEy2DhKHuTkSY3dBrZRCl/uhfJwK1q72ri7Nvf1FsaZupbJxXs5D9oiF6vcwmvjdWdGRnVbnXh+gSCe3AafeTGvPoZG5Sq3d/6hp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKBl6IgI; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKBl6IgI"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c156c4a9efso10080656eec.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778712934; x=1779317734; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iaq3hF+DVkA5zlYIbzXnnu60gGVm3O/byi28Rs9qmws=;
        b=CKBl6IgIwflYfOp5OX9WdEdtXkYMlJcaUqDHTxyEJyUPmC/GCimF39IH56CkZ6cljV
         Kri1xd+YOe/Y6vj9vBuZ+3nEemcbj+pKhRsmLo+R9ArlJSBJkFLHR3OQDAOeff895ZPs
         nNsbg+BSKwnpZlSZ66sEDpHli1dS6v1lym5ITPdJGT863TCGabwtKNs2uqwhLMmD1RXx
         1Qu/gtKgyof8r9gK2Yfw7F/kK9i+qkHl1Wd3tJluEa1fqvVVfUCDXa4pIIDi3QWH0k2V
         N+MrZsXtegP4oMQwdfxhfY2GzqokayViB2x/TjSl4ekHxrSdpY6++6rtjSjkf8WhmloK
         zINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778712934; x=1779317734;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iaq3hF+DVkA5zlYIbzXnnu60gGVm3O/byi28Rs9qmws=;
        b=DRzY60BbyFTLTOJJmAzSOk8OrGPeBVaIO8v96CFvw/Om95ZnUmOFf9ExGUnZR1gjuh
         xIi5wDAu6QlmJlAnVxb6F2KmUd/Hxqi+xhhL/RphAXTzUphMXOp9Yxxa7IdUnAdMPqQ3
         6siUhh2iskScF/pCokuZFfvsjgwFeMjqfcUIy6EOcovb3c0AEg9+91rzQxdSZoUCV0rw
         BD246gzjOwM9y66JMIfshxMrvLcXBjBfj2vghomUx+3WdTwUyutzflXVgHmi6fckt0b8
         yJj22554xfwg1RWrJpPi0iWpRjOJ6ZrMrppyb35tbWKuJaz/Du8yEafUievgFyp10GZ0
         wc5A==
X-Gm-Message-State: AOJu0YzoNH0nHZeTmtZBowAY636YJwjRG9xPyQOzBeldOpHMRlgtr6+4
	WVMZbA90C+b2UHn+XENpuL7FRalX3KZwqAl6FyNEdSuQFHOrLbx5tq0S
X-Gm-Gg: Acq92OGzKD++iSsPMkDj5CNtpMJbehFldgHV9LFRDSWX3MEQG7CVKYvCLuLYDiMMHpI
	aO7Yu0wPSI/9wjh4/3KRPG27isyde/f0qmOBsfkaM0iK0gXzlcfSIe+6JOyWGbtxUlO0MJ1VpcX
	7NTJw4YkAa8B3ad0BSSTSG9hpwxzrfs6HgIed1LbN6F7tuJHYs6Vmk6R63HJ61B9XW8B0Y9PdSm
	dBjdfPGIAQ/pZSvfmvYrEZE26Df+Ujw7mHQyXaV645rWdH7ZOrz9DxXqi8kPq8ESu7yw3CysDX7
	2k+5eQ+qFk6SCIAIxb9v6LDUA5qlg2xsPnSi2N1shRODtLwCiuBNRFupDQuYMIpBcjKEBQ6+bAV
	yMDuEotRJ8OMXy6DovCxZz5ekfjk6mFY14YwfqOHcUAJxbKrwDyt9EQugXdV7vpj/wO+5cv4nLW
	oxsjIUupK635GtME//ZS1UoW4UcVsTGdom4dvzC9RcQOeNhzHhA6eNTEuFJh+jtkD5q5GDXyOfj
	tEOSWw=
X-Received: by 2002:a05:7300:7244:b0:2de:c5ca:c1e8 with SMTP id 5a478bee46e88-301541af891mr2987879eec.4.1778712933997;
        Wed, 13 May 2026 15:55:33 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5152:641f:f5ef:6c7b? ([2620:10d:c090:500::2:8a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6f6sm956046eec.17.2026.05.13.15.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:55:33 -0700 (PDT)
Message-ID: <66355df814a639c463b5f51e96fd539aa30f0679.camel@gmail.com>
Subject: Re: [PATCH RESEND bpf-next v10 7/8] bpf: allow non-owning list-node
 args via __nonown_allowed
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao cheng <kaitao.cheng@linux.dev>, ast@kernel.org, corbet@lwn.net, 
	martin.lau@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, 	chengkaitao@kylinos.cn, skhan@linuxfoundation.org,
 memxor@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org
Date: Wed, 13 May 2026 15:55:31 -0700
In-Reply-To: <0419643c9a04bf0824066742e52e3f197b43909b.camel@gmail.com>
References: <20260512055919.95716-1-kaitao.cheng@linux.dev>
		 <20260512055919.95716-8-kaitao.cheng@linux.dev>
	 <0419643c9a04bf0824066742e52e3f197b43909b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-13 at 15:37 -0700, Eduard Zingerman wrote:
> On Tue, 2026-05-12 at 13:59 +0800, Kaitao cheng wrote:
> > From: Kaitao Cheng <chengkaitao@kylinos.cn>
> >=20
> > KF_ARG_PTR_TO_LIST_NODE normally requires an owning reference
> > (PTR_TO_BTF_ID | MEM_ALLOC with ref_obj_id). Introduce and use
> > the __nonown_allowed annotation on selected list-node arguments
> > so non-owning references with ref_obj_id=3D=3D0 are accepted as well.
> >=20
> > This enables passing bpf_list_front() / bpf_list_back() results to:
> >=20
> > bpf_list_add() as insertion point (prev)
> > bpf_list_del() as deletion target (node)
> > bpf_list_is_first/last() as query target (node)
> >=20
> > Verifier keeps existing owning-ref checks by default; only arguments
> > annotated with __nonown_allowed bypass MEM_ALLOC/ref_obj_id checks
> > and then follow the same list-node validation path.
> >=20
> > Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> > ---

Also, I think it is worthwhile to move this patch before the patches
that introduce kfuncs that use the __nonown_allowed annotation.
(In case if this series goes to v11).
