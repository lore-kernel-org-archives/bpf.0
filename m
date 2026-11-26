Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662227;
	b=k9eRi6i2VeGPR7F4eIhYMFmxP0cdul4AL878HSIRffBLDBd1czMPLU3CBSpLvO90iei4
	 3QU8cjWHQsHE8UgDr0Pi33qITgycbvIUXRGEVBwFBj3ZG2hpNDtSGuBh686pgKI2rQbLo
	 lBat0oZVy78XtdYVvvYonIo7/D0PJj70ARetuT3BC3oMl7R7ak4wJavW2iJLbeS8tkqJB
	 wiZHWqOvLbLN1B81WuNnsbIiYO2OcjYYTeeHo2eSXGf7xUfWoLnl6xirvlb0TflxNqlSn
	 8Te5dghrefUvirvT9w8z8NbFKgDUEPwTe5XSBcQKWFhaxjo8zmONav6RCxORqTRkNcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BypWm+ajXgg6TQzdUJ97ZZvPvWnvS+eQsbc0PMHjKdY=;
	b=RisknC/C8RWsr59MRxnaJimyYq3CKvRIrKjQcOyPx5Rcoprqjqef81Ql5ZaSQbzvc0RA
	 1tT+A7nvMsVeA/EBWATCYuo6J4qqXwiBYbcvyqiD28zrHqRMX/BfL65P6T82DGfVUVYpw
	 1kWJvUKHjnJBQd/c82IqXljNW9UJcfeOZmKy2WR5qppaLFq4LXSY5rtqmeKAO8dCkVSU/
	 q2n/FgYiO3daptxH4Spw87rIaNGrgnEQFsSR9CsT3yuFzTSmf91fQkByv4g1zHbhMlw1P
	 6i5z6PZS5DInTdN+clIgOJ0P38eYY59KlbFhSI39WDrMpeGnZGpdvaM5Ay0Qzgd6A+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kS/YoYo2";
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A7606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 599A7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kS/YoYo2
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b3e85baf7cso3941779a91.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 19:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795662227; x=1796267027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BypWm+ajXgg6TQzdUJ97ZZvPvWnvS+eQsbc0PMHjKdY=;
        b=kS/YoYo2wZAKkkC80J624Yht0r4DLKGN4VxpDlQXEmzs0R+6/dXOchIyMVZ+edoN4L
         uVcUA9c4TCcIsOdmRE+tUozTMLlVLxXJ/6j58krdhlvLW+2HcQxK7KxLGlejSr3Nmqga
         +zClon/y/XoKQvO7OPoarGoCu+geJU+1GyuhBj6zRPNlKFvZKrhyn0xePK6M9ki4gCU8
         vTC/bjRODt6Kivv88nn1ZzG/Rx8iUGUB6jwLFOE1RrGWF9GbA+o8NFgnxjVe+sAYsBae
         um/KsD7V8IK9Q37HloNv6ROL9bIkb9KD3uTi+vXDhjYY91bARDh6W8wQF5mQdssvT3Ee
         mJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795662227; x=1796267027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BypWm+ajXgg6TQzdUJ97ZZvPvWnvS+eQsbc0PMHjKdY=;
        b=cXIdigoRZ9cYLUqWY4Nd76E9G4Laeb/wMrWwpCgsJZrqlMwJWso4YkMb3yJuzPWeRG
         8zFJC9Q+OGp5jWReKvYrYt/DK1/X88W+GXqwDOb7uFAvBV9bX1yja+K1NNjDb36D/qXA
         7nfYdeDRxre/bV91umgyXmq88t4ECZiibInyARnaNKRLdZzc0diwLKIU7umzpA8k1ZYA
         RmtKw/bbiKwfAaLZboL1EICNSxTaAgZkdq2JQG9vhyK/bwHU381MkrhZNAQ7JQ9N5Hgo
         mUKBRh89b9LUjG3DNdvr4m2OIjsvO+o7mQZ1FcAf2JCzC4yFYfnnUm56SbIErDFmq8i5
         G0HQ==
