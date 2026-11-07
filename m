Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017719;
	b=1CLsCvxZOSlUtW1qEZ6aQOzZtnXbJhVcFYJ8/QfMGaVwgF9Twdkfrhbo4kJvdchop/zO
	 Zgn0T5AgiN8WoI9IYlDBOpc59Lx2gvu1YF4ULrlnbZZkFvsoDzFy2trwBAOPJ9mYH4ghh
	 8obwM7uAs9Zi9UwKc5ZSzPjt0U+dUT9SgkTxdLDJwy3Gpsgp6g8AXvjyo1ewHuIe9EYg/
	 3nUtGwSMybJH2mQJwTvUAuF8dDzw6/kNFiG0QdZeM8SCAsoXwDVNxFifOmTaSEs2qyc5O
	 1OB9Q8prbdcgog9sXu7e7+RPNMkOBwn102bduEfu+tGmfWa8OuyRQq73NVIs2zc+Tjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vkNpnDXn7v7FcqEceWtawbzUhjqzoj0bXsK40kYeEvM=;
	b=LIXs6Lu2y1Iht62tpJDkgzBjzbT2oC6fpdYsfWX+ZZh8Odryq2DkdPK7gkI5X73JFSUi
	 8xc4Jxg2wumdxbFJEflkqF3Dn6l0FbLd3yql59qvwuaYtxCMO5++zkb1g8Pj5uBFCLJqw
	 l5TZvd1bcp95yww6Ye4G9Y/lHsr2jDcCNSmM51ffTT6A3OU10L+8rY/KJlOCKXn/6GOJD
	 TPDedNHOKLB6nv6sZc1Km06Bnw4nw6ctqwu5JKsIVqRq5r5AC9n0JDvC3EPuDYJdIXLtn
	 lMSQy102yHmgACe7KJh1cYkelmDAdzsJG2h3uSa48izA0DhOwuhWsShBmHZ1ov+23hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+tq5SXK;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC6606A337
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 02:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80EC6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+tq5SXK
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso7835345e9.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 18:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017718; x=1794622518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vkNpnDXn7v7FcqEceWtawbzUhjqzoj0bXsK40kYeEvM=;
        b=w+tq5SXKnfdvsqGHzcQK4MV2Idg8X9GCuyFRHpjBKAZaJMv0TTG/wMQnL2CNt7IWr7
         l1+vz+bTwouMfbb5xf+u0jWyMI8JmPq0DFEL04DVY6IQeiD3mqGQzHiBu7gW30siKxzA
         n5W0fwMTRfKfKJ31/BDjBKKoFZrSFN+IZVlQyatztlEtJKnVU4D4nqTIRLj/0D4Y57WU
         UBUqj4Vkgw8wK4vozw1uEhLZP5fY63ZxjZDQA369X8lGLcjrT6/7VyGTltVoyAd5BLMP
         biUWJ1x4O4BjR8Yx6UCc1v6AunT1YiAc/3oiysr6MBZ/ALuHlT/hhnAsL8lrrhysU1pn
         63eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017718; x=1794622518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vkNpnDXn7v7FcqEceWtawbzUhjqzoj0bXsK40kYeEvM=;
        b=dD7d2iQl9l+yLFvEN9Dl9aYwasA2eEx9ed+kLIMEjrb0kLYyB8rZhTRiUVBxVwb/Zw
         9sRfGC45YSlKRefseiP3g861zvjPCoSObCJ9i2q4vw3HYjlcArBiFMyTarp9TJgIv94j
         a1JJR7ZbgFwaaL5wzIOCXTH2C8AARMijnrko/Beo1BTmKENVuu2Tz34C1mXScjPB/ONY
         QmD7wS+TAJSXqW8Umzkureq/J6gW6V585VOVJiR3uhy3gl9YrwdltkCUWC6iMJS6I9aA
         pLCSbT91LF1PCvLxH9QwsncrmY1Jrc2/XeYMv/kZMSNxCq3seBBmJ54WNGXb9GN78YBe
         XATg==
