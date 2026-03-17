Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24483A0EB1
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739811; cv=none; b=fY08EzssCRgrLS8aO2y4vQC/6EzMlsI8HqGw1jl6Gi60/WkzahXselL1cHSqZtDHOIlBip5/VVkYcTMKoWIVfApW4hvGlWA9tyIDGvb32nIpdF8NaF8iBo15JYonjsCdUVg/6ZZyIPuYVsl/ERRakOwf9TtX5yCcFg3MjUCLxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739811; c=relaxed/simple;
	bh=cbnprwPaY7zwRJWHZYt6wVlZGxugerk6GPerK+WZ9EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZKm2E38MEC4fp0fY5TcrR+PuFvkBrKOS/NPYK65sLvhDwkyqyQhuAUAzh3QSyAW7RU2hZ0uUz4IxfbxY6pKW8JMjm9QKkcvrKFZqrKcx20zRTwuJqMI3m2UOuk2kiOWhd+5ITlmZVbH3GJep1KmwAffWUQ8qq1oD2WSWUhqbgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK0EH5tg; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK0EH5tg"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c7393536e53so2139508a12.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773739809; x=1774344609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbnprwPaY7zwRJWHZYt6wVlZGxugerk6GPerK+WZ9EQ=;
        b=mK0EH5tgAKl5r5efiuDVopFTYC3ikaLTdwToIh/QwN+cZvtvYxRXMZBpPW+t7UXsYz
         vEOuzDG/uYu/5NIsgfUXAzZJuW/KLHzTDmszdo+nSYmakEloEYCrvdUSzIO/u8QX3Kj1
         N6yKpuJMQn4eAu2uVkUlg8FHqjxt4FUK5+4PP0IqpYcrgmv/sGgPzTfCqoXLxV0jUc4c
         wVT1nohWqLQXA+hE9nPXuYCHMLBX4hWtKPp2xlfOkPudG3xSi2KD72PCTohSqA9w7jHr
         S6dR2WSzwPKGh1i4hS8LXvDx0DwOnpMIE0vJ/f3XtRTh+cXRxGuSA/HWitiLZwCIPE7E
         tssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773739809; x=1774344609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbnprwPaY7zwRJWHZYt6wVlZGxugerk6GPerK+WZ9EQ=;
        b=CRMOCDwZbkz1VUufWVZUGScRzdMWcjNvh3TUHIn6CYgJ6XKWOtHc+RKuvWOOrVxs8u
         HEFk5gnZP4jCLWGnF093npa5agQaENx4YZGJGtwZMiqMs22mxb2iiwAOPPcbzj82X4El
         2Oj+Lhyc1IAx1FHKtfB8gtODnI3f/6MY2VKHbd/wvGpOefkQBAiqn0F5xBODXtWomQ3E
         1l67osDPmifWvqv5m0C8PRhwj6lWSvBzxpMW2LyK1AdDdwuG1bqkqe5oeYa3zD/+eifl
         LVDwrczjZHxeimAS2AxIoGoPx0JOEE8QmeFj2sWc0xBX+q4h7aWlavCHBXGOesBukvsi
         z3Lw==
X-Gm-Message-State: AOJu0Yz5OesZk5B83I29vypSgfBvl+2pfhmhuSJd1nYbAj4neRw6dgkJ
	Ezb6amAHoRM9Oxkr8kx8ZFvK4BAd4Ps59d1gQmRECFjnFavM7xbgQM+q
X-Gm-Gg: ATEYQzy7XaWMtAC8MJDdwgEfG5GlBKYS4fdH4pC86fip04YVFwzE1s+K70XZ4emKzqE
	UYhKZoCPnXhvq+dWI1xAXXvqh+Kua9FDicenVmeXXlgMdwABPUzMaw9pLh9ZKtBlgcnjS14ObzQ
	CbUCZq1tGl4hEVJV3Cisu/vcuqerNTYC40WG44nj/MvkJWdeaxrrXeHpxyHQw64G3/BQi8/XQAk
	3lIiD/fbkuEUBMl6G9xknfV/TeUysryjyeV2Gvra5Isf5or2sRvATglln8XcfeQviCzO8ZoJ5hb
	AGkDfX8Nfu3hqzVUkZjV2eY90DUBm27SELTYuqpH6fQSqyyEtHtL6r7eKDHl0okMGbrc1HDTBgU
	epDRi5rkoWu5je0Wv9GNzFFRoY/AhaUogDSafwURv8KnCxx+ndnYaN4zZvotIIP/9cbLwABPLsb
	dwZqq7ObBOcYMWxQH9IN9QXOysDCvoTHUvW9aASxTmqQ==
X-Received: by 2002:a05:6300:228c:b0:398:9c94:2033 with SMTP id adf61e73a8af0-398eca2e828mr15592813637.11.1773739809032;
        Tue, 17 Mar 2026 02:30:09 -0700 (PDT)
Received: from computer ([2a09:bac5:40b2:1a96::2a6:3d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7400000532sm6814783a12.27.2026.03.17.02.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 02:30:08 -0700 (PDT)
Date: Tue, 17 Mar 2026 15:00:00 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix special fields mem leak for
 non-prealloc maps
Message-ID: <abkfGJw2F_Mwuuvf@computer>
References: <20260216131341.1285427-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216131341.1285427-1-mykyta.yatsenko5@gmail.com>

Hey Mykyta! I saw that you haven't really come back to this in a while.
Is it alright if I try to continue with the patch ? Since it's mostly minor changes
that are left, I'll try to get it to pass CI and implement the reviews
Puranjay gave. Is it alright if I submit a v3 ?