X-Gm-Message-State: APuU4Z8ohq55wRYaLl0NQ82xI1nkU25N1O44iC9me/1w5undQ0Eiixwg
	6/IX9v1DAPWn7nAJnuIpsBWhXu+YiGif2QvpitNdOcxuvHqDfWUSBtnH9HC3kA==
X-Gm-Gg: AZFdTZf1Wx4Cr+xnw3fqJdzu94DBN1S0JgXyMQh2u11aSKQ7qWOd3Ri2HaDjR5J7F7B
	jx2WQNtLVY3+va1GBjvW7uhY65Ga6sI5UgoJhy+hWdHXDbks29csxmHmRWtcgth5hThS2swu3We
	a4cf3NFch/z5+yETiafURXUhnCd57xBxVCiVvoJzM+Bysle4Absbaj82nsRWLVBDFhv25ENbMTM
	oG01/Qj1hNFyWBARfYIZ7R4aNy+f66ePHpLOrmDtuKEZhTsoEznsydm7MIf3kbvskVzr8Uys6OK
	gDKgtSY8LowTRO5WRVGOo+iCM+YnRI2EaUvVZbJylXfUSA4/fi34orBHaR8uZaW9WV1XtwTPvhm
	npQgxN11wwyfrHVuxiNK5c7ZWtwUN0UaUlQb0kn3KVMNw5c2UJsB+Stpj/sJa0C4XrFjhyniEwM
	w/ZZYE4/oYQgP8rhwpKHE5WTYqa/MCpJsm8ZBr+G1dPOU1nP0eX+GPAANJTtQ1bDna/b7OtET1W
	twi1m+SyjYRQDd2+NgC7digshzRJQNx1wQJ7of8xXBQfDK6UqIQZub/9RBGqugE8wJ27ELd4sPk
	oP9/mivDo6IngAHk7bYNu6KJpYwv/JICcp8JUv3QgqhZ4om1GxIKBU0EnM2/kfcwq94y0nUrrmK
	rvPPpQLDTfr7ihv4kR1yNBasVowF8YMIVKoolA/Kq0dLiRjZ5g77MlUiYxlrIEiagA9WxRnfdyS
	+anxQD4KsL2fn3Sf2IWDY=
X-Received: by 2002:a17:90b:2e49:b0:3b4:192c:a4d8 with SMTP id 98e67ed59e1d1-3b41c92d37amr16972119a91.32.1795662226400;
        Wed, 25 Nov 2026 19:03:46 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b704cfesm11424775a91.1.2026.11.25.19.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:03:46 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/4] bpf: Fixes for calls, struct_ops and bpf_throw()
Date: Thu, 26 Nov 2026 03:03:38 +0000
Message-ID: <20261126030342.4013902-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

These patches fix bugs in the verifier. Each refuses what was allowed:

  patch  refused now
  -----  ------------------------------------------------------------------
  1      a stack that is over the limit with outgoing stack arguments
  2      recursion without CAP_PERFMON
  3      a reference that the caller of a struct_ops prog does not take
  4      fexit and fsession on a subprog that throws

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (4):
  bpf: Count outgoing stack arguments in the combined stack size
  bpf: Require CAP_PERFMON for recursion
  bpf: Fix reference leaks in struct_ops programs
  bpf: Allow only fentry on a subprog that can throw

 Documentation/bpf/verifier.rst                |  2 +-
 include/linux/bpf.h                           |  1 +
 include/linux/bpf_verifier.h                  |  1 +
 kernel/bpf/fixups.c                           |  8 ++++
 kernel/bpf/verifier.c                         | 48 ++++++++++++++++---
 .../selftests/bpf/prog_tests/exceptions.c     | 12 ++---
 .../selftests/bpf/progs/verifier_barrier.c    | 11 ++---
 .../bpf/progs/verifier_private_stack.c        |  2 +-
 8 files changed, 63 insertions(+), 22 deletions(-)


base-commit: 486b5ce7184f7449ef2fe1e951455b0b8a114060
-- 
2.55.0

