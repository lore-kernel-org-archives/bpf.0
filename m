Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795827354;
	b=CRLuVQaL4HCaU0DZeqhrL/wzAsJ59IUJDkn6be3MBmn5Jm4dNgopDc9XCWIkYO3RQzHH
	 gjE8m3Hz80ES8JDopQnepWLvteo0eAh0fCG+aU9dfveHmdcaAmVTK3YTnEjOT7wjrA/8W
	 DI86klGU8X0SXEUjCoQIUAf6dao491+NBAv9ZcLdMmSFt58A8dKu1g/N7tHy+N0kCeKvE
	 GI12iKm7wumIy1innZL0lub+RaJV/pF3g2R2LaJJIYc987gucA2i/M2Hxp7dmEvrnYLaP
	 9Lj4lA8YptufwB8EjI8vaJB6M7p/wCf7c7pxn5xyck9fztuGCxHKSks2/5PGI9a/cLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795827354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M4YJXz2C1qqMpFfvawPlwYq2ZIDKs+0ke0HB93yAMqs=;
	b=q1gwd9JxJlx8AChxB+WM2P/XQr+fliAh4dx5Dg0ByLet41mYBYg3cYe2utx0ZujZPWYt
	 lTNSIITa4QWqtgvCvqZopMwPiG9NHuJRmThj6fZpEQeZ36629di8LaDrO7jlLLp/G2NGl
	 cEPZwzpAv/VaEpbwroKIJuRqXXp0+nB0TNq80b+yyqTxvvXhTrsNznmvdVZVdISfv0hFp
	 CKVrX9wbJo7Y8U8d1u9xed7Tbn0xhzFZO4DUlW4Ua7arUB3b6eKgTFeLeCqTSDpfeDr/K
	 YbYiQ/DAPJAPIQR5z3TxoQcFOVZuOqffZkZhdTbx20XYm4DxZT9K8FJ6kufO4fJXpww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=egc5oRyU;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E80606A327
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 00:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4E80606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=egc5oRyU
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso105798815e9.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 16:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795827352; x=1796432152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4YJXz2C1qqMpFfvawPlwYq2ZIDKs+0ke0HB93yAMqs=;
        b=egc5oRyUW6VFDIcdxYwZDeGVcRPdqVVcw0/9bUs8kD5ZsjJsFc0wc7Ij4lq+IUwayF
         w2XgNkLL/plAb0xjtXjWDmbgHsj8BbN8y5QH4zabvGdDwwb8xzCpvOiS/FFDQ1pAmNwA
         4uiU6YjDORB86waZuFacytNoIhdLmWlhX93TlunzFDHBxP1tk3JWqemA4JUyNxNFOtfh
         CKwdIz1EOzEmUqFvrYxqw/6yXUkip8rv4zUWrx4HDc3q++gCUskaW4sXZoxU4kXNS894
         nnM8O1l8kivUFX2WTqpxfjbMSvlGbzGIvqyGbP1cvEGn8taKbCLd436XionhZ+TbNkl7
         Tb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795827352; x=1796432152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4YJXz2C1qqMpFfvawPlwYq2ZIDKs+0ke0HB93yAMqs=;
        b=YYqbVg6vR5vFduDDwCjMAnF8OuTkTqhcAs/8GacXpOx7jPr9XzootDr6jFvIj4oIZi
         5TbyCRGRGNxf9lsCSb36990AoDASC6P5MGSc343br+VBsqqTJ6vi3Q6DBV6ZPFivJTaK
         qDXZ/9GC7B2aQunW7AbJpZbMSAjybJVfyVo6L8Wtua+58Yft7Vpc5s2S5TLSy2Z5Zxa3
         dSpvFAK/8Z1d8fu7/htfXizGmPBhMSDc1yPvX5dMlaLiQj6rVyDE+dFZiKIokuglJ1+v
         2HfJfLv2AHUyfZih1OXNQnsxXPfP8Xd6nCwpyEEoVrkifir/PlPk70HhcdtemjNR1sef
         vXKg==
