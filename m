Received: from mail-lr2-f33.google.com (mail-lr2-f33.google.com [74.125.230.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E654E66B9
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364775; cv=none; b=N4/L4Irysvez7VN05wo5qopI1kwfvo+VSfeBumd9BDxkvOzcBHf2Iv5E8tA6PhEnXkGx/IaVahvAJ9BQSkbpgxXwoINDRm/ex5o1INi11ekfDz+fPe1pogyktN4pDqjvLUXVaZMBilQd9s2THEl3QGobzCEJ29Fs2P/vq1LrWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364775; c=relaxed/simple;
	bh=K8K1S9ERuiSvvG6VKGDrUmZzsFAhSAuIeiifb6ecQio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrXruQC1KHUPsIv8Agwh2SE4CvIdEK2ehaWVE36nZ1XEd/6lkv9luImN9Vvao7U3S8yFT4uP0a7tD1GJ1NKGu4ywi3v7dS4kGw3XmapAkK3JF1xRvkRF7ay/QzCNW1MS7TbV8G6s56qZqs9p7KRw0zkmOCscX0vecfM2aN5HpUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWVTJrnE; arc=none smtp.client-ip=74.125.230.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWVTJrnE"
Received: by mail-lr2-f33.google.com with SMTP id 38308e7fff4ca-3a2ff16c0e6so10781821fa.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 12:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790364769; x=1790969569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K8K1S9ERuiSvvG6VKGDrUmZzsFAhSAuIeiifb6ecQio=;
        b=bWVTJrnEO3BEp9fI/4Hs2kIIaaywHPmv5NZsVZKkmyXit8/hrw8AAmkqzIgdMSCZIh
         WLbgM4+QlbcxiM6+EaTjMKvc3AK15Fu2dGvSmLvMvWkDcITR85Ao24nlrt8QwO+Cflo8
         mZszQ+g8UAMQgK3LLnMe/7aZGNpgOiHZHRA18WWJm9zyP94S0rv9sb4lT6p1+XxafXHA
         bniX3m0RJz6SI4CO6pI6byE73r4nu0bHcWlm4PpaO93Di5NbCTVFx5BJSZ+aDvso7ZJf
         2LzCI8cfXgr5dNJjqgQmiNI6VeoGWUvbm0LTMdVWZEG5AsGyEJyYZYFO/gWenYR5Bqwx
         R6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790364769; x=1790969569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K8K1S9ERuiSvvG6VKGDrUmZzsFAhSAuIeiifb6ecQio=;
        b=IkisUxZmmPtpmXF0oiPM4N1ujgez+sLE7voZdoP90BRWJR97CEftt8hVrIxl6Lr2Tu
         x13V/fOzt/+uqaJIpYeocbBTXErh0a21GBM0k25EyiVAPEzNIpevNkc7wmyp5ZTBae/Y
         yPx4cKXHxbJKxVLKC43UQuBXNnmDRoWRDWLtmtGuHd8PrWMjOtZ4jGIxdebLdWrzVpgX
         j3NbmxkGDNGlLz+WQEHuC4UERSzlUA700yhFHMdKrocgUaEt/N/1QjyRW2VARlM/Z2GG
         cGIkXsxJc82oCgcmjYkqBgzPl6QNT9/pLo76KRPOF8tsQIM2W4cEAR+U8dsgZdvXCyMJ
         SCFg==
X-Gm-Message-State: AFuF++lqUBDcBciaQ5ruEI9z3ciKzqjMduh1OqkOw+PHG51UT2/JfIX6
	oL9MJXLarNgkO3oqnv1xzBYo95o+mPwMNdee+l4K58ArrgnwpOBprm7DoN6mbkt+JNkiGA==
X-Gm-Gg: AYBFou2SPO0vqklAFqdjzcw/D5lD6Og+POdHtiB1Z3h2LlotR4I+pHtWrl6tq4E+s+4
	KigeLEjZqcEdxAFdLpsALPaXqR+BnU9zZwl1mu4Aa9PZNs8PUVF2welHkL4KJQUqTHG+9L4zf0T
	TqQfL0VYNoWDEf4QJRZyBUsD2W+NV7feq5tM7npbUCE1i4oBPayxZEvK5vsLUYw93eHsSAltflz
	zVySPff/yzg+DTxnuu1xG7EeJ+d6JBGb6ftULpkoEwfKkDd7RdrQgHccbhaQwrsA08ex8S+jK1j
	2hyKZFLQWKu9fkAzCeJZKMhsZ0bQW9HHy0mbWH7+GPfN3Nq2Ls6UjezpKKtH6R9Pja2PAlnqftw
	antZmftH6adUIQxn1z7lMKHn1j/mQDtT5kAO0rVgQ0Y71z4Say1fx6gOmNSfWx40XXfOZxf/Dir
	J8rAkRh8kPYHYVZggdMQaffUFnlGrrfxKZctu/eFUVZN6uiuNOQbCOOEH9pCxLzseyH/Uc13W69
	6f/KOYVio33B8xM
X-Received: by 2002:a05:6512:a87:b0:5b4:adb1:b25b with SMTP id 2adb3069b0e04-5b8df049ebbmr2324537e87.14.1790364768717;
        Fri, 25 Sep 2026 12:32:48 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.121])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e6afe7dcsm778146e87.51.2026.09.25.12.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 12:32:48 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org,
	Maxim Skokov <skokovmaksimevg@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Check that bpftool map dump fails for socket storage
Date: Fri, 25 Sep 2026 22:32:30 +0300
Message-ID: <20260925193235.48369-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925162915.2CB261F000FF@smtp.kernel.org>
References: <20260925162031.27259-1-skokovmaksimevg@gmail.com> <20260925162031.27259-3-skokovmaksimevg@gmail.com> <20260925162915.2CB261F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Since the out label is positioned after unlink(PIN_PATH), the cleanup is
> bypassed on failure paths.
>
> Should the unlink be moved after the out label so the cleanup is always
> executed?

A failed pin creates nothing, and every check after a successful pin
falls through to the unlink, so no path leaves the map pinned. What is
left is a run killed after the pin: the stale pin then makes every later
run fail with EEXIST. Moving the unlink under the out label lets the
next failed run clear it, so I'll do that in the next version.
