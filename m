Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262713AA9F4
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697370; cv=none; b=CJveOeZaBeXyMY2rZOVMFz4VgJMPJMEC4Ow8odjTAv+AkucLpANYM1bjXsmrBwfYaEu5jv1ZZv+O2MKQEQHY2QH7s1TrzlJqLkaQz+JmujbuDAnWXAMCHbRaYJS0hRA+752V+86GdSPgQazr8skpHv7iGBTrfGvmLhNrDAXCaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697370; c=relaxed/simple;
	bh=+TqM+PtcKsHz4Xzb0T/t9rjYOVVf8Wg55mJJ72MLd6A=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=JMGkDQsLTCCwgXfBGTLGvm9h3S1FIMatLxl5EW/C20pbkmjvH4BHYm+H74ogSP200KNJRz95AiGBzH+QPSHzrcc4xxeL3HqQn5obtxz5c60WzEX4PbRYlYSphWO3X6A2BRpUDBInjOLlk+7OZD9WNfCyzmJhaEBhPi3jw2tXHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZIKMEq8x; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZIKMEq8x"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-90fc979d84cso76681685a.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697365; x=1779302165; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmWhw8+BzycLbCZdUGo17yGhh7wc4olKhqN+RMzekS4=;
        b=ZIKMEq8xkGrjNG30QC3AIMbJd4ZWWAHLxvfJ94Q6RCyNGZd9fwLroog1punB40QvFw
         h8KizRwT7DCSOqhahlu5AoaV+rubVpQRLjun/HFcvoTThml4QjLWlRQoJ5hnpDsmTHE/
         Gv5QJwFxNbvZpBjI46IdVB9Aao7868mlGoIKkjM5khsE8oQ6T9Ln5Zg9TYWPUXmtcW8V
         vdYwMl3mbr/4A3Zr2aXuX6gpQOzHHZ/+i0IgjYz+Y0zCB3fwyhxIT0i2WmCRsL6dOeH9
         /9fDED+mzZLL5XvzHn6CW3wb7jj7pt1a8irMpLgDj7cT9O0VSwV1DbsmhhA6TU4UJ0CJ
         EMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697365; x=1779302165;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmWhw8+BzycLbCZdUGo17yGhh7wc4olKhqN+RMzekS4=;
        b=AkCs7TBEdVJPZUIWVXdAitfeunPRT+7ocDQSueGuozrnD0i5jywi1Cc7KE8l3oBv67
         KKMXTppWWdTI4QBjSh9lnForf/TlScpkC9j83QE6sN+cFoFtHgIfx2D631lYa/M+63Lv
         AqE3hWPFp1fuYGD2Iggv3qTUUWfyt5M/j0Rc/6GI5P7RYL6wMyZRcxu5GdGT7AScFUCe
         Fc/Zy5yu7IKkRpTdwIC5+Y/CAErZ4SWHhERubiMy43QlB1oYh8zDTtejFXBqHehMoO9o
         fealtbEUid+IE2C5kcmbQJCwas7PCW4y/5q1l4aJdzGI9AAjdQJO5JmLcYfWIJTbrx5n
         WNlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/oluL5cAxIofr0ojsmoKyG+MhxfoxU7kQ66uSR3JnAeD4iwpGK8KFBEFUIOL9qBfWs5zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfXZscHB/qVjpHrcg2kkGUTJ4XmLxFYGUMQYeSdzYStuRYNqfQ
	ptX+Nr9ar1WOIs+uHzy5h8MGbjC6FyFo7xhR6Vg8RjjO30WS7On1SZrWeT9UFgPR4HtVgtXRNSA
	HhfE=
X-Gm-Gg: Acq92OGmoAJ2sTV6Dye9qxNyLxfWEclNEwZzWgVs0hwvQR+uJCBCO/bJazKFENKMT0Z
	G32h2re6OasEJoD67+198v/r99CLoC/KO/eB2JDx7qQ6oqh6I9Yx+AjUeSlpscSxZIGkWD2sosd
	IP3SPbnB4M3WxCo2rWBHmXAPp+xar1GLs2h0FQ6vJ+f7TYZzVOa5tcO1iuCN+LB6PmJfmdpxTud
	oZLeMoAoPgYy6kg57NZCI0njd47wPiDau+4+oYAldnT1zf78exumzebYff98cnlEY9/aG643ktl
	kzt6Oc+BMmjdr6CGsiH7I/E5rumwHDxy0InFBrwtvmpgaGQ9NviMHCMqrOGqgW6J3vu1J6vuix+
	6y1uqB8JjKX6zwYGKHip5sUccVFcAeWFnyBXXM7eK2gCblTi89Rc+oEDKaL8m/Gjsui2GfFq7F0
	QrofT1b35pHQF8n9Q1qJymt0177k/ywcu7L3X7sKUmghzwVHCC+/9R1KR6LN/Z9+lhOYyH
X-Received: by 2002:a05:620a:290d:b0:90b:9dca:2187 with SMTP id af79cd13be357-90fad385651mr655950285a.38.1778697364951;
        Wed, 13 May 2026 11:36:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf3732dsm28874785a.33.2026.05.13.11.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:03 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:02 -0400
Message-ID: <64548a3cec806e2080ce4515777b4a39@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260512_1604/pstg-lib:20260513_1343/pstg-pwork:20260512_1604
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "" , "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Andrew Morton" <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, "Fan Wu" <wufan@kernel.org>, "Ryan Foster" <foster.ryan.r@gmail.com>, "Randy Dunlap" <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v7 2/10] crypto: pkcs7: add ability to extract signed  attributes by OID
References: <20260507191416.2984054-3-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-3-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> Signers may add any information they like in signed attributes and
> sometimes this information turns out to be relevant to specific
> signing cases, so add an api pkcs7_get_authattr() to extract the value
> of an authenticated attribute by specific OID.  The current
> implementation is designed for the single signer use case and simply
> terminates the search when it finds the relevant OID.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  crypto/asymmetric_keys/Makefile       |  4 +-
>  crypto/asymmetric_keys/pkcs7_aa.asn1  | 18 ++++++
>  crypto/asymmetric_keys/pkcs7_parser.c | 81 +++++++++++++++++++++++++++
>  include/crypto/pkcs7.h                |  4 ++
>  4 files changed, 106 insertions(+), 1 deletion(-)
>  create mode 100644 crypto/asymmetric_keys/pkcs7_aa.asn1

Merged into lsm/dev, thanks.

--
paul-moore.com
