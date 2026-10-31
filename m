Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483764;
	b=lP8NujHEzJuu9A74TqnJuCZwfDPsc5iRGFbFDmi0WcDg5YzjkAhteIWAp3aOUfmkGNJK
	 +TrTIc9f3RiMHjqx0k2W1Ll+IGH+FrzikIIRw3ev/611Ao1tX37t0KVUZMkrFDfTo2aOM
	 AnIm9ZIJNEHfUBsjXKRlPMgQTh54TVrimGIi7iQBtELtHRIY71cLr6fl+RenM8tCtInae
	 v+9+tjXc5GDUm8aTXWwv569VvjFhWvGDsvIkUjn1GLZHnabmMrn1hu6mGS6+iIWLvKCjD
	 hB4JIRfQDbP+txh6xWC6Xdo68tcGuRPB6i8asjrNTIeTEpUG7t0dvuRipqgI1NLx6IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mklt+ccNlE2WV11kdzk0vP8ANWjoRC2PThez0W7y1ak=;
	b=SHedHeBOpMe7HTt0xFljBUMqOYEQCqtrR8Mfy807pIKPyJ0UR4+YgSyBMtvukUe6ntxX
	 wBtNnJCWazL9kRJPsc/uOqCx7qvquEt1L8Ucg0dLJvGH7UKKed1QkoldZ/erPPJOmlLwx
	 baLtrg95x18dygpx/7+3iLzDMsxqrpxCf4fRXyACux9Q+opnl3TI11YuPJgTQMl+hxm9T
	 FlAt/9gYtYlEYAMHNuLKGEkvYhZveyFuxXy0Jq2SA6wpmmJl8t6QlT2eHv9KciPw9BmnM
	 56I4eYwo+jiOZYKXyFu3dQKIJg2bBENWO1qovd7C7bfhbj1bzl3VhaT4vyLa7K3c69w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPZfhurw;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27789606A333
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 21:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27789606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPZfhurw
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so776949a12.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793483763; x=1794088563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mklt+ccNlE2WV11kdzk0vP8ANWjoRC2PThez0W7y1ak=;
        b=lPZfhurwqTDUssOmRSzPCEY8QBfUtRjCXCLkLkE1ZpCJ9nrAxCa8HXb1zXVslPduxZ
         lqOpPn7APiRl9P67lFO14hhjB3ss4iis6NmRmqiTKWqLpkL7p4zbPMpghGbOggeCyjt9
         P8qIydJgAVmyCnB2rU/GpVvIGhWVRrGdtzrea7ak8skzKgMwhfIj5PDAQIfrzv9/XdzW
         XTGIezgKt/IkN/BhCDdgpAHHLRQUscB8gf8AvNwdmWwIbbsnRIGslzQ1wZIjiPv0Yen+
         HESlNHw6MkUQkAdwWEPvj34lwwj9qwjtO3y7jFYGlmf/NkG9+w9/vns0wo0yOdG1vq0F
         qGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483763; x=1794088563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mklt+ccNlE2WV11kdzk0vP8ANWjoRC2PThez0W7y1ak=;
        b=LWIE491L2PDwdgfwIvRBnNy90G78TrkvsvQDvszkFjk535tHNgUkQrjpRiHymzRn26
         xSR2aKmNAhxmlzNGMXWfpcUrpuxzKB17lECYEhXH+wHbsthqRDbzJ0TlDc5YzTDMXawp
         gTNgqtppSbU6IaRQzBF9ChuBhwInOl/xkzWGH0fb8P8ZgauHhbwImx8GnrpOrzFTMaz2
         lqEJloIm6rgniHSm8Kp3liyyz2YpdRoXVgM1rnrKbWCCTXmT7IkrXsDcsUdUxdNk84B5
         Ll2hov04kb9cNN4w1jxXnL2AhDnyJFNDLu/wLaCYw9IOUaPhO5kfCRd/+aqWV4U6c5O2
         Wtjw==
X-Gm-Message-State: AFq9FYIP6At+2fnB4381QjjkpFdoSlMMFcDTQdLqIpXKKVCzpuArLdaS
	jVoySOrTQfFql30BDZHeUtUCjWFdCU7jyRxhXB2BpSGEjvPCExyr5IH2cEvTXw==
X-Gm-Gg: AYBFou3yqSO6mrgY59uG1Jqr8la1YCiTuPX7sQE0/pyWYwwxy6zLErEQVobg/DCfvsa
	AZWh1lQCyHB5MwDuE55qzNRRc52K6vTfNB+MhkzMFjkSKtED3KgOrZQ8zx2CM1IFKoeos7ki3O9
	LGA7dEHwe44ltKnI4fcqhjokD6+0S1oQ6smWxsCP/5vi/s+OiGBp3gF7vhr7jPXda44zxvkjlUX
	cPmZ9lzsSmyPrzyJ3t46zz8Zi5Elbbbc9e0oW9YNrBpp4QmOLcECE39vpHFtBDbrQkaIO7cFP6n
	KtGp1kZ3k78b8l/73UKzoznkYEShXAYsFPl8/nJM7ORhtBSiBYXZrreevhzC0Gxf2QoI1VC3XHT
	6eYU1qweZu1DB6UM4MgKqLFIeUMWT7RaobVHwtRiBgy4slOC3Jiae5xr2KImjCT/fI5JU3S4y7f
	xsQOEqpBi8lZbzVtwTvF7s569u7Nth9E2UbBS+tl+VnKULi1/aH96V7G5TeB/TgVjmRvcAvaC/7
	9nSujCM8JYS8+8WgfTwZ55RXOvBcjCt2jZ66+lfrPqAf7jK6kGR7+93uMW9mOx3/7dj8ndX4V/o
	uNYKdlCJc6sdlLZd+XpLZWZGCsRlIQbLosgU3lbTpd/Z8f0OtWOtOs+94HwBqN8/Xqo+ZAYVT2L
	b3N4R2BChfBMzKxqtJ1f8nI9lb7pc6TkzNhrRY8V1vs+pVyAAC1J+S84Svx9ahD96hijCnAymOM
	G7nt8mCM/Q0l5B9oZ9+WUV
X-Received: by 2002:a17:90b:4a4d:b0:3ac:9e5e:d19c with SMTP id 98e67ed59e1d1-3ae897ccc1emr5247729a91.17.1793483763514;
        Sat, 31 Oct 2026 14:56:03 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ecaf5sm8470829a91.16.2026.10.31.14.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:56:03 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 3/9] selftests/bpf: Give the first loop of cond_break5 an end
Date: Sat, 31 Oct 2026 21:55:37 +0000
Message-ID: <20261031215543.682284-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

The main prog of cond_break5 spins until may_goto stops the loop. Then it
calls a subprog and expects that the loop of the subprog makes iterations.
This is true only while each stack frame has a time slice of its own.

Stop the first loop after 100 iterations. The test still makes sure that
may_goto works in the main prog and in a subprog of one prog.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_iterating_callbacks.c      | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 1fbcc5228306..4dd98acc6436 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -553,7 +553,11 @@ int cond_break5(const void *ctx)
 {
 	int cnt1 = zero, cnt2;
 
-	for (;;) {
+	/*
+	 * There is one time slice for all may_goto of the prog. When it's used up a function that
+	 * is called after that makes no iteration. So this loop has an end.
+	 */
+	for (; cnt1 < 100;) {
 		cond_break;
 		cnt1++;
 	}
-- 
2.55.0