X-Forwarded-Encrypted: i=1; AL+hErFgJrlxSRfW+fPHR2k/Svy73umggNff/QQpdlW7h6M7Wzf/lGIbZG5j7M1hoKEu2qcsstg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fnR5HX4bpUuLKk3EH+DN8GuK5aWZ1+FlXKyzwUxkwXJWc07iG
	Msu51LpVth8tig10Dgw56C77QuEF6h1k+N3+I4rU5uBBp94LGIXREDgXIRbP5V9Z
X-Gm-Gg: AZFdTZeQJxD6kbJaH8r+4ukNdB4gOxVryirXrJIKjzJoh+Ik4Uhl3tzmv5aDx9EZpRG
	VZdbJRPZ8cUmA+DT9e+IxNzDtjZsaqS47R4dk8djCk9bYyjGyfvmM92jWJ7jGoTH2WboPupyC1x
	nD8U09N8lFXwSA3r0xuxX0PI1aBhvrIYJay+8jtg3oQ6INKZ9sIrRJude2oSHri6X9RC7MRCEPx
	cHp6uS0q6kMIgtIbdinlbbDg+w8376sbIibtup0nQe3IoB+fl9CkGq36TOiJ9Tazw3MH6hMtN7q
	4QpkxnxcUgrc+9jGczWzrtFG1XqkJVbHO4iykkeuPRAW9qvoIbxNFzVUrM5BfH/VWtTSvFlFNAY
	UZOSsnF+iRIzaoIWxukE5idC4d8uIK/3dmXG+2c8AcP18fkK4biU8lKcAiDoUcENXMiKj07GP4G
	h7be5sWV2BedDjuPYrlc8gGVTfRPI++8oXni3+Btg7e5Wuv+frolKUdP6q0ruorkN4Q0WdZvQAz
	YH3+ZUYULYPoJ7Bw8uO4Tpd6h1HT4384Ng9/tPpfmFq5hwm+tJGCIE3tP9bTK9L6kR9HNcyQTSD
	TGpXdZ9gN7bzEa7x2iyHufRq9Q==
X-Received: by 2002:a05:600c:4e0b:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4bb8881ae90mr541218935e9.32.1795827351797;
        Fri, 27 Nov 2026 16:55:51 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8538b09bsm1328407645e9.4.2026.11.27.16.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 16:55:51 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: jarkko@kernel.org
Cc: aleksa@amutable.com,
	alex@amutable.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	containers@lists.linux.dev,
	corbet@lwn.net,
	dhowells@redhat.com,
	ebiggers@kernel.org,
	giuseppe@scrivano.org,
	hughd@google.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kees@kernel.org,
	kpsingh@kernel.org,
	lennart@poettering.net,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	luto@amacapital.net,
	neal@gompa.dev,
	oleg@redhat.com,
	paul@paul-moore.com,
	ptikhomirov@virtuozzo.com,
	sergeh@kernel.org,
	skhan@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	zygmunt.krynicki@canonical.com
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
Date: Sat, 28 Nov 2026 03:55:41 +0300
Message-ID: <20261128005541.873229-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261122193539.3334213-1-jarkko@kernel.org>
References: <20261122193539.3334213-1-jarkko@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jarkko Sakkinen <jarkko@kernel.org>:
> Work on this feature started in 2025 after reviewing David Howells'
> container object patch set [1], whose underlying mechanics made sense to

> [1] https://lore.kernel.org/all/155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk/
> [2] https://lwn.net/Articles/1102593/

You put wrong link in "[1]". This is not Howells' container patchset. This
is Howells' fsopen/fsmount patchset.

Link "[2]" seems to be wrong, too. It is not something "earlier", this is
very recent LWN article.

> While the patch set is manually written, the original motivation came
> from isolating LLM agents

LLM agents are too strong for Linux containers. They should be isolated
using VMs or using some Linux reimplementation, such as gVisor.

Bacik said that he tested his patchset in Anthropic. But I think it
was tested not for agents themselves, but for something else.

Anyway, I suggest to drop this phrase from your cover letter and think
about some other use case.

-- 
Askar Safin
