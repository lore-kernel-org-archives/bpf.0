Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5C23B8BBB
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788734054; cv=none; b=HDJHEflk/fw+9Z9FPDWF6pzV+ulTi4csz99e3+yKmgtXHRxXAfKknqh+HutO6qxEnf5CrdouMzg90NFpmGK3cw9odL2QHyOdM3Q7V23oPBqlEYTGm+L0ZC//YSvmC2JUSIYdXuTiREV7LGYE7sgyXDBaPOSAZTxeQ/i1OsQMEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788734054; c=relaxed/simple;
	bh=okvJ6MUhnWI+E7FimIXZxzgRJVCReJSPDgX+XaGLlzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GIzanu9ylQrsHXloTwkmS9YcuNs7d2dmgNK22cmvDXi+77MxHuWzhrFB3nhAUhNj1ebU6zpYOzm9HebAQRQKGFlwYbP1v4Jd3gxJbVSO9xy6dwtwLAZ5mJ8vLMuerZ/1sFeTba8XWZmHW+QkVgxdoLdSZn7nJY6vG5/uFz3rzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqfKEdp+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqfKEdp+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b0eab380eso25695495e9.0
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788734051; x=1789338851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=okvJ6MUhnWI+E7FimIXZxzgRJVCReJSPDgX+XaGLlzc=;
        b=mqfKEdp+nW+9PSuCpA7jvxUSRg42G9LcDOFu5y0PFb7AX4EChtT1R8WJG27sJJzNrn
         Wn4TCPERjxBpXS/LonVV3dwC2HpRY+qwkGOZacfX9qOTa+3X99lQ+sYzhtvsElx54KPH
         Y3YzjLgFh7yRR5YFxFS6tDbCpJ6Njaw7O2Af1P14NFIYZiuymzhU2HKgrIbZXcQyhOAv
         ibccAt0Xw4C4AaaFulo9y4srYevs/qQZLJE9Soa7BnB1YhpwdzMmGfa0TwadxhUiaRus
         G2Twp2mdcVB5Stm7/eI/zZkrSUXfIK9gt+AQIsQxhnBNTBwEqHSed1d60ws1v6WqGWYU
         QsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788734051; x=1789338851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=okvJ6MUhnWI+E7FimIXZxzgRJVCReJSPDgX+XaGLlzc=;
        b=aWsi5Bq0jJVdPGIgw81nTa/O57SfWURo8RTaJtwa10IqsD2MjJ00pIPCQ1G4hCNoaU
         KQq/qgJZ3LfhgPr4CKdTOsP7KI1FYzvyrlrBaRxL7wt2h642wJ+LqvxJHT2480OCDBOj
         nai6833S0WQnI2sfc1RdNwtvH1r2GL93/3hXLQpFl6ZpAET1mT95BhjRPal4K1PQnroe
         6Hj7EBWfi1HMQI1bTxZ+tDTAML6ZE40rsVrf2yx3rGhmucMz67yboTfUjoijxKh3m0Is
         a9SMDoTMupX6FsnxJgzJkMxjPqfjzGVE/8wYjm2nfdlDeqq1Tcji7CXJZPga55fpMT6I
         7tVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwaCHJm9MCJGWw/fgRda4y0eqlpdeDSECPDV5ezD1XbnEbuXMZKhoKNUylrPFnQFyrDn+c=@vger.kernel.org
X-Gm-Message-State: AFuF++lRS7hL3ejAa+ncoM0TAVLfsf2VCFaWgjgMpJ36l5ZoPImFhNrl
	XNuuqA4VE+RTgzgcojuPiFG8XZVV/i8EOuK1sVTfL9zwOr47PnRSxgrWc54pTP1Y
X-Gm-Gg: AYBFou0/UHFGPzE5KXWV/iZLIwcxklu6K6F0U+rM6z7lyyQL1d0oU1cYXUnoi7A3T1p
	HatCbwPX19CMtiRXC1VcDhkGRUn9g3Gv93OFq940K5nCidH2BKsMNAWBjwandDaEF3qxuvYZutv
	NGwrY7bKTpBcBcnYAO5aOnv5OCe410JtP865xGLdRqbSjp/BmpR9+DrdTivd0UKuzzj4kiMOJsP
	JS3evLWcp3oas1Giwaz0zscgaNGRqS3sd3o+Z9RtPd1PqPBhTffm0dInmZQOYN6ahTRen3SkYac
	IK4npzli4Q7VQmLfzwNt0A6uOTWEk98qT0r+OUryndy1jYTXwDp50xGL5Adn1EFv1faaULmrO0Y
	bhYREQ+16kqgU06xnrCV8XyYogzqD05L48jtys2Dx0uJz0jrSPPvDAi39/E+rCjQ5rsEC3eZ79j
	VPOHtZ1U3hwTb3Ce/3xY9+zDWLr4F5kqKNIo0PvtfIUOG6iJ2vKjWjQ9k1RczTScXapJr0K9r1r
	Y1GVHXL9wdW1iFPK5/c2Oytq+VNowAlTCLVr1HdrSV05OTeg9yETcOSg3u0uBemrB1zlfLPKREh
	jxiaueX6Z+BOom4yMh7ZgaNQfFM3Fxe3fq5/838Xij6H4AN4YiJGFc3IDlk6lNoH3e4=
X-Received: by 2002:a05:600c:5397:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49cf82cba17mr169598915e9.4.1788734051512;
        Sun, 06 Sep 2026 15:34:11 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de. [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm587151185e9.15.2026.09.06.15.34.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Sep 2026 15:34:11 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	bpf@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH bpf-next] bpf, docs: Fix the struct bpf_cpumask name in kfuncs.rst
Date: Mon,  7 Sep 2026 00:34:06 +0200
Message-Id: <20260906223406.3528-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905095527.42261-1-kmehltretter@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Superseded by the combined v2 with the btf_var patch:

https://lore.kernel.org/r/20260906222656.3459-1-kmehltretter@gmail.com/

Thanks,
Karl
