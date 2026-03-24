Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC763B19BC
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390159; cv=none; b=KHTsg6ibpl9y4/+uRzWUAsEQEWsxa5UOu9xYGBxHlVDonbYPXtBs1TinlWghCu8R029/RsrTlYnfs+Sv2NUjUdg0eHxuBjkXGo47bXotwElsABy9AVfS21QOUHg4UZFSKkjwefaVf575J+xqxZ6B2XnliUX3Kn9CmeAWvYLqLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390159; c=relaxed/simple;
	bh=7vKkBYwCe0nZLOJaqUqy3huVvBWvizJCtj6drN+3kj0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pjJ4u5AUOnmb/VAALsTmALZyhZ0jXfJir8/AosbJbLCczMLLitALHXoh2P8mPPnwhQzd6BJRUAWt9yYtWkrtKD7Ez2p0SXpViU4+bizdvBxcwB+UldEIsAOTCB0RUmNIcFU5lUIp7uWqjXj2Og4/aw0DEhk+6uqg8clGgGJEaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3SBn1+s; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3SBn1+s"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-128e4d0cc48so5206681c88.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774390157; x=1774994957; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7vKkBYwCe0nZLOJaqUqy3huVvBWvizJCtj6drN+3kj0=;
        b=F3SBn1+sT1XmB9qNTaErJHn3AElIExkDPeHEtULN6Y4XINvIAbEPrI0J70l8N9dIeW
         Q2qbYyTlnG5ZwYiN6PudrmmHEG0TAGndX+FxtmKpl3sY+DLOaR4YmpX/U+1tiwEq7F3u
         y5FgExxug4S/JtpqveTl++t9ENAIvnxgyx78MH2asCx/XduihR9BLxkqfPUGn7cy2p0p
         fnHZIJBmt7ZsOvyfrUDT/xXPaB98NTbn6XtanHIGa2emtbOqntEcRwNLQEEW/tjhPhrq
         tRWJE+G8/IVZZyiIIBDiE60V6wb28faEcRVmvjT0+OByLgqfv2XLS++QiFtbKDBC460V
         ZhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774390157; x=1774994957;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vKkBYwCe0nZLOJaqUqy3huVvBWvizJCtj6drN+3kj0=;
        b=cKJ2RpajJVGnJzr9ytUqNTmGc/qzKu/UNsfYNiL6+VaR3+bfq4Vyp65afABTveMY5X
         isVA3X2MRnsIYRYiaDwe7/DYCKKuNyXRG0YKeMsOFawf7VQz9ECBXPj4IFTj/lU4aZqc
         NijTC5e1/6aTt6mIyxEssvrCiOAcvT8HoOIwh6RM2zKSIK++h9cIRCCWxEo0Uu6ltg9T
         VUf0vJBxmzzzXQlGCE4uZLbHkrd1Lhp5X1WylAd7fCBhm5ZPk6Hh6NetyDjeE7QLYT7v
         HghvFuWeru8VKqN0tLytNqDwFyXnUOdRIhQIHGiNwi6WdXj+xwZdGf3RggR5N0CykkPZ
         NXrw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Z4cWSwPsdzpui4pqLoJSTRFssxwNBnaKIGJdr2aJtaJaXUWLNlXq5/EgGzBGo9DEVb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3AeX4AwKkYEKZUgT6PK2UKbP52JBdIwDj226MyGc/g6LH2dk
	6Zfpj+cs5omQkOsnnQdkcGUoOzLeqEoAKvhtABIV17Xf+zE4KtS8mDx1
X-Gm-Gg: ATEYQzwuoit1xGi/fYMBQqLBltmZlDb3gKMYoTr7IMAsH9DPEEA9duZ8OqCeVOzM9Ir
	SG3EnT5IYQ31+ajUbqY0iZxu95LXgRJrrzCRnlYGEzS1rRJkz7lf5C9nA7bY4Ir+v+770CsnLtb
	GrUGaqG2s4lXMGgPZqQW+NW+USBnLp1tJdsP0KqGu6zsltWgeUy4boCIhSrIHWeHLyiqdk+cY8a
	ODCg+SWmLiPMvLd2yNWxXyPzR1LJ08gGB6H/qwbFrWpE968rjuLPny06+H31wdPrsNK8HuFuyTi
	Kgeye90QUxN/PXk6n1O2tKN8hlWK5Qx5aAwTQJ5CC+se66VOup+UcA6/Ku7jdBf174EOKkvYxRw
	AWNIhdq1A1E+3ZYTMwNPnkogU3otHL/7X+ih8punDtqkgnug2POlYpLyxvKgQcgVuPz6eT+q9B5
	azQySRF+ykDEC8yamdvXAP1Eri63bFbCrRlpopgDzM6g7Uwco4HgoSByct13dE4onY7Y6d+N+nr
	uTq/w2t4sNEalNl
X-Received: by 2002:a05:7022:510:b0:128:c77a:6c8e with SMTP id a92af1059eb24-12a96ee761bmr570587c88.28.1774390157333;
        Tue, 24 Mar 2026 15:09:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:41fb:8dcd:b77b:d6ce? ([2620:10d:c090:500::bed7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b8f2sm22083304eec.9.2026.03.24.15.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:09:16 -0700 (PDT)
Message-ID: <8c907a804b9a651bc04c326f6fd1a110dec78cab.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Test variable length
 stack write
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Tue, 24 Mar 2026 15:09:15 -0700
In-Reply-To: <20260324215938.81733-2-alexei.starovoitov@gmail.com>
References: <20260324215938.81733-1-alexei.starovoitov@gmail.com>
	 <20260324215938.81733-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-24 at 14:59 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Add a test to make sure that variable length stack writes
> scrubs STACK_SPILL into STACK_MISC.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
