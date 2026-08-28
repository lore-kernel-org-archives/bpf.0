Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F8233939
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922136; cv=none; b=mGs+KOenzCuO89LqBjve0aQOJ/5JwRnQeAyXC8jHh5U0K+lGxSVoYsSEljQE+ih2sNk5kADDBe5BsadvFvVeCmELJT4P1CfffPRBemq8eOrh1Jw1MkmHX9JN2lr25BJ7tvUi9ibr55f2YAmtVmBNTgsKBWehfP7KuhwPoeSwPR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922136; c=relaxed/simple;
	bh=QqzBBu7p8nODo/RmFJm1kAQ41J+L+8YvaBuNF7HBWYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0CEHacp5ZOLiw0Dq37ccDMSnmY17383OAh5Kn6hUgi2xmyMWCwd9yAvuofqLhG1ML1pzZxdJJvbON+szgJG2R3qjt3EEPgf0bRYrsuZ6osyM/NnoMxPrTGA/RrC1cWtP3js2kzhdJWHx23P1/qbffYEkHDHeWPj2IzfO2At2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKsP1TlU; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKsP1TlU"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66c70f69d3fso1385416d50.1
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 06:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787922134; x=1788526934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QqzBBu7p8nODo/RmFJm1kAQ41J+L+8YvaBuNF7HBWYk=;
        b=MKsP1TlUYUeUNOdu8V1C9pJvBi81lkXLkE4S1OivElINshuP9DPCx7gJEDVul60aHQ
         O6B8RkCPTl/CJXugP8mwR1OJ1p9m7ehYskD57AhN2ZDz4e3nRDERritZPgjVEu15LVRy
         nBSSaGRzdLC6jxTKqV4u0vJrtDSn3xph1F3hUgPdoFYxF7vkLRnykoDYMNBik2gI0Hdo
         lf2KGngS4ZsxTN9ChjAxBffVjb+DNyb+QTNJN9V28T1YjgIyqb3CULf4ziTeNelTNhBK
         xFeJxN+/grPnN1+fjaQDj8OD7TNyOnM0mfJ4naf1cgSoxicUCvnF8EEiZIsnEijpR/0v
         RPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922134; x=1788526934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QqzBBu7p8nODo/RmFJm1kAQ41J+L+8YvaBuNF7HBWYk=;
        b=GJF08k3Kx2l8T0t5jZgGuVGq2PnwoFvVosekoJkr7SRw/6izS1b8kXtUXtEoZ8NeH4
         XYyNp6lJrGD8znzy52mx0yFZf6V9Y2bfffIyyn/EiWIERcBlidDXUYxe8up2LD3JuDqJ
         NpH0CfVDYmA732mZY/dNEX+4NLPV+xD4ql0KqDvLhfwc6xz3Nu3zjJpfZhaR+vffrqF8
         m7DO+7kCO5GUr7pSAJxz4nWE3e0YYFqf0mbQmmiDlb9O036uMC2Re9PuJLW2bU30vX+9
         K6md1+0yMl8dbEOJX9flMDrn5wJyXF+HReKHjf+dFYdg4gkj0KU8ny6eveHt7EsL84xY
         DTXg==
X-Forwarded-Encrypted: i=1; AKwUvBy7+F+wBxIYB1s4PffH7tnVg1dOyIo7wZzhTL0YM8rt7z4b5AMy3dYnp2sf6GM8jWnqljg=@vger.kernel.org
X-Gm-Message-State: AFuF++k5d4zOvgoxIbOxGukQAlVVH+xSgFUQOPOAXxsep3eiQa76GfYX
	cpDPke1jW58ps/jsceVVouXwuiImrghQmcUC7em3rlYBeOACLwFiTlsS
X-Gm-Gg: AYBFou2rQCcUAGaBFtGNzujFOLgVKWSF2f/t3rb+9kp/8qZOIXDeebg0ZbBIdhVa25W
	sN7GIn/4peiFmM0jW23WIwU0thVr4qtXkPUoERCxJkPGqP8/phhOWJyFVPqM0za4vOMIUozs9K8
	NtUrvIGj2FM975qCcEy+w++bAawss9O0SXAVS18ogdGvmyllP6vgMx+P7Esa4GvPuuNgVbRGxtY
	ZTsxne9WZ2UNbLrm0KtjSkBTxva1mgWaLc43dR6rUntCY0vfVOlgN39Q3q3SMgATnnxiBu2t5Zj
	FtiE/Km8+CB9YWWyrNU6QdXv1DO4pWFFaoEy6jMcEM7O5lOHD6Vr+eGF7DtN5VsvpFEOve7cMQc
	NMWoSfDbqXlNSh49rGnXky75GVnpgyUcrg8KKWYOLmA4wmk2MDSCaAdwb4xBitDFhv2SyvE+MoP
	L5IZULuPQ54pGIpBHxXlBRcDz1/6MVAZjg6hAIcNu48CY2+LQ4XJmY6OciLcGSfey35xCNsqk4i
	d2Tdg==
X-Received: by 2002:a53:c550:0:b0:66d:264e:88f2 with SMTP id 956f58d0204a3-66e4c6eb8f4mr1512029d50.16.1787922134170;
        Fri, 28 Aug 2026 06:02:14 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ed39d4csm770568d50.21.2026.08.28.06.02.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 06:02:13 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: leitao@debian.org
Cc: AutonomousCodeSecurity@microsoft.com,
	andriin@fb.com,
	ast@kernel.org,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	geliang@kernel.org,
	horms@kernel.org,
	kafai@fb.com,
	kuba@kernel.org,
	kuniyu@google.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu,
	yhs@fb.com
Subject: Re: [PATCH net v3 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
Date: Fri, 28 Aug 2026 09:02:12 -0400
Message-ID: <20260828130212.32968-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apGBE3XHKeNohHF1@gmail.com>
References: <apGBE3XHKeNohHF1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> nit: Do you need to zero this string? It will be safely overwritten
> below, no?

Thanks for catching this. That initialization is unnecessary. Would
you prefer a new version for this, or are you okay with keeping it
as-is? I may need a few days before I can send a new version due to an
ongoing email account approval process.

Cen
