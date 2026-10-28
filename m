Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153713;
	b=Y76LqXJgoTyIYR7cBueezGKFWbZ48qs9qfggD4ttnis3U1enR7MxqmKflOWF4FKIEgKG
	 3AWebEJqrnHqPEBcIlptk4/lstuFud8OEsxc50v82q7+0S6ytwoXnFsNNhii0WWg1HiCG
	 xwO1E9tDfYWD8gNHW25T6ZFr2MyJToDkwEpJUSNFhSF11nPDZ+vw6uZ9CrzadKO5+jDjK
	 CpvHRsiPCa707FnVpQIgqxrgZ5nmCPmBXZ9jOT4Aa1OT7zJTuYGHIZd8o9STTQVb9+dkQ
	 F5gOPtvnRjIdNp087NJAjN7dMy0gGYfEIBXAu0FlTuIGOeBXTzzyUrP82M51RMr+C6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=4RXr0eZvl846M4lb9Zzrqm6kbJUwTNifrpHwF24NCYw=;
	b=W6AHiM0at+OBwUI0sFFVS2Bqe69bftLiX41DTlD5h7zhV4hnUO1e5Z+JJgAr8Kn4/KS3
	 kZ3hJGR0wiumpfGcUCxRSG7qPzfK7RAwdLVsFm+2MRe7xrNB4VvB4AxRp8e//kEIN+4i9
	 w2NDhoVFqF/MpW9k0vhIeCQWTMIxNiwd2yaqE4mM3tzxM+UiPkwOPLW7w+Ph2odq0v+YW
	 jjutAOHSISDRtrSvdSuWHBZfJvPn2XtHGRoIvCrFfJeo/Edos12vNlPXOZptuRCdx6gfM
	 +DuC96dZYxNjCHv6b3apGiVFr/UA96h/bmUEzn1FpOtnKXN4OJX5Y8RK5ZR4F+PFkfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ll1DtTHe;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989AA606A326
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 989AA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ll1DtTHe
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49814d35686so163605e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153711; x=1793758511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4RXr0eZvl846M4lb9Zzrqm6kbJUwTNifrpHwF24NCYw=;
        b=ll1DtTHe+GRnK+TDrit+tPe4l3EqUyLuTX749h1VzgjiS9k4H+CGD8J8cNFmVBc4lW
         AftsytEH+BWw7/9V73kf9R75hwC2AHe8t/Hu5yqsSSOKJ4GoJhWEpM2F/nIeMoQR1/qb
         kN313T55rG/BsPdAysuuXfh8gw3vz9E0nJbNQoRED0rQl/W93i0AbcTWo/lewq0D/Ydc
         YoFZQUtSyh684xtDOfbnAfSNO1Ij21IA1exUC/U9T21Biv68GrpMsbkbYEQc9yVrQFXt
         0/SGfr2Q9HJc2NwmGpU2GgnVvqfcnxOy7W7dMuA4hEK8cS3rF3YrWiS6L7LYnBU7jmv0
         SV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153711; x=1793758511;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4RXr0eZvl846M4lb9Zzrqm6kbJUwTNifrpHwF24NCYw=;
        b=vfz+SCSbh6d4eZrplSDa3YkW8d2UrdCRDWukcVaOW3xENlgTAeEo6m0WyOwB/CFJTt
         IIrY0QvfkpgliBe0NIZTk8yyrFzIZ26VOrixsKYQ2RZuLf0ePE6AyU2w6/wF2o2SPeS1
         7FWdF5mf9aD1sl1+YAEzwFoD0sn4laSTU+nHompfVP2aibVE+KOLblXSD1m5EivY1hnP
         7iqUALRa9adiqHJS1t+9LO+6HrGu3GHqx/QdEEXwI1pPVNEWmWyBZW9A7+wOrTuXPEvI
         W3hEilyktTtZNiM3p9xLx4a5PaELqAAxUc9AuP7e57hOIySpCHXoUT83zh8yUjwmqtAi
         T4nQ==
X-Gm-Message-State: AFq9FYKFY/md86YgbjBfafGPm4f5MmXFLtI3YEUw/j7W+0olan+KqvCN
	q/oYIeEJ6BNR689DN7NZ8w+I+7otrZMUHsRoOIYCNjWQFr8gv8ierKJx
X-Gm-Gg: AYBFou0qlb0KbTqjg6ynxLb98E/UR92Zam3gnQt9R73bSP3Jtsmx6LGqotLUCr+u9a5
	Ch+divB5DNgIA8x9TT/OB9UU9O7mHe/QKPySaVehetoP7rBtVZppLSJmB/dD00Cwy0jJovRILiZ
	g/RsPtHMFl6uv9ICwm7h760Mtmao/dM3DjXS+kXZbzoQgeN02LQ0eCqB7dLrDBQE/0kpJg5mByL
	9HVoW0uU3PU91hDv1DVOHnnVJdJ/vNES9Nuz476usUgAWN+gAw1jaARwBB4Nokz2+4fQSWa+2TC
	+bOgEPdnQqe7xiDBxoKiC1GNbmQkDAKZ3zzjcqHXo6YCR1VToHsJx3JK+ejeZdhnDywZP1/5G5x
	1UW345dFWLZmoih4Iaxd6PRZsgut0ADQ2w4mtJhnx3tXDiF03+aB3FljwY4dEkTjlZjsd05oBAM
	5iaAsXVJ3nAZzy79UbfQeTn5uc00iHBomOUayJalUxxT4GBqyxgUVtm62/ydmkVXv0cLoVJIttz
	yCS+mMuYQDaJHRroX7i46ui+k6/RoErW5KI2AnpQ/Kbo+BvKGL7VfM1jN/lxHtrrFjuVrTUcZXB
	cwar56HiFk6MlnW53RtGAGBqtM86mWyHaiNiR39m/LjTOS+OKedcjWYSjFjjrF+y4WlzGiX1dv7
	5ihq5mjhsMt8Si+v7EMIoIo13QOByEkidm4MIBCAQIwYKiRlfbV4Y0CtzkdB/Ofky7um9ixgfve
	MaGK0GZHOIAX4mjQ==
X-Received: by 2002:a05:600c:34c9:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4a9965cffa6mr7755865e9.7.1793153710887;
        Tue, 27 Oct 2026 19:15:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a977edc0fdsm10880365e9.5.2026.10.27.19.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:15:10 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v1 02/11] bpf, arm64: Let the pad after a helper call have r0
Date: Wed, 28 Oct 2026 03:15:09 +0100
Message-ID: <20261028021509.1203900-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-187299@kernel.org>
References: <cover.1793147364.git.memxor@gmail.com> <f86599ab5644a86943345b2650d1d11a0363bb6f.1793147364.git.memxor@gmail.com> <sashiko-outbox-187299@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed Oct 28, 2026 at 2:02 AM CET, sashiko-bot wrote:
> [...]
> [Severity: Medium]
> Can this leak ctx.landing_ex if multi-function JIT compilation fails between
> passes?

Right. ctx.offset leaked the same way before, where x86-64 frees its
addrs; the next version frees both in bpf_jit_free().

> [...]
