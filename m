Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648BB49690C
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023667; cv=none; b=Y8W9ZdYF04sF3vx0oPkmP450VuWhJ8Ka5jYkSztVlmlSYfTHCz7ZMjcpkQ19A/maI6Ap3PsPJ0bPrHDZYt2XPRpJohpd05hxW5fvPHV88NvmLXpgv1ak84amuMa5Goh8LheO8rlZ6kKW8Djf8z1cSGyjY9qhVvhUlZ57M47SrsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023667; c=relaxed/simple;
	bh=8tfPgrZ5njwmpOJtSnueMm9pFl26DajhtsqxQdPZBho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NFHRp7arUQ2P56xbxpY4uQd+6/ucwi5CaOBY7RoHuZOUJnaJlYiwUQPbCWMmuUF7aWUNgAsjHBv6B3vnP7Ywi56rP6vcgCGUhA3ucqtXf+IzW4OEiYMLLiw9akgwZPbNB6lOvQXJNSbclTPtEnUL5OUcfjtpMmPaoLbvjV7ya3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+UUsVQl; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+UUsVQl"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-137ec563a95so7217987c88.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023664; x=1781628464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8tfPgrZ5njwmpOJtSnueMm9pFl26DajhtsqxQdPZBho=;
        b=g+UUsVQlOBTpDMk+OabNam55ZBM9vrq1xEKWCft+aUs0+F989KaB5Ai+62pLRWg17U
         4x+hezgfs9n7+La/v+Arpuo88g0Q2ApY6JVzmhCzAUCg1XCef07gP+LBGRE4cacTHYU4
         /05SmcLddo++RRHT0WGwnlTEjhMxFDV4wJHyWIGTNtjRUvK+ECWGuIdYzjN4oOT5aP7G
         tVdJtBuy9Qs7Zz+mAzCpTxz7AgEVgAvQKbq8qfg7/wtk9VrN2YrBzZk8KlcxU6rNeO3f
         zf2DeoULvEpVrlQrVzulSYtRwykpoEROezkCcilpbKE1Ro0KBequ0O2eMLt+eCurgi4J
         IsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023664; x=1781628464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tfPgrZ5njwmpOJtSnueMm9pFl26DajhtsqxQdPZBho=;
        b=dbtVnA5IS+frldN4uoio39a1LZ+n+Eif+++ZwcTthvOcV/7yNmf4ojoruqL0WxD3wF
         Bk7JsGr29xE/nWB4T05SmQvA6PIfTzUh5gMUpwi4qjHXEsPLa74LaMwGzDH711xSJ6A/
         3DEyGO6Dy+qDevHCynl/ckfswI3ZLb0HI0JigFbi/FHpShrHlpTDB6PXB+0Hnk/TcWZY
         2XzqxWNZMkejLGk1OBEwwDBafpsFbOpnFuikr8cSVoNyux2K4BlHHB/msWVHkw5j36yC
         Ms//ZYDAgML0VkyZuFWSDzP31Ug3jK8PBo2MnNPKAQF5Su0MHeHhPWMnbs7TejrWtQiQ
         v1Cw==
X-Forwarded-Encrypted: i=1; AFNElJ+jiR5lXKVi2+acbAxymA3k4PZ7+eNGPb73ruWI3xqS7HFcEGiD5GrXXBxcmT6zY3m3LCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3MNjQFOJfhQ+Kgi9gemOG/O0jbXmh+256/101qT2OwoZ97sI
	Dle346zCt7jcw+GUOcnoScihtMekPo1Bz/ZPOldOExdBLa9H491yaQCv
X-Gm-Gg: Acq92OF4irt5b/72on4R22SZLKXTQThod7A59vT20FaLfMq94lv46L6Zy3ZsC7rOc23
	nEyYD4EGEKaDa3ebJB8844Wp+GtuG92/l3ToeUAi5L1qhGcwgYh3lHqThZnEyoHSqxJNE20Tet+
	9iQzGdPuYGcDRXjotF0+IBIgTUzmnHQLPuauCo7C5hwSbdGyXMhFXGvp9iRUe/b3U7hlIqYIrSz
	pT1ylVPZSz6EpNNtHhBVvD7GNvRNH87WuquGEc/63RGagY/dM0BIxaESpJ7Gid1Sr6iZob52hVv
	wkqP4W1MJiuthVkMz1wORfdHxqdbHk+pJQd1hHw6JUSUwYOPm5J6bmTJX0mtRe0xdN5I+cOXV34
	TqXp+3uyC0DLVZSvm1Z5FvOGVL6AfJiZvCNMYZ2zu5n1gQ+fMHMETe71gf9QIy3AMCnyEuhs4eD
	rEINiNa2aX5vxcuRburPARn4arBV6Yuwwi2035y+3s5O9UMYgYcuQh7HNXnjgu3oU/pTVhEH+cN
	51GAqVZp3gAoL/wtAU=
X-Received: by 2002:a05:7022:211:b0:128:d967:4673 with SMTP id a92af1059eb24-138066a8020mr11624934c88.16.1781023664342;
        Tue, 09 Jun 2026 09:47:44 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:bc91:a683:c279:a106? ([2620:10d:c090:500::3:1322])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f553ab33sm15118442c88.10.2026.06.09.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:47:44 -0700 (PDT)
Message-ID: <c51441fb2fa48d604818dffa59b7009f396fa0d3.camel@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Add BTF repeated field count
 overflow test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Moses <p@1g4.org>, martin.lau@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 bpf@vger.kernel.org
Cc: song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	houtao1@huawei.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 09 Jun 2026 09:47:41 -0700
In-Reply-To: <SzebdWqm2zREZBf8Tc5Kc-JDWbh9nBztnk4PUu5kRSD1OOdr_ESVTt__2Hd3-lClr47jIjJCXfOH0RHsMpjjpEUh_R2v30nh3T1IXNT6Pbo=@1g4.org>
References: 
	<SzebdWqm2zREZBf8Tc5Kc-JDWbh9nBztnk4PUu5kRSD1OOdr_ESVTt__2Hd3-lClr47jIjJCXfOH0RHsMpjjpEUh_R2v30nh3T1IXNT6Pbo=@1g4.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-09 at 11:37 +0000, Paul Moses wrote:
> From 7129e266643883a4f83e65fce3ce20c7f7269fb3 Mon Sep 17 00:00:00 2001
> From: Paul Moses <p@1g4.org>
> Date: Tue, 9 Jun 2026 05:08:54 -0500
> Subject: [PATCH bpf] selftests/bpf: Add BTF repeated field count overflow=
 test
>=20
> Add a raw BTF test that exercises repeated special-field expansion with a
> large array count. The compact element layout keeps the array byte size
> representable while the repeated field count overflows the old u32 capaci=
ty
> calculation in btf_repeat_fields().
>=20
> Signed-off-by: Paul Moses <p@1g4.org>
> ---

Note that this selftest is depending on a fix:
https://lore.kernel.org/bpf/DJ4DWMO4HXCM.3NVLDGNT2704E@gmail.com/T/#t
W/o the fix KASAN warning is reported when executing the test.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>
[...]
