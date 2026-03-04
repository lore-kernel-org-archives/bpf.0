Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648D39EF35
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618060; cv=none; b=j1J0aChrgOIki5h02aovAesYxWP50qDWOzvOKl2ZYQ5I7BnsR3/REIUS7n6xLt+qrKELb0/GCe6iVLMK5xlKUF7j3YhX8d5hTiaTq0q2sBMVNvBU1BgtXMCP4L1Xhrsaflc3tLGsr40FZei4NZBWefgsIuSC6MAd5OE67OnC9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618060; c=relaxed/simple;
	bh=eTa78WHUoVEvfYrnL1ZrbRTeOyVh9VMa4jG2UuaS4SI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWNd/Rz+vPpDC2xmewm109PMRytTZjk5QiFnHoF0CCq9A4hc0tLZ8F81igP/cnZwwQNrbIRZIQIKuBzG2EFcTj2X2FSk9K/s6Y4gbsiQrus9vXf462RqW48Blm69orZnJa5JHw2sFhQjwh9AQsavSlUEW8VY0Je1jhPIfT8Jk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF5A+nkN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF5A+nkN"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439c9eb5d36so310502f8f.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 01:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772618057; x=1773222857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04TQwyjav+Mkle+Jlhsg1YPsdYQI6BcfeeGyJ/oU2Wk=;
        b=ZF5A+nkN4Wcm2GQfTfzasFYPtzOGaM/vnwrBrdwOHvMRjyvx5cL5oO9Sp61/l9DUwV
         G6bB8r8ffMHAPCtV9nj/Hto696l6ZtoYRDeqQ4Ds6wW/8pCPYtHRWCGpBCYg9Vc2zink
         IDgfXFWIz66OyXC7A8OPb0g16zqtBIQ+htDd37Z0zODKNswgoSIHHPvRB9SZvF7YET/U
         k6Adb5pFTLVi5tBPvQd32cRvnPg5sMJB8GydQfx2rU9QqKDMOS/fiCw3eUsEqy/9ewAa
         bbw+QteujQd3wVApvB4P/kF5A8MCaqZuQqk2h+HgvOYcP+0dYnf5NwEg9Erk+zZJhF2f
         540w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772618057; x=1773222857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=04TQwyjav+Mkle+Jlhsg1YPsdYQI6BcfeeGyJ/oU2Wk=;
        b=YA2FIrT3avUwDLXQ9u3yEpXlCQboPoczf9Hoc2zippssAuX0g5y9hTuTN3z+Fo8rgH
         0EtiAevJYTDTHbHgZOFatwWlwT1YS5JwRkgnSBBlA1QZyR+y+fn2C7Ou+wPHu1m1XGov
         aCTTtgF0ivSQ7rQLeCWC/oXkQ0vqJY6U9Il+eulycPXWsQc6vaTonD6KWTS/pfovf/U3
         eA8IwQ01C6cJliTEPtDQjN1p0ZmWlZVE/dsL2hCITqpeXu3ya8IRl4JlCebZqeKi/zsZ
         c+eHLj7LjeMY5dAzUYf/1eQv7L/Ignnp4sPeKjELyoGBQPhtQ5K8udIc2oajxcV6XmTs
         hkjA==
X-Forwarded-Encrypted: i=1; AJvYcCWoN2hQ3ZuI420ln4FXmXhViDtCSHC1ZfCgy9CS96GYnqDC/Q1jrFs5wvDAXzu9EWNB9Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1W2sVf0lqIt7YtGK2f2A8U46iQmgYv78tiZ8H6KUz6r0rA4KS
	/Dlt+3P+QojR88ZWbwHlyp2gZtYN1G8MpYzxWfzX40mW47AIsm/j+xi6
X-Gm-Gg: ATEYQzwE97TfAcGNbnEommS00M0U4cb7bd5vPuiAYLCAgG1C0+zF5yq+H7xTsWduOuU
	+3ObH+9wZFuxFJxxgMtNRQZrKHizVlSTTjZ3D2SB5hVXNWgUZzwz55Ys3R/rX/1kKA8Vt6tZ3KJ
	68jMQpnRvEKoomnWHNtJxIjr5ggCWvrGimfDDshZzE5z99dtyINEHdLFiRN3VbsHE1hQHBB64eV
	bC3DC8a5xMsXhmV0IOATYS5igDrUAKN92hBxl4+7NLuIPKeICZdE2Nd5/XVE8x/fck7Pkp4DUQu
	C2MxlywVCcHnTLvf979t4PpMTP215iaUKibvtkHlDSmM7if8xRlPTiti+kD5ml6gzNY+dIppVsf
	fkWouXOK+9pPypAQHNpsEO7KEJ7S9AXeu+rVuhwZvxTs9SpIfw+OcVY/GcoV3AjMu1TEZ/Qjxyo
	aFovoAZSf2XyjtwAVYtYcdpDVkXI012K6S8MB6mGlCPkz+lCAUstgyIJICpXrE4YjfJ3j3XsFDF
	hI=
X-Received: by 2002:a05:600c:6389:b0:483:75f1:54f with SMTP id 5b1f17b1804b1-485198a10e7mr21116425e9.31.1772618057285;
        Wed, 04 Mar 2026 01:54:17 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188923c2sm40345475e9.14.2026.03.04.01.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:54:17 -0800 (PST)
Date: Wed, 4 Mar 2026 09:54:15 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260304095415.4d5f2528@pumpkin>
In-Reply-To: <20260304090249.GN606826@noisy.programming.kicks-ass.net>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
	<20260304074650.58165-2-laoar.shao@gmail.com>
	<20260304090249.GN606826@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Mar 2026 10:02:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Mar 04, 2026 at 03:46:49PM +0800, Yafang Shao wrote:
> > Introduce mutex_lock_nospin(), a helper that disables optimistic spinning
> > on the owner for specific heavy locks. This prevents long spinning times
> > that can lead to latency spikes for other tasks on the same runqueue.  
> 
> This makes no sense; spinning stops on need_resched().
> 

That might still be an issue if a high priority process is spinning.
But a %sys spike doesn't imply a latency spike.

Is this using the osq_lock.c code?
That will have problems on overprovisioned VMs, it tries to find out
whether the hypervisor has switched out - but ISTR that is flawed.

In reality a spin lock shouldn't be held for long enough to cause
any kind latency issue.
So something in the code that reads the list of filter functions
needs to be done differently so that the lock isn't held for as long.

	David
