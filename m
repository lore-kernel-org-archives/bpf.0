Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585BE357D14
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635022; cv=none; b=lrYCZSrfDh3cNaztVn86KJZ8UnqrVufyGeQbJPUGOitLJAgzBAs+xCf04l64HtBatwasc5bA+JqmWzO0rgjeTZvID1hEL2hgugiKZrk72fYJ7/FnMYBx3L67fnDOID5NEsKKRNMksQZlWxKpO1lhuCC4E1Qtt0vgJK3ylo7flYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635022; c=relaxed/simple;
	bh=BGt/XflRUDA5DhFD/N1WAK0zw3vyMAn8WLZhQuFSrY4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I4TnR0L6M4X4DFKVMgsJx70993Y4h0lLPFfs0XBPpB31ir+yWP9jtoY6ICB2rP/705NINL5Er8rNgOfesB9jpR5nCPYxPqUF/+Qx5Ew0efsQifny9MJZEPWuR/E2mVM2eS6CdCCS3w1fyASzwaAYvBcxTE44D1GDNFkNC9DnM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dshRlg9/; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dshRlg9/"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69b747a8984so351800eaf.2
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 18:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778635019; x=1779239819; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGt/XflRUDA5DhFD/N1WAK0zw3vyMAn8WLZhQuFSrY4=;
        b=dshRlg9/Sfcali7v30m1hCJG8e8QQCqx6dz5hqdsKz+suFkl8Z6EHFTEa9Q2WSTlJh
         XZG7LDPJJnBMpaYsLFtEziEOCnByyEkkQgbOOPN+JUb4srlNHl2dnaBYgQK5MsOrXwUA
         Gcg6Qb8ZoXwPJmWUP8A7q7O220FZKYxMm4oLq+Wq+yVC2IotxL/RLgRwM5bPr4N5Pt/K
         2ngSXCDignZ0asSdFoc9a3T3UytiCztcoi4a5EqqgP9P4k7E+xylXbitfzwZZIg0Y8ZQ
         67Ky5tnMyUG73mNw+ey9E6GDymzQjU9UGEjUncDpCAE1LA/E81U8bRQ1GNx/17UjQpmx
         xM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778635019; x=1779239819;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGt/XflRUDA5DhFD/N1WAK0zw3vyMAn8WLZhQuFSrY4=;
        b=FqV+ngSvYRH4hnfDXsPcDH50hE2+l+qIhFeg5ZJ90EoG86QeeFncoBCnbM1UDTrFHl
         E+7kybbUmVPhUPW+RJQDinCu+FOXutM4K24SQTUQAQjnlrbgt7uDv2L+JVqXDuJT+Fby
         OB447nhlavi6ms9oq+UdNXF1VU+g4giDXY/JIVkthXMBmRW+D6zAfh/wDo8PT51abOUD
         4APmelO+e1sqdjQpM0yWzGOS3wXMyNzsbOc0DDx96mBSXS+MX+YHiU9awX/sLPcRhpQ9
         bLWBxvMEeQlXkxk3q/sS7qJkvjX8zamh9ZtU9hHSiZh0/wih/dwALWcDfqvw8o+/orEh
         8o7g==
X-Forwarded-Encrypted: i=1; AFNElJ/uY2DFaPPagHfdyTjiPQYRkXbsawlvHvvYq3HQPWK9Z3sq0UpdN1RcP7hKhAD5f/Th+Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOrbt2/NiinVgiEjA8gqz+OGgHlUGGOHi48IdKWIDwU1UFkmTM
	3hR5Ae1FEwD1vHTbVX3FrtT1dck5oB48zd9nJDY7FtOCVti8Crxwdq9b
X-Gm-Gg: Acq92OEYQvHdTN8RKHPIVfIc1oGovLRhqtA7J+BBkppyIjdWoQug+rusicYIx8O84lc
	Qie0tVe34b5gfJxVzS+mp4ivLNTSE590Optdq6/1StaCzMGVDtEYb3hQu2tAJ/IShZ28mAoUyEH
	ZPn/Z+CJMz0xfPIEl2JRTgM3RJ5VpWFincXI3AdZz+iu3PpD0JIL67RlIBq3kPDd1+P52ryOfNS
	bDLQhKPn96E0LixK+h9Ih2NlZvdryNAAH+mt5cou2Dv7VGcgvJ/rdAaAHotOmaTd94D0jkeOdQa
	K5D/ss5r/KR+FmnH145VV4Hpv0BfsnUbMZ4GL1MiBrPaqCUBUQSQfFF6c7wOoDIp3YS5zz5VTo3
	c1aBC/UhF8UJ5gihwkXlhL0xkwzf/PVx63QYD0hWZHBqrARTPEKONHiyWq8b3q37vv+dfjJHE5Z
	CKAuZnxO6fiaT6fX8XRIOmrDObJWny90rctSGyE31E6SPkmlWQzrVQz0Q9y8hFGOxWTR6RACbIs
	3Y5JdEnI5ZqShO/gg==
X-Received: by 2002:a4a:e908:0:b0:694:a339:43ac with SMTP id 006d021491bc7-69b78e2f43dmr699568eaf.42.1778635019001;
        Tue, 12 May 2026 18:16:59 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25956231sm8332504eaf.0.2026.05.12.18.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 18:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 18:16:55 -0700
Message-Id: <DIH5HQ54TYJF.2LNWVZJ50B5L0@gmail.com>
Cc: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <andrii@kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <eddyz87@gmail.com>,
 <edumazet@google.com>, <john.fastabend@gmail.com>, <martin.lau@linux.dev>,
 <pabeni@redhat.com>, <song@kernel.org>, <liamwisehart@meta.com>
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
 <20260511085344.3302-2-mahe.tardy@gmail.com>
 <20260511182019.69ebc7c6@kernel.org> <DIGBS3WKQN94.1YYMZM0K6CETY@gmail.com>
 <20260511193603.3ef00cee@kernel.org> <DIGD21MXE0XM.3CLUL6BVK74PK@gmail.com>
 <20260512065335.50647ee9@kernel.org> <DIGZA9DICBXO.2QQ1V7T186JW2@gmail.com>
 <20260512163255.34162f1a@kernel.org>
In-Reply-To: <20260512163255.34162f1a@kernel.org>

On Tue May 12, 2026 at 4:32 PM PDT, Jakub Kicinski wrote:
>
> I think you may be overly optimistic on the dependability of netpoll.
> Rik has added support for serial scraping at Meta because netconsole=20
> misses a lot of crucial alerts. And I can confirm there's a bunch of
> errors that appear in that dataset that are missed by netcons.
>
> Then there are little nuggets like some generations of bnxt NICs
> having to discard all Rx frames when netcons is trying to send
> and Tx is full (bnxt_force_rx_discard()).=20

horrors. since bnxt is doing that then indeed it's not something
to rely on. I thought that over the years major vendors cleaned up
the driver side well. Looks like it's still not the case.
Sigh. Moving to sock_create_kern() and friends then.