X-Forwarded-Encrypted: i=1; AKwUvBxQNprS5Fbjz7h49cFMIT6j+PfVbSMsM9oJVgb+gNrVKwCtYmOE9PlBTqHKbSIl8KJD4go=@vger.kernel.org
X-Gm-Message-State: APuU4Z+D9TMhpNLplbWsoJOd73RhtXeFkS03DUhlfxZYo+DM87f6k2x8
	VfiX3jFsOukbLvDu3jGDoUC1kPehSxRXNW0Fc30buLqGWyJoTNDHJPCZ
X-Gm-Gg: AYBFou1jPSWjATWp/Kv79nCuCOsSu5CroZSES8Skn7HvzoiZV/H8bSjBPbEE3EgoX/V
	ZfgTCZnTQS4nvtGqWAG7nCaAUtjvktJkazOVDHI9yIVyJ1IB550rFwoVEmdCEKrwsuO4qFGrEJK
	Oo+VLPP4iBdMl+mHo9Oavx6kD/wLV9kBoQ1xHksSPMM8HsIKFpFYmB34w2YCa/26Mo5jJ2nEdfI
	SG/VkGVp1rCF+T/Gku4CeasXWHjpJq0HzDbKI0MRM+/K47ctagTX9zRWm6yE85B/3tb6f4UiHkQ
	2zx9GHOJsQW0KcXP6clEHd0HmTA8HUx3A4ki5RSPyQxDDRGsS8WwWffsRjkv+gEFqIHSZX56z4B
	JorhM2zvjzEjemLU9VlkT5EcEtjqjOGnHAI00qOFZmmUlIjpICi8y71PQjjoEK5QwN3+AeatAe+
	NQmgWO5ZdDLTBnhtZg4cYhq+fBYZ27VieVlEHSf8rv4Eaqu7kQhZMOb1jvQzjP9Gu6i/cMsiCpj
	nBowbltYLC2KYF8CSX1e26zhLEFS6bUuNB0dvzM63RQ5nyfvZed3/geQLUI3Jkoxq29B7h3mZwr
	rhmlcpXXDTLquflqdjsWS8Y/72wBMUzzBGZQOcar/aIRn5+ATFWeXcqdDHWpWnHdwlgkN4j6yWQ
	7Bg==
X-Received: by 2002:a05:600c:3495:b0:4a2:150f:1610 with SMTP id 5b1f17b1804b1-4b6dfba86f0mr71877255e9.23.1794017717990;
        Fri, 06 Nov 2026 18:15:17 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5f11sm6367449f8f.49.2026.11.06.18.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:15:17 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: peterz@infradead.org,
	tj@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] softirq: Treat an interrupted idle task as idle in tick_irq_exit()
Date: Sat,  7 Nov 2026 02:15:08 +0000
Message-ID: <20261107021509.968928-3-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d8c4fb5ce3e465c9c9e562c851d586ef8e5cc43d85d61998f63f2c48d431778e@mail.kernel.org>
References: <20261106094343.174905-1-radu.m.toader@gmail.com> <20261106094343.174905-3-radu.m.toader@gmail.com> <d8c4fb5ce3e465c9c9e562c851d586ef8e5cc43d85d61998f63f2c48d431778e@mail.kernel.org>
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

Both points are right and both are changelog-only, as the report says.
Fixed in v2.

On the first: PF_IDLE is indeed set by cpu_startup_entry() and not by
init_idle(), which I checked - init_idle() sets PF_KTHREAD and
PF_NO_SETAFFINITY only. So the gates overlap rather than one containing
the other, and "strictly wider" is wrong. v2 drops it, names the state
that is no longer covered, and says why nothing is lost there:
TS_FLAG_INIDLE is only set inside do_idle(), so tick_nohz_irq_exit() had
nothing to do before cpu_startup_entry(), and nohz_full CPUs stay
covered by tick_nohz_full_cpu(cpu).

On the second: injected idle is now named among the newly covered
states, with play_idle_precise() cited and the reach beyond sched_ext
spelled out - intel_powerclamp and cpuidle_cooling via
drivers/powercap/idle_inject.c. Peter Zijlstra raised the same point and
has a reply of his own in the thread; the gap in the changelog was real
and is closed.

No code change in v2.

Disclosure: this reply was written by Claude Opus 5 (Claude Code) and
sent on my behalf, in the same session as the patch; the patch changelog
carries the same note.
