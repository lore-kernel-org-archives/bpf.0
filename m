Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B9832E129
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769581627; cv=none; b=i9ChP+Z1MrIfO5I0EL2uUb9+6NvxDIrRzRBSU/6ezPVkVjn1n7Aqypbv4l2iVz7PAr5hWx3RjSiGgSK/WoTuasOlQkt7LoEf5RRJ/AkecBmhImabmf5/DTVOdZEc23BODAWtxqmsgBuxCWVfyChLt+UxwzSkfu4gP+5pQeyySng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769581627; c=relaxed/simple;
	bh=Z2RNeIgIuiMxf8WzwyV3GqNjVb47QgM8ARvMJvBsGWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MEmBxzVU9lzXx8sbj2KcRefm9dq71IiTODnVj71lVscLF1GPOZoB49X24BjpSMyAGWPyn/64Dx0R91EOpmDgibF5EBjzIov6x2rdE7XJRpV5r0EVeapYN/BSHAAjsu/nny86flYnZusT0TK2cr7KHhh1tPvC9X6hynDM9WJOSNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHuT4vyf; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHuT4vyf"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so5352251a91.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 22:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769581626; x=1770186426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPoxFNbF1tIwyPaMGUrhH8qeDggEU3m2mgb1vM1gtHo=;
        b=cHuT4vyfHhUq0umCO1Bt9yuvejemY0rDAR2/ddWYGvCOy7LNzpEFNIn2tjeHXtiquW
         NWDoqY1lYrQ9ARkwp7apx5SWdtv/ejL0y/HvwTpClw4SeQrxJ8P/BepuYn75HorLU+si
         nlUlQzPYefjxUwksrD488y9ponpOvqEDClKqEIUxugnOfwBzocHQ4O9Akxa5uMgKXfsm
         UM9yTXZQwhCVXeNHk3D00C/TiMUKjUYyPThASIlcuNQsbfS+O/rd3aYTggHNz1UsgGvT
         f5bnuai+1TN6N1GdhYDWQPuSsZidFZmjOYrQe/mR2/kyOMnhtumFJ3RRPK7xQnjJsYbc
         z9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769581626; x=1770186426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iPoxFNbF1tIwyPaMGUrhH8qeDggEU3m2mgb1vM1gtHo=;
        b=RU1ykIhdvt9F8NAd1cLLSXFpxviUmfln3czBsK/TowO3XaBewIQrkfOdAVoVVY2Wcm
         A/jYZM6bHOqY3sagxYOGyp2qR5aL3xwoa/4ltqHb8PlhDXSN5+MrWeioWOYOd09iPjDE
         ChtgWA84w1evaiFqQ9HC70UnalHw1PwqIrnrzQ6ZosCqkVPuFYMJZaJQSgDOYcrnhDgL
         UBTB3SgoEacI9uTSy7bCZc+b8xoOxTIXXO5pEJBYAH1kXe/vMgrxOxpVONisoo+UW0uE
         z74QzdJkDzlrwMH3rMkohFM3J3sUKqJf5VCjUyI8yHzbedXkHpLmJ3oX8FRvCtNCBvOE
         RL3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAt25g/MRNPZKU/U6SPvMoyd1TOeffTDFoRlwPuXKZ3MUYoPZJnE99yTY85hrk7LihT1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZL45TE7oDsqufAOuHi8A82t/T+rI1DkN9AXhrN8Iah33jJDnk
	/CZcO4Uy+6ihb5cPuk+7Q7bOoEcK0PNQ1LCavb8oMWzifnLbO3vvioBr
X-Gm-Gg: AZuq6aJmK5IEm/uNCwkqdNiR11RZ6B1scUAdj9byJThu4ij3Z5pZQxU6coFUXVTLK4u
	RTtYkUaV9wS+gDsTgQLeeOB8fHbzryhR2OtCstQXl3Ca8Ts9h3DppT6XeRvKgZDpYYbr56pqsGs
	vnYIH+GRfMNktnIMrX9AprT3oxPwVVAQZM7SbgJfP3l84u9KhgJEQXfWFIrMEJ6DmsQFMCzVYp2
	aUIkeX9NPdBavGQ4AFiSslp9AUAqkqGoKuLTfaEHn3PH5+rg6EElQqr+hVlfqoE/nVOcHJSeXTx
	R13vTyDqCQcWyjYg1A7JQn0hTv0otPjqoPEmVLrxvABzafv+YsV6Qs/NPjUz2AcEHWsYpRKflUa
	pYhfRRJTQ++Bb7Yf1tGdvgM+/yXNkoWiVqnJDrYo7FZ+v6qHj+uyiHKyUyGGyh34Ne04E1k0U/+
	wMUwD3c6OAHusQBqgndudDSraL17um5qFbNbSRXg==
X-Received: by 2002:a17:90b:2789:b0:34c:cb3c:f536 with SMTP id 98e67ed59e1d1-353fedbb396mr4595212a91.36.1769581625850;
        Tue, 27 Jan 2026 22:27:05 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f24aesm1286780a91.6.2026.01.27.22.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 22:27:05 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	bpf@vger.kernel.org,
	irogers@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	radoslaw.zielonek@gmail.com,
	syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Subject: Re: [PATCH] perf callchain: Fix suspicious RCU usage in get_callchain_entry()
Date: Wed, 28 Jan 2026 14:26:56 +0800
Message-Id: <20260128062656.1860201-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAEf4BzaYL9zZN8TZyRHW3_O3vbHc7On+NSunrkDvDQx2=wwyRw@mail.gmail.com>
References: <CAEf4BzaYL9zZN8TZyRHW3_O3vbHc7On+NSunrkDvDQx2=wwyRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Jul 2024 at 01:41, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> Which is what I'm doing in [0]. Radoslaw, can you please help
> validating if those changes are enough to fix this issue or we need to
> do some more?
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240709204245.3=
> 847811-10-andrii@kernel.org/
> 
> >
> > > ---
> > >  kernel/events/callchain.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >

Hi,

I found this issue still exists after your patch in upstream and I have a
patch to fix it.

Patch here: https://lore.kernel.org/all/20260128061753.1857803-1-wangqing7171@gmail.com/T/

Looking forward to your review.

--
Best regards,
Qing
