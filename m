Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D171A6807;
	Thu,  8 Oct 2026 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458213; cv=none; b=gPjjEA5XvaYi8Bcuhl6d8a+ORMGAeji5KbCZxgN/AEini3J0C0PxsJzUPH5FhDKsFOqQPj5C3ZnmTHtPumBclAJ4BKvYND16Aj2b5d+tbmdcU3BrV4UUPtNVyE3qP/W/+69Jt5QFGkRv7jIY6z5yIGGAkDqnt7Z5LWhtLnkH+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458213; c=relaxed/simple;
	bh=sTHAdpnW9bVA8od2XCMArovshAesAKt4NgA4MUbjdqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HM3ImocgiuXav6YUZHXo+iFQoVhbIrtEfUlWFxPobFJ+wVHvLOctPvGafQn4k0JNxYe4m6ZwIlt2NmqG3eFnT0wP+DJsvQ6BkkT8X0owqaZw85gSpuiOWqpBI9BZPax9kQu90L/cnPR+hUBLSiWNogZ/ehdiEq1n61so7MAuVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xPWYq0rV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b8rPD/dq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xPWYq0rV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8rPD/dq"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791458210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTHAdpnW9bVA8od2XCMArovshAesAKt4NgA4MUbjdqA=;
	b=xPWYq0rVjTpoyNlWPfKh+d9hPsdIvN+LsfYw+5u69a/PvpWbaup7RMb47deAbugOxmx6wQ
	oHBmJr+JzFBBGtBxfBE0CM4Vnf6pVg0Yl+vJOBpXWDhit+Obd1TG8fMoEQgIGD47iS+B0S
	aAynjyOvohwlqP4uugw4Rlv5AkidtePN0qpj4DViuxFPsj1FJhMlf6ytlOOVs4jBpmgv3C
	WRHTzBCDAKF9CE2NekHw2UggKU/jRbKr3JSZ03gPvyUogHROOf50enu1x4CaFOPL9ay2dz
	PwtZayI+5OY4HY/FcCU06SgMjYLaEoCNbi5yLSZfojJuGoSXsgcdlL2NcyY6gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791458210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTHAdpnW9bVA8od2XCMArovshAesAKt4NgA4MUbjdqA=;
	b=b8rPD/dqjYBFHkoJ5YL1gnxMCBX93lw1zCLksM1NL5Z5Jead79v+D/3QzDH2SRwaP7y8C1
	n5UavJb3STCegDBw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Wen Yang
 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 09/15] tools/rv: Copy stripped bpf_atomic.h from
 libarena
In-Reply-To: <4F009BB7-58C2-4AB1-8FEF-61FA4B5281A2@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-10-gmonaco@redhat.com> <87ld89wtrx.fsf@yellow.woof>
 <4F009BB7-58C2-4AB1-8FEF-61FA4B5281A2@redhat.com>
Date: Thu, 08 Oct 2026 13:16:49 +0200
Message-ID: <87fqygl9we.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Mmh, I'm not too familiar with them, but they wouldn't be drop-in
> replacements as far as I understand. I'd need to use C11 atomic types
> and that would diverge further from the kernel implementation.

I am thinking we should migrate to BPF entirely. Keeping both in-kernel
and BPF will be a bit painful.

Nam
