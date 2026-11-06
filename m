Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964781;
	b=3KozAyeS87Cu8VDXuZr0wv3t2EEJNVFg3+BHfgFt8QADEqn4QoE774eh2pdib5n5hgEZ
	 4uSvEktVd5B4jRJEYPo1SVxx11eHj5Iqmzw8O3kEqEtO/TG7IWI2zs8TkZZeytWbbIcgy
	 ojGdPK4qoftC2pzpowBPMG4CsgFtn+N2kpH2kYejEUVAquTxflMhusctKTEX9i/2o8v81
	 zpjClo3sxxZyGeNvtqtf7omr5M7my/ja4IRXtv5dmCQM/d9N21weon3uOhzTZiYwwUIwN
	 WzNZEeGK0QDw68D1tEz51futuOcFNKOR2IpwHeGK+ngENgH4C8WIC8SABmcgqlnBqag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Nzh7sCzVLU1Vb7ZGY6Ft72lyczAGmFqvjOfkg3Fwk8k=;
	b=AhsK2YBgXE24WW+FbfUHntTuuCFRPJpx/BJyf0cRYHtqBPYwfi6vFdGP5qfV/rCKdQEC
	 psEBAiA9MLxycnVtbWjIbG9pXEXxY//XBRw832SSpRh1q5T0Mqtu3L+/7+ajHTprXjwrE
	 mrh6N0FM4Dennzs09yV9f/uK3VLu8Oh13C0oesiJjTwZzPyxe1nqMDBsBEfBzG7uwn+/a
	 5exbtC+poxhXVN5oHMXqLyiQ/2oYF8Z7WP3Q1wohFQCSAT74hat7V5S333ywkzrlABAMA
	 HktwS1ygnJp9Z4d6S7esOqlXCGSr66foWHvR+pH8kqCrsqwKUrkCUDTO09P7vdIvtvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oGw8bPug;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D860A3821
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 11:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 049D860A3821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oGw8bPug
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso4329975e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 03:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793964779; x=1794569579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nzh7sCzVLU1Vb7ZGY6Ft72lyczAGmFqvjOfkg3Fwk8k=;
        b=oGw8bPugmHcN6mPqHq+3d9Rsb9MiQM+ozHzT9oATnAygZWmszkg/mWNy7tTKqjgQpe
         Z90Efh6jtFUl/LAMuvCsWHB+CltQB3R6JRQ1cYD3it7URk6DraxQ3xnglzLnakg+fVip
         oHJ7evIRXtHRKSO+mn4xyvmHoVce7xN8BncEqxHFZtDZL93sWsUXLJ0FUizGeDjG4yZ7
         oG0TckvSYVUxBJZsygecbrNU96ujNWTcot24IrNErdc//dLTHPSVewvDv4f4cYrGGji3
         4oA7qjTUtkslo5j37SJJvxQRJY99VKjDzD66ku6VeEQFYBYwsBp7tdZQ7zbiAFtCnKBo
         6vMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964779; x=1794569579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nzh7sCzVLU1Vb7ZGY6Ft72lyczAGmFqvjOfkg3Fwk8k=;
        b=25Zplyms7XoQuMwH/TD7voZ4m89SKzIso4SXP/xAeUH+IfjI1wlf0mn45FVw2xpuk5
         /9om0OwxImqmeybTzDe+wB9dfK2L/Vqsf3K8UiR3UaQ9dfA0E+LmcqEadeDG77FpIjL5
         fxd7BCTL5QpZxDorsxF5pqCoL0V4/YairJREwWPyaetXqPYlhBYp2U52pJZDa5PO+e2C
         zJW5SqSXcQ0nG31n2CFjEDfnJfXl+qJpdb1yA+mp5LqdCnxqr5GU9CSSoh51rFm49vEK
         UPuAct1z+9ggVv5v1Hgk4l2G2NNhDPEgaZnA61kT1MrLzfxY5T+CWDYo+vsvNtJBCija
         jDuQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5+E8kO5cdVNwE3KAb3NiwiWsp0Jx0P5nVYK6vRRexir7zKK8UycJ+6/hjFwiRrINtPek=@vger.kernel.org
X-Gm-Message-State: APuU4Z/skpifMjVX6geT8uG7vhoirWNCqFyFK3aexBvO1uVwTBeOTt6h
	CWgoEuIczYpkfhZEz17XMxZZu4y6e27rbliKG5iNaLkkICTJ2m6WAAuX
X-Gm-Gg: AYBFou3V3nM8XbLMRWuE4mSsy+aQUGnW9O2DnKh2R9eCz0mnqut9bHPMQx3l9av0G3y
	zTE99W9ir3byYM96O0Wh6UDc8yXQ8pXjKTN1/CkUtbvlRiu0NdLDvihDYsegc7ZcoDJZzKagxS+
	Mcv1kxBOMbGQ6cjdiyyjP2QS4/i+roJ7wHOQpHzCr6Zy7TFfeyBKb2JU38j27yNRwqoOpOTTM0r
	PAAGltAoJE87xSrIM5+EkL7PjjDs5ccElOmMD/i3sYcHY6XHoj9pf+ipbR44PHDpVbooXNNbEXX
	oi1P0RMozQApR0+iCOvFxRO4vrl+jaPMCzztMF7AbqiE533/OPFzQ5NbCncMn+tHE8i6+BxyvrN
	MWxkHkuQBI4vpA3o6j3YFa0QO5h0QuESfLfj1TbvA6n/6xyT/fQszoP/ahHRvjXXZOeSto7uyff
	K8EJv9pbrC4CpGOUERY6In7PycdX2P9ELcUn0D6A7LO80o70BxP1i9sTyVKDCofiUkhgyfYUXD7
	NHuJwhfnhhF6R7ZQt77e8nyuGO9k56NWssvT8uVF5Chtns48TKAnaAhEqybXwpeU8OM2H/v0l2s
	cWunlI6kuk8PQNXy/XFQyHFFKXhoV9k5WGCnBZ2kvSvEQFMplk5Ig0N/1oJImyhILtXOWmK3jkS
	KwmMowpEno/jnjP8fXHcPd1Jp8SSr
X-Received: by 2002:a05:600c:1d05:b0:4a0:1b14:e283 with SMTP id 5b1f17b1804b1-4b6dc6deb82mr34411495e9.1.1793964779207;
        Fri, 06 Nov 2026 03:32:59 -0800 (PST)
Received: from andreayoga.localdomain ([151.37.255.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76b5d5511sm3825805e9.4.2026.11.06.03.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:32:58 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Tycho Andersen <tycho@kernel.org>,
	Cong Wang <cwang@multikernel.io>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sargun Dhillon <sargun@sargun.me>,
	Hui Peng <benquike@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/4] seccomp: fix user-notification state transitions
Date: Fri,  6 Nov 2026 12:32:49 +0100
Message-ID: <20261106113253.78866-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104103736.71956-1-parri.andrea@gmail.com>
References: <20261104103736.71956-1-parri.andrea@gmail.com>
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

I've reconsidered my earlier plan to send patch 4 on its own, and I'm
dropping this series.  Patches 1-3 go as discussed with Tycho.  For
patch 4, it looks possible for a signal during a RECV whose copy then
fails to make the target return EINTR even with RESTART_BEFORE_RECV
alone.  I don't plan to pursue this further.  If anyone wants to pick it
up, the fix could be limited to RESTART_BEFORE_RECV filters, leaving the
others unchanged.

Thanks,
  Andrea
