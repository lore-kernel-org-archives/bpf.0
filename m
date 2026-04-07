Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA6B3A3E73
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569373; cv=none; b=o12H1EQRnZ2Hkw2A1Y1chHuOgO4MSlu++DR/mO8CJ2EYMzD2IRQjunPOStVBJfnkoUayxz6Ih9Sah8BTyWcrbIzOkE+LWI5bCp89qKAfiA/CBAaSFoYD/8UUwggj73XdqPnHGkyAWkEGNa3ysJkMGsWmM994cWzvegfrV/bOg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569373; c=relaxed/simple;
	bh=YNlJtimV5JMivSgLjw962M4pD6qXkboi2C22PosLX0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1vyWvb8AfDCG0XtQnrzX8a7MQmKt03o4pW81ij3OCAQMuhoaLfEkuIDIpH6AH9ApVkflxicOa6egQwxKV3p0VJrzFMCnjqBzninta8RU5PSjdCDNbqYUSZFBWmog6/UX6zTW81ef4eEupttw1BqGNHbOL55yIRpyizgN+QaxSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvuNZ+Ou; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvuNZ+Ou"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b0c8362d93so31903085ad.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775569372; x=1776174172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNlJtimV5JMivSgLjw962M4pD6qXkboi2C22PosLX0c=;
        b=rvuNZ+OuKQAjAUlyvDXDpBANfh2YBFqqymRMRxWa2LzYCRlNvgCjYyxlKFZZBLghNL
         i2DmpiIhwWXlen8kV46qAN/Q5hrWtFbx/tXZ7YgUjiqUjhotds185sr109uRw/HfPPm4
         AydQ2J5nCvSDbwuytnImZs7x8dDsehcD9AmC9y6eV66AOPYLHhxD4CZVy1Lfrd+G8Aay
         oa4ol3bfzPAdEVFLGvnGeolmRBMeVKNTOpzTkNIfrfGodWOb2wkgtbIcn4OFiQIKFzTs
         t27sCCOWQCgkSm6Gzn9HGFQwodsz8yoUiWJF+GYSMnCtNxFqJ31dxFQN2t+6fT7vGNER
         SVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775569372; x=1776174172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNlJtimV5JMivSgLjw962M4pD6qXkboi2C22PosLX0c=;
        b=f3vz4PPi9kV+19pMeswUMa5NXkWM094C4rjUCBHLRIwQgpHBwf8Z25pE1P943g2ZQi
         lp0yPgFjTK+6aeemrmW3jpJN5fwIP/6nqd8kFOxff49UduYNJ2KDO8eUuwbUZW2jJd1/
         q9vBH6NG1lXxHCKBOyIfDxXT2BEDtGtJJPFWbqWZNa9T2N5qnlWn8Mf40tpJMDycDxWu
         ytmwpbWRlQxHFq54pOY9TpJF9X0anuQfpCkBirHgSFRSoa3Vt11u36oqVpZZJ+QTZ0jg
         xt66iCOpQiOpUxf2nPnh41k5qnFwHKVVL8aJgUMKsoUXArp8lg+RODvd9/l9UC7T2MBw
         deIw==
X-Forwarded-Encrypted: i=1; AJvYcCXXV/d3EECXZiXYFxWlQ+8EmGS/k8FqHaQJaBhK/VJlu2cxYwtBbQhKjO5uxUqcJT1r/BI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/VZO939vUr6oofeMUj7vN1ni7SHb4DwrMZImjRcqLwzFWQTaS
	syLBTRvG68D4qYnQ365EodlpPIC18yAFJKPyMJEuHgZz7LaOV/boFu6croM3z0ywyAg=
X-Gm-Gg: AeBDieu7k0BqkuocUeQGySoKfNBvFPl3jMUUUF3zoaqJ4Obg1a2ruJ+8eOvzwR+JJoM
	3YKOoGxqwlZEYSv3380QJ7trFZCvC/Rjiz8xq81Aj+bkec/BubAgnr9Jilv17Y94Q/nQZsxFxGH
	qsLr5jcPLHQB5RiqmAFLy4JIEvQnqxeOGLwsgTEeiJZHPwEx+Y8JENhh8t82weEExjgPeW8oVHo
	E1TG0T0Io81q+GjJMsbknn4x8w+iLUSQcKA0WEmDUZfmugehfA7ZsyUabwKzOlzdlAaP+cs8jk4
	g0/OEqTP2xCw1eJ1TZLD/g3HOsj+mo+2ktXS95KCHoQXEXlzDW1mdAn8oH89LghVCNXv8cspbPB
	YrJfBCGtxNz/2lcRyWj7AVbisalXVhU+WH6zM3prJoD+o5wIwjoFBJ/U2lwvRncAm2ih4ewq8KS
	JOhOseKKxcrG+ZG9GFv17swNjwfhh6aGR3Od4=
X-Received: by 2002:a17:903:286:b0:2b0:5320:23e2 with SMTP id d9443c01a7336-2b281855cd2mr189598475ad.34.1775569371901;
        Tue, 07 Apr 2026 06:42:51 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274979d5csm171029295ad.38.2026.04.07.06.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:42:51 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: add test for nullable PTR_TO_BUF access
Date: Tue,  7 Apr 2026 21:42:40 +0800
Message-ID: <20260407134241.78413-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAP01T76uzZvbk7h4TAKC1t0Ls11CoGtj=TvhQ4ur=iprLvWFyA@mail.gmail.com>
References: <CAP01T76uzZvbk7h4TAKC1t0Ls11CoGtj=TvhQ4ur=iprLvWFyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Apr 6, 2026, Kumar Kartikeya Dwivedi wrote:
> Qi, only the fix was applied, the test still needs to be resent.
> Please respin the selftest alone and send it against bpf-next.

Got it. Thanks for the ack and for guiding me through the
review rounds on this one. Will respin the selftest with
Amery's nits fixed and send against bpf-next.

Qi Tang
